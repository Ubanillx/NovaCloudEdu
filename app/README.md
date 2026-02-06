# NovaCloudEdu App

智云星课 Flutter 移动端应用，支持 Android 与 iOS 双平台。

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
| **API 生成** | OpenAPI Generator (Dart/Dio) | 6.1 |

## 项目结构

```
lib/
├── features/                        # 功能模块
│   ├── auth/                        #   认证（登录/注册）
│   ├── home/                        #   首页
│   ├── course/                      #   课程
│   ├── chat/                        #   AI 智能对话
│   ├── circle/                      #   学习圈子/社区
│   ├── profile/                     #   个人中心
│   └── data/                        #   数据/学习统计
│
├── core/                            # 核心层
│   ├── network/                     #   网络请求封装
│   ├── storage/                     #   本地存储
│   ├── database/                    #   SQLite 数据库
│   ├── theme/                       #   主题配置
│   └── constants/                   #   常量定义
│
├── models/                          # 数据模型
├── services/                        # 服务层（业务逻辑）
├── routes/                          # 路由配置
├── utils/                           # 工具类
│
├── widgets/                         # 通用组件库
│   ├── buttons/                     #   按钮组件
│   ├── cards/                       #   卡片组件
│   ├── dialogs/                     #   对话框组件
│   ├── inputs/                      #   输入框组件
│   ├── toast/                       #   Toast 提示
│   └── common/                      #   其他通用组件
│
├── api/generated/                   # OpenAPI Generator 自动生成的 API 客户端
├── assests/                         # 资源文件（字体/Logo/图标）
├── config/                          # 应用配置
└── main.dart                        # 应用入口
```

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
