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
| **文档解析** | Apache POI / PDFBox / Jsoup / Epublib | 5.2.5 / 3.0.1 / 1.17.2 / 3.1 |
| **网页爬虫** | Selenium + HtmlUnit + Jsoup | 4.31.0 |
| **实时通信** | WebSocket (STOMP) | — |
| **代码沙箱** | Docker Java + GraalJS | 3.4.1 / 24.1.1 |
| **API 文档** | SpringDoc OpenAPI (Swagger) | 2.7.0 |
| **序列化** | Jackson + Gson | — |
| **HTTP 客户端** | OkHttp | 4.12.0 |

---

## 项目架构

采用 DDD（领域驱动设计）四层架构，按领域模块组织代码。

### 架构总览

```
com.novacloudedu.backend/
│
├── interfaces/rest/        # 接口层 — REST API
├── application/            # 应用层 — 业务编排 (Command/Query/ApplicationService)
├── domain/                 # 领域层 — 核心业务逻辑 (Entity/ValueObject/Repository 接口)
├── infrastructure/         # 基础设施层 — 技术实现 (持久化/AI/OSS/语音/爬虫/工作流)
├── config/                 # 配置类
├── common/                 # 通用类 (统一响应/错误码)
├── exception/              # 异常处理
├── aop/                    # AOP 切面
├── annotation/             # 自定义注解
└── BackendApplication.java # 启动类
```

### 各层职责

| 层级 | 职责 | 依赖方向 |
|:---:|:---|:---:|
| **Interfaces** | 处理 HTTP 请求，参数校验，DTO ↔ Command 转换 | → Application |
| **Application** | 编排领域服务，事务管理，权限控制 | → Domain |
| **Domain** | 核心业务逻辑，领域模型，业务规则（零框架依赖） | 无外部依赖 |
| **Infrastructure** | 数据持久化，外部服务调用（AI/OSS/Neo4j/ES/语音/工作流等） | → Domain |

### 数据流转

```
HTTP Request → Controller → Assembler(DTO→Command) → ApplicationService → Domain Entity → Repository(接口)
                                                                                              ↓
HTTP Response ← Controller ← Assembler(Entity→DTO) ← ApplicationService ← Domain Entity ← RepositoryImpl(实现)
```

---

## Interfaces 接口层

22 个 REST 模块，每个模块包含 `Controller`、`assembler/`（DTO ↔ Command 转换器）、`dto/`（请求/响应数据对象）。

### AI 智能服务

```
interfaces/rest/ai/
├── AiChatController.java               # AI 对话（多模型路由、SSE 流式响应）
├── AiAssistantController.java           # AI 助手管理（创建/配置/系统提示词）
├── KnowledgeBaseController.java         # 知识库管理（文档上传/向量化/检索）
├── WorkflowController.java              # 工作流管理（CRUD/执行/调度/日志）
├── WorkflowWebhookController.java       # 工作流 Webhook 触发
├── assembler/
└── dto/ (53 个 DTO)
```

### 认证与用户

```
interfaces/rest/auth/                    # 认证模块
├── AuthController.java                  #   登录/注册/短信验证码/Token 刷新
├── assembler/ + dto/ (7 个 DTO)

interfaces/rest/user/                    # 用户管理模块
├── UserManageController.java            #   用户 CRUD/角色管理/分页查询
├── assembler/ + dto/ (12 个 DTO)

interfaces/rest/teacher/                 # 教师模块
├── TeacherApplicationController.java    #   教师资格申请/审核
├── TeacherController.java               #   教师信息管理
├── assembler/ + dto/ (5 个 DTO)
```

### 课程体系

```
interfaces/rest/course/                  # 课程模块
├── CourseController.java                #   课程 CRUD/发布/搜索
├── CourseChapterController.java         #   章节管理
├── CourseSectionController.java         #   小节管理
├── CourseStructureController.java       #   课程结构树查询
├── CourseFavouriteController.java       #   课程收藏
├── CourseReviewController.java          #   课程评价
├── assembler/ + dto/ (12 个 DTO)

interfaces/rest/clazz/                   # 班级模块
├── ClassController.java                 #   班级 CRUD/成员管理/作业布置
├── assembler/ + dto/ (6 个 DTO)

interfaces/rest/schedule/                # 课程表模块
├── ScheduleController.java              #   课程排期/日历视图/冲突检测
├── assembler/ + dto/ (7 个 DTO)

interfaces/rest/progress/                # 学习进度模块
├── ProgressController.java              #   进度记录/统计/报告
├── assembler/ + dto/ (3 个 DTO)
```

### 每日学习

```
interfaces/rest/dailylearning/           # 每日学习模块
├── DailyWordController.java             #   每日单词管理（CRUD/批量导入）
├── DailyArticleController.java          #   每日文章管理（CRUD/发布）
├── UserDailyWordController.java         #   用户单词学习（记录/进度/复习）
├── UserDailyArticleController.java      #   用户文章学习（阅读/收藏）
├── UserWordBookController.java          #   生词本管理
├── ArticleAiController.java             #   文章 AI 总结/问答
├── ArticleChatController.java           #   文章 AI 对话（SSE 流式）
├── GraphSyncController.java             #   知识图谱同步
├── assembler/ + dto/ (17 个 DTO)
```

### 电子书

```
interfaces/rest/book/                    # 电子书模块
├── BookController.java                  #   书籍列表/详情
├── ChapterController.java               #   章节内容（AES 解密）
├── ReadingProgressController.java       #   阅读进度同步
├── AiBookController.java                #   AI 书籍功能（总结/问答/测试题生成）
```

### 社交互动

```
interfaces/rest/social/                  # 社交模块
├── UserFollowController.java            #   关注/取关/粉丝列表
├── FriendController.java                #   好友管理（申请/同意/拒绝/列表）
├── PrivateChatController.java           #   私聊消息（WebSocket + REST）
├── GroupChatController.java             #   群聊消息
├── ChatGroupController.java             #   聊天群组管理（创建/成员/解散）
├── assembler/ + dto/ (26 个 DTO)

interfaces/rest/post/                    # 帖子模块
├── PostController.java                  #   帖子 CRUD/点赞/分页
├── PostCommentController.java           #   评论/回复/删除
├── dto/ (11 个 DTO)
```

### 内容管理

```
interfaces/rest/announcement/            # 公告模块
├── AnnouncementController.java          #   公告列表/详情（用户端）
├── AdminAnnouncementController.java     #   公告 CRUD（管理端）
├── assembler/ + dto/ (8 个 DTO)

interfaces/rest/banner/                  # 轮播图模块
├── BannerController.java                #   轮播图列表（用户端）
├── AdminBannerController.java           #   轮播图 CRUD（管理端）
├── assembler/ + dto/ (6 个 DTO)

interfaces/rest/feedback/                # 反馈模块
├── FeedbackController.java              #   用户提交反馈
├── FeedbackManageController.java        #   反馈审核/处理（管理端）
├── assembler/ + dto/ (8 个 DTO)
```

### 其他模块

```
interfaces/rest/checkin/                 # 签到模块
├── CheckinController.java               #   每日签到/签到记录
├── UserStatsController.java             #   用户统计数据

interfaces/rest/file/                    # 文件上传模块
├── FileUploadController.java            #   文件上传（阿里云 OSS）
├── assembler/ + dto/ (2 个 DTO)

interfaces/rest/order/                   # 订单模块
├── OrderController.java                 #   用户订单（创建/查询）
├── OrderAdminController.java            #   订单管理（管理端）
├── assembler/ + dto/ (3 个 DTO)

interfaces/rest/speech/                  # 语音交互模块
├── SpeechController.java                #   语音合成 (TTS) / 语音识别 (ASR)
├── dto/ (2 个 DTO)

interfaces/rest/scraper/                 # 网页爬虫模块
├── ScraperController.java               #   爬虫任务（创建/执行/监控/结果查询）
├── ScraperConfigController.java         #   爬虫规则配置（CRUD）
├── assembler/ + dto/ (13 个 DTO)

interfaces/rest/recommendation/          # 智能推荐模块
├── assembler/ + dto/ (4 个 DTO)         #   基于 Neo4j 知识图谱推荐

interfaces/rest/common/                  # 通用模块
├── HealthController.java                #   健康检查接口
├── PageResponse.java                    #   分页响应封装
```

---

## Application 应用层

18 个应用模块，负责业务流程编排。每个模块包含 `command/`（命令对象）、`query/`（查询对象）和/或 `service/`（应用服务）。

```
application/
├── service/                             # 核心应用服务集合
│   ├── AiChatApplicationService         #   AI 对话编排（多模型路由/SSE 流式/上下文管理）
│   ├── AiAssistantApplicationService    #   AI 助手管理
│   ├── AiAssistantWorkflowService       #   AI 助手工作流集成
│   ├── KnowledgeBaseApplicationService  #   知识库编排（文档解析/Embedding/检索/Rerank）
│   ├── WorkflowApplicationService       #   工作流编排（执行/调度/日志/版本管理）
│   ├── UserApplicationService           #   用户管理（CRUD/角色/密码/偏好）
│   ├── ClassApplicationService          #   班级编排
│   ├── AnnouncementApplicationService   #   公告管理
│   ├── BannerApplicationService         #   轮播图管理
│   ├── FeedbackApplicationService       #   反馈管理
│   ├── PostApplicationService           #   帖子编排（发布/点赞/评论）
│   ├── CheckinApplicationService        #   签到编排
│   ├── UserFollowApplicationService     #   关注/粉丝
│   ├── FriendApplicationService         #   好友管理
│   ├── PrivateChatApplicationService    #   私聊消息
│   ├── GroupChatApplicationService      #   群聊消息
│   ├── ChatGroupApplicationService      #   聊天群组管理
│   └── NotificationService              #   消息通知（WebSocket 推送/离线缓存）
│
├── ai/                                  # AI 模块
│   ├── command/ (4)                     #   ChatCommand / KnowledgeBaseCommand 等
│   └── dto/ (4)                         #   ChatResult / EmbeddingResult 等
│
├── book/                                # 电子书模块
│   ├── command/ (2)  + dto/ (4)
│   └── service/ (7)                     #   BookAppService / ChapterAppService / AiBookService 等
│
├── course/                              # 课程模块
│   ├── command/ (16)                    #   CreateCourseCmd / UpdateChapterCmd / ReviewCmd 等
│   └── query/ (5)                       #   CourseQuery / ChapterQuery 等
│
├── dailylearning/                       # 每日学习模块
│   ├── command/ (10) + query/ (5)
│   └── service/ (2)                     #   DailyLearningAppService / ArticleAiService
│
├── social/                              # 社交模块
│   ├── command/ (4)                     #   SendMessageCmd / CreateGroupCmd 等
│   └── query/ (4)
│
├── user/          (10 items)            # 用户模块 command/query
├── scraper/       (5 items)             # 爬虫模块 command/dto
├── schedule/      (9 items)             # 课程表模块 command/query
├── teacher/       (6 items)             # 教师模块 command/query
├── announcement/  (3 items)             # 公告模块 command
├── banner/        (3 items)             # 轮播图模块 command
├── feedback/      (4 items)             # 反馈模块 command/query
├── file/          (3 items)             # 文件模块 command
├── order/         (4 items)             # 订单模块 command
├── progress/      (4 items)             # 进度模块 command/query
└── recommendation/ (4 items)            # 推荐模块 query/dto
```

---

## Domain 领域层

22 个领域模块，每个模块采用标准 DDD 结构：`entity/`、`valueobject/`、`repository/`（接口）、`service/`（领域服务）。

### 领域模块一览

| 领域模块 | Entity | ValueObject | Repository | Service | 说明 |
|:---|:---:|:---:|:---:|:---:|:---|
| **ai** | 11 | 21 | 13 | 7 | AI 对话/会话/助手/知识库/工作流 |
| **book** | 9 | 15 | 9 | 8 | 电子书/章节/阅读进度/AI 书籍 |
| **social** | 10 | 16 | 10 | — | 好友/私聊/群聊/聊天群组 |
| **course** | 5 | 6 | 5 | — | 课程/章节/小节/收藏/评价 |
| **dailylearning** | 5 | 5 | 5 | 1 | 每日单词/每日文章/生词本 |
| **post** | 5 | 4 | 5 | — | 帖子/评论/点赞 |
| **scraper** | 3 | 6 | 2 | 1 | 爬虫配置/任务/结果 |
| **recommendation** | 3 | 3 | 3 | — | 知识图谱推荐 |
| **clazz** | — | — | — | — | 班级（8 items） |
| **feedback** | — | — | — | — | 反馈（8 items） |
| **user** | 1 | 4 | 1 | — | 用户/偏好 |
| **schedule** | 2 | 3 | 1 | — | 课程表 |
| **teacher** | — | — | — | — | 教师（6 items） |
| **announcement** | — | — | — | — | 公告（6 items） |
| **banner** | — | — | — | — | 轮播图（5 items） |
| **checkin** | — | — | — | — | 签到（4 items） |
| **file** | — | — | — | — | 文件（4 items） |
| **order** | — | — | — | — | 订单（4 items） |
| **payment** | — | — | — | — | 支付（4 items） |
| **knowledge** | — | — | — | 1 | 知识图谱服务 |
| **progress** | — | — | — | — | 学习进度（2 items） |
| **event** | — | — | — | — | 领域事件（预留） |

---

## Infrastructure 基础设施层

### AI 服务 (`infrastructure/ai/`)

```
ai/
├── ChatModelFactory.java                # 多模型工厂（根据 provider 创建 ChatModel 实例）
├── LangchainChatService.java            # Langchain4j 统一对话服务
├── DashScopeLlmService.java             # 通义千问 LLM 调用（流式/非流式）
├── DashScopeEmbeddingService.java       # 文本向量化 (Embedding) 服务
├── DashScopeRerankService.java          # 文档重排序 (Rerank) 服务
├── DocumentParseService.java            # 文档解析调度（PDF/EPUB/DOCX/TXT）
├── DocumentContentExtractor.java        # 文档内容提取
├── KnowledgeSearchServiceImpl.java      # 知识库检索实现（向量检索 + Rerank）
├── ArticleAiServiceImpl.java            # 文章 AI 服务实现（总结/问答）
├── ImageGenerationService.java          # AI 图片生成服务
├── VideoGenerationService.java          # AI 视频生成服务
└── QwenClient.java                      # 通义千问原生客户端
```

### 持久化 (`infrastructure/persistence/`)

```
persistence/
├── po/         (69 个 PO)               # 持久化对象（对应数据库表）
├── mapper/     (68 个 Mapper)            # MyBatis Plus Mapper 接口
├── repository/ (66 个 Repository 实现)   # 仓储实现（PO ↔ Entity 转换）
├── converter/  (49 个 Converter)         # PO ↔ Entity/ValueObject 转换器
└── handler/    (3 个 Handler)            # MyBatis 类型处理器
```

### 安全认证 (`infrastructure/security/`)

```
security/
├── JwtTokenProvider.java                # JWT Token 生成/解析/验证
├── JwtAuthenticationFilter.java         # JWT 请求过滤器
├── JwtAuthenticationEntryPoint.java     # 未认证响应处理
├── JwtAccessDeniedHandler.java          # 无权限响应处理
└── PasswordEncoderAdapter.java          # 密码加密适配器
```

### Neo4j 知识图谱 (`infrastructure/neo4j/`)

```
neo4j/
├── node/ (6 个节点类型)                   # 知识图谱节点（课程/知识点/用户偏好等）
└── repository/ (5 个仓储)                 # Neo4j 图查询仓储
```

### WebSocket 实时通信 (`infrastructure/websocket/`)

```
websocket/
├── WebSocketAuthChannelInterceptor.java # WebSocket JWT 认证拦截器
├── WebSocketEventListener.java          # 连接/断开事件监听
├── SpeechRecognitionWebSocketHandler.java # 语音识别 WebSocket 处理器
└── OfflineNotificationCache.java        # 离线消息缓存（Redis）
```

### 工作流引擎 (`infrastructure/workflow/`)

```
workflow/
├── DefaultWorkflowEngine.java           # 工作流引擎核心（DAG 执行/变量传递/错误处理）
├── WorkflowSchedulerService.java        # 定时调度服务（Cron 表达式）
├── DefaultWorkflowLogService.java       # 执行日志记录服务
├── NodeExecutorRegistry.java            # 节点执行器注册中心
├── DatabaseMetadataService.java         # 数据库元数据查询服务
└── executor/                            # 节点执行器
    ├── StartNodeExecutor.java           #   开始节点（参数注入）
    ├── EndNodeExecutor.java             #   结束节点
    ├── LlmNodeExecutor.java             #   LLM 对话节点（多模型）
    ├── ConditionNodeExecutor.java       #   条件分支节点
    ├── SwitchNodeExecutor.java          #   多路分支节点
    ├── LoopNodeExecutor.java            #   循环节点
    ├── ParallelNodeExecutor.java        #   并行执行节点
    ├── MergeNodeExecutor.java           #   合并节点
    ├── CodeNodeExecutor.java            #   代码执行节点
    ├── HttpRequestNodeExecutor.java     #   HTTP 请求节点
    ├── DatabaseQueryNodeExecutor.java   #   数据库查询节点
    ├── TemplateNodeExecutor.java        #   模板转换节点
    ├── JsonParseNodeExecutor.java       #   JSON 解析节点
    ├── TextEmbeddingNodeExecutor.java   #   文本向量化节点
    ├── IntentRecognitionNodeExecutor.java #  意图识别节点
    ├── EntityExtractionNodeExecutor.java #   实体提取节点
    ├── FileNodeExecutor.java            #   文件处理节点
    ├── ResponseNodeExecutor.java        #   响应输出节点
    └── code/                            #   代码沙箱
        ├── CodeSandboxConfig.java       #     沙箱配置
        ├── DockerPythonExecutionService #     Docker Python 执行（安全隔离）
        └── GraalJsExecutionService      #     GraalJS JavaScript 执行（JVM 内沙箱）
```

### 其他基础设施

```
infrastructure/
├── oss/
│   └── AliyunOssService.java            # 阿里云 OSS 文件上传/下载/删除
│
├── speech/
│   ├── NlsSpeechRecognitionService.java # 阿里云 NLS 语音识别 (ASR)
│   └── NlsTextToSpeechService.java      # 阿里云 NLS 语音合成 (TTS)
│
├── parser/
│   ├── PdfBookParser.java               # PDF 文档解析（PDFBox）
│   ├── EpubBookParser.java              # EPUB 电子书解析（Epublib）
│   ├── WordBookParser.java              # DOCX/DOC 解析（Apache POI）
│   └── TxtBookParser.java              # TXT 纯文本解析
│
├── scraper/
│   ├── SeleniumWebScraperService.java   # Selenium 动态页面爬虫
│   └── JsoupWebScraperService.java      # Jsoup 静态页面爬虫
│
├── search/                              # Elasticsearch 全文检索
├── sms/
│   ├── SmsService.java                  # 短信发送服务
│   └── SmsCodeService.java              # 验证码生成/校验/限流
│
└── payment/                             # 支付集成
```

---

## 配置类 (`config/`)

| 配置类 | 功能 |
|:---|:---|
| `SecurityConfig.java` | Spring Security 配置（过滤链/CORS/路径放行） |
| `ChatModelProperties.java` | Langchain4j 多模型路由配置属性 |
| `ImageModelProperties.java` | AI 图片生成模型配置属性 |
| `VideoModelProperties.java` | AI 视频生成模型配置属性 |
| `DashScopeConfig.java` | 阿里云 DashScope SDK 配置 |
| `Neo4jConfig.java` | Neo4j 连接配置 |
| `NlsSpeechConfig.java` | 阿里云 NLS 语音交互配置（AppKey/Token） |
| `WebSocketConfig.java` | STOMP WebSocket 配置（消息代理/端点） |
| `RawWebSocketConfig.java` | 原生 WebSocket 配置（语音识别） |
| `MybatisPlusConfig.java` | MyBatis Plus 配置（分页插件/自动填充） |
| `MyBatisMetaObjectHandler.java` | 自动填充 createTime/updateTime |
| `OpenApiConfig.java` | Swagger/OpenAPI 配置 |
| `JacksonConfig.java` | Jackson 序列化配置 |
| `GsonConfig.java` | Gson 配置 |
| `RestTemplateConfig.java` | RestTemplate 配置 |
| `AsyncSecurityConfig.java` | 异步线程安全上下文传播 |

---

## 通用基础设施

### 通用类 (`common/`)

| 类 | 功能 |
|:---|:---|
| `BaseResponse<T>` | 统一 API 响应格式 `{code, data, message}` |
| `ErrorCode` | 错误码枚举（SUCCESS/PARAMS_ERROR/NOT_LOGIN 等） |
| `ResultUtils` | 响应构建工具 `success(data)` / `error(code, msg)` |

### 异常处理 (`exception/`)

| 类 | 功能 |
|:---|:---|
| `BusinessException` | 业务异常（携带 ErrorCode） |
| `ThrowUtils` | 条件抛异常工具 `throwIf(condition, errorCode)` |
| `GlobalExceptionHandler` | 全局异常处理（@RestControllerAdvice） |

### AOP (`aop/` + `annotation/`)

| 类 | 功能 |
|:---|:---|
| `@AuthCheck` | 权限校验注解（指定所需角色） |
| `AuthInterceptor` | 权限校验切面（拦截 @AuthCheck 注解方法） |

---

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

### AI 能力矩阵

| 能力 | 实现类 | 说明 |
|:---|:---|:---|
| **多模型对话** | `ChatModelFactory` + `LangchainChatService` | 根据 provider 动态创建模型实例 |
| **DashScope 原生** | `DashScopeLlmService` + `QwenClient` | 通义千问流式/非流式调用 |
| **文本向量化** | `DashScopeEmbeddingService` | 文档/查询 Embedding |
| **文档重排序** | `DashScopeRerankService` | 检索结果 Rerank |
| **知识库检索** | `KnowledgeSearchServiceImpl` | 向量检索 + Rerank 两阶段 |
| **文档解析** | `DocumentParseService` | PDF/EPUB/DOCX/TXT 多格式解析 |
| **图片生成** | `ImageGenerationService` | AI 图片生成 |
| **视频生成** | `VideoGenerationService` | AI 视频生成 |

---

## 工作流引擎

内置可视化工作流引擎，支持 **18 种节点执行器**：

| 分类 | 节点 | 说明 |
|:---|:---|:---|
| **流程控制** | Start / End / Condition / Switch / Loop / Parallel / Merge | 开始、结束、条件分支、多路分支、循环、并行、合并 |
| **AI 节点** | LLM / TextEmbedding / IntentRecognition / EntityExtraction | LLM 对话、向量化、意图识别、实体提取 |
| **数据处理** | Code / Template / JsonParse / DatabaseQuery / File | 代码执行、模板转换、JSON 解析、数据库查询、文件处理 |
| **输出** | Response / HttpRequest | 响应输出、HTTP 请求 |

**代码执行沙箱**：
- **Python** — Docker 容器隔离执行（`DockerPythonExecutionService`）
- **JavaScript** — GraalJS JVM 内沙箱执行（`GraalJsExecutionService`）

工作流支持定时调度（Cron）、Webhook 触发和手动执行，执行日志完整记录。

---

## 资源文件

```
resources/
├── application.yml                  # 公共配置（JWT/MyBatis-Plus/SpringDoc）
├── application-dev.example.yml      # 开发环境配置模板（★ 复制为 application-dev.yml 使用）
├── application-dev.yml              # 开发环境配置（gitignore，不提交）
└── application-prod.yml             # 生产环境配置
```

## SQL 脚本

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

---

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
