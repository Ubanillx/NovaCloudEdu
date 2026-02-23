# NovaCloudEdu App

智云星课 Flutter 移动端应用，支持 Android 与 iOS 双平台。

底部五大 Tab 导航：**首页 / 课程 / 圈子 / 对话 / 我的**，包含 AI 智能对话、社交聊天、每日学习、智能批改、PPT 生成、会员权益等功能。

---

## 技术栈

| 分类 | 技术 | 版本 | 用途 |
|:---|:---|:---|:---|
| **框架** | Flutter | 3.10+ | 跨平台移动应用框架 |
| **语言** | Dart | 3.10+ | 应用开发语言 |
| **UI 组件** | TDesign Flutter | 0.2.6 | 腾讯 TDesign 组件库 |
| **状态管理** | Provider | 6.0+ | 状态管理（主题/认证） |
| **网络** | Dio | 5.9 | HTTP 客户端 |
| **实时通信** | web_socket_channel | 3.0 | WebSocket 连接 |
| | stomp_dart_client | 2.0 | STOMP 协议聊天 |
| **SSE** | flutter_client_sse | 2.0 | 服务端推送事件（AI 流式） |
| **安全存储** | flutter_secure_storage | 10.0 | Token 安全存储 |
| **本地数据库** | sqflite | 2.3+ | SQLite 消息缓存 |
| **Markdown** | markdown_widget | 2.3+ | Markdown 渲染 |
| **录音/播放** | record | 6.0+ | 录音（ASR） |
| | audioplayers | 6.1+ | 音频播放（TTS） |
| **音视频** | flutter_webrtc | 0.10+ | WebRTC 音视频通话 |
| **文件选择** | file_picker | 8.1+ | 文件选择 |
| | image_picker | 1.0+ | 图片选择 |
| | image_cropper | 8.0+ | 图片裁剪 |
| **权限管理** | permission_handler | 11.3+ | 权限请求 |
| **图片缓存** | cached_network_image | 3.4+ | 图片缓存 |
| **文件预览** | open_filex | 4.5+ | 文件预览 |
| | url_launcher | 6.2+ | 链接跳转 |
| **下拉刷新** | easy_refresh | 3.4+ | 下拉刷新 |
| **OCR** | google_mlkit_text_recognition | 0.14+ | 文字识别 |
| **地区选择** | city_pickers | 1.3+ | 城市选择器 |
| **路径工具** | path_provider | 2.1+ | 文件路径获取 |
| **SVG** | flutter_svg | 2.0+ | SVG 图片支持 |
| **图标** | phosphor_flutter | 2.1+ | 图标库 |
| **API 生成** | OpenAPI Generator | 6.1+ | API 代码生成 |

---

## 功能模块

| 模块 | 功能描述 |
|:---|:---|
| **认证** | 手机号/密码登录、短信验证码注册、Token 自动刷新、安全存储 |
| **首页** | Banner 轮播、公告列表/详情、每日单词/文章、课程表卡片、学习统计 |
| **每日单词** | 单词列表（7级别筛选/搜索/分页）、单词详情、生词本、学习笔记 |
| **每日文章** | 文章列表（分类筛选/搜索）、文章详情、AI 文章对话（SSE 流式） |
| **课程** | 课程列表/详情、课程表（周视图/编辑/新增）、任务列表 |
| **AI 对话** | 多模型智能对话、SSE 流式响应、语音交互、知识库问答、文件上传 |
| **社交聊天** | 私聊/群聊（WebSocket + STOMP）、好友管理、群组管理、消息同步 |
| **音视频通话** | WebRTC 一对一通话、实时信令、静音/挂断/摄像头切换 |
| **学习圈子** | 帖子发布/编辑、评论/回复、点赞/收藏、用户主页、关注/粉丝 |
| **智能批改** | 拍照批改、OCR 识别、AI 流式批改、知识点标注、错题推荐 |
| **PPT 生成** | AI 大纲生成、内容生成、模板选择、OnlyOffice 在线编辑 |
| **会员权益** | 会员套餐购买、AI 额度查看、会员中心、配额使用统计 |
| **个人中心** | 个人信息编辑、签到打卡/排行榜、反馈管理、学习计划、主题切换 |

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
```

---

## 项目结构

### Features 功能模块

```
lib/features/
├── auth/                            # 认证模块
│   ├── pages/                       #   登录页、注册页
│   ├── controllers/                 #   认证控制器
│   └── services/                    #   认证服务
│
├── home/                            # 首页模块
│   ├── pages/                       #   首页、公告列表、公告详情
│   ├── controllers/                 #   首页控制器
│   ├── daily_word/                 #   每日单词（列表/详情/生词本/笔记）
│   └── daily_article/               #   每日文章（列表/详情/AI对话）
│
├── course/                          # 课程模块
│   ├── pages/                       #   课程列表、课程表、任务列表
│   └── services/                    #   课程服务
│
├── chat/                            # 对话模块（11 页面 + 13 服务）
│   ├── pages/                       #   AI对话、私聊、群聊、好友、通话等
│   ├── services/                    #   WebSocket、消息同步、音频、通知等
│   └── widgets/                     #   聊天输入栏、消息渲染
│
├── circle/                          # 学习圈子模块
│   ├── pages/                       #   圈子、帖子、用户主页
│   └── services/                    #   帖子服务
│
├── profile/                         # 个人中心模块
│   ├── pages/                       #   个人信息、设置、签到、反馈等
│   └── services/                    #   签到、反馈服务
│
├── grading/                         # 智能批改模块
│   └── pages/                       #   作业批改、试卷批改
│
├── ppt/                             # PPT 生成模块
│   └── pages/                       #   PPT 生成、编辑
│
├── membership/                      # 会员权益模块
│   ├── pages/                       #   会员中心、权益卡片
│   ├── services/                    #   会员服务
│   └── widgets/                     #   会员卡片、额度对话框
│
└── data/                            # Mock 数据
```

### Core 核心层

```
lib/core/
├── network/                         # 网络层
│   ├── api_client.dart              #   API 客户端单例（Dio + OpenAPI）
│   └── token_refresh_interceptor.dart # Token 自动刷新拦截器
│
├── database/                        # SQLite 数据库
│   ├── database_service.dart        #   数据库服务
│   ├── models/                      #   数据模型
│   └── repositories/                #   数据仓储
│
├── storage/                         # 本地存储封装
├── theme/                           # 主题配置
└── constants/                       # 应用常量
```

### Config 配置

```
lib/config/
├── app_config.dart                  # 应用环境配置
├── env_config.dart                  # 环境参数（API 地址）
├── app_theme.dart                   # 完整主题定义
└── theme_provider.dart              # 主题 Provider（浅色/深色/跟随系统）
```

### Services 服务层

```
lib/services/
├── auth_service.dart                # 认证服务
├── user_service.dart                # 用户服务
└── file_upload_service.dart         # 文件上传服务（阿里云 OSS）
```

### Widgets 通用组件

```
lib/widgets/
├── buttons/                         # 按钮组件
├── cards/                           # 卡片组件
├── inputs/                          # 输入组件
├── dialogs/                         # 对话框组件
├── toast/                           # Toast 提示
└── common/                          # 通用组件（空状态、加载态等）
```

### API & 资源

```
lib/api/generated/                   # OpenAPI 自动生成（1530+ 文件）
assets/
├── fonts/                           # 自定义字体
└── logo/                            # 应用 Logo
```

---

## 关键技术实现

### Token 安全管理

```
flutter_secure_storage 持久化
    ↓
Dio 拦截器自动注入 Token
    ↓
401 响应 → TokenRefreshInterceptor 刷新 Token
    ↓
请求队列重放（并发 401 只刷新一次）
    ↓
刷新失败 → 自动登出
```

### SSE 流式 AI 对话

```
ai_chat_service
    ↓
flutter_client_sse 建立 SSE 连接
    ↓
逐字渲染（Markdown）
    ↓
支持中断 / 多模型切换 / 知识库关联
```

### WebSocket 实时聊天

```
chat_websocket_service
    ↓
STOMP/WebSocket 连接
    ↓
私聊 + 群聊消息收发
    ↓
SQLite 本地缓存
    ↓
消息同步服务（本地 ↔ 服务端）
    ↓
自动重连
```

### WebRTC 音视频通话

```
CallService + RtcSignalingService
    ↓
WebRTC 建立点对点连接
    ↓
实时音视频流传输
    ↓
静音/挂断/摄像头切换
```

### 离线优先

```
消息收发 → SQLite 本地存储
    ↓
同步服务拉取增量
    ↓
UI 展示
```

### 主题系统

```
ThemeProvider(ChangeNotifier)
    ↓
浅色 / 深色 / 跟随系统
    ↓
AppTheme 语义色扩展
    ↓
TDesign Flutter 品牌色注入
```

---

## 快速开始

### 环境要求

- Flutter SDK 3.10+
- Android Studio / Xcode
- iOS 设备需要 macOS + Xcode

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

# Android 模拟器自动使用 10.0.2.2 访问宿主机
# iOS/桌面端使用 localhost
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

---

## 设计文档

| 文档 | 说明 |
|:---|:---|
| [会员系统设计](docs/membership-system-design.md) | 会员权益系统完整设计 |
| [会员系统实现](docs/membership-flutter-implementation.md) | Flutter 端会员实现方案 |
