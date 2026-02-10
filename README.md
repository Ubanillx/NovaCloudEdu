<div align="center">

  <img src="logo.svg" alt="智云星课 Logo" width="120" height="120">

  # 智云星课 NovaCloudEdu

  **AI 驱动的智慧教育云平台**

  [![Java](https://img.shields.io/badge/Java-21-orange?logo=openjdk&logoColor=white)](https://openjdk.org/)
  [![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.5.8-green?logo=spring-boot&logoColor=white)](https://spring.io/projects/spring-boot)
  [![React](https://img.shields.io/badge/React-19.2-blue?logo=react&logoColor=white)](https://react.dev/)
  [![TypeScript](https://img.shields.io/badge/TypeScript-5.9-blue?logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
  [![Flutter](https://img.shields.io/badge/Flutter-3.10+-blue?logo=flutter&logoColor=white)](https://flutter.dev/)
  [![Langchain4j](https://img.shields.io/badge/Langchain4j-0.36.2-000000?logo=github&logoColor=white)](https://github.com/langchain4j/langchain4j)
  [![License](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](LICENSE)

  融合多模型 AI 助手、知识库、语音交互与智能推荐，为教育场景提供全方位智能化解决方案

  [文档](#) · [快速开始](#快速开始) · [功能特性](#核心功能) · [架构设计](#架构设计) · [贡献指南](#贡献指南)

</div>

---

## 目录

- [项目简介](#项目简介)
- [技术栈](#技术栈)
- [核心功能](#核心功能)
- [项目结构](#项目结构)
- [架构设计](#架构设计)
- [快速开始](#快速开始)
- [环境配置](#环境配置)
- [开发指南](#开发指南)
- [许可证](#许可证)

### 子项目文档

| 子项目 | 说明 | 文档 |
|:---|:---|:---:|
| **backend** | Spring Boot 后端服务（DDD 四层架构） | [📖 README](backend/README.md) |
| **web** | React Web 前端（用户端 + 管理后台） | [📖 README](web/README.md) |
| **app** | Flutter 移动端（Android + iOS） | [📖 README](app/README.md) |

---

## 项目简介

**智云星课** 是一款面向教育领域的智能化 SaaS 平台，支持多端访问（Web + 移动端），集成了课程管理、班级管理、电子书阅读、学习进度跟踪等核心教育功能，并通过 AI 智能助手、知识库和推荐系统提升学习体验。

### 产品亮点

| 特性 | 说明 |
|:---:|:---|
| **AI 赋能** | 集成 Langchain4j 多模型路由，支持通义千问/GPT/DeepSeek/Moonshot/智谱/SiliconFlow/Ollama 7 大提供商 |
| **多端同步** | React Web 用户端+管理后台 + Flutter 移动端（Android/iOS），数据实时同步 |
| **智能推荐** | 基于 Neo4j 知识图谱的个性化学习路径推荐 |
| **RAG 知识库** | 文档解析（PDF/EPUB/DOCX）→ 向量 Embedding → Rerank 检索增强 |
| **语音交互** | 阿里云 NLS 语音识别 (ASR) + 语音合成 (TTS)，WebSocket 实时转写 |
| **实时通信** | WebSocket + STOMP 私聊/群聊，已读回执，离线消息缓存 |
| **工作流引擎** | 可视化 DAG 编排，18 种节点（LLM/代码沙箱/HTTP/数据库等），Cron/Webhook 触发 |
| **AI 生成** | 文生图 + 文生视频能力 |
| **内容安全** | 书籍内容 AES 加密，守护知识产权 |

---

## 技术栈

### 前端技术

[![React](https://img.shields.io/badge/React-19.2-blue?logo=react&logoColor=white)](https://react.dev/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.9-blue?logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![Vite](https://img.shields.io/badge/Vite-7.2-purple?logo=vite&logoColor=white)](https://vitejs.dev/)
[![TailwindCSS](https://img.shields.io/badge/TailwindCSS-4.1-38bdf8?logo=tailwind-css&logoColor=white)](https://tailwindcss.com/)
[![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.10+-0175C2?logo=dart&logoColor=white)](https://dart.dev/)

```
┌─────────────────────────────────────────────────────────────┐
│                         前端层                               │
├─────────────────────┬───────────────────────────────────────┤
│  Web 前端           │  移动端 (Flutter)                      │
├─────────────────────┼───────────────────────────────────────┤
│  React 19.2         │  Flutter 3.10+ / Dart 3.10+           │
│  TypeScript 5.9     │  TDesign Flutter 组件库                │
│  Vite 7.2 (SWC)    │  Dio + Token 自动刷新拦截器             │
│  TailwindCSS 4.1    │  WebSocket + STOMP (实时聊天)          │
│  Zustand 状态管理   │  SSE 流式 AI 对话                      │
│  React Flow 工作流   │  sqflite 本地数据库 (离线缓存)        │
│  json-bigint 大数   │  flutter_secure_storage 安全存储       │
│  STOMP WebSocket    │  录音 ASR / TTS 语音播放               │
│  Lucide Icons       │  OpenAPI Generator 代码生成            │
│  OpenAPI Generator  │                                        │
└─────────────────────┴───────────────────────────────────────┘
```

### 后端技术

[![Java](https://img.shields.io/badge/Java-21-orange?logo=openjdk&logoColor=white)](https://openjdk.org/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.5.8-green?logo=spring-boot&logoColor=white)](https://spring.io/projects/spring-boot)
[![Spring Security](https://img.shields.io/badge/Spring%20Security-6.2-green?logo=spring-security&logoColor=white)](https://spring.io/projects/spring-security)
[![MyBatis](https://img.shields.io/badge/MyBatis%20Plus-3.5.5-red?logo=mybatis&logoColor=white)](https://baomidou.com/)
[![JWT](https://img.shields.io/badge/JWT-1.0-EF5350?logo=jsonwebtokens&logoColor=white)](https://jwt.io/)

```
┌─────────────────────────────────────────────────────────────┐
│                       后端服务层                             │
├─────────────────────────────────────────────────────────────┤
│  核心:       Java 21 + Spring Boot 3.5.8 (DDD 四层架构)     │
│  持久化:     MyBatis Plus 3.5.5 (69 PO / 68 Mapper)        │
│  安全:       Spring Security + JWT (jjwt 0.12.6)           │
│  AI:         Langchain4j 0.36.2 + DashScope SDK 2.16.7     │
│  工作流:     自研 DAG 引擎 (18 种节点 + 代码沙箱)           │
├─────────────────────────────────────────────────────────────┤
│  数据存储    │  PostgreSQL 15+ (主数据库, 19 张表)           │
│              │  Redis 7+ (缓存/会话/离线消息)                │
│              │  Elasticsearch 8+ (全文检索)                  │
│              │  Neo4j 5+ (知识图谱/推荐)                     │
├─────────────────────────────────────────────────────────────┤
│  外部服务    │  阿里云 OSS (文件存储)                        │
│              │  阿里云 NLS (语音 ASR/TTS)                    │
│              │  WebSocket + STOMP (实时通信)                 │
│              │  Docker Java + GraalJS (代码沙箱)             │
│              │  Selenium + Jsoup (网页爬虫)                  │
└─────────────────────────────────────────────────────────────┘
```

### 数据库 & 存储

[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15+-336791?logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Redis](https://img.shields.io/badge/Redis-7+-DC382D?logo=redis&logoColor=white)](https://redis.io/)
[![Elasticsearch](https://img.shields.io/badge/Elasticsearch-8+-005571?logo=elasticsearch&logoColor=white)](https://www.elastic.co/)
[![Neo4j](https://img.shields.io/badge/Neo4j-5+-008CC1?logo=neo4j&logoColor=white)](https://neo4j.com/)

### AI & 云服务

[![Langchain4j](https://img.shields.io/badge/Langchain4j-0.36.2-000000?logo=github&logoColor=white)](https://github.com/langchain4j/langchain4j)
[![Langchain4j Docs](https://img.shields.io/badge/Langchain4j-Docs-4285F4?logo=readthedocs&logoColor=white)](https://docs.langchain4j.dev)
[![阿里云](https://img.shields.io/badge/阿里云-DashScope%20SDK-FF6A00?logo=alibabacloud&logoColor=white)](https://www.aliyun.com/)
[![阿里云 OSS](https://img.shields.io/badge/阿里云%20OSS-对象存储-FF6A00?logo=alibabacloud&logoColor=white)](https://www.aliyun.com/product/oss)
[![阿里云 NLS](https://img.shields.io/badge/阿里云%20NLS-语音交互-FF6A00?logo=alibabacloud&logoColor=white)](https://ai.aliyun.com/nls)
[![WebSocket](https://img.shields.io/badge/WebSocket-实时通信-010101?logo=websocket&logoColor=white)](https://websocket.org/)
---

## 核心功能

### AI 智能化

| 模块 | 功能描述 |
|:---|:---|
| **AI 智能助手** | Langchain4j 多模型路由（通义千问/GPT/DeepSeek/Moonshot/智谱/SiliconFlow/Ollama），SSE 流式对话，支持文本与视觉理解 |
| **RAG 知识库** | 文档解析（PDF/EPUB/DOCX）→ 向量 Embedding → Rerank → 相似度检索增强生成 |
| **文生图/文生视频** | AI 图片/视频生成，异步任务状态追踪 |
| **语音交互** | 阿里云 NLS 语音识别 (ASR) + 语音合成 (TTS)，WebSocket 实时转写 |
| **智能总结** | 文档自动摘要、知识点提取、测试题生成 |
| **推荐系统** | 基于 Neo4j 知识图谱的个性化学习路径推荐 |

### 教育管理

| 模块 | 功能描述 |
|:---|:---|
| **用户管理** | 学生/教师/管理员角色，手机号+短信验证码注册登录，JWT Token 自动刷新 |
| **课程管理** | 课程创建/发布，课程表（周视图/编辑/排期），任务列表 |
| **每日学习** | 每日单词（7 级别词库/发音/笔记/生词本）、每日文章（分类/收藏/AI 文章对话） |
| **电子书** | PDF/EPUB/DOCX 解析，AES 内容加密，阅读进度同步 |
| **公告系统** | 公告发布/管理、Banner 轮播图管理 |

### 社交与互动

| 模块 | 功能描述 |
|:---|:---|
| **实时聊天** | WebSocket + STOMP 私聊/群聊，已读回执，消息类型（文本/图片/文件/音频/视频），离线消息 SQLite 缓存 |
| **学习圈子** | 帖子发布/编辑/详情，评论/回复/点赞/收藏，用户主页/关注/粉丝，搜索 |
| **签到系统** | 每日签到打卡，日/周/月排行榜，学习习惯养成 |
| **反馈系统** | 分类反馈提交，对话式回复，状态跟踪 |

### 管理后台

| 模块 | 功能描述 |
|:---|:---|
| **工作流引擎** | 可视化 DAG 编排（React Flow），18 种节点执行器（LLM/代码沙箱/HTTP/数据库/条件/循环等），Cron/Webhook/手动触发，版本管理，模板画廊 |
| **AI 助手管理** | 助手配置/模型选择/系统提示词/知识库关联 |
| **知识库管理** | 文档上传/向量化进度/文档列表/知识库 CRUD |
| **爬虫系统** | 网页爬虫规则配置（CSS 选择器/分页策略/代理），任务调度与监控，Selenium + Jsoup |
| **内容管理** | 用户/公告/轮播图/帖子/反馈/每日单词/每日文章 管理 |

---

## 项目结构

```
NovaCloudEdu/
│
├── 📁 backend/                      # Spring Boot 后端服务 (DDD 四层架构)
│   ├── src/main/java/.../backend/
│   │   ├── interfaces/rest/         #   接口层 — 22 个 REST 模块
│   │   │   ├── ai/                  #     AI 对话/知识库/助手/语音/爬虫 (7 Controller)
│   │   │   ├── auth/                #     认证/注册/Token (3 Controller)
│   │   │   ├── chat/                #     私聊/群聊/好友/群组 (4 Controller)
│   │   │   ├── daily/               #     每日单词/每日文章 (2 Controller)
│   │   │   └── ...                  #     课程/电子书/公告/帖子/反馈/签到/课表等
│   │   ├── application/             #   应用层 — 19 个 ApplicationService
│   │   │   ├── service/             #     业务编排 + Command/Query 参数
│   │   │   └── assembler/           #     DTO ↔ Command 转换
│   │   ├── domain/                  #   领域层 — 22 个领域模块
│   │   │   ├── ai/ chat/ course/    #     Entity + ValueObject + Repository 接口
│   │   │   └── workflow/ ebook/ ... #     DomainService
│   │   ├── infrastructure/          #   基础设施层
│   │   │   ├── ai/                  #     AI 多模型路由 (12 个类)
│   │   │   ├── persistence/         #     数据持久化 (69 PO / 68 Mapper / 55 Repository)
│   │   │   ├── workflow/            #     工作流引擎 (18 种节点执行器 + 代码沙箱)
│   │   │   ├── websocket/           #     WebSocket + STOMP (实时通信)
│   │   │   ├── neo4j/               #     知识图谱
│   │   │   └── security/            #     JWT 认证 (5 个类)
│   │   └── config/                  #   配置类 (16 个)
│   ├── sql/                         #   数据库 SQL 脚本 (19 张表)
│   └── pom.xml
│
├── 📁 web/                          # React Web 前端 (用户端 + 管理后台)
│   ├── src/
│   │   ├── pages/                   #   页面
│   │   │   ├── LoginPage / RegisterPage    # 登录/注册
│   │   │   ├── ChatPage / CirclePage / ... # 用户端 (AI 对话/圈子/单词/文章/课表等)
│   │   │   └── admin/               #     管理后台 (14 个管理页面)
│   │   │       └── workflow/        #       工作流可视化编辑器 (React Flow)
│   │   ├── components/              #   组件
│   │   │   ├── layout/              #     布局 (AdminLayout/Header/Sider/Footer)
│   │   │   ├── chat/                #     聊天 (AI 面板/私聊/群聊/消息渲染/useAiChat)
│   │   │   ├── home/                #     首页 (Banner/公告/单词/文章/课表/统计)
│   │   │   └── ui/                  #     UI 基础 (Toast/Tooltip/Avatar/RegionPicker)
│   │   ├── context/                 #   状态管理 (Chat/Sider/Theme Context)
│   │   ├── api/                     #   API 层
│   │   │   ├── index.ts             #     Axios + json-bigint + Token 自动刷新
│   │   │   ├── websocket.ts         #     STOMP WebSocket 服务 (单例)
│   │   │   └── generated/ (800+)    #     OpenAPI 自动生成
│   │   └── hooks/                   #   自定义 Hooks (useCache)
│   └── package.json
│
├── 📁 app/                          # Flutter 移动端 (Android + iOS)
│   ├── lib/
│   │   ├── features/                #   功能模块 (7 个)
│   │   │   ├── auth/                #     认证 (登录/注册/Token 安全存储)
│   │   │   ├── home/                #     首页 + 每日单词(笔记/生词本) + 每日文章(AI 对话)
│   │   │   ├── chat/                #     对话 (11 页面 + 13 服务 + 2 组件)
│   │   │   │   ├── pages/           #       AI 对话/私聊/群聊/好友/群组/搜索
│   │   │   │   └── services/        #       WebSocket/SQLite 缓存/消息同步/音频/通知
│   │   │   ├── circle/              #     学习圈子 (帖子/评论/关注/收藏/搜索)
│   │   │   ├── course/              #     课程 (列表/课表/编辑/任务)
│   │   │   └── profile/             #     个人中心 (信息/签到/反馈/学习计划/设置)
│   │   ├── core/                    #   核心层
│   │   │   ├── network/             #     Dio + Token 刷新拦截器 (并发安全)
│   │   │   ├── database/            #     SQLite (私聊/群聊/学习计划表)
│   │   │   └── theme/               #     主题 (浅色/深色/跟随系统)
│   │   ├── widgets/                 #   通用组件 (按钮/卡片/输入/对话框/Toast/加载态)
│   │   ├── services/                #   服务层 (认证/用户/文件上传)
│   │   ├── api/generated/ (1530+)   #   OpenAPI 自动生成
│   │   └── config/                  #   配置 (环境/主题/ThemeProvider)
│   └── pubspec.yaml
│
├── 📁 english-vocabulary/           # 英语词库资源 (初中~SAT 共 7 级别)
│   ├── json/ (7 文件)               #   顺序 JSON 词库 (初中/高中/CET4/CET6/考研/托福/SAT)
│   ├── json_original/               #   原始多版本 JSON (full/sentence/simple)
│   ├── 乱序sql/ (7 文件)            #   PostgreSQL 导入脚本
│   ├── convert_json_to_pgsql.py     #   JSON → SQL 转换工具
│   └── fetch_audio_urls.py          #   发音 URL 抓取工具
│
├── 📄 logo.svg                      # 项目 Logo
├── 📄 README.md                     # 项目文档
└── 📄 LICENSE                       # CC BY-NC-SA 4.0 许可证
```

> 📖 各子目录下均有独立的 `README.md`，包含更详细的架构说明和文件级注释。

---

## 架构设计

### DDD 四层架构

本项目采用 **领域驱动设计 (DDD)** 架构，确保业务逻辑与技术实现清晰分离。

```
┌─────────────────────────────────────────────────────────────┐
│                    Interfaces 接口层                         │
│  处理 HTTP 请求、参数校验、DTO 转换                          │
│  ┌───────────┐  ┌───────────┐  ┌───────────────────┐       │
│  │Controller │  │   DTO     │  │    Assembler      │       │
│  └─────┬─────┘  └───────────┘  └───────────────────┘       │
└────────┼────────────────────────────────────────────────────┘
         │ 调用
┌────────▼────────────────────────────────────────────────────┐
│                   Application 应用层                         │
│  业务流程编排、事务管理、权限控制                             │
│  ┌───────────────────┐  ┌───────────┐  ┌─────────────┐     │
│  │ApplicationService │  │  Command  │  │    Query    │     │
│  └─────────┬─────────┘  └───────────┘  └─────────────┘     │
└────────────┼────────────────────────────────────────────────┘
             │ 调用
┌────────────▼────────────────────────────────────────────────┐
│                      Domain 领域层                           │
│  核心业务逻辑、领域模型、业务规则（无框架依赖）                │
│  ┌──────────┐  ┌─────────────┐  ┌─────────────────────┐    │
│  │  Entity  │  │ ValueObject │  │ Repository (接口)    │    │
│  └──────────┘  └─────────────┘  └─────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
             ▲ 实现
┌────────────┴────────────────────────────────────────────────┐
│                Infrastructure 基础设施层                      │
│  数据持久化、外部服务、技术支撑                               │
│  ┌──────────┐  ┌─────────────┐  ┌─────────────────────┐    │
│  │  Mapper  │  │     PO      │  │ Repository (实现)    │    │
│  └──────────┘  └─────────────┘  └─────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
```

### 各层职责

| 层级 | 职责 | 规模 | 依赖方向 |
|:---:|:---|:---|:---:|
| **Interfaces** | HTTP 请求处理、参数校验、DTO 转换 | 22 个 REST 模块 | → Application |
| **Application** | 业务流程编排、事务管理、权限控制 | 19 个 ApplicationService | → Domain |
| **Domain** | 核心业务逻辑、领域模型、业务规则 | 22 个领域模块 | 无外部依赖 |
| **Infrastructure** | 数据持久化、外部服务调用、技术支撑 | 69 PO / 68 Mapper / 55 Repository | → Domain |

### 系统架构

```
┌──────────────┐  ┌──────────────┐
│  React Web   │  │ Flutter App  │
│  (用户端+后台) │  │ (Android/iOS)│
└──────┬───────┘  └──────┬───────┘
       │  HTTP/SSE        │  HTTP/SSE
       │  WebSocket        │  WebSocket
       └────────┬─────────┘
                │
       ┌────────▼────────┐
       │   Nginx / LB    │
       └────────┬────────┘
                │
       ┌────────▼────────────────────────────────────┐
       │           Spring Boot 后端                    │
       ├──────────────────────────────────────────────┤
       │  REST API  │  WebSocket/STOMP  │  SSE 流式   │
       ├──────────────────────────────────────────────┤
       │  DDD 四层   │  工作流引擎  │  AI 多模型路由   │
       └───┬─────┬──────┬───────┬───────┬────────────┘
           │     │      │       │       │
     ┌─────▼┐ ┌─▼───┐ ┌▼────┐ ┌▼────┐ ┌▼──────────┐
     │Postgre│ │Redis│ │ ES  │ │Neo4j│ │ 阿里云     │
     │ SQL   │ │     │ │     │ │     │ │OSS/NLS/AI │
     └───────┘ └─────┘ └─────┘ └─────┘ └───────────┘
```

### 数据流转

```
HTTP Request
     │
     ▼
┌─────────────────┐
│   Controller    │ ←── 接收请求，参数校验
└────────┬────────┘
         │ Request DTO
         ▼
┌─────────────────┐
│   Assembler     │ ←── DTO → Command 转换
└────────┬────────┘
         │ Command
         ▼
┌─────────────────┐
│ AppService      │ ←── 编排用例流程
└────────┬────────┘
         │ 调用领域对象
         ▼
┌─────────────────┐
│ Domain Entity   │ ←── 执行业务逻辑
└────────┬────────┘
         │ Repository 接口
         ▼
┌─────────────────┐
│ RepositoryImpl  │ ←── 数据持久化
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│    Database     │
└─────────────────┘
```

### API 通信方式

| 通信方式 | 用途 | 技术实现 |
|:---|:---|:---|
| **REST API** | 标准 CRUD 操作 | Axios (Web) / Dio (Flutter) + OpenAPI Generator 自动生成客户端 |
| **SSE** | AI 流式对话 | fetch EventSource (Web) / flutter_client_sse (Flutter) |
| **WebSocket** | 实时聊天/通知 | @stomp/stompjs (Web) / stomp_dart_client (Flutter)，STOMP 协议 |
| **Token 管理** | 身份认证 | JWT + 自动刷新拦截器（并发 401 请求队列），Web 用 localStorage / Flutter 用 flutter_secure_storage |
| **大数处理** | 雪花 ID 精度 | Web 端 json-bigint（storeAsString），所有 ID 运行时为字符串 |

---

## 快速开始

### 前置要求

| 组件 | 版本要求 | 用途 |
|:---:|:---|:---|
| JDK | 21+ | 后端运行环境 |
| Maven | 3.9+ | 后端构建 |
| Node.js | 18+ | Web 前端构建 |
| Flutter | 3.10+ | 移动端开发 |
| PostgreSQL | 15+ | 主数据库 |
| Redis | 7+ | 缓存/会话/离线消息 |
| Elasticsearch | 8+ | 全文检索（可选） |
| Neo4j | 5+ | 知识图谱（可选） |

### 1. 后端启动

```bash
# 进入后端目录
cd backend

# 复制并编辑配置文件
cp src/main/resources/application-dev.example.yml src/main/resources/application-dev.yml
# 编辑 application-dev.yml，填入数据库、Redis、Neo4j、阿里云等配置

# 初始化数据库（PostgreSQL）
psql -U postgres -d NovaCloudEdu -f sql/init.sql

# 启动服务（Maven）
mvn spring-boot:run

# 访问 Swagger API 文档
# http://localhost:8080/swagger-ui.html
```

### 2. Web 前端启动

```bash
# 进入前端目录
cd web

# 安装依赖
npm install

# 生成 API 客户端（需后端已启动）
npm run openapi:generate

# 启动开发服务器
npm run dev

# 访问应用
# http://localhost:5173
# 管理后台: 使用 admin 角色账户登录后自动跳转 /admin
```

### 3. 移动端启动

```bash
# 进入移动端目录
cd app

# 获取依赖
flutter pub get

# 生成 API 客户端
flutter pub run build_runner build

# 运行应用
flutter run

# 构建发布版本
flutter build apk      # Android
flutter build ios       # iOS
```

> **注意**：Flutter 开发时，Android 模拟器自动使用 `10.0.2.2` 访问宿主机，iOS/桌面端使用 `localhost`，无需手动配置。

---

## 环境配置

### 后端配置

后端使用 Spring Profiles 管理多环境配置：

| 配置文件 | 说明 |
|:---|:---|
| `application.yml` | 公共配置（JWT 密钥/过期时间、MyBatis-Plus、SpringDoc、文件上传等） |
| `application-dev.yml` | 开发环境（从 `application-dev.example.yml` 复制，需填入实际密钥） |
| `application-prod.yml` | 生产环境 |

### 关键配置项

| 配置项 | 说明 | 必须 |
|:---|:---|:---:|
| `spring.datasource` | PostgreSQL 数据库连接 | ✅ |
| `spring.data.redis` | Redis 缓存连接 | ✅ |
| `spring.elasticsearch` | Elasticsearch 全文检索连接 | ⬜ |
| `spring.neo4j` | Neo4j 知识图谱连接 | ⬜ |
| `aliyun.oss` | 阿里云 OSS 对象存储（AccessKey/Bucket/Endpoint） | ✅ |
| `aliyun.nls` | 阿里云 NLS 语音交互（AppKey/Token） | ⬜ |
| `ai.dashscope` | 阿里云 DashScope 大模型 API Key | ✅ |
| `ai.chat-models.providers` | Langchain4j 多模型路由（DashScope/OpenAI/DeepSeek/Moonshot/智谱/SiliconFlow/Ollama） | ⬜ |
| `ai.rag` | RAG 检索增强生成配置 | ⬜ |
| `sms` | 短信验证码配置 | ⬜ |
| `book.content.encryption` | 书籍内容 AES 加密密钥 | ⬜ |

> ✅ = 核心启动必须，⬜ = 按需配置（不配置对应功能不可用）
>
> 详见 `backend/src/main/resources/application-dev.example.yml`

### 前端配置

| 项目 | 配置方式 | 说明 |
|:---|:---|:---|
| **Web** | `.env` / `vite.config.ts` | `VITE_API_BASE_URL` 指向后端地址（默认 `http://localhost:8080`） |
| **Flutter** | `lib/config/env_config.dart` | `EnvConfig.apiBaseUrl`，自动适配 Android/iOS 模拟器地址 |

---

## 开发指南

### OpenAPI 代码生成

本项目使用 **OpenAPI Generator** 从后端 Swagger 接口自动生成前端 API 客户端，确保前后端接口类型一致。

| 端 | 生成器 | 生成命令 | 输出目录 |
|:---|:---|:---|:---|
| **Web** | typescript-axios | `npm run openapi:generate` | `web/src/api/generated/` |
| **Flutter** | dart-dio | `flutter pub run build_runner build` | `app/lib/api/generated/` |

### 数据库脚本

所有 SQL 建表脚本位于 `backend/sql/`，包含 19 张表：

| 分类 | 表 |
|:---|:---|
| **用户/认证** | user、user_checkin |
| **AI** | ai_assistant、ai_chat_session、ai_chat、knowledge_base、knowledge_base_document |
| **社交** | friend、chat_group、chat_group_member、private_message、group_message |
| **内容** | announcement、banner、post、feedback |
| **学习** | daily_word、daily_article、course_schedule |

---

## 许可证

本项目采用 **CC BY-NC-SA 4.0** (署名-非商业性使用-相同方式共享) 许可证。

```
Creative Commons BY-NC-SA 4.0

您可以：
  • 分享 — 复制和转载本项目的材料
  * 修改 — 混合、转换和基于本材料进行构建

须遵守以下条件：
  • 署名 — 您必须提供适当的版权声明和许可证链接
  • 非商业 — 禁止将本项目用于任何商业目的
  • 相同方式共享 — 若您修改本项目，必须使用相同的许可证分发
```

> ⚠️ **商业合作请联系**: longxin_liu@qq.com

---

## 联系我们
- **微信**: Ubanillx
- **微信公众号**: 智云星课

---

<div align="center">

  **⭐ 如果觉得这个项目有帮助，请给我们一个 Star！**

  Made with ❤️ by NovaCloudEdu Team


</div>
