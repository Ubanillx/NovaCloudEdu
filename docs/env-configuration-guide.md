# NovaCloudEdu 环境变量配置指南

> 本文档说明 `.env` 文件中每个配置项的用途、获取方式和申请地址。
>
> 使用前请将 `docker/.env.example` 复制为 `docker/.env`，然后按需填写。

---

## 一、本地基础设施（无需申请，Docker 自动创建）

以下配置均为本地 Docker 容器服务，只需设置密码即可，**不需要任何外部账号**。

### PostgreSQL 数据库

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `DB_NAME` | 数据库名 | `novacloudedu` |
| `DB_USERNAME` | 数据库用户名 | `nova` |
| `DB_PASSWORD` | 数据库密码 | `changeme_postgres_password_123` |
| `DB_PORT` | 宿主机映射端口 | `5432` |

> 直接修改密码为自定义强密码即可，无需额外操作。

### Redis 缓存

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `REDIS_PASSWORD` | Redis 访问密码 | `changeme_redis_password_123` |
| `REDIS_PORT` | 宿主机映射端口 | `6379` |

### Neo4j 图数据库

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `NEO4J_AUTH` | 认证格式 `用户名/密码` | `neo4j/changeme_neo4j_password_123` |
| `NEO4J_PASSWORD` | 密码（传给后端） | `changeme_neo4j_password_123` |
| `NEO4J_HTTP_PORT` | Web 控制台端口 | `7474` |
| `NEO4J_BOLT_PORT` | Bolt 协议端口 | `7687` |

> `NEO4J_AUTH` 和 `NEO4J_PASSWORD` 中的密码部分需要保持一致。

### Elasticsearch 搜索引擎

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `ES_PORT` | HTTP 端口 | `9200` |
| `ES_TRANSPORT_PORT` | 集群通信端口 | `9300` |

> 当前配置为单节点模式，已关闭安全认证，无需额外设置。

---

## 二、应用安全配置（本地生成即可）

### JWT 密钥

| 变量 | 说明 |
|------|------|
| `JWT_SECRET` | JWT 签名密钥，至少 32 字符 |

> 可使用以下命令生成随机密钥：
> ```bash
> openssl rand -base64 48
> ```

### 书籍内容加密

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `BOOK_ENCRYPTION_ENABLED` | 是否启用 | `false` |
| `BOOK_ENCRYPTION_KEY` | AES 加密密钥 | `NovaCloudEduBookKey1` |

> 开发环境可保持关闭。生产环境启用后需自定义密钥。

---

## 三、文档处理服务（Docker 自带，无需申请）

### OnlyOffice 文档编辑

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `ONLYOFFICE_PORT` | 宿主机映射端口 | `9980` |
| `ONLYOFFICE_JWT_ENABLED` | 是否启用 JWT 鉴权 | `true` |
| `ONLYOFFICE_JWT_SECRET` | JWT 密钥 | `changeme_onlyoffice_secret_1234567` |

### Gotenberg PDF 转换

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `GOTENBERG_PORT` | 宿主机映射端口 | `3000` |

---

## 四、实时音视频服务（Docker 自带，无需申请）

### SRS 直播媒体服务器

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `SRS_RTMP_PORT` | RTMP 推流端口 | `1935` |
| `SRS_HTTP_PORT` | HTTP-FLV/HLS 拉流端口 | `8085` |
| `SRS_API_PORT` | API 端口 | `1985` |

### coturn TURN/STUN 中继

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `TURN_REALM` | TURN 域名 | `novacloudedu.com` |
| `TURN_USER` | TURN 用户名 | `nova` |
| `TURN_PASSWORD` | TURN 密码 | `changeme_turn_password` |

### LiveKit SFU

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `LIVEKIT_PORT` | HTTP 端口 | `7880` |
| `LIVEKIT_RTC_TCP` | RTC TCP 端口 | `7881` |
| `LIVEKIT_API_KEY` | API Key | `devkey` |
| `LIVEKIT_API_SECRET` | API Secret | `devsecret` |

> 开发环境使用默认值即可。生产环境需自定义 API Key/Secret。

---

## 五、阿里云服务（需注册阿里云账号）

> 注册地址：https://www.aliyun.com
>
> 控制台：https://home.console.aliyun.com

### 阿里云 OSS 对象存储

| 变量 | 说明 |
|------|------|
| `ALIYUN_OSS_ENDPOINT` | Bucket 所在地域的 Endpoint |
| `ALIYUN_OSS_ACCESS_KEY_ID` | AccessKey ID |
| `ALIYUN_OSS_ACCESS_KEY_SECRET` | AccessKey Secret |
| `ALIYUN_OSS_BUCKET_NAME` | Bucket 名称 |
| `ALIYUN_OSS_DOMAIN` | 自定义域名（可选） |

**获取步骤：**

1. 登录 [阿里云控制台](https://home.console.aliyun.com)
2. 进入 [OSS 管理控制台](https://oss.console.aliyun.com)
3. 创建 Bucket，记录 Bucket 名称和 Endpoint
4. 进入 [AccessKey 管理](https://ram.console.aliyun.com/manage/ak) 创建子账号 AccessKey（推荐 RAM 子账号）
5. 为子账号授予 `AliyunOSSFullAccess` 权限

### 阿里云 NLS 语音服务（ASR/TTS）

| 变量 | 说明 |
|------|------|
| `ALIYUN_NLS_ACCESS_KEY_ID` | AccessKey ID |
| `ALIYUN_NLS_ACCESS_KEY_SECRET` | AccessKey Secret |
| `ALIYUN_NLS_APP_KEY` | NLS 应用 AppKey |

**获取步骤：**

1. 进入 [智能语音交互控制台](https://nls-portal.console.aliyun.com)
2. 开通服务 → 创建项目 → 获取 AppKey
3. AccessKey 同 OSS，建议使用同一子账号

---

## 六、AI 模型 API Key

### DashScope 通义千问（必选，核心 AI 能力）

| 变量 | 说明 |
|------|------|
| `DASHSCOPE_API_KEY` | DashScope API Key |

**获取步骤：**

1. 访问 [DashScope 控制台](https://dashscope.console.aliyun.com)
2. 开通"模型服务灵积"
3. 进入 [API Key 管理](https://dashscope.console.aliyun.com/apiKey) 创建 Key
4. 新用户有免费额度

> 这是系统核心 AI 能力的必选项，不配置则 AI 对话、批改、PPT 生成等功能均不可用。

### 可选 AI 提供商

以下均为可选，设置 `*_ENABLED=true` 并填入 API Key 即可启用。不启用不影响系统运行。

| 提供商 | 变量前缀 | 申请地址 | 说明 |
|--------|----------|----------|------|
| **OpenAI** | `OPENAI_*` | https://platform.openai.com/api-keys | GPT-4o 系列，需境外支付方式 |
| **DeepSeek** | `DEEPSEEK_*` | https://platform.deepseek.com/api_keys | 国产推理模型，价格低 |
| **Moonshot** (月之暗面) | `MOONSHOT_*` | https://platform.moonshot.cn/console/api-keys | 128K 长文本，注册送额度 |
| **智谱 GLM** | `ZHIPU_*` | https://open.bigmodel.cn/usercenter/apikeys | GLM-4 系列，注册送额度 |
| **SiliconFlow** (硅基流动) | `SILICONFLOW_*` | https://cloud.siliconflow.cn/account/ak | 多模型聚合，注册送额度 |
| **OpenRouter** | `OPENROUTER_*` | https://openrouter.ai/keys | 海外多模型路由，支持信用卡/加密货币 |

---

## 七、百度 OCR 图片文字识别

| 变量 | 说明 |
|------|------|
| `BAIDU_OCR_APP_ID` | 应用 ID |
| `BAIDU_OCR_API_KEY` | API Key |
| `BAIDU_OCR_SECRET_KEY` | Secret Key |

**获取步骤：**

1. 访问 [百度智能云控制台](https://console.bce.baidu.com)
2. 进入 [文字识别](https://console.bce.baidu.com/ai/#/ai/ocr/overview/index) 服务
3. 创建应用 → 获取 AppID、API Key、Secret Key
4. 每月有免费调用额度

---

## 八、Tavily AI 联网搜索

| 变量 | 说明 |
|------|------|
| `TAVILY_API_KEY` | Tavily API Key |

**获取步骤：**

1. 访问 https://tavily.com
2. 注册账号 → Dashboard → API Keys
3. 免费套餐每月 1000 次搜索

> 用于 PPT Agent 联网搜索素材，不配置则 Agent 无法联网。

---

## 九、邮件和短信

### SMTP 邮件

| 变量 | 说明 |
|------|------|
| `MAIL_USERNAME` | 发件邮箱地址 |
| `MAIL_PASSWORD` | 邮箱授权码（非登录密码） |

**常用邮箱 SMTP 获取方式：**

| 邮箱 | 设置入口 | 说明 |
|------|----------|------|
| QQ 邮箱 | 设置 → 账户 → POP3/SMTP | 开启后生成授权码 |
| 163 邮箱 | 设置 → POP3/SMTP/IMAP | 开启后设置授权码 |
| Gmail | Google 账户 → 安全性 → 应用专用密码 | 需开启两步验证 |

> 后端 `application.yml` 中 SMTP host 默认为 `smtp.qq.com`，如使用其他邮箱需同步修改。

### 管理员邮件通知

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `ADMIN_EMAIL_ENABLED` | 是否启用管理员通知 | `true` |
| `ADMIN_EMAIL_RECIPIENTS` | 接收通知的邮箱，逗号分隔 | `admin@example.com` |

### SMS 短信

| 变量 | 说明 |
|------|------|
| `SMS_URL` | 短信服务 API 地址 |
| `SMS_TOKEN` | 短信服务鉴权 Token |

> 短信服务需根据实际对接的短信平台填写。

---

## 十、PPT Agent 配置（无需申请）

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `PPT_AGENT_CONCURRENCY` | 并发生成数 | `3` |
| `PPT_AGENT_QUALITY_THRESHOLD` | 质量评分阈值 | `65` |
| `PPT_AGENT_MAX_REPAIR_ROUNDS` | 最大修复轮次 | `2` |
| `PPT_AGENT_SLIDE_SCORE_THRESHOLD` | 单页评分阈值 | `60` |
| `PPT_AGENT_IMAGE_SEARCH_ENABLED` | 是否启用图片搜索 | `false` |

> 纯调优参数，使用默认值即可。

---

## 十一、应用服务端口（无需申请）

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `BACKEND_PORT` | Java 后端端口 | `8080` |
| `PPT_SERVICE_PORT` | PPT 生成服务端口 | `8100` |
| `TYPST_SERVICE_PORT` | 试卷排版服务端口 | `8200` |
| `RTC_WS_PORT` | RTC 信令服务端口 | `8300` |
| `SERVER_BASE_URL` | 后端公网地址 | `http://localhost:8080` |

---

## 快速开始清单

**最小可运行配置**（仅需修改密码）：

```bash
cp docker/.env.example docker/.env
# 修改 .env 中的密码为自定义值即可启动
docker compose -f docker/docker-compose.yml up -d
```

**完整功能需要额外配置**：

- [ ] `DASHSCOPE_API_KEY` — AI 核心能力（必选）
- [ ] `ALIYUN_OSS_*` — 文件上传
- [ ] `MAIL_USERNAME` + `MAIL_PASSWORD` — 邮件验证码
- [ ] `BAIDU_OCR_*` — 图片文字识别（智能批改）
- [ ] `ALIYUN_NLS_*` — 语音识别/合成
- [ ] `TAVILY_API_KEY` — PPT Agent 联网搜索
- [ ] `SMS_*` — 短信验证码
