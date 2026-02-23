# Flutter 加载动画审计报告

## 现有加载组件（`widgets/common/loading_widget.dart`）

| 组件 | 说明 | 使用情况 |
|------|------|----------|
| `LoadingWidget` | Win11 风格圆环加载（自定义 CustomPaint） | 广泛使用，25+ 处 |
| `PageLoading` | 全屏加载页（包裹 LoadingWidget） | 8 处页面级加载 |
| `LoadingOverlay` | 加载遮罩层 | **未使用** |
| `ShimmerLoading` | 骨架屏闪烁效果 | 仅被 ListSkeleton 内部使用 |
| `ListSkeleton` | 列表骨架屏 | 仅 circle_page.dart 使用（5 处） |
| `CircularProgressIndicator` | Flutter 原生圆形进度条 | 散布于 20+ 文件，**不统一** |

---

## 各页面/组件当前加载方式

### A. 页面级加载（整页替换为加载状态）

| 文件 | 当前组件 | 应改为 |
|------|----------|--------|
| `course/pages/bookshelf_page.dart` | `PageLoading()` | ✅ 保持 |
| `course/pages/book_reader_page.dart` | `PageLoading()` | ✅ 保持 |
| `course/pages/course_detail_page.dart` | `PageLoading(message:...)` | ✅ 保持 |
| `course/pages/schedule_page.dart` | `PageLoading(message:...)` | ✅ 保持 |
| `home/daily_article/pages/daily_article_page.dart` | `PageLoading(message:...)` | ✅ 保持 |
| `home/daily_word/pages/daily_word_page.dart` | `PageLoading(message:...)` | ✅ 保持 |
| `home/daily_word/pages/word_book_page.dart` | `PageLoading(message:...)` | ✅ 保持 |
| `circle/pages/user_posts_page.dart` | `CircularProgressIndicator()` | ❌ → PageLoading |
| `circle/pages/my_favourites_page.dart` | `CircularProgressIndicator()` | ❌ → PageLoading |

### B. 组件/Tab 级加载（页面内局部区域加载）

| 文件 | 场景 | 当前组件 | 应改为 |
|------|------|----------|--------|
| `chat/pages/chat_page.dart` | 会话/好友/群组 Tab | `LoadingWidget` | ❌ → 骨架屏 |
| `chat/pages/ai_session_list_page.dart` | AI 会话列表 | `LoadingWidget` | ❌ → 骨架屏 |
| `chat/pages/ai_chat_page.dart` | 初始化 | `LoadingWidget` | ❌ → 骨架屏 |
| `chat/pages/group_chat_page.dart` | 消息列表 | `LoadingWidget` | ❌ → 骨架屏 |
| `chat/pages/private_chat_page.dart` | 消息列表 | `LoadingWidget` | ❌ → 骨架屏 |
| `chat/pages/friend_requests_page.dart` | 收到/发出 Tab | `LoadingWidget` | ❌ → 骨架屏 |
| `chat/pages/friends_list_page.dart` | 好友列表 | `LoadingWidget` | ❌ → 骨架屏 |
| `chat/pages/search_user_page.dart` | 搜索结果 | `LoadingWidget` | ❌ → 骨架屏 |
| `circle/pages/circle_page.dart` | 帖子列表 | `ListSkeleton` | ✅ 保持 |
| `circle/pages/search_page.dart` | 搜索结果 | `LoadingWidget` | ❌ → 骨架屏 |
| `circle/pages/post_detail_page.dart` | 帖子详情 | `LoadingWidget` | ❌ → 骨架屏 |
| `circle/pages/user_profile_page.dart` | 用户资料 | `LoadingWidget` | ❌ → 骨架屏 |
| `profile/pages/profile_page.dart` | 学习计划 | `LoadingWidget` | ❌ → 骨架屏 |
| `profile/pages/profile_detail_page.dart` | 个人资料 | `LoadingWidget` | ❌ → 骨架屏 |
| `profile/pages/study_plan_page.dart` | 学习计划 | `LoadingWidget` | ❌ → 骨架屏 |
| `profile/pages/feedback_page.dart` | 反馈列表 | `LoadingWidget` | ❌ → 骨架屏 |
| `profile/pages/feedback_detail_page.dart` | 反馈详情 | `LoadingWidget` | ❌ → 骨架屏 |
| `profile/pages/checkin_ranking_page.dart` | 排行榜 | `LoadingWidget` | ❌ → 骨架屏 |
| `home/pages/announcement_list_page.dart` | 公告列表 | `LoadingWidget` | ❌ → 骨架屏 |
| `home/pages/announcement_detail_page.dart` | 公告详情 | `LoadingWidget` | ❌ → 骨架屏 |
| `home/pages/home_page.dart` | 各卡片区域 | `CircularProgressIndicator` | ❌ → 骨架屏 |
| `home/pages/search_page.dart` | 搜索结果 | `CircularProgressIndicator` | ❌ → 骨架屏 |
| `course/pages/course_page.dart` | 课程列表 | `PageLoading` | ❌ → 骨架屏 |
| `course/pages/course_search_page.dart` | 搜索结果 | `PageLoading` | ❌ → 骨架屏 |
| `course/pages/task_list_page.dart` | 任务列表 | `PageLoading` | ❌ → 骨架屏 |
| `course/widgets/paged_chapter_reader.dart` | 章节加载 | `LoadingWidget` | ✅ 保持（特殊场景） |

### C. 按钮内加载（操作进行中）

| 文件 | 场景 | 当前组件 | 应改为 |
|------|------|----------|--------|
| `auth/widgets/auth_ui_components.dart` | 登录/注册按钮 | `CircularProgressIndicator(strokeWidth:2.5)` | ✅ 保持（标准模式） |
| `circle/pages/post_detail_page.dart` | 发送评论按钮 | `CircularProgressIndicator(strokeWidth:2)` | ✅ 保持 |
| `circle/pages/user_profile_page.dart` | 关注按钮 | `CircularProgressIndicator(strokeWidth:2)` | ✅ 保持 |
| `circle/pages/post_edit_page.dart` | 发布按钮 | `CircularProgressIndicator(strokeWidth:2)` | ✅ 保持 |
| `profile/pages/phone_edit_page.dart` | 保存按钮 | `CircularProgressIndicator(strokeWidth:2)` | ✅ 保持 |
| `profile/pages/profile_detail_page.dart` | 保存/上传按钮 | `CircularProgressIndicator(strokeWidth:2)` | ✅ 保持 |
| `profile/pages/profile_page.dart` | 签到按钮 | `CircularProgressIndicator(strokeWidth:2.5)` | ✅ 保持 |
| `profile/pages/settings_page.dart` | 退出/缓存按钮 | `CircularProgressIndicator(strokeWidth:2.5)` | ✅ 保持 |
| `profile/pages/feedback_detail_page.dart` | 删除按钮 | `CircularProgressIndicator(strokeWidth:2)` | ✅ 保持 |

### D. 加载更多（列表底部触发）

| 文件 | 当前组件 | 应改为 |
|------|----------|--------|
| `circle/pages/circle_page.dart` | `LoadingWidget(size:24)` | ✅ 保持 |
| `circle/pages/my_favourites_page.dart` | `CircularProgressIndicator()` | ❌ → LoadingWidget(size:24) |
| `circle/pages/post_detail_page.dart` | `CircularProgressIndicator()` | ❌ → LoadingWidget(size:24) |
| `home/pages/announcement_list_page.dart` | `CircularProgressIndicator(strokeWidth:2)` | ❌ → LoadingWidget(size:24) |
| `profile/pages/feedback_page.dart` | `LoadingWidget(size:24)` | ✅ 保持 |

### E. 图片/媒体加载（占位符）

| 文件 | 场景 | 当前组件 | 应改为 |
|------|------|----------|--------|
| `circle/pages/post_detail_page.dart` | 图片占位 | `CircularProgressIndicator()` | ❌ → ShimmerLoading |
| `chat/widgets/message_content_widget.dart` | 图片/文件加载 | `CircularProgressIndicator` | ❌ → ShimmerLoading |
| `course/pages/bookshelf_page.dart` | 封面占位 | `CircularProgressIndicator(strokeWidth:2)` | ❌ → ShimmerLoading |
| `course/pages/video_player_page.dart` | 播放器加载 | `CircularProgressIndicator(strokeWidth:2)` | ✅ 保持（特殊场景） |
| `home/pages/home_page.dart` | 卡片/Banner 占位 | `CircularProgressIndicator(strokeWidth:2)` | ❌ → ShimmerLoading |

---

## 统一规范

### 原则

| 场景 | 使用组件 | 说明 |
|------|----------|------|
| **整页加载** | `PageLoading` | Win11 风格圆环 + 可选文字 |
| **组件/列表加载** | 骨架屏 (`*Skeleton`) | Shimmer 闪烁效果 |
| **按钮内加载** | `CircularProgressIndicator(strokeWidth:2)` | Flutter 标准，保持不变 |
| **加载更多** | `LoadingWidget(size:24)` | 小尺寸圆环 |
| **图片占位** | `ShimmerLoading` + 圆角容器 | 闪烁占位 |

### 新增骨架屏组件（`widgets/common/skeleton_widgets.dart`）

| 组件 | 用途 |
|------|------|
| `SkeletonLine` | 单行占位条 |
| `SkeletonCircle` | 圆形占位（头像） |
| `SkeletonBox` | 矩形占位块 |
| `ListItemSkeleton` | 通用列表项骨架（头像 + 2 行文字） |
| `ChatListSkeleton` | 聊天会话列表骨架 |
| `ChatMessageSkeleton` | 聊天消息列表骨架 |
| `PostListSkeleton` | 帖子列表骨架 |
| `GridCardSkeleton` | 网格卡片骨架（书架/课程） |
| `ProfileSkeleton` | 个人资料骨架 |
| `DetailPageSkeleton` | 详情页骨架（标题 + 段落） |
| `HomeSectionSkeleton` | 首页卡片区域骨架 |
