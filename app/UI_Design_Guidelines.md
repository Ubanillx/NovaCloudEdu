# 智云星课 (NovaCloudEdu) UI 设计指南

基于个人中心 (ProfilePage) 与认证模块 (Auth 组件) 提取的最新设计规范。本作致力于打造一个现代化、沉浸感强、年轻有活力的学习平台。

## 1. 核心设计理念

*   **现代化与空间感**：通过大圆角、柔和的弥散阴影、半透明底层建立卡片化层级，使界面更加通透。
*   **强烈的字体呈现**：引入较粗字重的主副标题，明确视觉重点。
*   **微交互驱动**：注重按钮按下缩放（Scale）和顺滑的过度动画。
*   **全场景暗黑模式支持**：通过语义化 Token 管理所有色彩。

---

## 2. 颜色体系 (Color System)

使用语义化颜色方案（参考 `AppTheme` 规范）。

### 2.1 品牌与主色调
*   **品牌主色 (Brand 1)**: `#1989FA` (科技蓝)
*   **品牌辅色 (Brand 2)**: `#3B82F6` (亮蓝)
*   **聚焦色/强调色 (Focus)**: `#3B5BFF` (常用于输入框激活态等强光标场景)

### 2.2 背景与卡片 (Background & Surface)
*   **Scaffold 背景色 (Background)**: 
    *   亮色: `#F8FAFC`
    *   暗色: `#0F172A`
*   **卡片/模块背景 (Surface)**: 
    *   亮色: `#FFFFFF`
    *   暗色: `#1E293B`
*   **交互底色/输入框/表单背景 (Surface Variant)**: 
    *   亮色: `#F1F5F9`
    *   暗色: `#334155`

### 2.3 文本与图标层级 (Typography & Icons)
*   **一级文本/标题 (Text Primary)**: `#1E293B` (亮) / `#F1F5F9` (暗)
*   **二级文本/正文 (Text Secondary)**: `#64748B` (亮) / `#94A3B8` (暗)
*   **三级文本/提示/暗文 (Text Tertiary)**: `#94A3B8` (亮) / `#64748B` (暗)
*   **分割线 (Divider)**: `#E2E8F0` (亮) / `#334155` (暗)
*   **边框 (Border)**: `#CBD5E1` (亮) / `#475569` (暗)

### 2.4 功能语义色 (Semantic Colors)
*   **成功 (Success)**: `#10B981` (亮) / `#34D399` (暗)
*   **警告 (Warning)**: `#F59E0B` (亮) / `#FBBF24` (暗)
*   **错误 (Error)**: `#EF4444` (亮) / `#F87171` (暗)

### 2.5 常用渐变 (Gradients)
*   **打卡/强行动呼唤**: `LinearGradient(colors: [#xFFFF4B2B, #xFFFF416C])`
*   **品牌进度/强调**: `LinearGradient(colors: [Brand, Brand2])`

---

## 3. 字体排版 (Typography)

全局推荐优先使用 **Inter** 字体族（或原生无衬线），加强数字与英文字符的结构感。字距往往较原来缩小（Letter Spacing 为负值）以增强标题凝聚力。

*   **大标题头 (Display/Name)**: `24px - 32px`，字重 `W900 (Black)`，字间距 `-0.5 到 -1.5`。
*   **模块/卡片标题 (Headline)**: `18px`，字重 `W900`。
*   **重要数据指标 (Stat Number)**: `22px`，字重 `W800`，字间距 `-0.5`。
*   **主按钮文本**: `16px - 17px`，字重 `W700 - W800`，字母间距适当放大（如引流按钮 `letterSpacing: 4` 或 `0.5`）。
*   **正文/副文 (Body/Secondary)**: `14px - 16px`，字重 `W500 - W600`。
*   **辅助说明/小标签 (Tags/Caption)**: `12px`，字重 `W600`。

---

## 4. 间距与圆角 (Spacing & Radius)

### 4.1 圆角 (Border Radius)
*   **页面级大卡片/模态框**: `24px`, `28px`，甚至在 Auth 登录主卡片使用到 `40px`。
*   **交互按钮/输入框**: `16px - 20px`。
*   **小面板/列表项**: `12px - 16px`。
*   **进度条/状态标签**: 完全成胶囊状 (`100px` / `StadiumBorder()`)。
*   **头像/图标基底**: 绝对圆形 (`BoxShape.circle`)。

### 4.2 间距 (Padding & Margin)
*   **水平安全边距 (Horizontal Margin)**: 屏幕两侧保留 `24px` 或 `28px` 的空白。
*   **模块间距 (Vertical Gap)**: 模块间通常保留 `12px` - `16px` 测试，较大区块间使用 `24px`。
*   **卡片内边距 (Card Padding)**: `20px - 24px` 均匀留白。

---

## 5. 核心组件规范 (Components)

### 5.1 按钮 (Buttons)
*   **主行动按钮 (Primary Button)**: 
    *   高度: `54px - 58px`
    *   样式: 采用渐变背景色，圆角 `16px - 20px`。
    *   特效: 带有与其本身渐变色同系、并增加透明度的彩色强力阴影 （如 `Color.withOpacity(0.25)`, `blurRadius: 12-16`, `offset: (0, 6-8)`）。
*   **次级按钮 (Secondary Button)**: 
    *   高度: `48px`
    *   样式: 使用 `Surface Variant` 背景，带 1px 浅色柔和边框，文本使用色为 Secondary。

### 5.2 卡片容器 (Cards)
*   抛弃 Material 默认的高程位移（`elevation: 0`），统一采用自定义的柔和弥散阴影：
    *   标准卡片阴影参数: `BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.04), blurRadius: 20, offset: Offset(0, 8))`。

### 5.3 数据录入 (Inputs)
*   **文本输入框 (TextField)**:
    *   视觉: 去掉常态边框。背景填充为 `Surface Variant`（50%透明度）。
    *   交互: 激活态时呈现 `1.5px` 的聚焦色边框（`#3B5BFF`）。
    *   内容: 内边距大（`20px`四周），字体加粗 `W600`。

### 5.4 图标 (Icons)
*   设计风格一致性: 尽量选用 `Rounded` （圆润系）后缀的图标资源（例如 `Icons.settings_outlined`、`Icons.check_circle_rounded`）。

---

## 6. 微交互与动画 (Micro-Interactions)

*   **弹性缩放点击 (Bouncy Tap)**: 对于按钮容器，在按下时缩小为 `Scale 0.97`，释放回弹，周期 `100ms-160ms`。
*   **高斯模糊渲染 (Blur Decor)**: 在无尽背景和登陆页面大背景层加入炫丽的颜色色块，并使用高强度的弥散模糊（`MaskFilter.blur(BlurStyle.normal, 60-70)`）形成柔和光晕感。
*   **平滑位移 (Smooth Transition)**: 对于滑块 (Segmented Control)、进度条，尽量使用具有 `Curves.easeOutCubic` 缓动属性的时间约为 `160-220ms` 的动画。
