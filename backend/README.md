# NovaCloudEdu Backend

智云星课后端服务，基于 **Spring Boot 3.5.8 + MyBatis Plus 3.5.5**，采用 **DDD 四层架构**。

## 技术栈

| 分类 | 技术 | 版本 |
|:---|:---|:---|
| **核心框架** | Java + Spring Boot | 21 + 3.5.8 |
| **持久化** | MyBatis Plus | 3.5.5 |
| **安全** | Spring Security + JWT (jjwt) | 6.x + 0.12.6 |
| **数据库** | PostgreSQL | 15+ |
| **缓存** | Redis (Lettuce) | 7+ |
| **全文检索** | Elasticsearch (Spring Data) | 8+ |
| **知识图谱** | Neo4j (Spring Data) | 5+ |
| **AI 框架** | Langchain4j | 0.36.2 |
| **AI 模型** | DashScope SDK (通义千问) | 2.16.7 |
| **对象存储** | 阿里云 OSS | 3.17.4 |
| **语音交互** | 阿里云 NLS (ASR/TTS) | 2.1.6 |
| **文档解析** | Apache POI / PDFBox / Jsoup | 5.2.5 / 3.0.1 / 1.17.2 |
| **网页爬虫** | Selenium + HtmlUnit | 4.31.0 |
| **实时通信** | WebSocket (STOMP) | — |
| **API 文档** | SpringDoc OpenAPI (Swagger) | 2.7.0 |

## 项目架构

采用 DDD（领域驱动设计）四层架构，按领域模块组织代码：

```
com.novacloudedu.backend/
│
├── interfaces/rest/                 # 接口层 — REST API
│   ├── ai/                          #   AI 智能对话
│   ├── auth/                        #   认证（登录/注册/短信验证）
│   ├── announcement/                #   公告管理
│   ├── banner/                      #   轮播图管理
│   ├── book/                        #   电子书管理
│   ├── checkin/                     #   签到打卡
│   ├── clazz/                       #   班级管理
│   ├── course/                      #   课程管理
│   ├── dailylearning/               #   每日学习（单词/文章）
│   ├── feedback/                    #   反馈管理
│   ├── file/                        #   文件上传
│   ├── order/                       #   订单管理
│   ├── post/                        #   帖子/动态
│   ├── progress/                    #   学习进度
│   ├── recommendation/              #   智能推荐
│   ├── schedule/                    #   课程表
│   ├── scraper/                     #   网页爬虫
│   ├── social/                      #   社交（关注/圈子）
│   ├── speech/                      #   语音交互
│   ├── teacher/                     #   教师管理
│   ├── user/                        #   用户管理
│   └── common/                      #   通用接口（健康检查）
│
├── application/                     # 应用层 — 业务编排
│   ├── ai/                          #   AI 对话应用服务
│   ├── user/                        #   用户应用服务
│   ├── course/                      #   课程应用服务
│   ├── book/                        #   电子书应用服务
│   ├── clazz/                       #   班级应用服务
│   ├── social/                      #   社交应用服务
│   ├── scraper/                     #   爬虫应用服务
│   ├── service/                     #   通用应用服务
│   └── ...                          #   (共 16+ 个模块)
│
├── domain/                          # 领域层 — 核心业务逻辑
│   ├── user/                        #   用户领域（Entity/ValueObject/Repository）
│   ├── course/                      #   课程领域
│   ├── book/                        #   电子书领域
│   ├── ai/                          #   AI 对话领域
│   ├── clazz/                       #   班级领域
│   ├── knowledge/                   #   知识图谱领域
│   ├── order/ + payment/            #   订单与支付领域
│   ├── social/ + post/              #   社交与帖子领域
│   ├── scraper/                     #   爬虫领域
│   ├── event/                       #   领域事件
│   └── ...                          #   (共 22 个领域模块)
│
├── infrastructure/                  # 基础设施层 — 技术实现
│   ├── ai/                          #   Langchain4j 多模型路由 + ChatService
│   ├── persistence/                 #   MyBatis 持久化（PO/Mapper/Repository 实现/Converter）
│   ├── repository/                  #   仓储实现
│   ├── security/                    #   JWT 认证与授权
│   ├── oss/                         #   阿里云 OSS 对象存储
│   ├── neo4j/                       #   Neo4j 知识图谱
│   ├── search/                      #   Elasticsearch 全文检索
│   ├── speech/                      #   阿里云 NLS 语音（ASR/TTS）
│   ├── scraper/                     #   Selenium/HtmlUnit 网页爬虫
│   ├── parser/                      #   文档解析（PDF/EPUB/DOCX）
│   ├── payment/                     #   支付集成
│   ├── sms/                         #   短信验证码
│   ├── websocket/                   #   WebSocket 实时通信
│   ├── workflow/                    #   工作流引擎
│   ├── external/                    #   外部服务集成
│   └── config/                      #   基础设施配置
│
├── config/                          # 配置类
│   ├── SecurityConfig.java          #   Spring Security 配置
│   ├── ChatModelProperties.java     #   Langchain4j 多模型配置
│   ├── DashScopeConfig.java         #   DashScope AI 配置
│   ├── Neo4jConfig.java             #   Neo4j 配置
│   ├── NlsSpeechConfig.java         #   阿里云 NLS 语音配置
│   ├── WebSocketConfig.java         #   WebSocket 配置
│   ├── RawWebSocketConfig.java      #   原生 WebSocket 配置
│   ├── MybatisPlusConfig.java       #   MyBatis Plus 配置
│   ├── OpenApiConfig.java           #   Swagger 配置
│   └── ...
│
├── common/                          # 通用类
│   ├── BaseResponse.java            #   统一响应封装
│   ├── ErrorCode.java               #   错误码枚举
│   └── ResultUtils.java             #   响应工具类
│
├── exception/                       # 异常处理
│   ├── BusinessException.java       #   业务异常
│   ├── ThrowUtils.java              #   抛异常工具
│   └── GlobalExceptionHandler.java  #   全局异常处理器
│
├── aop/                             # AOP 切面
│   └── AuthInterceptor.java         #   权限校验切面
│
├── annotation/                      # 自定义注解
│   └── AuthCheck.java               #   权限校验注解
│
└── BackendApplication.java          # 启动类
```

### 资源文件

```
resources/
├── application.yml                  # 公共配置（JWT/MyBatis-Plus/SpringDoc）
├── application-dev.example.yml      # 开发环境配置模板（★ 复制为 application-dev.yml 使用）
├── application-dev.yml              # 开发环境配置（gitignore，不提交）
└── application-prod.yml             # 生产环境配置
```

### SQL 脚本

```
sql/
├── init.sql                         # 数据库初始化
├── user.sql / user_follow.sql / user_preference.sql
├── course.sql / class.sql / schedule.sql
├── book.sql / post.sql / social.sql
├── ai_chat.sql / ai_chat_session.sql
├── announcement.sql / banner.sql / feedback.sql
├── checkin.sql / daily_learning.sql / file_upload.sql
├── create_scraper_tables.sql
└── (共 19 个 SQL 文件)
```

## 各层职责

| 层级 | 职责 | 依赖方向 |
|:---:|:---|:---:|
| **Interfaces** | 处理 HTTP 请求，参数校验，DTO ↔ Command 转换 | → Application |
| **Application** | 编排领域服务，事务管理，权限控制 | → Domain |
| **Domain** | 核心业务逻辑，领域模型，业务规则（零框架依赖） | 无外部依赖 |
| **Infrastructure** | 数据持久化，外部服务调用（AI/OSS/Neo4j/ES/语音等） | → Domain |

## AI 多模型路由

基于 **Langchain4j 0.36.2** 实现多 LLM 提供商统一接入：

| 提供商 | 支持模型 | 协议 |
|:---|:---|:---|
| **DashScope (通义千问)** | qwen-max / qwen-plus / qwen-turbo / qwen-vl-max / qwen-vl-plus | DashScope 原生 |
| **OpenAI** | gpt-4o / gpt-4o-mini | OpenAI API |
| **DeepSeek** | deepseek-chat / deepseek-reasoner | OpenAI 兼容 |
| **Moonshot (Kimi)** | moonshot-v1-128k / moonshot-v1-32k | OpenAI 兼容 |
| **智谱 (GLM)** | glm-4 / glm-4v | 智谱原生 |
| **SiliconFlow** | DeepSeek-V3 / Qwen2.5-72B 等 | OpenAI 兼容 |
| **Ollama** | llama3 / llava 等本地模型 | Ollama 原生 |

前端通过 `modelId`（格式 `provider/model`）指定模型，未指定时使用默认模型。

## 快速开始

### 1. 复制配置文件

```bash
cp src/main/resources/application-dev.example.yml src/main/resources/application-dev.yml
```

编辑 `application-dev.yml`，填入数据库、Redis、Neo4j、阿里云等配置。

### 2. 初始化数据库

```bash
psql -U postgres -d NovaCloudEdu -f sql/init.sql
```

### 3. 启动服务

```bash
mvn spring-boot:run
```

### 4. 访问

- **API 文档**: http://localhost:8080/swagger-ui.html
- **OpenAPI JSON**: http://localhost:8080/v3/api-docs

## 构建与部署

```bash
# 构建
mvn clean package -DskipTests

# 开发环境运行
java -jar target/backend-0.0.1-SNAPSHOT.jar --spring.profiles.active=dev

# 生产环境运行
java -jar target/backend-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
```
