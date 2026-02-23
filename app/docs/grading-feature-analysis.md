# 智能批改功能分析文档

## 一、Web 端功能分析

### 1.1 页面结构（3 个页面）

| 页面 | 路由 | 文件 | 功能 |
|------|------|------|------|
| **提交批改页** | `/grading` | `GradingSubmitPage.tsx` | 选择模式→填写信息→上传图片→SSE流式批改→实时进度 |
| **批改结果页** | `/grading/:submissionId` | `GradingResultPage.tsx` | 分数环→总评→逐题展开详情（答案对比+知识点+错因） |
| **学习画像页** | `/grading-dashboard` | `GradingDashboardPage.tsx` | 概览统计→得分趋势→学科分布→错因剖析→知识掌握度 |

### 1.2 提交批改页（GradingSubmitPage）详细交互

#### 1.2.1 双模式选择
- **通用作业助手（GENERAL）**：上传任意作业图片，AI 自动识别学科并批改
- **试卷批改（EXAM_PAPER）**：关联平台试卷，对照标准答案精准批改

#### 1.2.2 试卷选择器（仅试卷模式）
- 搜索试卷（关键词 + 学科筛选）
- 选中试卷后自动填充学科和年级
- API: `GET /api/grading/papers?keyword=&subject=&page=1&size=50`

#### 1.2.3 历史批改记录
- 显示最近 5 条记录（标题、学科、状态、得分）
- 点击已完成记录跳转结果页
- API: `GET /api/grading/history?page=1&size=5`

#### 1.2.4 作业信息表单
- **标题**（可选）
- **学科**（下拉选择，通用模式支持"自动识别"）
- **年级**（可选下拉）

学科列表：
```
自动识别（AI推断）、数学、语文、英语、物理、化学、生物、历史、地理、政治
```

年级列表：
```
一年级~六年级、初一~初三、高一~高三
```

#### 1.2.5 图片上传
- 最多 10 张图片
- 支持 JPG/PNG/HEIC（iOS HEIC 自动转 JPEG）
- 拖拽上传 + 点击上传
- 逐张上传到 `POST /api/file/upload/grading/homework`（FormData）
- 每张显示上传中/成功/失败状态
- 可删除已上传图片

#### 1.2.6 SSE 流式批改（核心）
- 提交到 `POST /api/grading/submit`（返回 SSE 流）
- 请求体：`{ gradingMode, title?, subject?, grade?, imageUrls, examPaperId? }`
- SSE 事件处理：

| 事件 | 数据 | 描述 |
|------|------|------|
| `step: 'ocr'` | `{ message }` | OCR 图像识别中 |
| `step: 'ocr_done'` | `{ message, questionCount }` | 识别完成，题目数量 |
| grading progress | `{ index, total, message }` | 第N题/共M题 批改中 |
| question_graded | `{ index, score, maxScore, comment, errorCategories, knowledgePoints }` | 单题批改完成 |
| done | `{ submissionId, totalScore, maxScore, overallComment }` | 全部完成 |
| error | `{ message }` | 错误 |

#### 1.2.7 进度面板（GradingProgressPanel）
- **阶段指示器**：图像识别 → AI 批改 → 生成报告（三步）
- **进度条**：N/M items (X%)
- **逐题结果列表**：实时追加，显示每题得分+评语+知识点
- **总评**：批改完成后显示 AI 核心建议
- **操作按钮**：查看详细报告 / 继续批改

### 1.3 批改结果页（GradingResultPage）

- API: `GET /api/grading/{submissionId}/result`
- **得分概览**：分数环（SVG 圆环动画）+ 正确率 + 正确/需改进/总数
- **总评卡片**：AI 整体评价
- **逐题详情**（可展开折叠）：
  - 状态图标（✅正确/⚠️部分/❌错误）
  - 题号 + 题型 + 得分
  - 展开内容：题目内容、学生答案 vs 参考答案、错误分类标签、知识点标签、AI 深度解析

### 1.4 学习画像页（GradingDashboardPage）

- API: `GET /api/grading/stats` + `GET /api/grading/profile`
- **概览卡片**：累计批改次数、平均得分率、覆盖学科数、薄弱知识点数
- **得分趋势图**：最近 10 次提交的柱状图（悬停显示详情）
- **学科得分分布**：各学科得分率进度条
- **错因深度剖析**：错误类型分布横向柱状图
- **各学科知识掌握度**：每学科一张卡片（掌握度%、知识点/薄弱/优势数、待攻克/优势知识点标签）

---

## 二、后端 API 清单

| # | 方法 | 路径 | 描述 | 响应类型 |
|---|------|------|------|----------|
| 1 | POST | `/api/grading/submit` | 提交批改（SSE流） | SseEmitter |
| 2 | GET | `/api/grading/{id}/status` | 查询批改状态 | SubmissionStatusResponse |
| 3 | GET | `/api/grading/{id}/result` | 获取批改结果 | GradingResultResponse |
| 4 | GET | `/api/grading/history` | 批改历史 | List<SubmissionStatusResponse> |
| 5 | GET | `/api/grading/papers` | 已发布试卷列表 | Map(records, total) |
| 6 | GET | `/api/grading/profile` | 全部知识画像 | List<SubjectProfileSummary> |
| 7 | GET | `/api/grading/profile/{code}` | 某学科画像 | SubjectProfileSummary |
| 8 | GET | `/api/grading/profile/{code}/weak` | 薄弱知识点 | List<KnowledgeProfileResponse> |
| 9 | GET | `/api/grading/stats` | 批改统计 | GradingStatsResponse |
| 10 | GET | `/api/grading/{id}/recommend` | 同类题推荐 | List<Map> |
| 11 | POST | `/api/file/upload/grading/homework` | 上传图片 | FileUploadResponse |

---

## 三、Flutter 已有资源

### 3.1 已生成的 API 模型（nova_api 包）
- `SubmitHomeworkRequest` — 提交请求
- `GradingResultResponse` / `QuestionGradingItem` — 批改结果
- `GradingStatsResponse` / `ScoreTrendItem` / `ErrorCategoryCount` — 统计数据
- `SubjectProfileSummary` / `KnowledgeProfileResponse` — 知识画像
- `SubmissionStatusResponse` — 提交状态

### 3.2 已生成的 API 方法（DefaultApi）
- `submitHomework()` — 但返回 SseEmitter（不能直接用，需 raw HTTP SSE）
- `getResult()` / `getStatus()` / `getHistory()`
- `getStats3()` / `getAllProfiles()`
- `getPublishedPapers()` / `getRecommendations()`

### 3.3 需要额外处理
- **SSE 流式响应**：Flutter 的 generated client 不支持 SSE，需用 raw Dio 或 http 包手动处理
- **图片上传**：需用 Dio MultipartFile
- **HEIC 转换**：iOS 相机拍摄可能产生 HEIC，需用 `image_picker` 或手动转换
- **相机拍照**：移动端核心交互，Web 端没有

---

## 四、Flutter 执行计划

### Phase 1: 基础设施（1 个文件）

| # | 任务 | 文件 | 描述 |
|---|------|------|------|
| 1.1 | GradingService | `features/grading/services/grading_service.dart` | 封装所有 API 调用：图片上传、SSE 提交（raw Dio 流式解析）、结果查询、历史、统计、画像 |

### Phase 2: 提交批改页（2 个文件）

| # | 任务 | 文件 | 描述 |
|---|------|------|------|
| 2.1 | 提交批改页 | `features/grading/pages/grading_submit_page.dart` | 模式选择→信息填写→图片上传（相机+相册）→提交批改 |
| 2.2 | 批改进度组件 | `features/grading/widgets/grading_progress_panel.dart` | 三阶段指示器+进度条+逐题结果+总评+操作按钮 |

### Phase 3: 结果页（1 个文件）

| # | 任务 | 文件 | 描述 |
|---|------|------|------|
| 3.1 | 批改结果页 | `features/grading/pages/grading_result_page.dart` | 分数环+总评+逐题可展开详情（答案对比+标签+AI解析） |

### Phase 4: 学习画像页（1 个文件）

| # | 任务 | 文件 | 描述 |
|---|------|------|------|
| 4.1 | 学习画像页 | `features/grading/pages/grading_dashboard_page.dart` | 概览统计+得分趋势+学科分布+错因分析+知识掌握度 |

### Phase 5: 集成与入口（2 个文件）

| # | 任务 | 文件 | 描述 |
|---|------|------|------|
| 5.1 | 路由入口 | `features/profile/pages/profile_page.dart` | 在"我的"页面添加"智能批改"入口 |
| 5.2 | 首页入口 | `features/home/pages/home_page.dart` | 可选：在首页添加快捷入口卡片 |

### Phase 6: 验证

| # | 任务 | 描述 |
|---|------|------|
| 6.1 | dart analyze | 确保 0 errors |
| 6.2 | 功能测试 | 拍照/相册上传 → SSE 进度 → 结果查看 → 画像查看 |

---

## 五、关键技术点

### 5.1 SSE 流式批改（最复杂部分）
```dart
// 不能用 generated client，需 raw Dio
final response = await dio.post(
  '/api/grading/submit',
  data: requestBody,
  options: Options(responseType: ResponseType.stream),
);
final stream = response.data.stream;
// 逐行解析 SSE: "data: {...}\n\n"
```

### 5.2 图片上传
```dart
final formData = FormData.fromMap({
  'file': await MultipartFile.fromFile(path, filename: name),
});
final response = await dio.post('/api/file/upload/grading/homework', data: formData);
```

### 5.3 移动端增强（Web 端没有）
- **相机拍照**：`image_picker` 包，直接拍摄作业照片
- **图片压缩**：上传前压缩，减少流量
- **离线缓存**：历史记录可缓存到本地 SQLite

### 5.4 依赖包
- `image_picker` — 相机/相册选图（已有）
- `dio` — HTTP 请求（已有）
- 无需额外新增依赖

---

## 六、文件数量预估

| 类型 | 数量 |
|------|------|
| Service | 1 |
| Pages | 3 |
| Widgets | 1 |
| 修改已有文件 | 2 |
| **总计** | **7 个文件** |
