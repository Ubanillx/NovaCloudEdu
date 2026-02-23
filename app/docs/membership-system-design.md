# 智云星课 — 会员权益系统详细设计文档

> 本文档详细描述智云星课（NovaCloudEdu）平台的会员权益系统的完整设计，涵盖数据库、后端领域模型、API接口、Web前端UI以及业务流程。

---

## 1. 系统概述

会员系统为平台核心变现模块，负责：
- **会员计划管理**：定义多等级会员套餐（FREE/BASIC/PRO/TEACHER）
- **AI功能配额控制**：按日/月限制5大AI功能的使用次数
- **订单与支付流程**：用户购买 → 管理员确认 → 会员激活
- **权益分发**：会员课访问、AI额度提升等

---

## 2. 数据库设计

### 2.1 membership_plan（会员计划表）

管理员配置的会员套餐定义表。

| 字段 | 类型 | 说明 |
|------|------|------|
| `id` | BIGSERIAL PK | 自增主键 |
| `name` | VARCHAR(128) | 计划名称（免费版/基础版/专业版/教师版） |
| `code` | VARCHAR(64) UNIQUE | 计划编码：`FREE` / `BASIC` / `PRO` / `TEACHER` |
| `description` | TEXT | 计划描述 |
| `price` | DECIMAL(10,2) | 价格（元），0表示免费 |
| `duration_days` | INT | 有效期天数，0表示永久 |
| `ai_chat_daily_limit` | INT | AI对话每日限额，-1无限制 |
| `ai_chat_monthly_limit` | INT | AI对话每月限额 |
| `ai_ppt_daily_limit` | INT | PPT生成每日限额 |
| `ai_ppt_monthly_limit` | INT | PPT生成每月限额 |
| `ai_exam_daily_limit` | INT | AI出题每日限额 |
| `ai_exam_monthly_limit` | INT | AI出题每月限额 |
| `ai_book_daily_limit` | INT | 电子书AI每日限额 |
| `ai_book_monthly_limit` | INT | 电子书AI每月限额 |
| `ai_grading_daily_limit` | INT | 智能批改每日限额 |
| `ai_grading_monthly_limit` | INT | 智能批改每月限额 |
| `course_member_access` | SMALLINT | 是否可访问会员课：0否 1是 |
| `is_default` | SMALLINT | 是否默认计划（FREE为1） |
| `sort_order` | INT | 排序，越小越靠前 |
| `create_time` | TIMESTAMP | 创建时间 |
| `update_time` | TIMESTAMP | 更新时间 |
| `is_delete` | SMALLINT | 逻辑删除 |

**种子数据（4个默认计划）：**

| 计划 | 编码 | 价格 | 有效期 | AI对话(日/月) | PPT(日/月) | AI出题(日/月) | 电子书AI(日/月) | 智能批改(日/月) | 会员课 |
|------|------|------|--------|---------------|------------|---------------|-----------------|-----------------|--------|
| 免费版 | FREE | 0 | 永久 | 10/200 | 1/20 | 3/60 | 5/100 | 3/60 | 否 |
| 基础版 | BASIC | 29.90 | 30天 | 50/1000 | 5/100 | 15/300 | 30/600 | 15/300 | 是 |
| 专业版 | PRO | 59.90 | 30天 | 无限 | 无限 | 无限 | 无限 | 无限 | 是 |
| 教师版 | TEACHER | 0 | 永久 | 100/2000 | 20/400 | 50/1000 | 50/1000 | 50/1000 | 是 |

### 2.2 user_membership（用户会员表）

记录用户的会员订购/激活/过期等状态。

| 字段 | 类型 | 说明 |
|------|------|------|
| `id` | BIGSERIAL PK | 自增主键 |
| `user_id` | BIGINT | 用户ID |
| `plan_id` | BIGINT | 关联会员计划ID |
| `order_no` | VARCHAR(64) | 订单号 |
| `start_time` | TIMESTAMP | 生效时间 |
| `expire_time` | TIMESTAMP | 到期时间，NULL表示永久 |
| `status` | SMALLINT | 0-待支付 1-生效中 2-已过期 3-已取消 |
| `create_time` | TIMESTAMP | 创建时间 |
| `update_time` | TIMESTAMP | 更新时间 |
| `is_delete` | SMALLINT | 逻辑删除 |

**索引：** `user_id`、`plan_id`、`status`、`order_no`、`expire_time`

### 2.3 ai_usage_record（AI使用记录表）

按用户+功能+日期维度聚合AI使用次数，用于配额检查。

| 字段 | 类型 | 说明 |
|------|------|------|
| `id` | BIGSERIAL PK | 自增主键 |
| `user_id` | BIGINT | 用户ID |
| `feature_type` | VARCHAR(32) | 功能类型：`AI_CHAT` / `AI_PPT` / `AI_EXAM` / `AI_BOOK` / `AI_GRADING` |
| `usage_date` | DATE | 使用日期 |
| `usage_count` | INT | 当日使用次数 |
| `create_time` | TIMESTAMP | 创建时间 |
| `update_time` | TIMESTAMP | 更新时间 |

**唯一约束：** `(user_id, feature_type, usage_date)` — 保证每用户每功能每天只有一条记录，通过 upsert 原子递增。

---

## 3. 后端领域模型（DDD四层架构）

### 3.1 领域层（domain/membership/）

#### 实体

| 实体 | 角色 | 说明 |
|------|------|------|
| `MembershipPlan` | 聚合根 | 会员计划，定义价格、有效期、各AI功能配额、会员课权限 |
| `UserMembership` | 聚合根 | 用户会员订购记录，管理状态机（PENDING → ACTIVE → EXPIRED/CANCELLED） |
| `AiUsageRecord` | 实体 | AI使用计数记录 |

#### 值对象

| 值对象 | 说明 |
|--------|------|
| `PlanCode` | 枚举：`FREE` / `BASIC` / `PRO` / `TEACHER` |
| `MembershipStatus` | 枚举：`PENDING(0)` / `ACTIVE(1)` / `EXPIRED(2)` / `CANCELLED(3)` |
| `AiFeatureType` | 枚举：`AI_CHAT` / `AI_PPT` / `AI_EXAM` / `AI_BOOK` / `AI_GRADING` |

#### 领域服务

**`AiUsageLimitService`** — 核心配额管控服务：

- `checkAndConsume(userId, featureType)` — 检查并消费一次AI额度
  - 管理员不受限制，直接放行
  - 检查每日限额 → 检查每月限额 → 原子递增计数
  - 额度不足抛出 `BusinessException(42900/42901)`
  - 达到80%告警线时邮件通知用户
- `getRemainingDailyQuota(userId, featureType)` — 查询某功能今日剩余
- `getRemainingMonthlyQuota(userId, featureType)` — 查询某功能本月剩余
- `getAllRemainingQuota(userId)` — 批量查询所有功能剩余额度（优化版：4次DB查询）
- `getUserPlan(userId)` — 获取用户当前生效计划
  - 优先级：生效中的会员 > 教师角色自动使用TEACHER计划 > 默认FREE计划

#### 仓储接口

| 仓储 | 关键方法 |
|------|----------|
| `MembershipPlanRepository` | `findById`, `findByCode`, `findDefault`, `findAll`, `save`, `deleteById` |
| `UserMembershipRepository` | `findActiveByUserId`, `findLatestByUserId`, `findByOrderNo`, `findByStatus(分页)`, `findExpiredActive` |
| `AiUsageRecordRepository` | `findByUserIdAndFeatureTypeAndDate`, `findByUserIdAndDate(批量)`, `sumMonthlyUsage`, `sumAllMonthlyUsage(批量)`, `incrementUsage(upsert)` |

### 3.2 应用层（application/membership/）

**`MembershipApplicationService`** — 会员业务编排：

| 方法 | 说明 |
|------|------|
| `listPlans()` | 获取所有未删除的会员计划（按sortOrder排序） |
| `getPlan(planId)` | 获取单个计划详情 |
| `createPlan(...)` | 管理员创建会员计划 |
| `updatePlan(...)` | 管理员更新计划基本信息 |
| `updatePlanQuota(...)` | 管理员修改计划AI配额 |
| `deletePlan(planId)` | 管理员删除计划（逻辑删除） |
| `purchaseMembership(userId, planId)` | 用户购买会员（创建PENDING订单，邮件通知管理员和用户） |
| `confirmMembershipPayment(orderNo)` | 管理员确认支付（PENDING→ACTIVE，计算过期时间） |
| `grantMembership(userId, planId)` | 管理员直接为用户开通会员（旧会员自动取消） |
| `cancelMembership(userId)` | 取消会员 |
| `getCurrentMembership(userId)` | 查询当前会员状态（优先ACTIVE，其次最新记录） |
| `getCurrentMembershipDetail(userId)` | 查询会员详情（含计划信息+剩余配额） |
| `getMembershipHistory(userId)` | 查询历史会员记录 |
| `getAiQuota(userId)` | 查询所有AI功能剩余额度 |
| `listMembershipsByStatus(status, page, size)` | 管理员分页查询会员列表 |
| `countByStatus(status)` | 统计各状态会员数量 |

### 3.3 接口层

#### 用户端接口 — `MembershipController`

基础路径：`/api/membership`

| 方法 | 路径 | 说明 | 认证 |
|------|------|------|------|
| GET | `/plans` | 获取所有会员计划 | 公开（Security白名单） |
| GET | `/plans/{planId}` | 获取计划详情 | 需登录 |
| POST | `/purchase` | 购买会员 | 需登录 |
| GET | `/current` | 查询我的当前会员详情 | 需登录 |
| GET | `/history` | 查询我的会员历史 | 需登录 |
| GET | `/ai-quota` | 查询我的AI额度 | 需登录 |
| POST | `/cancel` | 取消会员 | 需登录 |

**关键DTO — `UserMembershipDetailResponse`：**

返回当前会员的完整详情，包含：
- 会员基础信息：`id`, `userId`, `planId`, `orderNo`, `startTime`, `expireTime`, `status`
- 计划信息：`planName`, `planCode`, `planDescription`, `planPrice`, `planDurationDays`
- 计划限额：`aiChatDailyLimit/MonthlyLimit`, `aiPptDailyLimit/MonthlyLimit`, ...（5组共10个字段）
- **剩余额度**：`aiChatDailyRemaining/MonthlyRemaining`, ...（5组共10个字段）
- 权益：`courseMemberAccess`

#### 管理员端接口 — `MembershipAdminController`

基础路径：`/api/admin/membership`

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/plans` | 获取所有计划 |
| POST | `/plans` | 创建计划 |
| PUT | `/plans` | 更新计划基本信息 |
| PUT | `/plans/{planId}/quota` | 修改计划AI配额 |
| DELETE | `/plans/{planId}` | 删除计划 |
| POST | `/confirm?orderNo=xxx` | 确认会员支付 |
| POST | `/grant` | 为用户开通会员 |
| POST | `/cancel/{userId}` | 取消用户会员 |
| GET | `/list?status=&page=&size=` | 按状态查询会员列表 |
| GET | `/statistics` | 会员统计（各状态数量） |
| GET | `/users/{userId}/ai-quota` | 查询指定用户AI额度 |

---

## 4. AI配额接入点

会员配额检查已接入以下5个AI功能模块（在调用AI前执行 `aiUsageLimitService.checkAndConsume`）：

| AI功能 | AiFeatureType | 接入位置 |
|--------|---------------|----------|
| AI对话 | `AI_CHAT` | `AiChatApplicationService` |
| PPT生成 | `AI_PPT` | `PptGenerationService` |
| AI出题 | `AI_EXAM` | `AiQuestionGenerationService` |
| 电子书AI | `AI_BOOK` | `AiBookController` |
| 智能批改 | `AI_GRADING` | `HomeworkGradingApplicationService` |

**配额检查流程：**
```
用户请求 → 检查是否管理员（跳过）
         → 获取用户当前计划（ACTIVE会员 > 教师角色 > FREE）
         → 检查每日限额（-1无限制，否则对比当日使用数）
         → 检查每月限额
         → 原子递增 ai_usage_record
         → 达到80%告警线发邮件
         → 额度耗尽抛异常 + 发邮件
```

---

## 5. Web前端UI说明

### 5.1 首页会员卡片（MembershipCard）

位置：首页侧边栏

功能：
- 显示当前会员等级（带渐变色图标）
- 显示到期时间或"永久有效"/"未开通会员"
- 展示5项AI功能的剩余额度进度条
- FREE用户显示"升级"按钮，跳转会员中心

API调用：`GET /api/membership/current` → `UserMembershipDetailResponse`

计划颜色映射：
- **FREE**：灰色（gray）
- **BASIC**：蓝色（blue→indigo）
- **PRO**：金色（amber→orange）
- **TEACHER**：紫色（purple→pink）

### 5.2 会员中心页（MembershipPage）

路径：`/membership`

功能模块：
1. **今日AI额度面板** — 4宫格展示AI对话/PPT生成/AI出题/电子书AI的剩余次数
2. **计划卡片（3列网格）** — 展示FREE/BASIC/PRO三个计划（TEACHER过滤不显示）
   - 渐变色头部（Crown图标 + 计划名 + 价格 + 有效期）
   - 4项AI功能配额明细（日/月）
   - 会员课访问权限（勾/叉）
   - 当前计划显示"当前"标签，其他显示"立即开通"按钮
3. **会员记录（可折叠）** — 历史订单列表，显示订单号、有效期、状态标签
4. **支付说明** — 线下支付提示信息

API调用：
- `GET /api/membership/plans` — 获取计划列表
- `GET /api/membership/current` — 当前会员
- `GET /api/membership/history` — 会员历史
- `GET /api/membership/ai-quota` — AI额度
- `POST /api/membership/purchase` — 购买会员

### 5.3 管理后台会员管理（MembershipManagementPage）

路径：管理后台 → 会员管理

功能模块：
1. **统计卡片（4列）** — 待支付/生效中/已过期/已取消的会员数量
2. **双Tab切换**：
   - **计划管理** — 表格展示所有计划的配额信息，支持编辑配额（弹窗）
   - **会员列表** — 按状态筛选，分页展示会员记录，支持确认支付/取消会员操作
3. **开通会员弹窗** — 管理员为指定用户直接开通会员

---

## 6. 业务流程

### 6.1 用户购买会员流程

```
用户选择计划 → POST /api/membership/purchase
  → 校验：非FREE计划、无生效中会员
  → 生成订单号（MEM + 时间戳 + 随机数）
  → 创建 UserMembership (status=PENDING)
  → 邮件通知管理员（新订单）+ 邮件通知用户（订单创建）
  → 返回订单号
```

### 6.2 管理员确认支付流程

```
管理员确认 → POST /api/admin/membership/confirm?orderNo=xxx
  → 查找订单 → 获取关联计划
  → 调用 membership.activateWithExpiry(durationDays)
    → status: PENDING → ACTIVE
    → startTime: now()
    → expireTime: now() + durationDays（0天则为null=永久）
  → 保存更新
  → 邮件通知管理员（已激活）+ 邮件通知用户（会员已生效）
```

### 6.3 管理员直接开通流程

```
管理员开通 → POST /api/admin/membership/grant
  → 如有生效中会员 → 先取消
  → 生成订单号 → 创建 UserMembership (status=ACTIVE)
  → 邮件通知用户（会员已开通）
```

### 6.4 会员到期处理

`UserMembership.isActive()` 实时判断：
```java
return status == ACTIVE 
    && (expireTime == null || expireTime.isAfter(now()));
```
- `expireTime == null`：永久会员
- `expireTime` 已过：视为过期
- 可通过 `findExpiredActive()` 批量查询并标记过期

### 6.5 教师角色特殊逻辑

教师（role=teacher）即使未购买会员，也自动享受TEACHER计划权益：
```
getUserPlan(userId):
  1. 查找生效中的会员 → 有则返回其计划
  2. 查用户角色 → teacher → 返回TEACHER计划
  3. 返回默认FREE计划
```

---

## 7. 邮件通知

会员系统触发的邮件通知：

| 事件 | 接收人 | 内容 |
|------|--------|------|
| 用户购买会员 | 管理员 | 新订单通知（订单号、计划、金额、用户名） |
| 用户购买会员 | 用户 | 订单创建确认（订单号、计划、金额） |
| 管理员确认支付 | 管理员 | 会员已激活通知 |
| 管理员确认支付 | 用户 | 会员已生效通知（计划名、到期时间） |
| 管理员直接开通 | 用户 | 会员已开通通知 |
| 取消会员 | 用户 | 会员已取消通知 |
| AI额度达80% | 用户 | 额度即将用尽警告 |
| AI额度耗尽 | 用户 | 额度已用完通知 |

---

## 8. Security配置

白名单（无需认证）：
- `GET /api/membership/plans` — 计划列表公开查看
- `/api/payment/callback/**` — 支付回调预留

管理员接口（`/api/admin/membership/**`）需管理员权限。

---

## 9. 关键设计决策

1. **配额-1约定**：所有限额字段 `-1` 表示无限制，前后端统一遵循
2. **按天聚合**：`ai_usage_record` 每用户每功能每天一条记录，通过 upsert 原子递增，避免并发问题
3. **批量查询优化**：`getAllRemainingQuota` 仅4次DB查询（1次User + 1次Plan + 1次当日记录 + 1次月度汇总），替代原来的 N*8 次查询
4. **教师免费**：教师角色自动享受TEACHER计划，无需购买
5. **线下支付**：当前采用管理员手动确认模式，支付网关（Alipay/WechatPay）为预留空壳
6. **课程对齐**：会员课购买时如果用户已是会员（courseMemberAccess=true），自动免费开通
