# AI PPT 生成功能 — 全链路分析与 Flutter 端实现方案

## 目录

- [第一部分：Web 端现有实现分析](#第一部分web-端现有实现分析)
- [第二部分：Flutter 端实现方案](#第二部分flutter-端实现方案)

---

# 第一部分：Web 端现有实现分析

## 1. 系统架构总览

```
┌─────────────┐     SSE/REST      ┌──────────────────┐    HTTP     ┌──────────────────┐
│  Web 前端    │ ◀──────────────▶ │  Java 后端        │ ─────────▶ │  Python PPT 服务  │
│  React+TS   │                   │  Spring Boot     │            │  FastAPI+python- │
│             │                   │  SSE Emitter     │            │  pptx+OSS       │
└─────────────┘                   └──────────────────┘            └──────────────────┘
                                         │                               │
                                         │ LangChain                     │ OSS
                                         ▼                               ▼
                                  ┌──────────────┐              ┌──────────────┐
                                  │  AI 大模型    │              │  阿里云 OSS   │
                                  │  (通义千问)   │              │  文件存储     │
                                  └──────────────┘              └──────────────┘
```

### 三层服务职责

| 层级 | 技术栈 | 职责 |
|------|--------|------|
| **Web 前端** | React + TypeScript + TailwindCSS | 对话式 UI、SSE 流式交互、模板选择、大纲预览/编辑、幻灯片缩略图实时预览 |
| **Java 后端** | Spring Boot + SSE Emitter + LangChain | 会话管理、意图识别、大纲生成（AI）、逐页内容填充（AI）、编排调度 Python 服务 |
| **Python PPT 服务** | FastAPI + python-pptx + LibreOffice + OSS | 模板解析、幻灯片克隆+填充、渲染 PNG 预览图、生成最终 PPTX、上传 OSS |

---

## 2. 完整用户流程（Web 端）

### 2.1 页面布局

```
┌─────────────────────────────────────────────────────────────┐
│ [←返回]   PPT 生成助手                                       │
├──────────┬─────────────────────────────┬────────────────────┤
│ 会话侧栏  │      中间对话区              │  PPT 缩略图面板   │
│          │                             │  (生成时出现)      │
│ PPT 会话  │  [AI/用户消息气泡]           │                   │
│ --------  │  [大纲卡片(确认/修改)]       │  [Slide 1 预览]   │
│ 生成历史  │  [进度卡片(x/y页)]           │  [Slide 2 预览]   │
│ session1  │  [下载卡片(文件链接)]        │  [Slide 3 ...]    │
│ session2  │                             │                   │
│ [+新建]   │                             │                   │
│          ├─────────────────────────────┤                    │
│          │  [🎤语音] [输入框] [发送/停止] │                    │
└──────────┴─────────────────────────────┴────────────────────┘
```

### 2.2 多步骤交互流程

```
用户输入主题
    │
    ▼
[Step 0] detect_intent ─── AI 意图识别 ─── 是否要做 PPT？
    │                                         │
    │ (是)                                    │ (否)
    ▼                                         ▼
创建 Session                              普通对话回复
    │
    ▼
[Step 4] select_template ─── 弹出模板选择 Modal
    │                         用户选择系统模板 or 自定义 URL
    ▼
Python 解析模板 → 返回结构 JSON + 幻灯片渲染预览图
    │
    ▼
[Step 1] generate_outline ─── AI 流式生成 Markdown 大纲
    │                          （大纲感知模板结构：页面类型、槽位数量）
    ▼
展示大纲卡片 ─── 用户可以：
    │              ├─ [确认大纲] → Step 3
    │              └─ [修改大纲] → Step 2 → 重新生成 → 回到这里
    ▼
[Step 3] confirm_outline ─── 确认后自动进入 Step 5
    │
    ▼
[Step 5] generate_ppt ─── AI 逐页生成填充 JSON
    │   循环每页：
    │   ├─ AI 生成 {template_slide_index, fills: [{shape_id, text}]}
    │   ├─ Python 克隆+填充+渲染 PNG 预览图
    │   ├─ SSE 推送 slide_progress 事件（预览图 URL）
    │   └─ 前端实时在缩略图面板显示
    │
    │   全部生成完毕后自动组装：
    │   ├─ Python 生成最终 PPTX → 上传 OSS
    │   └─ SSE 推送 result 事件（文件 URL）
    ▼
展示下载卡片 ─── 用户可以：
    ├─ [下载 PPTX]
    └─ [在线编辑] → 跳转 PPT Editor 页面
```

### 2.3 实际流程顺序（新流程）

> 注意：代码中实际的顺序是 **意图识别 → 选模板 → 生成大纲 → 确认大纲 → 生成幻灯片**，
> 而不是 Controller 注释中列出的数字顺序。这是因为大纲生成需要感知模板结构。

```
detect_intent → select_template → generate_outline → confirm_outline → generate_ppt
```

---

## 3. 后端 API 详解

### 3.1 会话管理（REST）

| 方法 | 端点 | 说明 |
|------|------|------|
| GET | `/api/ppt/generation/sessions` | 获取用户所有 PPT 会话列表 |
| GET | `/api/ppt/generation/sessions/{id}` | 获取会话详情（含大纲、模板、slides JSON、结果 URL） |
| DELETE | `/api/ppt/generation/sessions/{id}` | 删除会话 |

### 3.2 SSE 流式生成（核心端点）

**`POST /api/ppt/generation/stream`** — 单一端点，通过 `action` 字段路由

#### 请求体

```json
{
  "action": "detect_intent | generate_outline | revise_outline | confirm_outline | select_template | generate_ppt | assemble_ppt",
  "sessionId": 12345,          // 会话 ID（首次请求可不传）
  "message": "做一个关于AI的PPT",  // detect_intent 时的用户消息
  "topic": "人工智能",            // generate_outline 时的主题
  "requirements": "要有数据图表",  // 可选要求
  "feedback": "多加一页关于...",    // revise_outline 时的修改意见
  "templateId": 1,               // select_template 时的模板 ID
  "templateUrl": "https://..."   // 或直接提供模板 URL
}
```

#### SSE 事件类型

| 事件名 | 触发时机 | 数据格式 |
|--------|---------|---------|
| `message` | AI 流式输出文本 token | 纯文本 token |
| `status` | 各阶段状态变化 | `{"phase": "...", "message": "..."}` |
| `intent` | 意图识别完成 | `{"detected": true, "topic": "...", "sessionId": 123}` |
| `outline` | 大纲生成完成 | `{"markdown": "# ...", "sessionId": 123}` |
| `outline_confirmed` | 大纲确认 | `{"sessionId": 123}` |
| `template_parsed` | 模板解析完成 | `{"slideCount": 22, "templateUrl": "...", "slides": [...], "slideImages": [...]}` |
| `slide_progress` | 逐页生成进度 | `{"current": 3, "total": 10, "previewImageUrl": "..."}` |
| `result` | 最终 PPT 生成完成 | `{"fileUrl": "...", "fileName": "...", "slideCount": 10}` |
| `error` | 错误 | 错误消息文本 |
| `done` | 本次 SSE 流结束 | `[DONE]` |

### 3.3 会话状态机

```
INIT → GENERATING_OUTLINE → OUTLINE_READY → AWAITING_TEMPLATE
    → PARSING_TEMPLATE → TEMPLATE_READY → GENERATING_SLIDES
    → PREVIEW_EDITING → ASSEMBLING → COMPLETED
                                    → FAILED
```

### 3.4 模板管理（REST）

| 方法 | 端点 | 说明 |
|------|------|------|
| POST | `/api/ppt/templates` | 上传 PPTX 模板（multipart） |
| GET | `/api/ppt/templates` | 列出所有可用模板 |
| GET | `/api/ppt/templates/{id}` | 模板详情 |
| DELETE | `/api/ppt/templates/{id}` | 删除模板 |

---

## 4. AI 编排逻辑

### 4.1 意图识别

- **模型**: 默认（通义千问）
- **Prompt**: 判断用户消息是否想生成 PPT，提取主题
- **输出**: 在回复末尾添加 `<<PPT_INTENT:{"topic":"..."}>>` 标记
- **后端处理**: 解析标记后创建 Session，通过 SSE 推送 `intent` 事件

### 4.2 大纲生成

- **模型**: `dashscope/qwen-long`（超长上下文，适合感知模板结构）
- **Prompt**: 输入主题 + 模板页面结构描述 → 输出 Markdown 大纲
- **格式约束**:
  - `# ` → PPT 标题（封面页）
  - `## ` → 章节标题（section 页）
  - `### ` → 要点内容（content 页子项）
  - 必须含封面和结束页
  - 章节数适配模板页面数量

### 4.3 逐页内容填充

- **模型**: `dashscope/qwen-vl-max`（视觉模型，可选退化为纯文本）
- **输入**:
  - 模板页结构描述（text_slots 的 shape_id、role、sample_text）
  - 页面类型提示（cover/content/section/ending）
  - 该页对应的大纲内容
  - （可选）模板页截图
- **输出**: 单页填充 JSON
  ```json
  {
    "template_slide_index": 0,
    "fills": [
      {"shape_id": 15, "text": "标题文本"},
      {"shape_id": 10, "items": ["要点1", "要点2", "要点3"]}
    ]
  }
  ```

---

## 5. Python PPT 服务接口

| 端点 | 功能 |
|------|------|
| `POST /api/templates/parse` | 下载 PPTX → 解析结构（slides/text_slots/image_slots） → 截封面 → 上传 OSS |
| `POST /api/templates/render-slides` | 渲染模板所有页为 PNG 预览图 → 上传 OSS |
| `POST /api/templates/render-slide` | 渲染模板单页为高清 PNG |
| `POST /api/generate-slide-preview` | 克隆+填充单页 → 渲染 PNG 预览图 → 上传 OSS |
| `POST /api/generate` | 基于模板+填充规格生成完整 PPTX → 上传 OSS |

### 核心技术

- **python-pptx**: 解析/操作 PPTX 文件
- **克隆机制**: 深拷贝 spTree + rId 映射 + 背景复制
- **文本填充**: 递归遍历形状（含 GROUP），按 shape_id 定位，保留原始字体格式
- **图片替换**: 下载图片 URL → 替换 Picture 形状
- **渲染**: LibreOffice headless 模式将 PPTX 转 PNG
- **存储**: 阿里云 OSS（与 Java 后端共享 bucket）

---

## 6. Web 前端实现细节

### 6.1 核心文件

| 文件 | 职责 |
|------|------|
| `pages/admin/PptGeneratorPage.tsx` | 主页面：三栏布局（会话侧栏 + 对话区 + 缩略图面板） |
| `hooks/usePptChat.ts` | 核心 Hook：会话管理、SSE 通信、消息状态、PPT 生成状态机 |
| `hooks/usePptGeneration.ts` | 底层 Hook：SSE 通用方法、类型定义 |
| `components/ppt/PptChatInput.tsx` | 输入组件：文本输入 + 语音输入 + 快捷提示 + 发送/停止 |
| `components/ppt/PptChatMessage.tsx` | 消息组件：支持 7 种消息类型渲染 |
| `components/ppt/TemplateSelector.tsx` | 模板选择 Modal：网格展示、封面预览、选中态 |
| `components/ppt/PptPreviewPanel.tsx` | 右侧缩略图面板：实时显示生成的幻灯片预览 |
| `components/ppt/SlideListPanel.tsx` | 幻灯片列表：缩略图滚动、选中高亮 |

### 6.2 消息类型

| type | 说明 | 渲染组件 |
|------|------|---------|
| `user` | 用户消息 | 右对齐蓝色气泡 |
| `ai-text` | AI 回复（支持流式 + Markdown） | 左对齐白色气泡 + Bot 头像 |
| `outline-card` | 大纲卡片 | Markdown 渲染 + 确认/修改按钮 |
| `progress-card` | 生成进度 | 进度条 + 页数 + 百分比 |
| `download-card` | 下载卡片 | 文件链接 + 在线编辑按钮 |
| `status` | 系统状态提示 | 灰色药丸标签 |
| `error` | 错误消息 | 红色气泡 |

### 6.3 SSE 通信

- **fetch API** + `ReadableStream` 手动解析 SSE 协议
- 支持 `event:` / `data:` 多行缓冲，空行分隔事件
- **AbortController** 支持中断生成
- **JSONBig** 处理 Java Long 类型精度问题

---

# 第二部分：Flutter 端实现方案

## 1. 移动端产品形态分析

### 1.1 Web 端 vs 移动端差异

| 维度 | Web 端 | 移动端建议 |
|------|--------|-----------|
| **屏幕** | 宽屏三栏布局 | 单栏 + Tab/Sheet 切换 |
| **输入** | 键盘为主 | 语音 + 键盘 + 快捷提示 |
| **预览** | 右侧面板实时预览 | 内嵌横向卡片滚动 or 全屏预览 |
| **会话管理** | 左侧栏常驻 | 顶部下拉/抽屉/独立列表页 |
| **文件下载** | 浏览器下载 | 系统分享 / 保存到相册 / 第三方 App 打开 |
| **模板选择** | Modal 网格 | BottomSheet 或全屏选择页 |
| **在线编辑** | 跳转 Editor 页 | 暂不支持（仅预览 + 下载） |

### 1.2 推荐交互形态：**对话式 + 步骤卡片**

移动端最适合的形态是 **聊天式界面**，与 Web 端保持一致的对话范式，但针对小屏优化：

```
┌──────────────────────────────────┐
│ [←] PPT 生成助手    [历史] [新建] │
├──────────────────────────────────┤
│                                  │
│  [用户] 帮我做一个关于AI的PPT     │
│                                  │
│  [AI] 好的，我来帮你生成...       │
│                                  │
│  [系统] 请选择模板                │
│  ┌────────────────────────────┐  │
│  │ 模板选择卡片（横向滚动）     │  │
│  │ [模板1] [模板2] [模板3] ... │  │
│  └────────────────────────────┘  │
│                                  │
│  [AI] 大纲已生成，请查看          │
│  ┌────────────────────────────┐  │
│  │ 大纲卡片（Markdown 渲染）    │  │
│  │ # 人工智能与教育             │  │
│  │ ## 1. AI 概述               │  │
│  │ ...                         │  │
│  │ [✓ 确认大纲] [✎ 修改大纲]   │  │
│  └────────────────────────────┘  │
│                                  │
│  ┌────────────────────────────┐  │
│  │ 进度卡片  3/10 页  ████░ 30%│  │
│  └────────────────────────────┘  │
│                                  │
│  ┌────────────────────────────┐  │
│  │ 幻灯片预览（横向滚动）       │  │
│  │ [S1][S2][S3][S4]...        │  │
│  └────────────────────────────┘  │
│                                  │
│  ┌────────────────────────────┐  │
│  │ 📥 下载 PPT   📤 分享       │  │
│  └────────────────────────────┘  │
│                                  │
├──────────────────────────────────┤
│  [🎤]  输入 PPT 主题...   [发送] │
└──────────────────────────────────┘
```

---

## 2. 技术栈

| 类别 | 技术选型 | 说明 |
|------|---------|------|
| **UI 框架** | Flutter + AppTheme | 复用现有设计系统 |
| **HTTP** | Dio | 复用现有 ApiClient |
| **SSE 解析** | Dio `ResponseType.stream` | 与 grading_service 相同方案 |
| **Markdown** | `flutter_markdown` | 渲染大纲 |
| **文件下载** | `dio` + `path_provider` | 下载到临时目录 |
| **文件分享** | `share_plus` | 系统分享菜单 |
| **语音输入** | 复用现有 VoiceInput | 如有 |
| **图片缓存** | `cached_network_image` | 幻灯片预览图缓存 |
| **状态管理** | StatefulWidget + setState | 与现有 grading 页保持一致 |

---

## 3. Flutter 端文件结构

```
lib/features/ppt/
├── services/
│   └── ppt_generation_service.dart    # 服务层：SSE通信 + REST API + 数据模型
├── pages/
│   ├── ppt_chat_page.dart             # 主页面：对话式 PPT 生成
│   └── ppt_history_page.dart          # 历史会话列表页
└── widgets/
    ├── ppt_message_bubble.dart        # 消息气泡（7种类型）
    ├── ppt_outline_card.dart          # 大纲卡片（Markdown + 确认/修改）
    ├── ppt_progress_card.dart         # 生成进度卡片
    ├── ppt_download_card.dart         # 下载/分享卡片
    ├── ppt_template_selector.dart     # 模板选择组件（横向滚动或BottomSheet）
    └── ppt_slide_preview.dart         # 幻灯片预览横向滚动条
```

---

## 4. 数据模型设计

```dart
// ==================== SSE 事件 ====================

class PptSseEvent {
  final String type;     // message / status / intent / outline / template_parsed / slide_progress / result / error / done
  final String rawData;
  final Map<String, dynamic>? jsonData;
}

// ==================== 会话状态 ====================

enum PptPhase {
  idle,
  detecting,
  generatingOutline,
  outlineReady,
  awaitingTemplate,
  parsingTemplate,
  templateReady,
  generatingSlides,
  assembling,
  completed,
  error,
}

// ==================== 消息类型 ====================

enum PptMessageType {
  user,
  aiText,
  outlineCard,
  progressCard,
  downloadCard,
  templateSelector,
  status,
  error,
}

class PptChatMessage {
  final String id;
  final PptMessageType type;
  String content;
  final DateTime timestamp;
  bool isStreaming;
  
  // 特殊字段
  String? outlineMarkdown;
  bool outlineConfirmed;
  int? progressCurrent;
  int? progressTotal;
  String? downloadUrl;
  String? downloadFileName;
}

// ==================== 会话摘要 ====================

class PptSessionSummary {
  final String id;
  final String topic;
  final String state;
  final String? resultUrl;
  final String? createTime;
  final String? updateTime;
}

// ==================== 模板 ====================

class PptTemplate {
  final String id;
  final String name;
  final String? coverUrl;
  final int slideCount;
}

// ==================== 幻灯片预览 ====================

class GeneratedSlide {
  final String? previewImageUrl;
  bool isNew;
}
```

---

## 5. PptGenerationService 设计

```dart
class PptGenerationService {
  final Dio _dio = ApiClient.instance.dio;
  
  // ==================== REST API ====================
  
  /// 获取会话列表
  Future<List<PptSessionSummary>> getSessions();
  
  /// 获取会话详情
  Future<PptSessionDetail?> getSessionDetail(String sessionId);
  
  /// 删除会话
  Future<void> deleteSession(String sessionId);
  
  /// 获取模板列表
  Future<List<PptTemplate>> getTemplates();
  
  // ==================== SSE 流式通信 ====================
  
  /// 通用 SSE action 方法
  /// 返回 Stream<PptSseEvent>
  Stream<PptSseEvent> sendAction({
    required String action,
    String? sessionId,
    String? message,
    String? topic,
    String? requirements,
    String? feedback,
    String? templateId,
    String? templateUrl,
  }) async* {
    final response = await _dio.post(
      '/api/ppt/generation/stream',
      data: {
        'action': action,
        if (sessionId != null) 'sessionId': sessionId,
        if (message != null) 'message': message,
        if (topic != null) 'topic': topic,
        if (requirements != null) 'requirements': requirements,
        if (feedback != null) 'feedback': feedback,
        if (templateId != null) 'templateId': templateId,
        if (templateUrl != null) 'templateUrl': templateUrl,
      },
      options: Options(
        responseType: ResponseType.stream,
        headers: {'Accept': 'text/event-stream'},
      ),
    );
    
    // 解析 SSE 流（与 grading_service 相同模式）
    // yield PptSseEvent for each parsed event
  }
  
  // ==================== 文件下载 ====================
  
  /// 下载 PPTX 文件到临时目录
  Future<String> downloadPptx(String url, String fileName);
}
```

---

## 6. PptChatPage 核心状态与交互

### 6.1 核心状态

```dart
class _PptChatPageState extends State<PptChatPage> {
  final _service = PptGenerationService();
  final _messages = <PptChatMessage>[];
  final _scrollController = ScrollController();
  final _inputController = TextEditingController();
  
  // 会话状态
  String? _currentSessionId;
  PptPhase _phase = PptPhase.idle;
  String _statusMessage = '';
  
  // 意图
  String _intentTopic = '';
  
  // 大纲
  String _outlineMarkdown = '';
  
  // 模板
  List<PptTemplate> _templates = [];
  
  // 生成进度
  List<GeneratedSlide> _generatedSlides = [];
  int _currentSlide = 0;
  int _totalSlides = 0;
  
  // 结果
  String _resultUrl = '';
  String _resultFileName = '';
  
  // UI 状态
  bool _isGenerating = false;
  StreamSubscription? _sseSubscription;
}
```

### 6.2 交互流程映射

```dart
// 1. 用户发送消息 → 意图识别
void _sendMessage(String content) {
  _addUserMessage(content);
  _phase = PptPhase.detecting;
  _streamAction('detect_intent', message: content);
}

// 2. 意图识别成功 → 自动弹出模板选择
void _onIntentDetected(String topic, String sessionId) {
  _intentTopic = topic;
  _currentSessionId = sessionId;
  _showTemplateSelector(); // BottomSheet or inline card
}

// 3. 用户选择模板 → 解析模板 → 自动生成大纲
void _selectTemplate(String templateId) {
  _phase = PptPhase.parsingTemplate;
  _streamAction('select_template', templateId: templateId);
  // onTemplateParsed → 自动调用 generate_outline
}

// 4. 大纲生成完毕 → 展示大纲卡片
void _onOutlineReady(String markdown) {
  _outlineMarkdown = markdown;
  _addOutlineCard(markdown);
}

// 5. 用户确认大纲 → 开始生成幻灯片
void _confirmOutline() {
  _streamAction('confirm_outline');
  // onConfirmed → 自动调用 generate_ppt
}

// 6. 逐页生成 → 实时更新预览
void _onSlideProgress(int current, int total, String? previewUrl) {
  _generatedSlides.add(GeneratedSlide(previewImageUrl: previewUrl));
  _currentSlide = current;
  _totalSlides = total;
}

// 7. 生成完成 → 展示下载卡片
void _onResult(String fileUrl, String fileName) {
  _resultUrl = fileUrl;
  _addDownloadCard(fileUrl, fileName);
}
```

---

## 7. UI 组件详细设计

### 7.1 模板选择（PptTemplateSelector）

**推荐形态：BottomSheet + 横向卡片网格**

```
┌──────────────────────────────────┐
│        选择 PPT 模板              │
│                                  │
│  ┌──────┐ ┌──────┐ ┌──────┐     │
│  │ 封面  │ │ 封面  │ │ 封面  │    │  ← 2列网格，封面图 + 模板名 + 页数
│  │ 预览  │ │ 预览  │ │ 预览  │    │
│  │      │ │  ✓   │ │      │     │  ← 选中态：品牌色边框 + 对勾
│  │模板1  │ │模板2  │ │模板3  │    │
│  │ 22页  │ │ 15页  │ │ 10页  │    │
│  └──────┘ └──────┘ └──────┘     │
│                                  │
│          [ 使用此模板 ]           │
└──────────────────────────────────┘
```

### 7.2 大纲卡片（PptOutlineCard）

```
┌──────────────────────────────────┐
│ AI 生成的大纲                     │
│                                  │
│ # 人工智能与教育                   │
│ ## 1. AI 技术概述                  │
│   ### 机器学习基础                 │
│   ### 深度学习与神经网络            │
│ ## 2. 教育领域应用                 │
│   ### 个性化学习                   │
│   ### 智能评测                    │
│ ## 感谢观看                       │
│                                  │
│ [✓ 确认大纲]  [✎ 修改大纲]        │
└──────────────────────────────────┘
```

- 确认后按钮变为 "✓ 大纲已确认"（绿色标签）
- 修改时展开 TextField + 提交/取消按钮

### 7.3 幻灯片预览（PptSlidePreview）

```
┌──────────────────────────────────┐
│ 幻灯片预览  3/10                  │
│ ┌────┐ ┌────┐ ┌────┐ ┌────┐     │
│ │ S1 │ │ S2 │ │ S3 │ │ S4 │ →   │  ← 横向滚动
│ │    │ │    │ │ ✨  │ │    │     │  ← 新生成的有动画
│ └────┘ └────┘ └────┘ └────┘     │
└──────────────────────────────────┘
```

- 使用 `CachedNetworkImage` 加载预览图
- 新增幻灯片有缩放进入动画
- 点击可全屏查看

### 7.4 下载/分享卡片（PptDownloadCard）

```
┌──────────────────────────────────┐
│ 📄 AI助力教育发展.pptx            │
│    PPT 生成完毕！10页              │
│                                  │
│  [📥 下载文件]  [📤 分享]          │
└──────────────────────────────────┘
```

- 下载：Dio 下载到临时目录 → 用 `open_filex` 打开
- 分享：下载后通过 `share_plus` 调用系统分享

---

## 8. 关键技术实现要点

### 8.1 SSE 流解析（复用 grading 模式）

```dart
Stream<PptSseEvent> _parseSseStream(ResponseBody responseBody) async* {
  String buffer = '';
  String currentEventType = 'message';
  
  await for (final chunk in responseBody.stream) {
    buffer += utf8.decode(chunk);
    final lines = buffer.split('\n');
    buffer = lines.removeLast();
    
    for (final line in lines) {
      if (line.startsWith('event:')) {
        currentEventType = line.substring(6).trim();
      } else if (line.startsWith('data:')) {
        final data = line.substring(5).trim();
        if (data == '[DONE]') continue;
        yield PptSseEvent(type: currentEventType, rawData: data);
        currentEventType = 'message';
      }
    }
  }
}
```

### 8.2 流式文本更新（打字机效果）

```dart
void _handleMessageToken(String token) {
  setState(() {
    final msg = _messages.last;
    msg.content += token;
    msg.isStreaming = true;
  });
  _autoScrollToBottom();
}
```

### 8.3 模板选择触发

意图识别成功后，通过 `showModalBottomSheet` 弹出模板选择：

```dart
void _showTemplateSelector() {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => PptTemplateSelector(
      templates: _templates,
      onSelect: (templateId) {
        Navigator.pop(context);
        _selectTemplate(templateId);
      },
    ),
  );
}
```

### 8.4 文件下载与分享

```dart
Future<void> _downloadAndShare(String url, String fileName) async {
  final dir = await getTemporaryDirectory();
  final filePath = '${dir.path}/$fileName';
  await _service.dio.download(url, filePath);
  
  // 分享
  await Share.shareXFiles([XFile(filePath)], text: '我用 AI 生成的 PPT');
}
```

---

## 9. 与现有项目的集成

### 9.1 入口位置

在 `chat_page.dart` 的智能工具区添加 "AI 制作PPT" 入口：

```dart
_buildQuickActionItem(
  icon: Icons.slideshow_rounded,
  label: 'AI制作PPT',
  colors: colors,
  onTap: () => Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => const PptChatPage()),
  ),
),
```

### 9.2 复用现有组件

| 组件 | 来源 | 用途 |
|------|------|------|
| `ApiClient` | `core/network/api_client.dart` | Dio 实例 + Token 管理 |
| `AppTheme` / `AppColors` | `config/app_theme.dart` | 主题色 + 设计令牌 |
| `FileUploadService` | `services/file_upload_service.dart` | （如需上传自定义模板） |
| SSE 解析模式 | `grading_service.dart` | 复用 SSE 流式解析逻辑 |

### 9.3 新增依赖

```yaml
# pubspec.yaml 中可能需要新增
flutter_markdown: ^0.7.4+3    # Markdown 渲染（如果尚未添加）
share_plus: ^10.1.4           # 系统分享
open_filex: ^4.5.0            # 打开文件
cached_network_image: ^3.4.1  # 图片缓存（如果尚未添加）
```

---

## 10. 开发计划

### Phase 1: 基础功能（MVP）

1. **PptGenerationService** — SSE 通信 + REST API + 数据模型
2. **PptChatPage** — 基本对话 UI + 消息列表
3. **意图识别** — 用户输入 → AI 回复 → 检测意图
4. **模板选择** — BottomSheet 模板列表
5. **大纲生成** — 流式输出 + 大纲卡片 + 确认/修改
6. **幻灯片生成** — 进度卡片 + 横向预览
7. **下载/分享** — 下载卡片 + 系统分享

### Phase 2: 体验优化

1. **会话管理** — 历史列表页、恢复会话
2. **流式打字机** — AI 回复逐字显示
3. **幻灯片全屏预览** — 点击缩略图全屏查看
4. **语音输入** — 语音转文字输入主题
5. **快捷提示** — 预设常用 PPT 主题

### Phase 3: 高级功能

1. **模板上传** — 手机端上传自定义 PPTX 模板
2. **大纲编辑** — 直接编辑 Markdown 大纲
3. **幻灯片排序** — 拖拽调整顺序
4. **离线缓存** — 缓存已生成的 PPT 和预览图

---

## 11. 风险与注意事项

| 风险 | 影响 | 缓解措施 |
|------|------|---------|
| SSE 长连接移动端不稳定 | 生成中断 | 心跳检测 + 断线重连 + 会话恢复 |
| 生成耗时长（10页≈2-5分钟） | 用户等待 | 后台继续 + 本地通知 + 进度实时反馈 |
| PPTX 文件较大（5-20MB） | 下载慢 | 压缩 + 进度显示 + 缓存 |
| AI 模型输出不稳定 | JSON 解析失败 | 容错处理 + 重试机制 + 降级方案 |
| 移动端 Markdown 渲染性能 | 长大纲卡顿 | 限制大纲长度 + 懒加载 |
| Long 类型 ID 精度 | sessionId 丢失精度 | 与 Web 端一样使用 String 类型 |
