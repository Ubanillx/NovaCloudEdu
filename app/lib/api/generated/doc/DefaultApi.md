# nova_api.api.DefaultApi

## Load the API package
```dart
import 'package:nova_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**activateSetting**](DefaultApi.md#activatesetting) | **POST** /api/schedule/setting/{id}/activate | 激活课表配置
[**addComment**](DefaultApi.md#addcomment) | **POST** /api/user/daily-article/{articleId}/comment | 添加评论
[**addCourse**](DefaultApi.md#addcourse) | **POST** /api/classes/{classId}/courses | 添加课程
[**addEdge**](DefaultApi.md#addedge) | **POST** /api/workflows/{id}/edges | 添加连接线
[**addItem**](DefaultApi.md#additem) | **POST** /api/schedule/item | 添加课程项
[**addMember**](DefaultApi.md#addmember) | **POST** /api/classes/{classId}/members | 添加成员
[**addNode**](DefaultApi.md#addnode) | **POST** /api/workflows/{id}/nodes | 添加节点
[**addQuestionToSection**](DefaultApi.md#addquestiontosection) | **POST** /api/exam-papers/{paperId}/sections/{sectionId}/questions | 向大题添加题目
[**addSection**](DefaultApi.md#addsection) | **POST** /api/exam-papers/{paperId}/sections | 添加大题
[**addToShelf**](DefaultApi.md#addtoshelf) | **POST** /api/reading/shelf | 添加书籍到书架
[**addToWordBook**](DefaultApi.md#addtowordbook) | **POST** /api/user/word-book/add/{wordId} | 添加单词到生词本
[**addVariable**](DefaultApi.md#addvariable) | **POST** /api/workflows/{id}/variables | 添加变量
[**adminDeletePost**](DefaultApi.md#admindeletepost) | **DELETE** /api/posts/admin/{postId} | 管理员删除帖子
[**aiGenerateQuestions**](DefaultApi.md#aigeneratequestions) | **POST** /api/questions/ai-generate | AI 智能出题
[**alipayCallback**](DefaultApi.md#alipaycallback) | **POST** /api/payment/callback/alipay | 支付宝异步回调（预留）
[**applyTeacher**](DefaultApi.md#applyteacher) | **POST** /api/teacher/apply | 申请成为讲师
[**applyToJoin**](DefaultApi.md#applytojoin) | **POST** /api/groups/{groupId}/join | 申请加入群
[**archive**](DefaultApi.md#archive) | **POST** /api/workflows/{id}/archive | 归档工作流
[**batchBanUsers**](DefaultApi.md#batchbanusers) | **POST** /api/user/admin/ban | 批量封禁/解封用户
[**batchCreateUsers**](DefaultApi.md#batchcreateusers) | **POST** /api/user/admin/batch-create | 批量创建用户
[**batchSyncAll**](DefaultApi.md#batchsyncall) | **POST** /api/dailylearning/graph-sync/all/batch | 批量同步所有数据到知识图谱（高效批量导入）
[**batchSyncArticles**](DefaultApi.md#batchsyncarticles) | **POST** /api/dailylearning/graph-sync/articles/batch | 批量同步每日文章到知识图谱（高效批量导入）
[**batchSyncWords**](DefaultApi.md#batchsyncwords) | **POST** /api/dailylearning/graph-sync/words/batch | 批量同步每日单词到知识图谱（高效批量导入）
[**batchUpdate**](DefaultApi.md#batchupdate) | **POST** /api/workflows/{id}/batch-update | 批量更新节点和连接线
[**bindToAssistant**](DefaultApi.md#bindtoassistant) | **POST** /api/workflows/{id}/assistants/{assistantId} | 绑定工作流到AI助手
[**cancelExecution**](DefaultApi.md#cancelexecution) | **POST** /api/workflows/executions/{executionId}/cancel | 取消执行
[**cancelMembership**](DefaultApi.md#cancelmembership) | **POST** /api/membership/cancel | 取消会员
[**cancelMembership1**](DefaultApi.md#cancelmembership1) | **POST** /api/admin/membership/cancel/{userId} | 取消用户会员
[**changePassword**](DefaultApi.md#changepassword) | **POST** /api/user/password | 修改密码
[**checkFavourite**](DefaultApi.md#checkfavourite) | **GET** /api/course/favourite/{courseId}/check | 检查是否已收藏
[**checkFriendship**](DefaultApi.md#checkfriendship) | **GET** /api/friend/check/{userId} | 检查好友关系
[**checkin**](DefaultApi.md#checkin) | **POST** /api/user/checkin | 用户打卡
[**completeSection**](DefaultApi.md#completesection) | **POST** /api/progress/section/{sectionId}/complete | 标记小节为已完成
[**confirmPayment**](DefaultApi.md#confirmpayment) | **POST** /api/admin/order/confirm | 确认收款（管理员手动确认）
[**confirmPayment1**](DefaultApi.md#confirmpayment1) | **POST** /api/admin/membership/confirm | 确认会员支付（管理员手动确认）
[**copy**](DefaultApi.md#copy) | **POST** /api/workflows/{id}/copy | 复制工作流
[**create**](DefaultApi.md#create) | **POST** /api/workflows | 创建工作流
[**createAnnouncement**](DefaultApi.md#createannouncement) | **POST** /api/announcement/admin/create | 创建公告
[**createBanner**](DefaultApi.md#createbanner) | **POST** /api/admin/banner | 创建轮播图
[**createBookmark**](DefaultApi.md#createbookmark) | **POST** /api/books/{bookId}/bookmarks | 创建书签
[**createChapter**](DefaultApi.md#createchapter) | **POST** /api/course/{courseId}/chapter | 创建章节（管理员）
[**createClass**](DefaultApi.md#createclass) | **POST** /api/classes | 创建班级
[**createComment**](DefaultApi.md#createcomment) | **POST** /api/posts/{postId}/comments | 发表评论
[**createConfig**](DefaultApi.md#createconfig) | **POST** /api/admin/scraper/config | 创建抓取配置
[**createCourse**](DefaultApi.md#createcourse) | **POST** /api/course | 创建课程（管理员）
[**createDailyArticle**](DefaultApi.md#createdailyarticle) | **POST** /api/daily-article | 创建每日文章（管理员）
[**createDailyWord**](DefaultApi.md#createdailyword) | **POST** /api/daily-word | 创建每日单词（管理员）
[**createExamPaper**](DefaultApi.md#createexampaper) | **POST** /api/exam-papers | 创建试卷
[**createFeedback**](DefaultApi.md#createfeedback) | **POST** /api/feedback | 创建反馈
[**createFromTemplate**](DefaultApi.md#createfromtemplate) | **POST** /api/workflows/templates/{templateId}/create-workflow | 从模板创建工作流
[**createGroup**](DefaultApi.md#creategroup) | **POST** /api/groups | 创建群聊
[**createGroupFromClass**](DefaultApi.md#creategroupfromclass) | **POST** /api/classes/{classId}/chat-group | 基于班级创建群聊
[**createNote**](DefaultApi.md#createnote) | **POST** /api/books/{bookId}/notes | 创建阅读笔记
[**createOrder**](DefaultApi.md#createorder) | **POST** /api/order | 创建订单（用户下单）
[**createPlan**](DefaultApi.md#createplan) | **POST** /api/admin/membership/plans | 创建会员计划
[**createPost**](DefaultApi.md#createpost) | **POST** /api/posts | 发布帖子
[**createQuestion**](DefaultApi.md#createquestion) | **POST** /api/questions | 创建题目
[**createReply**](DefaultApi.md#createreply) | **POST** /api/posts/comments/{commentId}/replies | 发表回复
[**createRoom**](DefaultApi.md#createroom) | **POST** /api/livestream/rooms | 创建直播间
[**createScheduleTrigger**](DefaultApi.md#createscheduletrigger) | **POST** /api/workflows/{id}/triggers/schedule | 创建定时触发器
[**createSection**](DefaultApi.md#createsection) | **POST** /api/course/{courseId}/section | 创建小节（管理员）
[**createSetting**](DefaultApi.md#createsetting) | **POST** /api/schedule/setting | 创建课表配置
[**createTemplate**](DefaultApi.md#createtemplate) | **POST** /api/workflows/templates/from-workflow/{workflowId} | 从工作流创建模板
[**createUser**](DefaultApi.md#createuser) | **POST** /api/user/admin/create | 创建用户
[**createVersionSnapshot**](DefaultApi.md#createversionsnapshot) | **POST** /api/workflows/{id}/versions | 创建版本快照（发布时）
[**createWebhookTrigger**](DefaultApi.md#createwebhooktrigger) | **POST** /api/workflows/{id}/triggers/webhook | 创建Webhook触发器
[**delete**](DefaultApi.md#delete) | **DELETE** /api/workflows/{id} | 删除工作流
[**deleteAnnouncement**](DefaultApi.md#deleteannouncement) | **DELETE** /api/announcement/admin/delete/{id} | 删除公告
[**deleteBanner**](DefaultApi.md#deletebanner) | **DELETE** /api/admin/banner/{id} | 删除轮播图
[**deleteBook**](DefaultApi.md#deletebook) | **DELETE** /api/books/{bookId} | 删除书籍
[**deleteBookmark**](DefaultApi.md#deletebookmark) | **DELETE** /api/books/{bookId}/bookmarks/{bookmarkId} | 删除书签
[**deleteChapter**](DefaultApi.md#deletechapter) | **DELETE** /api/course/{courseId}/chapter/{chapterId} | 删除章节（管理员）
[**deleteClass**](DefaultApi.md#deleteclass) | **DELETE** /api/classes/{classId} | 删除班级
[**deleteComment**](DefaultApi.md#deletecomment) | **DELETE** /api/posts/comments/{commentId} | 删除评论
[**deleteConfig**](DefaultApi.md#deleteconfig) | **DELETE** /api/admin/scraper/config/{id} | 删除配置
[**deleteCourse**](DefaultApi.md#deletecourse) | **DELETE** /api/course/{id} | 删除课程（管理员）
[**deleteDailyArticle**](DefaultApi.md#deletedailyarticle) | **DELETE** /api/daily-article/{id} | 删除每日文章（管理员）
[**deleteDailyWord**](DefaultApi.md#deletedailyword) | **DELETE** /api/daily-word/{id} | 删除每日单词（管理员）
[**deleteEdge**](DefaultApi.md#deleteedge) | **DELETE** /api/workflows/{id}/edges/{edgeId} | 删除连接线
[**deleteExamPaper**](DefaultApi.md#deleteexampaper) | **DELETE** /api/exam-papers/{id} | 删除试卷
[**deleteFeedback**](DefaultApi.md#deletefeedback) | **DELETE** /api/feedback/{id} | 删除反馈
[**deleteFeedback1**](DefaultApi.md#deletefeedback1) | **DELETE** /api/feedback/admin/{id} | 删除反馈
[**deleteFile**](DefaultApi.md#deletefile) | **DELETE** /api/file/{fileId} | 删除文件
[**deleteFriend**](DefaultApi.md#deletefriend) | **DELETE** /api/friend/{friendId} | 删除好友
[**deleteItem**](DefaultApi.md#deleteitem) | **DELETE** /api/schedule/item/{id} | 删除课程项
[**deleteMessage**](DefaultApi.md#deletemessage) | **DELETE** /api/group-chat/{groupId}/messages/{messageId} | 删除消息
[**deleteNode**](DefaultApi.md#deletenode) | **DELETE** /api/workflows/{id}/nodes/{nodeId} | 删除节点
[**deleteNote**](DefaultApi.md#deletenote) | **DELETE** /api/books/{bookId}/notes/{noteId} | 删除笔记
[**deletePlan**](DefaultApi.md#deleteplan) | **DELETE** /api/admin/membership/plans/{planId} | 删除会员计划
[**deletePost**](DefaultApi.md#deletepost) | **DELETE** /api/posts/{postId} | 删除帖子
[**deleteQuestion**](DefaultApi.md#deletequestion) | **DELETE** /api/questions/{id} | 删除题目
[**deleteReply**](DefaultApi.md#deletereply) | **DELETE** /api/posts/replies/{replyId} | 删除回复
[**deleteRoom**](DefaultApi.md#deleteroom) | **DELETE** /api/livestream/rooms/{id} | 删除直播间
[**deleteSection**](DefaultApi.md#deletesection) | **DELETE** /api/exam-papers/{paperId}/sections/{sectionId} | 删除大题
[**deleteSection1**](DefaultApi.md#deletesection1) | **DELETE** /api/course/{courseId}/section/{sectionId} | 删除小节（管理员）
[**deleteTemplate**](DefaultApi.md#deletetemplate) | **DELETE** /api/workflows/templates/{templateId} | 删除模板
[**deleteTemplate2**](DefaultApi.md#deletetemplate2) | **DELETE** /api/exam-templates/{id} | 删除模板
[**deleteTrigger**](DefaultApi.md#deletetrigger) | **DELETE** /api/workflows/triggers/{triggerId} | 删除触发器
[**deleteVariable**](DefaultApi.md#deletevariable) | **DELETE** /api/workflows/{id}/variables/{variableName} | 删除变量
[**disableConfig**](DefaultApi.md#disableconfig) | **POST** /api/admin/scraper/config/{id}/disable | 禁用配置
[**disableTrigger**](DefaultApi.md#disabletrigger) | **POST** /api/workflows/triggers/{triggerId}/disable | 禁用触发器
[**dissolveGroup**](DefaultApi.md#dissolvegroup) | **DELETE** /api/groups/{groupId} | 解散群
[**dissolveGroup1**](DefaultApi.md#dissolvegroup1) | **DELETE** /api/admin/groups/{groupId} | 解散群
[**enableConfig**](DefaultApi.md#enableconfig) | **POST** /api/admin/scraper/config/{id}/enable | 启用配置
[**enableTrigger**](DefaultApi.md#enabletrigger) | **POST** /api/workflows/triggers/{triggerId}/enable | 启用触发器
[**encryptAllChapters**](DefaultApi.md#encryptallchapters) | **POST** /api/books/{bookId}/chapters/encrypt-all | 批量加密所有章节
[**encryptChapterContent**](DefaultApi.md#encryptchaptercontent) | **POST** /api/books/{bookId}/chapters/{chapterIndex}/encrypt | 加密章节内容
[**execute**](DefaultApi.md#execute) | **POST** /api/workflows/{id}/execute | 执行工作流
[**executeAllTasks**](DefaultApi.md#executealltasks) | **POST** /api/admin/scraper/config/execute-all | 触发所有抓取
[**executeAsync**](DefaultApi.md#executeasync) | **POST** /api/workflows/{id}/execute-async | 异步执行工作流
[**executeTask**](DefaultApi.md#executetask) | **POST** /api/admin/scraper/config/execute | 执行抓取任务
[**exportAnswerKey**](DefaultApi.md#exportanswerkey) | **POST** /api/exam-papers/{id}/export-answer-key | 导出参考答案PDF
[**favouriteCourse**](DefaultApi.md#favouritecourse) | **POST** /api/course/favourite/{courseId} | 收藏课程
[**follow**](DefaultApi.md#follow) | **POST** /api/follow/{targetUserId} | 关注用户
[**generateBannerImage**](DefaultApi.md#generatebannerimage) | **POST** /api/admin/banner/generate-image | AI生成轮播图图片
[**getAiQuota**](DefaultApi.md#getaiquota) | **GET** /api/membership/ai-quota | 查询我的AI功能剩余额度
[**getAllConfigs**](DefaultApi.md#getallconfigs) | **GET** /api/admin/scraper/config | 获取所有配置
[**getAllFriends**](DefaultApi.md#getallfriends) | **GET** /api/friend/all | 获取全部好友
[**getAllProfiles**](DefaultApi.md#getallprofiles) | **GET** /api/grading/profile | 查询学生全部知识画像
[**getAllTasks**](DefaultApi.md#getalltasks) | **GET** /api/admin/scraper/config/tasks | 获取所有任务
[**getAnnouncement**](DefaultApi.md#getannouncement) | **GET** /api/announcement/admin/{id} | 获取公告详情
[**getAnnouncementDetail**](DefaultApi.md#getannouncementdetail) | **GET** /api/announcement/{id} | 获取公告详情
[**getAnnouncementList**](DefaultApi.md#getannouncementlist) | **GET** /api/announcement/list | 获取公告列表
[**getApplication**](DefaultApi.md#getapplication) | **GET** /api/teacher/application/{id} | 获取申请详情
[**getArticlesByDate**](DefaultApi.md#getarticlesbydate) | **GET** /api/daily-article/date/{date} | 获取指定日期文章
[**getBannerDetail**](DefaultApi.md#getbannerdetail) | **GET** /api/admin/banner/{id} | 获取轮播图详情
[**getBannerList**](DefaultApi.md#getbannerlist) | **GET** /api/banner/list | 获取轮播图列表
[**getBook**](DefaultApi.md#getbook) | **GET** /api/books/{bookId} | 获取书籍详情
[**getBookChapters**](DefaultApi.md#getbookchapters) | **GET** /api/books/{bookId}/chapters | 获取书籍章节列表
[**getBookmarksByBook**](DefaultApi.md#getbookmarksbybook) | **GET** /api/books/{bookId}/bookmarks | 获取用户在该书的书签列表
[**getById**](DefaultApi.md#getbyid) | **GET** /api/workflows/{id} | 获取工作流详情
[**getChapter**](DefaultApi.md#getchapter) | **GET** /api/course/{courseId}/chapter/{chapterId} | 获取章节详情
[**getChapterContent**](DefaultApi.md#getchaptercontent) | **GET** /api/books/{bookId}/chapters/{chapterIndex} | 获取章节内容
[**getChatHistory**](DefaultApi.md#getchathistory) | **POST** /api/chat/history | 获取聊天历史
[**getChatHistory1**](DefaultApi.md#getchathistory1) | **GET** /api/livestream/rooms/{id}/messages | 直播间聊天历史
[**getCheckinRanking**](DefaultApi.md#getcheckinranking) | **GET** /api/user/checkin/ranking | 打卡排行榜
[**getCheckinStatus**](DefaultApi.md#getcheckinstatus) | **GET** /api/user/checkin/status | 获取打卡状态
[**getClassAiReport**](DefaultApi.md#getclassaireport) | **GET** /api/analytics/class/{classId}/ai-report | AI班级学情分析报告（SSE流式）
[**getClassInfo**](DefaultApi.md#getclassinfo) | **GET** /api/classes/{classId} | 获取班级详情
[**getClassMembers**](DefaultApi.md#getclassmembers) | **GET** /api/classes/{classId}/members | 获取班级成员列表
[**getClassOverview**](DefaultApi.md#getclassoverview) | **GET** /api/analytics/class/{classId}/overview | 班级学情概览
[**getClassRanking**](DefaultApi.md#getclassranking) | **GET** /api/analytics/class/{classId}/ranking | 班级成员排名
[**getClassSubjects**](DefaultApi.md#getclasssubjects) | **GET** /api/analytics/class/{classId}/subjects | 班级各学科分析
[**getClassTrend**](DefaultApi.md#getclasstrend) | **GET** /api/analytics/class/{classId}/trend | 班级学习趋势
[**getCollectedArticles**](DefaultApi.md#getcollectedarticles) | **GET** /api/user/daily-article/collected | 获取收藏文章列表
[**getCollectedWords**](DefaultApi.md#getcollectedwords) | **GET** /api/user/daily-word/collected | 获取收藏单词列表
[**getCommentReplies**](DefaultApi.md#getcommentreplies) | **GET** /api/posts/comments/{commentId}/replies | 获取评论回复列表
[**getConfig**](DefaultApi.md#getconfig) | **GET** /api/admin/scraper/config/{id} | 获取配置详情
[**getConfigsByPage**](DefaultApi.md#getconfigsbypage) | **GET** /api/admin/scraper/config/page | 分页获取配置
[**getCourse**](DefaultApi.md#getcourse) | **GET** /api/course/{id} | 获取课程详情
[**getCourseProgress**](DefaultApi.md#getcourseprogress) | **GET** /api/progress/course/{courseId} | 获取课程所有小节的学习进度
[**getCourseProgressSummary**](DefaultApi.md#getcourseprogresssummary) | **GET** /api/progress/course/{courseId}/summary | 获取课程进度汇总
[**getCourseStructure**](DefaultApi.md#getcoursestructure) | **GET** /api/course/{courseId}/structure | 获取课程完整结构（课程+章节+小节）
[**getCurrentMembership**](DefaultApi.md#getcurrentmembership) | **GET** /api/membership/current | 查询我的当前会员详细信息
[**getDailyArticle**](DefaultApi.md#getdailyarticle) | **GET** /api/daily-article/{id} | 获取文章详情
[**getDailyWord**](DefaultApi.md#getdailyword) | **GET** /api/daily-word/{id} | 获取单词详情
[**getDefinition**](DefaultApi.md#getdefinition) | **GET** /api/workflows/{id}/definition | 获取工作流定义详情
[**getEdges**](DefaultApi.md#getedges) | **GET** /api/workflows/{id}/edges | 获取工作流所有连接线
[**getExamPaper**](DefaultApi.md#getexampaper) | **GET** /api/exam-papers/{id} | 获取试卷详情
[**getExecutionLogs**](DefaultApi.md#getexecutionlogs) | **GET** /api/workflows/executions/{executionId}/logs | 获取执行日志
[**getExecutionStatistics**](DefaultApi.md#getexecutionstatistics) | **GET** /api/workflows/{id}/execution-statistics | 获取工作流执行统计
[**getExecutionStatus**](DefaultApi.md#getexecutionstatus) | **GET** /api/workflows/executions/{executionId} | 获取执行状态
[**getFavouriteCount**](DefaultApi.md#getfavouritecount) | **GET** /api/course/favourite/{courseId}/count | 获取课程收藏数
[**getFeedbackDetail**](DefaultApi.md#getfeedbackdetail) | **GET** /api/feedback/{id} | 获取反馈详情
[**getFeedbackDetail1**](DefaultApi.md#getfeedbackdetail1) | **GET** /api/feedback/admin/{id} | 获取反馈详情
[**getFeedbackReplies**](DefaultApi.md#getfeedbackreplies) | **GET** /api/feedback/{id}/replies | 获取反馈回复列表
[**getFeedbackReplies1**](DefaultApi.md#getfeedbackreplies1) | **GET** /api/feedback/admin/{id}/replies | 获取反馈回复列表
[**getFilesByBusinessType**](DefaultApi.md#getfilesbybusinesstype) | **GET** /api/file/business-type/{businessType} | 按业务类型获取文件列表（管理员）
[**getFollowingPosts**](DefaultApi.md#getfollowingposts) | **GET** /api/posts/following | 获取关注用户的帖子列表
[**getFriendList**](DefaultApi.md#getfriendlist) | **POST** /api/friend/list | 获取好友列表
[**getGroupInfo**](DefaultApi.md#getgroupinfo) | **GET** /api/groups/{groupId} | 获取群详情
[**getGroupInfo1**](DefaultApi.md#getgroupinfo1) | **GET** /api/admin/groups/{groupId} | 获取群详情
[**getGroupMembers**](DefaultApi.md#getgroupmembers) | **GET** /api/groups/{groupId}/members | 获取群成员列表
[**getGroupMembers1**](DefaultApi.md#getgroupmembers1) | **GET** /api/admin/groups/{groupId}/members | 分页获取群成员
[**getGroupMembersPage**](DefaultApi.md#getgroupmemberspage) | **GET** /api/groups/{groupId}/members/page | 分页获取群成员
[**getHistory**](DefaultApi.md#gethistory) | **GET** /api/grading/history | 查询批改历史
[**getHlsStream**](DefaultApi.md#gethlsstream) | **GET** /api/video/hls/{sectionId} | 获取HLS播放流（带Token）
[**getKey**](DefaultApi.md#getkey) | **GET** /api/video/key | 获取视频解密密钥（HLS播放器自动调用）
[**getLatestMessages**](DefaultApi.md#getlatestmessages) | **GET** /api/group-chat/{groupId}/messages/latest | 获取群最新消息
[**getLikedArticles**](DefaultApi.md#getlikedarticles) | **GET** /api/user/daily-article/liked | 获取点赞文章列表
[**getLoginUser**](DefaultApi.md#getloginuser) | **GET** /api/auth/current | 获取当前用户
[**getMembershipHistory**](DefaultApi.md#getmembershiphistory) | **GET** /api/membership/history | 查询我的会员历史
[**getMessages**](DefaultApi.md#getmessages) | **GET** /api/group-chat/{groupId}/messages | 获取群聊历史消息（分页）
[**getMessagesBefore**](DefaultApi.md#getmessagesbefore) | **GET** /api/group-chat/{groupId}/messages/before | 获取群聊历史消息（游标分页，获取某消息之前的消息）
[**getMyApplication**](DefaultApi.md#getmyapplication) | **GET** /api/teacher/application/my | 获取当前用户的申请
[**getMyFavourites**](DefaultApi.md#getmyfavourites) | **GET** /api/posts/favourites | 获取我收藏的帖子
[**getMyFavourites1**](DefaultApi.md#getmyfavourites1) | **GET** /api/course/favourite/my | 获取我的收藏列表
[**getMyFeedbacks**](DefaultApi.md#getmyfeedbacks) | **GET** /api/feedback/my | 获取我的反馈列表
[**getMyFiles**](DefaultApi.md#getmyfiles) | **GET** /api/file/my | 获取我的文件列表
[**getMyFollowStats**](DefaultApi.md#getmyfollowstats) | **GET** /api/follow/stats | 获取我的关注统计
[**getMyFollowers**](DefaultApi.md#getmyfollowers) | **GET** /api/follow/followers | 获取我的粉丝列表
[**getMyFollowings**](DefaultApi.md#getmyfollowings) | **GET** /api/follow/followings | 获取我的关注列表
[**getMyGroups**](DefaultApi.md#getmygroups) | **GET** /api/groups/my | 获取我加入的群列表
[**getMyOrders**](DefaultApi.md#getmyorders) | **GET** /api/order/my | 获取我的订单列表
[**getMyPosts**](DefaultApi.md#getmyposts) | **GET** /api/posts/my | 获取我的帖子列表
[**getMyReview**](DefaultApi.md#getmyreview) | **GET** /api/course/review/{courseId}/my | 获取我对该课程的评价
[**getMySchedule**](DefaultApi.md#getmyschedule) | **GET** /api/schedule/my | 获取我的课表
[**getMyTeacher**](DefaultApi.md#getmyteacher) | **GET** /api/teacher/my | 获取当前用户的讲师信息
[**getNode**](DefaultApi.md#getnode) | **GET** /api/workflows/{id}/nodes/{nodeId} | 获取单个节点详情
[**getNodeTypes**](DefaultApi.md#getnodetypes) | **GET** /api/workflows/node-types | 获取所有可用的节点类型
[**getNodes**](DefaultApi.md#getnodes) | **GET** /api/workflows/{id}/nodes | 获取工作流所有节点
[**getNotesByBook**](DefaultApi.md#getnotesbybook) | **GET** /api/books/{bookId}/notes | 获取用户在该书的笔记列表
[**getNotesByChapter**](DefaultApi.md#getnotesbychapter) | **GET** /api/books/{bookId}/notes/chapters/{chapterId} | 获取用户在该章节的笔记
[**getOrder**](DefaultApi.md#getorder) | **GET** /api/order/{orderNo} | 查询订单详情
[**getPaperQuestions**](DefaultApi.md#getpaperquestions) | **GET** /api/exam-papers/{paperId}/sections/{sectionId}/questions | 获取大题下的所有题目关联
[**getPdfUrl**](DefaultApi.md#getpdfurl) | **GET** /api/books/{bookId}/pdf-url | 获取PDF预签名URL
[**getPendingCount**](DefaultApi.md#getpendingcount) | **GET** /api/teacher/application/pending/count | 获取待审核申请数量（管理员）
[**getPendingRequests**](DefaultApi.md#getpendingrequests) | **GET** /api/groups/{groupId}/requests | 获取群待审批申请列表
[**getPlan**](DefaultApi.md#getplan) | **GET** /api/membership/plans/{planId} | 获取计划详情
[**getPlayToken**](DefaultApi.md#getplaytoken) | **GET** /api/video/play-token | 获取视频播放令牌
[**getPostComments**](DefaultApi.md#getpostcomments) | **GET** /api/posts/{postId}/comments | 获取帖子评论列表
[**getPostDetail**](DefaultApi.md#getpostdetail) | **GET** /api/posts/{postId} | 获取帖子详情
[**getPostList**](DefaultApi.md#getpostlist) | **GET** /api/posts | 分页获取帖子列表
[**getPostListByType**](DefaultApi.md#getpostlistbytype) | **GET** /api/posts/type/{postType} | 根据类型获取帖子列表
[**getPublishedPapers**](DefaultApi.md#getpublishedpapers) | **GET** /api/grading/papers | 查询已发布试卷列表（供批改选择）
[**getQuestion**](DefaultApi.md#getquestion) | **GET** /api/questions/{id} | 获取题目详情
[**getReadArticles**](DefaultApi.md#getreadarticles) | **GET** /api/user/daily-article/read | 获取已阅读文章列表
[**getReadCount**](DefaultApi.md#getreadcount) | **GET** /api/group-chat/messages/{messageId}/read-count | 获取消息已读人数
[**getReadUsers**](DefaultApi.md#getreadusers) | **GET** /api/group-chat/messages/{messageId}/read-users | 获取消息已读用户列表（含昵称头像）
[**getReceivedRequests**](DefaultApi.md#getreceivedrequests) | **POST** /api/friend/request/received | 获取收到的好友申请
[**getRecommendations**](DefaultApi.md#getrecommendations) | **GET** /api/grading/{submissionId}/recommend | 获取错题的同类题推荐
[**getResult**](DefaultApi.md#getresult) | **GET** /api/grading/{submissionId}/result | 获取批改结果
[**getReviewCount**](DefaultApi.md#getreviewcount) | **GET** /api/course/review/{courseId}/count | 获取课程评价数
[**getRoomDetail**](DefaultApi.md#getroomdetail) | **GET** /api/livestream/rooms/{id} | 直播间详情
[**getScheduleBySetting**](DefaultApi.md#getschedulebysetting) | **GET** /api/schedule/setting/{settingId} | 获取特定配置的课表
[**getSection**](DefaultApi.md#getsection) | **GET** /api/course/{courseId}/section/{sectionId} | 获取小节详情
[**getSectionProgress**](DefaultApi.md#getsectionprogress) | **GET** /api/progress/section/{sectionId} | 获取小节学习进度
[**getSections**](DefaultApi.md#getsections) | **GET** /api/exam-papers/{paperId}/sections | 获取试卷的所有大题
[**getSentRequests**](DefaultApi.md#getsentrequests) | **POST** /api/friend/request/sent | 获取发送的好友申请
[**getSessionList**](DefaultApi.md#getsessionlist) | **GET** /api/chat/sessions | 获取会话列表
[**getStatistics**](DefaultApi.md#getstatistics) | **GET** /api/admin/order/statistics | 订单统计（管理员，包含课程+会员）
[**getStatistics1**](DefaultApi.md#getstatistics1) | **GET** /api/admin/membership/statistics | 会员统计
[**getStats**](DefaultApi.md#getstats) | **GET** /api/user/word-book/stats | 获取生词本统计
[**getStats1**](DefaultApi.md#getstats1) | **GET** /api/user/daily-word/stats | 获取学习统计
[**getStats2**](DefaultApi.md#getstats2) | **GET** /api/user/daily-article/stats | 获取阅读统计
[**getStats3**](DefaultApi.md#getstats3) | **GET** /api/grading/stats | 查询批改历史统计
[**getStatus**](DefaultApi.md#getstatus) | **GET** /api/grading/{submissionId}/status | 查询批改状态
[**getStudentAiReport**](DefaultApi.md#getstudentaireport) | **GET** /api/analytics/student/ai-report | AI个人学情分析报告（SSE流式）
[**getStudentOverview**](DefaultApi.md#getstudentoverview) | **GET** /api/analytics/student/overview | 个人学情概览
[**getStudentSubjects**](DefaultApi.md#getstudentsubjects) | **GET** /api/analytics/student/subjects | 个人各学科学情
[**getStudentTrend**](DefaultApi.md#getstudenttrend) | **GET** /api/analytics/student/trend | 个人学习趋势
[**getStudiedWords**](DefaultApi.md#getstudiedwords) | **GET** /api/user/daily-word/studied | 获取已学习单词列表
[**getSubjectProfile**](DefaultApi.md#getsubjectprofile) | **GET** /api/grading/profile/{subjectCode} | 查询某学科知识画像详情
[**getSupportedSources**](DefaultApi.md#getsupportedsources) | **GET** /api/scraper/sources | 获取预设来源列表
[**getSupportedVoices**](DefaultApi.md#getsupportedvoices) | **GET** /api/speech/tts/voices | 获取支持的发音人列表
[**getTableColumns**](DefaultApi.md#gettablecolumns) | **GET** /api/workflows/database/tables/{tableName}/columns | 获取指定表的字段信息
[**getTask**](DefaultApi.md#gettask) | **GET** /api/admin/scraper/config/task/{taskId} | 获取任务详情
[**getTasksByConfig**](DefaultApi.md#gettasksbyconfig) | **GET** /api/admin/scraper/config/{configId}/tasks | 获取配置的任务列表
[**getTeacher**](DefaultApi.md#getteacher) | **GET** /api/teacher/{id} | 获取讲师信息
[**getTeacherByUserId**](DefaultApi.md#getteacherbyuserid) | **GET** /api/teacher/user/{userId} | 根据用户ID获取讲师信息
[**getTemplate**](DefaultApi.md#gettemplate) | **GET** /api/workflows/templates/{templateId} | 获取模板详情
[**getTemplate1**](DefaultApi.md#gettemplate1) | **GET** /api/exam-templates/{id} | 获取模板详情
[**getTodayArticles**](DefaultApi.md#gettodayarticles) | **GET** /api/daily-article/today | 获取今日推荐文章（个性化推荐）
[**getTodayWords**](DefaultApi.md#gettodaywords) | **GET** /api/daily-word/today | 获取今日推荐单词（个性化推荐）
[**getTopPosts**](DefaultApi.md#gettopposts) | **GET** /api/posts/top | 获取点赞排行榜（全部时间）
[**getTopPostsByDays**](DefaultApi.md#gettoppostsbydays) | **GET** /api/posts/top/days | 获取点赞排行榜（指定天数内）
[**getUnreadCount**](DefaultApi.md#getunreadcount) | **GET** /api/group-chat/{groupId}/unread/count | 获取群未读消息数
[**getUnreadCount1**](DefaultApi.md#getunreadcount1) | **GET** /api/chat/unread/count | 获取未读消息数
[**getUnreadCount2**](DefaultApi.md#getunreadcount2) | **GET** /api/announcement/unread-count | 获取未读公告数量
[**getUserAiQuota**](DefaultApi.md#getuseraiquota) | **GET** /api/admin/membership/users/{userId}/ai-quota | 查询指定用户的AI额度
[**getUserDetail**](DefaultApi.md#getuserdetail) | **GET** /api/user/admin/{id} | 获取用户详情
[**getUserDetailInfo**](DefaultApi.md#getuserdetailinfo) | **GET** /api/user/detail/{id} | 获取用户详细信息
[**getUserFollowStats**](DefaultApi.md#getuserfollowstats) | **GET** /api/follow/user/{targetUserId}/stats | 获取指定用户的关注统计
[**getUserFollowers**](DefaultApi.md#getuserfollowers) | **GET** /api/follow/user/{targetUserId}/followers | 获取指定用户的粉丝列表
[**getUserFollowings**](DefaultApi.md#getuserfollowings) | **GET** /api/follow/user/{targetUserId}/followings | 获取指定用户的关注列表
[**getUserPosts**](DefaultApi.md#getuserposts) | **GET** /api/posts/user/{targetUserId} | 获取指定用户的帖子列表
[**getUserPublicInfo**](DefaultApi.md#getuserpublicinfo) | **GET** /api/user/public/{id} | 获取用户公开信息
[**getUserShelf**](DefaultApi.md#getusershelf) | **GET** /api/reading/shelf/{userId} | 获取用户书架
[**getUserStats**](DefaultApi.md#getuserstats) | **GET** /api/user/stats | 获取用户统计数据
[**getVariables**](DefaultApi.md#getvariables) | **GET** /api/workflows/{id}/variables | 获取工作流所有变量
[**getVersion**](DefaultApi.md#getversion) | **GET** /api/workflows/{id}/versions/{versionNumber} | 获取指定版本详情
[**getWeakPoints**](DefaultApi.md#getweakpoints) | **GET** /api/grading/profile/{subjectCode}/weak | 查询某学科薄弱知识点
[**getWordBookList**](DefaultApi.md#getwordbooklist) | **GET** /api/user/word-book/list | 获取生词本列表
[**getWordsByDate**](DefaultApi.md#getwordsbydate) | **GET** /api/daily-word/date/{date} | 获取指定日期单词
[**getWorkflowAssistants**](DefaultApi.md#getworkflowassistants) | **GET** /api/workflows/{id}/assistants | 获取使用该工作流的AI助手ID列表
[**grantMembership**](DefaultApi.md#grantmembership) | **POST** /api/admin/membership/grant | 为用户直接开通会员
[**handleFriendRequest**](DefaultApi.md#handlefriendrequest) | **POST** /api/friend/request/handle | 处理好友申请
[**handleJoinRequest**](DefaultApi.md#handlejoinrequest) | **POST** /api/groups/requests/{requestId}/handle | 处理加入申请
[**health**](DefaultApi.md#health) | **GET** /api/health | 健康检查
[**inviteMember**](DefaultApi.md#invitemember) | **POST** /api/groups/{groupId}/invite | 邀请用户加入群
[**isFollowing**](DefaultApi.md#isfollowing) | **GET** /api/follow/check/{targetUserId} | 检查是否已关注
[**kbAddDocument**](DefaultApi.md#kbadddocument) | **POST** /api/ai/knowledge-bases/{id}/documents | 添加文档
[**kbBatchProcessByKnowledgeBase**](DefaultApi.md#kbbatchprocessbyknowledgebase) | **POST** /api/ai/knowledge-bases/{id}/embed-all | 向量化知识库所有待处理文档
[**kbBatchProcessDocuments**](DefaultApi.md#kbbatchprocessdocuments) | **POST** /api/ai/knowledge-bases/{id}/documents/batch-embed | 批量文档向量化
[**kbBatchProcessDocumentsAsync**](DefaultApi.md#kbbatchprocessdocumentsasync) | **POST** /api/ai/knowledge-bases/{id}/documents/batch-embed-async | 异步批量文档向量化
[**kbCreate**](DefaultApi.md#kbcreate) | **POST** /api/ai/knowledge-bases | 创建知识库
[**kbDelete**](DefaultApi.md#kbdelete) | **DELETE** /api/ai/knowledge-bases/{id} | 删除知识库
[**kbDeleteDocument**](DefaultApi.md#kbdeletedocument) | **DELETE** /api/ai/knowledge-bases/{id}/documents/{docId} | 删除文档
[**kbGetById**](DefaultApi.md#kbgetbyid) | **GET** /api/ai/knowledge-bases/{id} | 获取知识库详情
[**kbListByCreator**](DefaultApi.md#kblistbycreator) | **GET** /api/ai/knowledge-bases | 获取用户的知识库列表
[**kbListChunks**](DefaultApi.md#kblistchunks) | **GET** /api/ai/knowledge-bases/{id}/documents/{docId}/chunks | 获取文档分块列表
[**kbListDocuments**](DefaultApi.md#kblistdocuments) | **GET** /api/ai/knowledge-bases/{id}/documents | 获取文档列表
[**kbProcessDocument**](DefaultApi.md#kbprocessdocument) | **POST** /api/ai/knowledge-bases/{id}/documents/{docId}/embed | 触发文档向量化
[**kbRecallTest**](DefaultApi.md#kbrecalltest) | **POST** /api/ai/knowledge-bases/{id}/recall-test | 知识库召回测试
[**kbSearch**](DefaultApi.md#kbsearch) | **GET** /api/ai/knowledge-bases/search | 搜索知识库
[**kbUpdate**](DefaultApi.md#kbupdate) | **PUT** /api/ai/knowledge-bases/{id} | 更新知识库
[**kbUpdateDocument**](DefaultApi.md#kbupdatedocument) | **PUT** /api/ai/knowledge-bases/{id}/documents/{docId} | 更新文档元信息
[**leaveGroup**](DefaultApi.md#leavegroup) | **POST** /api/groups/{groupId}/leave | 退出群
[**listAllTemplates**](DefaultApi.md#listalltemplates) | **GET** /api/exam-templates/all | 列出所有模板（管理员）
[**listAllowedTables**](DefaultApi.md#listallowedtables) | **GET** /api/workflows/database/tables | 获取可查询的数据库表列表
[**listApplications**](DefaultApi.md#listapplications) | **GET** /api/teacher/application/list | 获取申请列表（管理员）
[**listArticles**](DefaultApi.md#listarticles) | **GET** /api/daily-article/list | 获取文章列表
[**listAvailableModels**](DefaultApi.md#listavailablemodels) | **GET** /api/workflows/models | 获取可用模型列表
[**listBooks**](DefaultApi.md#listbooks) | **GET** /api/books | 获取书籍列表
[**listByUser**](DefaultApi.md#listbyuser) | **GET** /api/workflows | 获取用户的工作流列表
[**listChapters**](DefaultApi.md#listchapters) | **GET** /api/course/{courseId}/chapter | 获取课程的章节列表
[**listClasses**](DefaultApi.md#listclasses) | **GET** /api/classes/list | 获取班级列表
[**listCourses**](DefaultApi.md#listcourses) | **GET** /api/course/list | 获取课程列表
[**listCoursesByTeacher**](DefaultApi.md#listcoursesbyteacher) | **GET** /api/course/teacher/{teacherId} | 获取讲师的课程列表
[**listExecutions**](DefaultApi.md#listexecutions) | **GET** /api/workflows/{id}/executions | 获取工作流执行历史列表
[**listGroups**](DefaultApi.md#listgroups) | **GET** /api/admin/groups/list | 分页获取群列表
[**listMemberships**](DefaultApi.md#listmemberships) | **GET** /api/admin/membership/list | 按状态查询会员列表
[**listOrders**](DefaultApi.md#listorders) | **GET** /api/admin/order/list | 获取订单列表（管理员，包含课程订单和会员订单）
[**listPlans**](DefaultApi.md#listplans) | **GET** /api/admin/membership/plans | 获取所有会员计划
[**listPlans1**](DefaultApi.md#listplans1) | **GET** /api/membership/plans | 获取所有会员计划
[**listPublic**](DefaultApi.md#listpublic) | **GET** /api/workflows/public | 获取公开的工作流列表
[**listReviews**](DefaultApi.md#listreviews) | **GET** /api/course/review/{courseId}/list | 获取课程评价列表
[**listRooms**](DefaultApi.md#listrooms) | **GET** /api/livestream/rooms | 直播间列表
[**listSections**](DefaultApi.md#listsections) | **GET** /api/course/{courseId}/section | 获取课程的所有小节
[**listSystemTemplates**](DefaultApi.md#listsystemtemplates) | **GET** /api/workflows/templates/system | 获取系统预置模板
[**listTeachers**](DefaultApi.md#listteachers) | **GET** /api/teacher/list | 获取讲师列表
[**listTemplates1**](DefaultApi.md#listtemplates1) | **GET** /api/exam-templates | 列出所有可用模板
[**listTriggers**](DefaultApi.md#listtriggers) | **GET** /api/workflows/{id}/triggers | 获取工作流触发器列表
[**listVersions**](DefaultApi.md#listversions) | **GET** /api/workflows/{id}/versions | 获取工作流版本列表
[**listWords**](DefaultApi.md#listwords) | **GET** /api/daily-word/list | 获取单词列表
[**markAsRead**](DefaultApi.md#markasread) | **POST** /api/user/daily-article/{articleId}/read | 标记文章为已阅读
[**markAsRead1**](DefaultApi.md#markasread1) | **POST** /api/group-chat/{groupId}/messages/{messageId}/read | 标记消息已读
[**markAsRead2**](DefaultApi.md#markasread2) | **POST** /api/chat/read/{senderId} | 标记消息已读
[**markAsRead3**](DefaultApi.md#markasread3) | **POST** /api/announcement/{id}/read | 标记公告已读
[**markRepliesAsRead**](DefaultApi.md#markrepliesasread) | **POST** /api/feedback/{id}/read | 标记回复为已读
[**myRooms**](DefaultApi.md#myrooms) | **GET** /api/livestream/rooms/my | 我的直播间
[**offlineAnnouncement**](DefaultApi.md#offlineannouncement) | **POST** /api/announcement/admin/offline/{id} | 下线公告
[**offlineBanner**](DefaultApi.md#offlinebanner) | **POST** /api/admin/banner/{id}/offline | 下线轮播图
[**phoneLogin**](DefaultApi.md#phonelogin) | **POST** /api/auth/login/phone | 手机验证码登录
[**previewPdf**](DefaultApi.md#previewpdf) | **POST** /api/exam-papers/{id}/preview | 预览试卷PDF
[**previewTemplate**](DefaultApi.md#previewtemplate) | **POST** /api/exam-templates/{id}/preview | 预览模板效果（用示例数据编译PDF）
[**publish**](DefaultApi.md#publish) | **POST** /api/workflows/{id}/publish | 发布工作流
[**publishAnnouncement**](DefaultApi.md#publishannouncement) | **PUT** /api/groups/{groupId}/announcement | 发布群公告
[**publishAnnouncement1**](DefaultApi.md#publishannouncement1) | **POST** /api/announcement/admin/publish/{id} | 发布公告
[**publishBanner**](DefaultApi.md#publishbanner) | **POST** /api/admin/banner/{id}/publish | 发布轮播图
[**publishCourse**](DefaultApi.md#publishcourse) | **POST** /api/course/{id}/publish | 发布课程（管理员）
[**publishExamPaper**](DefaultApi.md#publishexampaper) | **POST** /api/exam-papers/{id}/publish | 发布试卷
[**purchaseMembership**](DefaultApi.md#purchasemembership) | **POST** /api/membership/purchase | 购买会员（创建待支付订单）
[**queryAnnouncements**](DefaultApi.md#queryannouncements) | **POST** /api/announcement/admin/list | 分页查询公告
[**queryBanners**](DefaultApi.md#querybanners) | **GET** /api/admin/banner/list | 分页查询轮播图
[**queryExamPapers**](DefaultApi.md#queryexampapers) | **GET** /api/exam-papers | 分页查询我的试卷
[**queryFeedbacks**](DefaultApi.md#queryfeedbacks) | **POST** /api/feedback/admin/list | 分页查询反馈
[**queryMyQuestions**](DefaultApi.md#querymyquestions) | **GET** /api/questions/mine | 查询我的题目
[**queryQuestions**](DefaultApi.md#queryquestions) | **GET** /api/questions | 分页查询题目
[**queryUsers**](DefaultApi.md#queryusers) | **POST** /api/user/admin/list | 分页查询用户
[**quickDynamicScrape**](DefaultApi.md#quickdynamicscrape) | **GET** /api/scraper/dynamic/quick | 快速动态抓取
[**quickScrape**](DefaultApi.md#quickscrape) | **GET** /api/scraper/quick | 快速抓取
[**refreshToken**](DefaultApi.md#refreshtoken) | **POST** /api/auth/refresh | 刷新Token
[**refund**](DefaultApi.md#refund) | **POST** /api/admin/order/{orderNo}/refund | 退款（管理员）
[**reindex**](DefaultApi.md#reindex) | **POST** /api/search/admin/reindex | 全量重建索引（管理员）
[**removeCourse**](DefaultApi.md#removecourse) | **DELETE** /api/classes/{classId}/courses/{courseId} | 移除课程
[**removeFromShelf**](DefaultApi.md#removefromshelf) | **DELETE** /api/reading/shelf | 从书架移除书籍
[**removeFromWordBook**](DefaultApi.md#removefromwordbook) | **DELETE** /api/user/word-book/{wordBookId} | 从生词本移除单词
[**removeMember**](DefaultApi.md#removemember) | **DELETE** /api/groups/{groupId}/members/{targetUserId} | 移除成员
[**removeMember1**](DefaultApi.md#removemember1) | **DELETE** /api/classes/{classId}/members/{userId} | 移除成员
[**removeMember2**](DefaultApi.md#removemember2) | **DELETE** /api/admin/groups/{groupId}/members/{targetUserId} | 移除群成员
[**removePaperQuestion**](DefaultApi.md#removepaperquestion) | **DELETE** /api/exam-papers/{paperId}/sections/{sectionId}/questions/{pqId} | 从大题移除题目
[**removeTeacher**](DefaultApi.md#removeteacher) | **DELETE** /api/teacher/{id} | 移除讲师
[**replyFeedback**](DefaultApi.md#replyfeedback) | **POST** /api/feedback/reply | 回复反馈
[**replyFeedback1**](DefaultApi.md#replyfeedback1) | **POST** /api/feedback/admin/reply | 回复反馈
[**resetPassword**](DefaultApi.md#resetpassword) | **POST** /api/user/admin/reset-password | 重置用户密码
[**resetProgress**](DefaultApi.md#resetprogress) | **POST** /api/progress/section/{sectionId}/reset | 重置小节进度
[**reviewApplication**](DefaultApi.md#reviewapplication) | **POST** /api/teacher/application/review | 审核讲师申请（管理员）
[**reviewCourse**](DefaultApi.md#reviewcourse) | **POST** /api/course/review/{courseId} | 评价课程
[**rollbackToVersion**](DefaultApi.md#rollbacktoversion) | **POST** /api/workflows/{id}/versions/{versionNumber}/rollback | 回滚到指定版本
[**scrapeArticleLinks**](DefaultApi.md#scrapearticlelinks) | **POST** /api/scraper/links | 获取文章链接
[**scrapeDynamicArticleLinks**](DefaultApi.md#scrapedynamicarticlelinks) | **POST** /api/scraper/dynamic/links | 动态获取文章链接
[**scrapeDynamicMultiplePages**](DefaultApi.md#scrapedynamicmultiplepages) | **POST** /api/scraper/dynamic/batch | 批量动态抓取
[**scrapeDynamicPage**](DefaultApi.md#scrapedynamicpage) | **POST** /api/scraper/dynamic/single | 动态抓取单个页面
[**scrapeDynamicPageWithSelector**](DefaultApi.md#scrapedynamicpagewithselector) | **POST** /api/scraper/dynamic/wait-for | 动态抓取（等待元素）
[**scrapeDynamicRecursively**](DefaultApi.md#scrapedynamicrecursively) | **POST** /api/scraper/dynamic/recursive | 递归动态抓取
[**scrapeFromSource**](DefaultApi.md#scrapefromsource) | **POST** /api/scraper/source | 从预设来源抓取
[**scrapeMultiplePages**](DefaultApi.md#scrapemultiplepages) | **POST** /api/scraper/batch | 批量抓取
[**scrapeRecursively**](DefaultApi.md#scraperecursively) | **POST** /api/scraper/recursive | 递归抓取
[**scrapeSinglePage**](DefaultApi.md#scrapesinglepage) | **POST** /api/scraper/single | 抓取单个页面
[**searchAll**](DefaultApi.md#searchall) | **GET** /api/search | 聚合搜索（书籍+章节+帖子）
[**searchArticles**](DefaultApi.md#searcharticles) | **GET** /api/daily-article/search | 搜索文章
[**searchBookChapters**](DefaultApi.md#searchbookchapters) | **GET** /api/search/books/{bookId}/chapters | 书内搜索
[**searchBooks**](DefaultApi.md#searchbooks) | **GET** /api/search/books | 搜索书籍
[**searchBooks1**](DefaultApi.md#searchbooks1) | **GET** /api/books/search | 搜索书籍
[**searchChapters**](DefaultApi.md#searchchapters) | **GET** /api/search/chapters | 搜索章节内容
[**searchCourses**](DefaultApi.md#searchcourses) | **GET** /api/course/search | 搜索课程
[**searchGroups**](DefaultApi.md#searchgroups) | **GET** /api/groups/search | 搜索群
[**searchGroups1**](DefaultApi.md#searchgroups1) | **GET** /api/admin/groups/search | 搜索群
[**searchPosts**](DefaultApi.md#searchposts) | **GET** /api/search/posts | 搜索帖子
[**searchPosts1**](DefaultApi.md#searchposts1) | **GET** /api/posts/search | 搜索帖子
[**searchPostsByTag**](DefaultApi.md#searchpostsbytag) | **GET** /api/posts/tag | 根据标签搜索帖子
[**searchTemplates**](DefaultApi.md#searchtemplates) | **GET** /api/workflows/templates | 搜索工作流模板
[**searchUsers**](DefaultApi.md#searchusers) | **POST** /api/friend/search | 搜索用户
[**searchWords**](DefaultApi.md#searchwords) | **GET** /api/daily-word/search | 搜索单词
[**sendFriendRequest**](DefaultApi.md#sendfriendrequest) | **POST** /api/friend/request/send | 发送好友申请
[**sendRegisterCode**](DefaultApi.md#sendregistercode) | **POST** /api/auth/send-code | 发送注册验证码
[**sendSms**](DefaultApi.md#sendsms) | **POST** /api/user/admin/send-sms | 发送短信验证码
[**setAdmin**](DefaultApi.md#setadmin) | **PUT** /api/groups/{groupId}/members/{targetUserId}/admin | 设置/取消管理员
[**setJoinMode**](DefaultApi.md#setjoinmode) | **PUT** /api/groups/{groupId}/join-mode | 设置群加入模式
[**setMute**](DefaultApi.md#setmute) | **POST** /api/admin/groups/{groupId}/mute | 设置群全员禁言
[**smartDynamicScrape**](DefaultApi.md#smartdynamicscrape) | **POST** /api/scraper/dynamic/smart | 智能动态抓取
[**smartScrape**](DefaultApi.md#smartscrape) | **POST** /api/scraper/smart | 智能抓取
[**startStreaming**](DefaultApi.md#startstreaming) | **POST** /api/livestream/rooms/{id}/start | 获取推流信息
[**stopStreaming**](DefaultApi.md#stopstreaming) | **POST** /api/livestream/rooms/{id}/stop | 结束直播
[**studyWord**](DefaultApi.md#studyword) | **POST** /api/user/daily-word/{wordId}/study | 标记单词为已学习
[**submitHomework**](DefaultApi.md#submithomework) | **POST** /api/grading/submit | 提交作业并开始批改（SSE流式返回进度）
[**suggest**](DefaultApi.md#suggest) | **GET** /api/search/suggest | 搜索建议（即时联想）
[**takeOffline**](DefaultApi.md#takeoffline) | **POST** /api/course/{id}/offline | 下架课程（管理员）
[**textToSpeech**](DefaultApi.md#texttospeech) | **POST** /api/speech/tts | 文本转语音
[**textToSpeechBase64**](DefaultApi.md#texttospeechbase64) | **POST** /api/speech/tts/base64 | 文本转语音 (Base64)
[**toggleCollect**](DefaultApi.md#togglecollect) | **POST** /api/user/daily-word/{wordId}/collect | 收藏/取消收藏单词
[**toggleCollect1**](DefaultApi.md#togglecollect1) | **POST** /api/user/daily-article/{articleId}/collect | 收藏/取消收藏文章
[**toggleFavour**](DefaultApi.md#togglefavour) | **POST** /api/posts/{postId}/favour | 收藏/取消收藏帖子
[**toggleFollow**](DefaultApi.md#togglefollow) | **POST** /api/follow/{targetUserId}/toggle | 切换关注状态
[**toggleLike**](DefaultApi.md#togglelike) | **POST** /api/user/daily-article/{articleId}/like | 点赞/取消点赞文章
[**toggleThumb**](DefaultApi.md#togglethumb) | **POST** /api/posts/{postId}/thumb | 点赞/取消点赞帖子
[**transferOwnership**](DefaultApi.md#transferownership) | **POST** /api/groups/{groupId}/transfer | 转让群主
[**unbindFromAssistant**](DefaultApi.md#unbindfromassistant) | **DELETE** /api/workflows/{id}/assistants/{assistantId} | 解绑工作流与AI助手
[**unfavouriteCourse**](DefaultApi.md#unfavouritecourse) | **DELETE** /api/course/favourite/{courseId} | 取消收藏
[**unfollow**](DefaultApi.md#unfollow) | **DELETE** /api/follow/{targetUserId} | 取消关注
[**unpublishExamPaper**](DefaultApi.md#unpublishexampaper) | **POST** /api/exam-papers/{id}/unpublish | 撤回试卷为草稿
[**update**](DefaultApi.md#update) | **PUT** /api/workflows/{id} | 更新工作流基本信息
[**updateAnnouncement**](DefaultApi.md#updateannouncement) | **PUT** /api/announcement/admin/update | 更新公告
[**updateBanner**](DefaultApi.md#updatebanner) | **PUT** /api/admin/banner | 更新轮播图
[**updateBook**](DefaultApi.md#updatebook) | **PUT** /api/books/{bookId} | 编辑书籍信息
[**updateBookCover**](DefaultApi.md#updatebookcover) | **PUT** /api/books/{bookId}/cover | 更新书籍封面
[**updateBookmark**](DefaultApi.md#updatebookmark) | **PUT** /api/books/{bookId}/bookmarks/{bookmarkId} | 更新书签备注/标题
[**updateChapter**](DefaultApi.md#updatechapter) | **PUT** /api/course/{courseId}/chapter/{chapterId} | 更新章节（管理员）
[**updateClass**](DefaultApi.md#updateclass) | **PUT** /api/classes/{classId} | 更新班级信息
[**updateConfig**](DefaultApi.md#updateconfig) | **PUT** /api/admin/scraper/config/{id} | 更新抓取配置
[**updateCourse**](DefaultApi.md#updatecourse) | **PUT** /api/course/{id} | 更新课程（管理员）
[**updateDailyArticle**](DefaultApi.md#updatedailyarticle) | **PUT** /api/daily-article/{id} | 更新每日文章（管理员）
[**updateDailyWord**](DefaultApi.md#updatedailyword) | **PUT** /api/daily-word/{id} | 更新每日单词（管理员）
[**updateDefinition**](DefaultApi.md#updatedefinition) | **PUT** /api/workflows/{id}/definition | 更新工作流定义
[**updateEdge**](DefaultApi.md#updateedge) | **PUT** /api/workflows/{id}/edges/{edgeId} | 更新连接线
[**updateExamPaper**](DefaultApi.md#updateexampaper) | **PUT** /api/exam-papers | 更新试卷基本信息
[**updateFeedbackStatus**](DefaultApi.md#updatefeedbackstatus) | **PUT** /api/feedback/admin/status | 更新反馈状态
[**updateGroupInfo**](DefaultApi.md#updategroupinfo) | **PUT** /api/groups/{groupId} | 更新群信息
[**updateGroupInfo1**](DefaultApi.md#updategroupinfo1) | **PUT** /api/admin/groups/{groupId} | 更新群信息
[**updateItem**](DefaultApi.md#updateitem) | **PUT** /api/schedule/item/{id} | 更新课程项
[**updateLearningStatus**](DefaultApi.md#updatelearningstatus) | **PUT** /api/user/word-book/{wordBookId}/status | 更新学习状态
[**updateMastery**](DefaultApi.md#updatemastery) | **POST** /api/user/daily-word/{wordId}/mastery | 更新单词掌握程度
[**updateNode**](DefaultApi.md#updatenode) | **PUT** /api/workflows/{id}/nodes/{nodeId} | 更新节点
[**updateNodeConfig**](DefaultApi.md#updatenodeconfig) | **PUT** /api/workflows/{id}/nodes/{nodeId}/config | 更新节点配置
[**updateNote**](DefaultApi.md#updatenote) | **PUT** /api/books/{bookId}/notes/{noteId} | 更新笔记内容/颜色
[**updatePaperQuestion**](DefaultApi.md#updatepaperquestion) | **PUT** /api/exam-papers/{paperId}/sections/{sectionId}/questions/{pqId} | 更新试卷题目分值/排序
[**updatePlan**](DefaultApi.md#updateplan) | **PUT** /api/admin/membership/plans | 更新会员计划基本信息
[**updatePlanQuota**](DefaultApi.md#updateplanquota) | **PUT** /api/admin/membership/plans/{planId}/quota | 修改计划AI配额
[**updatePost**](DefaultApi.md#updatepost) | **PUT** /api/posts/{postId} | 更新帖子
[**updateProfile**](DefaultApi.md#updateprofile) | **PUT** /api/user/profile | 更新个人资料
[**updateProgress**](DefaultApi.md#updateprogress) | **PUT** /api/reading/progress | 更新阅读进度
[**updateProgress1**](DefaultApi.md#updateprogress1) | **POST** /api/progress | 更新学习进度
[**updateQuestion**](DefaultApi.md#updatequestion) | **PUT** /api/questions | 更新题目
[**updateReview**](DefaultApi.md#updatereview) | **PUT** /api/course/review/{reviewId} | 更新评价
[**updateSection**](DefaultApi.md#updatesection) | **PUT** /api/exam-papers/{paperId}/sections/{sectionId} | 更新大题
[**updateSection1**](DefaultApi.md#updatesection1) | **PUT** /api/course/{courseId}/section/{sectionId} | 更新小节（管理员）
[**updateSetting**](DefaultApi.md#updatesetting) | **PUT** /api/schedule/setting/{id} | 更新课表配置
[**updateSettings**](DefaultApi.md#updatesettings) | **PUT** /api/workflows/{id}/settings | 更新工作流设置
[**updateTeacher**](DefaultApi.md#updateteacher) | **PUT** /api/teacher/{id} | 更新讲师信息
[**updateUser**](DefaultApi.md#updateuser) | **PUT** /api/user/admin/update | 更新用户
[**updateVariable**](DefaultApi.md#updatevariable) | **PUT** /api/workflows/{id}/variables/{variableName} | 更新变量
[**uploadBook**](DefaultApi.md#uploadbook) | **POST** /api/books/upload | 上传书籍
[**uploadTemplate1**](DefaultApi.md#uploadtemplate1) | **POST** /api/exam-templates | 上传试卷模板
[**userLogin**](DefaultApi.md#userlogin) | **POST** /api/auth/login | 用户登录
[**userRegister**](DefaultApi.md#userregister) | **POST** /api/auth/register | 用户注册
[**validate**](DefaultApi.md#validate) | **POST** /api/workflows/{id}/validate | 验证工作流定义
[**wechatCallback**](DefaultApi.md#wechatcallback) | **POST** /api/payment/callback/wechat | 微信支付异步回调（预留）


# **activateSetting**
> BaseResponseBoolean activateSetting(id)

激活课表配置

将某学期配置设为当前激活

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.activateSetting(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->activateSetting: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addComment**
> BaseResponseVoid addComment(articleId, addCommentRequest)

添加评论

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int articleId = 789; // int | 文章ID
final AddCommentRequest addCommentRequest = ; // AddCommentRequest | 

try {
    final response = api.addComment(articleId, addCommentRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->addComment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **articleId** | **int**| 文章ID | 
 **addCommentRequest** | [**AddCommentRequest**](AddCommentRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addCourse**
> BaseResponseVoid addCourse(classId, addClassCourseRequest)

添加课程

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int classId = 789; // int | 
final AddClassCourseRequest addClassCourseRequest = ; // AddClassCourseRequest | 

try {
    final response = api.addCourse(classId, addClassCourseRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->addCourse: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **classId** | **int**|  | 
 **addClassCourseRequest** | [**AddClassCourseRequest**](AddClassCourseRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addEdge**
> BaseResponseWorkflowEdgeResponse addEdge(id, addEdgeRequest)

添加连接线

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final AddEdgeRequest addEdgeRequest = ; // AddEdgeRequest | 

try {
    final response = api.addEdge(id, addEdgeRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->addEdge: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **addEdgeRequest** | [**AddEdgeRequest**](AddEdgeRequest.md)|  | 

### Return type

[**BaseResponseWorkflowEdgeResponse**](BaseResponseWorkflowEdgeResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addItem**
> BaseResponseLong addItem(addScheduleItemRequest)

添加课程项

向课表中添加课程

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final AddScheduleItemRequest addScheduleItemRequest = ; // AddScheduleItemRequest | 

try {
    final response = api.addItem(addScheduleItemRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->addItem: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **addScheduleItemRequest** | [**AddScheduleItemRequest**](AddScheduleItemRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addMember**
> BaseResponseVoid addMember(classId, addClassMemberRequest)

添加成员

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int classId = 789; // int | 
final AddClassMemberRequest addClassMemberRequest = ; // AddClassMemberRequest | 

try {
    final response = api.addMember(classId, addClassMemberRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->addMember: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **classId** | **int**|  | 
 **addClassMemberRequest** | [**AddClassMemberRequest**](AddClassMemberRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addNode**
> BaseResponseWorkflowNodeResponse addNode(id, addNodeRequest)

添加节点

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final AddNodeRequest addNodeRequest = ; // AddNodeRequest | 

try {
    final response = api.addNode(id, addNodeRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->addNode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **addNodeRequest** | [**AddNodeRequest**](AddNodeRequest.md)|  | 

### Return type

[**BaseResponseWorkflowNodeResponse**](BaseResponseWorkflowNodeResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addQuestionToSection**
> BaseResponseLong addQuestionToSection(paperId, sectionId, addPaperQuestionRequest)

向大题添加题目

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int paperId = 789; // int | 
final int sectionId = 789; // int | 
final AddPaperQuestionRequest addPaperQuestionRequest = ; // AddPaperQuestionRequest | 

try {
    final response = api.addQuestionToSection(paperId, sectionId, addPaperQuestionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->addQuestionToSection: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **paperId** | **int**|  | 
 **sectionId** | **int**|  | 
 **addPaperQuestionRequest** | [**AddPaperQuestionRequest**](AddPaperQuestionRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addSection**
> BaseResponseLong addSection(paperId, addPaperSectionRequest)

添加大题

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int paperId = 789; // int | 
final AddPaperSectionRequest addPaperSectionRequest = ; // AddPaperSectionRequest | 

try {
    final response = api.addSection(paperId, addPaperSectionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->addSection: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **paperId** | **int**|  | 
 **addPaperSectionRequest** | [**AddPaperSectionRequest**](AddPaperSectionRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addToShelf**
> BaseResponseVoid addToShelf(userId, bookId)

添加书籍到书架

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int userId = 789; // int | 
final int bookId = 789; // int | 

try {
    final response = api.addToShelf(userId, bookId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->addToShelf: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**|  | 
 **bookId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addToWordBook**
> BaseResponseLong addToWordBook(wordId)

添加单词到生词本

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int wordId = 789; // int | 单词ID

try {
    final response = api.addToWordBook(wordId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->addToWordBook: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wordId** | **int**| 单词ID | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addVariable**
> BaseResponseWorkflowVariableResponse addVariable(id, addVariableRequest)

添加变量

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final AddVariableRequest addVariableRequest = ; // AddVariableRequest | 

try {
    final response = api.addVariable(id, addVariableRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->addVariable: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **addVariableRequest** | [**AddVariableRequest**](AddVariableRequest.md)|  | 

### Return type

[**BaseResponseWorkflowVariableResponse**](BaseResponseWorkflowVariableResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminDeletePost**
> BaseResponseVoid adminDeletePost(postId)

管理员删除帖子

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int postId = 789; // int | 

try {
    final response = api.adminDeletePost(postId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->adminDeletePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **aiGenerateQuestions**
> SseEmitter aiGenerateQuestions(aiGenerateQuestionsRequest)

AI 智能出题

支持联网搜索热点、几何图形渲染、文生图配图

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final AiGenerateQuestionsRequest aiGenerateQuestionsRequest = ; // AiGenerateQuestionsRequest | 

try {
    final response = api.aiGenerateQuestions(aiGenerateQuestionsRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->aiGenerateQuestions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **aiGenerateQuestionsRequest** | [**AiGenerateQuestionsRequest**](AiGenerateQuestionsRequest.md)|  | 

### Return type

[**SseEmitter**](SseEmitter.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, text/event-stream

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **alipayCallback**
> String alipayCallback(body)

支付宝异步回调（预留）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String body = body_example; // String | 

try {
    final response = api.alipayCallback(body);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->alipayCallback: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | **String**|  | 

### Return type

**String**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **applyTeacher**
> BaseResponseLong applyTeacher(applyTeacherRequest)

申请成为讲师

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final ApplyTeacherRequest applyTeacherRequest = ; // ApplyTeacherRequest | 

try {
    final response = api.applyTeacher(applyTeacherRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->applyTeacher: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **applyTeacherRequest** | [**ApplyTeacherRequest**](ApplyTeacherRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **applyToJoin**
> BaseResponseJoinRequestResponse applyToJoin(groupId, joinGroupRequest)

申请加入群

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 
final JoinGroupRequest joinGroupRequest = ; // JoinGroupRequest | 

try {
    final response = api.applyToJoin(groupId, joinGroupRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->applyToJoin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 
 **joinGroupRequest** | [**JoinGroupRequest**](JoinGroupRequest.md)|  | [optional] 

### Return type

[**BaseResponseJoinRequestResponse**](BaseResponseJoinRequestResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **archive**
> BaseResponseWorkflowResponse archive(id)

归档工作流

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID

try {
    final response = api.archive(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->archive: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 

### Return type

[**BaseResponseWorkflowResponse**](BaseResponseWorkflowResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **batchBanUsers**
> BaseResponseBoolean batchBanUsers(batchBanUserRequest)

批量封禁/解封用户

管理员批量封禁或解封用户

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final BatchBanUserRequest batchBanUserRequest = ; // BatchBanUserRequest | 

try {
    final response = api.batchBanUsers(batchBanUserRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->batchBanUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **batchBanUserRequest** | [**BatchBanUserRequest**](BatchBanUserRequest.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **batchCreateUsers**
> BaseResponseListLong batchCreateUsers(batchCreateUserRequest)

批量创建用户

管理员批量创建用户

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final BatchCreateUserRequest batchCreateUserRequest = ; // BatchCreateUserRequest | 

try {
    final response = api.batchCreateUsers(batchCreateUserRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->batchCreateUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **batchCreateUserRequest** | [**BatchCreateUserRequest**](BatchCreateUserRequest.md)|  | 

### Return type

[**BaseResponseListLong**](BaseResponseListLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **batchSyncAll**
> BaseResponseString batchSyncAll(batchSize)

批量同步所有数据到知识图谱（高效批量导入）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int batchSize = 56; // int | 每批次数量，默认500

try {
    final response = api.batchSyncAll(batchSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->batchSyncAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **batchSize** | **int**| 每批次数量，默认500 | [optional] [default to 500]

### Return type

[**BaseResponseString**](BaseResponseString.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **batchSyncArticles**
> BaseResponseInteger batchSyncArticles(batchSize)

批量同步每日文章到知识图谱（高效批量导入）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int batchSize = 56; // int | 每批次数量，默认500

try {
    final response = api.batchSyncArticles(batchSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->batchSyncArticles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **batchSize** | **int**| 每批次数量，默认500 | [optional] [default to 500]

### Return type

[**BaseResponseInteger**](BaseResponseInteger.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **batchSyncWords**
> BaseResponseInteger batchSyncWords(batchSize)

批量同步每日单词到知识图谱（高效批量导入）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int batchSize = 56; // int | 每批次数量，默认500

try {
    final response = api.batchSyncWords(batchSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->batchSyncWords: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **batchSize** | **int**| 每批次数量，默认500 | [optional] [default to 500]

### Return type

[**BaseResponseInteger**](BaseResponseInteger.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **batchUpdate**
> BaseResponseWorkflowDefinitionResponse batchUpdate(id, batchUpdateNodesRequest)

批量更新节点和连接线

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final BatchUpdateNodesRequest batchUpdateNodesRequest = ; // BatchUpdateNodesRequest | 

try {
    final response = api.batchUpdate(id, batchUpdateNodesRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->batchUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **batchUpdateNodesRequest** | [**BatchUpdateNodesRequest**](BatchUpdateNodesRequest.md)|  | 

### Return type

[**BaseResponseWorkflowDefinitionResponse**](BaseResponseWorkflowDefinitionResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bindToAssistant**
> BaseResponseVoid bindToAssistant(id, assistantId)

绑定工作流到AI助手

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final int assistantId = 789; // int | AI助手ID

try {
    final response = api.bindToAssistant(id, assistantId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->bindToAssistant: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **assistantId** | **int**| AI助手ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **cancelExecution**
> BaseResponseVoid cancelExecution(executionId)

取消执行

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String executionId = executionId_example; // String | 执行ID

try {
    final response = api.cancelExecution(executionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->cancelExecution: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **executionId** | **String**| 执行ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **cancelMembership**
> BaseResponseVoid cancelMembership()

取消会员

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.cancelMembership();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->cancelMembership: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **cancelMembership1**
> BaseResponseVoid cancelMembership1(userId)

取消用户会员

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int userId = 789; // int | 

try {
    final response = api.cancelMembership1(userId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->cancelMembership1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **changePassword**
> BaseResponseBoolean changePassword(changePasswordRequest)

修改密码

用户修改自己的密码，需要验证旧密码

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final ChangePasswordRequest changePasswordRequest = ; // ChangePasswordRequest | 

try {
    final response = api.changePassword(changePasswordRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->changePassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **changePasswordRequest** | [**ChangePasswordRequest**](ChangePasswordRequest.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **checkFavourite**
> BaseResponseBoolean checkFavourite(courseId)

检查是否已收藏

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID

try {
    final response = api.checkFavourite(courseId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->checkFavourite: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **checkFriendship**
> BaseResponseBoolean checkFriendship(userId)

检查好友关系

检查当前用户与目标用户是否是好友

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int userId = 789; // int | 

try {
    final response = api.checkFriendship(userId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->checkFriendship: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **checkin**
> BaseResponseCheckinResult checkin()

用户打卡

每日打卡，每天只能打卡一次

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.checkin();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->checkin: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseCheckinResult**](BaseResponseCheckinResult.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **completeSection**
> BaseResponseVoid completeSection(sectionId, courseId)

标记小节为已完成

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int sectionId = 789; // int | 小节ID
final int courseId = 789; // int | 课程ID

try {
    final response = api.completeSection(sectionId, courseId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->completeSection: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sectionId** | **int**| 小节ID | 
 **courseId** | **int**| 课程ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **confirmPayment**
> BaseResponseVoid confirmPayment(confirmPaymentRequest)

确认收款（管理员手动确认）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final ConfirmPaymentRequest confirmPaymentRequest = ; // ConfirmPaymentRequest | 

try {
    final response = api.confirmPayment(confirmPaymentRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->confirmPayment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **confirmPaymentRequest** | [**ConfirmPaymentRequest**](ConfirmPaymentRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **confirmPayment1**
> BaseResponseVoid confirmPayment1(orderNo)

确认会员支付（管理员手动确认）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String orderNo = orderNo_example; // String | 会员订单号

try {
    final response = api.confirmPayment1(orderNo);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->confirmPayment1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderNo** | **String**| 会员订单号 | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **copy**
> BaseResponseWorkflowResponse copy(id, newName, userId)

复制工作流

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final String newName = newName_example; // String | 新工作流名称
final int userId = 789; // int | 用户ID

try {
    final response = api.copy(id, newName, userId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->copy: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **newName** | **String**| 新工作流名称 | 
 **userId** | **int**| 用户ID | 

### Return type

[**BaseResponseWorkflowResponse**](BaseResponseWorkflowResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **create**
> BaseResponseWorkflowResponse create(createWorkflowRequest)

创建工作流

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreateWorkflowRequest createWorkflowRequest = ; // CreateWorkflowRequest | 

try {
    final response = api.create(createWorkflowRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->create: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createWorkflowRequest** | [**CreateWorkflowRequest**](CreateWorkflowRequest.md)|  | 

### Return type

[**BaseResponseWorkflowResponse**](BaseResponseWorkflowResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createAnnouncement**
> BaseResponseLong createAnnouncement(createAnnouncementRequest)

创建公告

创建新公告，初始状态为草稿

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreateAnnouncementRequest createAnnouncementRequest = ; // CreateAnnouncementRequest | 

try {
    final response = api.createAnnouncement(createAnnouncementRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createAnnouncement: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createAnnouncementRequest** | [**CreateAnnouncementRequest**](CreateAnnouncementRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createBanner**
> BaseResponseLong createBanner(createBannerRequest)

创建轮播图

创建新的轮播图

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreateBannerRequest createBannerRequest = ; // CreateBannerRequest | 

try {
    final response = api.createBanner(createBannerRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createBanner: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createBannerRequest** | [**CreateBannerRequest**](CreateBannerRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createBookmark**
> BaseResponseReadingBookmarkDTO createBookmark(bookId, requestBody)

创建书签

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int bookId = 789; // int | 
final BuiltMap<String, JsonObject> requestBody = Object; // BuiltMap<String, JsonObject> | 

try {
    final response = api.createBookmark(bookId, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createBookmark: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **requestBody** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)|  | 

### Return type

[**BaseResponseReadingBookmarkDTO**](BaseResponseReadingBookmarkDTO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createChapter**
> BaseResponseLong createChapter(courseId, createChapterRequest)

创建章节（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID
final CreateChapterRequest createChapterRequest = ; // CreateChapterRequest | 

try {
    final response = api.createChapter(courseId, createChapterRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createChapter: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 
 **createChapterRequest** | [**CreateChapterRequest**](CreateChapterRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createClass**
> BaseResponseClassResponse createClass(createClassRequest)

创建班级

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreateClassRequest createClassRequest = ; // CreateClassRequest | 

try {
    final response = api.createClass(createClassRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createClass: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createClassRequest** | [**CreateClassRequest**](CreateClassRequest.md)|  | 

### Return type

[**BaseResponseClassResponse**](BaseResponseClassResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createComment**
> BaseResponseCommentResponse createComment(postId, createCommentRequest)

发表评论

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int postId = 789; // int | 
final CreateCommentRequest createCommentRequest = ; // CreateCommentRequest | 

try {
    final response = api.createComment(postId, createCommentRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createComment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postId** | **int**|  | 
 **createCommentRequest** | [**CreateCommentRequest**](CreateCommentRequest.md)|  | 

### Return type

[**BaseResponseCommentResponse**](BaseResponseCommentResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createConfig**
> BaseResponseScraperConfigResponse createConfig(scraperConfigRequest)

创建抓取配置

创建新的抓取源配置

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final ScraperConfigRequest scraperConfigRequest = ; // ScraperConfigRequest | 

try {
    final response = api.createConfig(scraperConfigRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createConfig: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **scraperConfigRequest** | [**ScraperConfigRequest**](ScraperConfigRequest.md)|  | 

### Return type

[**BaseResponseScraperConfigResponse**](BaseResponseScraperConfigResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createCourse**
> BaseResponseLong createCourse(createCourseRequest)

创建课程（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreateCourseRequest createCourseRequest = ; // CreateCourseRequest | 

try {
    final response = api.createCourse(createCourseRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createCourse: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createCourseRequest** | [**CreateCourseRequest**](CreateCourseRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createDailyArticle**
> BaseResponseLong createDailyArticle(createDailyArticleRequest)

创建每日文章（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreateDailyArticleRequest createDailyArticleRequest = ; // CreateDailyArticleRequest | 

try {
    final response = api.createDailyArticle(createDailyArticleRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createDailyArticle: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createDailyArticleRequest** | [**CreateDailyArticleRequest**](CreateDailyArticleRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createDailyWord**
> BaseResponseLong createDailyWord(createDailyWordRequest)

创建每日单词（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreateDailyWordRequest createDailyWordRequest = ; // CreateDailyWordRequest | 

try {
    final response = api.createDailyWord(createDailyWordRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createDailyWord: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createDailyWordRequest** | [**CreateDailyWordRequest**](CreateDailyWordRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createExamPaper**
> BaseResponseLong createExamPaper(createExamPaperRequest)

创建试卷

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreateExamPaperRequest createExamPaperRequest = ; // CreateExamPaperRequest | 

try {
    final response = api.createExamPaper(createExamPaperRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createExamPaper: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createExamPaperRequest** | [**CreateExamPaperRequest**](CreateExamPaperRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createFeedback**
> BaseResponseLong createFeedback(createFeedbackRequest)

创建反馈

用户提交新的反馈

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreateFeedbackRequest createFeedbackRequest = ; // CreateFeedbackRequest | 

try {
    final response = api.createFeedback(createFeedbackRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createFeedback: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createFeedbackRequest** | [**CreateFeedbackRequest**](CreateFeedbackRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createFromTemplate**
> BaseResponseWorkflowResponse createFromTemplate(templateId, userId, name, description)

从模板创建工作流

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int templateId = 789; // int | 模板ID
final int userId = 789; // int | 
final String name = name_example; // String | 
final String description = description_example; // String | 

try {
    final response = api.createFromTemplate(templateId, userId, name, description);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createFromTemplate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **templateId** | **int**| 模板ID | 
 **userId** | **int**|  | 
 **name** | **String**|  | [optional] 
 **description** | **String**|  | [optional] 

### Return type

[**BaseResponseWorkflowResponse**](BaseResponseWorkflowResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createGroup**
> BaseResponseGroupResponse createGroup(createGroupRequest)

创建群聊

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreateGroupRequest createGroupRequest = ; // CreateGroupRequest | 

try {
    final response = api.createGroup(createGroupRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createGroup: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createGroupRequest** | [**CreateGroupRequest**](CreateGroupRequest.md)|  | 

### Return type

[**BaseResponseGroupResponse**](BaseResponseGroupResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createGroupFromClass**
> BaseResponseLong createGroupFromClass(classId)

基于班级创建群聊

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int classId = 789; // int | 

try {
    final response = api.createGroupFromClass(classId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createGroupFromClass: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **classId** | **int**|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createNote**
> BaseResponseReadingNoteDTO createNote(bookId, createReadingNoteCommand)

创建阅读笔记

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int bookId = 789; // int | 
final CreateReadingNoteCommand createReadingNoteCommand = ; // CreateReadingNoteCommand | 

try {
    final response = api.createNote(bookId, createReadingNoteCommand);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createNote: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **createReadingNoteCommand** | [**CreateReadingNoteCommand**](CreateReadingNoteCommand.md)|  | 

### Return type

[**BaseResponseReadingNoteDTO**](BaseResponseReadingNoteDTO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createOrder**
> BaseResponseString createOrder(createOrderRequest)

创建订单（用户下单）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreateOrderRequest createOrderRequest = ; // CreateOrderRequest | 

try {
    final response = api.createOrder(createOrderRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createOrderRequest** | [**CreateOrderRequest**](CreateOrderRequest.md)|  | 

### Return type

[**BaseResponseString**](BaseResponseString.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createPlan**
> BaseResponseMembershipPlan createPlan(createPlanRequest)

创建会员计划

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreatePlanRequest createPlanRequest = ; // CreatePlanRequest | 

try {
    final response = api.createPlan(createPlanRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createPlan: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createPlanRequest** | [**CreatePlanRequest**](CreatePlanRequest.md)|  | 

### Return type

[**BaseResponseMembershipPlan**](BaseResponseMembershipPlan.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createPost**
> BaseResponsePostResponse createPost(createPostRequest)

发布帖子

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreatePostRequest createPostRequest = ; // CreatePostRequest | 

try {
    final response = api.createPost(createPostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createPostRequest** | [**CreatePostRequest**](CreatePostRequest.md)|  | 

### Return type

[**BaseResponsePostResponse**](BaseResponsePostResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createQuestion**
> BaseResponseLong createQuestion(createQuestionRequest)

创建题目

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreateQuestionRequest createQuestionRequest = ; // CreateQuestionRequest | 

try {
    final response = api.createQuestion(createQuestionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createQuestion: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createQuestionRequest** | [**CreateQuestionRequest**](CreateQuestionRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createReply**
> BaseResponseReplyResponse createReply(commentId, createReplyRequest)

发表回复

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int commentId = 789; // int | 
final CreateReplyRequest createReplyRequest = ; // CreateReplyRequest | 

try {
    final response = api.createReply(commentId, createReplyRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createReply: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **commentId** | **int**|  | 
 **createReplyRequest** | [**CreateReplyRequest**](CreateReplyRequest.md)|  | 

### Return type

[**BaseResponseReplyResponse**](BaseResponseReplyResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createRoom**
> BaseResponseLiveRoomResponse createRoom(createLiveRoomRequest)

创建直播间

教师创建直播间，支持公开和班级专属

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreateLiveRoomRequest createLiveRoomRequest = ; // CreateLiveRoomRequest | 

try {
    final response = api.createRoom(createLiveRoomRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createRoom: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createLiveRoomRequest** | [**CreateLiveRoomRequest**](CreateLiveRoomRequest.md)|  | 

### Return type

[**BaseResponseLiveRoomResponse**](BaseResponseLiveRoomResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createScheduleTrigger**
> BaseResponseWorkflowTriggerResponse createScheduleTrigger(id, name, cronExpression, timezone)

创建定时触发器

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final String name = name_example; // String | 
final String cronExpression = cronExpression_example; // String | 
final String timezone = timezone_example; // String | 

try {
    final response = api.createScheduleTrigger(id, name, cronExpression, timezone);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createScheduleTrigger: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **name** | **String**|  | 
 **cronExpression** | **String**|  | 
 **timezone** | **String**|  | [optional] 

### Return type

[**BaseResponseWorkflowTriggerResponse**](BaseResponseWorkflowTriggerResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createSection**
> BaseResponseLong createSection(courseId, createSectionRequest)

创建小节（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID
final CreateSectionRequest createSectionRequest = ; // CreateSectionRequest | 

try {
    final response = api.createSection(courseId, createSectionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createSection: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 
 **createSectionRequest** | [**CreateSectionRequest**](CreateSectionRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createSetting**
> BaseResponseLong createSetting(createScheduleSettingRequest)

创建课表配置

管理员/教师创建班级课表配置

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreateScheduleSettingRequest createScheduleSettingRequest = ; // CreateScheduleSettingRequest | 

try {
    final response = api.createSetting(createScheduleSettingRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createSetting: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createScheduleSettingRequest** | [**CreateScheduleSettingRequest**](CreateScheduleSettingRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createTemplate**
> BaseResponseWorkflowTemplateResponse createTemplate(workflowId, name, userId, description, category)

从工作流创建模板

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int workflowId = 789; // int | 工作流ID
final String name = name_example; // String | 
final int userId = 789; // int | 
final String description = description_example; // String | 
final String category = category_example; // String | 

try {
    final response = api.createTemplate(workflowId, name, userId, description, category);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createTemplate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **workflowId** | **int**| 工作流ID | 
 **name** | **String**|  | 
 **userId** | **int**|  | 
 **description** | **String**|  | [optional] 
 **category** | **String**|  | [optional] 

### Return type

[**BaseResponseWorkflowTemplateResponse**](BaseResponseWorkflowTemplateResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createUser**
> BaseResponseLong createUser(createUserRequest)

创建用户

管理员创建单个用户

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreateUserRequest createUserRequest = ; // CreateUserRequest | 

try {
    final response = api.createUser(createUserRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createUserRequest** | [**CreateUserRequest**](CreateUserRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createVersionSnapshot**
> BaseResponseWorkflowVersionResponse createVersionSnapshot(id, userId, publishNote)

创建版本快照（发布时）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final int userId = 789; // int | 
final String publishNote = publishNote_example; // String | 

try {
    final response = api.createVersionSnapshot(id, userId, publishNote);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createVersionSnapshot: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **userId** | **int**|  | 
 **publishNote** | **String**|  | [optional] 

### Return type

[**BaseResponseWorkflowVersionResponse**](BaseResponseWorkflowVersionResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createWebhookTrigger**
> BaseResponseWorkflowTriggerResponse createWebhookTrigger(id, name, secret, validateSignature)

创建Webhook触发器

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final String name = name_example; // String | 
final String secret = secret_example; // String | 
final bool validateSignature = true; // bool | 

try {
    final response = api.createWebhookTrigger(id, name, secret, validateSignature);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createWebhookTrigger: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **name** | **String**|  | 
 **secret** | **String**|  | [optional] 
 **validateSignature** | **bool**|  | [optional] [default to false]

### Return type

[**BaseResponseWorkflowTriggerResponse**](BaseResponseWorkflowTriggerResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **delete**
> BaseResponseVoid delete(id)

删除工作流

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID

try {
    final response = api.delete(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->delete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteAnnouncement**
> BaseResponseBoolean deleteAnnouncement(id)

删除公告

逻辑删除公告

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.deleteAnnouncement(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteAnnouncement: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteBanner**
> BaseResponseBoolean deleteBanner(id)

删除轮播图

删除指定轮播图

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.deleteBanner(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteBanner: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteBook**
> BaseResponseVoid deleteBook(bookId)

删除书籍

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int bookId = 789; // int | 

try {
    final response = api.deleteBook(bookId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteBook: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteBookmark**
> BaseResponseVoid deleteBookmark(bookId, bookmarkId)

删除书签

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int bookId = 789; // int | 
final int bookmarkId = 789; // int | 

try {
    final response = api.deleteBookmark(bookId, bookmarkId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteBookmark: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **bookmarkId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteChapter**
> BaseResponseVoid deleteChapter(courseId, chapterId)

删除章节（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID
final int chapterId = 789; // int | 章节ID

try {
    final response = api.deleteChapter(courseId, chapterId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteChapter: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 
 **chapterId** | **int**| 章节ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteClass**
> BaseResponseVoid deleteClass(classId)

删除班级

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int classId = 789; // int | 

try {
    final response = api.deleteClass(classId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteClass: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **classId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteComment**
> BaseResponseVoid deleteComment(commentId)

删除评论

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int commentId = 789; // int | 

try {
    final response = api.deleteComment(commentId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteComment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **commentId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteConfig**
> BaseResponseVoid deleteConfig(id)

删除配置

删除指定的抓取配置

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.deleteConfig(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteConfig: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteCourse**
> BaseResponseVoid deleteCourse(id)

删除课程（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 课程ID

try {
    final response = api.deleteCourse(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteCourse: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 课程ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteDailyArticle**
> BaseResponseVoid deleteDailyArticle(id)

删除每日文章（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 文章ID

try {
    final response = api.deleteDailyArticle(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteDailyArticle: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 文章ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteDailyWord**
> BaseResponseVoid deleteDailyWord(id)

删除每日单词（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 单词ID

try {
    final response = api.deleteDailyWord(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteDailyWord: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 单词ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteEdge**
> BaseResponseVoid deleteEdge(id, edgeId)

删除连接线

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final String edgeId = edgeId_example; // String | 连接线ID

try {
    final response = api.deleteEdge(id, edgeId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteEdge: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **edgeId** | **String**| 连接线ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteExamPaper**
> BaseResponseBoolean deleteExamPaper(id)

删除试卷

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.deleteExamPaper(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteExamPaper: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteFeedback**
> BaseResponseBoolean deleteFeedback(id)

删除反馈

用户删除自己的反馈

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.deleteFeedback(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteFeedback: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteFeedback1**
> BaseResponseBoolean deleteFeedback1(id)

删除反馈

管理员删除反馈

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.deleteFeedback1(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteFeedback1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteFile**
> BaseResponseVoid deleteFile(fileId)

删除文件

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int fileId = 789; // int | 文件ID

try {
    final response = api.deleteFile(fileId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteFile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **fileId** | **int**| 文件ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteFriend**
> BaseResponseBoolean deleteFriend(friendId)

删除好友

删除指定好友

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int friendId = 789; // int | 

try {
    final response = api.deleteFriend(friendId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteFriend: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **friendId** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteItem**
> BaseResponseBoolean deleteItem(id)

删除课程项

删除课程项

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.deleteItem(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteItem: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteMessage**
> BaseResponseVoid deleteMessage(groupId, messageId)

删除消息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 
final int messageId = 789; // int | 

try {
    final response = api.deleteMessage(groupId, messageId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteMessage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 
 **messageId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteNode**
> BaseResponseVoid deleteNode(id, nodeId)

删除节点

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final String nodeId = nodeId_example; // String | 节点ID

try {
    final response = api.deleteNode(id, nodeId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteNode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **nodeId** | **String**| 节点ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteNote**
> BaseResponseVoid deleteNote(bookId, noteId)

删除笔记

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int bookId = 789; // int | 
final int noteId = 789; // int | 

try {
    final response = api.deleteNote(bookId, noteId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteNote: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **noteId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deletePlan**
> BaseResponseVoid deletePlan(planId)

删除会员计划

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int planId = 789; // int | 

try {
    final response = api.deletePlan(planId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deletePlan: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **planId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deletePost**
> BaseResponseVoid deletePost(postId)

删除帖子

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int postId = 789; // int | 

try {
    final response = api.deletePost(postId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deletePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteQuestion**
> BaseResponseBoolean deleteQuestion(id)

删除题目

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.deleteQuestion(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteQuestion: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteReply**
> BaseResponseVoid deleteReply(replyId)

删除回复

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int replyId = 789; // int | 

try {
    final response = api.deleteReply(replyId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteReply: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **replyId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteRoom**
> BaseResponseBoolean deleteRoom(id)

删除直播间

主播或管理员删除直播间

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.deleteRoom(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteRoom: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteSection**
> BaseResponseBoolean deleteSection(paperId, sectionId)

删除大题

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int paperId = 789; // int | 
final int sectionId = 789; // int | 

try {
    final response = api.deleteSection(paperId, sectionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteSection: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **paperId** | **int**|  | 
 **sectionId** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteSection1**
> BaseResponseVoid deleteSection1(courseId, sectionId)

删除小节（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID
final int sectionId = 789; // int | 小节ID

try {
    final response = api.deleteSection1(courseId, sectionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteSection1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 
 **sectionId** | **int**| 小节ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteTemplate**
> BaseResponseVoid deleteTemplate(templateId)

删除模板

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int templateId = 789; // int | 模板ID

try {
    final response = api.deleteTemplate(templateId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteTemplate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **templateId** | **int**| 模板ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteTemplate2**
> BaseResponseVoid deleteTemplate2(id)

删除模板

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 模板ID

try {
    final response = api.deleteTemplate2(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteTemplate2: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 模板ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteTrigger**
> BaseResponseVoid deleteTrigger(triggerId)

删除触发器

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int triggerId = 789; // int | 触发器ID

try {
    final response = api.deleteTrigger(triggerId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteTrigger: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **triggerId** | **int**| 触发器ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteVariable**
> BaseResponseVoid deleteVariable(id, variableName)

删除变量

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final String variableName = variableName_example; // String | 变量名称

try {
    final response = api.deleteVariable(id, variableName);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteVariable: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **variableName** | **String**| 变量名称 | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **disableConfig**
> BaseResponseVoid disableConfig(id)

禁用配置

禁用指定的抓取配置

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.disableConfig(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->disableConfig: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **disableTrigger**
> BaseResponseWorkflowTriggerResponse disableTrigger(triggerId)

禁用触发器

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int triggerId = 789; // int | 触发器ID

try {
    final response = api.disableTrigger(triggerId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->disableTrigger: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **triggerId** | **int**| 触发器ID | 

### Return type

[**BaseResponseWorkflowTriggerResponse**](BaseResponseWorkflowTriggerResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **dissolveGroup**
> BaseResponseVoid dissolveGroup(groupId)

解散群

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 

try {
    final response = api.dissolveGroup(groupId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->dissolveGroup: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **dissolveGroup1**
> BaseResponseVoid dissolveGroup1(groupId)

解散群

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 群ID

try {
    final response = api.dissolveGroup1(groupId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->dissolveGroup1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**| 群ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **enableConfig**
> BaseResponseVoid enableConfig(id)

启用配置

启用指定的抓取配置

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.enableConfig(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->enableConfig: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **enableTrigger**
> BaseResponseWorkflowTriggerResponse enableTrigger(triggerId)

启用触发器

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int triggerId = 789; // int | 触发器ID

try {
    final response = api.enableTrigger(triggerId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->enableTrigger: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **triggerId** | **int**| 触发器ID | 

### Return type

[**BaseResponseWorkflowTriggerResponse**](BaseResponseWorkflowTriggerResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **encryptAllChapters**
> BaseResponseInteger encryptAllChapters(bookId)

批量加密所有章节

对整本书所有未加密章节进行AES加密存储

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int bookId = 789; // int | 

try {
    final response = api.encryptAllChapters(bookId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->encryptAllChapters: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 

### Return type

[**BaseResponseInteger**](BaseResponseInteger.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **encryptChapterContent**
> BaseResponseVoid encryptChapterContent(bookId, chapterIndex)

加密章节内容

对指定章节的内容进行AES加密存储

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int bookId = 789; // int | 
final int chapterIndex = 56; // int | 

try {
    final response = api.encryptChapterContent(bookId, chapterIndex);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->encryptChapterContent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **chapterIndex** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **execute**
> BaseResponseExecutionResultResponse execute(id, executeWorkflowRequest)

执行工作流

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final ExecuteWorkflowRequest executeWorkflowRequest = ; // ExecuteWorkflowRequest | 

try {
    final response = api.execute(id, executeWorkflowRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->execute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **executeWorkflowRequest** | [**ExecuteWorkflowRequest**](ExecuteWorkflowRequest.md)|  | 

### Return type

[**BaseResponseExecutionResultResponse**](BaseResponseExecutionResultResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **executeAllTasks**
> BaseResponseVoid executeAllTasks()

触发所有抓取

手动触发所有启用配置的抓取任务

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.executeAllTasks();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->executeAllTasks: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **executeAsync**
> BaseResponseAsyncExecutionResponse executeAsync(id, executeWorkflowRequest)

异步执行工作流

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final ExecuteWorkflowRequest executeWorkflowRequest = ; // ExecuteWorkflowRequest | 

try {
    final response = api.executeAsync(id, executeWorkflowRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->executeAsync: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **executeWorkflowRequest** | [**ExecuteWorkflowRequest**](ExecuteWorkflowRequest.md)|  | 

### Return type

[**BaseResponseAsyncExecutionResponse**](BaseResponseAsyncExecutionResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **executeTask**
> BaseResponseScraperTaskResponse executeTask(executeTaskRequest)

执行抓取任务

手动触发指定配置的抓取任务

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final ExecuteTaskRequest executeTaskRequest = ; // ExecuteTaskRequest | 

try {
    final response = api.executeTask(executeTaskRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->executeTask: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **executeTaskRequest** | [**ExecuteTaskRequest**](ExecuteTaskRequest.md)|  | 

### Return type

[**BaseResponseScraperTaskResponse**](BaseResponseScraperTaskResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **exportAnswerKey**
> String exportAnswerKey(id)

导出参考答案PDF

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.exportAnswerKey(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->exportAnswerKey: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

**String**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **favouriteCourse**
> BaseResponseVoid favouriteCourse(courseId)

收藏课程

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID

try {
    final response = api.favouriteCourse(courseId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->favouriteCourse: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **follow**
> BaseResponseVoid follow(targetUserId)

关注用户

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int targetUserId = 789; // int | 

try {
    final response = api.follow(targetUserId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->follow: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **targetUserId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **generateBannerImage**
> BaseResponseGenerateBannerImageResponse generateBannerImage(generateBannerImageRequest)

AI生成轮播图图片

根据标题和图片描述，使用AI生成轮播图图片

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final GenerateBannerImageRequest generateBannerImageRequest = ; // GenerateBannerImageRequest | 

try {
    final response = api.generateBannerImage(generateBannerImageRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->generateBannerImage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **generateBannerImageRequest** | [**GenerateBannerImageRequest**](GenerateBannerImageRequest.md)|  | 

### Return type

[**BaseResponseGenerateBannerImageResponse**](BaseResponseGenerateBannerImageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAiQuota**
> BaseResponseMapStringMapStringInteger getAiQuota()

查询我的AI功能剩余额度

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getAiQuota();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getAiQuota: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseMapStringMapStringInteger**](BaseResponseMapStringMapStringInteger.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllConfigs**
> BaseResponseListScraperConfigResponse getAllConfigs()

获取所有配置

获取所有抓取源配置列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getAllConfigs();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getAllConfigs: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListScraperConfigResponse**](BaseResponseListScraperConfigResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllFriends**
> BaseResponseListFriendResponse getAllFriends()

获取全部好友

获取当前用户的全部好友列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getAllFriends();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getAllFriends: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListFriendResponse**](BaseResponseListFriendResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllProfiles**
> BaseResponseListSubjectProfileSummary getAllProfiles()

查询学生全部知识画像

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getAllProfiles();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getAllProfiles: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListSubjectProfileSummary**](BaseResponseListSubjectProfileSummary.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllTasks**
> BaseResponseScraperTaskPageResponse getAllTasks(page, size)

获取所有任务

获取所有抓取任务列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.getAllTasks(page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getAllTasks: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponseScraperTaskPageResponse**](BaseResponseScraperTaskPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAnnouncement**
> BaseResponseAnnouncementResponse getAnnouncement(id)

获取公告详情

获取公告详细信息，包含阅读统计

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.getAnnouncement(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getAnnouncement: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseAnnouncementResponse**](BaseResponseAnnouncementResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAnnouncementDetail**
> BaseResponseAnnouncementDetailResponse getAnnouncementDetail(id)

获取公告详情

获取公告详细内容

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.getAnnouncementDetail(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getAnnouncementDetail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseAnnouncementDetailResponse**](BaseResponseAnnouncementDetailResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAnnouncementList**
> BaseResponseUserAnnouncementPageResponse getAnnouncementList(pageNum, pageSize)

获取公告列表

获取用户可见的公告列表，包含已读状态

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.getAnnouncementList(pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getAnnouncementList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponseUserAnnouncementPageResponse**](BaseResponseUserAnnouncementPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getApplication**
> BaseResponseTeacherApplicationResponse getApplication(id)

获取申请详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 申请ID

try {
    final response = api.getApplication(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getApplication: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 申请ID | 

### Return type

[**BaseResponseTeacherApplicationResponse**](BaseResponseTeacherApplicationResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getArticlesByDate**
> BaseResponseListDailyArticleResponse getArticlesByDate(date)

获取指定日期文章

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final Date date = 2013-10-20; // Date | 日期

try {
    final response = api.getArticlesByDate(date);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getArticlesByDate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **date** | **Date**| 日期 | 

### Return type

[**BaseResponseListDailyArticleResponse**](BaseResponseListDailyArticleResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getBannerDetail**
> BaseResponseBannerResponse getBannerDetail(id)

获取轮播图详情

获取轮播图详细信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.getBannerDetail(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getBannerDetail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseBannerResponse**](BaseResponseBannerResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getBannerList**
> BaseResponseListBannerListResponse getBannerList()

获取轮播图列表

获取用户可见的轮播图列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getBannerList();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getBannerList: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListBannerListResponse**](BaseResponseListBannerListResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getBook**
> BaseResponseBookDTO getBook(bookId)

获取书籍详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int bookId = 789; // int | 

try {
    final response = api.getBook(bookId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getBook: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 

### Return type

[**BaseResponseBookDTO**](BaseResponseBookDTO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getBookChapters**
> BaseResponseListChapterDTO getBookChapters(bookId)

获取书籍章节列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int bookId = 789; // int | 

try {
    final response = api.getBookChapters(bookId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getBookChapters: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 

### Return type

[**BaseResponseListChapterDTO**](BaseResponseListChapterDTO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getBookmarksByBook**
> BaseResponseListReadingBookmarkDTO getBookmarksByBook(bookId, userId)

获取用户在该书的书签列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int bookId = 789; // int | 
final int userId = 789; // int | 

try {
    final response = api.getBookmarksByBook(bookId, userId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getBookmarksByBook: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **userId** | **int**|  | 

### Return type

[**BaseResponseListReadingBookmarkDTO**](BaseResponseListReadingBookmarkDTO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getById**
> BaseResponseWorkflowResponse getById(id)

获取工作流详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID

try {
    final response = api.getById(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 

### Return type

[**BaseResponseWorkflowResponse**](BaseResponseWorkflowResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getChapter**
> BaseResponseChapterResponse getChapter(courseId, chapterId)

获取章节详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID
final int chapterId = 789; // int | 章节ID

try {
    final response = api.getChapter(courseId, chapterId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getChapter: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 
 **chapterId** | **int**| 章节ID | 

### Return type

[**BaseResponseChapterResponse**](BaseResponseChapterResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getChapterContent**
> BaseResponseChapterContentDTO getChapterContent(bookId, chapterIndex)

获取章节内容

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int bookId = 789; // int | 
final int chapterIndex = 56; // int | 

try {
    final response = api.getChapterContent(bookId, chapterIndex);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getChapterContent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **chapterIndex** | **int**|  | 

### Return type

[**BaseResponseChapterContentDTO**](BaseResponseChapterContentDTO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getChatHistory**
> BaseResponseChatMessagePageResponse getChatHistory(chatHistoryRequestDTO)

获取聊天历史

获取与指定用户的聊天历史记录

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final ChatHistoryRequestDTO chatHistoryRequestDTO = ; // ChatHistoryRequestDTO | 

try {
    final response = api.getChatHistory(chatHistoryRequestDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getChatHistory: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **chatHistoryRequestDTO** | [**ChatHistoryRequestDTO**](ChatHistoryRequestDTO.md)|  | 

### Return type

[**BaseResponseChatMessagePageResponse**](BaseResponseChatMessagePageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getChatHistory1**
> BaseResponseMapStringObject getChatHistory1(id, page, size)

直播间聊天历史

分页获取直播间聊天消息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.getChatHistory1(id, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getChatHistory1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 50]

### Return type

[**BaseResponseMapStringObject**](BaseResponseMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCheckinRanking**
> BaseResponseListCheckinRankingItem getCheckinRanking(limit)

打卡排行榜

获取打卡排行榜前10名，公开接口

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int limit = 56; // int | 

try {
    final response = api.getCheckinRanking(limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getCheckinRanking: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponseListCheckinRankingItem**](BaseResponseListCheckinRankingItem.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCheckinStatus**
> BaseResponseCheckinStatusResult getCheckinStatus()

获取打卡状态

获取当前用户的打卡状态

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getCheckinStatus();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getCheckinStatus: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseCheckinStatusResult**](BaseResponseCheckinStatusResult.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getClassAiReport**
> SseEmitter getClassAiReport(classId, startDate, endDate)

AI班级学情分析报告（SSE流式）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int classId = 789; // int | 
final Date startDate = 2013-10-20; // Date | 
final Date endDate = 2013-10-20; // Date | 

try {
    final response = api.getClassAiReport(classId, startDate, endDate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getClassAiReport: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **classId** | **int**|  | 
 **startDate** | **Date**|  | [optional] 
 **endDate** | **Date**|  | [optional] 

### Return type

[**SseEmitter**](SseEmitter.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/event-stream

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getClassInfo**
> BaseResponseClassResponse getClassInfo(classId)

获取班级详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int classId = 789; // int | 

try {
    final response = api.getClassInfo(classId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getClassInfo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **classId** | **int**|  | 

### Return type

[**BaseResponseClassResponse**](BaseResponseClassResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getClassMembers**
> BaseResponsePageResponseClassMemberResponse getClassMembers(classId, pageNum, pageSize)

获取班级成员列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int classId = 789; // int | 
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.getClassMembers(classId, pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getClassMembers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **classId** | **int**|  | 
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponsePageResponseClassMemberResponse**](BaseResponsePageResponseClassMemberResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getClassOverview**
> BaseResponseClassAnalyticsResponse getClassOverview(classId, startDate, endDate)

班级学情概览

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int classId = 789; // int | 
final Date startDate = 2013-10-20; // Date | 
final Date endDate = 2013-10-20; // Date | 

try {
    final response = api.getClassOverview(classId, startDate, endDate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getClassOverview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **classId** | **int**|  | 
 **startDate** | **Date**|  | [optional] 
 **endDate** | **Date**|  | [optional] 

### Return type

[**BaseResponseClassAnalyticsResponse**](BaseResponseClassAnalyticsResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getClassRanking**
> BaseResponseListStudentRankingItem getClassRanking(classId, startDate, endDate)

班级成员排名

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int classId = 789; // int | 
final Date startDate = 2013-10-20; // Date | 
final Date endDate = 2013-10-20; // Date | 

try {
    final response = api.getClassRanking(classId, startDate, endDate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getClassRanking: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **classId** | **int**|  | 
 **startDate** | **Date**|  | [optional] 
 **endDate** | **Date**|  | [optional] 

### Return type

[**BaseResponseListStudentRankingItem**](BaseResponseListStudentRankingItem.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getClassSubjects**
> BaseResponseListSubjectAnalyticsItem getClassSubjects(classId)

班级各学科分析

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int classId = 789; // int | 

try {
    final response = api.getClassSubjects(classId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getClassSubjects: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **classId** | **int**|  | 

### Return type

[**BaseResponseListSubjectAnalyticsItem**](BaseResponseListSubjectAnalyticsItem.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getClassTrend**
> BaseResponseLearningTrendResponse getClassTrend(classId, granularity, startDate, endDate)

班级学习趋势

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int classId = 789; // int | 
final String granularity = granularity_example; // String | 
final Date startDate = 2013-10-20; // Date | 
final Date endDate = 2013-10-20; // Date | 

try {
    final response = api.getClassTrend(classId, granularity, startDate, endDate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getClassTrend: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **classId** | **int**|  | 
 **granularity** | **String**|  | [optional] [default to 'day']
 **startDate** | **Date**|  | [optional] 
 **endDate** | **Date**|  | [optional] 

### Return type

[**BaseResponseLearningTrendResponse**](BaseResponseLearningTrendResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCollectedArticles**
> BaseResponseListUserDailyArticleResponse getCollectedArticles(page, size)

获取收藏文章列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.getCollectedArticles(page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getCollectedArticles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseListUserDailyArticleResponse**](BaseResponseListUserDailyArticleResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCollectedWords**
> BaseResponseListUserDailyWordResponse getCollectedWords(page, size)

获取收藏单词列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.getCollectedWords(page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getCollectedWords: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseListUserDailyWordResponse**](BaseResponseListUserDailyWordResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCommentReplies**
> BaseResponseReplyPageResponse getCommentReplies(commentId, pageNum, pageSize)

获取评论回复列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int commentId = 789; // int | 
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.getCommentReplies(commentId, pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getCommentReplies: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **commentId** | **int**|  | 
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponseReplyPageResponse**](BaseResponseReplyPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getConfig**
> BaseResponseScraperConfigResponse getConfig(id)

获取配置详情

获取指定抓取配置的详细信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.getConfig(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getConfig: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseScraperConfigResponse**](BaseResponseScraperConfigResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getConfigsByPage**
> BaseResponseScraperConfigPageResponse getConfigsByPage(page, size)

分页获取配置

分页获取抓取源配置列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.getConfigsByPage(page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getConfigsByPage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponseScraperConfigPageResponse**](BaseResponseScraperConfigPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCourse**
> BaseResponseCourseResponse getCourse(id)

获取课程详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 课程ID

try {
    final response = api.getCourse(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getCourse: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 课程ID | 

### Return type

[**BaseResponseCourseResponse**](BaseResponseCourseResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCourseProgress**
> BaseResponseListProgressResponse getCourseProgress(courseId)

获取课程所有小节的学习进度

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID

try {
    final response = api.getCourseProgress(courseId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getCourseProgress: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 

### Return type

[**BaseResponseListProgressResponse**](BaseResponseListProgressResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCourseProgressSummary**
> BaseResponseCourseProgressSummaryResponse getCourseProgressSummary(courseId)

获取课程进度汇总

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID

try {
    final response = api.getCourseProgressSummary(courseId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getCourseProgressSummary: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 

### Return type

[**BaseResponseCourseProgressSummaryResponse**](BaseResponseCourseProgressSummaryResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCourseStructure**
> BaseResponseCourseStructureResponse getCourseStructure(courseId)

获取课程完整结构（课程+章节+小节）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID

try {
    final response = api.getCourseStructure(courseId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getCourseStructure: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 

### Return type

[**BaseResponseCourseStructureResponse**](BaseResponseCourseStructureResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCurrentMembership**
> BaseResponseUserMembershipDetailResponse getCurrentMembership()

查询我的当前会员详细信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getCurrentMembership();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getCurrentMembership: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseUserMembershipDetailResponse**](BaseResponseUserMembershipDetailResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDailyArticle**
> BaseResponseDailyArticleResponse getDailyArticle(id)

获取文章详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 文章ID

try {
    final response = api.getDailyArticle(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getDailyArticle: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 文章ID | 

### Return type

[**BaseResponseDailyArticleResponse**](BaseResponseDailyArticleResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDailyWord**
> BaseResponseDailyWordResponse getDailyWord(id)

获取单词详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 单词ID

try {
    final response = api.getDailyWord(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getDailyWord: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 单词ID | 

### Return type

[**BaseResponseDailyWordResponse**](BaseResponseDailyWordResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDefinition**
> BaseResponseWorkflowDefinitionResponse getDefinition(id)

获取工作流定义详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID

try {
    final response = api.getDefinition(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getDefinition: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 

### Return type

[**BaseResponseWorkflowDefinitionResponse**](BaseResponseWorkflowDefinitionResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getEdges**
> BaseResponseListWorkflowEdgeResponse getEdges(id)

获取工作流所有连接线

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID

try {
    final response = api.getEdges(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getEdges: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 

### Return type

[**BaseResponseListWorkflowEdgeResponse**](BaseResponseListWorkflowEdgeResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getExamPaper**
> BaseResponseExamPaperResponse getExamPaper(id)

获取试卷详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.getExamPaper(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getExamPaper: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseExamPaperResponse**](BaseResponseExamPaperResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getExecutionLogs**
> BaseResponseListExecutionLogResponse getExecutionLogs(executionId, level)

获取执行日志

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String executionId = executionId_example; // String | 执行ID
final String level = level_example; // String | 日志级别过滤（可选）：DEBUG/INFO/WARN/ERROR

try {
    final response = api.getExecutionLogs(executionId, level);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getExecutionLogs: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **executionId** | **String**| 执行ID | 
 **level** | **String**| 日志级别过滤（可选）：DEBUG/INFO/WARN/ERROR | [optional] 

### Return type

[**BaseResponseListExecutionLogResponse**](BaseResponseListExecutionLogResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getExecutionStatistics**
> BaseResponseExecutionStatisticsResponse getExecutionStatistics(id)

获取工作流执行统计

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID

try {
    final response = api.getExecutionStatistics(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getExecutionStatistics: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 

### Return type

[**BaseResponseExecutionStatisticsResponse**](BaseResponseExecutionStatisticsResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getExecutionStatus**
> BaseResponseExecutionResultResponse getExecutionStatus(executionId)

获取执行状态

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String executionId = executionId_example; // String | 执行ID

try {
    final response = api.getExecutionStatus(executionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getExecutionStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **executionId** | **String**| 执行ID | 

### Return type

[**BaseResponseExecutionResultResponse**](BaseResponseExecutionResultResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFavouriteCount**
> BaseResponseLong getFavouriteCount(courseId)

获取课程收藏数

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID

try {
    final response = api.getFavouriteCount(courseId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getFavouriteCount: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFeedbackDetail**
> BaseResponseFeedbackDetailResponse getFeedbackDetail(id)

获取反馈详情

获取指定反馈的详细信息及回复列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.getFeedbackDetail(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getFeedbackDetail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseFeedbackDetailResponse**](BaseResponseFeedbackDetailResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFeedbackDetail1**
> BaseResponseFeedbackDetailResponse getFeedbackDetail1(id)

获取反馈详情

管理员获取反馈详细信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.getFeedbackDetail1(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getFeedbackDetail1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseFeedbackDetailResponse**](BaseResponseFeedbackDetailResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFeedbackReplies**
> BaseResponseListFeedbackReplyResponse getFeedbackReplies(id)

获取反馈回复列表

获取指定反馈的所有回复

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.getFeedbackReplies(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getFeedbackReplies: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseListFeedbackReplyResponse**](BaseResponseListFeedbackReplyResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFeedbackReplies1**
> BaseResponseListFeedbackReplyResponse getFeedbackReplies1(id)

获取反馈回复列表

管理员获取反馈的所有回复

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.getFeedbackReplies1(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getFeedbackReplies1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseListFeedbackReplyResponse**](BaseResponseListFeedbackReplyResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFilesByBusinessType**
> BaseResponseListFileInfoResponse getFilesByBusinessType(businessType, page, size)

按业务类型获取文件列表（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String businessType = businessType_example; // String | 业务类型
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.getFilesByBusinessType(businessType, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getFilesByBusinessType: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **businessType** | **String**| 业务类型 | 
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseListFileInfoResponse**](BaseResponseListFileInfoResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFollowingPosts**
> BaseResponsePostPageResponse getFollowingPosts(pageNum, pageSize)

获取关注用户的帖子列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.getFollowingPosts(pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getFollowingPosts: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponsePostPageResponse**](BaseResponsePostPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFriendList**
> BaseResponseFriendPageResponse getFriendList(friendListRequestDTO)

获取好友列表

获取当前用户的好友列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final FriendListRequestDTO friendListRequestDTO = ; // FriendListRequestDTO | 

try {
    final response = api.getFriendList(friendListRequestDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getFriendList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **friendListRequestDTO** | [**FriendListRequestDTO**](FriendListRequestDTO.md)|  | 

### Return type

[**BaseResponseFriendPageResponse**](BaseResponseFriendPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getGroupInfo**
> BaseResponseGroupResponse getGroupInfo(groupId)

获取群详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 

try {
    final response = api.getGroupInfo(groupId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getGroupInfo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 

### Return type

[**BaseResponseGroupResponse**](BaseResponseGroupResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getGroupInfo1**
> BaseResponseGroupResponse getGroupInfo1(groupId)

获取群详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 群ID

try {
    final response = api.getGroupInfo1(groupId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getGroupInfo1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**| 群ID | 

### Return type

[**BaseResponseGroupResponse**](BaseResponseGroupResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getGroupMembers**
> BaseResponseListGroupMemberResponse getGroupMembers(groupId)

获取群成员列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 

try {
    final response = api.getGroupMembers(groupId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getGroupMembers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 

### Return type

[**BaseResponseListGroupMemberResponse**](BaseResponseListGroupMemberResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getGroupMembers1**
> BaseResponseMemberPage getGroupMembers1(groupId, pageNum, pageSize)

分页获取群成员

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 群ID
final int pageNum = 56; // int | 页码
final int pageSize = 56; // int | 每页数量

try {
    final response = api.getGroupMembers1(groupId, pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getGroupMembers1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**| 群ID | 
 **pageNum** | **int**| 页码 | [optional] [default to 1]
 **pageSize** | **int**| 每页数量 | [optional] [default to 20]

### Return type

[**BaseResponseMemberPage**](BaseResponseMemberPage.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getGroupMembersPage**
> BaseResponseMemberPage getGroupMembersPage(groupId, pageNum, pageSize)

分页获取群成员

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.getGroupMembersPage(groupId, pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getGroupMembersPage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponseMemberPage**](BaseResponseMemberPage.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getHistory**
> BaseResponseListSubmissionStatusResponse getHistory(page, size)

查询批改历史

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.getHistory(page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getHistory: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponseListSubmissionStatusResponse**](BaseResponseListSubmissionStatusResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getHlsStream**
> getHlsStream(sectionId)

获取HLS播放流（带Token）

获取带Token验证的HLS m3u8播放内容。 流程： 1. 后端生成一次性播放token 2. 下载原始m3u8，修改#EXT-X-KEY的URI，附加token参数 3. 返回修改后的m3u8内容，播放器可直接播放 播放器只需将此URL作为视频源即可播放加密视频。 

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int sectionId = 789; // int | 小节ID

try {
    api.getHlsStream(sectionId);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getHlsStream: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sectionId** | **int**| 小节ID | 

### Return type

void (empty response body)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getKey**
> getKey(keyId, token)

获取视频解密密钥（HLS播放器自动调用）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String keyId = keyId_example; // String | 密钥ID
final String token = token_example; // String | 一次性播放令牌（可选）

try {
    api.getKey(keyId, token);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getKey: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **keyId** | **String**| 密钥ID | 
 **token** | **String**| 一次性播放令牌（可选） | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getLatestMessages**
> BaseResponseListGroupMessageItem getLatestMessages(groupId, limit)

获取群最新消息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 
final int limit = 56; // int | 

try {
    final response = api.getLatestMessages(groupId, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getLatestMessages: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 
 **limit** | **int**|  | [optional] [default to 50]

### Return type

[**BaseResponseListGroupMessageItem**](BaseResponseListGroupMessageItem.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getLikedArticles**
> BaseResponseListUserDailyArticleResponse getLikedArticles(page, size)

获取点赞文章列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.getLikedArticles(page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getLikedArticles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseListUserDailyArticleResponse**](BaseResponseListUserDailyArticleResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getLoginUser**
> BaseResponseLoginUserResponse getLoginUser()

获取当前用户

获取当前登录用户信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getLoginUser();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getLoginUser: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseLoginUserResponse**](BaseResponseLoginUserResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMembershipHistory**
> BaseResponseListUserMembership getMembershipHistory()

查询我的会员历史

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getMembershipHistory();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getMembershipHistory: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListUserMembership**](BaseResponseListUserMembership.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMessages**
> BaseResponseGroupMessagePageResponse getMessages(groupId, pageNum, pageSize)

获取群聊历史消息（分页）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.getMessages(groupId, pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getMessages: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 50]

### Return type

[**BaseResponseGroupMessagePageResponse**](BaseResponseGroupMessagePageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMessagesBefore**
> BaseResponseListGroupMessageItem getMessagesBefore(groupId, beforeMessageId, limit)

获取群聊历史消息（游标分页，获取某消息之前的消息）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 
final int beforeMessageId = 789; // int | 
final int limit = 56; // int | 

try {
    final response = api.getMessagesBefore(groupId, beforeMessageId, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getMessagesBefore: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 
 **beforeMessageId** | **int**|  | 
 **limit** | **int**|  | [optional] [default to 50]

### Return type

[**BaseResponseListGroupMessageItem**](BaseResponseListGroupMessageItem.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyApplication**
> BaseResponseTeacherApplicationResponse getMyApplication()

获取当前用户的申请

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getMyApplication();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getMyApplication: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseTeacherApplicationResponse**](BaseResponseTeacherApplicationResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyFavourites**
> BaseResponsePostPageResponse getMyFavourites(pageNum, pageSize)

获取我收藏的帖子

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.getMyFavourites(pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getMyFavourites: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponsePostPageResponse**](BaseResponsePostPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyFavourites1**
> BaseResponseListCourseResponse getMyFavourites1(page, size)

获取我的收藏列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.getMyFavourites1(page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getMyFavourites1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseListCourseResponse**](BaseResponseListCourseResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyFeedbacks**
> BaseResponseFeedbackPageResponse getMyFeedbacks(pageNum, pageSize)

获取我的反馈列表

分页获取当前用户的反馈列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.getMyFeedbacks(pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getMyFeedbacks: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponseFeedbackPageResponse**](BaseResponseFeedbackPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyFiles**
> BaseResponseListFileInfoResponse getMyFiles(page, size)

获取我的文件列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.getMyFiles(page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getMyFiles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseListFileInfoResponse**](BaseResponseListFileInfoResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyFollowStats**
> BaseResponseFollowStatsResponse getMyFollowStats()

获取我的关注统计

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getMyFollowStats();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getMyFollowStats: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseFollowStatsResponse**](BaseResponseFollowStatsResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyFollowers**
> BaseResponseFollowPageResponse getMyFollowers(pageNum, pageSize)

获取我的粉丝列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.getMyFollowers(pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getMyFollowers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponseFollowPageResponse**](BaseResponseFollowPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyFollowings**
> BaseResponseFollowPageResponse getMyFollowings(pageNum, pageSize)

获取我的关注列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.getMyFollowings(pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getMyFollowings: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponseFollowPageResponse**](BaseResponseFollowPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyGroups**
> BaseResponseListGroupResponse getMyGroups()

获取我加入的群列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getMyGroups();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getMyGroups: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListGroupResponse**](BaseResponseListGroupResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyOrders**
> BaseResponseListOrderResponse getMyOrders(page, size)

获取我的订单列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.getMyOrders(page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getMyOrders: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseListOrderResponse**](BaseResponseListOrderResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyPosts**
> BaseResponseListPostResponse getMyPosts()

获取我的帖子列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getMyPosts();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getMyPosts: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListPostResponse**](BaseResponseListPostResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyReview**
> BaseResponseCourseReviewResponse getMyReview(courseId)

获取我对该课程的评价

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID

try {
    final response = api.getMyReview(courseId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getMyReview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 

### Return type

[**BaseResponseCourseReviewResponse**](BaseResponseCourseReviewResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMySchedule**
> BaseResponseListClassScheduleItemResponse getMySchedule()

获取我的课表

获取当前登录用户的完整课表（包括班级课表、执教课表、个人日程）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getMySchedule();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getMySchedule: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListClassScheduleItemResponse**](BaseResponseListClassScheduleItemResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyTeacher**
> BaseResponseTeacherResponse getMyTeacher()

获取当前用户的讲师信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getMyTeacher();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getMyTeacher: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseTeacherResponse**](BaseResponseTeacherResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getNode**
> BaseResponseWorkflowNodeResponse getNode(id, nodeId)

获取单个节点详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final String nodeId = nodeId_example; // String | 节点ID

try {
    final response = api.getNode(id, nodeId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getNode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **nodeId** | **String**| 节点ID | 

### Return type

[**BaseResponseWorkflowNodeResponse**](BaseResponseWorkflowNodeResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getNodeTypes**
> BaseResponseListNodeTypeResponse getNodeTypes()

获取所有可用的节点类型

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getNodeTypes();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getNodeTypes: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListNodeTypeResponse**](BaseResponseListNodeTypeResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getNodes**
> BaseResponseListWorkflowNodeResponse getNodes(id)

获取工作流所有节点

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID

try {
    final response = api.getNodes(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getNodes: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 

### Return type

[**BaseResponseListWorkflowNodeResponse**](BaseResponseListWorkflowNodeResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getNotesByBook**
> BaseResponseListReadingNoteDTO getNotesByBook(bookId, userId)

获取用户在该书的笔记列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int bookId = 789; // int | 
final int userId = 789; // int | 

try {
    final response = api.getNotesByBook(bookId, userId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getNotesByBook: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **userId** | **int**|  | 

### Return type

[**BaseResponseListReadingNoteDTO**](BaseResponseListReadingNoteDTO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getNotesByChapter**
> BaseResponseListReadingNoteDTO getNotesByChapter(bookId, chapterId, userId)

获取用户在该章节的笔记

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int bookId = 789; // int | 
final int chapterId = 789; // int | 
final int userId = 789; // int | 

try {
    final response = api.getNotesByChapter(bookId, chapterId, userId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getNotesByChapter: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **chapterId** | **int**|  | 
 **userId** | **int**|  | 

### Return type

[**BaseResponseListReadingNoteDTO**](BaseResponseListReadingNoteDTO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getOrder**
> BaseResponseOrderResponse getOrder(orderNo)

查询订单详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String orderNo = orderNo_example; // String | 订单号

try {
    final response = api.getOrder(orderNo);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderNo** | **String**| 订单号 | 

### Return type

[**BaseResponseOrderResponse**](BaseResponseOrderResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPaperQuestions**
> BaseResponseListPaperQuestionResponse getPaperQuestions(paperId, sectionId)

获取大题下的所有题目关联

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int paperId = 789; // int | 
final int sectionId = 789; // int | 

try {
    final response = api.getPaperQuestions(paperId, sectionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getPaperQuestions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **paperId** | **int**|  | 
 **sectionId** | **int**|  | 

### Return type

[**BaseResponseListPaperQuestionResponse**](BaseResponseListPaperQuestionResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPdfUrl**
> BaseResponseString getPdfUrl(bookId)

获取PDF预签名URL

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int bookId = 789; // int | 

try {
    final response = api.getPdfUrl(bookId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getPdfUrl: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 

### Return type

[**BaseResponseString**](BaseResponseString.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPendingCount**
> BaseResponseLong getPendingCount()

获取待审核申请数量（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getPendingCount();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getPendingCount: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPendingRequests**
> BaseResponseListJoinRequestResponse getPendingRequests(groupId)

获取群待审批申请列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 

try {
    final response = api.getPendingRequests(groupId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getPendingRequests: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 

### Return type

[**BaseResponseListJoinRequestResponse**](BaseResponseListJoinRequestResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPlan**
> BaseResponseMembershipPlan getPlan(planId)

获取计划详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int planId = 789; // int | 

try {
    final response = api.getPlan(planId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getPlan: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **planId** | **int**|  | 

### Return type

[**BaseResponseMembershipPlan**](BaseResponseMembershipPlan.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPlayToken**
> BaseResponseString getPlayToken(sectionId, keyId)

获取视频播放令牌

获取一次性播放令牌，用于请求HLS解密密钥。令牌5分钟有效且只能使用一次。

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int sectionId = 789; // int | 小节ID
final String keyId = keyId_example; // String | 加密密钥ID

try {
    final response = api.getPlayToken(sectionId, keyId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getPlayToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sectionId** | **int**| 小节ID | 
 **keyId** | **String**| 加密密钥ID | 

### Return type

[**BaseResponseString**](BaseResponseString.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPostComments**
> BaseResponseCommentPageResponse getPostComments(postId, pageNum, pageSize)

获取帖子评论列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int postId = 789; // int | 
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.getPostComments(postId, pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getPostComments: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postId** | **int**|  | 
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponseCommentPageResponse**](BaseResponseCommentPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPostDetail**
> BaseResponsePostDetailResponse getPostDetail(postId)

获取帖子详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int postId = 789; // int | 

try {
    final response = api.getPostDetail(postId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getPostDetail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postId** | **int**|  | 

### Return type

[**BaseResponsePostDetailResponse**](BaseResponsePostDetailResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPostList**
> BaseResponsePostPageResponse getPostList(pageNum, pageSize)

分页获取帖子列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.getPostList(pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getPostList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponsePostPageResponse**](BaseResponsePostPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPostListByType**
> BaseResponsePostPageResponse getPostListByType(postType, pageNum, pageSize)

根据类型获取帖子列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String postType = postType_example; // String | 
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.getPostListByType(postType, pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getPostListByType: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postType** | **String**|  | 
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponsePostPageResponse**](BaseResponsePostPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPublishedPapers**
> BaseResponseMapStringObject getPublishedPapers(keyword, subject, grade, page, size)

查询已发布试卷列表（供批改选择）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String keyword = keyword_example; // String | 
final String subject = subject_example; // String | 
final String grade = grade_example; // String | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.getPublishedPapers(keyword, subject, grade, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getPublishedPapers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **keyword** | **String**|  | [optional] 
 **subject** | **String**|  | [optional] 
 **grade** | **String**|  | [optional] 
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponseMapStringObject**](BaseResponseMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getQuestion**
> BaseResponseQuestionResponse getQuestion(id)

获取题目详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.getQuestion(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getQuestion: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseQuestionResponse**](BaseResponseQuestionResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReadArticles**
> BaseResponseListUserDailyArticleResponse getReadArticles(page, size)

获取已阅读文章列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.getReadArticles(page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getReadArticles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseListUserDailyArticleResponse**](BaseResponseListUserDailyArticleResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReadCount**
> BaseResponseInteger getReadCount(messageId)

获取消息已读人数

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int messageId = 789; // int | 

try {
    final response = api.getReadCount(messageId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getReadCount: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **messageId** | **int**|  | 

### Return type

[**BaseResponseInteger**](BaseResponseInteger.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReadUsers**
> BaseResponseListMessageReadUserResponse getReadUsers(messageId)

获取消息已读用户列表（含昵称头像）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int messageId = 789; // int | 

try {
    final response = api.getReadUsers(messageId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getReadUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **messageId** | **int**|  | 

### Return type

[**BaseResponseListMessageReadUserResponse**](BaseResponseListMessageReadUserResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReceivedRequests**
> BaseResponseFriendRequestPageResponse getReceivedRequests(friendRequestListDTO)

获取收到的好友申请

获取当前用户收到的好友申请列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final FriendRequestListDTO friendRequestListDTO = ; // FriendRequestListDTO | 

try {
    final response = api.getReceivedRequests(friendRequestListDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getReceivedRequests: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **friendRequestListDTO** | [**FriendRequestListDTO**](FriendRequestListDTO.md)|  | 

### Return type

[**BaseResponseFriendRequestPageResponse**](BaseResponseFriendRequestPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getRecommendations**
> BaseResponseListMapStringObject getRecommendations(submissionId)

获取错题的同类题推荐

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int submissionId = 789; // int | 

try {
    final response = api.getRecommendations(submissionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getRecommendations: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **submissionId** | **int**|  | 

### Return type

[**BaseResponseListMapStringObject**](BaseResponseListMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getResult**
> BaseResponseGradingResultResponse getResult(submissionId)

获取批改结果

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int submissionId = 789; // int | 

try {
    final response = api.getResult(submissionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getResult: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **submissionId** | **int**|  | 

### Return type

[**BaseResponseGradingResultResponse**](BaseResponseGradingResultResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReviewCount**
> BaseResponseLong getReviewCount(courseId)

获取课程评价数

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID

try {
    final response = api.getReviewCount(courseId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getReviewCount: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getRoomDetail**
> BaseResponseLiveRoomResponse getRoomDetail(id)

直播间详情

获取直播间详情，含播放地址

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.getRoomDetail(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getRoomDetail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseLiveRoomResponse**](BaseResponseLiveRoomResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getScheduleBySetting**
> BaseResponseScheduleResponse getScheduleBySetting(settingId)

获取特定配置的课表

根据配置ID获取课表预览

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int settingId = 789; // int | 

try {
    final response = api.getScheduleBySetting(settingId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getScheduleBySetting: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **settingId** | **int**|  | 

### Return type

[**BaseResponseScheduleResponse**](BaseResponseScheduleResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSection**
> BaseResponseSectionResponse getSection(courseId, sectionId)

获取小节详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID
final int sectionId = 789; // int | 小节ID

try {
    final response = api.getSection(courseId, sectionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getSection: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 
 **sectionId** | **int**| 小节ID | 

### Return type

[**BaseResponseSectionResponse**](BaseResponseSectionResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSectionProgress**
> BaseResponseProgressResponse getSectionProgress(sectionId)

获取小节学习进度

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int sectionId = 789; // int | 小节ID

try {
    final response = api.getSectionProgress(sectionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getSectionProgress: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sectionId** | **int**| 小节ID | 

### Return type

[**BaseResponseProgressResponse**](BaseResponseProgressResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSections**
> BaseResponseListPaperSectionResponse getSections(paperId)

获取试卷的所有大题

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int paperId = 789; // int | 

try {
    final response = api.getSections(paperId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getSections: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **paperId** | **int**|  | 

### Return type

[**BaseResponseListPaperSectionResponse**](BaseResponseListPaperSectionResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSentRequests**
> BaseResponseFriendRequestPageResponse getSentRequests(friendRequestListDTO)

获取发送的好友申请

获取当前用户发送的好友申请列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final FriendRequestListDTO friendRequestListDTO = ; // FriendRequestListDTO | 

try {
    final response = api.getSentRequests(friendRequestListDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getSentRequests: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **friendRequestListDTO** | [**FriendRequestListDTO**](FriendRequestListDTO.md)|  | 

### Return type

[**BaseResponseFriendRequestPageResponse**](BaseResponseFriendRequestPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSessionList**
> BaseResponseListChatSessionResponse getSessionList()

获取会话列表

获取当前用户的所有私聊会话

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getSessionList();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getSessionList: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListChatSessionResponse**](BaseResponseListChatSessionResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStatistics**
> BaseResponseOrderStatistics getStatistics()

订单统计（管理员，包含课程+会员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getStatistics();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getStatistics: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseOrderStatistics**](BaseResponseOrderStatistics.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStatistics1**
> BaseResponseMapStringLong getStatistics1()

会员统计

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getStatistics1();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getStatistics1: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseMapStringLong**](BaseResponseMapStringLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStats**
> BaseResponseWordBookStats getStats()

获取生词本统计

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getStats();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getStats: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseWordBookStats**](BaseResponseWordBookStats.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStats1**
> BaseResponseLearningStats getStats1()

获取学习统计

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getStats1();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getStats1: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseLearningStats**](BaseResponseLearningStats.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStats2**
> BaseResponseReadingStats getStats2()

获取阅读统计

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getStats2();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getStats2: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseReadingStats**](BaseResponseReadingStats.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStats3**
> BaseResponseGradingStatsResponse getStats3()

查询批改历史统计

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getStats3();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getStats3: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseGradingStatsResponse**](BaseResponseGradingStatsResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStatus**
> BaseResponseSubmissionStatusResponse getStatus(submissionId)

查询批改状态

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int submissionId = 789; // int | 

try {
    final response = api.getStatus(submissionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **submissionId** | **int**|  | 

### Return type

[**BaseResponseSubmissionStatusResponse**](BaseResponseSubmissionStatusResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStudentAiReport**
> SseEmitter getStudentAiReport(startDate, endDate)

AI个人学情分析报告（SSE流式）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final Date startDate = 2013-10-20; // Date | 
final Date endDate = 2013-10-20; // Date | 

try {
    final response = api.getStudentAiReport(startDate, endDate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getStudentAiReport: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **startDate** | **Date**|  | [optional] 
 **endDate** | **Date**|  | [optional] 

### Return type

[**SseEmitter**](SseEmitter.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/event-stream

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStudentOverview**
> BaseResponseStudentAnalyticsResponse getStudentOverview(startDate, endDate)

个人学情概览

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final Date startDate = 2013-10-20; // Date | 
final Date endDate = 2013-10-20; // Date | 

try {
    final response = api.getStudentOverview(startDate, endDate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getStudentOverview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **startDate** | **Date**|  | [optional] 
 **endDate** | **Date**|  | [optional] 

### Return type

[**BaseResponseStudentAnalyticsResponse**](BaseResponseStudentAnalyticsResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStudentSubjects**
> BaseResponseListSubjectAnalyticsItem getStudentSubjects()

个人各学科学情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getStudentSubjects();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getStudentSubjects: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListSubjectAnalyticsItem**](BaseResponseListSubjectAnalyticsItem.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStudentTrend**
> BaseResponseLearningTrendResponse getStudentTrend(granularity, startDate, endDate)

个人学习趋势

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String granularity = granularity_example; // String | 
final Date startDate = 2013-10-20; // Date | 
final Date endDate = 2013-10-20; // Date | 

try {
    final response = api.getStudentTrend(granularity, startDate, endDate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getStudentTrend: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **granularity** | **String**|  | [optional] [default to 'day']
 **startDate** | **Date**|  | [optional] 
 **endDate** | **Date**|  | [optional] 

### Return type

[**BaseResponseLearningTrendResponse**](BaseResponseLearningTrendResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStudiedWords**
> BaseResponseListUserDailyWordResponse getStudiedWords(page, size)

获取已学习单词列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.getStudiedWords(page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getStudiedWords: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseListUserDailyWordResponse**](BaseResponseListUserDailyWordResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSubjectProfile**
> BaseResponseSubjectProfileSummary getSubjectProfile(subjectCode)

查询某学科知识画像详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String subjectCode = subjectCode_example; // String | 

try {
    final response = api.getSubjectProfile(subjectCode);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getSubjectProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **subjectCode** | **String**|  | 

### Return type

[**BaseResponseSubjectProfileSummary**](BaseResponseSubjectProfileSummary.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSupportedSources**
> BaseResponseListArticleSourceResponse getSupportedSources()

获取预设来源列表

获取所有支持的预设新闻来源

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getSupportedSources();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getSupportedSources: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListArticleSourceResponse**](BaseResponseListArticleSourceResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSupportedVoices**
> BaseResponseString getSupportedVoices()

获取支持的发音人列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getSupportedVoices();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getSupportedVoices: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseString**](BaseResponseString.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTableColumns**
> BaseResponseListMapStringObject getTableColumns(tableName)

获取指定表的字段信息

返回白名单内指定表的字段名、类型等元数据

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String tableName = tableName_example; // String | 表名

try {
    final response = api.getTableColumns(tableName);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getTableColumns: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **tableName** | **String**| 表名 | 

### Return type

[**BaseResponseListMapStringObject**](BaseResponseListMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTask**
> BaseResponseScraperTaskResponse getTask(taskId)

获取任务详情

获取指定抓取任务的详细信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int taskId = 789; // int | 

try {
    final response = api.getTask(taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getTask: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **int**|  | 

### Return type

[**BaseResponseScraperTaskResponse**](BaseResponseScraperTaskResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTasksByConfig**
> BaseResponseScraperTaskPageResponse getTasksByConfig(configId, page, size)

获取配置的任务列表

获取指定配置的任务执行历史

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int configId = 789; // int | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.getTasksByConfig(configId, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getTasksByConfig: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **configId** | **int**|  | 
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponseScraperTaskPageResponse**](BaseResponseScraperTaskPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTeacher**
> BaseResponseTeacherResponse getTeacher(id)

获取讲师信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 讲师ID

try {
    final response = api.getTeacher(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getTeacher: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 讲师ID | 

### Return type

[**BaseResponseTeacherResponse**](BaseResponseTeacherResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTeacherByUserId**
> BaseResponseTeacherResponse getTeacherByUserId(userId)

根据用户ID获取讲师信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int userId = 789; // int | 用户ID

try {
    final response = api.getTeacherByUserId(userId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getTeacherByUserId: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**| 用户ID | 

### Return type

[**BaseResponseTeacherResponse**](BaseResponseTeacherResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTemplate**
> BaseResponseWorkflowTemplateResponse getTemplate(templateId)

获取模板详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int templateId = 789; // int | 模板ID

try {
    final response = api.getTemplate(templateId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getTemplate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **templateId** | **int**| 模板ID | 

### Return type

[**BaseResponseWorkflowTemplateResponse**](BaseResponseWorkflowTemplateResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTemplate1**
> BaseResponseExamTemplateResponse getTemplate1(id)

获取模板详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 模板ID

try {
    final response = api.getTemplate1(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getTemplate1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 模板ID | 

### Return type

[**BaseResponseExamTemplateResponse**](BaseResponseExamTemplateResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTodayArticles**
> BaseResponseListDailyArticleResponse getTodayArticles(size)

获取今日推荐文章（个性化推荐）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int size = 56; // int | 推荐数量

try {
    final response = api.getTodayArticles(size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getTodayArticles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **size** | **int**| 推荐数量 | [optional] [default to 10]

### Return type

[**BaseResponseListDailyArticleResponse**](BaseResponseListDailyArticleResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTodayWords**
> BaseResponseListDailyWordResponse getTodayWords(size, type)

获取今日推荐单词（个性化推荐）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int size = 56; // int | 推荐数量，最大100
final String type = type_example; // String | 单词分类：小学三年级、小学四年级、小学五年级、小学六年级、初中七年级、初中八年级、初中九年级、初中、初中(乱序)、外研社初中、高中、高中(乱序)、北师高中、四级、四级(乱序)、专四、专四(乱序)、六级、六级(乱序)、考研、考研(乱序)、专八、专八(乱序)、托福、雅思、雅思(乱序)、GRE、GMAT、GMAT(乱序)、SAT、BEC商务英语

try {
    final response = api.getTodayWords(size, type);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getTodayWords: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **size** | **int**| 推荐数量，最大100 | [optional] [default to 10]
 **type** | **String**| 单词分类：小学三年级、小学四年级、小学五年级、小学六年级、初中七年级、初中八年级、初中九年级、初中、初中(乱序)、外研社初中、高中、高中(乱序)、北师高中、四级、四级(乱序)、专四、专四(乱序)、六级、六级(乱序)、考研、考研(乱序)、专八、专八(乱序)、托福、雅思、雅思(乱序)、GRE、GMAT、GMAT(乱序)、SAT、BEC商务英语 | [optional] 

### Return type

[**BaseResponseListDailyWordResponse**](BaseResponseListDailyWordResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTopPosts**
> BaseResponsePostPageResponse getTopPosts(pageNum, pageSize)

获取点赞排行榜（全部时间）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.getTopPosts(pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getTopPosts: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponsePostPageResponse**](BaseResponsePostPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTopPostsByDays**
> BaseResponsePostPageResponse getTopPostsByDays(days, pageNum, pageSize)

获取点赞排行榜（指定天数内）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int days = 56; // int | 
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.getTopPostsByDays(days, pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getTopPostsByDays: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **days** | **int**|  | [optional] 
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponsePostPageResponse**](BaseResponsePostPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUnreadCount**
> BaseResponseInteger getUnreadCount(groupId)

获取群未读消息数

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 

try {
    final response = api.getUnreadCount(groupId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getUnreadCount: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 

### Return type

[**BaseResponseInteger**](BaseResponseInteger.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUnreadCount1**
> BaseResponseInteger getUnreadCount1()

获取未读消息数

获取当前用户的未读消息总数

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getUnreadCount1();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getUnreadCount1: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseInteger**](BaseResponseInteger.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUnreadCount2**
> BaseResponseLong getUnreadCount2()

获取未读公告数量

获取当前用户未读公告的数量

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getUnreadCount2();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getUnreadCount2: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserAiQuota**
> BaseResponseMapStringMapStringInteger getUserAiQuota(userId)

查询指定用户的AI额度

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int userId = 789; // int | 

try {
    final response = api.getUserAiQuota(userId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getUserAiQuota: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**|  | 

### Return type

[**BaseResponseMapStringMapStringInteger**](BaseResponseMapStringMapStringInteger.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserDetail**
> BaseResponseUserDetailResponse getUserDetail(id)

获取用户详情

管理员获取用户详细信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.getUserDetail(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getUserDetail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseUserDetailResponse**](BaseResponseUserDetailResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserDetailInfo**
> BaseResponseUserDetailResponse getUserDetailInfo(id)

获取用户详细信息

获取用户的详细信息，只有管理员和本人可以访问

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.getUserDetailInfo(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getUserDetailInfo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseUserDetailResponse**](BaseResponseUserDetailResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserFollowStats**
> BaseResponseFollowStatsResponse getUserFollowStats(targetUserId)

获取指定用户的关注统计

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int targetUserId = 789; // int | 

try {
    final response = api.getUserFollowStats(targetUserId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getUserFollowStats: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **targetUserId** | **int**|  | 

### Return type

[**BaseResponseFollowStatsResponse**](BaseResponseFollowStatsResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserFollowers**
> BaseResponseFollowPageResponse getUserFollowers(targetUserId, pageNum, pageSize)

获取指定用户的粉丝列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int targetUserId = 789; // int | 
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.getUserFollowers(targetUserId, pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getUserFollowers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **targetUserId** | **int**|  | 
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponseFollowPageResponse**](BaseResponseFollowPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserFollowings**
> BaseResponseFollowPageResponse getUserFollowings(targetUserId, pageNum, pageSize)

获取指定用户的关注列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int targetUserId = 789; // int | 
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.getUserFollowings(targetUserId, pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getUserFollowings: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **targetUserId** | **int**|  | 
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponseFollowPageResponse**](BaseResponseFollowPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserPosts**
> BaseResponseListPostResponse getUserPosts(targetUserId)

获取指定用户的帖子列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int targetUserId = 789; // int | 

try {
    final response = api.getUserPosts(targetUserId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getUserPosts: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **targetUserId** | **int**|  | 

### Return type

[**BaseResponseListPostResponse**](BaseResponseListPostResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserPublicInfo**
> BaseResponseUserPublicResponse getUserPublicInfo(id)

获取用户公开信息

获取其他用户的公开信息（非敏感）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.getUserPublicInfo(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getUserPublicInfo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseUserPublicResponse**](BaseResponseUserPublicResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserShelf**
> BaseResponseListUserShelfDTO getUserShelf(userId, page, size)

获取用户书架

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int userId = 789; // int | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.getUserShelf(userId, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getUserShelf: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**|  | 
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponseListUserShelfDTO**](BaseResponseListUserShelfDTO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserStats**
> BaseResponseUserStatsResult getUserStats()

获取用户统计数据

获取当前用户的注册天数、打卡天数、帖子获赞数等统计数据

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getUserStats();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getUserStats: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseUserStatsResult**](BaseResponseUserStatsResult.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getVariables**
> BaseResponseListWorkflowVariableResponse getVariables(id)

获取工作流所有变量

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID

try {
    final response = api.getVariables(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getVariables: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 

### Return type

[**BaseResponseListWorkflowVariableResponse**](BaseResponseListWorkflowVariableResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getVersion**
> BaseResponseWorkflowVersionResponse getVersion(id, versionNumber)

获取指定版本详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final int versionNumber = 56; // int | 版本号

try {
    final response = api.getVersion(id, versionNumber);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getVersion: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **versionNumber** | **int**| 版本号 | 

### Return type

[**BaseResponseWorkflowVersionResponse**](BaseResponseWorkflowVersionResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getWeakPoints**
> BaseResponseListKnowledgeProfileResponse getWeakPoints(subjectCode)

查询某学科薄弱知识点

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String subjectCode = subjectCode_example; // String | 

try {
    final response = api.getWeakPoints(subjectCode);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getWeakPoints: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **subjectCode** | **String**|  | 

### Return type

[**BaseResponseListKnowledgeProfileResponse**](BaseResponseListKnowledgeProfileResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getWordBookList**
> BaseResponseListUserWordBookResponse getWordBookList(status, page, size)

获取生词本列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int status = 56; // int | 学习状态：0-未学习，1-已学习，2-已掌握
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.getWordBookList(status, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getWordBookList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **int**| 学习状态：0-未学习，1-已学习，2-已掌握 | [optional] 
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseListUserWordBookResponse**](BaseResponseListUserWordBookResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getWordsByDate**
> BaseResponseListDailyWordResponse getWordsByDate(date)

获取指定日期单词

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final Date date = 2013-10-20; // Date | 日期

try {
    final response = api.getWordsByDate(date);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getWordsByDate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **date** | **Date**| 日期 | 

### Return type

[**BaseResponseListDailyWordResponse**](BaseResponseListDailyWordResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getWorkflowAssistants**
> BaseResponseListLong getWorkflowAssistants(id)

获取使用该工作流的AI助手ID列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID

try {
    final response = api.getWorkflowAssistants(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getWorkflowAssistants: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 

### Return type

[**BaseResponseListLong**](BaseResponseListLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **grantMembership**
> BaseResponseVoid grantMembership(grantMembershipRequest)

为用户直接开通会员

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final GrantMembershipRequest grantMembershipRequest = ; // GrantMembershipRequest | 

try {
    final response = api.grantMembership(grantMembershipRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->grantMembership: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **grantMembershipRequest** | [**GrantMembershipRequest**](GrantMembershipRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **handleFriendRequest**
> BaseResponseBoolean handleFriendRequest(handleFriendRequestDTO)

处理好友申请

接受或拒绝好友申请

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final HandleFriendRequestDTO handleFriendRequestDTO = ; // HandleFriendRequestDTO | 

try {
    final response = api.handleFriendRequest(handleFriendRequestDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->handleFriendRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **handleFriendRequestDTO** | [**HandleFriendRequestDTO**](HandleFriendRequestDTO.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **handleJoinRequest**
> BaseResponseVoid handleJoinRequest(requestId, handleJoinRequestDTO)

处理加入申请

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int requestId = 789; // int | 
final HandleJoinRequestDTO handleJoinRequestDTO = ; // HandleJoinRequestDTO | 

try {
    final response = api.handleJoinRequest(requestId, handleJoinRequestDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->handleJoinRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestId** | **int**|  | 
 **handleJoinRequestDTO** | [**HandleJoinRequestDTO**](HandleJoinRequestDTO.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **health**
> BaseResponseString health()

健康检查

检查服务是否正常运行

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.health();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->health: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseString**](BaseResponseString.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **inviteMember**
> BaseResponseVoid inviteMember(groupId, inviteeId)

邀请用户加入群

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 
final int inviteeId = 789; // int | 

try {
    final response = api.inviteMember(groupId, inviteeId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->inviteMember: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 
 **inviteeId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **isFollowing**
> BaseResponseBoolean isFollowing(targetUserId)

检查是否已关注

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int targetUserId = 789; // int | 

try {
    final response = api.isFollowing(targetUserId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->isFollowing: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **targetUserId** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbAddDocument**
> BaseResponseKnowledgeDocumentVO kbAddDocument(id, userId, requestBody)

添加文档

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final int userId = 789; // int | 
final BuiltMap<String, JsonObject> requestBody = Object; // BuiltMap<String, JsonObject> | 

try {
    final response = api.kbAddDocument(id, userId, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->kbAddDocument: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **userId** | **int**|  | 
 **requestBody** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)|  | 

### Return type

[**BaseResponseKnowledgeDocumentVO**](BaseResponseKnowledgeDocumentVO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbBatchProcessByKnowledgeBase**
> BaseResponseBatchProcessResult kbBatchProcessByKnowledgeBase(id)

向量化知识库所有待处理文档

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.kbBatchProcessByKnowledgeBase(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->kbBatchProcessByKnowledgeBase: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseBatchProcessResult**](BaseResponseBatchProcessResult.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbBatchProcessDocuments**
> BaseResponseBatchProcessResult kbBatchProcessDocuments(id, requestBody)

批量文档向量化

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final BuiltList<int> requestBody = ; // BuiltList<int> | 

try {
    final response = api.kbBatchProcessDocuments(id, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->kbBatchProcessDocuments: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **requestBody** | [**BuiltList&lt;int&gt;**](int.md)|  | 

### Return type

[**BaseResponseBatchProcessResult**](BaseResponseBatchProcessResult.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbBatchProcessDocumentsAsync**
> BaseResponseString kbBatchProcessDocumentsAsync(id, requestBody)

异步批量文档向量化

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final BuiltList<int> requestBody = ; // BuiltList<int> | 

try {
    final response = api.kbBatchProcessDocumentsAsync(id, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->kbBatchProcessDocumentsAsync: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **requestBody** | [**BuiltList&lt;int&gt;**](int.md)|  | 

### Return type

[**BaseResponseString**](BaseResponseString.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbCreate**
> BaseResponseKnowledgeBaseVO kbCreate(userId, createKnowledgeBaseCommand)

创建知识库

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int userId = 789; // int | 
final CreateKnowledgeBaseCommand createKnowledgeBaseCommand = ; // CreateKnowledgeBaseCommand | 

try {
    final response = api.kbCreate(userId, createKnowledgeBaseCommand);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->kbCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**|  | 
 **createKnowledgeBaseCommand** | [**CreateKnowledgeBaseCommand**](CreateKnowledgeBaseCommand.md)|  | 

### Return type

[**BaseResponseKnowledgeBaseVO**](BaseResponseKnowledgeBaseVO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbDelete**
> BaseResponseVoid kbDelete(id)

删除知识库

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.kbDelete(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->kbDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbDeleteDocument**
> BaseResponseVoid kbDeleteDocument(id, docId)

删除文档

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final int docId = 789; // int | 

try {
    final response = api.kbDeleteDocument(id, docId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->kbDeleteDocument: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **docId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbGetById**
> BaseResponseKnowledgeBaseVO kbGetById(id)

获取知识库详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.kbGetById(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->kbGetById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseKnowledgeBaseVO**](BaseResponseKnowledgeBaseVO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbListByCreator**
> BaseResponseListKnowledgeBaseVO kbListByCreator(userId, page, size)

获取用户的知识库列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int userId = 789; // int | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.kbListByCreator(userId, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->kbListByCreator: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**|  | 
 **page** | **int**|  | [optional] [default to 0]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponseListKnowledgeBaseVO**](BaseResponseListKnowledgeBaseVO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbListChunks**
> BaseResponseMapStringObject kbListChunks(id, docId, page, size)

获取文档分块列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final int docId = 789; // int | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.kbListChunks(id, docId, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->kbListChunks: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **docId** | **int**|  | 
 **page** | **int**|  | [optional] [default to 0]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponseMapStringObject**](BaseResponseMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbListDocuments**
> BaseResponseListKnowledgeDocumentVO kbListDocuments(id, page, size)

获取文档列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.kbListDocuments(id, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->kbListDocuments: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **page** | **int**|  | [optional] [default to 0]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponseListKnowledgeDocumentVO**](BaseResponseListKnowledgeDocumentVO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbProcessDocument**
> BaseResponseVoid kbProcessDocument(id, docId)

触发文档向量化

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final int docId = 789; // int | 

try {
    final response = api.kbProcessDocument(id, docId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->kbProcessDocument: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **docId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbRecallTest**
> BaseResponseMapStringObject kbRecallTest(id, requestBody)

知识库召回测试

输入查询文本，返回向量检索+Rerank后的召回结果，用于调试知识库检索效果

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final BuiltMap<String, JsonObject> requestBody = Object; // BuiltMap<String, JsonObject> | 

try {
    final response = api.kbRecallTest(id, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->kbRecallTest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **requestBody** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)|  | 

### Return type

[**BaseResponseMapStringObject**](BaseResponseMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbSearch**
> BaseResponseListKnowledgeBaseVO kbSearch(keyword, userId, page, size)

搜索知识库

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String keyword = keyword_example; // String | 
final int userId = 789; // int | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.kbSearch(keyword, userId, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->kbSearch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **keyword** | **String**|  | 
 **userId** | **int**|  | 
 **page** | **int**|  | [optional] [default to 0]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponseListKnowledgeBaseVO**](BaseResponseListKnowledgeBaseVO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbUpdate**
> BaseResponseKnowledgeBaseVO kbUpdate(id, updateKnowledgeBaseCommand)

更新知识库

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final UpdateKnowledgeBaseCommand updateKnowledgeBaseCommand = ; // UpdateKnowledgeBaseCommand | 

try {
    final response = api.kbUpdate(id, updateKnowledgeBaseCommand);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->kbUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **updateKnowledgeBaseCommand** | [**UpdateKnowledgeBaseCommand**](UpdateKnowledgeBaseCommand.md)|  | 

### Return type

[**BaseResponseKnowledgeBaseVO**](BaseResponseKnowledgeBaseVO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbUpdateDocument**
> BaseResponseKnowledgeDocumentVO kbUpdateDocument(id, docId, requestBody)

更新文档元信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final int docId = 789; // int | 
final BuiltMap<String, String> requestBody = ; // BuiltMap<String, String> | 

try {
    final response = api.kbUpdateDocument(id, docId, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->kbUpdateDocument: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **docId** | **int**|  | 
 **requestBody** | [**BuiltMap&lt;String, String&gt;**](String.md)|  | 

### Return type

[**BaseResponseKnowledgeDocumentVO**](BaseResponseKnowledgeDocumentVO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **leaveGroup**
> BaseResponseVoid leaveGroup(groupId)

退出群

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 

try {
    final response = api.leaveGroup(groupId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->leaveGroup: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAllTemplates**
> BaseResponseListExamTemplateResponse listAllTemplates()

列出所有模板（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.listAllTemplates();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listAllTemplates: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListExamTemplateResponse**](BaseResponseListExamTemplateResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAllowedTables**
> BaseResponseListMapStringObject listAllowedTables()

获取可查询的数据库表列表

返回工作流数据库查询节点允许访问的安全表名及字段信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.listAllowedTables();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listAllowedTables: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListMapStringObject**](BaseResponseListMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listApplications**
> BaseResponseListTeacherApplicationResponse listApplications(status, page, size)

获取申请列表（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int status = 56; // int | 状态：0-待审核，1-已通过，2-已拒绝
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.listApplications(status, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listApplications: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **int**| 状态：0-待审核，1-已通过，2-已拒绝 | [optional] 
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseListTeacherApplicationResponse**](BaseResponseListTeacherApplicationResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listArticles**
> BaseResponseDailyArticlePageResponse listArticles(category, difficulty, page, size)

获取文章列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String category = category_example; // String | 分类
final int difficulty = 56; // int | 难度等级
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.listArticles(category, difficulty, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listArticles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **category** | **String**| 分类 | [optional] 
 **difficulty** | **int**| 难度等级 | [optional] 
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseDailyArticlePageResponse**](BaseResponseDailyArticlePageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAvailableModels**
> BaseResponseListMapStringObject listAvailableModels()

获取可用模型列表

返回所有已启用的AI模型，供工作流LLM节点选择

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.listAvailableModels();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listAvailableModels: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListMapStringObject**](BaseResponseListMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listBooks**
> BaseResponseListBookDTO listBooks(page, size)

获取书籍列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.listBooks(page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listBooks: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponseListBookDTO**](BaseResponseListBookDTO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listByUser**
> BaseResponseListWorkflowResponse listByUser(userId, page, size)

获取用户的工作流列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int userId = 789; // int | 用户ID
final int page = 56; // int | 页码，从0开始
final int size = 56; // int | 每页数量

try {
    final response = api.listByUser(userId, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listByUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**| 用户ID | 
 **page** | **int**| 页码，从0开始 | [optional] [default to 0]
 **size** | **int**| 每页数量 | [optional] [default to 20]

### Return type

[**BaseResponseListWorkflowResponse**](BaseResponseListWorkflowResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listChapters**
> BaseResponseListChapterResponse listChapters(courseId)

获取课程的章节列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID

try {
    final response = api.listChapters(courseId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listChapters: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 

### Return type

[**BaseResponseListChapterResponse**](BaseResponseListChapterResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listClasses**
> BaseResponsePageResponseClassResponse listClasses(pageNum, pageSize, keyword)

获取班级列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 
final String keyword = keyword_example; // String | 

try {
    final response = api.listClasses(pageNum, pageSize, keyword);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listClasses: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 10]
 **keyword** | **String**|  | [optional] 

### Return type

[**BaseResponsePageResponseClassResponse**](BaseResponsePageResponseClassResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listCourses**
> BaseResponseListCourseResponse listCourses(status, page, size)

获取课程列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int status = 56; // int | 状态：0-未发布，1-已发布，2-已下架
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.listCourses(status, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listCourses: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **int**| 状态：0-未发布，1-已发布，2-已下架 | [optional] 
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseListCourseResponse**](BaseResponseListCourseResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listCoursesByTeacher**
> BaseResponseListCourseResponse listCoursesByTeacher(teacherId, page, size)

获取讲师的课程列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int teacherId = 789; // int | 讲师ID
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.listCoursesByTeacher(teacherId, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listCoursesByTeacher: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **teacherId** | **int**| 讲师ID | 
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseListCourseResponse**](BaseResponseListCourseResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listExecutions**
> BaseResponseListExecutionResultResponse listExecutions(id, page, size)

获取工作流执行历史列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final int page = 56; // int | 页码，从0开始
final int size = 56; // int | 每页数量

try {
    final response = api.listExecutions(id, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listExecutions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **page** | **int**| 页码，从0开始 | [optional] [default to 0]
 **size** | **int**| 每页数量 | [optional] [default to 20]

### Return type

[**BaseResponseListExecutionResultResponse**](BaseResponseListExecutionResultResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listGroups**
> BaseResponseAdminGroupPageResponse listGroups(pageNum, pageSize)

分页获取群列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int pageNum = 56; // int | 页码
final int pageSize = 56; // int | 每页数量

try {
    final response = api.listGroups(pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listGroups: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageNum** | **int**| 页码 | [optional] [default to 1]
 **pageSize** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseAdminGroupPageResponse**](BaseResponseAdminGroupPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMemberships**
> BaseResponseListUserMembership listMemberships(status, page, size)

按状态查询会员列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int status = 56; // int | 状态：0-待支付，1-生效中，2-已过期，3-已取消
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.listMemberships(status, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listMemberships: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **int**| 状态：0-待支付，1-生效中，2-已过期，3-已取消 | [optional] 
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponseListUserMembership**](BaseResponseListUserMembership.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listOrders**
> BaseResponseListOrderResponse listOrders(status, page, size)

获取订单列表（管理员，包含课程订单和会员订单）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int status = 56; // int | 订单状态：0-未支付，1-已支付，2-已过期，3-已退款/已取消
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.listOrders(status, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listOrders: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **int**| 订单状态：0-未支付，1-已支付，2-已过期，3-已退款/已取消 | [optional] 
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseListOrderResponse**](BaseResponseListOrderResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listPlans**
> BaseResponseListMembershipPlan listPlans()

获取所有会员计划

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.listPlans();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listPlans: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListMembershipPlan**](BaseResponseListMembershipPlan.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listPlans1**
> BaseResponseListMembershipPlan listPlans1()

获取所有会员计划

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.listPlans1();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listPlans1: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListMembershipPlan**](BaseResponseListMembershipPlan.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listPublic**
> BaseResponseListWorkflowResponse listPublic(page, size)

获取公开的工作流列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int page = 56; // int | 页码，从0开始
final int size = 56; // int | 每页数量

try {
    final response = api.listPublic(page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listPublic: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**| 页码，从0开始 | [optional] [default to 0]
 **size** | **int**| 每页数量 | [optional] [default to 20]

### Return type

[**BaseResponseListWorkflowResponse**](BaseResponseListWorkflowResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listReviews**
> BaseResponseListCourseReviewResponse listReviews(courseId, page, size)

获取课程评价列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.listReviews(courseId, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listReviews: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseListCourseReviewResponse**](BaseResponseListCourseReviewResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listRooms**
> BaseResponseMapStringObject listRooms(status, classId, page, size)

直播间列表

分页获取直播间列表，可按状态筛选

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String status = status_example; // String | 状态: CREATED/LIVE/ENDED
final int classId = 789; // int | 班级ID
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.listRooms(status, classId, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listRooms: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **String**| 状态: CREATED/LIVE/ENDED | [optional] 
 **classId** | **int**| 班级ID | [optional] 
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseMapStringObject**](BaseResponseMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listSections**
> BaseResponseListSectionResponse listSections(courseId)

获取课程的所有小节

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID

try {
    final response = api.listSections(courseId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listSections: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 

### Return type

[**BaseResponseListSectionResponse**](BaseResponseListSectionResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listSystemTemplates**
> BaseResponseListWorkflowTemplateResponse listSystemTemplates()

获取系统预置模板

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.listSystemTemplates();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listSystemTemplates: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListWorkflowTemplateResponse**](BaseResponseListWorkflowTemplateResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listTeachers**
> BaseResponseListTeacherResponse listTeachers(page, size, keyword)

获取讲师列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量
final String keyword = keyword_example; // String | 搜索关键词（讲师姓名）

try {
    final response = api.listTeachers(page, size, keyword);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listTeachers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]
 **keyword** | **String**| 搜索关键词（讲师姓名） | [optional] 

### Return type

[**BaseResponseListTeacherResponse**](BaseResponseListTeacherResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listTemplates1**
> BaseResponseListExamTemplateResponse listTemplates1()

列出所有可用模板

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.listTemplates1();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listTemplates1: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListExamTemplateResponse**](BaseResponseListExamTemplateResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listTriggers**
> BaseResponseListWorkflowTriggerResponse listTriggers(id)

获取工作流触发器列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID

try {
    final response = api.listTriggers(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listTriggers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 

### Return type

[**BaseResponseListWorkflowTriggerResponse**](BaseResponseListWorkflowTriggerResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listVersions**
> BaseResponseListWorkflowVersionResponse listVersions(id)

获取工作流版本列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID

try {
    final response = api.listVersions(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listVersions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 

### Return type

[**BaseResponseListWorkflowVersionResponse**](BaseResponseListWorkflowVersionResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listWords**
> BaseResponseDailyWordPageResponse listWords(category, difficulty, page, size)

获取单词列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String category = category_example; // String | 分类
final int difficulty = 56; // int | 难度等级
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.listWords(category, difficulty, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listWords: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **category** | **String**| 分类 | [optional] 
 **difficulty** | **int**| 难度等级 | [optional] 
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseDailyWordPageResponse**](BaseResponseDailyWordPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markAsRead**
> BaseResponseVoid markAsRead(articleId)

标记文章为已阅读

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int articleId = 789; // int | 文章ID

try {
    final response = api.markAsRead(articleId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->markAsRead: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **articleId** | **int**| 文章ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markAsRead1**
> BaseResponseVoid markAsRead1(groupId, messageId)

标记消息已读

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 
final int messageId = 789; // int | 

try {
    final response = api.markAsRead1(groupId, messageId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->markAsRead1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 
 **messageId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markAsRead2**
> BaseResponseBoolean markAsRead2(senderId)

标记消息已读

标记与指定用户的消息为已读

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int senderId = 789; // int | 

try {
    final response = api.markAsRead2(senderId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->markAsRead2: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **senderId** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markAsRead3**
> BaseResponseBoolean markAsRead3(id)

标记公告已读

将公告标记为已读

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.markAsRead3(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->markAsRead3: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markRepliesAsRead**
> BaseResponseBoolean markRepliesAsRead(id)

标记回复为已读

将反馈的所有回复标记为已读

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.markRepliesAsRead(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->markRepliesAsRead: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **myRooms**
> BaseResponseMapStringObject myRooms(page, size)

我的直播间

获取当前用户创建的直播间列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.myRooms(page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->myRooms: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponseMapStringObject**](BaseResponseMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **offlineAnnouncement**
> BaseResponseBoolean offlineAnnouncement(id)

下线公告

将公告状态改为已下线

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.offlineAnnouncement(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->offlineAnnouncement: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **offlineBanner**
> BaseResponseBoolean offlineBanner(id)

下线轮播图

将轮播图状态设置为已下线

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.offlineBanner(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->offlineBanner: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **phoneLogin**
> BaseResponseLoginUserResponse phoneLogin(phoneLoginRequest)

手机验证码登录

使用手机号和验证码登录，未注册用户自动注册

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final PhoneLoginRequest phoneLoginRequest = ; // PhoneLoginRequest | 

try {
    final response = api.phoneLogin(phoneLoginRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->phoneLogin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **phoneLoginRequest** | [**PhoneLoginRequest**](PhoneLoginRequest.md)|  | 

### Return type

[**BaseResponseLoginUserResponse**](BaseResponseLoginUserResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **previewPdf**
> String previewPdf(id)

预览试卷PDF

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.previewPdf(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->previewPdf: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

**String**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **previewTemplate**
> String previewTemplate(id)

预览模板效果（用示例数据编译PDF）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 模板ID

try {
    final response = api.previewTemplate(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->previewTemplate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 模板ID | 

### Return type

**String**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publish**
> BaseResponseWorkflowResponse publish(id)

发布工作流

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID

try {
    final response = api.publish(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->publish: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 

### Return type

[**BaseResponseWorkflowResponse**](BaseResponseWorkflowResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publishAnnouncement**
> BaseResponseVoid publishAnnouncement(groupId, body)

发布群公告

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 
final String body = body_example; // String | 

try {
    final response = api.publishAnnouncement(groupId, body);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->publishAnnouncement: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 
 **body** | **String**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publishAnnouncement1**
> BaseResponseBoolean publishAnnouncement1(id)

发布公告

将公告状态改为已发布

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.publishAnnouncement1(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->publishAnnouncement1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publishBanner**
> BaseResponseBoolean publishBanner(id)

发布轮播图

将轮播图状态设置为已发布

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.publishBanner(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->publishBanner: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publishCourse**
> BaseResponseVoid publishCourse(id)

发布课程（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 课程ID

try {
    final response = api.publishCourse(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->publishCourse: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 课程ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publishExamPaper**
> BaseResponseBoolean publishExamPaper(id)

发布试卷

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.publishExamPaper(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->publishExamPaper: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **purchaseMembership**
> BaseResponseString purchaseMembership(purchaseMembershipRequest)

购买会员（创建待支付订单）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final PurchaseMembershipRequest purchaseMembershipRequest = ; // PurchaseMembershipRequest | 

try {
    final response = api.purchaseMembership(purchaseMembershipRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->purchaseMembership: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **purchaseMembershipRequest** | [**PurchaseMembershipRequest**](PurchaseMembershipRequest.md)|  | 

### Return type

[**BaseResponseString**](BaseResponseString.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **queryAnnouncements**
> BaseResponseAnnouncementPageResponse queryAnnouncements(queryAnnouncementRequest)

分页查询公告

管理员分页查询公告列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final QueryAnnouncementRequest queryAnnouncementRequest = ; // QueryAnnouncementRequest | 

try {
    final response = api.queryAnnouncements(queryAnnouncementRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->queryAnnouncements: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **queryAnnouncementRequest** | [**QueryAnnouncementRequest**](QueryAnnouncementRequest.md)|  | 

### Return type

[**BaseResponseAnnouncementPageResponse**](BaseResponseAnnouncementPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **queryBanners**
> BaseResponseBannerPageResponse queryBanners(request)

分页查询轮播图

分页查询轮播图列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final QueryBannerRequest request = ; // QueryBannerRequest | 

try {
    final response = api.queryBanners(request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->queryBanners: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **request** | [**QueryBannerRequest**](.md)|  | 

### Return type

[**BaseResponseBannerPageResponse**](BaseResponseBannerPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **queryExamPapers**
> BaseResponseExamPaperPageResponse queryExamPapers(request)

分页查询我的试卷

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final QueryExamPaperRequest request = ; // QueryExamPaperRequest | 

try {
    final response = api.queryExamPapers(request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->queryExamPapers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **request** | [**QueryExamPaperRequest**](.md)|  | 

### Return type

[**BaseResponseExamPaperPageResponse**](BaseResponseExamPaperPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **queryFeedbacks**
> BaseResponseFeedbackPageResponse queryFeedbacks(queryFeedbackRequest)

分页查询反馈

管理员分页查询所有反馈

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final QueryFeedbackRequest queryFeedbackRequest = ; // QueryFeedbackRequest | 

try {
    final response = api.queryFeedbacks(queryFeedbackRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->queryFeedbacks: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **queryFeedbackRequest** | [**QueryFeedbackRequest**](QueryFeedbackRequest.md)|  | 

### Return type

[**BaseResponseFeedbackPageResponse**](BaseResponseFeedbackPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **queryMyQuestions**
> BaseResponseQuestionPageResponse queryMyQuestions(request)

查询我的题目

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final QueryQuestionRequest request = ; // QueryQuestionRequest | 

try {
    final response = api.queryMyQuestions(request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->queryMyQuestions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **request** | [**QueryQuestionRequest**](.md)|  | 

### Return type

[**BaseResponseQuestionPageResponse**](BaseResponseQuestionPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **queryQuestions**
> BaseResponseQuestionPageResponse queryQuestions(request)

分页查询题目

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final QueryQuestionRequest request = ; // QueryQuestionRequest | 

try {
    final response = api.queryQuestions(request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->queryQuestions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **request** | [**QueryQuestionRequest**](.md)|  | 

### Return type

[**BaseResponseQuestionPageResponse**](BaseResponseQuestionPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **queryUsers**
> BaseResponseUserPageResponse queryUsers(queryUserRequest)

分页查询用户

管理员分页查询用户，支持模糊搜索

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final QueryUserRequest queryUserRequest = ; // QueryUserRequest | 

try {
    final response = api.queryUsers(queryUserRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->queryUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **queryUserRequest** | [**QueryUserRequest**](QueryUserRequest.md)|  | 

### Return type

[**BaseResponseUserPageResponse**](BaseResponseUserPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **quickDynamicScrape**
> BaseResponseArticleResponse quickDynamicScrape(url, waitForJsMs)

快速动态抓取

通过GET方式快速动态抓取单个页面

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String url = url_example; // String | 
final int waitForJsMs = 56; // int | 

try {
    final response = api.quickDynamicScrape(url, waitForJsMs);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->quickDynamicScrape: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **url** | **String**|  | 
 **waitForJsMs** | **int**|  | [optional] [default to 3000]

### Return type

[**BaseResponseArticleResponse**](BaseResponseArticleResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **quickScrape**
> BaseResponseArticleResponse quickScrape(url)

快速抓取

通过GET方式快速抓取单个页面

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String url = url_example; // String | 

try {
    final response = api.quickScrape(url);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->quickScrape: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **url** | **String**|  | 

### Return type

[**BaseResponseArticleResponse**](BaseResponseArticleResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refreshToken**
> BaseResponseRefreshTokenResponse refreshToken(refreshTokenRequest)

刷新Token

使用Refresh Token获取新的Access Token和Refresh Token

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final RefreshTokenRequest refreshTokenRequest = ; // RefreshTokenRequest | 

try {
    final response = api.refreshToken(refreshTokenRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->refreshToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **refreshTokenRequest** | [**RefreshTokenRequest**](RefreshTokenRequest.md)|  | 

### Return type

[**BaseResponseRefreshTokenResponse**](BaseResponseRefreshTokenResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refund**
> BaseResponseVoid refund(orderNo)

退款（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String orderNo = orderNo_example; // String | 订单号

try {
    final response = api.refund(orderNo);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->refund: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderNo** | **String**| 订单号 | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reindex**
> BaseResponseMapStringInteger reindex(type)

全量重建索引（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String type = type_example; // String | 

try {
    final response = api.reindex(type);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->reindex: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **type** | **String**|  | [optional] [default to 'all']

### Return type

[**BaseResponseMapStringInteger**](BaseResponseMapStringInteger.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeCourse**
> BaseResponseVoid removeCourse(classId, courseId)

移除课程

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int classId = 789; // int | 
final int courseId = 789; // int | 

try {
    final response = api.removeCourse(classId, courseId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->removeCourse: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **classId** | **int**|  | 
 **courseId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeFromShelf**
> BaseResponseVoid removeFromShelf(userId, bookId)

从书架移除书籍

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int userId = 789; // int | 
final int bookId = 789; // int | 

try {
    final response = api.removeFromShelf(userId, bookId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->removeFromShelf: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**|  | 
 **bookId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeFromWordBook**
> BaseResponseVoid removeFromWordBook(wordBookId)

从生词本移除单词

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int wordBookId = 789; // int | 生词本记录ID

try {
    final response = api.removeFromWordBook(wordBookId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->removeFromWordBook: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wordBookId** | **int**| 生词本记录ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeMember**
> BaseResponseVoid removeMember(groupId, targetUserId)

移除成员

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 
final int targetUserId = 789; // int | 

try {
    final response = api.removeMember(groupId, targetUserId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->removeMember: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 
 **targetUserId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeMember1**
> BaseResponseVoid removeMember1(classId, userId)

移除成员

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int classId = 789; // int | 
final int userId = 789; // int | 

try {
    final response = api.removeMember1(classId, userId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->removeMember1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **classId** | **int**|  | 
 **userId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeMember2**
> BaseResponseVoid removeMember2(groupId, targetUserId)

移除群成员

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 群ID
final int targetUserId = 789; // int | 目标用户ID

try {
    final response = api.removeMember2(groupId, targetUserId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->removeMember2: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**| 群ID | 
 **targetUserId** | **int**| 目标用户ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removePaperQuestion**
> BaseResponseBoolean removePaperQuestion(paperId, sectionId, pqId)

从大题移除题目

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int paperId = 789; // int | 
final int sectionId = 789; // int | 
final int pqId = 789; // int | 

try {
    final response = api.removePaperQuestion(paperId, sectionId, pqId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->removePaperQuestion: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **paperId** | **int**|  | 
 **sectionId** | **int**|  | 
 **pqId** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeTeacher**
> BaseResponseVoid removeTeacher(id)

移除讲师

管理员移除讲师，用户角色降回学生，需重新申请

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 讲师ID

try {
    final response = api.removeTeacher(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->removeTeacher: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 讲师ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **replyFeedback**
> BaseResponseLong replyFeedback(createReplyRequest)

回复反馈

用户回复自己的反馈

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreateReplyRequest createReplyRequest = ; // CreateReplyRequest | 

try {
    final response = api.replyFeedback(createReplyRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->replyFeedback: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createReplyRequest** | [**CreateReplyRequest**](CreateReplyRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **replyFeedback1**
> BaseResponseLong replyFeedback1(createReplyRequest)

回复反馈

管理员回复用户反馈

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreateReplyRequest createReplyRequest = ; // CreateReplyRequest | 

try {
    final response = api.replyFeedback1(createReplyRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->replyFeedback1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createReplyRequest** | [**CreateReplyRequest**](CreateReplyRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resetPassword**
> BaseResponseBoolean resetPassword(resetPasswordRequest)

重置用户密码

管理员重置指定用户的密码

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final ResetPasswordRequest resetPasswordRequest = ; // ResetPasswordRequest | 

try {
    final response = api.resetPassword(resetPasswordRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->resetPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **resetPasswordRequest** | [**ResetPasswordRequest**](ResetPasswordRequest.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resetProgress**
> BaseResponseVoid resetProgress(sectionId)

重置小节进度

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int sectionId = 789; // int | 小节ID

try {
    final response = api.resetProgress(sectionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->resetProgress: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sectionId** | **int**| 小节ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewApplication**
> BaseResponseVoid reviewApplication(reviewApplicationRequest)

审核讲师申请（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final ReviewApplicationRequest reviewApplicationRequest = ; // ReviewApplicationRequest | 

try {
    final response = api.reviewApplication(reviewApplicationRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->reviewApplication: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **reviewApplicationRequest** | [**ReviewApplicationRequest**](ReviewApplicationRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewCourse**
> BaseResponseLong reviewCourse(courseId, reviewCourseRequest)

评价课程

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID
final ReviewCourseRequest reviewCourseRequest = ; // ReviewCourseRequest | 

try {
    final response = api.reviewCourse(courseId, reviewCourseRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->reviewCourse: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 
 **reviewCourseRequest** | [**ReviewCourseRequest**](ReviewCourseRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rollbackToVersion**
> BaseResponseWorkflowResponse rollbackToVersion(id, versionNumber)

回滚到指定版本

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final int versionNumber = 56; // int | 版本号

try {
    final response = api.rollbackToVersion(id, versionNumber);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->rollbackToVersion: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **versionNumber** | **int**| 版本号 | 

### Return type

[**BaseResponseWorkflowResponse**](BaseResponseWorkflowResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeArticleLinks**
> BaseResponseListString scrapeArticleLinks(scrapeRequest)

获取文章链接

从列表页获取所有文章链接

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final ScrapeRequest scrapeRequest = ; // ScrapeRequest | 

try {
    final response = api.scrapeArticleLinks(scrapeRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->scrapeArticleLinks: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **scrapeRequest** | [**ScrapeRequest**](ScrapeRequest.md)|  | 

### Return type

[**BaseResponseListString**](BaseResponseListString.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeDynamicArticleLinks**
> BaseResponseListString scrapeDynamicArticleLinks(dynamicScrapeRequest)

动态获取文章链接

从动态页面获取所有文章链接

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final DynamicScrapeRequest dynamicScrapeRequest = ; // DynamicScrapeRequest | 

try {
    final response = api.scrapeDynamicArticleLinks(dynamicScrapeRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->scrapeDynamicArticleLinks: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **dynamicScrapeRequest** | [**DynamicScrapeRequest**](DynamicScrapeRequest.md)|  | 

### Return type

[**BaseResponseListString**](BaseResponseListString.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeDynamicMultiplePages**
> BaseResponseScrapeResultResponse scrapeDynamicMultiplePages(batchScrapeRequest, waitForJsMs)

批量动态抓取

批量抓取多个动态页面

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final BatchScrapeRequest batchScrapeRequest = ; // BatchScrapeRequest | 
final int waitForJsMs = 56; // int | 

try {
    final response = api.scrapeDynamicMultiplePages(batchScrapeRequest, waitForJsMs);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->scrapeDynamicMultiplePages: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **batchScrapeRequest** | [**BatchScrapeRequest**](BatchScrapeRequest.md)|  | 
 **waitForJsMs** | **int**|  | [optional] [default to 3000]

### Return type

[**BaseResponseScrapeResultResponse**](BaseResponseScrapeResultResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeDynamicPage**
> BaseResponseArticleResponse scrapeDynamicPage(dynamicScrapeRequest)

动态抓取单个页面

使用无头浏览器抓取 JavaScript 渲染的动态页面

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final DynamicScrapeRequest dynamicScrapeRequest = ; // DynamicScrapeRequest | 

try {
    final response = api.scrapeDynamicPage(dynamicScrapeRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->scrapeDynamicPage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **dynamicScrapeRequest** | [**DynamicScrapeRequest**](DynamicScrapeRequest.md)|  | 

### Return type

[**BaseResponseArticleResponse**](BaseResponseArticleResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeDynamicPageWithSelector**
> BaseResponseArticleResponse scrapeDynamicPageWithSelector(dynamicScrapeRequest)

动态抓取（等待元素）

等待页面特定元素加载后再抓取

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final DynamicScrapeRequest dynamicScrapeRequest = ; // DynamicScrapeRequest | 

try {
    final response = api.scrapeDynamicPageWithSelector(dynamicScrapeRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->scrapeDynamicPageWithSelector: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **dynamicScrapeRequest** | [**DynamicScrapeRequest**](DynamicScrapeRequest.md)|  | 

### Return type

[**BaseResponseArticleResponse**](BaseResponseArticleResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeDynamicRecursively**
> BaseResponseScrapeResultResponse scrapeDynamicRecursively(dynamicScrapeRequest)

递归动态抓取

递归抓取动态网站，支持 SPA 和 JavaScript 渲染页面

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final DynamicScrapeRequest dynamicScrapeRequest = ; // DynamicScrapeRequest | 

try {
    final response = api.scrapeDynamicRecursively(dynamicScrapeRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->scrapeDynamicRecursively: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **dynamicScrapeRequest** | [**DynamicScrapeRequest**](DynamicScrapeRequest.md)|  | 

### Return type

[**BaseResponseScrapeResultResponse**](BaseResponseScrapeResultResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeFromSource**
> BaseResponseScrapeResultResponse scrapeFromSource(sourceScrapeRequest)

从预设来源抓取

使用预设的来源配置抓取内容，支持 Dogo News、Science News for Students 等

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final SourceScrapeRequest sourceScrapeRequest = ; // SourceScrapeRequest | 

try {
    final response = api.scrapeFromSource(sourceScrapeRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->scrapeFromSource: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sourceScrapeRequest** | [**SourceScrapeRequest**](SourceScrapeRequest.md)|  | 

### Return type

[**BaseResponseScrapeResultResponse**](BaseResponseScrapeResultResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeMultiplePages**
> BaseResponseScrapeResultResponse scrapeMultiplePages(batchScrapeRequest)

批量抓取

批量抓取多个URL的页面内容

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final BatchScrapeRequest batchScrapeRequest = ; // BatchScrapeRequest | 

try {
    final response = api.scrapeMultiplePages(batchScrapeRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->scrapeMultiplePages: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **batchScrapeRequest** | [**BatchScrapeRequest**](BatchScrapeRequest.md)|  | 

### Return type

[**BaseResponseScrapeResultResponse**](BaseResponseScrapeResultResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeRecursively**
> BaseResponseScrapeResultResponse scrapeRecursively(scrapeRequest)

递归抓取

从起始URL开始递归抓取网站内容，支持嵌套页面扫描

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final ScrapeRequest scrapeRequest = ; // ScrapeRequest | 

try {
    final response = api.scrapeRecursively(scrapeRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->scrapeRecursively: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **scrapeRequest** | [**ScrapeRequest**](ScrapeRequest.md)|  | 

### Return type

[**BaseResponseScrapeResultResponse**](BaseResponseScrapeResultResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeSinglePage**
> BaseResponseArticleResponse scrapeSinglePage(scrapeRequest)

抓取单个页面

抓取指定URL的页面内容，提取标题、作者、来源、正文等信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final ScrapeRequest scrapeRequest = ; // ScrapeRequest | 

try {
    final response = api.scrapeSinglePage(scrapeRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->scrapeSinglePage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **scrapeRequest** | [**ScrapeRequest**](ScrapeRequest.md)|  | 

### Return type

[**BaseResponseArticleResponse**](BaseResponseArticleResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchAll**
> BaseResponsePageResult searchAll(q, type, page, size)

聚合搜索（书籍+章节+帖子）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String q = q_example; // String | 
final String type = type_example; // String | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.searchAll(q, type, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->searchAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **q** | **String**|  | 
 **type** | **String**|  | [optional] [default to 'all']
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponsePageResult**](BaseResponsePageResult.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchArticles**
> BaseResponseDailyArticlePageResponse searchArticles(keyword, page, size)

搜索文章

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String keyword = keyword_example; // String | 关键词
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.searchArticles(keyword, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->searchArticles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **keyword** | **String**| 关键词 | 
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseDailyArticlePageResponse**](BaseResponseDailyArticlePageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchBookChapters**
> BaseResponsePageResult searchBookChapters(bookId, q, page, size)

书内搜索

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int bookId = 789; // int | 
final String q = q_example; // String | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.searchBookChapters(bookId, q, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->searchBookChapters: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **q** | **String**|  | 
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponsePageResult**](BaseResponsePageResult.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchBooks**
> BaseResponsePageResult searchBooks(q, page, size)

搜索书籍

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String q = q_example; // String | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.searchBooks(q, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->searchBooks: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **q** | **String**|  | 
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponsePageResult**](BaseResponsePageResult.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchBooks1**
> BaseResponseListBookDTO searchBooks1(keyword, page, size)

搜索书籍

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String keyword = keyword_example; // String | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.searchBooks1(keyword, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->searchBooks1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **keyword** | **String**|  | 
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponseListBookDTO**](BaseResponseListBookDTO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchChapters**
> BaseResponsePageResult searchChapters(q, bookId, page, size)

搜索章节内容

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String q = q_example; // String | 
final int bookId = 789; // int | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.searchChapters(q, bookId, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->searchChapters: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **q** | **String**|  | 
 **bookId** | **int**|  | [optional] 
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponsePageResult**](BaseResponsePageResult.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchCourses**
> BaseResponseListCourseResponse searchCourses(keyword, page, size)

搜索课程

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String keyword = keyword_example; // String | 关键词
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.searchCourses(keyword, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->searchCourses: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **keyword** | **String**| 关键词 | 
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseListCourseResponse**](BaseResponseListCourseResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchGroups**
> BaseResponseGroupPage searchGroups(keyword, pageNum, pageSize)

搜索群

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String keyword = keyword_example; // String | 
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.searchGroups(keyword, pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->searchGroups: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **keyword** | **String**|  | 
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponseGroupPage**](BaseResponseGroupPage.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchGroups1**
> BaseResponseAdminGroupPageResponse searchGroups1(keyword, pageNum, pageSize)

搜索群

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String keyword = keyword_example; // String | 关键词
final int pageNum = 56; // int | 页码
final int pageSize = 56; // int | 每页数量

try {
    final response = api.searchGroups1(keyword, pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->searchGroups1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **keyword** | **String**| 关键词 | 
 **pageNum** | **int**| 页码 | [optional] [default to 1]
 **pageSize** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseAdminGroupPageResponse**](BaseResponseAdminGroupPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchPosts**
> BaseResponsePageResult searchPosts(q, postType, page, size)

搜索帖子

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String q = q_example; // String | 
final String postType = postType_example; // String | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.searchPosts(q, postType, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->searchPosts: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **q** | **String**|  | 
 **postType** | **String**|  | [optional] 
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponsePageResult**](BaseResponsePageResult.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchPosts1**
> BaseResponsePostPageResponse searchPosts1(keyword, pageNum, pageSize)

搜索帖子

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String keyword = keyword_example; // String | 
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.searchPosts1(keyword, pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->searchPosts1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **keyword** | **String**|  | 
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponsePostPageResponse**](BaseResponsePostPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchPostsByTag**
> BaseResponsePostPageResponse searchPostsByTag(tag, pageNum, pageSize)

根据标签搜索帖子

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String tag = tag_example; // String | 
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.searchPostsByTag(tag, pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->searchPostsByTag: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **tag** | **String**|  | 
 **pageNum** | **int**|  | [optional] [default to 1]
 **pageSize** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponsePostPageResponse**](BaseResponsePostPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchTemplates**
> BaseResponseListWorkflowTemplateResponse searchTemplates(keyword, category, page, size)

搜索工作流模板

返回公开模板 + 当前用户自己创建的私有模板

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String keyword = keyword_example; // String | 关键词
final String category = category_example; // String | 分类
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.searchTemplates(keyword, category, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->searchTemplates: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **keyword** | **String**| 关键词 | [optional] 
 **category** | **String**| 分类 | [optional] 
 **page** | **int**| 页码 | [optional] [default to 0]
 **size** | **int**| 每页数量 | [optional] [default to 20]

### Return type

[**BaseResponseListWorkflowTemplateResponse**](BaseResponseListWorkflowTemplateResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchUsers**
> BaseResponseSearchUserPageResponse searchUsers(searchUserRequestDTO)

搜索用户

根据关键词搜索用户，用于添加好友

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final SearchUserRequestDTO searchUserRequestDTO = ; // SearchUserRequestDTO | 

try {
    final response = api.searchUsers(searchUserRequestDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->searchUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **searchUserRequestDTO** | [**SearchUserRequestDTO**](SearchUserRequestDTO.md)|  | 

### Return type

[**BaseResponseSearchUserPageResponse**](BaseResponseSearchUserPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchWords**
> BaseResponseDailyWordPageResponse searchWords(keyword, page, size)

搜索单词

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String keyword = keyword_example; // String | 关键词
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.searchWords(keyword, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->searchWords: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **keyword** | **String**| 关键词 | 
 **page** | **int**| 页码 | [optional] [default to 1]
 **size** | **int**| 每页数量 | [optional] [default to 10]

### Return type

[**BaseResponseDailyWordPageResponse**](BaseResponseDailyWordPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendFriendRequest**
> BaseResponseLong sendFriendRequest(sendFriendRequestDTO)

发送好友申请

向指定用户发送好友申请

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final SendFriendRequestDTO sendFriendRequestDTO = ; // SendFriendRequestDTO | 

try {
    final response = api.sendFriendRequest(sendFriendRequestDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->sendFriendRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendFriendRequestDTO** | [**SendFriendRequestDTO**](SendFriendRequestDTO.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendRegisterCode**
> BaseResponseSendResult sendRegisterCode(sendCodeRequest)

发送注册验证码

发送短信验证码用于注册

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final SendCodeRequest sendCodeRequest = ; // SendCodeRequest | 

try {
    final response = api.sendRegisterCode(sendCodeRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->sendRegisterCode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendCodeRequest** | [**SendCodeRequest**](SendCodeRequest.md)|  | 

### Return type

[**BaseResponseSendResult**](BaseResponseSendResult.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendSms**
> BaseResponseSendResult sendSms(sendSmsRequest)

发送短信验证码

管理员手动发送短信验证码

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final SendSmsRequest sendSmsRequest = ; // SendSmsRequest | 

try {
    final response = api.sendSms(sendSmsRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->sendSms: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendSmsRequest** | [**SendSmsRequest**](SendSmsRequest.md)|  | 

### Return type

[**BaseResponseSendResult**](BaseResponseSendResult.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setAdmin**
> BaseResponseVoid setAdmin(groupId, targetUserId, isAdmin)

设置/取消管理员

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 
final int targetUserId = 789; // int | 
final bool isAdmin = true; // bool | 

try {
    final response = api.setAdmin(groupId, targetUserId, isAdmin);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->setAdmin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 
 **targetUserId** | **int**|  | 
 **isAdmin** | **bool**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setJoinMode**
> BaseResponseVoid setJoinMode(groupId, mode)

设置群加入模式

0-自由加入，1-需审批，2-禁止加入

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 
final int mode = 56; // int | 

try {
    final response = api.setJoinMode(groupId, mode);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->setJoinMode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 
 **mode** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setMute**
> BaseResponseVoid setMute(groupId, mute)

设置群全员禁言

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 群ID
final bool mute = true; // bool | 是否禁言

try {
    final response = api.setMute(groupId, mute);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->setMute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**| 群ID | 
 **mute** | **bool**| 是否禁言 | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **smartDynamicScrape**
> BaseResponseScrapeResultResponse smartDynamicScrape(url, maxArticles, forceDynamic)

智能动态抓取

自动检测是否需要动态抓取，先尝试静态抓取，失败后自动切换到动态抓取

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String url = url_example; // String | 
final int maxArticles = 56; // int | 
final bool forceDynamic = true; // bool | 

try {
    final response = api.smartDynamicScrape(url, maxArticles, forceDynamic);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->smartDynamicScrape: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **url** | **String**|  | 
 **maxArticles** | **int**|  | [optional] [default to 10]
 **forceDynamic** | **bool**|  | [optional] [default to false]

### Return type

[**BaseResponseScrapeResultResponse**](BaseResponseScrapeResultResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **smartScrape**
> BaseResponseScrapeResultResponse smartScrape(url, maxArticles)

智能抓取

自动识别页面类型并使用最佳策略抓取

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String url = url_example; // String | 
final int maxArticles = 56; // int | 

try {
    final response = api.smartScrape(url, maxArticles);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->smartScrape: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **url** | **String**|  | 
 **maxArticles** | **int**|  | [optional] [default to 10]

### Return type

[**BaseResponseScrapeResultResponse**](BaseResponseScrapeResultResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **startStreaming**
> BaseResponseLiveRoomResponse startStreaming(id)

获取推流信息

主播获取推流地址和密钥

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.startStreaming(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->startStreaming: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseLiveRoomResponse**](BaseResponseLiveRoomResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **stopStreaming**
> BaseResponseLiveRoomResponse stopStreaming(id)

结束直播

主播手动结束直播

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.stopStreaming(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->stopStreaming: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseLiveRoomResponse**](BaseResponseLiveRoomResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **studyWord**
> BaseResponseVoid studyWord(wordId)

标记单词为已学习

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int wordId = 789; // int | 单词ID

try {
    final response = api.studyWord(wordId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->studyWord: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wordId** | **int**| 单词ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **submitHomework**
> SseEmitter submitHomework(submitHomeworkRequest)

提交作业并开始批改（SSE流式返回进度）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final SubmitHomeworkRequest submitHomeworkRequest = ; // SubmitHomeworkRequest | 

try {
    final response = api.submitHomework(submitHomeworkRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->submitHomework: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **submitHomeworkRequest** | [**SubmitHomeworkRequest**](SubmitHomeworkRequest.md)|  | 

### Return type

[**SseEmitter**](SseEmitter.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, text/event-stream

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **suggest**
> BaseResponseListSearchSuggestionDTO suggest(q, type)

搜索建议（即时联想）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String q = q_example; // String | 
final String type = type_example; // String | 

try {
    final response = api.suggest(q, type);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->suggest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **q** | **String**|  | 
 **type** | **String**|  | [optional] [default to 'all']

### Return type

[**BaseResponseListSearchSuggestionDTO**](BaseResponseListSearchSuggestionDTO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **takeOffline**
> BaseResponseVoid takeOffline(id)

下架课程（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 课程ID

try {
    final response = api.takeOffline(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->takeOffline: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 课程ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **textToSpeech**
> String textToSpeech(ttsRequest)

文本转语音

将文本转换为语音，返回音频文件

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final TtsRequest ttsRequest = ; // TtsRequest | 

try {
    final response = api.textToSpeech(ttsRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->textToSpeech: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ttsRequest** | [**TtsRequest**](TtsRequest.md)|  | 

### Return type

**String**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **textToSpeechBase64**
> BaseResponseTtsResponse textToSpeechBase64(ttsRequest)

文本转语音 (Base64)

将文本转换为语音，返回 Base64 编码的音频数据

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final TtsRequest ttsRequest = ; // TtsRequest | 

try {
    final response = api.textToSpeechBase64(ttsRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->textToSpeechBase64: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ttsRequest** | [**TtsRequest**](TtsRequest.md)|  | 

### Return type

[**BaseResponseTtsResponse**](BaseResponseTtsResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toggleCollect**
> BaseResponseVoid toggleCollect(wordId)

收藏/取消收藏单词

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int wordId = 789; // int | 单词ID

try {
    final response = api.toggleCollect(wordId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->toggleCollect: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wordId** | **int**| 单词ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toggleCollect1**
> BaseResponseVoid toggleCollect1(articleId)

收藏/取消收藏文章

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int articleId = 789; // int | 文章ID

try {
    final response = api.toggleCollect1(articleId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->toggleCollect1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **articleId** | **int**| 文章ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toggleFavour**
> BaseResponseBoolean toggleFavour(postId)

收藏/取消收藏帖子

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int postId = 789; // int | 

try {
    final response = api.toggleFavour(postId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->toggleFavour: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postId** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toggleFollow**
> BaseResponseBoolean toggleFollow(targetUserId)

切换关注状态

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int targetUserId = 789; // int | 

try {
    final response = api.toggleFollow(targetUserId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->toggleFollow: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **targetUserId** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toggleLike**
> BaseResponseVoid toggleLike(articleId)

点赞/取消点赞文章

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int articleId = 789; // int | 文章ID

try {
    final response = api.toggleLike(articleId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->toggleLike: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **articleId** | **int**| 文章ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toggleThumb**
> BaseResponseBoolean toggleThumb(postId)

点赞/取消点赞帖子

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int postId = 789; // int | 

try {
    final response = api.toggleThumb(postId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->toggleThumb: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postId** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **transferOwnership**
> BaseResponseVoid transferOwnership(groupId, newOwnerId)

转让群主

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 
final int newOwnerId = 789; // int | 

try {
    final response = api.transferOwnership(groupId, newOwnerId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->transferOwnership: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 
 **newOwnerId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unbindFromAssistant**
> BaseResponseVoid unbindFromAssistant(id, assistantId)

解绑工作流与AI助手

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final int assistantId = 789; // int | AI助手ID

try {
    final response = api.unbindFromAssistant(id, assistantId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->unbindFromAssistant: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **assistantId** | **int**| AI助手ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unfavouriteCourse**
> BaseResponseVoid unfavouriteCourse(courseId)

取消收藏

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID

try {
    final response = api.unfavouriteCourse(courseId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->unfavouriteCourse: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unfollow**
> BaseResponseVoid unfollow(targetUserId)

取消关注

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int targetUserId = 789; // int | 

try {
    final response = api.unfollow(targetUserId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->unfollow: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **targetUserId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unpublishExamPaper**
> BaseResponseBoolean unpublishExamPaper(id)

撤回试卷为草稿

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.unpublishExamPaper(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->unpublishExamPaper: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **update**
> BaseResponseWorkflowResponse update(id, updateWorkflowRequest)

更新工作流基本信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final UpdateWorkflowRequest updateWorkflowRequest = ; // UpdateWorkflowRequest | 

try {
    final response = api.update(id, updateWorkflowRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->update: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **updateWorkflowRequest** | [**UpdateWorkflowRequest**](UpdateWorkflowRequest.md)|  | 

### Return type

[**BaseResponseWorkflowResponse**](BaseResponseWorkflowResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateAnnouncement**
> BaseResponseBoolean updateAnnouncement(updateAnnouncementRequest)

更新公告

更新公告信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final UpdateAnnouncementRequest updateAnnouncementRequest = ; // UpdateAnnouncementRequest | 

try {
    final response = api.updateAnnouncement(updateAnnouncementRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateAnnouncement: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateAnnouncementRequest** | [**UpdateAnnouncementRequest**](UpdateAnnouncementRequest.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateBanner**
> BaseResponseBoolean updateBanner(updateBannerRequest)

更新轮播图

更新轮播图信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final UpdateBannerRequest updateBannerRequest = ; // UpdateBannerRequest | 

try {
    final response = api.updateBanner(updateBannerRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateBanner: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateBannerRequest** | [**UpdateBannerRequest**](UpdateBannerRequest.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateBook**
> BaseResponseBookDTO updateBook(bookId, requestBody)

编辑书籍信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int bookId = 789; // int | 
final BuiltMap<String, String> requestBody = ; // BuiltMap<String, String> | 

try {
    final response = api.updateBook(bookId, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateBook: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **requestBody** | [**BuiltMap&lt;String, String&gt;**](String.md)|  | 

### Return type

[**BaseResponseBookDTO**](BaseResponseBookDTO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateBookCover**
> BaseResponseBookDTO updateBookCover(bookId, updateBookCoverRequest)

更新书籍封面

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int bookId = 789; // int | 
final UpdateBookCoverRequest updateBookCoverRequest = ; // UpdateBookCoverRequest | 

try {
    final response = api.updateBookCover(bookId, updateBookCoverRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateBookCover: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **updateBookCoverRequest** | [**UpdateBookCoverRequest**](UpdateBookCoverRequest.md)|  | [optional] 

### Return type

[**BaseResponseBookDTO**](BaseResponseBookDTO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateBookmark**
> BaseResponseReadingBookmarkDTO updateBookmark(bookId, bookmarkId, requestBody)

更新书签备注/标题

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int bookId = 789; // int | 
final int bookmarkId = 789; // int | 
final BuiltMap<String, String> requestBody = ; // BuiltMap<String, String> | 

try {
    final response = api.updateBookmark(bookId, bookmarkId, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateBookmark: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **bookmarkId** | **int**|  | 
 **requestBody** | [**BuiltMap&lt;String, String&gt;**](String.md)|  | 

### Return type

[**BaseResponseReadingBookmarkDTO**](BaseResponseReadingBookmarkDTO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateChapter**
> BaseResponseVoid updateChapter(courseId, chapterId, updateChapterRequest)

更新章节（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID
final int chapterId = 789; // int | 章节ID
final UpdateChapterRequest updateChapterRequest = ; // UpdateChapterRequest | 

try {
    final response = api.updateChapter(courseId, chapterId, updateChapterRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateChapter: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 
 **chapterId** | **int**| 章节ID | 
 **updateChapterRequest** | [**UpdateChapterRequest**](UpdateChapterRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateClass**
> BaseResponseVoid updateClass(classId, updateClassRequest)

更新班级信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int classId = 789; // int | 
final UpdateClassRequest updateClassRequest = ; // UpdateClassRequest | 

try {
    final response = api.updateClass(classId, updateClassRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateClass: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **classId** | **int**|  | 
 **updateClassRequest** | [**UpdateClassRequest**](UpdateClassRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateConfig**
> BaseResponseScraperConfigResponse updateConfig(id, scraperConfigRequest)

更新抓取配置

更新已有的抓取源配置

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final ScraperConfigRequest scraperConfigRequest = ; // ScraperConfigRequest | 

try {
    final response = api.updateConfig(id, scraperConfigRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateConfig: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **scraperConfigRequest** | [**ScraperConfigRequest**](ScraperConfigRequest.md)|  | 

### Return type

[**BaseResponseScraperConfigResponse**](BaseResponseScraperConfigResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateCourse**
> BaseResponseVoid updateCourse(id, updateCourseRequest)

更新课程（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 课程ID
final UpdateCourseRequest updateCourseRequest = ; // UpdateCourseRequest | 

try {
    final response = api.updateCourse(id, updateCourseRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateCourse: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 课程ID | 
 **updateCourseRequest** | [**UpdateCourseRequest**](UpdateCourseRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateDailyArticle**
> BaseResponseVoid updateDailyArticle(id, updateDailyArticleRequest)

更新每日文章（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 文章ID
final UpdateDailyArticleRequest updateDailyArticleRequest = ; // UpdateDailyArticleRequest | 

try {
    final response = api.updateDailyArticle(id, updateDailyArticleRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateDailyArticle: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 文章ID | 
 **updateDailyArticleRequest** | [**UpdateDailyArticleRequest**](UpdateDailyArticleRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateDailyWord**
> BaseResponseVoid updateDailyWord(id, updateDailyWordRequest)

更新每日单词（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 单词ID
final UpdateDailyWordRequest updateDailyWordRequest = ; // UpdateDailyWordRequest | 

try {
    final response = api.updateDailyWord(id, updateDailyWordRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateDailyWord: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 单词ID | 
 **updateDailyWordRequest** | [**UpdateDailyWordRequest**](UpdateDailyWordRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateDefinition**
> BaseResponseWorkflowResponse updateDefinition(id, updateWorkflowDefinitionRequest)

更新工作流定义

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final UpdateWorkflowDefinitionRequest updateWorkflowDefinitionRequest = ; // UpdateWorkflowDefinitionRequest | 

try {
    final response = api.updateDefinition(id, updateWorkflowDefinitionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateDefinition: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **updateWorkflowDefinitionRequest** | [**UpdateWorkflowDefinitionRequest**](UpdateWorkflowDefinitionRequest.md)|  | 

### Return type

[**BaseResponseWorkflowResponse**](BaseResponseWorkflowResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateEdge**
> BaseResponseWorkflowEdgeResponse updateEdge(id, edgeId, updateEdgeRequest)

更新连接线

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final String edgeId = edgeId_example; // String | 连接线ID
final UpdateEdgeRequest updateEdgeRequest = ; // UpdateEdgeRequest | 

try {
    final response = api.updateEdge(id, edgeId, updateEdgeRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateEdge: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **edgeId** | **String**| 连接线ID | 
 **updateEdgeRequest** | [**UpdateEdgeRequest**](UpdateEdgeRequest.md)|  | 

### Return type

[**BaseResponseWorkflowEdgeResponse**](BaseResponseWorkflowEdgeResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateExamPaper**
> BaseResponseBoolean updateExamPaper(updateExamPaperRequest)

更新试卷基本信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final UpdateExamPaperRequest updateExamPaperRequest = ; // UpdateExamPaperRequest | 

try {
    final response = api.updateExamPaper(updateExamPaperRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateExamPaper: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateExamPaperRequest** | [**UpdateExamPaperRequest**](UpdateExamPaperRequest.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateFeedbackStatus**
> BaseResponseBoolean updateFeedbackStatus(updateFeedbackStatusRequest)

更新反馈状态

管理员更新反馈处理状态

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final UpdateFeedbackStatusRequest updateFeedbackStatusRequest = ; // UpdateFeedbackStatusRequest | 

try {
    final response = api.updateFeedbackStatus(updateFeedbackStatusRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateFeedbackStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateFeedbackStatusRequest** | [**UpdateFeedbackStatusRequest**](UpdateFeedbackStatusRequest.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateGroupInfo**
> BaseResponseVoid updateGroupInfo(groupId, updateGroupRequest)

更新群信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 
final UpdateGroupRequest updateGroupRequest = ; // UpdateGroupRequest | 

try {
    final response = api.updateGroupInfo(groupId, updateGroupRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateGroupInfo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 
 **updateGroupRequest** | [**UpdateGroupRequest**](UpdateGroupRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateGroupInfo1**
> BaseResponseVoid updateGroupInfo1(groupId, updateGroupRequest)

更新群信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int groupId = 789; // int | 群ID
final UpdateGroupRequest updateGroupRequest = ; // UpdateGroupRequest | 

try {
    final response = api.updateGroupInfo1(groupId, updateGroupRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateGroupInfo1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**| 群ID | 
 **updateGroupRequest** | [**UpdateGroupRequest**](UpdateGroupRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateItem**
> BaseResponseBoolean updateItem(id, updateScheduleItemRequest)

更新课程项

更新课程项信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final UpdateScheduleItemRequest updateScheduleItemRequest = ; // UpdateScheduleItemRequest | 

try {
    final response = api.updateItem(id, updateScheduleItemRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateItem: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **updateScheduleItemRequest** | [**UpdateScheduleItemRequest**](UpdateScheduleItemRequest.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateLearningStatus**
> BaseResponseVoid updateLearningStatus(wordBookId, status)

更新学习状态

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int wordBookId = 789; // int | 生词本记录ID
final int status = 56; // int | 学习状态：0-未学习，1-已学习，2-已掌握

try {
    final response = api.updateLearningStatus(wordBookId, status);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateLearningStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wordBookId** | **int**| 生词本记录ID | 
 **status** | **int**| 学习状态：0-未学习，1-已学习，2-已掌握 | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMastery**
> BaseResponseVoid updateMastery(wordId, level)

更新单词掌握程度

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int wordId = 789; // int | 单词ID
final int level = 56; // int | 掌握程度：0-未知，1-生词，2-熟悉，3-掌握

try {
    final response = api.updateMastery(wordId, level);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateMastery: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wordId** | **int**| 单词ID | 
 **level** | **int**| 掌握程度：0-未知，1-生词，2-熟悉，3-掌握 | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateNode**
> BaseResponseWorkflowNodeResponse updateNode(id, nodeId, updateNodeRequest)

更新节点

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final String nodeId = nodeId_example; // String | 节点ID
final UpdateNodeRequest updateNodeRequest = ; // UpdateNodeRequest | 

try {
    final response = api.updateNode(id, nodeId, updateNodeRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateNode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **nodeId** | **String**| 节点ID | 
 **updateNodeRequest** | [**UpdateNodeRequest**](UpdateNodeRequest.md)|  | 

### Return type

[**BaseResponseWorkflowNodeResponse**](BaseResponseWorkflowNodeResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateNodeConfig**
> BaseResponseWorkflowNodeResponse updateNodeConfig(id, nodeId, updateNodeConfigRequest)

更新节点配置

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final String nodeId = nodeId_example; // String | 节点ID
final UpdateNodeConfigRequest updateNodeConfigRequest = ; // UpdateNodeConfigRequest | 

try {
    final response = api.updateNodeConfig(id, nodeId, updateNodeConfigRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateNodeConfig: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **nodeId** | **String**| 节点ID | 
 **updateNodeConfigRequest** | [**UpdateNodeConfigRequest**](UpdateNodeConfigRequest.md)|  | 

### Return type

[**BaseResponseWorkflowNodeResponse**](BaseResponseWorkflowNodeResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateNote**
> BaseResponseReadingNoteDTO updateNote(bookId, noteId, requestBody)

更新笔记内容/颜色

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int bookId = 789; // int | 
final int noteId = 789; // int | 
final BuiltMap<String, String> requestBody = ; // BuiltMap<String, String> | 

try {
    final response = api.updateNote(bookId, noteId, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateNote: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **noteId** | **int**|  | 
 **requestBody** | [**BuiltMap&lt;String, String&gt;**](String.md)|  | 

### Return type

[**BaseResponseReadingNoteDTO**](BaseResponseReadingNoteDTO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePaperQuestion**
> BaseResponseBoolean updatePaperQuestion(paperId, sectionId, pqId, updatePaperQuestionRequest)

更新试卷题目分值/排序

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int paperId = 789; // int | 
final int sectionId = 789; // int | 
final int pqId = 789; // int | 
final UpdatePaperQuestionRequest updatePaperQuestionRequest = ; // UpdatePaperQuestionRequest | 

try {
    final response = api.updatePaperQuestion(paperId, sectionId, pqId, updatePaperQuestionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updatePaperQuestion: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **paperId** | **int**|  | 
 **sectionId** | **int**|  | 
 **pqId** | **int**|  | 
 **updatePaperQuestionRequest** | [**UpdatePaperQuestionRequest**](UpdatePaperQuestionRequest.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePlan**
> BaseResponseVoid updatePlan(updatePlanRequest)

更新会员计划基本信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final UpdatePlanRequest updatePlanRequest = ; // UpdatePlanRequest | 

try {
    final response = api.updatePlan(updatePlanRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updatePlan: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updatePlanRequest** | [**UpdatePlanRequest**](UpdatePlanRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePlanQuota**
> BaseResponseVoid updatePlanQuota(planId, updatePlanQuotaRequest)

修改计划AI配额

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int planId = 789; // int | 
final UpdatePlanQuotaRequest updatePlanQuotaRequest = ; // UpdatePlanQuotaRequest | 

try {
    final response = api.updatePlanQuota(planId, updatePlanQuotaRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updatePlanQuota: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **planId** | **int**|  | 
 **updatePlanQuotaRequest** | [**UpdatePlanQuotaRequest**](UpdatePlanQuotaRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePost**
> BaseResponseVoid updatePost(postId, updatePostRequest)

更新帖子

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int postId = 789; // int | 
final UpdatePostRequest updatePostRequest = ; // UpdatePostRequest | 

try {
    final response = api.updatePost(postId, updatePostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updatePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postId** | **int**|  | 
 **updatePostRequest** | [**UpdatePostRequest**](UpdatePostRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateProfile**
> BaseResponseBoolean updateProfile(updateProfileRequest)

更新个人资料

用户更新自己的个人资料

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final UpdateProfileRequest updateProfileRequest = ; // UpdateProfileRequest | 

try {
    final response = api.updateProfile(updateProfileRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateProfileRequest** | [**UpdateProfileRequest**](UpdateProfileRequest.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateProgress**
> BaseResponseVoid updateProgress(updateReadingProgressCommand)

更新阅读进度

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final UpdateReadingProgressCommand updateReadingProgressCommand = ; // UpdateReadingProgressCommand | 

try {
    final response = api.updateProgress(updateReadingProgressCommand);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateProgress: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateReadingProgressCommand** | [**UpdateReadingProgressCommand**](UpdateReadingProgressCommand.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateProgress1**
> BaseResponseVoid updateProgress1(updateProgressRequest)

更新学习进度

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final UpdateProgressRequest updateProgressRequest = ; // UpdateProgressRequest | 

try {
    final response = api.updateProgress1(updateProgressRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateProgress1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateProgressRequest** | [**UpdateProgressRequest**](UpdateProgressRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateQuestion**
> BaseResponseBoolean updateQuestion(updateQuestionRequest)

更新题目

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final UpdateQuestionRequest updateQuestionRequest = ; // UpdateQuestionRequest | 

try {
    final response = api.updateQuestion(updateQuestionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateQuestion: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateQuestionRequest** | [**UpdateQuestionRequest**](UpdateQuestionRequest.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateReview**
> BaseResponseVoid updateReview(reviewId, reviewCourseRequest)

更新评价

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int reviewId = 789; // int | 评价ID
final ReviewCourseRequest reviewCourseRequest = ; // ReviewCourseRequest | 

try {
    final response = api.updateReview(reviewId, reviewCourseRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateReview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **reviewId** | **int**| 评价ID | 
 **reviewCourseRequest** | [**ReviewCourseRequest**](ReviewCourseRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateSection**
> BaseResponseBoolean updateSection(paperId, sectionId, addPaperSectionRequest)

更新大题

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int paperId = 789; // int | 
final int sectionId = 789; // int | 
final AddPaperSectionRequest addPaperSectionRequest = ; // AddPaperSectionRequest | 

try {
    final response = api.updateSection(paperId, sectionId, addPaperSectionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateSection: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **paperId** | **int**|  | 
 **sectionId** | **int**|  | 
 **addPaperSectionRequest** | [**AddPaperSectionRequest**](AddPaperSectionRequest.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateSection1**
> BaseResponseVoid updateSection1(courseId, sectionId, updateSectionRequest)

更新小节（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID
final int sectionId = 789; // int | 小节ID
final UpdateSectionRequest updateSectionRequest = ; // UpdateSectionRequest | 

try {
    final response = api.updateSection1(courseId, sectionId, updateSectionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateSection1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **courseId** | **int**| 课程ID | 
 **sectionId** | **int**| 小节ID | 
 **updateSectionRequest** | [**UpdateSectionRequest**](UpdateSectionRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateSetting**
> BaseResponseBoolean updateSetting(id, updateScheduleSettingRequest)

更新课表配置

更新课表基础配置

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final UpdateScheduleSettingRequest updateScheduleSettingRequest = ; // UpdateScheduleSettingRequest | 

try {
    final response = api.updateSetting(id, updateScheduleSettingRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateSetting: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **updateScheduleSettingRequest** | [**UpdateScheduleSettingRequest**](UpdateScheduleSettingRequest.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateSettings**
> BaseResponseWorkflowSettingsDTO updateSettings(id, updateWorkflowSettingsRequest)

更新工作流设置

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final UpdateWorkflowSettingsRequest updateWorkflowSettingsRequest = ; // UpdateWorkflowSettingsRequest | 

try {
    final response = api.updateSettings(id, updateWorkflowSettingsRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateSettings: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **updateWorkflowSettingsRequest** | [**UpdateWorkflowSettingsRequest**](UpdateWorkflowSettingsRequest.md)|  | 

### Return type

[**BaseResponseWorkflowSettingsDTO**](BaseResponseWorkflowSettingsDTO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateTeacher**
> BaseResponseVoid updateTeacher(id, updateTeacherRequest)

更新讲师信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 讲师ID
final UpdateTeacherRequest updateTeacherRequest = ; // UpdateTeacherRequest | 

try {
    final response = api.updateTeacher(id, updateTeacherRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateTeacher: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 讲师ID | 
 **updateTeacherRequest** | [**UpdateTeacherRequest**](UpdateTeacherRequest.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateUser**
> BaseResponseBoolean updateUser(updateUserRequest)

更新用户

管理员更新用户信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final UpdateUserRequest updateUserRequest = ; // UpdateUserRequest | 

try {
    final response = api.updateUser(updateUserRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateUserRequest** | [**UpdateUserRequest**](UpdateUserRequest.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateVariable**
> BaseResponseWorkflowVariableResponse updateVariable(id, variableName, updateVariableRequest)

更新变量

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID
final String variableName = variableName_example; // String | 变量名称
final UpdateVariableRequest updateVariableRequest = ; // UpdateVariableRequest | 

try {
    final response = api.updateVariable(id, variableName, updateVariableRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateVariable: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 
 **variableName** | **String**| 变量名称 | 
 **updateVariableRequest** | [**UpdateVariableRequest**](UpdateVariableRequest.md)|  | 

### Return type

[**BaseResponseWorkflowVariableResponse**](BaseResponseWorkflowVariableResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadBook**
> BaseResponseBookDTO uploadBook(command)

上传书籍

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final UploadBookCommand command = ; // UploadBookCommand | 

try {
    final response = api.uploadBook(command);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->uploadBook: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **command** | [**UploadBookCommand**](.md)|  | 

### Return type

[**BaseResponseBookDTO**](BaseResponseBookDTO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadTemplate1**
> BaseResponseLong uploadTemplate1(name, description, uploadTemplate1Request)

上传试卷模板

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String name = name_example; // String | 模板名称
final String description = description_example; // String | 模板描述
final UploadTemplate1Request uploadTemplate1Request = ; // UploadTemplate1Request | 

try {
    final response = api.uploadTemplate1(name, description, uploadTemplate1Request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->uploadTemplate1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**| 模板名称 | 
 **description** | **String**| 模板描述 | [optional] 
 **uploadTemplate1Request** | [**UploadTemplate1Request**](UploadTemplate1Request.md)|  | [optional] 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userLogin**
> BaseResponseLoginUserResponse userLogin(userLoginRequest)

用户登录

用户登录并获取 JWT Token

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final UserLoginRequest userLoginRequest = ; // UserLoginRequest | 

try {
    final response = api.userLogin(userLoginRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->userLogin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userLoginRequest** | [**UserLoginRequest**](UserLoginRequest.md)|  | 

### Return type

[**BaseResponseLoginUserResponse**](BaseResponseLoginUserResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userRegister**
> BaseResponseLong userRegister(userRegisterRequest)

用户注册

新用户注册接口，需先获取短信验证码

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final UserRegisterRequest userRegisterRequest = ; // UserRegisterRequest | 

try {
    final response = api.userRegister(userRegisterRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->userRegister: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userRegisterRequest** | [**UserRegisterRequest**](UserRegisterRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **validate**
> BaseResponseWorkflowValidationResponse validate(id)

验证工作流定义

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID

try {
    final response = api.validate(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->validate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 工作流ID | 

### Return type

[**BaseResponseWorkflowValidationResponse**](BaseResponseWorkflowValidationResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **wechatCallback**
> String wechatCallback(body)

微信支付异步回调（预留）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String body = body_example; // String | 

try {
    final response = api.wechatCallback(body);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->wechatCallback: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | **String**|  | 

### Return type

**String**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

