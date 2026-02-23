# Flutter端会员权益系统实现方案

> 本文档基于Web端会员UI和后端API，详细描述如何在Flutter端实现完整的会员权益展示与管理功能。

---

## 1. 功能范围

参考Web端已有的三个页面/组件，Flutter端需实现：

| 功能模块 | Web端对应 | Flutter实现 | 优先级 |
|----------|-----------|-------------|--------|
| 会员卡片（首页嵌入） | `MembershipCard.tsx` | 嵌入个人中心/首页 | P0 |
| 会员中心页 | `MembershipPage.tsx` | 独立页面 | P0 |
| AI额度查看 | MembershipCard内嵌 | 会员卡片+会员中心 | P0 |
| 购买会员 | MembershipPage内购买 | 会员中心内 | P1 |
| 会员历史记录 | MembershipPage折叠区 | 会员中心内 | P2 |

---

## 2. 已有基础设施

### 2.1 已生成的API模型（OpenAPI Generator）

Flutter端已通过OpenAPI Generator生成了所有membership相关的模型和API方法：

**模型类（`app/lib/api/generated/lib/src/model/`）：**
- `MembershipPlan` — 会员计划（含所有配额字段）
- `UserMembership` — 用户会员记录
- `UserMembershipDetailResponse` — 会员详情（含计划信息+剩余额度）
- `PurchaseMembershipRequest` — 购买请求
- `GrantMembershipRequest` — 管理员开通请求

**API方法（`DefaultApi`）：**
- `listPlans()` — 获取计划列表
- `getCurrentMembership()` — 获取当前会员详情
- `getMembershipHistory()` — 获取会员历史
- `getAiQuota()` — 获取AI额度
- `purchaseMembership(...)` — 购买会员
- `cancelMembership()` — 取消会员

### 2.2 项目技术栈

- 状态管理：直接在StatefulWidget内管理（项目惯例）
- 网络请求：已生成的OpenAPI Dart客户端（基于dio）
- UI框架：TDesign Flutter组件库 + 自定义Widget
- 主题：已有AppTheme统一管理颜色/字体

---

## 3. 目录结构规划

```
app/lib/features/membership/
├── services/
│   └── membership_service.dart       # 服务层：API调用封装 + 数据模型转换
├── pages/
│   └── membership_center_page.dart   # 会员中心页（计划卡片 + AI额度 + 购买 + 历史）
└── widgets/
    ├── membership_card.dart          # 首页会员权益卡片（嵌入式）
    ├── plan_card.dart                # 单个计划卡片组件
    ├── ai_quota_panel.dart           # AI额度面板组件
    └── membership_history_list.dart  # 会员历史记录列表
```

---

## 4. 服务层设计 — `MembershipService`

### 4.1 数据模型

定义纯Dart模型类，与API生成的BuiltValue模型解耦：

```dart
/// 会员计划展示模型
class MembershipPlanData {
  final String id;
  final String name;
  final String code;        // FREE / BASIC / PRO / TEACHER
  final String description;
  final double price;
  final int durationDays;   // 0=永久
  final Map<String, QuotaLimit> quotas; // key: AI_CHAT/AI_PPT/AI_EXAM/AI_BOOK/AI_GRADING
  final bool courseMemberAccess;
}

class QuotaLimit {
  final int dailyLimit;     // -1=无限
  final int monthlyLimit;   // -1=无限
}

/// 当前会员状态展示模型
class MembershipDetail {
  final String? id;
  final String? orderNo;
  final String planCode;      // FREE/BASIC/PRO/TEACHER
  final String planName;
  final String? planDescription;
  final double planPrice;
  final int planDurationDays;
  final String status;        // FREE/PENDING/ACTIVE/EXPIRED/CANCELLED
  final DateTime? startTime;
  final DateTime? expireTime;
  final bool courseMemberAccess;
  final Map<String, QuotaRemaining> quotas;
}

class QuotaRemaining {
  final int dailyLimit;
  final int monthlyLimit;
  final int dailyRemaining;   // -1=无限
  final int monthlyRemaining; // -1=无限
}

/// AI额度查询结果
class AiQuotaData {
  final Map<String, QuotaInfo> quotas; // key: AI_CHAT etc.
}

class QuotaInfo {
  final int dailyRemaining;
  final int monthlyRemaining;
}
```

### 4.2 服务方法

```dart
class MembershipService {
  final DefaultApi _api;

  /// 获取所有会员计划（过滤TEACHER，按sortOrder排序）
  Future<List<MembershipPlanData>> getPlans();

  /// 获取当前会员详情（含剩余额度）
  Future<MembershipDetail> getCurrentMembershipDetail();

  /// 获取AI额度汇总
  Future<AiQuotaData> getAiQuota();

  /// 购买会员
  Future<String> purchaseMembership(String planId);

  /// 取消会员
  Future<void> cancelMembership();

  /// 获取会员历史记录
  Future<List<MembershipHistoryItem>> getMembershipHistory();
}
```

### 4.3 API模型到展示模型的转换

由于OpenAPI生成的模型使用BuiltValue（不可变对象），需要转换为简单Dart类：

```dart
MembershipPlanData _convertPlan(MembershipPlan plan) {
  return MembershipPlanData(
    id: plan.id?.toString() ?? '',
    name: plan.name ?? '',
    code: plan.code?.name ?? 'FREE',
    description: plan.description ?? '',
    price: plan.price?.toDouble() ?? 0,
    durationDays: plan.durationDays ?? 0,
    quotas: {
      'AI_CHAT': QuotaLimit(plan.aiChatDailyLimit ?? -1, plan.aiChatMonthlyLimit ?? -1),
      'AI_PPT': QuotaLimit(plan.aiPptDailyLimit ?? -1, plan.aiPptMonthlyLimit ?? -1),
      'AI_EXAM': QuotaLimit(plan.aiExamDailyLimit ?? -1, plan.aiExamMonthlyLimit ?? -1),
      'AI_BOOK': QuotaLimit(plan.aiBookDailyLimit ?? -1, plan.aiBookMonthlyLimit ?? -1),
      'AI_GRADING': QuotaLimit(plan.aiGradingDailyLimit ?? -1, plan.aiGradingMonthlyLimit ?? -1),
    },
    courseMemberAccess: plan.courseMemberAccess ?? false,
  );
}
```

---

## 5. UI组件设计

### 5.1 首页会员卡片 — `MembershipCard`

**参考Web端 `MembershipCard.tsx`**

布局结构：
```
┌──────────────────────────────────────┐
│ Header区（计划等级图标+名称+到期时间）│ ← 渐变背景色
│                        [升级按钮]     │ ← FREE用户显示
├──────────────────────────────────────┤
│ AI 额度                              │
│ ── AI 对话     今日10 / 本月200  ███ │ ← 进度条
│ ── PPT 生成    今日1 / 本月20    ███ │
│ ── AI 出题     无限              ─── │ ← 无限不显示进度条
│ ── 电子书AI    今日5 / 本月100   ███ │
│ ── 智能批改    今日3 / 本月60    ███ │
├──────────────────────────────────────┤
│         查看会员详情 →                │
└──────────────────────────────────────┘
```

**关键设计点：**
- 根据 `planCode` 映射不同渐变色（与Web一致）
- AI额度用LinearProgressIndicator展示消耗比例
- `-1`（无限制）显示"无限"文字，不显示进度条
- 点击底部跳转会员中心页

**颜色映射（与Web端对齐）：**
```dart
static const planColors = {
  'FREE': PlanColorScheme(
    gradient: [Color(0xFF9CA3AF), Color(0xFF6B7280)],
    bgColor: Color(0xFFF9FAFB),
    textColor: Color(0xFF4B5563),
  ),
  'BASIC': PlanColorScheme(
    gradient: [Color(0xFF3B82F6), Color(0xFF6366F1)],
    bgColor: Color(0xFFEFF6FF),
    textColor: Color(0xFF2563EB),
  ),
  'PRO': PlanColorScheme(
    gradient: [Color(0xFFF59E0B), Color(0xFFEA580C)],
    bgColor: Color(0xFFFFFBEB),
    textColor: Color(0xFFD97706),
  ),
  'TEACHER': PlanColorScheme(
    gradient: [Color(0xFFA855F7), Color(0xFFEC4899)],
    bgColor: Color(0xFFFAF5FF),
    textColor: Color(0xFF9333EA),
  ),
};
```

### 5.2 会员中心页 — `MembershipCenterPage`

**参考Web端 `MembershipPage.tsx`**

页面布局（CustomScrollView / ListView）：
```
[AppBar: 返回按钮 + "会员中心" + 副标题]

[今日AI额度面板]        ← AiQuotaPanel组件
  4宫格：AI对话/PPT生成/AI出题/电子书AI/智能批改
  每格显示：图标 + 名称 + 剩余次数

[计划卡片列表]           ← 水平滑动 / 垂直排列
  FREE / BASIC / PRO（过滤TEACHER）
  每张卡片包含：
  - 渐变头部（Crown图标+计划名+价格+有效期）
  - AI配额明细（4行：功能名 + 日/月限额）
  - 会员课访问权限
  - 操作按钮（当前计划/立即开通）

[会员记录（可折叠区域）]  ← ExpansionTile
  历史订单列表
  每条显示：订单号 + 有效期区间 + 状态标签

[支付说明提示卡片]
```

### 5.3 单个计划卡片 — `PlanCard`

```
┌─────────────────────────┐
│  渐变背景区               │
│  👑 Crown图标             │
│  基础版                   │ ← [当前] 标签（如果是当前计划）
│  ¥29.90 /30天            │
│  适合日常学习的进阶套餐    │
├─────────────────────────┤
│  AI对话      50/天·1000/月│
│  PPT生成     5/天·100/月  │
│  AI出题      15/天·300/月 │
│  电子书AI    30/天·600/月 │
│  智能批改    15/天·300/月 │
│  ─────────────────────  │
│  会员课访问    ✓          │
├─────────────────────────┤
│  [   立即开通   ]        │ ← 渐变按钮，当前计划则显示灰色"当前计划"
└─────────────────────────┘
```

### 5.4 AI额度面板 — `AiQuotaPanel`

```dart
// 5项AI功能的图标和标签映射
const aiFeatures = [
  AiFeatureInfo('AI_CHAT', 'AI 对话', Icons.chat_bubble_outline),
  AiFeatureInfo('AI_PPT', 'PPT 生成', Icons.slideshow),
  AiFeatureInfo('AI_EXAM', 'AI 出题', Icons.auto_awesome),
  AiFeatureInfo('AI_BOOK', '电子书AI', Icons.menu_book),
  AiFeatureInfo('AI_GRADING', '智能批改', Icons.fact_check),
];
```

展示逻辑：
- `dailyRemaining == -1 && monthlyRemaining == -1` → 显示"无限"
- 否则显示 `"${daily}次/天 · ${monthly}次/月"`

### 5.5 会员历史列表 — `MembershipHistoryList`

使用 `ExpansionTile` 包裹：
- 标题：`会员记录 (N)`
- 展开后：`ListView` 每条显示订单号、有效期、状态Chip
- 状态颜色映射（与Web一致）：
  - PENDING → 黄色
  - ACTIVE → 绿色
  - EXPIRED → 灰色
  - CANCELLED → 红色

---

## 6. 交互流程

### 6.1 进入会员中心

```
个人中心/首页会员卡片 → 点击"查看会员详情"或"升级"
  → Navigator.push → MembershipCenterPage
  → 并发请求：listPlans + getCurrentMembershipDetail + getMembershipHistory + getAiQuota
  → 数据加载完成，渲染页面
```

### 6.2 购买会员

```
点击"立即开通"按钮
  → 弹出确认对话框（AlertDialog / TDDialog）
    "确认购买 [基础版] ？价格 ¥29.90，有效期30天"
  → 确认 → MembershipService.purchaseMembership(planId)
  → 成功：SnackBar提示"订单创建成功！订单号：xxx，请等待管理员确认。"
  → 刷新页面数据
  → 失败：SnackBar提示错误信息
```

### 6.3 额度不足提示（全局）

在各AI功能页面调用AI时，后端返回 `code=42900/42901` 表示额度不足：

```dart
// 统一错误处理建议
if (response.code == 42900 || response.code == 42901) {
  showDialog(
    // "AI额度不足" 对话框
    // 显示具体提示信息
    // 底部按钮："查看会员" → 跳转会员中心
  );
}
```

---

## 7. 嵌入位置建议

### 7.1 首页会员卡片嵌入

推荐嵌入位置（优先级排序）：

1. **个人中心页顶部** — 用户头像/昵称下方，最自然的位置
2. **"我的"Tab页** — 如有独立"我的"页面
3. **聊天页智慧体中心** — 已有"智能工具"区，可在其上方加入会员卡片

### 7.2 会员中心入口

- 个人中心 → 会员卡片底部 "查看会员详情"
- 个人中心 → 设置列表项 "会员中心"
- AI功能额度不足弹窗 → "查看会员" 按钮

---

## 8. 实现步骤（推荐顺序）

### Phase 1：服务层 + 数据模型（0.5天）
1. 创建 `features/membership/services/membership_service.dart`
2. 定义展示模型类（MembershipPlanData, MembershipDetail, AiQuotaData等）
3. 封装API调用方法（转换BuiltValue → 展示模型）
4. 错误处理（网络异常、业务异常）

### Phase 2：会员中心页（1天）
1. 创建 `features/membership/pages/membership_center_page.dart`
2. 实现今日AI额度面板
3. 实现计划卡片列表（渐变UI + 配额明细 + 购买按钮）
4. 实现会员历史折叠列表
5. 实现支付说明提示

### Phase 3：首页会员卡片（0.5天）
1. 创建 `features/membership/widgets/membership_card.dart`
2. 实现会员等级展示 + AI额度进度条
3. 嵌入个人中心或首页

### Phase 4：全局额度不足处理（0.5天）
1. 统一处理42900/42901错误码
2. 弹出额度不足对话框 + 跳转会员中心

---

## 9. 关键注意事项

### 9.1 ID处理

后端使用雪花算法ID（超过JS安全整数范围）。Flutter端Dart的int是64位，可以安全处理。但API生成模型中ID类型为 `int?`，传参时注意不要丢失精度。

### 9.2 配额-1约定

所有限额字段 `-1` 表示无限制，UI需统一处理：
```dart
String formatLimit(int? value) {
  if (value == null || value == -1) return '无限';
  return '$value';
}

String formatQuota(int daily, int monthly) {
  final d = daily == -1 ? '无限' : '$daily';
  final m = monthly == -1 ? '无限' : '$monthly';
  if (daily == -1 && monthly == -1) return '无限';
  return '$d/天 · $m/月';
}
```

### 9.3 状态映射

```dart
const statusLabels = {
  'FREE': '免费版',
  'PENDING': '待支付',
  'ACTIVE': '生效中',
  'EXPIRED': '已过期',
  'CANCELLED': '已取消',
};

const planLabels = {
  'FREE': '免费版',
  'BASIC': '基础版',
  'PRO': '专业版',
  'TEACHER': '教师版',
};
```

### 9.4 暗黑模式

所有组件需同时支持亮色/暗色主题。使用 `Theme.of(context)` 获取当前主题色：
```dart
final isDark = Theme.of(context).brightness == Brightness.dark;
```

### 9.5 缓存策略

会员信息变化不频繁，建议：
- 会员详情：页面进入时刷新，结果缓存到内存
- 计划列表：缓存较长时间（计划很少变动）
- AI额度：每次打开会员卡片时刷新（变化频繁）

### 9.6 错误处理

```dart
try {
  final detail = await membershipService.getCurrentMembershipDetail();
  // 更新UI
} on DioException catch (e) {
  if (e.response?.statusCode == 401) {
    // Token过期，跳转登录
  } else {
    // 网络错误，显示重试
  }
} catch (e) {
  // 其他错误
  debugPrint('获取会员信息失败: $e');
}
```

---

## 10. 与Web端UI对比映射

| Web端组件/元素 | Flutter对应实现 |
|---------------|----------------|
| `Crown` (lucide图标) | `Icons.workspace_premium` 或自定义SVG |
| `Brain` (AI对话图标) | `Icons.chat_bubble_outline` |
| `FileText` (PPT图标) | `Icons.slideshow` |
| `Sparkles` (AI出题图标) | `Icons.auto_awesome` |
| `BookOpen` (电子书图标) | `Icons.menu_book` |
| `FileCheck` (批改图标) | `Icons.fact_check` |
| `Zap` (升级按钮图标) | `Icons.bolt` |
| `ArrowRight` | `Icons.arrow_forward_ios` |
| `History` | `Icons.history` |
| `AlertCircle` | `Icons.info_outline` |
| TailwindCSS渐变 `bg-gradient-to-br` | `BoxDecoration(gradient: LinearGradient(...))` |
| TailwindCSS rounded-2xl | `BorderRadius.circular(16)` |
| TailwindCSS shadow-sm | `BoxShadow(blurRadius: 4, ...)` |
| dark mode `dark:bg-gray-900` | `Theme.of(context).brightness == Brightness.dark` |

---

## 11. API请求/响应示例

### 获取当前会员详情

**请求：** `GET /api/membership/current`  
**Headers：** `Authorization: Bearer <token>`

**响应（FREE用户）：**
```json
{
  "code": 0,
  "data": {
    "userId": 1996401850335551490,
    "planId": 1,
    "planName": "免费版",
    "planCode": "FREE",
    "planDescription": "注册即享的基础权益",
    "planPrice": 0.00,
    "planDurationDays": 0,
    "aiChatDailyLimit": 10,
    "aiChatMonthlyLimit": 200,
    "aiPptDailyLimit": 1,
    "aiPptMonthlyLimit": 20,
    "aiExamDailyLimit": 3,
    "aiExamMonthlyLimit": 60,
    "aiBookDailyLimit": 5,
    "aiBookMonthlyLimit": 100,
    "aiGradingDailyLimit": 3,
    "aiGradingMonthlyLimit": 60,
    "courseMemberAccess": false,
    "aiChatDailyRemaining": 8,
    "aiChatMonthlyRemaining": 195,
    "aiPptDailyRemaining": 1,
    "aiPptMonthlyRemaining": 20,
    "aiExamDailyRemaining": 3,
    "aiExamMonthlyRemaining": 60,
    "aiBookDailyRemaining": 5,
    "aiBookMonthlyRemaining": 100,
    "aiGradingDailyRemaining": 3,
    "aiGradingMonthlyRemaining": 60,
    "status": "FREE"
  }
}
```

**响应（ACTIVE会员）：**
```json
{
  "code": 0,
  "data": {
    "id": 2001234567890123456,
    "userId": 1996401850335551490,
    "planId": 2,
    "orderNo": "MEM20250223170000123456",
    "startTime": "2025-02-20T10:00:00",
    "expireTime": "2025-03-22T10:00:00",
    "status": "ACTIVE",
    "planName": "基础版",
    "planCode": "BASIC",
    "planDescription": "适合日常学习的进阶套餐",
    "planPrice": 29.90,
    "planDurationDays": 30,
    "aiChatDailyLimit": 50,
    "aiChatMonthlyLimit": 1000,
    "courseMemberAccess": true,
    "aiChatDailyRemaining": 45,
    "aiChatMonthlyRemaining": 980,
    "..."
  }
}
```

### 购买会员

**请求：** `POST /api/membership/purchase`
```json
{ "planId": 2 }
```

**成功响应：**
```json
{
  "code": 0,
  "data": "MEM20250223170530789012"
}
```

**失败响应（已有会员）：**
```json
{
  "code": 40900,
  "message": "您已有生效中的会员，请到期后再购买"
}
```

---

## 12. 总结

Flutter端会员权益系统的实现核心在于：
1. **服务层**：封装API调用，将BuiltValue模型转换为展示模型
2. **会员卡片**：嵌入式组件，展示当前等级和AI剩余额度
3. **会员中心页**：完整的计划展示、购买、历史查看功能
4. **全局配额处理**：统一的额度不足提示 + 跳转引导

所有API接口后端已完善，Flutter端API客户端已通过OpenAPI自动生成，实现时主要工作是UI层开发和数据适配。
