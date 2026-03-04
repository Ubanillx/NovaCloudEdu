# NovaCloudEdu Docker 部署配置指南

本文档说明 `docker/.env.example` 中每个配置项的用途、获取方式和申请地址。

---

## 快速开始

```bash
cd docker
cp .env.example .env
# 编辑 .env，填写必要的密码和 API Key
docker compose up -d
```

> 仅修改密码即可启动全部基础设施服务。AI/OSS/邮件等功能需要填写对应的 API Key 后才可用。

---

## 一、本地基础设施（无需外部申请）

以下配置项均为本地 Docker 容器使用，修改为自定义密码即可。

### 1.1 PostgreSQL 数据库

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `DB_NAME` | 数据库名 | `novacloudedu` |
| `DB_USERNAME` | 数据库用户名 | `nova` |
| `DB_PASSWORD` | 数据库密码（必须修改） | `changeme_postgres_password_123` |
| `DB_PORT` | 宿主机映射端口 | `5432` |

- 容器镜像：`pgvector/pgvector:pg16`（含向量扩展）
- SQL 初始化脚本自动从 `backend/sql/` 目录挂载执行

### 1.2 Redis 缓存

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `REDIS_PASSWORD` | Redis 密码 | `changeme_redis_password_123` |
| `REDIS_PORT` | 宿主机映射端口 | `6379` |

### 1.3 Neo4j 图数据库

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `NEO4J_AUTH` | Neo4j 认证（格式：`用户名/密码`） | `neo4j/changeme_neo4j_password_123` |
| `NEO4J_PASSWORD` | Neo4j 密码（需与 AUTH 中的密码一致） | `changeme_neo4j_password_123` |
| `NEO4J_HTTP_PORT` | Web 控制台端口 | `7474` |
| `NEO4J_BOLT_PORT` | Bolt 协议端口 | `7687` |

- 控制台地址：`http://localhost:7474`

### 1.4 Elasticsearch 搜索引擎

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `ES_PORT` | HTTP 端口 | `9200` |
| `ES_TRANSPORT_PORT` | 传输端口 | `9300` |

- 已集成 IK 中文分词器，无需额外配置
- 安全认证已关闭（`xpack.security.enabled=false`）

### 1.5 JWT 密钥

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `JWT_SECRET` | JWT 签名密钥（建议64位以上随机字符串） | 内置默认值 |

- 生产环境务必替换为高强度随机密钥
- 生成方式：`openssl rand -base64 64`

---

## 二、外部服务配置（需申请 API Key）

### 2.1 阿里云 OSS 对象存储

用于文件上传（头像、课程封面、文档、视频等）。

| 变量 | 说明 |
|------|------|
| `ALIYUN_OSS_ENDPOINT` | OSS 地域节点（如 `oss-cn-hangzhou.aliyuncs.com`） |
| `ALIYUN_OSS_ACCESS_KEY_ID` | AccessKey ID |
| `ALIYUN_OSS_ACCESS_KEY_SECRET` | AccessKey Secret |
| `ALIYUN_OSS_BUCKET_NAME` | Bucket 名称 |
| `ALIYUN_OSS_DOMAIN` | 自定义域名（可选，用于 CDN 加速） |

**申请地址：**
- OSS 控制台：https://oss.console.aliyun.com/
- AccessKey 管理：https://ram.console.aliyun.com/manage/ak
- 建议使用 RAM 子账户，仅授予 `AliyunOSSFullAccess` 权限

### 2.2 阿里云 NLS 智能语音

用于语音识别（ASR）和语音合成（TTS）。

| 变量 | 说明 |
|------|------|
| `ALIYUN_NLS_ACCESS_KEY_ID` | AccessKey ID |
| `ALIYUN_NLS_ACCESS_KEY_SECRET` | AccessKey Secret |
| `ALIYUN_NLS_APP_KEY` | NLS 应用 AppKey |

**申请地址：**
- NLS 控制台：https://nls-portal.console.aliyun.com/
- 创建项目后获取 AppKey
- AccessKey 同 OSS，可复用同一 RAM 子账户

### 2.3 AI 模型服务

#### DashScope（阿里云通义千问） — 核心 AI 能力

| 变量 | 说明 |
|------|------|
| `DASHSCOPE_API_KEY` | DashScope API Key |

**申请地址：**
- https://dashscope.console.aliyun.com/
- 注册后在「API-KEY 管理」创建密钥
- 支持模型：qwen-max、qwen-plus、qwen-turbo、qwen-vl-max（视觉）、文生图（wan2.6-t2i）等

#### OpenRouter — PPT Agent 默认模型路由

| 变量 | 说明 |
|------|------|
| `OPENROUTER_ENABLED` | 是否启用（`true`/`false`） |
| `OPENROUTER_API_KEY` | OpenRouter API Key |

**申请地址：**
- https://openrouter.ai/
- 注册后在 https://openrouter.ai/keys 创建 API Key
- 聚合了 OpenAI、Google、Anthropic、DeepSeek 等多家模型，按用量计费

#### OpenAI

| 变量 | 说明 |
|------|------|
| `OPENAI_ENABLED` | 是否启用 |
| `OPENAI_API_KEY` | API Key |

**申请地址：** https://platform.openai.com/api-keys

#### DeepSeek

| 变量 | 说明 |
|------|------|
| `DEEPSEEK_ENABLED` | 是否启用 |
| `DEEPSEEK_API_KEY` | API Key |

**申请地址：** https://platform.deepseek.com/api_keys

#### Moonshot（月之暗面）

| 变量 | 说明 |
|------|------|
| `MOONSHOT_ENABLED` | 是否启用 |
| `MOONSHOT_API_KEY` | API Key |

**申请地址：** https://platform.moonshot.cn/console/api-keys

#### 智谱 AI（GLM）

| 变量 | 说明 |
|------|------|
| `ZHIPU_ENABLED` | 是否启用 |
| `ZHIPU_API_KEY` | API Key |

**申请地址：** https://open.bigmodel.cn/usercenter/apikeys

#### SiliconFlow（硅基流动）

| 变量 | 说明 |
|------|------|
| `SILICONFLOW_ENABLED` | 是否启用 |
| `SILICONFLOW_API_KEY` | API Key |

**申请地址：** https://cloud.siliconflow.cn/account/ak

### 2.4 百度 OCR 文字识别

用于智能批改的图片文字识别。

| 变量 | 说明 |
|------|------|
| `BAIDU_OCR_APP_ID` | 应用 ID |
| `BAIDU_OCR_API_KEY` | API Key |
| `BAIDU_OCR_SECRET_KEY` | Secret Key |

**申请地址：**
- https://console.bce.baidu.com/ai/#/ai/ocr/overview/index
- 创建应用后获取 AppID、API Key、Secret Key
- 免费额度：通用文字识别每日 500 次

### 2.5 Tavily 搜索 API

用于 PPT Agent 联网搜索获取实时资料。

| 变量 | 说明 |
|------|------|
| `TAVILY_API_KEY` | Tavily API Key |

**申请地址：**
- https://tavily.com/
- 注册后在 Dashboard 获取 API Key
- 免费额度：每月 1000 次搜索

### 2.6 邮件 SMTP

用于发送验证码、通知邮件。

| 变量 | 说明 |
|------|------|
| `MAIL_USERNAME` | 邮箱账号 |
| `MAIL_PASSWORD` | 邮箱密码或授权码 |

**配置方式（以腾讯企业邮箱为例）：**
- 登录 https://exmail.qq.com/ → 设置 → 客户端设置 → 开启 SMTP
- 生成授权码填入 `MAIL_PASSWORD`
- 默认 SMTP 服务器：`smtp.exmail.qq.com:465`（SSL）

**其他邮箱：**
- QQ 邮箱：https://mail.qq.com/ → 设置 → 账户 → POP3/SMTP 服务
- Gmail：https://myaccount.google.com/apppasswords

### 2.7 SMS 短信服务

用于手机号登录验证码。

| 变量 | 说明 |
|------|------|
| `SMS_URL` | 短信推送 API 地址 |
| `SMS_TOKEN` | 短信服务 Token |

- 当前使用 spug.cc 推送服务
- 申请地址：https://push.spug.cc/

### 2.8 管理员邮件通知

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `ADMIN_EMAIL_ENABLED` | 是否启用管理员通知 | `true` |
| `ADMIN_EMAIL_RECIPIENTS` | 接收通知的管理员邮箱 | `admin@example.com` |

---

## 三、应用服务配置

### 3.1 OnlyOffice 文档编辑

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `ONLYOFFICE_PORT` | 宿主机映射端口 | `9980` |
| `ONLYOFFICE_JWT_ENABLED` | 是否启用 JWT 认证 | `true` |
| `ONLYOFFICE_JWT_SECRET` | JWT 密钥（需与后端一致） | 内置默认值 |

- 无需外部申请，Docker 容器自动运行
- 社区版免费，支持 Word/Excel/PPT 在线编辑

### 3.2 PPT Agent 配置

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `PPT_AGENT_CONCURRENCY` | 并发生成数 | `3` |
| `PPT_AGENT_QUALITY_THRESHOLD` | 整体质量评分阈值 | `65` |
| `PPT_AGENT_MAX_REPAIR_ROUNDS` | 最大修复轮次 | `2` |
| `PPT_AGENT_SLIDE_SCORE_THRESHOLD` | 单页评分阈值 | `60` |
| `PPT_AGENT_IMAGE_SEARCH_ENABLED` | 是否启用图片搜索 | `false` |

### 3.3 书籍内容加密

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `BOOK_ENCRYPTION_ENABLED` | 是否启用电子书内容加密 | `false` |
| `BOOK_ENCRYPTION_KEY` | 加密密钥 | `NovaCloudEduBookKey1` |

### 3.4 Gotenberg PDF 转换

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `GOTENBERG_PORT` | 宿主机映射端口 | `3000` |
| `GOTENBERG_CPU_LIMIT` | CPU 限制 | `1` |
| `GOTENBERG_MEM_LIMIT` | 内存限制 | `1G` |

- 无需外部申请，Docker 容器自动运行

---

## 四、运行环境配置

### 4.1 Docker Socket

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `DOCKER_SOCK_PATH` | Docker Socket 路径 | `/var/run/docker.sock` |

- **macOS Docker Desktop**：`/Users/<username>/.docker/run/docker.sock`
- **Linux**：`/var/run/docker.sock`（默认值）
- 用于后端的 Python 代码沙箱执行功能

### 4.2 应用服务端口

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `BACKEND_PORT` | Java 后端端口 | `8080` |
| `PPT_SERVICE_PORT` | PPT 渲染服务端口 | `8100` |
| `TYPST_SERVICE_PORT` | Typst 排版服务端口 | `8200` |
| `SERVER_BASE_URL` | 后端对外访问地址 | `http://localhost:8080` |

### 4.3 视频转码

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `FFMPEG_PATH` | FFmpeg 可执行文件路径 | `ffmpeg` |
| `HLS_TIME` | HLS 分片时长（秒） | `10` |

### 4.4 实时音视频

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `RTC_WS_PORT` | RTC WebSocket 信令端口 | `8300` |
| `SRS_RTMP_PORT` | SRS RTMP 推流端口 | `1935` |
| `SRS_HTTP_PORT` | SRS HTTP-FLV 播放端口 | `8085` |
| `SRS_API_PORT` | SRS API 端口 | `1985` |
| `TURN_REALM` | TURN 服务域名 | `novacloudedu.com` |
| `TURN_USER` | TURN 认证用户名 | `nova` |
| `TURN_PASSWORD` | TURN 认证密码 | `changeme_turn_password` |
| `LIVEKIT_PORT` | LiveKit SFU 端口 | `7880` |
| `LIVEKIT_RTC_TCP` | LiveKit RTC TCP 端口 | `7881` |
| `LIVEKIT_API_KEY` | LiveKit API Key | `devkey` |
| `LIVEKIT_API_SECRET` | LiveKit API Secret | `devsecret` |

- 以上均为本地 Docker 容器服务，无需外部申请
- 生产环境需修改 TURN/LiveKit 的密钥

---

## 五、服务架构总览

```
                          +-----------+
                          |  Frontend |
                          |  (Web/App)|
                          +-----+-----+
                                |
                         +------v------+
                         |   Backend   | :8080
                         | (Spring Boot)|
                         +------+------+
                                |
        +-----------+-----------+-----------+-----------+
        |           |           |           |           |
   +----v----+ +----v----+ +----v----+ +----v----+ +----v----+
   |PostgreSQL| |  Redis  | |  Neo4j  | |   ES    | |OnlyOffice|
   | :5432    | | :6379   | | :7687   | | :9200   | | :9980   |
   +---------+ +---------+ +---------+ +---------+ +---------+

   +----------+ +----------+ +----------+ +----------+
   |PPT Service| |Typst Svc | |Gotenberg | |RTC Service|
   | :8100     | | :8200    | | :3000    | | :8300    |
   +----------+ +----------+ +----------+ +----------+

   +----------+ +----------+ +----------+
   |   SRS    | |  CoTURN  | | LiveKit  |
   | :1935    | | :3478    | | :7880    |
   +----------+ +----------+ +----------+
```

共 13 个容器，全部通过 `docker-compose.yml` 一键编排。
