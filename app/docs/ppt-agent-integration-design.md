# PPTAgent 优秀设计思路整合方案

> 基于对 PPTAgent V1 (pptagent/) 和 V2 (DeepPresenter/) 的完整源码分析，
> 提炼可借鉴的设计思路，结合 NovaCloudEdu 现有架构落地。

## 一、差距分析

### 当前 NovaCloudEdu PPT 系统

| 模块 | 现状 | 薄弱点 |
|------|------|--------|
| **模板解析** | `template_parser.py` — 正则识别占位文字 (`_FILLABLE_KW`) | 仅靠文本关键词判断，无法理解视觉语义 |
| **角色分类** | `_classify_role()` — 基于位置和文本关键词 | 硬编码规则，无法处理非标准模板 |
| **槽位语义** | `_guess_slot_role()` — 文本长度 ≤8→label, >8→title | 粗粒度，无法区分 subtitle/quote/caption 等 |
| **版式选择** | 按大纲顺序固定分配 template_slide_index | 不考虑内容与版式的适配度 |
| **内容验证** | 无 | AI 生成内容可能溢出或不足 |
| **质量审查** | 全部生成后批量视觉评估 | 无法在生成过程中及时发现问题 |

### PPTAgent 对标优势

| PPTAgent 能力 | 对应模块 | NovaCloudEdu 可借鉴点 |
|--------------|----------|----------------------|
| Vision Model 版式分析 | `SlideInducter.layout_split()` | 用视觉模型理解模板页布局语义 |
| Content Schema 提取 | `schema_extractor.yaml` | 从模板页提取元素结构化描述 |
| Layout Selection | `layout_selector.yaml` | 根据内容智能选择最佳版式 |
| Content Validation | `PPTAgent._validate_content()` | 按 shape 尺寸校验内容长度 |
| Per-Slide Inspection | `inspect_slide` tool | 逐页渲染审查，即时修复 |
| Code-as-Action | `apis.py` + `CodeExecutor` | 程序化幻灯片编辑（可选） |

---

## 二、整合方案设计

### 优化一：Vision-based 模板智能分析

**借鉴来源**: PPTAgent V1 `SlideInducter` + `schema_extractor.yaml`

**核心思路**: 在 ppt-service 的 `template_parser.py` 中增加 Vision Model 分析步骤。
将每页模板幻灯片渲染为图片，调用视觉模型理解其布局语义，输出比纯文本正则更丰富的 Schema。

**实现方案**:

```
现有流程: parse_template() → 正则提取 slots → 角色分类
增强流程: parse_template() → 正则提取 slots → 渲染为图片 → Vision Model 分析 → 融合增强 Schema
```

新增 `template_analyzer.py`:
- `analyze_slide_visual(slide_image_path)` — 调用 Vision Model 分析单页视觉布局
- 输出: layout_type (图文混排/纯文本/数据展示等)、元素语义描述、建议内容类型
- 融合到现有 `SlideInfo` 中新增 `visual_analysis` 字段

**改动范围**: ppt-service (Python 层)
- 新增 `template_analyzer.py`
- 修改 `template_parser.py` — 可选启用 vision 分析
- 修改 `schemas.py` — 扩展 `SlideInfo` 模型

---

### 优化二：内容版式智能选择（Layout Selection）

**借鉴来源**: PPTAgent V1 `layout_selector.yaml` Agent

**核心思路**: 当模板有多种 content 页版式时（如"图文混排"、"纯列表"、"两栏对比"），
根据每页大纲内容的特点，智能选择最合适的版式，而非按顺序固定分配。

**实现方案**:

在 `PptAgentOrchestrator` 中新增 `LayoutSelectorAgent`:
```java
public interface LayoutSelectorAgent {
    @SystemMessage("你是版式选择专家，根据幻灯片内容和可用版式，选择最佳匹配...")
    String selectLayout(@UserMessage String input);
}
```

在 `generateSlideWithAgent()` 之前，调用 LayoutSelectorAgent 为该页选择 `template_slide_index`。

**改动范围**: Java 后端
- `PptAgentInterfaces.java` — 新增 `LayoutSelectorAgent`
- `PptAgentOrchestrator.java` — 生成前增加版式选择步骤
- `PptGenerationService.java` — 传递版式候选列表

---

### 优化三：内容长度验证层（Content Validation）

**借鉴来源**: PPTAgent V1 `PPTAgent._validate_content()` + `_rewrite_element()`

**核心思路**: AI 生成的填充内容可能与模板 shape 尺寸不匹配（文字溢出或过少）。
增加一层自动化校验和重写机制。

**实现方案**:

在 ppt-service 中新增 `content_validator.py`:
```python
def validate_fills(fills, slide_info):
    """校验每个 fill 的文本长度是否匹配对应 shape 尺寸。"""
    issues = []
    for fill in fills:
        slot = find_slot(slide_info, fill.shape_id)
        max_chars = estimate_max_chars(slot.width, slot.height, font_size)
        actual_chars = len(fill.text or '') + sum(len(i) for i in (fill.items or []))
        if actual_chars > max_chars * 1.2:
            issues.append({"shape_id": fill.shape_id, "issue": "overflow", ...})
        elif actual_chars < max_chars * 0.2:
            issues.append({"shape_id": fill.shape_id, "issue": "too_short", ...})
    return issues
```

Java 端在收到 ContentAgent 结果后，调用 ppt-service 的验证接口。
如果发现问题，将问题反馈给 ContentAgent 进行修正（类似 PPTAgent 的 retry 机制）。

**改动范围**:
- ppt-service: 新增 `content_validator.py` + 新 API 端点
- Java 后端: `PptAgentOrchestrator` 增加验证+重试逻辑

---

### 优化四：逐页即时视觉审查

**借鉴来源**: PPTAgent V2 `inspect_slide` + `reflect.py`

**核心思路**: 不等所有页面生成完毕再批量评估，而是每页生成后立即：
1. 渲染为 PNG 预览图
2. 用 Vision Model 快速审查该页质量
3. 发现严重问题（溢出/空白/残留）立即重新生成

**实现方案**:

在 `PptAgentOrchestrator.generateSlideWithAgent()` 流程中，每页生成后：
```
ContentAgent 生成 → 填充 → 渲染预览 PNG → Vision Model 快速审查
                                              ↓
                                   问题 → 带反馈重新生成（最多1次）
                                   通过 → 继续下一页
```

这将现有的"生成全部 → 批量评估 → 批量修复"优化为"逐页生成 → 即时审查 → 即时修复"。

**改动范围**:
- `PptAgentOrchestrator.java` — 每页生成后增加即时审查
- `PptServiceClient.java` — 新增单页渲染 API（已有 `renderSingleSlide`）
- `LangchainChatService.java` — 单张图片快速审查

---

## 三、实施优先级与完成状态

| 优先级 | 优化项 | 预期收益 | 实施复杂度 | 状态 |
|--------|--------|----------|-----------|------|
| **P0** | 优化三：内容长度验证 | 消除最常见的溢出/空白问题 | 低（纯工具函数） | ✅ 已完成 |
| **P0** | 优化二：版式智能选择 | 显著提升内容-版式匹配度 | 中（新增1个Agent） | ✅ 已完成 |
| **P1** | 优化四：逐页即时审查 | 大幅减少低质量页面到达最终输出 | 中（改编排逻辑） | ✅ 已完成 |
| **P2** | 优化一：Vision 模板分析 | 全面提升模板理解能力 | 高（需接入视觉模型到 ppt-service） | ✅ 已完成 |

### 已完成的实现清单

#### 优化三：内容长度验证层（P0 ✅）

**新增文件：**
- `ppt-service/src/content_validator.py` — 内容长度验证器
  - `estimate_max_chars()` — 根据 shape 物理尺寸(EMU)和字号估算最大字符数
  - `validate_slide_fills()` — 校验填充内容：溢出/空洞/缺失检测
  - `format_validation_feedback()` — 生成可直接反馈给 AI 的文本

**修改文件：**
- `ppt-service/src/server.py` — 新增 `POST /api/validate-slide` API 端点
- `backend/.../PptServiceClient.java` — 新增 `validateSlide()` 方法 + `ContentValidationResult` record
- `backend/.../PptAgentOrchestrator.java` — `generateSlideWithAgent()` 集成校验+重试逻辑

**工作流程：**
```
ContentAgent 生成 JSON → 调用 ppt-service /api/validate-slide
                              ↓
                   通过 → 继续
                   不通过 → 将 feedbackText 附加到 prompt → ContentAgent 重新生成
```

#### 优化二：版式智能选择（P0 ✅）

**修改文件：**
- `backend/.../PptAgentInterfaces.java` — 新增 `LayoutSelectorAgent` 接口
- `backend/.../PptAgentOrchestrator.java` — 新增 `buildLayoutSelectorAgent()` + 配置项

**新增配置项：**
- `ppt.agent.layout-selector-model` — 版式选择模型（默认 dashscope/qwen-max）
- `ppt.agent.enable-content-validation` — 内容校验开关（默认 true）
- `ppt.agent.enable-layout-selection` — 版式选择开关（默认 true）

**端到端调用链更新：**
- `PptGenerationService` → `generateWithReflection(templateUrl)` → `generateSlidesParallel(templateUrl)` → `generateSlideWithAgent(templateUrl)` → `pptServiceClient.validateSlide()`

#### 优化四：逐页即时视觉审查（P1 ✅）

借鉴 PPTAgent V2 (DeepPresenter) 的 `inspect_slide` 设计：每页生成后立即渲染预览图，用视觉模型快速审查，发现严重问题立即修复，而非等全部生成后才批量评估。

**修改文件：**
- `backend/.../PptAgentOrchestrator.java`
  - 新增 `inspectAndRepairSlide()` — 渲染预览→视觉模型审查→即时修复
  - 新增 `ppt.agent.enable-per-slide-inspection` 配置开关
  - 集成到并发流水线：Content→Validation→Design→**Inspection**→Done

**审查策略（三级严重度）：**
- `none` → 通过，继续
- `minor` → 记录但不修复（避免额外延迟）
- `major` → 立即修复重生：带视觉反馈的 ContentAgent 重新生成 + 重新渲染

**工作流程：**
```
DesignAgent 完成 → pptServiceClient.generateSlidePreview() → 渲染预览图
                                  ↓
         chatWithImages(视觉模型, 预览图) → 快速质量审查
                                  ↓
              pass → 继续 | major → ContentAgent 带反馈修复 → 重新渲染
```

#### 优化一：Vision-based 模板智能分析（P2 ✅）

借鉴 PPTAgent V1 `SlideInducter` 的模板归纳设计：通过结构化分析+视觉理解，为每页模板生成丰富的语义描述。

**新增文件：**
- `ppt-service/src/template_vision_analyzer.py` — 模板视觉分析器
  - `SlideVisionAnalysis` — 单页分析结果（版式分类/内容类型/空间分布/推荐场景）
  - `TemplateVisionProfile` — 模板整体画像（版式聚类/整体风格）
  - `analyze_slide_with_structure()` — 结构化分析 fallback
  - `build_template_vision_profile()` — 构建完整画像
  - `format_vision_profile_for_agent()` — 格式化为 Agent 可读文本

**修改文件：**
- `ppt-service/src/server.py` — 新增 `POST /api/analyze-template` API 端点
- `backend/.../PptServiceClient.java` — 新增 `analyzeTemplate()` + `TemplateVisionAnalysisResult` record

---

## 四、架构图（增强后）

```
用户输入主题/要求
       │
       ▼
┌─ PlannerAgent ─────────────────────────────────┐
│  联网搜索 → 收集资料 → 制定大纲                    │
│  (现有能力，无需改动)                              │
└────────────────────┬───────────────────────────┘
                     │ 大纲 sections[]
                     ▼
┌─ [新增] LayoutSelectorAgent ───────────────────┐
│  分析每页内容特点 → 从多种 content 版式中选择最佳   │
│  输入: section 内容 + 可用版式列表                  │
│  输出: 最佳 template_slide_index                  │
└────────────────────┬───────────────────────────┘
                     │ 分配版式后的 sections
                     ▼
┌─ 并发生成 (现有 Stage 2) ──────────────────────┐
│  ContentAgent × N 页并发                        │
│      │                                          │
│      ▼                                          │
│  [新增] ContentValidator 校验内容长度              │
│      │ 不通过 → 带反馈重新生成（1次）              │
│      ▼                                          │
│  渲染单页预览 PNG                                 │
│      │                                          │
│      ▼                                          │
│  [新增] 即时视觉审查（Vision Model 快速检查）       │
│      │ 不通过 → 带视觉反馈重新生成（1次）           │
│      ▼                                          │
│  DesignAgent 配图优化                             │
└────────────────────┬───────────────────────────┘
                     │
                     ▼
┌─ EvaluatorAgent (现有 Stage 3) ────────────────┐
│  多模态视觉批量评估（已大幅减少低质量页面）         │
│  反思修复循环（现有能力）                          │
└────────────────────┬───────────────────────────┘
                     │
                     ▼
                 最终 PPTX
```
