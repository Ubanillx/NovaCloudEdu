# NovaCloudEdu Web

智云星课 Web 端，基于 **React 19 + TypeScript 5.9 + Vite 7.2 + TailwindCSS 4.1**。

包含用户端首页与管理后台，支持 AI 智能对话、学习社区、工作流可视化编排等功能。

---

## 技术栈

| 分类 | 技术 | 版本 |
|:---|:---|:---|
| **框架** | React | 19.2 |
| **语言** | TypeScript | ~5.9.3 |
| **构建** | Vite (SWC) | 7.2 |
| **样式** | TailwindCSS + Typography 插件 | 4.1 |
| **路由** | React Router DOM | 7.13 |
| **状态管理** | Zustand + React Context | 5.0 |
| **HTTP** | Axios + json-bigint | 1.7 / 1.0 |
| **图标** | Lucide React | 0.562 |
| **Markdown** | react-markdown + remark-gfm + rehype-raw | 10.1 |
| **实时通信** | @stomp/stompjs + sockjs-client | 7.3 / 1.6 |
| **流程图** | @xyflow/react + dagre | 12.10 / 0.8 |
| **地区数据** | china-division | 2.7 |
| **API 生成** | OpenAPI Generator (typescript-axios) | 2.7 |

---

## 功能模块

### 用户端

| 页面 | 功能描述 |
|:---|:---|
| **AI 对话** | 多模型智能对话（SSE 流式）、文件上传、知识库问答、文生图/文生视频 |
| **私聊/群聊** | WebSocket 实时消息（STOMP 协议）、已读回执、在线状态 |
| **学习圈子** | 帖子发布/编辑/详情、评论/回复、点赞、社交互动 |
| **每日单词** | 单词列表/详情、发音播放、学习记录 |
| **每日文章** | 文章列表/详情、AI 文章对话（SSE 流式） |
| **公告** | 公告列表/详情 |
| **课程表** | 课程排期管理、日历视图 |
| **单词本** | 个人生词本管理 |
| **个人中心** | 个人信息、地区/手机修改、学习数据、偏好设置 |

### 管理后台

| 页面 | 功能描述 |
|:---|:---|
| **用户管理** | 用户 CRUD、角色权限、分页搜索 |
| **AI 助手管理** | AI 助手配置、模型选择、系统提示词、知识库关联 |
| **知识库管理** | 文档上传（PDF/EPUB/DOCX）、向量化、知识库 CRUD |
| **工作流管理** | 可视化工作流编排（React Flow）、节点拖拽、定时调度、版本管理 |
| **公告管理** | 公告 CRUD、发布/下架 |
| **轮播图管理** | 首页轮播图 CRUD、排序 |
| **帖子管理** | 社区帖子审核/删除 |
| **反馈管理** | 用户反馈处理/回复 |
| **每日单词管理** | 单词库 CRUD、批量导入、音频管理 |
| **每日文章管理** | 文章 CRUD、发布/下架 |
| **爬虫配置/任务** | 网页爬虫规则配置（CSS 选择器）、任务调度与监控 |

---

## 路由设计

```
main.tsx (渲染入口)
│
├── /login                           # 登录页（公开）
├── /register                        # 注册页（公开）
├── /entry                           # 初始重定向（按角色分流 admin→/admin, user→/）
│
├── /admin/*                         # 管理后台（ProtectedRoute + requireAdmin）
│   ├── /admin                       #   后台首页
│   ├── /admin/users                 #   用户管理
│   ├── /admin/ai-assistants         #   AI 助手管理
│   ├── /admin/knowledge-bases       #   知识库管理
│   ├── /admin/workflows             #   工作流管理
│   ├── /admin/workflows/:id/edit    #   工作流编辑器（全屏画布，不套 AdminLayout）
│   ├── /admin/announcements         #   公告管理
│   ├── /admin/banners               #   轮播图管理
│   ├── /admin/posts                 #   帖子管理
│   ├── /admin/feedbacks             #   反馈管理
│   ├── /admin/daily-words           #   每日单词管理
│   ├── /admin/daily-articles        #   每日文章管理
│   ├── /admin/scraper/config        #   爬虫配置
│   └── /admin/scraper/tasks         #   爬虫任务
│
└── /*                               # 用户端（ProtectedRoute）
    ├── /                            #   首页（Banner/公告/课程表/单词/文章/统计）
    ├── /chat                        #   AI 对话（AI/私聊/群聊三栏切换）
    ├── /circle                      #   学习圈子
    ├── /profile                     #   个人中心
    ├── /schedule                    #   课程表
    ├── /word-book                   #   单词本
    ├── /daily-words                 #   每日单词列表
    ├── /daily-words/:id             #   每日单词详情
    ├── /daily-articles              #   每日文章列表
    ├── /daily-articles/:id          #   每日文章详情
    ├── /daily-articles/:id/chat     #   AI 文章对话
    ├── /announcements               #   公告列表
    ├── /announcements/:id           #   公告详情
    ├── /posts/:id                   #   帖子详情
    └── /posts/edit/:id?             #   帖子编辑/新建
```

---

## 项目结构

### Pages 页面

```
src/pages/
│
├── LoginPage.tsx                    # 登录页（手机号/密码 + 短信验证码）
├── RegisterPage.tsx                 # 注册页（手机号 + 短信验证码）
│
├── ChatPage.tsx                     # AI 智能对话页（三栏布局：AI/私聊/群聊）
├── CirclePage.tsx                   # 学习圈子（帖子列表/发布/搜索/关注动态）
├── ProfilePage.tsx                  # 个人中心（信息编辑/签到/学习数据/关注/粉丝）
├── SchedulePage.tsx                 # 课程表（周视图/课程排期/新增课程）
├── WordBookPage.tsx                 # 单词本（生词列表/复习/删除）
│
├── DailyWordListPage.tsx            # 每日单词列表（按级别筛选/搜索/分页）
├── DailyWordDetailPage.tsx          # 每日单词详情（释义/词组/例句/发音）
├── DailyArticleListPage.tsx         # 每日文章列表（分类筛选/搜索/分页）
├── DailyArticleDetailPage.tsx       # 每日文章详情（正文/AI 总结/收藏）
├── ArticleChatPage.tsx              # AI 文章对话（SSE 流式/上下文关联）
│
├── AnnouncementListPage.tsx         # 公告列表（分页/搜索）
├── AnnouncementDetailPage.tsx       # 公告详情
├── PostDetailPage.tsx               # 帖子详情（正文/评论/回复/点赞）
├── PostEditPage.tsx                 # 帖子编辑器（富文本/图片上传）
│
├── admin/                           # ═══ 管理后台 ═══
│   ├── UserManagementPage.tsx       # 用户管理（CRUD/角色/搜索/分页）
│   ├── AiAssistantManagementPage.tsx # AI 助手管理（创建/配置/模型选择/提示词/知识库关联）
│   ├── KnowledgeBaseManagementPage.tsx # 知识库管理（创建/文档上传/向量化进度/文档列表）
│   ├── WorkflowManagementPage.tsx   # 工作流管理（列表/创建/删除/定时调度/执行日志）
│   │
│   ├── workflow/                    # ─── 工作流可视化编辑器 ───
│   │   ├── WorkflowEditorPage.tsx   #   全屏画布编辑器（React Flow 集成）
│   │   ├── types.ts                 #   工作流/节点/边 类型定义
│   │   ├── store/
│   │   │   └── useWorkflowStore.ts  #   Zustand 状态（节点/边/变量/撤销/重做）
│   │   ├── nodes/
│   │   │   ├── WorkflowNodeComponent.tsx # 通用节点渲染组件
│   │   │   ├── LoopContainerNode.tsx #   循环容器节点（可嵌套子节点）
│   │   │   └── CommentNode.tsx      #   注释节点
│   │   ├── components/
│   │   │   ├── NodeConfigPanel.tsx   #   节点配置面板（18 种节点的表单配置）
│   │   │   ├── NodeToolbar.tsx       #   节点工具栏（拖拽添加节点）
│   │   │   ├── CanvasToolbar.tsx     #   画布工具栏（缩放/布局/保存/运行）
│   │   │   ├── TriggerManagerPanel.tsx # 触发器管理面板（定时/Webhook/手动）
│   │   │   ├── VersionHistoryPanel.tsx # 版本历史面板（版本列表/回滚）
│   │   │   ├── SaveAsTemplateModal.tsx # 保存为模板弹窗
│   │   │   └── TemplateGalleryModal.tsx # 模板画廊弹窗
│   │   └── utils/
│   │       └── autoLayout.ts        #   DAG 自动布局算法（dagre）
│   │
│   ├── AnnouncementManagementPage.tsx # 公告管理
│   ├── BannerManagementPage.tsx     # 轮播图管理
│   ├── PostManagementPage.tsx       # 帖子管理
│   ├── FeedbackManagementPage.tsx   # 反馈管理
│   ├── DailyWordManagementPage.tsx  # 每日单词管理（CRUD/批量导入/音频）
│   ├── DailyArticleManagementPage.tsx # 每日文章管理
│   ├── ScraperConfigPage.tsx        # 爬虫规则配置（CSS 选择器/分页策略/代理）
│   └── ScraperTaskPage.tsx          # 爬虫任务监控（创建/执行/日志/结果）
│
└── index.ts                         # 页面导出
```

### Components 组件

```
src/components/
│
├── layout/                          # ═══ 布局组件 ═══
│   ├── AdminLayout.tsx              #   管理后台布局（侧边栏+头部+内容区）
│   ├── Header.tsx                   #   全局头部（Logo/导航/搜索/主题切换/用户菜单）
│   ├── Sider.tsx                    #   侧边栏导航（管理后台菜单/折叠/展开）
│   ├── Content.tsx                  #   内容区容器
│   ├── Footer.tsx                   #   底部栏（链接/版权/主题色选择器）
│   └── index.ts
│
├── chat/                            # ═══ 聊天组件 ═══
│   ├── AiChatPanel.tsx              #   AI 对话面板
│   │                                #     - 会话列表/新建会话
│   │                                #     - 消息列表（SSE 流式渲染）
│   │                                #     - 文件/图片上传
│   │                                #     - 模型选择/知识库切换
│   │                                #     - 文生图/文生视频
│   ├── PrivateChatPanel.tsx         #   私聊面板（好友列表/对话窗口）
│   ├── GroupChatPanel.tsx           #   群聊面板（群组列表/创建群/成员管理）
│   ├── ChatWindow.tsx               #   私聊窗口（消息渲染/输入/已读回执）
│   ├── GroupChatWindow.tsx          #   群聊窗口（消息渲染/回复/@ 成员/已读统计）
│   ├── MessageContent.tsx           #   消息内容渲染器（文本/Markdown/图片/文件/音频/视频）
│   ├── SessionList.tsx              #   AI 会话列表组件
│   ├── useAiChat.ts                 #   AI 对话核心 Hook
│   │                                #     - SSE 流式对话（EventSource）
│   │                                #     - 会话 CRUD / 消息历史
│   │                                #     - 文生图/文生视频任务管理
│   │                                #     - 多模型切换 / 知识库关联
│   └── useChatUpload.ts             #   文件上传 Hook（图片检测/大小格式化/OSS 上传）
│
├── home/                            # ═══ 首页组件 ═══
│   ├── BannerCarousel.tsx           #   轮播图（自动播放/手动切换/指示器）
│   ├── AnnouncementSection.tsx      #   公告区域（最新公告/查看更多）
│   ├── DailyWordSection.tsx         #   每日单词卡片（单词/音标/释义/发音）
│   ├── DailyArticleSection.tsx      #   每日文章推荐（标题/摘要/封面）
│   ├── CourseScheduleCard.tsx       #   课程表卡片（今日课程/周视图）
│   ├── StudyPlanCard.tsx            #   学习计划卡片（目标/进度）
│   ├── StudyStatsCard.tsx           #   学习统计卡片（学习时长/天数/签到）
│   └── index.ts
│
├── ui/                              # ═══ UI 基础组件 ═══
│   ├── Toast.tsx                    #   全局 Toast 提示（success/error/info/warning）
│   ├── Tooltip.tsx                  #   工具提示 + TruncateWithTooltip 截断提示
│   ├── Avatar.tsx                   #   用户头像（图片/文字 fallback）
│   ├── RegionPicker.tsx             #   省市区三级选择器（china-division 数据）
│   ├── PhoneEditModal.tsx           #   手机号修改弹窗（短信验证码验证）
│   └── index.ts
│
└── ProtectedRoute.tsx               # 路由守卫（Token 校验 + 管理员角色校验）
```

### API 层

```
src/api/
├── index.ts                         # Axios 实例 & API 客户端入口
│                                    #   - json-bigint 响应转换（雪花 ID 大数处理）
│                                    #   - 请求拦截器（自动注入 Bearer Token）
│                                    #   - 响应拦截器（401 自动刷新 Token + 请求队列重放）
│                                    #   - Token 管理（存储/获取/清除/刷新）
│                                    #   - 登出回调机制
│                                    #   - 导出所有生成的 API 和 Model
│
├── websocket.ts                     # WebSocket 聊天服务（单例模式）
│                                    #   - STOMP 协议连接（SockJS fallback）
│                                    #   - 私聊消息收发 + 已读回执
│                                    #   - 群聊消息收发 + 群组订阅/取消
│                                    #   - 通知事件（好友请求/群邀请/系统通知）
│                                    #   - 自动重连（指数退避，最多 10 次）
│                                    #   - 连接状态管理（disconnected/connecting/connected/error）
│
├── chatTypes.ts                     # WebSocket 消息类型定义
│                                    #   - WsChatMessage（私聊消息）
│                                    #   - WsGroupMessage（群聊消息）
│                                    #   - ReadReceipt / WsGroupReadReceipt（已读回执）
│                                    #   - NotificationEvent（12 种通知类型）
│                                    #   - ConnectionState / ChatEventHandlers
│
└── generated/ (800+ 文件)           # OpenAPI Generator 自动生成
    ├── api/                         #   各模块 API 类（与后端 Controller 一一对应）
    └── models/                      #   请求/响应 Model（与后端 DTO 一一对应）
```

### 状态管理

```
src/context/                         # React Context 全局状态
├── ChatContext.tsx                   # 聊天上下文 Provider
│                                    #   - WebSocket 连接管理（connect/disconnect）
│                                    #   - 私聊消息状态 + 发送/已读
│                                    #   - 群聊消息状态 + 发送/订阅/取消/已读
│                                    #   - 通知事件流 + 未读计数
│                                    #   - 已读回执追踪
│
├── SiderContext.tsx                  # 侧边栏状态 Provider
│                                    #   - siderHidden（是否隐藏）
│                                    #   - siderCollapsed（是否折叠）
│
└── ThemeContext.tsx                  # 主题 Provider
                                     #   - light/dark 切换
                                     #   - localStorage 持久化
                                     #   - 系统偏好自动检测（prefers-color-scheme）

src/pages/admin/workflow/store/
└── useWorkflowStore.ts              # 工作流编辑器 Zustand Store
                                     #   - 节点/边 增删改查
                                     #   - 变量管理
                                     #   - 撤销/重做（undo/redo）
                                     #   - 保存/发布/执行
```

### Hooks & 工具

```
src/hooks/
└── useCache.ts                      # 数据缓存 Hook
                                     #   - localStorage 带过期时间缓存
                                     #   - 自动过期清理
                                     #   - 加载中/错误状态管理
                                     #   - 手动刷新 + 回调

src/data/
└── mock.ts                          # Mock 数据类型和示例数据
                                     #   - Course / AiAssistant / Article / DailyWord 等类型
```

### 入口文件

```
src/
├── main.tsx                         # 渲染入口
│                                    #   - ThemeProvider 包裹
│                                    #   - BrowserRouter 路由
│                                    #   - ScrollToTop 路由切换滚动
│                                    #   - InitialRedirect 角色分流
│                                    #   - 公开路由（login/register）
│                                    #   - 管理员路由（/admin/*）
│                                    #   - 用户路由（/*）
│
├── App.tsx                          # 用户端应用壳
│                                    #   - SiderProvider + ChatProvider
│                                    #   - Header + Sider + Content + Footer 布局
│                                    #   - HomePage 组合首页组件
│                                    #   - 嵌套路由（chat/circle/profile 等）
│
├── App.css                          # 全局样式（自定义动画等）
└── index.css                        # TailwindCSS 基础样式 + CSS 变量（主题色/间距等）
```

---

## 关键技术实现

### 雪花 ID 大数处理

后端使用雪花算法生成 ID（如 `1996401850335551490`），超过 JS `Number.MAX_SAFE_INTEGER`。

```
api/index.ts → transformResponse → JSONBig({ storeAsString: true }).parse(data)
```

所有 ID 在运行时为**字符串类型**，禁止使用 `Number()` / `parseInt()` 转换。

### Token 自动刷新

```
401 响应 → 暂停后续请求 → 刷新 Token → 重放队列中的请求
```

支持并发请求场景：多个请求同时 401 时，只刷新一次，其他请求排队等待。

### SSE 流式对话

```
useAiChat Hook → fetch(SSE) → 逐字渲染 → 支持中断
```

### WebSocket 实时通信

```
WebSocketService(单例) → STOMP/SockJS → 自动重连（指数退避）
                       → ChatContext → 组件订阅
```

---

## 配置文件

| 文件 | 说明 |
|:---|:---|
| `vite.config.ts` | Vite 配置（React SWC 插件 + TailwindCSS 插件） |
| `openapi-generator-config.yaml` | OpenAPI Generator 配置（typescript-axios 生成器/类型映射） |
| `tsconfig.json` | TypeScript 配置 |
| `eslint.config.js` | ESLint 配置（React Hooks/Refresh 插件） |
| `tailwind.config` | TailwindCSS 配置（内置于 index.css） |

---

## 快速开始

### 安装依赖

```bash
npm install
```

### 启动开发服务器

```bash
npm run dev
```

访问 http://localhost:5173

### 生成 API 客户端

从后端 Swagger 接口自动生成 TypeScript API 客户端：

```bash
# 从运行中的后端服务生成（需先启动后端）
npm run openapi:generate

# 从本地 openapi.json 文件生成
npm run openapi:generate:local
```

生成的代码位于 `src/api/generated/`。

### 构建生产版本

```bash
npm run build
```

### 代码检查

```bash
npm run lint
```
