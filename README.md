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
  [![zread](https://img.shields.io/badge/Ask_Zread-_.svg?style=flat-square&color=00b0aa&labelColor=000000&logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPHN2ZyB3aWR0aD0iMTYiIGhlaWdodD0iMTYiIHZpZXdCb3g9IjAgMCAxNiAxNiIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTQuOTYxNTYgMS42MDAxSDIuMjQxNTZDMS44ODgxIDEuNjAwMSAxLjYwMTU2IDEuODg2NjQgMS42MDE1NiAyLjI0MDFWNC45NjAxQzEuNjAxNTYgNS4zMTM1NiAxLjg4ODEgNS42MDAxIDIuMjQxNTYgNS42MDAxSDQuOTYxNTZDNS4zMTUwMiA1LjYwMDEgNS42MDE1NiA1LjMxMzU2IDUuNjAxNTYgNC45NjAxVjIuMjQwMUM1LjYwMTU2IDEuODg2NjQgNS4zMTUwMiAxLjYwMDEgNC45NjE1NiAxLjYwMDFaIiBmaWxsPSIjZmZmIi8%2BCjxwYXRoIGQ9Ik00Ljk2MTU2IDEwLjM5OTlIMi4yNDE1NkMxLjg4ODEgMTAuMzk5OSAxLjYwMTU2IDEwLjY4NjQgMS42MDE1NiAxMS4wMzk5VjEzLjc1OTlDMS42MDE1NiAxNC4xMTM0IDEuODg4MSAxNC4zOTk5IDIuMjQxNTYgMTQuMzk5OUg0Ljk2MTU2QzUuMzE1MDIgMTQuMzk5OSA1LjYwMTU2IDE0LjExMzQgNS42MDE1NiAxMy43NTk5VjExLjAzOTlDNS42MDE1NiAxMC42ODY0IDUuMzE1MDIgMTAuMzk5OSA0Ljk2MTU2IDEwLjM5OTlaIiBmaWxsPSIjZmZmIi8%2BCjxwYXRoIGQ9Ik0xMy43NTg0IDEuNjAwMUgxMS4wMzg0QzEwLjY4NSAxLjYwMDEgMTAuMzk4NCAxLjg4NjY0IDEwLjM5ODQgMi4yNDAxVjQuOTYwMUMxMC4zOTg0IDUuMzEzNTYgMTAuNjg1IDUuNjAwMSAxMS4wMzg0IDUuNjAwMUgxMy43NTg0QzE0LjExMTkgNS42MDAxIDE0LjM5ODQgNS4zMTM1NiAxNC4zOTg0IDQuOTYwMVYyLjI0MDFDMTQuMzk4NCAxLjg4NjY0IDE0LjExMTkgMS42MDAxIDEzLjc1ODQgMS42MDAxWiIgZmlsbD0iI2ZmZiIvPgo8cGF0aCBkPSJNNCAxMkwxMiA0TDQgMTJaIiBmaWxsPSIjZmZmIi8%2BCjxwYXRoIGQ9Ik00IDEyTDEyIDQiIHN0cm9rZT0iI2ZmZiIgc3Ryb2tlLXdpZHRoPSIxLjUiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIvPgo8L3N2Zz4K&logoColor=ffffff)](https://zread.ai/rowboatlabs/rowboat)

  [功能文档](docs/wiki/Home.md) · [快速开始](#快速开始) · [架构设计](#架构设计)

  ![主页预览](assets/web/user/web端首页-主体预览.png)

</div>

---

## 目录

- [技术栈](#技术栈)
- [核心功能](#核心功能)
- [项目结构](#项目结构)
- [架构设计](#架构设计)
- [快速开始](#快速开始)
- [文档中心](#文档中心)

### 子项目文档

| 子项目 | 说明 | 文档 |
|:---|:---|:---:|
| **backend** | Spring Boot 后端服务（DDD 四层架构） | [📖 README](backend/README.md) |
| **web** | React Web 前端（用户端 + 管理后台） | [📖 README](web/README.md) |
| **app** | Flutter 移动端（Android + iOS） | [📖 README](app/README.md) |

---

## 技术栈

### 前端技术

| 技术 | 版本 | 用途 |
|:---|:---:|:---|
| **React** | 19.2 | Web 用户端 + 管理后台 |
| **TypeScript** | 5.9 | 类型安全 |
| **Vite** | 7.2 | 构建工具 (SWC) |
| **TailwindCSS** | 4.1 | 原子化 CSS |
| **Flutter** | 3.10+ | 移动端 (Android/iOS) |
| **Dart** | 3.10+ | Flutter 语言 |

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
│  Zustand 状态管理   │  sqflite 本地数据库 (离线缓存)        │
│  React Flow 工作流   │  flutter_secure_storage 安全存储       │
│  json-bigint 大数   │  SSE 流式 AI 对话                      │
└─────────────────────┴───────────────────────────────────────┘
```

### 后端技术

| 技术 | 版本 | 用途 |
|:---|:---:|:---|
| **Java** | 21 | 后端语言 |
| **Spring Boot** | 3.5.8 | 应用框架 |
| **Spring Security** | 6.2 | 安全认证 |
| **MyBatis Plus** | 3.5.5 | ORM 框架 |
| **Langchain4j** | 0.36.2 | AI 集成 |

```
┌─────────────────────────────────────────────────────────────┐
│                       后端服务层                             │
├─────────────────────────────────────────────────────────────┤
│  核心:       Java 21 + Spring Boot 3.5.8 (DDD 四层架构)     │
│  持久化:     MyBatis Plus 3.5.5 (80+ PO / 80+ Mapper)      │
│  安全:       Spring Security + JWT (jjwt 0.12.6)           │
│  AI:         Langchain4j 0.36.2 + DashScope SDK 2.16.7     │
│  工作流:     自研 DAG 引擎 (18 种节点 + 代码沙箱)           │
│  微服务:     Python-PPTX (PPT生成) + Typst (试卷排版)      │
├─────────────────────────────────────────────────────────────┤
│  数据存储    │  PostgreSQL 15+ (主数据库, 31 张表)           │
│              │  Redis 7+ (缓存/会话/离线消息)                │
│              │  Elasticsearch 8+ (全文检索)                  │
│              │  Neo4j 5+ (知识图谱/推荐)                     │
├─────────────────────────────────────────────────────────────┤
│  外部服务    │  阿里云 OSS (文件存储)                        │
│              │  阿里云 NLS (语音 ASR/TTS)                    │
│              │  WebSocket + STOMP (实时通信)                 │
│              │  Docker Java + GraalJS (代码沙箱)             │
└─────────────────────────────────────────────────────────────┘
```

### 数据库 & 存储

| 技术 | 版本 | 用途 |
|:---|:---:|:---|
| **PostgreSQL** | 15+ | 主数据库 |
| **Redis** | 7+ | 缓存/会话 |
| **Elasticsearch** | 8+ | 全文检索 |
| **Neo4j** | 5+ | 知识图谱 |

### AI & 云服务

| 服务 | 说明 |
|:---|:---|
| **Langchain4j** | 多模型路由（通义/GPT/DeepSeek/Moonshot/智谱/SiliconFlow/Ollama） |
| **阿里云 DashScope** | 通义千问大模型 |
| **阿里云 OSS** | 对象存储 |
| **阿里云 NLS** | 语音识别 (ASR) + 语音合成 (TTS) |

---

## 核心功能

| 模块 | 功能描述 |
|:---|:---|
| **AI 智能助手** | 多模型路由、SSE 流式对话、MCP 服务器集成 |
| **RAG 知识库** | 文档解析 → 向量 Embedding → Rerank 检索增强 |
| **智能批改** | OCR 识别 + AI 批改 + 知识画像 + 错题推荐 |
| **PPT 生成** | AI 大纲/内容生成 + OnlyOffice 在线编辑 |
| **试卷系统** | AI 生成题目 + Typst 排版导出 PDF |
| **会员系统** | 4 种套餐 + AI 配额控制（按天/按月） |
| **课程体系** | 课程/班级/教师管理 + HLS 视频播放 |
| **社交互动** | WebSocket 私聊/群聊 + 学习圈子 |
| **电子书** | PDF/EPUB 阅读器 + AI 摘要/问答 + 内容加密 |
| **工作流引擎** | 可视化 DAG 编排 + 18 种节点执行器 |

---

## 架构设计

### DDD 四层架构

```
┌─────────────────────────────────────────────────────────────┐
│                    Interfaces 接口层                         │
│  Controller → DTO → Assembler                               │
└────────────────────────┬────────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────────┐
│                   Application 应用层                         │
│  ApplicationService → Command → Query                       │
└────────────────────────┬────────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────────┐
│                      Domain 领域层                           │
│  Entity → ValueObject → Repository (接口)                   │
└────────────────────────▲────────────────────────────────────┘
                         │
┌────────────────────────┴────────────────────────────────────┐
│                Infrastructure 基础设施层                      │
│  Mapper → PO → Repository (实现)                             │
└─────────────────────────────────────────────────────────────┘
```

### 系统架构

```
┌──────────────┐  ┌──────────────┐
│  React Web   │  │ Flutter App  │
└──────┬───────┘  └──────┬───────┘
       │  HTTP/SSE        │  HTTP/SSE
       │  WebSocket       │  WebSocket
       └────────┬─────────┘
                │
       ┌────────▼────────┐
       │  Spring Boot    │
       │  REST/SSE/WS    │
       └───┬─────┬───────┘
           │     │
     ┌─────▼┐ ┌─▼───┐ ┌▼────┐ ┌▼────┐
     │PG SQL│ │Redis│ │ ES  │ │Neo4j│
     └──────┘ └─────┘ └─────┘ └─────┘
```

---

## 快速开始

### 前置要求

| 组件 | 版本 |
|:---|:---|
| JDK | 21+ |
| Node.js | 18+ |
| Flutter | 3.10+ |
| PostgreSQL | 15+ |
| Redis | 7+ |

### Docker 一键启动

```bash
# 复制环境变量模板
cp docker/.env.example docker/.env

# 编辑 docker/.env，填入必要配置

# 启动所有服务
docker-compose -f docker/docker-compose.yml up -d
```

### 本地开发

```bash
# 后端
cd backend
mvn spring-boot:run

# Web 前端
cd web
npm install && npm run dev

# 移动端
cd app
flutter pub get && flutter run
```

---

## 文档中心

### 功能文档

- **[功能文档首页](docs/wiki/Home.md)** - Web 端各页面功能说明

| 用户端 | 管理端 |
|:---|:---|
| [首页](docs/wiki/用户端-首页.md) | [仪表盘](docs/wiki/管理端-仪表盘.md) |
| [课程中心](docs/wiki/用户端-课程中心.md) | [用户与班级管理](docs/wiki/管理端-用户与班级管理.md) |
| [每日学习](docs/wiki/用户端-每日学习.md) | [内容管理](docs/wiki/管理端-内容管理.md) |
| [聊天与社交](docs/wiki/用户端-聊天与社交.md) | [会员与订单管理](docs/wiki/管理端-会员与订单管理.md) |
| [电子书](docs/wiki/用户端-电子书.md) | [AI 与 PPT 管理](docs/wiki/管理端-AI与PPT管理.md) |
| [AI 智能批改](docs/wiki/用户端-AI智能批改.md) | [工作流与自动化](docs/wiki/管理端-工作流与自动化.md) |
| [学习圈](docs/wiki/用户端-学习圈.md) | [题库与试卷管理](docs/wiki/管理端-题库与试卷管理.md) |

### API 文档

- **Swagger UI**: `http://localhost:8080/swagger-ui.html` (后端启动后访问)

---

## 许可证

**CC BY-NC-SA 4.0** (署名-非商业性使用-相同方式共享)

```
您可以：
  • 分享 — 复制和转载本项目的材料
  • 修改 — 混合、转换和基于本材料进行构建

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

