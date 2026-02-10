# NovaCloudEdu App

智云星课 Flutter 移动端应用，支持 Android 与 iOS 双平台。

底部五大 Tab 导航：**首页 / 课程 / 圈子 / 对话 / 我的**，包含 AI 智能对话、社交聊天、每日学习、学习圈子等功能。

---

## 技术栈

| 分类 | 技术 | 版本 |
|:---|:---|:---|
| **框架** | Flutter | 3.10+ |
| **语言** | Dart | ^3.10.1 |
| **UI 组件** | TDesign Flutter | 0.2.6 |
| **网络** | Dio | 5.9 |
| **实时通信** | WebSocket + STOMP | web_socket_channel 3.0 / stomp_dart_client 2.0 |
| **SSE** | flutter_client_sse | 2.0 |
| **安全存储** | flutter_secure_storage | 10.0 |
| **本地数据库** | sqflite | 2.3 |
| **Markdown** | markdown_widget | 2.3 |
| **录音/播放** | record + audioplayers | 6.0 / 6.1 |
| **文件选择** | file_picker | 8.1 |
| **图片选择** | image_picker | 1.0 |
| **权限管理** | permission_handler | 11.3 |
| **图片缓存** | cached_network_image + flutter_cache_manager | 3.4 |
| **文件预览** | open_filex + url_launcher | 4.5 / 6.2 |
| **地区选择** | city_pickers | 1.3 |
| **路径工具** | path_provider | 2.1 |
| **SVG** | flutter_svg | 2.0 |
| **下拉刷新** | easy_refresh | 3.4 |
| **API 生成** | OpenAPI Generator (Dart/Dio) | 6.1 |

---

## 功能模块

| 模块 | 功能描述 |
|:---|:---|
| **认证** | 手机号/密码登录、短信验证码注册、Token 自动刷新、安全存储 |
| **首页** | Banner 轮播、公告列表/详情、每日单词/文章、课程表卡片、学习统计 |
| **每日单词** | 单词列表（级别筛选/搜索/分页）、单词详情（释义/词组/例句/发音）、生词本、学习笔记 |
| **每日文章** | 文章列表（分类筛选/搜索）、文章详情（正文/收藏）、AI 文章对话（SSE 流式） |
| **课程** | 课程列表/详情、课程表（周视图/编辑/新增）、任务列表 |
| **AI 对话** | 多模型智能对话（SSE 流式）、会话管理、语音交互（ASR/TTS）、知识库问答、文件上传 |
| **社交聊天** | 私聊（WebSocket + STOMP）、群聊、好友管理（申请/同意/拒绝）、群组管理、统一搜索 |
| **学习圈子** | 帖子发布/编辑/详情、评论/回复/点赞、用户主页、关注/粉丝、收藏、搜索 |
| **个人中心** | 个人信息编辑、手机号修改、签到打卡/排行榜、反馈管理、学习计划、偏好设置、主题切换 |

---

## 应用导航

```
main.dart
│
├── SplashPage                       # 启动页（Logo 动画 + 登录状态检查）
│   ├── → LoginPage                  #   未登录 → 登录页
│   └── → MainPage                   #   已登录 → 主页
│
└── MainPage                         # 底部导航 TabBar（5 个 Tab）
    ├── Tab 0: HomePage              #   首页
    ├── Tab 1: CoursePage            #   课程
    ├── Tab 2: CirclePage            #   圈子
    ├── Tab 3: ChatPage              #   对话
    └── Tab 4: ProfilePage           #   我的

命名路由：
├── /circle/edit                     # 帖子编辑/新建
├── /circle/user-posts               # 用户帖子列表
└── /circle/user-profile             # 用户主页
```

---

## 项目结构

### Features 功能模块

#### 认证 (`features/auth/`)

```
auth/
├── pages/
│   ├── login_page.dart              # 登录页（手机号/密码 + 短信验证码 + 记住密码）
│   └── register_page.dart           # 注册页（手机号 + 短信验证码）
├── controllers/
│   └── auth_controller.dart         # 认证控制器
└── services/
    └── auth_service.dart            # 认证服务
                                     #   - Token 持久化（flutter_secure_storage）
                                     #   - 登录/注册/Token 刷新
                                     #   - 用户信息缓存
                                     #   - 自动登录状态检查
```

#### 首页 (`features/home/`)

```
home/
├── pages/
│   ├── home_page.dart               # 首页（Banner/公告/课程表/单词/文章/统计/搜索）
│   ├── announcement_list_page.dart  # 公告列表（分页/搜索）
│   └── announcement_detail_page.dart # 公告详情
│
├── controllers/
│   └── home_controller.dart         # 首页控制器
│
├── daily_word/                      # ─── 每日单词子模块 ───
│   ├── daily_word.dart              #   导出文件
│   ├── models/
│   │   └── word_notes_model.dart    #   学习笔记模型
│   ├── pages/
│   │   ├── daily_word_page.dart     #   单词列表（级别筛选/搜索/分页/滑动操作）
│   │   ├── word_detail_page.dart    #   单词详情（释义/词组/例句/发音/笔记/收藏）
│   │   └── word_book_page.dart      #   生词本（收藏单词/复习/删除）
│   └── services/
│       ├── daily_word_service.dart   #   单词 API 服务
│       └── daily_word_storage_service.dart # 单词本地存储（学习进度/笔记）
│
└── daily_article/                   # ─── 每日文章子模块 ───
    ├── daily_article.dart           #   导出文件
    ├── pages/
    │   ├── daily_article_page.dart  #   文章列表（分类筛选/搜索/分页）
    │   ├── article_detail_page.dart #   文章详情（正文渲染/AI 总结/收藏）
    │   └── article_chat_page.dart   #   AI 文章对话（SSE 流式/上下文关联）
    └── services/
        ├── daily_article_service.dart #  文章 API 服务
        └── article_chat_service.dart #   文章 AI 对话服务（SSE 流式）
```

#### 课程 (`features/course/`)

```
course/
├── pages/
│   ├── course_page.dart             # 课程列表（分类/搜索/推荐）
│   ├── schedule_page.dart           # 课程表（周视图/日历/课程详情弹窗）
│   ├── schedule_edit_page.dart      # 课程表编辑（新增/修改课程排期）
│   └── task_list_page.dart          # 任务列表（待办/已完成/筛选）
└── services/
    └── schedule_service.dart        # 课程表 API 服务
```

#### AI 对话与社交聊天 (`features/chat/`)

```
chat/
├── pages/                           # ═══ 页面（11 个） ═══
│   ├── chat_page.dart               # 对话主页（三栏切换：AI/私聊/群聊）
│   ├── ai_chat_page.dart            # AI 智能对话
│   │                                #   - 多模型选择/知识库切换
│   │                                #   - SSE 流式响应 + Markdown 渲染
│   │                                #   - 语音输入（ASR）/ 语音播放（TTS）
│   │                                #   - 文件/图片上传
│   │                                #   - 会话历史切换
│   ├── ai_session_list_page.dart    # AI 会话列表（创建/删除/切换）
│   ├── private_chat_page.dart       # 私聊页面（消息收发/已读/图片/文件）
│   ├── group_chat_page.dart         # 群聊页面（消息/回复/@/已读统计/成员管理）
│   ├── friends_list_page.dart       # 好友列表
│   ├── friend_requests_page.dart    # 好友请求（收到的/发出的/同意/拒绝）
│   ├── search_user_page.dart        # 搜索用户（添加好友）
│   ├── search_group_page.dart       # 搜索群组（加入群）
│   ├── invite_members_page.dart     # 邀请成员入群
│   └── unified_search_page.dart     # 统一搜索（好友/群组/消息）
│
├── services/                        # ═══ 服务（13 个） ═══
│   ├── ai_chat_service.dart         # AI 对话服务（SSE 流式/会话管理/历史消息）
│   ├── chat_websocket_service.dart  # WebSocket 聊天服务
│   │                                #   - STOMP 协议连接/断开
│   │                                #   - 私聊/群聊消息收发
│   │                                #   - 通知事件订阅
│   │                                #   - 已读回执
│   │                                #   - 自动重连
│   ├── chat_database_service.dart   # 私聊消息本地数据库（SQLite 缓存）
│   ├── group_database_service.dart  # 群聊消息本地数据库（SQLite 缓存）
│   ├── chat_sync_service.dart       # 私聊消息同步（本地 ↔ 服务端）
│   ├── group_sync_service.dart      # 群聊消息同步（本地 ↔ 服务端）
│   ├── chat_service.dart            # 聊天通用服务
│   ├── friend_service.dart          # 好友 API 服务
│   ├── group_service.dart           # 群组 API 服务
│   ├── audio_service.dart           # 音频服务（录音 ASR + TTS 播放）
│   ├── notification_service.dart    # 通知服务（消息通知/未读计数/离线缓存）
│   ├── file_cache_service.dart      # 文件缓存服务（图片/文件本地缓存）
│   └── user_info_service.dart       # 用户信息查询服务
│
└── widgets/                         # ═══ 组件（2 个） ═══
    ├── chat_input_bar.dart          # 聊天输入栏（文本/语音切换/文件/图片/表情）
    └── message_content_widget.dart  # 消息内容渲染（文本/Markdown/图片/文件/音频/视频）
```

#### 学习圈子 (`features/circle/`)

```
circle/
├── pages/                           # ═══ 页面（7 个） ═══
│   ├── circle_page.dart             # 圈子主页（帖子列表/发布/搜索/关注动态/热门）
│   ├── post_detail_page.dart        # 帖子详情（正文/评论/回复/点赞/收藏/分享）
│   ├── post_edit_page.dart          # 帖子编辑器（富文本/图片上传/标签）
│   ├── search_page.dart             # 圈子搜索（帖子/用户）
│   ├── user_profile_page.dart       # 用户主页（资料/帖子/关注/粉丝）
│   ├── user_posts_page.dart         # 用户帖子列表
│   └── my_favourites_page.dart      # 我的收藏
└── services/
    └── post_service.dart            # 帖子 API 服务（CRUD/点赞/评论/收藏/关注）
```

#### 个人中心 (`features/profile/`)

```
profile/
├── pages/                           # ═══ 页面（9 个） ═══
│   ├── profile_page.dart            # 个人中心主页（信息卡片/功能入口/签到/统计）
│   ├── profile_detail_page.dart     # 个人信息编辑（头像/昵称/性别/生日/简介/地区）
│   ├── phone_edit_page.dart         # 手机号修改（短信验证码验证）
│   ├── settings_page.dart           # 设置页（主题切换/缓存清理/关于/退出登录）
│   ├── checkin_ranking_page.dart    # 签到排行榜（日/周/月排名）
│   ├── study_plan_page.dart         # 学习计划（创建/编辑/完成/删除）
│   ├── feedback_page.dart           # 反馈列表（我的反馈/状态跟踪）
│   ├── feedback_create_page.dart    # 提交反馈（分类/描述/截图上传）
│   └── feedback_detail_page.dart    # 反馈详情（对话式回复/状态更新）
│
├── services/
│   ├── checkin_service.dart         # 签到 API 服务（签到/记录/排行榜）
│   └── feedback_service.dart        # 反馈 API 服务
│
└── widgets/
    └── add_plan_dialog.dart         # 新建学习计划弹窗
```

#### 数据 (`features/data/`)

```
data/
└── mock_data.dart                   # Mock 数据（课程/助手/文章/单词等示例数据）
```

---

### Core 核心层

```
core/
├── network/                         # ═══ 网络层 ═══
│   ├── api_client.dart              # API 客户端（单例模式）
│   │                                #   - Dio 实例（baseUrl/超时/请求头）
│   │                                #   - OpenAPI 生成的 NovaApi 集成
│   │                                #   - JWT Token 注入/清除
│   │                                #   - Token 过期回调
│   │                                #   - 开发环境日志拦截器
│   │                                #   - 分 API 访问：defaultApi / aiApi / webhookApi
│   └── token_refresh_interceptor.dart # Token 自动刷新拦截器
│                                    #   - 401 自动刷新 Token
│                                    #   - 请求队列（并发 401 只刷新一次）
│                                    #   - flutter_secure_storage 安全存储
│                                    #   - 刷新失败自动登出
│
├── storage/
│   └── local_storage.dart           # 本地安全存储封装
│
├── database/                        # ═══ SQLite 数据库 ═══
│   ├── database_service.dart        # 数据库服务（建表/升级/CRUD）
│   │                                #   - 私聊消息表
│   │                                #   - 群聊消息表
│   │                                #   - 学习计划表
│   ├── models/
│   │   └── study_plan.dart          # 学习计划模型（本地持久化）
│   └── repositories/
│       └── study_plan_repository.dart # 学习计划仓储（CRUD + 查询）
│
├── theme/
│   └── app_theme.dart               # 主题配置（品牌色/语义色/扩展）
│
└── constants/
    └── app_constants.dart           # 应用常量（API 路径等）
```

### Config 配置

```
config/
├── app_config.dart                  # 应用环境配置（dev/staging/prod）
├── env_config.dart                  # 环境参数（API 地址/OpenAPI 文档地址）
│                                    #   - Android 模拟器自动使用 10.0.2.2
│                                    #   - iOS/其他平台使用 localhost
├── app_theme.dart                   # 完整主题定义（浅色/深色/品牌色/语义色系统）
└── theme_provider.dart              # 主题 Provider（ChangeNotifier）
                                     #   - 浅色/深色/跟随系统三种模式
                                     #   - SharedPreferences 持久化
```

### Services 服务层

```
services/
├── auth_service.dart                # 认证服务（接口封装）
├── user_service.dart                # 用户服务（接口封装）
└── file_upload_service.dart         # 文件上传服务
                                     #   - 阿里云 OSS 上传
                                     #   - 图片/文件分业务类型上传
                                     #   - 上传进度回调
```

### Models 数据模型

```
models/
└── user_model.dart                  # 用户模型（本地缓存用）
```

### Routes 路由

```
routes/
├── app_routes.dart                  # 路由常量定义（splash/login/home/profile）
└── app_pages.dart                   # 路由页面绑定
```

### Utils 工具类

```
utils/
├── date_utils.dart                  # 日期工具（格式化/相对时间/比较）
└── validators.dart                  # 表单校验器（手机号/密码/验证码/昵称）
```

### Widgets 通用组件库

```
widgets/
├── buttons/
│   └── primary_button.dart          # 主按钮（品牌色/加载状态/禁用态）
├── cards/
│   └── app_card.dart                # 通用卡片（圆角/阴影/点击效果）
├── inputs/
│   └── app_input.dart               # 通用输入框（标签/校验/图标）
├── dialogs/
│   └── app_dialog.dart              # 通用对话框（确认/输入/选择/多种样式）
├── toast/
│   ├── app_toast.dart               # Toast 提示（成功/错误/信息）
│   └── nova_message.dart            # NovaMessage 消息提示（顶部弹出/自动消失）
├── common/
│   ├── empty_widget.dart            # 空状态占位组件
│   ├── loading_widget.dart          # 加载组件（骨架屏/转圈/列表加载态）
│   └── nova_refresh_header.dart     # 下拉刷新头部（品牌动画）
└── widgets.dart                     # 统一导出
```

### API & 资源

```
api/generated/ (1530+ 文件)          # OpenAPI Generator 自动生成
                                     #   - 与后端 Controller 一一对应的 API 类
                                     #   - 请求/响应 Model（与后端 DTO 对应）

assests/
├── fonts/ (24 文件)                  # 自定义字体
└── logo/
    └── logo.svg                     # 应用 Logo
```

### 入口文件

```
main.dart                            # 应用入口
                                     #   - TDesign 主题注入（自定义品牌色）
                                     #   - MaterialApp（浅色/深色双主题）
                                     #   - SplashPage（启动页 + 登录状态检查）
                                     #   - MainPage（底部 5 Tab 导航）
                                     #   - onGenerateRoute 命名路由处理
```

---

## 关键技术实现

### Token 安全管理

```
flutter_secure_storage 持久化 → Dio 拦截器自动注入
401 响应 → TokenRefreshInterceptor → 刷新 Token → 队列重放
刷新失败 → 自动登出回调
```

### SSE 流式 AI 对话

```
ai_chat_service → flutter_client_sse → 逐字渲染（Markdown）
                → 支持中断 / 多模型切换 / 知识库关联
```

### WebSocket 实时聊天

```
chat_websocket_service → STOMP/WebSocket → 私聊 + 群聊
                       → 消息本地缓存（SQLite）
                       → 消息同步服务（本地 ↔ 服务端）
                       → 自动重连
```

### 离线优先

```
消息收发 → SQLite 本地存储 → 同步服务拉取增量 → UI 展示
单词笔记 → daily_word_storage_service → 本地持久化
学习计划 → study_plan_repository → SQLite CRUD
```

### 主题系统

```
ThemeProvider(ChangeNotifier) → 浅色/深色/跟随系统
AppTheme → 语义色扩展（NovaColors）→ context.colors.xxx
TDesign Flutter → 品牌色自定义注入
```

---

## 快速开始

### 环境要求

- Flutter SDK ^3.10.1
- Android Studio / Xcode（对应平台）

### 安装依赖

```bash
flutter pub get
```

### 运行

```bash
# 调试运行
flutter run

# 指定设备
flutter run -d <device_id>
```

### 生成 API 客户端

```bash
flutter pub run build_runner build
```

生成的代码位于 `lib/api/generated/`。

### 构建发布

```bash
# Android APK
flutter build apk

# Android App Bundle
flutter build appbundle

# iOS
flutter build ios
```
