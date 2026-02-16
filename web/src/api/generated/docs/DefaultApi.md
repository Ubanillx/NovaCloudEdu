# DefaultApi

All URIs are relative to *http://localhost:8080*

|Method | HTTP request | Description|
|------------- | ------------- | -------------|
|[**_delete**](#_delete) | **DELETE** /api/workflows/{id} | 删除工作流|
|[**activateSetting**](#activatesetting) | **POST** /api/schedule/setting/{id}/activate | 激活课表配置|
|[**addComment**](#addcomment) | **POST** /api/user/daily-article/{articleId}/comment | 添加评论|
|[**addCourse**](#addcourse) | **POST** /api/classes/{classId}/courses | 添加课程|
|[**addEdge**](#addedge) | **POST** /api/workflows/{id}/edges | 添加连接线|
|[**addItem**](#additem) | **POST** /api/schedule/item | 添加课程项|
|[**addMember**](#addmember) | **POST** /api/classes/{classId}/members | 添加成员|
|[**addNode**](#addnode) | **POST** /api/workflows/{id}/nodes | 添加节点|
|[**addQuestionToSection**](#addquestiontosection) | **POST** /api/exam-papers/{paperId}/sections/{sectionId}/questions | 向大题添加题目|
|[**addSection**](#addsection) | **POST** /api/exam-papers/{paperId}/sections | 添加大题|
|[**addToShelf**](#addtoshelf) | **POST** /api/reading/shelf | 添加书籍到书架|
|[**addToWordBook**](#addtowordbook) | **POST** /api/user/word-book/add/{wordId} | 添加单词到生词本|
|[**addVariable**](#addvariable) | **POST** /api/workflows/{id}/variables | 添加变量|
|[**adminDeletePost**](#admindeletepost) | **DELETE** /api/posts/admin/{postId} | 管理员删除帖子|
|[**aiGenerateQuestions**](#aigeneratequestions) | **POST** /api/questions/ai-generate | AI 智能出题|
|[**applyTeacher**](#applyteacher) | **POST** /api/teacher/apply | 申请成为讲师|
|[**applyToJoin**](#applytojoin) | **POST** /api/groups/{groupId}/join | 申请加入群|
|[**archive**](#archive) | **POST** /api/workflows/{id}/archive | 归档工作流|
|[**batchBanUsers**](#batchbanusers) | **POST** /api/user/admin/ban | 批量封禁/解封用户|
|[**batchCreateUsers**](#batchcreateusers) | **POST** /api/user/admin/batch-create | 批量创建用户|
|[**batchSyncAll**](#batchsyncall) | **POST** /api/dailylearning/graph-sync/all/batch | 批量同步所有数据到知识图谱（高效批量导入）|
|[**batchSyncArticles**](#batchsyncarticles) | **POST** /api/dailylearning/graph-sync/articles/batch | 批量同步每日文章到知识图谱（高效批量导入）|
|[**batchSyncWords**](#batchsyncwords) | **POST** /api/dailylearning/graph-sync/words/batch | 批量同步每日单词到知识图谱（高效批量导入）|
|[**batchUpdate**](#batchupdate) | **POST** /api/workflows/{id}/batch-update | 批量更新节点和连接线|
|[**bindToAssistant**](#bindtoassistant) | **POST** /api/workflows/{id}/assistants/{assistantId} | 绑定工作流到AI助手|
|[**cancelExecution**](#cancelexecution) | **POST** /api/workflows/executions/{executionId}/cancel | 取消执行|
|[**changePassword**](#changepassword) | **POST** /api/user/password | 修改密码|
|[**checkFavourite**](#checkfavourite) | **GET** /api/course/favourite/{courseId}/check | 检查是否已收藏|
|[**checkFriendship**](#checkfriendship) | **GET** /api/friend/check/{userId} | 检查好友关系|
|[**checkin**](#checkin) | **POST** /api/user/checkin | 用户打卡|
|[**completeSection**](#completesection) | **POST** /api/progress/section/{sectionId}/complete | 标记小节为已完成|
|[**confirmPayment**](#confirmpayment) | **POST** /api/admin/order/confirm | 确认收款（管理员手动确认）|
|[**copy**](#copy) | **POST** /api/workflows/{id}/copy | 复制工作流|
|[**create**](#create) | **POST** /api/workflows | 创建工作流|
|[**createAnnouncement**](#createannouncement) | **POST** /api/announcement/admin/create | 创建公告|
|[**createBanner**](#createbanner) | **POST** /api/admin/banner | 创建轮播图|
|[**createChapter**](#createchapter) | **POST** /api/course/{courseId}/chapter | 创建章节（管理员）|
|[**createClass**](#createclass) | **POST** /api/classes | 创建班级|
|[**createComment**](#createcomment) | **POST** /api/posts/{postId}/comments | 发表评论|
|[**createConfig**](#createconfig) | **POST** /api/admin/scraper/config | 创建抓取配置|
|[**createCourse**](#createcourse) | **POST** /api/course | 创建课程（管理员）|
|[**createDailyArticle**](#createdailyarticle) | **POST** /api/daily-article | 创建每日文章（管理员）|
|[**createDailyWord**](#createdailyword) | **POST** /api/daily-word | 创建每日单词（管理员）|
|[**createExamPaper**](#createexampaper) | **POST** /api/exam-papers | 创建试卷|
|[**createFeedback**](#createfeedback) | **POST** /api/feedback | 创建反馈|
|[**createFromTemplate**](#createfromtemplate) | **POST** /api/workflows/templates/{templateId}/create-workflow | 从模板创建工作流|
|[**createGroup**](#creategroup) | **POST** /api/groups | 创建群聊|
|[**createGroupFromClass**](#creategroupfromclass) | **POST** /api/classes/{classId}/chat-group | 基于班级创建群聊|
|[**createOrder**](#createorder) | **POST** /api/order | 创建订单（用户下单）|
|[**createPost**](#createpost) | **POST** /api/posts | 发布帖子|
|[**createQuestion**](#createquestion) | **POST** /api/questions | 创建题目|
|[**createReply**](#createreply) | **POST** /api/posts/comments/{commentId}/replies | 发表回复|
|[**createScheduleTrigger**](#createscheduletrigger) | **POST** /api/workflows/{id}/triggers/schedule | 创建定时触发器|
|[**createSection**](#createsection) | **POST** /api/course/{courseId}/section | 创建小节（管理员）|
|[**createSetting**](#createsetting) | **POST** /api/schedule/setting | 创建课表配置|
|[**createTemplate**](#createtemplate) | **POST** /api/workflows/templates/from-workflow/{workflowId} | 从工作流创建模板|
|[**createUser**](#createuser) | **POST** /api/user/admin/create | 创建用户|
|[**createVersionSnapshot**](#createversionsnapshot) | **POST** /api/workflows/{id}/versions | 创建版本快照（发布时）|
|[**createWebhookTrigger**](#createwebhooktrigger) | **POST** /api/workflows/{id}/triggers/webhook | 创建Webhook触发器|
|[**deleteAnnouncement**](#deleteannouncement) | **DELETE** /api/announcement/admin/delete/{id} | 删除公告|
|[**deleteBanner**](#deletebanner) | **DELETE** /api/admin/banner/{id} | 删除轮播图|
|[**deleteBook**](#deletebook) | **DELETE** /api/books/{bookId} | 删除书籍|
|[**deleteChapter**](#deletechapter) | **DELETE** /api/course/{courseId}/chapter/{chapterId} | 删除章节（管理员）|
|[**deleteClass**](#deleteclass) | **DELETE** /api/classes/{classId} | 删除班级|
|[**deleteComment**](#deletecomment) | **DELETE** /api/posts/comments/{commentId} | 删除评论|
|[**deleteConfig**](#deleteconfig) | **DELETE** /api/admin/scraper/config/{id} | 删除配置|
|[**deleteCourse**](#deletecourse) | **DELETE** /api/course/{id} | 删除课程（管理员）|
|[**deleteDailyArticle**](#deletedailyarticle) | **DELETE** /api/daily-article/{id} | 删除每日文章（管理员）|
|[**deleteDailyWord**](#deletedailyword) | **DELETE** /api/daily-word/{id} | 删除每日单词（管理员）|
|[**deleteEdge**](#deleteedge) | **DELETE** /api/workflows/{id}/edges/{edgeId} | 删除连接线|
|[**deleteExamPaper**](#deleteexampaper) | **DELETE** /api/exam-papers/{id} | 删除试卷|
|[**deleteFeedback**](#deletefeedback) | **DELETE** /api/feedback/{id} | 删除反馈|
|[**deleteFeedback1**](#deletefeedback1) | **DELETE** /api/feedback/admin/{id} | 删除反馈|
|[**deleteFile**](#deletefile) | **DELETE** /api/file/{fileId} | 删除文件|
|[**deleteFriend**](#deletefriend) | **DELETE** /api/friend/{friendId} | 删除好友|
|[**deleteItem**](#deleteitem) | **DELETE** /api/schedule/item/{id} | 删除课程项|
|[**deleteMessage**](#deletemessage) | **DELETE** /api/group-chat/{groupId}/messages/{messageId} | 删除消息|
|[**deleteNode**](#deletenode) | **DELETE** /api/workflows/{id}/nodes/{nodeId} | 删除节点|
|[**deletePost**](#deletepost) | **DELETE** /api/posts/{postId} | 删除帖子|
|[**deleteQuestion**](#deletequestion) | **DELETE** /api/questions/{id} | 删除题目|
|[**deleteReply**](#deletereply) | **DELETE** /api/posts/replies/{replyId} | 删除回复|
|[**deleteSection**](#deletesection) | **DELETE** /api/exam-papers/{paperId}/sections/{sectionId} | 删除大题|
|[**deleteSection1**](#deletesection1) | **DELETE** /api/course/{courseId}/section/{sectionId} | 删除小节（管理员）|
|[**deleteTemplate**](#deletetemplate) | **DELETE** /api/workflows/templates/{templateId} | 删除模板|
|[**deleteTemplate2**](#deletetemplate2) | **DELETE** /api/exam-templates/{id} | 删除模板|
|[**deleteTrigger**](#deletetrigger) | **DELETE** /api/workflows/triggers/{triggerId} | 删除触发器|
|[**deleteVariable**](#deletevariable) | **DELETE** /api/workflows/{id}/variables/{variableName} | 删除变量|
|[**disableConfig**](#disableconfig) | **POST** /api/admin/scraper/config/{id}/disable | 禁用配置|
|[**disableTrigger**](#disabletrigger) | **POST** /api/workflows/triggers/{triggerId}/disable | 禁用触发器|
|[**dissolveGroup**](#dissolvegroup) | **DELETE** /api/groups/{groupId} | 解散群|
|[**dissolveGroup1**](#dissolvegroup1) | **DELETE** /api/admin/groups/{groupId} | 解散群|
|[**enableConfig**](#enableconfig) | **POST** /api/admin/scraper/config/{id}/enable | 启用配置|
|[**enableTrigger**](#enabletrigger) | **POST** /api/workflows/triggers/{triggerId}/enable | 启用触发器|
|[**encryptChapterContent**](#encryptchaptercontent) | **POST** /api/books/{bookId}/chapters/{chapterIndex}/encrypt | 加密章节内容|
|[**execute**](#execute) | **POST** /api/workflows/{id}/execute | 执行工作流|
|[**executeAllTasks**](#executealltasks) | **POST** /api/admin/scraper/config/execute-all | 触发所有抓取|
|[**executeAsync**](#executeasync) | **POST** /api/workflows/{id}/execute-async | 异步执行工作流|
|[**executeTask**](#executetask) | **POST** /api/admin/scraper/config/execute | 执行抓取任务|
|[**exportAnswerKey**](#exportanswerkey) | **POST** /api/exam-papers/{id}/export-answer-key | 导出参考答案PDF|
|[**favouriteCourse**](#favouritecourse) | **POST** /api/course/favourite/{courseId} | 收藏课程|
|[**follow**](#follow) | **POST** /api/follow/{targetUserId} | 关注用户|
|[**generateBannerImage**](#generatebannerimage) | **POST** /api/admin/banner/generate-image | AI生成轮播图图片|
|[**getAllConfigs**](#getallconfigs) | **GET** /api/admin/scraper/config | 获取所有配置|
|[**getAllFriends**](#getallfriends) | **GET** /api/friend/all | 获取全部好友|
|[**getAllTasks**](#getalltasks) | **GET** /api/admin/scraper/config/tasks | 获取所有任务|
|[**getAnnouncement**](#getannouncement) | **GET** /api/announcement/admin/{id} | 获取公告详情|
|[**getAnnouncementDetail**](#getannouncementdetail) | **GET** /api/announcement/{id} | 获取公告详情|
|[**getAnnouncementList**](#getannouncementlist) | **GET** /api/announcement/list | 获取公告列表|
|[**getApplication**](#getapplication) | **GET** /api/teacher/application/{id} | 获取申请详情|
|[**getArticlesByDate**](#getarticlesbydate) | **GET** /api/daily-article/date/{date} | 获取指定日期文章|
|[**getBannerDetail**](#getbannerdetail) | **GET** /api/admin/banner/{id} | 获取轮播图详情|
|[**getBannerList**](#getbannerlist) | **GET** /api/banner/list | 获取轮播图列表|
|[**getBook**](#getbook) | **GET** /api/books/{bookId} | 获取书籍详情|
|[**getBookChapters**](#getbookchapters) | **GET** /api/books/{bookId}/chapters | 获取书籍章节列表|
|[**getById**](#getbyid) | **GET** /api/workflows/{id} | 获取工作流详情|
|[**getChapter**](#getchapter) | **GET** /api/course/{courseId}/chapter/{chapterId} | 获取章节详情|
|[**getChapterContent**](#getchaptercontent) | **GET** /api/books/{bookId}/chapters/{chapterIndex} | 获取章节内容|
|[**getChatHistory**](#getchathistory) | **POST** /api/chat/history | 获取聊天历史|
|[**getCheckinRanking**](#getcheckinranking) | **GET** /api/user/checkin/ranking | 打卡排行榜|
|[**getCheckinStatus**](#getcheckinstatus) | **GET** /api/user/checkin/status | 获取打卡状态|
|[**getClassInfo**](#getclassinfo) | **GET** /api/classes/{classId} | 获取班级详情|
|[**getClassMembers**](#getclassmembers) | **GET** /api/classes/{classId}/members | 获取班级成员列表|
|[**getCollectedArticles**](#getcollectedarticles) | **GET** /api/user/daily-article/collected | 获取收藏文章列表|
|[**getCollectedWords**](#getcollectedwords) | **GET** /api/user/daily-word/collected | 获取收藏单词列表|
|[**getCommentReplies**](#getcommentreplies) | **GET** /api/posts/comments/{commentId}/replies | 获取评论回复列表|
|[**getConfig**](#getconfig) | **GET** /api/admin/scraper/config/{id} | 获取配置详情|
|[**getConfigsByPage**](#getconfigsbypage) | **GET** /api/admin/scraper/config/page | 分页获取配置|
|[**getCourse**](#getcourse) | **GET** /api/course/{id} | 获取课程详情|
|[**getCourseProgress**](#getcourseprogress) | **GET** /api/progress/course/{courseId} | 获取课程所有小节的学习进度|
|[**getCourseProgressSummary**](#getcourseprogresssummary) | **GET** /api/progress/course/{courseId}/summary | 获取课程进度汇总|
|[**getCourseStructure**](#getcoursestructure) | **GET** /api/course/{courseId}/structure | 获取课程完整结构（课程+章节+小节）|
|[**getDailyArticle**](#getdailyarticle) | **GET** /api/daily-article/{id} | 获取文章详情|
|[**getDailyWord**](#getdailyword) | **GET** /api/daily-word/{id} | 获取单词详情|
|[**getDefinition**](#getdefinition) | **GET** /api/workflows/{id}/definition | 获取工作流定义详情|
|[**getEdges**](#getedges) | **GET** /api/workflows/{id}/edges | 获取工作流所有连接线|
|[**getExamPaper**](#getexampaper) | **GET** /api/exam-papers/{id} | 获取试卷详情|
|[**getExecutionLogs**](#getexecutionlogs) | **GET** /api/workflows/executions/{executionId}/logs | 获取执行日志|
|[**getExecutionStatistics**](#getexecutionstatistics) | **GET** /api/workflows/{id}/execution-statistics | 获取工作流执行统计|
|[**getExecutionStatus**](#getexecutionstatus) | **GET** /api/workflows/executions/{executionId} | 获取执行状态|
|[**getFavouriteCount**](#getfavouritecount) | **GET** /api/course/favourite/{courseId}/count | 获取课程收藏数|
|[**getFeedbackDetail**](#getfeedbackdetail) | **GET** /api/feedback/{id} | 获取反馈详情|
|[**getFeedbackDetail1**](#getfeedbackdetail1) | **GET** /api/feedback/admin/{id} | 获取反馈详情|
|[**getFeedbackReplies**](#getfeedbackreplies) | **GET** /api/feedback/{id}/replies | 获取反馈回复列表|
|[**getFeedbackReplies1**](#getfeedbackreplies1) | **GET** /api/feedback/admin/{id}/replies | 获取反馈回复列表|
|[**getFilesByBusinessType**](#getfilesbybusinesstype) | **GET** /api/file/business-type/{businessType} | 按业务类型获取文件列表（管理员）|
|[**getFollowingPosts**](#getfollowingposts) | **GET** /api/posts/following | 获取关注用户的帖子列表|
|[**getFriendList**](#getfriendlist) | **POST** /api/friend/list | 获取好友列表|
|[**getGroupInfo**](#getgroupinfo) | **GET** /api/groups/{groupId} | 获取群详情|
|[**getGroupInfo1**](#getgroupinfo1) | **GET** /api/admin/groups/{groupId} | 获取群详情|
|[**getGroupMembers**](#getgroupmembers) | **GET** /api/groups/{groupId}/members | 获取群成员列表|
|[**getGroupMembers1**](#getgroupmembers1) | **GET** /api/admin/groups/{groupId}/members | 分页获取群成员|
|[**getGroupMembersPage**](#getgroupmemberspage) | **GET** /api/groups/{groupId}/members/page | 分页获取群成员|
|[**getKey**](#getkey) | **GET** /api/video/key | 获取视频解密密钥（HLS播放器自动调用）|
|[**getLatestMessages**](#getlatestmessages) | **GET** /api/group-chat/{groupId}/messages/latest | 获取群最新消息|
|[**getLikedArticles**](#getlikedarticles) | **GET** /api/user/daily-article/liked | 获取点赞文章列表|
|[**getLoginUser**](#getloginuser) | **GET** /api/auth/current | 获取当前用户|
|[**getMessages**](#getmessages) | **GET** /api/group-chat/{groupId}/messages | 获取群聊历史消息（分页）|
|[**getMessagesBefore**](#getmessagesbefore) | **GET** /api/group-chat/{groupId}/messages/before | 获取群聊历史消息（游标分页，获取某消息之前的消息）|
|[**getMyApplication**](#getmyapplication) | **GET** /api/teacher/application/my | 获取当前用户的申请|
|[**getMyFavourites**](#getmyfavourites) | **GET** /api/posts/favourites | 获取我收藏的帖子|
|[**getMyFavourites1**](#getmyfavourites1) | **GET** /api/course/favourite/my | 获取我的收藏列表|
|[**getMyFeedbacks**](#getmyfeedbacks) | **GET** /api/feedback/my | 获取我的反馈列表|
|[**getMyFiles**](#getmyfiles) | **GET** /api/file/my | 获取我的文件列表|
|[**getMyFollowStats**](#getmyfollowstats) | **GET** /api/follow/stats | 获取我的关注统计|
|[**getMyFollowers**](#getmyfollowers) | **GET** /api/follow/followers | 获取我的粉丝列表|
|[**getMyFollowings**](#getmyfollowings) | **GET** /api/follow/followings | 获取我的关注列表|
|[**getMyGroups**](#getmygroups) | **GET** /api/groups/my | 获取我加入的群列表|
|[**getMyOrders**](#getmyorders) | **GET** /api/order/my | 获取我的订单列表|
|[**getMyPosts**](#getmyposts) | **GET** /api/posts/my | 获取我的帖子列表|
|[**getMyReview**](#getmyreview) | **GET** /api/course/review/{courseId}/my | 获取我对该课程的评价|
|[**getMySchedule**](#getmyschedule) | **GET** /api/schedule/my | 获取我的课表|
|[**getMyTeacher**](#getmyteacher) | **GET** /api/teacher/my | 获取当前用户的讲师信息|
|[**getNode**](#getnode) | **GET** /api/workflows/{id}/nodes/{nodeId} | 获取单个节点详情|
|[**getNodeTypes**](#getnodetypes) | **GET** /api/workflows/node-types | 获取所有可用的节点类型|
|[**getNodes**](#getnodes) | **GET** /api/workflows/{id}/nodes | 获取工作流所有节点|
|[**getOrder**](#getorder) | **GET** /api/order/{orderNo} | 查询订单详情|
|[**getPaperQuestions**](#getpaperquestions) | **GET** /api/exam-papers/{paperId}/sections/{sectionId}/questions | 获取大题下的所有题目关联|
|[**getPendingCount**](#getpendingcount) | **GET** /api/teacher/application/pending/count | 获取待审核申请数量（管理员）|
|[**getPendingRequests**](#getpendingrequests) | **GET** /api/groups/{groupId}/requests | 获取群待审批申请列表|
|[**getPostComments**](#getpostcomments) | **GET** /api/posts/{postId}/comments | 获取帖子评论列表|
|[**getPostDetail**](#getpostdetail) | **GET** /api/posts/{postId} | 获取帖子详情|
|[**getPostList**](#getpostlist) | **GET** /api/posts | 分页获取帖子列表|
|[**getPostListByType**](#getpostlistbytype) | **GET** /api/posts/type/{postType} | 根据类型获取帖子列表|
|[**getQuestion**](#getquestion) | **GET** /api/questions/{id} | 获取题目详情|
|[**getReadArticles**](#getreadarticles) | **GET** /api/user/daily-article/read | 获取已阅读文章列表|
|[**getReadCount**](#getreadcount) | **GET** /api/group-chat/messages/{messageId}/read-count | 获取消息已读人数|
|[**getReadUsers**](#getreadusers) | **GET** /api/group-chat/messages/{messageId}/read-users | 获取消息已读用户列表（含昵称头像）|
|[**getReceivedRequests**](#getreceivedrequests) | **POST** /api/friend/request/received | 获取收到的好友申请|
|[**getReviewCount**](#getreviewcount) | **GET** /api/course/review/{courseId}/count | 获取课程评价数|
|[**getScheduleBySetting**](#getschedulebysetting) | **GET** /api/schedule/setting/{settingId} | 获取特定配置的课表|
|[**getSection**](#getsection) | **GET** /api/course/{courseId}/section/{sectionId} | 获取小节详情|
|[**getSectionProgress**](#getsectionprogress) | **GET** /api/progress/section/{sectionId} | 获取小节学习进度|
|[**getSections**](#getsections) | **GET** /api/exam-papers/{paperId}/sections | 获取试卷的所有大题|
|[**getSentRequests**](#getsentrequests) | **POST** /api/friend/request/sent | 获取发送的好友申请|
|[**getSessionList**](#getsessionlist) | **GET** /api/chat/sessions | 获取会话列表|
|[**getStatistics**](#getstatistics) | **GET** /api/admin/order/statistics | 订单统计（管理员）|
|[**getStats**](#getstats) | **GET** /api/user/word-book/stats | 获取生词本统计|
|[**getStats1**](#getstats1) | **GET** /api/user/daily-word/stats | 获取学习统计|
|[**getStats2**](#getstats2) | **GET** /api/user/daily-article/stats | 获取阅读统计|
|[**getStudiedWords**](#getstudiedwords) | **GET** /api/user/daily-word/studied | 获取已学习单词列表|
|[**getSupportedSources**](#getsupportedsources) | **GET** /api/scraper/sources | 获取预设来源列表|
|[**getSupportedVoices**](#getsupportedvoices) | **GET** /api/speech/tts/voices | 获取支持的发音人列表|
|[**getTableColumns**](#gettablecolumns) | **GET** /api/workflows/database/tables/{tableName}/columns | 获取指定表的字段信息|
|[**getTask**](#gettask) | **GET** /api/admin/scraper/config/task/{taskId} | 获取任务详情|
|[**getTasksByConfig**](#gettasksbyconfig) | **GET** /api/admin/scraper/config/{configId}/tasks | 获取配置的任务列表|
|[**getTeacher**](#getteacher) | **GET** /api/teacher/{id} | 获取讲师信息|
|[**getTeacherByUserId**](#getteacherbyuserid) | **GET** /api/teacher/user/{userId} | 根据用户ID获取讲师信息|
|[**getTemplate**](#gettemplate) | **GET** /api/workflows/templates/{templateId} | 获取模板详情|
|[**getTemplate1**](#gettemplate1) | **GET** /api/exam-templates/{id} | 获取模板详情|
|[**getTodayArticles**](#gettodayarticles) | **GET** /api/daily-article/today | 获取今日推荐文章（个性化推荐）|
|[**getTodayWords**](#gettodaywords) | **GET** /api/daily-word/today | 获取今日推荐单词（个性化推荐）|
|[**getTopPosts**](#gettopposts) | **GET** /api/posts/top | 获取点赞排行榜（全部时间）|
|[**getTopPostsByDays**](#gettoppostsbydays) | **GET** /api/posts/top/days | 获取点赞排行榜（指定天数内）|
|[**getUnreadCount**](#getunreadcount) | **GET** /api/group-chat/{groupId}/unread/count | 获取群未读消息数|
|[**getUnreadCount1**](#getunreadcount1) | **GET** /api/chat/unread/count | 获取未读消息数|
|[**getUnreadCount2**](#getunreadcount2) | **GET** /api/announcement/unread-count | 获取未读公告数量|
|[**getUserDetail**](#getuserdetail) | **GET** /api/user/admin/{id} | 获取用户详情|
|[**getUserDetailInfo**](#getuserdetailinfo) | **GET** /api/user/detail/{id} | 获取用户详细信息|
|[**getUserFollowStats**](#getuserfollowstats) | **GET** /api/follow/user/{targetUserId}/stats | 获取指定用户的关注统计|
|[**getUserFollowers**](#getuserfollowers) | **GET** /api/follow/user/{targetUserId}/followers | 获取指定用户的粉丝列表|
|[**getUserFollowings**](#getuserfollowings) | **GET** /api/follow/user/{targetUserId}/followings | 获取指定用户的关注列表|
|[**getUserPosts**](#getuserposts) | **GET** /api/posts/user/{targetUserId} | 获取指定用户的帖子列表|
|[**getUserPublicInfo**](#getuserpublicinfo) | **GET** /api/user/public/{id} | 获取用户公开信息|
|[**getUserShelf**](#getusershelf) | **GET** /api/reading/shelf/{userId} | 获取用户书架|
|[**getUserStats**](#getuserstats) | **GET** /api/user/stats | 获取用户统计数据|
|[**getVariables**](#getvariables) | **GET** /api/workflows/{id}/variables | 获取工作流所有变量|
|[**getVersion**](#getversion) | **GET** /api/workflows/{id}/versions/{versionNumber} | 获取指定版本详情|
|[**getWordBookList**](#getwordbooklist) | **GET** /api/user/word-book/list | 获取生词本列表|
|[**getWordsByDate**](#getwordsbydate) | **GET** /api/daily-word/date/{date} | 获取指定日期单词|
|[**getWorkflowAssistants**](#getworkflowassistants) | **GET** /api/workflows/{id}/assistants | 获取使用该工作流的AI助手ID列表|
|[**handleFriendRequest**](#handlefriendrequest) | **POST** /api/friend/request/handle | 处理好友申请|
|[**handleJoinRequest**](#handlejoinrequest) | **POST** /api/groups/requests/{requestId}/handle | 处理加入申请|
|[**health**](#health) | **GET** /api/health | 健康检查|
|[**inviteMember**](#invitemember) | **POST** /api/groups/{groupId}/invite | 邀请用户加入群|
|[**isFollowing**](#isfollowing) | **GET** /api/follow/check/{targetUserId} | 检查是否已关注|
|[**kbAddDocument**](#kbadddocument) | **POST** /api/ai/knowledge-bases/{id}/documents | 添加文档|
|[**kbBatchProcessByKnowledgeBase**](#kbbatchprocessbyknowledgebase) | **POST** /api/ai/knowledge-bases/{id}/embed-all | 向量化知识库所有待处理文档|
|[**kbBatchProcessDocuments**](#kbbatchprocessdocuments) | **POST** /api/ai/knowledge-bases/{id}/documents/batch-embed | 批量文档向量化|
|[**kbBatchProcessDocumentsAsync**](#kbbatchprocessdocumentsasync) | **POST** /api/ai/knowledge-bases/{id}/documents/batch-embed-async | 异步批量文档向量化|
|[**kbCreate**](#kbcreate) | **POST** /api/ai/knowledge-bases | 创建知识库|
|[**kbDelete**](#kbdelete) | **DELETE** /api/ai/knowledge-bases/{id} | 删除知识库|
|[**kbDeleteDocument**](#kbdeletedocument) | **DELETE** /api/ai/knowledge-bases/{id}/documents/{docId} | 删除文档|
|[**kbGetById**](#kbgetbyid) | **GET** /api/ai/knowledge-bases/{id} | 获取知识库详情|
|[**kbListByCreator**](#kblistbycreator) | **GET** /api/ai/knowledge-bases | 获取用户的知识库列表|
|[**kbListChunks**](#kblistchunks) | **GET** /api/ai/knowledge-bases/{id}/documents/{docId}/chunks | 获取文档分块列表|
|[**kbListDocuments**](#kblistdocuments) | **GET** /api/ai/knowledge-bases/{id}/documents | 获取文档列表|
|[**kbProcessDocument**](#kbprocessdocument) | **POST** /api/ai/knowledge-bases/{id}/documents/{docId}/embed | 触发文档向量化|
|[**kbRecallTest**](#kbrecalltest) | **POST** /api/ai/knowledge-bases/{id}/recall-test | 知识库召回测试|
|[**kbSearch**](#kbsearch) | **GET** /api/ai/knowledge-bases/search | 搜索知识库|
|[**kbUpdate**](#kbupdate) | **PUT** /api/ai/knowledge-bases/{id} | 更新知识库|
|[**kbUpdateDocument**](#kbupdatedocument) | **PUT** /api/ai/knowledge-bases/{id}/documents/{docId} | 更新文档元信息|
|[**leaveGroup**](#leavegroup) | **POST** /api/groups/{groupId}/leave | 退出群|
|[**listAllTemplates**](#listalltemplates) | **GET** /api/exam-templates/all | 列出所有模板（管理员）|
|[**listAllowedTables**](#listallowedtables) | **GET** /api/workflows/database/tables | 获取可查询的数据库表列表|
|[**listApplications**](#listapplications) | **GET** /api/teacher/application/list | 获取申请列表（管理员）|
|[**listArticles**](#listarticles) | **GET** /api/daily-article/list | 获取文章列表|
|[**listAvailableModels**](#listavailablemodels) | **GET** /api/workflows/models | 获取可用模型列表|
|[**listBooks**](#listbooks) | **GET** /api/books | 获取书籍列表|
|[**listByUser**](#listbyuser) | **GET** /api/workflows | 获取用户的工作流列表|
|[**listChapters**](#listchapters) | **GET** /api/course/{courseId}/chapter | 获取课程的章节列表|
|[**listClasses**](#listclasses) | **GET** /api/classes/list | 获取班级列表|
|[**listCourses**](#listcourses) | **GET** /api/course/list | 获取课程列表|
|[**listCoursesByTeacher**](#listcoursesbyteacher) | **GET** /api/course/teacher/{teacherId} | 获取讲师的课程列表|
|[**listExecutions**](#listexecutions) | **GET** /api/workflows/{id}/executions | 获取工作流执行历史列表|
|[**listGroups**](#listgroups) | **GET** /api/admin/groups/list | 分页获取群列表|
|[**listOrders**](#listorders) | **GET** /api/admin/order/list | 获取订单列表（管理员）|
|[**listPublic**](#listpublic) | **GET** /api/workflows/public | 获取公开的工作流列表|
|[**listReviews**](#listreviews) | **GET** /api/course/review/{courseId}/list | 获取课程评价列表|
|[**listSections**](#listsections) | **GET** /api/course/{courseId}/section | 获取课程的所有小节|
|[**listSystemTemplates**](#listsystemtemplates) | **GET** /api/workflows/templates/system | 获取系统预置模板|
|[**listTeachers**](#listteachers) | **GET** /api/teacher/list | 获取讲师列表|
|[**listTemplates1**](#listtemplates1) | **GET** /api/exam-templates | 列出所有可用模板|
|[**listTriggers**](#listtriggers) | **GET** /api/workflows/{id}/triggers | 获取工作流触发器列表|
|[**listVersions**](#listversions) | **GET** /api/workflows/{id}/versions | 获取工作流版本列表|
|[**listWords**](#listwords) | **GET** /api/daily-word/list | 获取单词列表|
|[**markAsRead**](#markasread) | **POST** /api/user/daily-article/{articleId}/read | 标记文章为已阅读|
|[**markAsRead1**](#markasread1) | **POST** /api/group-chat/{groupId}/messages/{messageId}/read | 标记消息已读|
|[**markAsRead2**](#markasread2) | **POST** /api/chat/read/{senderId} | 标记消息已读|
|[**markAsRead3**](#markasread3) | **POST** /api/announcement/{id}/read | 标记公告已读|
|[**markRepliesAsRead**](#markrepliesasread) | **POST** /api/feedback/{id}/read | 标记回复为已读|
|[**offlineAnnouncement**](#offlineannouncement) | **POST** /api/announcement/admin/offline/{id} | 下线公告|
|[**offlineBanner**](#offlinebanner) | **POST** /api/admin/banner/{id}/offline | 下线轮播图|
|[**phoneLogin**](#phonelogin) | **POST** /api/auth/login/phone | 手机验证码登录|
|[**previewPdf**](#previewpdf) | **POST** /api/exam-papers/{id}/preview | 预览试卷PDF|
|[**previewTemplate**](#previewtemplate) | **POST** /api/exam-templates/{id}/preview | 预览模板效果（用示例数据编译PDF）|
|[**publish**](#publish) | **POST** /api/workflows/{id}/publish | 发布工作流|
|[**publishAnnouncement**](#publishannouncement) | **PUT** /api/groups/{groupId}/announcement | 发布群公告|
|[**publishAnnouncement1**](#publishannouncement1) | **POST** /api/announcement/admin/publish/{id} | 发布公告|
|[**publishBanner**](#publishbanner) | **POST** /api/admin/banner/{id}/publish | 发布轮播图|
|[**publishCourse**](#publishcourse) | **POST** /api/course/{id}/publish | 发布课程（管理员）|
|[**publishExamPaper**](#publishexampaper) | **POST** /api/exam-papers/{id}/publish | 发布试卷|
|[**queryAnnouncements**](#queryannouncements) | **POST** /api/announcement/admin/list | 分页查询公告|
|[**queryBanners**](#querybanners) | **GET** /api/admin/banner/list | 分页查询轮播图|
|[**queryExamPapers**](#queryexampapers) | **GET** /api/exam-papers | 分页查询我的试卷|
|[**queryFeedbacks**](#queryfeedbacks) | **POST** /api/feedback/admin/list | 分页查询反馈|
|[**queryMyQuestions**](#querymyquestions) | **GET** /api/questions/mine | 查询我的题目|
|[**queryQuestions**](#queryquestions) | **GET** /api/questions | 分页查询题目|
|[**queryUsers**](#queryusers) | **POST** /api/user/admin/list | 分页查询用户|
|[**quickDynamicScrape**](#quickdynamicscrape) | **GET** /api/scraper/dynamic/quick | 快速动态抓取|
|[**quickScrape**](#quickscrape) | **GET** /api/scraper/quick | 快速抓取|
|[**refreshToken**](#refreshtoken) | **POST** /api/auth/refresh | 刷新Token|
|[**refund**](#refund) | **POST** /api/admin/order/{orderNo}/refund | 退款（管理员）|
|[**removeCourse**](#removecourse) | **DELETE** /api/classes/{classId}/courses/{courseId} | 移除课程|
|[**removeFromShelf**](#removefromshelf) | **DELETE** /api/reading/shelf | 从书架移除书籍|
|[**removeFromWordBook**](#removefromwordbook) | **DELETE** /api/user/word-book/{wordBookId} | 从生词本移除单词|
|[**removeMember**](#removemember) | **DELETE** /api/groups/{groupId}/members/{targetUserId} | 移除成员|
|[**removeMember1**](#removemember1) | **DELETE** /api/classes/{classId}/members/{userId} | 移除成员|
|[**removeMember2**](#removemember2) | **DELETE** /api/admin/groups/{groupId}/members/{targetUserId} | 移除群成员|
|[**removePaperQuestion**](#removepaperquestion) | **DELETE** /api/exam-papers/{paperId}/sections/{sectionId}/questions/{pqId} | 从大题移除题目|
|[**removeTeacher**](#removeteacher) | **DELETE** /api/teacher/{id} | 移除讲师|
|[**replyFeedback**](#replyfeedback) | **POST** /api/feedback/reply | 回复反馈|
|[**replyFeedback1**](#replyfeedback1) | **POST** /api/feedback/admin/reply | 回复反馈|
|[**resetPassword**](#resetpassword) | **POST** /api/user/admin/reset-password | 重置用户密码|
|[**resetProgress**](#resetprogress) | **POST** /api/progress/section/{sectionId}/reset | 重置小节进度|
|[**reviewApplication**](#reviewapplication) | **POST** /api/teacher/application/review | 审核讲师申请（管理员）|
|[**reviewCourse**](#reviewcourse) | **POST** /api/course/review/{courseId} | 评价课程|
|[**rollbackToVersion**](#rollbacktoversion) | **POST** /api/workflows/{id}/versions/{versionNumber}/rollback | 回滚到指定版本|
|[**scrapeArticleLinks**](#scrapearticlelinks) | **POST** /api/scraper/links | 获取文章链接|
|[**scrapeDynamicArticleLinks**](#scrapedynamicarticlelinks) | **POST** /api/scraper/dynamic/links | 动态获取文章链接|
|[**scrapeDynamicMultiplePages**](#scrapedynamicmultiplepages) | **POST** /api/scraper/dynamic/batch | 批量动态抓取|
|[**scrapeDynamicPage**](#scrapedynamicpage) | **POST** /api/scraper/dynamic/single | 动态抓取单个页面|
|[**scrapeDynamicPageWithSelector**](#scrapedynamicpagewithselector) | **POST** /api/scraper/dynamic/wait-for | 动态抓取（等待元素）|
|[**scrapeDynamicRecursively**](#scrapedynamicrecursively) | **POST** /api/scraper/dynamic/recursive | 递归动态抓取|
|[**scrapeFromSource**](#scrapefromsource) | **POST** /api/scraper/source | 从预设来源抓取|
|[**scrapeMultiplePages**](#scrapemultiplepages) | **POST** /api/scraper/batch | 批量抓取|
|[**scrapeRecursively**](#scraperecursively) | **POST** /api/scraper/recursive | 递归抓取|
|[**scrapeSinglePage**](#scrapesinglepage) | **POST** /api/scraper/single | 抓取单个页面|
|[**searchArticles**](#searcharticles) | **GET** /api/daily-article/search | 搜索文章|
|[**searchBooks**](#searchbooks) | **GET** /api/books/search | 搜索书籍|
|[**searchCourses**](#searchcourses) | **GET** /api/course/search | 搜索课程|
|[**searchGroups**](#searchgroups) | **GET** /api/groups/search | 搜索群|
|[**searchGroups1**](#searchgroups1) | **GET** /api/admin/groups/search | 搜索群|
|[**searchPosts**](#searchposts) | **GET** /api/posts/search | 搜索帖子|
|[**searchPostsByTag**](#searchpostsbytag) | **GET** /api/posts/tag | 根据标签搜索帖子|
|[**searchTemplates**](#searchtemplates) | **GET** /api/workflows/templates | 搜索工作流模板|
|[**searchUsers**](#searchusers) | **POST** /api/friend/search | 搜索用户|
|[**searchWords**](#searchwords) | **GET** /api/daily-word/search | 搜索单词|
|[**sendFriendRequest**](#sendfriendrequest) | **POST** /api/friend/request/send | 发送好友申请|
|[**sendRegisterCode**](#sendregistercode) | **POST** /api/auth/send-code | 发送注册验证码|
|[**sendSms**](#sendsms) | **POST** /api/user/admin/send-sms | 发送短信验证码|
|[**setAdmin**](#setadmin) | **PUT** /api/groups/{groupId}/members/{targetUserId}/admin | 设置/取消管理员|
|[**setJoinMode**](#setjoinmode) | **PUT** /api/groups/{groupId}/join-mode | 设置群加入模式|
|[**setMute**](#setmute) | **POST** /api/admin/groups/{groupId}/mute | 设置群全员禁言|
|[**smartDynamicScrape**](#smartdynamicscrape) | **POST** /api/scraper/dynamic/smart | 智能动态抓取|
|[**smartScrape**](#smartscrape) | **POST** /api/scraper/smart | 智能抓取|
|[**studyWord**](#studyword) | **POST** /api/user/daily-word/{wordId}/study | 标记单词为已学习|
|[**takeOffline**](#takeoffline) | **POST** /api/course/{id}/offline | 下架课程（管理员）|
|[**textToSpeech**](#texttospeech) | **POST** /api/speech/tts | 文本转语音|
|[**textToSpeechBase64**](#texttospeechbase64) | **POST** /api/speech/tts/base64 | 文本转语音 (Base64)|
|[**toggleCollect**](#togglecollect) | **POST** /api/user/daily-word/{wordId}/collect | 收藏/取消收藏单词|
|[**toggleCollect1**](#togglecollect1) | **POST** /api/user/daily-article/{articleId}/collect | 收藏/取消收藏文章|
|[**toggleFavour**](#togglefavour) | **POST** /api/posts/{postId}/favour | 收藏/取消收藏帖子|
|[**toggleFollow**](#togglefollow) | **POST** /api/follow/{targetUserId}/toggle | 切换关注状态|
|[**toggleLike**](#togglelike) | **POST** /api/user/daily-article/{articleId}/like | 点赞/取消点赞文章|
|[**toggleThumb**](#togglethumb) | **POST** /api/posts/{postId}/thumb | 点赞/取消点赞帖子|
|[**transferOwnership**](#transferownership) | **POST** /api/groups/{groupId}/transfer | 转让群主|
|[**unbindFromAssistant**](#unbindfromassistant) | **DELETE** /api/workflows/{id}/assistants/{assistantId} | 解绑工作流与AI助手|
|[**unfavouriteCourse**](#unfavouritecourse) | **DELETE** /api/course/favourite/{courseId} | 取消收藏|
|[**unfollow**](#unfollow) | **DELETE** /api/follow/{targetUserId} | 取消关注|
|[**unpublishExamPaper**](#unpublishexampaper) | **POST** /api/exam-papers/{id}/unpublish | 撤回试卷为草稿|
|[**update**](#update) | **PUT** /api/workflows/{id} | 更新工作流基本信息|
|[**updateAnnouncement**](#updateannouncement) | **PUT** /api/announcement/admin/update | 更新公告|
|[**updateBanner**](#updatebanner) | **PUT** /api/admin/banner | 更新轮播图|
|[**updateChapter**](#updatechapter) | **PUT** /api/course/{courseId}/chapter/{chapterId} | 更新章节（管理员）|
|[**updateClass**](#updateclass) | **PUT** /api/classes/{classId} | 更新班级信息|
|[**updateConfig**](#updateconfig) | **PUT** /api/admin/scraper/config/{id} | 更新抓取配置|
|[**updateCourse**](#updatecourse) | **PUT** /api/course/{id} | 更新课程（管理员）|
|[**updateDailyArticle**](#updatedailyarticle) | **PUT** /api/daily-article/{id} | 更新每日文章（管理员）|
|[**updateDailyWord**](#updatedailyword) | **PUT** /api/daily-word/{id} | 更新每日单词（管理员）|
|[**updateDefinition**](#updatedefinition) | **PUT** /api/workflows/{id}/definition | 更新工作流定义|
|[**updateEdge**](#updateedge) | **PUT** /api/workflows/{id}/edges/{edgeId} | 更新连接线|
|[**updateExamPaper**](#updateexampaper) | **PUT** /api/exam-papers | 更新试卷基本信息|
|[**updateFeedbackStatus**](#updatefeedbackstatus) | **PUT** /api/feedback/admin/status | 更新反馈状态|
|[**updateGroupInfo**](#updategroupinfo) | **PUT** /api/groups/{groupId} | 更新群信息|
|[**updateGroupInfo1**](#updategroupinfo1) | **PUT** /api/admin/groups/{groupId} | 更新群信息|
|[**updateItem**](#updateitem) | **PUT** /api/schedule/item/{id} | 更新课程项|
|[**updateLearningStatus**](#updatelearningstatus) | **PUT** /api/user/word-book/{wordBookId}/status | 更新学习状态|
|[**updateMastery**](#updatemastery) | **POST** /api/user/daily-word/{wordId}/mastery | 更新单词掌握程度|
|[**updateNode**](#updatenode) | **PUT** /api/workflows/{id}/nodes/{nodeId} | 更新节点|
|[**updateNodeConfig**](#updatenodeconfig) | **PUT** /api/workflows/{id}/nodes/{nodeId}/config | 更新节点配置|
|[**updatePaperQuestion**](#updatepaperquestion) | **PUT** /api/exam-papers/{paperId}/sections/{sectionId}/questions/{pqId} | 更新试卷题目分值/排序|
|[**updatePost**](#updatepost) | **PUT** /api/posts/{postId} | 更新帖子|
|[**updateProfile**](#updateprofile) | **PUT** /api/user/profile | 更新个人资料|
|[**updateProgress**](#updateprogress) | **PUT** /api/reading/progress | 更新阅读进度|
|[**updateProgress1**](#updateprogress1) | **POST** /api/progress | 更新学习进度|
|[**updateQuestion**](#updatequestion) | **PUT** /api/questions | 更新题目|
|[**updateReview**](#updatereview) | **PUT** /api/course/review/{reviewId} | 更新评价|
|[**updateSection**](#updatesection) | **PUT** /api/exam-papers/{paperId}/sections/{sectionId} | 更新大题|
|[**updateSection1**](#updatesection1) | **PUT** /api/course/{courseId}/section/{sectionId} | 更新小节（管理员）|
|[**updateSetting**](#updatesetting) | **PUT** /api/schedule/setting/{id} | 更新课表配置|
|[**updateSettings**](#updatesettings) | **PUT** /api/workflows/{id}/settings | 更新工作流设置|
|[**updateTeacher**](#updateteacher) | **PUT** /api/teacher/{id} | 更新讲师信息|
|[**updateUser**](#updateuser) | **PUT** /api/user/admin/update | 更新用户|
|[**updateVariable**](#updatevariable) | **PUT** /api/workflows/{id}/variables/{variableName} | 更新变量|
|[**uploadBook**](#uploadbook) | **POST** /api/books/upload | 上传书籍|
|[**uploadTemplate1**](#uploadtemplate1) | **POST** /api/exam-templates | 上传试卷模板|
|[**userLogin**](#userlogin) | **POST** /api/auth/login | 用户登录|
|[**userRegister**](#userregister) | **POST** /api/auth/register | 用户注册|
|[**validate**](#validate) | **POST** /api/workflows/{id}/validate | 验证工作流定义|

# **_delete**
> BaseResponseVoid _delete()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)

const { status, data } = await apiInstance._delete(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **activateSetting**
> BaseResponseBoolean activateSetting()

将某学期配置设为当前激活

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.activateSetting(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addComment**
> BaseResponseVoid addComment(addCommentRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    AddCommentRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let articleId: number; //文章ID (default to undefined)
let addCommentRequest: AddCommentRequest; //

const { status, data } = await apiInstance.addComment(
    articleId,
    addCommentRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **addCommentRequest** | **AddCommentRequest**|  | |
| **articleId** | [**number**] | 文章ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addCourse**
> BaseResponseVoid addCourse(addClassCourseRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    AddClassCourseRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let classId: number; // (default to undefined)
let addClassCourseRequest: AddClassCourseRequest; //

const { status, data } = await apiInstance.addCourse(
    classId,
    addClassCourseRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **addClassCourseRequest** | **AddClassCourseRequest**|  | |
| **classId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addEdge**
> BaseResponseWorkflowEdgeResponse addEdge(addEdgeRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    AddEdgeRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let addEdgeRequest: AddEdgeRequest; //

const { status, data } = await apiInstance.addEdge(
    id,
    addEdgeRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **addEdgeRequest** | **AddEdgeRequest**|  | |
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseWorkflowEdgeResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addItem**
> BaseResponseLong addItem(addScheduleItemRequest)

向课表中添加课程

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    AddScheduleItemRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let addScheduleItemRequest: AddScheduleItemRequest; //

const { status, data } = await apiInstance.addItem(
    addScheduleItemRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **addScheduleItemRequest** | **AddScheduleItemRequest**|  | |


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addMember**
> BaseResponseVoid addMember(addClassMemberRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    AddClassMemberRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let classId: number; // (default to undefined)
let addClassMemberRequest: AddClassMemberRequest; //

const { status, data } = await apiInstance.addMember(
    classId,
    addClassMemberRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **addClassMemberRequest** | **AddClassMemberRequest**|  | |
| **classId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addNode**
> BaseResponseWorkflowNodeResponse addNode(addNodeRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    AddNodeRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let addNodeRequest: AddNodeRequest; //

const { status, data } = await apiInstance.addNode(
    id,
    addNodeRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **addNodeRequest** | **AddNodeRequest**|  | |
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseWorkflowNodeResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addQuestionToSection**
> BaseResponseLong addQuestionToSection(addPaperQuestionRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    AddPaperQuestionRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let paperId: number; // (default to undefined)
let sectionId: number; // (default to undefined)
let addPaperQuestionRequest: AddPaperQuestionRequest; //

const { status, data } = await apiInstance.addQuestionToSection(
    paperId,
    sectionId,
    addPaperQuestionRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **addPaperQuestionRequest** | **AddPaperQuestionRequest**|  | |
| **paperId** | [**number**] |  | defaults to undefined|
| **sectionId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addSection**
> BaseResponseLong addSection(addPaperSectionRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    AddPaperSectionRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let paperId: number; // (default to undefined)
let addPaperSectionRequest: AddPaperSectionRequest; //

const { status, data } = await apiInstance.addSection(
    paperId,
    addPaperSectionRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **addPaperSectionRequest** | **AddPaperSectionRequest**|  | |
| **paperId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addToShelf**
> BaseResponseVoid addToShelf()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let userId: number; // (default to undefined)
let bookId: number; // (default to undefined)

const { status, data } = await apiInstance.addToShelf(
    userId,
    bookId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **userId** | [**number**] |  | defaults to undefined|
| **bookId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addToWordBook**
> BaseResponseLong addToWordBook()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let wordId: number; //单词ID (default to undefined)

const { status, data } = await apiInstance.addToWordBook(
    wordId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **wordId** | [**number**] | 单词ID | defaults to undefined|


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addVariable**
> BaseResponseWorkflowVariableResponse addVariable(addVariableRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    AddVariableRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let addVariableRequest: AddVariableRequest; //

const { status, data } = await apiInstance.addVariable(
    id,
    addVariableRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **addVariableRequest** | **AddVariableRequest**|  | |
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseWorkflowVariableResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminDeletePost**
> BaseResponseVoid adminDeletePost()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let postId: number; // (default to undefined)

const { status, data } = await apiInstance.adminDeletePost(
    postId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **postId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **aiGenerateQuestions**
> SseEmitter aiGenerateQuestions(aiGenerateQuestionsRequest)

支持联网搜索热点、几何图形渲染、文生图配图

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    AiGenerateQuestionsRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let aiGenerateQuestionsRequest: AiGenerateQuestionsRequest; //

const { status, data } = await apiInstance.aiGenerateQuestions(
    aiGenerateQuestionsRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **aiGenerateQuestionsRequest** | **AiGenerateQuestionsRequest**|  | |


### Return type

**SseEmitter**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, text/event-stream


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **applyTeacher**
> BaseResponseLong applyTeacher(applyTeacherRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    ApplyTeacherRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let applyTeacherRequest: ApplyTeacherRequest; //

const { status, data } = await apiInstance.applyTeacher(
    applyTeacherRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **applyTeacherRequest** | **ApplyTeacherRequest**|  | |


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **applyToJoin**
> BaseResponseJoinRequestResponse applyToJoin()


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    JoinGroupRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)
let joinGroupRequest: JoinGroupRequest; // (optional)

const { status, data } = await apiInstance.applyToJoin(
    groupId,
    joinGroupRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **joinGroupRequest** | **JoinGroupRequest**|  | |
| **groupId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseJoinRequestResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **archive**
> BaseResponseWorkflowResponse archive()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)

const { status, data } = await apiInstance.archive(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseWorkflowResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **batchBanUsers**
> BaseResponseBoolean batchBanUsers(batchBanUserRequest)

管理员批量封禁或解封用户

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    BatchBanUserRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let batchBanUserRequest: BatchBanUserRequest; //

const { status, data } = await apiInstance.batchBanUsers(
    batchBanUserRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **batchBanUserRequest** | **BatchBanUserRequest**|  | |


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **batchCreateUsers**
> BaseResponseListLong batchCreateUsers(batchCreateUserRequest)

管理员批量创建用户

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    BatchCreateUserRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let batchCreateUserRequest: BatchCreateUserRequest; //

const { status, data } = await apiInstance.batchCreateUsers(
    batchCreateUserRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **batchCreateUserRequest** | **BatchCreateUserRequest**|  | |


### Return type

**BaseResponseListLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **batchSyncAll**
> BaseResponseString batchSyncAll()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let batchSize: number; //每批次数量，默认500 (optional) (default to 500)

const { status, data } = await apiInstance.batchSyncAll(
    batchSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **batchSize** | [**number**] | 每批次数量，默认500 | (optional) defaults to 500|


### Return type

**BaseResponseString**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **batchSyncArticles**
> BaseResponseInteger batchSyncArticles()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let batchSize: number; //每批次数量，默认500 (optional) (default to 500)

const { status, data } = await apiInstance.batchSyncArticles(
    batchSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **batchSize** | [**number**] | 每批次数量，默认500 | (optional) defaults to 500|


### Return type

**BaseResponseInteger**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **batchSyncWords**
> BaseResponseInteger batchSyncWords()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let batchSize: number; //每批次数量，默认500 (optional) (default to 500)

const { status, data } = await apiInstance.batchSyncWords(
    batchSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **batchSize** | [**number**] | 每批次数量，默认500 | (optional) defaults to 500|


### Return type

**BaseResponseInteger**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **batchUpdate**
> BaseResponseWorkflowDefinitionResponse batchUpdate(batchUpdateNodesRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    BatchUpdateNodesRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let batchUpdateNodesRequest: BatchUpdateNodesRequest; //

const { status, data } = await apiInstance.batchUpdate(
    id,
    batchUpdateNodesRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **batchUpdateNodesRequest** | **BatchUpdateNodesRequest**|  | |
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseWorkflowDefinitionResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bindToAssistant**
> BaseResponseVoid bindToAssistant()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let assistantId: number; //AI助手ID (default to undefined)

const { status, data } = await apiInstance.bindToAssistant(
    id,
    assistantId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|
| **assistantId** | [**number**] | AI助手ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **cancelExecution**
> BaseResponseVoid cancelExecution()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let executionId: string; //执行ID (default to undefined)

const { status, data } = await apiInstance.cancelExecution(
    executionId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **executionId** | [**string**] | 执行ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **changePassword**
> BaseResponseBoolean changePassword(changePasswordRequest)

用户修改自己的密码，需要验证旧密码

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    ChangePasswordRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let changePasswordRequest: ChangePasswordRequest; //

const { status, data } = await apiInstance.changePassword(
    changePasswordRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **changePasswordRequest** | **ChangePasswordRequest**|  | |


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **checkFavourite**
> BaseResponseBoolean checkFavourite()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)

const { status, data } = await apiInstance.checkFavourite(
    courseId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **courseId** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **checkFriendship**
> BaseResponseBoolean checkFriendship()

检查当前用户与目标用户是否是好友

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let userId: number; // (default to undefined)

const { status, data } = await apiInstance.checkFriendship(
    userId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **userId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **checkin**
> BaseResponseCheckinResult checkin()

每日打卡，每天只能打卡一次

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.checkin();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseCheckinResult**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **completeSection**
> BaseResponseVoid completeSection()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let sectionId: number; //小节ID (default to undefined)
let courseId: number; //课程ID (default to undefined)

const { status, data } = await apiInstance.completeSection(
    sectionId,
    courseId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **sectionId** | [**number**] | 小节ID | defaults to undefined|
| **courseId** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **confirmPayment**
> BaseResponseVoid confirmPayment(confirmPaymentRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    ConfirmPaymentRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let confirmPaymentRequest: ConfirmPaymentRequest; //

const { status, data } = await apiInstance.confirmPayment(
    confirmPaymentRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **confirmPaymentRequest** | **ConfirmPaymentRequest**|  | |


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **copy**
> BaseResponseWorkflowResponse copy()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let newName: string; //新工作流名称 (default to undefined)
let userId: number; //用户ID (default to undefined)

const { status, data } = await apiInstance.copy(
    id,
    newName,
    userId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|
| **newName** | [**string**] | 新工作流名称 | defaults to undefined|
| **userId** | [**number**] | 用户ID | defaults to undefined|


### Return type

**BaseResponseWorkflowResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **create**
> BaseResponseWorkflowResponse create(createWorkflowRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateWorkflowRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let createWorkflowRequest: CreateWorkflowRequest; //

const { status, data } = await apiInstance.create(
    createWorkflowRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createWorkflowRequest** | **CreateWorkflowRequest**|  | |


### Return type

**BaseResponseWorkflowResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createAnnouncement**
> BaseResponseLong createAnnouncement(createAnnouncementRequest)

创建新公告，初始状态为草稿

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateAnnouncementRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let createAnnouncementRequest: CreateAnnouncementRequest; //

const { status, data } = await apiInstance.createAnnouncement(
    createAnnouncementRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createAnnouncementRequest** | **CreateAnnouncementRequest**|  | |


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createBanner**
> BaseResponseLong createBanner(createBannerRequest)

创建新的轮播图

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateBannerRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let createBannerRequest: CreateBannerRequest; //

const { status, data } = await apiInstance.createBanner(
    createBannerRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createBannerRequest** | **CreateBannerRequest**|  | |


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createChapter**
> BaseResponseLong createChapter(createChapterRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateChapterRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)
let createChapterRequest: CreateChapterRequest; //

const { status, data } = await apiInstance.createChapter(
    courseId,
    createChapterRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createChapterRequest** | **CreateChapterRequest**|  | |
| **courseId** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createClass**
> BaseResponseClassResponse createClass(createClassRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateClassRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let createClassRequest: CreateClassRequest; //

const { status, data } = await apiInstance.createClass(
    createClassRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createClassRequest** | **CreateClassRequest**|  | |


### Return type

**BaseResponseClassResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createComment**
> BaseResponseCommentResponse createComment(createCommentRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateCommentRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let postId: number; // (default to undefined)
let createCommentRequest: CreateCommentRequest; //

const { status, data } = await apiInstance.createComment(
    postId,
    createCommentRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createCommentRequest** | **CreateCommentRequest**|  | |
| **postId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseCommentResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createConfig**
> BaseResponseScraperConfigResponse createConfig(scraperConfigRequest)

创建新的抓取源配置

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    ScraperConfigRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let scraperConfigRequest: ScraperConfigRequest; //

const { status, data } = await apiInstance.createConfig(
    scraperConfigRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **scraperConfigRequest** | **ScraperConfigRequest**|  | |


### Return type

**BaseResponseScraperConfigResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createCourse**
> BaseResponseLong createCourse(createCourseRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateCourseRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let createCourseRequest: CreateCourseRequest; //

const { status, data } = await apiInstance.createCourse(
    createCourseRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createCourseRequest** | **CreateCourseRequest**|  | |


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createDailyArticle**
> BaseResponseLong createDailyArticle(createDailyArticleRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateDailyArticleRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let createDailyArticleRequest: CreateDailyArticleRequest; //

const { status, data } = await apiInstance.createDailyArticle(
    createDailyArticleRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createDailyArticleRequest** | **CreateDailyArticleRequest**|  | |


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createDailyWord**
> BaseResponseLong createDailyWord(createDailyWordRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateDailyWordRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let createDailyWordRequest: CreateDailyWordRequest; //

const { status, data } = await apiInstance.createDailyWord(
    createDailyWordRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createDailyWordRequest** | **CreateDailyWordRequest**|  | |


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createExamPaper**
> BaseResponseLong createExamPaper(createExamPaperRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateExamPaperRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let createExamPaperRequest: CreateExamPaperRequest; //

const { status, data } = await apiInstance.createExamPaper(
    createExamPaperRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createExamPaperRequest** | **CreateExamPaperRequest**|  | |


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createFeedback**
> BaseResponseLong createFeedback(createFeedbackRequest)

用户提交新的反馈

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateFeedbackRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let createFeedbackRequest: CreateFeedbackRequest; //

const { status, data } = await apiInstance.createFeedback(
    createFeedbackRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createFeedbackRequest** | **CreateFeedbackRequest**|  | |


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createFromTemplate**
> BaseResponseWorkflowResponse createFromTemplate()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let templateId: number; //模板ID (default to undefined)
let userId: number; // (default to undefined)
let name: string; // (optional) (default to undefined)
let description: string; // (optional) (default to undefined)

const { status, data } = await apiInstance.createFromTemplate(
    templateId,
    userId,
    name,
    description
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **templateId** | [**number**] | 模板ID | defaults to undefined|
| **userId** | [**number**] |  | defaults to undefined|
| **name** | [**string**] |  | (optional) defaults to undefined|
| **description** | [**string**] |  | (optional) defaults to undefined|


### Return type

**BaseResponseWorkflowResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createGroup**
> BaseResponseGroupResponse createGroup(createGroupRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateGroupRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let createGroupRequest: CreateGroupRequest; //

const { status, data } = await apiInstance.createGroup(
    createGroupRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createGroupRequest** | **CreateGroupRequest**|  | |


### Return type

**BaseResponseGroupResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createGroupFromClass**
> BaseResponseLong createGroupFromClass()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let classId: number; // (default to undefined)

const { status, data } = await apiInstance.createGroupFromClass(
    classId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **classId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createOrder**
> BaseResponseString createOrder(createOrderRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateOrderRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let createOrderRequest: CreateOrderRequest; //

const { status, data } = await apiInstance.createOrder(
    createOrderRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createOrderRequest** | **CreateOrderRequest**|  | |


### Return type

**BaseResponseString**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createPost**
> BaseResponsePostResponse createPost(createPostRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreatePostRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let createPostRequest: CreatePostRequest; //

const { status, data } = await apiInstance.createPost(
    createPostRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createPostRequest** | **CreatePostRequest**|  | |


### Return type

**BaseResponsePostResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createQuestion**
> BaseResponseLong createQuestion(createQuestionRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateQuestionRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let createQuestionRequest: CreateQuestionRequest; //

const { status, data } = await apiInstance.createQuestion(
    createQuestionRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createQuestionRequest** | **CreateQuestionRequest**|  | |


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createReply**
> BaseResponseReplyResponse createReply(createReplyRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateReplyRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let commentId: number; // (default to undefined)
let createReplyRequest: CreateReplyRequest; //

const { status, data } = await apiInstance.createReply(
    commentId,
    createReplyRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createReplyRequest** | **CreateReplyRequest**|  | |
| **commentId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseReplyResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createScheduleTrigger**
> BaseResponseWorkflowTriggerResponse createScheduleTrigger()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let name: string; // (default to undefined)
let cronExpression: string; // (default to undefined)
let timezone: string; // (optional) (default to undefined)

const { status, data } = await apiInstance.createScheduleTrigger(
    id,
    name,
    cronExpression,
    timezone
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|
| **name** | [**string**] |  | defaults to undefined|
| **cronExpression** | [**string**] |  | defaults to undefined|
| **timezone** | [**string**] |  | (optional) defaults to undefined|


### Return type

**BaseResponseWorkflowTriggerResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createSection**
> BaseResponseLong createSection(createSectionRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateSectionRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)
let createSectionRequest: CreateSectionRequest; //

const { status, data } = await apiInstance.createSection(
    courseId,
    createSectionRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createSectionRequest** | **CreateSectionRequest**|  | |
| **courseId** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createSetting**
> BaseResponseLong createSetting(createScheduleSettingRequest)

管理员/教师创建班级课表配置

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateScheduleSettingRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let createScheduleSettingRequest: CreateScheduleSettingRequest; //

const { status, data } = await apiInstance.createSetting(
    createScheduleSettingRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createScheduleSettingRequest** | **CreateScheduleSettingRequest**|  | |


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createTemplate**
> BaseResponseWorkflowTemplateResponse createTemplate()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let workflowId: number; //工作流ID (default to undefined)
let name: string; // (default to undefined)
let userId: number; // (default to undefined)
let description: string; // (optional) (default to undefined)
let category: string; // (optional) (default to undefined)

const { status, data } = await apiInstance.createTemplate(
    workflowId,
    name,
    userId,
    description,
    category
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **workflowId** | [**number**] | 工作流ID | defaults to undefined|
| **name** | [**string**] |  | defaults to undefined|
| **userId** | [**number**] |  | defaults to undefined|
| **description** | [**string**] |  | (optional) defaults to undefined|
| **category** | [**string**] |  | (optional) defaults to undefined|


### Return type

**BaseResponseWorkflowTemplateResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createUser**
> BaseResponseLong createUser(createUserRequest)

管理员创建单个用户

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateUserRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let createUserRequest: CreateUserRequest; //

const { status, data } = await apiInstance.createUser(
    createUserRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createUserRequest** | **CreateUserRequest**|  | |


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createVersionSnapshot**
> BaseResponseWorkflowVersionResponse createVersionSnapshot()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let userId: number; // (default to undefined)
let publishNote: string; // (optional) (default to undefined)

const { status, data } = await apiInstance.createVersionSnapshot(
    id,
    userId,
    publishNote
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|
| **userId** | [**number**] |  | defaults to undefined|
| **publishNote** | [**string**] |  | (optional) defaults to undefined|


### Return type

**BaseResponseWorkflowVersionResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createWebhookTrigger**
> BaseResponseWorkflowTriggerResponse createWebhookTrigger()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let name: string; // (default to undefined)
let secret: string; // (optional) (default to undefined)
let validateSignature: boolean; // (optional) (default to false)

const { status, data } = await apiInstance.createWebhookTrigger(
    id,
    name,
    secret,
    validateSignature
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|
| **name** | [**string**] |  | defaults to undefined|
| **secret** | [**string**] |  | (optional) defaults to undefined|
| **validateSignature** | [**boolean**] |  | (optional) defaults to false|


### Return type

**BaseResponseWorkflowTriggerResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteAnnouncement**
> BaseResponseBoolean deleteAnnouncement()

逻辑删除公告

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.deleteAnnouncement(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteBanner**
> BaseResponseBoolean deleteBanner()

删除指定轮播图

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.deleteBanner(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteBook**
> BaseResponseVoid deleteBook()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let bookId: number; // (default to undefined)

const { status, data } = await apiInstance.deleteBook(
    bookId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **bookId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteChapter**
> BaseResponseVoid deleteChapter()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)
let chapterId: number; //章节ID (default to undefined)

const { status, data } = await apiInstance.deleteChapter(
    courseId,
    chapterId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **courseId** | [**number**] | 课程ID | defaults to undefined|
| **chapterId** | [**number**] | 章节ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteClass**
> BaseResponseVoid deleteClass()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let classId: number; // (default to undefined)

const { status, data } = await apiInstance.deleteClass(
    classId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **classId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteComment**
> BaseResponseVoid deleteComment()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let commentId: number; // (default to undefined)

const { status, data } = await apiInstance.deleteComment(
    commentId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **commentId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteConfig**
> BaseResponseVoid deleteConfig()

删除指定的抓取配置

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.deleteConfig(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteCourse**
> BaseResponseVoid deleteCourse()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //课程ID (default to undefined)

const { status, data } = await apiInstance.deleteCourse(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteDailyArticle**
> BaseResponseVoid deleteDailyArticle()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //文章ID (default to undefined)

const { status, data } = await apiInstance.deleteDailyArticle(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 文章ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteDailyWord**
> BaseResponseVoid deleteDailyWord()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //单词ID (default to undefined)

const { status, data } = await apiInstance.deleteDailyWord(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 单词ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteEdge**
> BaseResponseVoid deleteEdge()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let edgeId: string; //连接线ID (default to undefined)

const { status, data } = await apiInstance.deleteEdge(
    id,
    edgeId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|
| **edgeId** | [**string**] | 连接线ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteExamPaper**
> BaseResponseBoolean deleteExamPaper()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.deleteExamPaper(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteFeedback**
> BaseResponseBoolean deleteFeedback()

用户删除自己的反馈

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.deleteFeedback(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteFeedback1**
> BaseResponseBoolean deleteFeedback1()

管理员删除反馈

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.deleteFeedback1(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteFile**
> BaseResponseVoid deleteFile()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let fileId: number; //文件ID (default to undefined)

const { status, data } = await apiInstance.deleteFile(
    fileId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **fileId** | [**number**] | 文件ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteFriend**
> BaseResponseBoolean deleteFriend()

删除指定好友

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let friendId: number; // (default to undefined)

const { status, data } = await apiInstance.deleteFriend(
    friendId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **friendId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteItem**
> BaseResponseBoolean deleteItem()

删除课程项

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.deleteItem(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteMessage**
> BaseResponseVoid deleteMessage()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)
let messageId: number; // (default to undefined)

const { status, data } = await apiInstance.deleteMessage(
    groupId,
    messageId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] |  | defaults to undefined|
| **messageId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteNode**
> BaseResponseVoid deleteNode()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let nodeId: string; //节点ID (default to undefined)

const { status, data } = await apiInstance.deleteNode(
    id,
    nodeId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|
| **nodeId** | [**string**] | 节点ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deletePost**
> BaseResponseVoid deletePost()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let postId: number; // (default to undefined)

const { status, data } = await apiInstance.deletePost(
    postId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **postId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteQuestion**
> BaseResponseBoolean deleteQuestion()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.deleteQuestion(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteReply**
> BaseResponseVoid deleteReply()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let replyId: number; // (default to undefined)

const { status, data } = await apiInstance.deleteReply(
    replyId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **replyId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteSection**
> BaseResponseBoolean deleteSection()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let paperId: number; // (default to undefined)
let sectionId: number; // (default to undefined)

const { status, data } = await apiInstance.deleteSection(
    paperId,
    sectionId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **paperId** | [**number**] |  | defaults to undefined|
| **sectionId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteSection1**
> BaseResponseVoid deleteSection1()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)
let sectionId: number; //小节ID (default to undefined)

const { status, data } = await apiInstance.deleteSection1(
    courseId,
    sectionId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **courseId** | [**number**] | 课程ID | defaults to undefined|
| **sectionId** | [**number**] | 小节ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteTemplate**
> BaseResponseVoid deleteTemplate()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let templateId: number; //模板ID (default to undefined)

const { status, data } = await apiInstance.deleteTemplate(
    templateId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **templateId** | [**number**] | 模板ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteTemplate2**
> BaseResponseVoid deleteTemplate2()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //模板ID (default to undefined)

const { status, data } = await apiInstance.deleteTemplate2(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 模板ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteTrigger**
> BaseResponseVoid deleteTrigger()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let triggerId: number; //触发器ID (default to undefined)

const { status, data } = await apiInstance.deleteTrigger(
    triggerId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **triggerId** | [**number**] | 触发器ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteVariable**
> BaseResponseVoid deleteVariable()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let variableName: string; //变量名称 (default to undefined)

const { status, data } = await apiInstance.deleteVariable(
    id,
    variableName
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|
| **variableName** | [**string**] | 变量名称 | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **disableConfig**
> BaseResponseVoid disableConfig()

禁用指定的抓取配置

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.disableConfig(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **disableTrigger**
> BaseResponseWorkflowTriggerResponse disableTrigger()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let triggerId: number; //触发器ID (default to undefined)

const { status, data } = await apiInstance.disableTrigger(
    triggerId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **triggerId** | [**number**] | 触发器ID | defaults to undefined|


### Return type

**BaseResponseWorkflowTriggerResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **dissolveGroup**
> BaseResponseVoid dissolveGroup()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)

const { status, data } = await apiInstance.dissolveGroup(
    groupId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **dissolveGroup1**
> BaseResponseVoid dissolveGroup1()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; //群ID (default to undefined)

const { status, data } = await apiInstance.dissolveGroup1(
    groupId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] | 群ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **enableConfig**
> BaseResponseVoid enableConfig()

启用指定的抓取配置

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.enableConfig(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **enableTrigger**
> BaseResponseWorkflowTriggerResponse enableTrigger()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let triggerId: number; //触发器ID (default to undefined)

const { status, data } = await apiInstance.enableTrigger(
    triggerId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **triggerId** | [**number**] | 触发器ID | defaults to undefined|


### Return type

**BaseResponseWorkflowTriggerResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **encryptChapterContent**
> BaseResponseVoid encryptChapterContent()

对指定章节的内容进行AES加密存储

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let bookId: number; // (default to undefined)
let chapterIndex: number; // (default to undefined)

const { status, data } = await apiInstance.encryptChapterContent(
    bookId,
    chapterIndex
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **bookId** | [**number**] |  | defaults to undefined|
| **chapterIndex** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **execute**
> BaseResponseExecutionResultResponse execute(executeWorkflowRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    ExecuteWorkflowRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let executeWorkflowRequest: ExecuteWorkflowRequest; //

const { status, data } = await apiInstance.execute(
    id,
    executeWorkflowRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **executeWorkflowRequest** | **ExecuteWorkflowRequest**|  | |
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseExecutionResultResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **executeAllTasks**
> BaseResponseVoid executeAllTasks()

手动触发所有启用配置的抓取任务

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.executeAllTasks();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **executeAsync**
> BaseResponseAsyncExecutionResponse executeAsync(executeWorkflowRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    ExecuteWorkflowRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let executeWorkflowRequest: ExecuteWorkflowRequest; //

const { status, data } = await apiInstance.executeAsync(
    id,
    executeWorkflowRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **executeWorkflowRequest** | **ExecuteWorkflowRequest**|  | |
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseAsyncExecutionResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **executeTask**
> BaseResponseScraperTaskResponse executeTask(executeTaskRequest)

手动触发指定配置的抓取任务

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    ExecuteTaskRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let executeTaskRequest: ExecuteTaskRequest; //

const { status, data } = await apiInstance.executeTask(
    executeTaskRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **executeTaskRequest** | **ExecuteTaskRequest**|  | |


### Return type

**BaseResponseScraperTaskResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **exportAnswerKey**
> string exportAnswerKey()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.exportAnswerKey(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**string**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **favouriteCourse**
> BaseResponseVoid favouriteCourse()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)

const { status, data } = await apiInstance.favouriteCourse(
    courseId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **courseId** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **follow**
> BaseResponseVoid follow()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let targetUserId: number; // (default to undefined)

const { status, data } = await apiInstance.follow(
    targetUserId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **targetUserId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **generateBannerImage**
> BaseResponseGenerateBannerImageResponse generateBannerImage(generateBannerImageRequest)

根据标题和图片描述，使用AI生成轮播图图片

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    GenerateBannerImageRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let generateBannerImageRequest: GenerateBannerImageRequest; //

const { status, data } = await apiInstance.generateBannerImage(
    generateBannerImageRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **generateBannerImageRequest** | **GenerateBannerImageRequest**|  | |


### Return type

**BaseResponseGenerateBannerImageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllConfigs**
> BaseResponseListScraperConfigResponse getAllConfigs()

获取所有抓取源配置列表

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getAllConfigs();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseListScraperConfigResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllFriends**
> BaseResponseListFriendResponse getAllFriends()

获取当前用户的全部好友列表

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getAllFriends();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseListFriendResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllTasks**
> BaseResponseScraperTaskPageResponse getAllTasks()

获取所有抓取任务列表

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let page: number; // (optional) (default to 1)
let size: number; // (optional) (default to 10)

const { status, data } = await apiInstance.getAllTasks(
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **page** | [**number**] |  | (optional) defaults to 1|
| **size** | [**number**] |  | (optional) defaults to 10|


### Return type

**BaseResponseScraperTaskPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAnnouncement**
> BaseResponseAnnouncementResponse getAnnouncement()

获取公告详细信息，包含阅读统计

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.getAnnouncement(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseAnnouncementResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAnnouncementDetail**
> BaseResponseAnnouncementDetailResponse getAnnouncementDetail()

获取公告详细内容

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.getAnnouncementDetail(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseAnnouncementDetailResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAnnouncementList**
> BaseResponseUserAnnouncementPageResponse getAnnouncementList()

获取用户可见的公告列表，包含已读状态

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 10)

const { status, data } = await apiInstance.getAnnouncementList(
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 10|


### Return type

**BaseResponseUserAnnouncementPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getApplication**
> BaseResponseTeacherApplicationResponse getApplication()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //申请ID (default to undefined)

const { status, data } = await apiInstance.getApplication(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 申请ID | defaults to undefined|


### Return type

**BaseResponseTeacherApplicationResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getArticlesByDate**
> BaseResponseListDailyArticleResponse getArticlesByDate()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let date: string; //日期 (default to undefined)

const { status, data } = await apiInstance.getArticlesByDate(
    date
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **date** | [**string**] | 日期 | defaults to undefined|


### Return type

**BaseResponseListDailyArticleResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getBannerDetail**
> BaseResponseBannerResponse getBannerDetail()

获取轮播图详细信息

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.getBannerDetail(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBannerResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getBannerList**
> BaseResponseListBannerListResponse getBannerList()

获取用户可见的轮播图列表

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getBannerList();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseListBannerListResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getBook**
> BaseResponseBookDTO getBook()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let bookId: number; // (default to undefined)

const { status, data } = await apiInstance.getBook(
    bookId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **bookId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBookDTO**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getBookChapters**
> BaseResponseListChapterDTO getBookChapters()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let bookId: number; // (default to undefined)

const { status, data } = await apiInstance.getBookChapters(
    bookId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **bookId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseListChapterDTO**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getById**
> BaseResponseWorkflowResponse getById()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)

const { status, data } = await apiInstance.getById(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseWorkflowResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getChapter**
> BaseResponseChapterResponse getChapter()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)
let chapterId: number; //章节ID (default to undefined)

const { status, data } = await apiInstance.getChapter(
    courseId,
    chapterId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **courseId** | [**number**] | 课程ID | defaults to undefined|
| **chapterId** | [**number**] | 章节ID | defaults to undefined|


### Return type

**BaseResponseChapterResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getChapterContent**
> BaseResponseChapterContentDTO getChapterContent()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let bookId: number; // (default to undefined)
let chapterIndex: number; // (default to undefined)

const { status, data } = await apiInstance.getChapterContent(
    bookId,
    chapterIndex
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **bookId** | [**number**] |  | defaults to undefined|
| **chapterIndex** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseChapterContentDTO**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getChatHistory**
> BaseResponseChatMessagePageResponse getChatHistory(chatHistoryRequestDTO)

获取与指定用户的聊天历史记录

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    ChatHistoryRequestDTO
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let chatHistoryRequestDTO: ChatHistoryRequestDTO; //

const { status, data } = await apiInstance.getChatHistory(
    chatHistoryRequestDTO
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **chatHistoryRequestDTO** | **ChatHistoryRequestDTO**|  | |


### Return type

**BaseResponseChatMessagePageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCheckinRanking**
> BaseResponseListCheckinRankingItem getCheckinRanking()

获取打卡排行榜前10名，公开接口

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let limit: number; // (optional) (default to 10)

const { status, data } = await apiInstance.getCheckinRanking(
    limit
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **limit** | [**number**] |  | (optional) defaults to 10|


### Return type

**BaseResponseListCheckinRankingItem**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCheckinStatus**
> BaseResponseCheckinStatusResult getCheckinStatus()

获取当前用户的打卡状态

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getCheckinStatus();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseCheckinStatusResult**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getClassInfo**
> BaseResponseClassResponse getClassInfo()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let classId: number; // (default to undefined)

const { status, data } = await apiInstance.getClassInfo(
    classId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **classId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseClassResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getClassMembers**
> BaseResponsePageResponseClassMemberResponse getClassMembers()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let classId: number; // (default to undefined)
let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 20)

const { status, data } = await apiInstance.getClassMembers(
    classId,
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **classId** | [**number**] |  | defaults to undefined|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 20|


### Return type

**BaseResponsePageResponseClassMemberResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCollectedArticles**
> BaseResponseListUserDailyArticleResponse getCollectedArticles()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.getCollectedArticles(
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseListUserDailyArticleResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCollectedWords**
> BaseResponseListUserDailyWordResponse getCollectedWords()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.getCollectedWords(
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseListUserDailyWordResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCommentReplies**
> BaseResponseReplyPageResponse getCommentReplies()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let commentId: number; // (default to undefined)
let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 20)

const { status, data } = await apiInstance.getCommentReplies(
    commentId,
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **commentId** | [**number**] |  | defaults to undefined|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 20|


### Return type

**BaseResponseReplyPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getConfig**
> BaseResponseScraperConfigResponse getConfig()

获取指定抓取配置的详细信息

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.getConfig(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseScraperConfigResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getConfigsByPage**
> BaseResponseScraperConfigPageResponse getConfigsByPage()

分页获取抓取源配置列表

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let page: number; // (optional) (default to 1)
let size: number; // (optional) (default to 10)

const { status, data } = await apiInstance.getConfigsByPage(
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **page** | [**number**] |  | (optional) defaults to 1|
| **size** | [**number**] |  | (optional) defaults to 10|


### Return type

**BaseResponseScraperConfigPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCourse**
> BaseResponseCourseResponse getCourse()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //课程ID (default to undefined)

const { status, data } = await apiInstance.getCourse(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseCourseResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCourseProgress**
> BaseResponseListProgressResponse getCourseProgress()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)

const { status, data } = await apiInstance.getCourseProgress(
    courseId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **courseId** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseListProgressResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCourseProgressSummary**
> BaseResponseCourseProgressSummaryResponse getCourseProgressSummary()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)

const { status, data } = await apiInstance.getCourseProgressSummary(
    courseId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **courseId** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseCourseProgressSummaryResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCourseStructure**
> BaseResponseCourseStructureResponse getCourseStructure()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)

const { status, data } = await apiInstance.getCourseStructure(
    courseId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **courseId** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseCourseStructureResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDailyArticle**
> BaseResponseDailyArticleResponse getDailyArticle()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //文章ID (default to undefined)

const { status, data } = await apiInstance.getDailyArticle(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 文章ID | defaults to undefined|


### Return type

**BaseResponseDailyArticleResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDailyWord**
> BaseResponseDailyWordResponse getDailyWord()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //单词ID (default to undefined)

const { status, data } = await apiInstance.getDailyWord(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 单词ID | defaults to undefined|


### Return type

**BaseResponseDailyWordResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDefinition**
> BaseResponseWorkflowDefinitionResponse getDefinition()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)

const { status, data } = await apiInstance.getDefinition(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseWorkflowDefinitionResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getEdges**
> BaseResponseListWorkflowEdgeResponse getEdges()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)

const { status, data } = await apiInstance.getEdges(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseListWorkflowEdgeResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getExamPaper**
> BaseResponseExamPaperResponse getExamPaper()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.getExamPaper(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseExamPaperResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getExecutionLogs**
> BaseResponseListExecutionLogResponse getExecutionLogs()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let executionId: string; //执行ID (default to undefined)
let level: string; //日志级别过滤（可选）：DEBUG/INFO/WARN/ERROR (optional) (default to undefined)

const { status, data } = await apiInstance.getExecutionLogs(
    executionId,
    level
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **executionId** | [**string**] | 执行ID | defaults to undefined|
| **level** | [**string**] | 日志级别过滤（可选）：DEBUG/INFO/WARN/ERROR | (optional) defaults to undefined|


### Return type

**BaseResponseListExecutionLogResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getExecutionStatistics**
> BaseResponseExecutionStatisticsResponse getExecutionStatistics()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)

const { status, data } = await apiInstance.getExecutionStatistics(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseExecutionStatisticsResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getExecutionStatus**
> BaseResponseExecutionResultResponse getExecutionStatus()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let executionId: string; //执行ID (default to undefined)

const { status, data } = await apiInstance.getExecutionStatus(
    executionId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **executionId** | [**string**] | 执行ID | defaults to undefined|


### Return type

**BaseResponseExecutionResultResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFavouriteCount**
> BaseResponseLong getFavouriteCount()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)

const { status, data } = await apiInstance.getFavouriteCount(
    courseId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **courseId** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFeedbackDetail**
> BaseResponseFeedbackDetailResponse getFeedbackDetail()

获取指定反馈的详细信息及回复列表

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.getFeedbackDetail(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseFeedbackDetailResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFeedbackDetail1**
> BaseResponseFeedbackDetailResponse getFeedbackDetail1()

管理员获取反馈详细信息

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.getFeedbackDetail1(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseFeedbackDetailResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFeedbackReplies**
> BaseResponseListFeedbackReplyResponse getFeedbackReplies()

获取指定反馈的所有回复

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.getFeedbackReplies(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseListFeedbackReplyResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFeedbackReplies1**
> BaseResponseListFeedbackReplyResponse getFeedbackReplies1()

管理员获取反馈的所有回复

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.getFeedbackReplies1(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseListFeedbackReplyResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFilesByBusinessType**
> BaseResponseListFileInfoResponse getFilesByBusinessType()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let businessType: string; //业务类型 (default to undefined)
let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.getFilesByBusinessType(
    businessType,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **businessType** | [**string**] | 业务类型 | defaults to undefined|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseListFileInfoResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFollowingPosts**
> BaseResponsePostPageResponse getFollowingPosts()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 10)

const { status, data } = await apiInstance.getFollowingPosts(
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 10|


### Return type

**BaseResponsePostPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFriendList**
> BaseResponseFriendPageResponse getFriendList(friendListRequestDTO)

获取当前用户的好友列表

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    FriendListRequestDTO
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let friendListRequestDTO: FriendListRequestDTO; //

const { status, data } = await apiInstance.getFriendList(
    friendListRequestDTO
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **friendListRequestDTO** | **FriendListRequestDTO**|  | |


### Return type

**BaseResponseFriendPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getGroupInfo**
> BaseResponseGroupResponse getGroupInfo()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)

const { status, data } = await apiInstance.getGroupInfo(
    groupId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseGroupResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getGroupInfo1**
> BaseResponseGroupResponse getGroupInfo1()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; //群ID (default to undefined)

const { status, data } = await apiInstance.getGroupInfo1(
    groupId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] | 群ID | defaults to undefined|


### Return type

**BaseResponseGroupResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getGroupMembers**
> BaseResponseListGroupMemberResponse getGroupMembers()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)

const { status, data } = await apiInstance.getGroupMembers(
    groupId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseListGroupMemberResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getGroupMembers1**
> BaseResponseMemberPage getGroupMembers1()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; //群ID (default to undefined)
let pageNum: number; //页码 (optional) (default to 1)
let pageSize: number; //每页数量 (optional) (default to 20)

const { status, data } = await apiInstance.getGroupMembers1(
    groupId,
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] | 群ID | defaults to undefined|
| **pageNum** | [**number**] | 页码 | (optional) defaults to 1|
| **pageSize** | [**number**] | 每页数量 | (optional) defaults to 20|


### Return type

**BaseResponseMemberPage**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getGroupMembersPage**
> BaseResponseMemberPage getGroupMembersPage()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)
let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 20)

const { status, data } = await apiInstance.getGroupMembersPage(
    groupId,
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] |  | defaults to undefined|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 20|


### Return type

**BaseResponseMemberPage**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getKey**
> getKey()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let keyId: string; //密钥ID (default to undefined)
let token: string; //一次性播放令牌（可选） (optional) (default to undefined)

const { status, data } = await apiInstance.getKey(
    keyId,
    token
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **keyId** | [**string**] | 密钥ID | defaults to undefined|
| **token** | [**string**] | 一次性播放令牌（可选） | (optional) defaults to undefined|


### Return type

void (empty response body)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getLatestMessages**
> BaseResponseListGroupMessageItem getLatestMessages()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)
let limit: number; // (optional) (default to 50)

const { status, data } = await apiInstance.getLatestMessages(
    groupId,
    limit
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] |  | defaults to undefined|
| **limit** | [**number**] |  | (optional) defaults to 50|


### Return type

**BaseResponseListGroupMessageItem**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getLikedArticles**
> BaseResponseListUserDailyArticleResponse getLikedArticles()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.getLikedArticles(
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseListUserDailyArticleResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getLoginUser**
> BaseResponseLoginUserResponse getLoginUser()

获取当前登录用户信息

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getLoginUser();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseLoginUserResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMessages**
> BaseResponseGroupMessagePageResponse getMessages()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)
let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 50)

const { status, data } = await apiInstance.getMessages(
    groupId,
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] |  | defaults to undefined|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 50|


### Return type

**BaseResponseGroupMessagePageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMessagesBefore**
> BaseResponseListGroupMessageItem getMessagesBefore()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)
let beforeMessageId: number; // (default to undefined)
let limit: number; // (optional) (default to 50)

const { status, data } = await apiInstance.getMessagesBefore(
    groupId,
    beforeMessageId,
    limit
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] |  | defaults to undefined|
| **beforeMessageId** | [**number**] |  | defaults to undefined|
| **limit** | [**number**] |  | (optional) defaults to 50|


### Return type

**BaseResponseListGroupMessageItem**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyApplication**
> BaseResponseTeacherApplicationResponse getMyApplication()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getMyApplication();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseTeacherApplicationResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyFavourites**
> BaseResponsePostPageResponse getMyFavourites()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 10)

const { status, data } = await apiInstance.getMyFavourites(
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 10|


### Return type

**BaseResponsePostPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyFavourites1**
> BaseResponseListCourseResponse getMyFavourites1()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.getMyFavourites1(
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseListCourseResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyFeedbacks**
> BaseResponseFeedbackPageResponse getMyFeedbacks()

分页获取当前用户的反馈列表

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 10)

const { status, data } = await apiInstance.getMyFeedbacks(
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 10|


### Return type

**BaseResponseFeedbackPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyFiles**
> BaseResponseListFileInfoResponse getMyFiles()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.getMyFiles(
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseListFileInfoResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyFollowStats**
> BaseResponseFollowStatsResponse getMyFollowStats()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getMyFollowStats();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseFollowStatsResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyFollowers**
> BaseResponseFollowPageResponse getMyFollowers()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 10)

const { status, data } = await apiInstance.getMyFollowers(
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 10|


### Return type

**BaseResponseFollowPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyFollowings**
> BaseResponseFollowPageResponse getMyFollowings()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 10)

const { status, data } = await apiInstance.getMyFollowings(
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 10|


### Return type

**BaseResponseFollowPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyGroups**
> BaseResponseListGroupResponse getMyGroups()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getMyGroups();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseListGroupResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyOrders**
> BaseResponseListOrderResponse getMyOrders()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.getMyOrders(
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseListOrderResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyPosts**
> BaseResponseListPostResponse getMyPosts()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getMyPosts();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseListPostResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyReview**
> BaseResponseCourseReviewResponse getMyReview()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)

const { status, data } = await apiInstance.getMyReview(
    courseId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **courseId** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseCourseReviewResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMySchedule**
> BaseResponseListClassScheduleItemResponse getMySchedule()

获取当前登录用户的完整课表（包括班级课表、执教课表、个人日程）

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getMySchedule();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseListClassScheduleItemResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyTeacher**
> BaseResponseTeacherResponse getMyTeacher()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getMyTeacher();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseTeacherResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getNode**
> BaseResponseWorkflowNodeResponse getNode()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let nodeId: string; //节点ID (default to undefined)

const { status, data } = await apiInstance.getNode(
    id,
    nodeId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|
| **nodeId** | [**string**] | 节点ID | defaults to undefined|


### Return type

**BaseResponseWorkflowNodeResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getNodeTypes**
> BaseResponseListNodeTypeResponse getNodeTypes()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getNodeTypes();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseListNodeTypeResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getNodes**
> BaseResponseListWorkflowNodeResponse getNodes()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)

const { status, data } = await apiInstance.getNodes(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseListWorkflowNodeResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getOrder**
> BaseResponseOrderResponse getOrder()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let orderNo: string; //订单号 (default to undefined)

const { status, data } = await apiInstance.getOrder(
    orderNo
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **orderNo** | [**string**] | 订单号 | defaults to undefined|


### Return type

**BaseResponseOrderResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPaperQuestions**
> BaseResponseListPaperQuestionResponse getPaperQuestions()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let paperId: number; // (default to undefined)
let sectionId: number; // (default to undefined)

const { status, data } = await apiInstance.getPaperQuestions(
    paperId,
    sectionId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **paperId** | [**number**] |  | defaults to undefined|
| **sectionId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseListPaperQuestionResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPendingCount**
> BaseResponseLong getPendingCount()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getPendingCount();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPendingRequests**
> BaseResponseListJoinRequestResponse getPendingRequests()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)

const { status, data } = await apiInstance.getPendingRequests(
    groupId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseListJoinRequestResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPostComments**
> BaseResponseCommentPageResponse getPostComments()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let postId: number; // (default to undefined)
let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 20)

const { status, data } = await apiInstance.getPostComments(
    postId,
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **postId** | [**number**] |  | defaults to undefined|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 20|


### Return type

**BaseResponseCommentPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPostDetail**
> BaseResponsePostDetailResponse getPostDetail()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let postId: number; // (default to undefined)

const { status, data } = await apiInstance.getPostDetail(
    postId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **postId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponsePostDetailResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPostList**
> BaseResponsePostPageResponse getPostList()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 10)

const { status, data } = await apiInstance.getPostList(
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 10|


### Return type

**BaseResponsePostPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPostListByType**
> BaseResponsePostPageResponse getPostListByType()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let postType: string; // (default to undefined)
let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 10)

const { status, data } = await apiInstance.getPostListByType(
    postType,
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **postType** | [**string**] |  | defaults to undefined|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 10|


### Return type

**BaseResponsePostPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getQuestion**
> BaseResponseQuestionResponse getQuestion()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.getQuestion(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseQuestionResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReadArticles**
> BaseResponseListUserDailyArticleResponse getReadArticles()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.getReadArticles(
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseListUserDailyArticleResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReadCount**
> BaseResponseInteger getReadCount()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let messageId: number; // (default to undefined)

const { status, data } = await apiInstance.getReadCount(
    messageId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **messageId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseInteger**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReadUsers**
> BaseResponseListMessageReadUserResponse getReadUsers()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let messageId: number; // (default to undefined)

const { status, data } = await apiInstance.getReadUsers(
    messageId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **messageId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseListMessageReadUserResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReceivedRequests**
> BaseResponseFriendRequestPageResponse getReceivedRequests(friendRequestListDTO)

获取当前用户收到的好友申请列表

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    FriendRequestListDTO
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let friendRequestListDTO: FriendRequestListDTO; //

const { status, data } = await apiInstance.getReceivedRequests(
    friendRequestListDTO
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **friendRequestListDTO** | **FriendRequestListDTO**|  | |


### Return type

**BaseResponseFriendRequestPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReviewCount**
> BaseResponseLong getReviewCount()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)

const { status, data } = await apiInstance.getReviewCount(
    courseId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **courseId** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getScheduleBySetting**
> BaseResponseScheduleResponse getScheduleBySetting()

根据配置ID获取课表预览

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let settingId: number; // (default to undefined)

const { status, data } = await apiInstance.getScheduleBySetting(
    settingId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **settingId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseScheduleResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSection**
> BaseResponseSectionResponse getSection()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)
let sectionId: number; //小节ID (default to undefined)

const { status, data } = await apiInstance.getSection(
    courseId,
    sectionId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **courseId** | [**number**] | 课程ID | defaults to undefined|
| **sectionId** | [**number**] | 小节ID | defaults to undefined|


### Return type

**BaseResponseSectionResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSectionProgress**
> BaseResponseProgressResponse getSectionProgress()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let sectionId: number; //小节ID (default to undefined)

const { status, data } = await apiInstance.getSectionProgress(
    sectionId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **sectionId** | [**number**] | 小节ID | defaults to undefined|


### Return type

**BaseResponseProgressResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSections**
> BaseResponseListPaperSectionResponse getSections()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let paperId: number; // (default to undefined)

const { status, data } = await apiInstance.getSections(
    paperId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **paperId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseListPaperSectionResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSentRequests**
> BaseResponseFriendRequestPageResponse getSentRequests(friendRequestListDTO)

获取当前用户发送的好友申请列表

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    FriendRequestListDTO
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let friendRequestListDTO: FriendRequestListDTO; //

const { status, data } = await apiInstance.getSentRequests(
    friendRequestListDTO
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **friendRequestListDTO** | **FriendRequestListDTO**|  | |


### Return type

**BaseResponseFriendRequestPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSessionList**
> BaseResponseListChatSessionResponse getSessionList()

获取当前用户的所有私聊会话

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getSessionList();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseListChatSessionResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStatistics**
> BaseResponseOrderStatistics getStatistics()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getStatistics();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseOrderStatistics**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStats**
> BaseResponseWordBookStats getStats()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getStats();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseWordBookStats**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStats1**
> BaseResponseLearningStats getStats1()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getStats1();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseLearningStats**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStats2**
> BaseResponseReadingStats getStats2()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getStats2();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseReadingStats**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStudiedWords**
> BaseResponseListUserDailyWordResponse getStudiedWords()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.getStudiedWords(
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseListUserDailyWordResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSupportedSources**
> BaseResponseListArticleSourceResponse getSupportedSources()

获取所有支持的预设新闻来源

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getSupportedSources();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseListArticleSourceResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSupportedVoices**
> BaseResponseString getSupportedVoices()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getSupportedVoices();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseString**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTableColumns**
> BaseResponseListMapStringObject getTableColumns()

返回白名单内指定表的字段名、类型等元数据

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let tableName: string; //表名 (default to undefined)

const { status, data } = await apiInstance.getTableColumns(
    tableName
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **tableName** | [**string**] | 表名 | defaults to undefined|


### Return type

**BaseResponseListMapStringObject**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTask**
> BaseResponseScraperTaskResponse getTask()

获取指定抓取任务的详细信息

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let taskId: number; // (default to undefined)

const { status, data } = await apiInstance.getTask(
    taskId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **taskId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseScraperTaskResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTasksByConfig**
> BaseResponseScraperTaskPageResponse getTasksByConfig()

获取指定配置的任务执行历史

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let configId: number; // (default to undefined)
let page: number; // (optional) (default to 1)
let size: number; // (optional) (default to 10)

const { status, data } = await apiInstance.getTasksByConfig(
    configId,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **configId** | [**number**] |  | defaults to undefined|
| **page** | [**number**] |  | (optional) defaults to 1|
| **size** | [**number**] |  | (optional) defaults to 10|


### Return type

**BaseResponseScraperTaskPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTeacher**
> BaseResponseTeacherResponse getTeacher()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //讲师ID (default to undefined)

const { status, data } = await apiInstance.getTeacher(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 讲师ID | defaults to undefined|


### Return type

**BaseResponseTeacherResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTeacherByUserId**
> BaseResponseTeacherResponse getTeacherByUserId()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let userId: number; //用户ID (default to undefined)

const { status, data } = await apiInstance.getTeacherByUserId(
    userId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **userId** | [**number**] | 用户ID | defaults to undefined|


### Return type

**BaseResponseTeacherResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTemplate**
> BaseResponseWorkflowTemplateResponse getTemplate()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let templateId: number; //模板ID (default to undefined)

const { status, data } = await apiInstance.getTemplate(
    templateId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **templateId** | [**number**] | 模板ID | defaults to undefined|


### Return type

**BaseResponseWorkflowTemplateResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTemplate1**
> BaseResponseExamTemplateResponse getTemplate1()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //模板ID (default to undefined)

const { status, data } = await apiInstance.getTemplate1(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 模板ID | defaults to undefined|


### Return type

**BaseResponseExamTemplateResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTodayArticles**
> BaseResponseListDailyArticleResponse getTodayArticles()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let size: number; //推荐数量 (optional) (default to 10)

const { status, data } = await apiInstance.getTodayArticles(
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **size** | [**number**] | 推荐数量 | (optional) defaults to 10|


### Return type

**BaseResponseListDailyArticleResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTodayWords**
> BaseResponseListDailyWordResponse getTodayWords()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let size: number; //推荐数量，最大100 (optional) (default to 10)
let type: string; //单词分类：小学三年级、小学四年级、小学五年级、小学六年级、初中七年级、初中八年级、初中九年级、初中、初中(乱序)、外研社初中、高中、高中(乱序)、北师高中、四级、四级(乱序)、专四、专四(乱序)、六级、六级(乱序)、考研、考研(乱序)、专八、专八(乱序)、托福、雅思、雅思(乱序)、GRE、GMAT、GMAT(乱序)、SAT、BEC商务英语 (optional) (default to undefined)

const { status, data } = await apiInstance.getTodayWords(
    size,
    type
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **size** | [**number**] | 推荐数量，最大100 | (optional) defaults to 10|
| **type** | [**string**] | 单词分类：小学三年级、小学四年级、小学五年级、小学六年级、初中七年级、初中八年级、初中九年级、初中、初中(乱序)、外研社初中、高中、高中(乱序)、北师高中、四级、四级(乱序)、专四、专四(乱序)、六级、六级(乱序)、考研、考研(乱序)、专八、专八(乱序)、托福、雅思、雅思(乱序)、GRE、GMAT、GMAT(乱序)、SAT、BEC商务英语 | (optional) defaults to undefined|


### Return type

**BaseResponseListDailyWordResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTopPosts**
> BaseResponsePostPageResponse getTopPosts()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 10)

const { status, data } = await apiInstance.getTopPosts(
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 10|


### Return type

**BaseResponsePostPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTopPostsByDays**
> BaseResponsePostPageResponse getTopPostsByDays()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let days: number; // (optional) (default to undefined)
let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 10)

const { status, data } = await apiInstance.getTopPostsByDays(
    days,
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **days** | [**number**] |  | (optional) defaults to undefined|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 10|


### Return type

**BaseResponsePostPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUnreadCount**
> BaseResponseInteger getUnreadCount()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)

const { status, data } = await apiInstance.getUnreadCount(
    groupId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseInteger**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUnreadCount1**
> BaseResponseInteger getUnreadCount1()

获取当前用户的未读消息总数

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getUnreadCount1();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseInteger**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUnreadCount2**
> BaseResponseLong getUnreadCount2()

获取当前用户未读公告的数量

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getUnreadCount2();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserDetail**
> BaseResponseUserDetailResponse getUserDetail()

管理员获取用户详细信息

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.getUserDetail(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseUserDetailResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserDetailInfo**
> BaseResponseUserDetailResponse getUserDetailInfo()

获取用户的详细信息，只有管理员和本人可以访问

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.getUserDetailInfo(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseUserDetailResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserFollowStats**
> BaseResponseFollowStatsResponse getUserFollowStats()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let targetUserId: number; // (default to undefined)

const { status, data } = await apiInstance.getUserFollowStats(
    targetUserId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **targetUserId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseFollowStatsResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserFollowers**
> BaseResponseFollowPageResponse getUserFollowers()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let targetUserId: number; // (default to undefined)
let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 10)

const { status, data } = await apiInstance.getUserFollowers(
    targetUserId,
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **targetUserId** | [**number**] |  | defaults to undefined|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 10|


### Return type

**BaseResponseFollowPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserFollowings**
> BaseResponseFollowPageResponse getUserFollowings()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let targetUserId: number; // (default to undefined)
let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 10)

const { status, data } = await apiInstance.getUserFollowings(
    targetUserId,
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **targetUserId** | [**number**] |  | defaults to undefined|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 10|


### Return type

**BaseResponseFollowPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserPosts**
> BaseResponseListPostResponse getUserPosts()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let targetUserId: number; // (default to undefined)

const { status, data } = await apiInstance.getUserPosts(
    targetUserId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **targetUserId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseListPostResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserPublicInfo**
> BaseResponseUserPublicResponse getUserPublicInfo()

获取其他用户的公开信息（非敏感）

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.getUserPublicInfo(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseUserPublicResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserShelf**
> BaseResponseListUserShelfDTO getUserShelf()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let userId: number; // (default to undefined)
let page: number; // (optional) (default to 1)
let size: number; // (optional) (default to 20)

const { status, data } = await apiInstance.getUserShelf(
    userId,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **userId** | [**number**] |  | defaults to undefined|
| **page** | [**number**] |  | (optional) defaults to 1|
| **size** | [**number**] |  | (optional) defaults to 20|


### Return type

**BaseResponseListUserShelfDTO**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserStats**
> BaseResponseUserStatsResult getUserStats()

获取当前用户的注册天数、打卡天数、帖子获赞数等统计数据

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.getUserStats();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseUserStatsResult**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getVariables**
> BaseResponseListWorkflowVariableResponse getVariables()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)

const { status, data } = await apiInstance.getVariables(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseListWorkflowVariableResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getVersion**
> BaseResponseWorkflowVersionResponse getVersion()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let versionNumber: number; //版本号 (default to undefined)

const { status, data } = await apiInstance.getVersion(
    id,
    versionNumber
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|
| **versionNumber** | [**number**] | 版本号 | defaults to undefined|


### Return type

**BaseResponseWorkflowVersionResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getWordBookList**
> BaseResponseListUserWordBookResponse getWordBookList()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let status: number; //学习状态：0-未学习，1-已学习，2-已掌握 (optional) (default to undefined)
let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.getWordBookList(
    status,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **status** | [**number**] | 学习状态：0-未学习，1-已学习，2-已掌握 | (optional) defaults to undefined|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseListUserWordBookResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getWordsByDate**
> BaseResponseListDailyWordResponse getWordsByDate()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let date: string; //日期 (default to undefined)

const { status, data } = await apiInstance.getWordsByDate(
    date
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **date** | [**string**] | 日期 | defaults to undefined|


### Return type

**BaseResponseListDailyWordResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getWorkflowAssistants**
> BaseResponseListLong getWorkflowAssistants()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)

const { status, data } = await apiInstance.getWorkflowAssistants(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseListLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **handleFriendRequest**
> BaseResponseBoolean handleFriendRequest(handleFriendRequestDTO)

接受或拒绝好友申请

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    HandleFriendRequestDTO
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let handleFriendRequestDTO: HandleFriendRequestDTO; //

const { status, data } = await apiInstance.handleFriendRequest(
    handleFriendRequestDTO
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **handleFriendRequestDTO** | **HandleFriendRequestDTO**|  | |


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **handleJoinRequest**
> BaseResponseVoid handleJoinRequest(handleJoinRequestDTO)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    HandleJoinRequestDTO
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let requestId: number; // (default to undefined)
let handleJoinRequestDTO: HandleJoinRequestDTO; //

const { status, data } = await apiInstance.handleJoinRequest(
    requestId,
    handleJoinRequestDTO
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **handleJoinRequestDTO** | **HandleJoinRequestDTO**|  | |
| **requestId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **health**
> BaseResponseString health()

检查服务是否正常运行

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.health();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseString**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **inviteMember**
> BaseResponseVoid inviteMember()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)
let inviteeId: number; // (default to undefined)

const { status, data } = await apiInstance.inviteMember(
    groupId,
    inviteeId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] |  | defaults to undefined|
| **inviteeId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **isFollowing**
> BaseResponseBoolean isFollowing()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let targetUserId: number; // (default to undefined)

const { status, data } = await apiInstance.isFollowing(
    targetUserId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **targetUserId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbAddDocument**
> BaseResponseKnowledgeDocumentVO kbAddDocument(requestBody)


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)
let userId: number; // (default to undefined)
let requestBody: { [key: string]: object; }; //

const { status, data } = await apiInstance.kbAddDocument(
    id,
    userId,
    requestBody
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **requestBody** | **{ [key: string]: object; }**|  | |
| **id** | [**number**] |  | defaults to undefined|
| **userId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseKnowledgeDocumentVO**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbBatchProcessByKnowledgeBase**
> BaseResponseBatchProcessResult kbBatchProcessByKnowledgeBase()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.kbBatchProcessByKnowledgeBase(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBatchProcessResult**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbBatchProcessDocuments**
> BaseResponseBatchProcessResult kbBatchProcessDocuments(requestBody)


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)
let requestBody: Array<number>; //

const { status, data } = await apiInstance.kbBatchProcessDocuments(
    id,
    requestBody
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **requestBody** | **Array<number>**|  | |
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBatchProcessResult**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbBatchProcessDocumentsAsync**
> BaseResponseString kbBatchProcessDocumentsAsync(requestBody)


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)
let requestBody: Array<number>; //

const { status, data } = await apiInstance.kbBatchProcessDocumentsAsync(
    id,
    requestBody
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **requestBody** | **Array<number>**|  | |
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseString**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbCreate**
> BaseResponseKnowledgeBaseVO kbCreate(createKnowledgeBaseCommand)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateKnowledgeBaseCommand
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let userId: number; // (default to undefined)
let createKnowledgeBaseCommand: CreateKnowledgeBaseCommand; //

const { status, data } = await apiInstance.kbCreate(
    userId,
    createKnowledgeBaseCommand
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createKnowledgeBaseCommand** | **CreateKnowledgeBaseCommand**|  | |
| **userId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseKnowledgeBaseVO**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbDelete**
> BaseResponseVoid kbDelete()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.kbDelete(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbDeleteDocument**
> BaseResponseVoid kbDeleteDocument()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)
let docId: number; // (default to undefined)

const { status, data } = await apiInstance.kbDeleteDocument(
    id,
    docId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|
| **docId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbGetById**
> BaseResponseKnowledgeBaseVO kbGetById()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.kbGetById(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseKnowledgeBaseVO**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbListByCreator**
> BaseResponseListKnowledgeBaseVO kbListByCreator()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let userId: number; // (default to undefined)
let page: number; // (optional) (default to 0)
let size: number; // (optional) (default to 20)

const { status, data } = await apiInstance.kbListByCreator(
    userId,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **userId** | [**number**] |  | defaults to undefined|
| **page** | [**number**] |  | (optional) defaults to 0|
| **size** | [**number**] |  | (optional) defaults to 20|


### Return type

**BaseResponseListKnowledgeBaseVO**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbListChunks**
> BaseResponseMapStringObject kbListChunks()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)
let docId: number; // (default to undefined)
let page: number; // (optional) (default to 0)
let size: number; // (optional) (default to 20)

const { status, data } = await apiInstance.kbListChunks(
    id,
    docId,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|
| **docId** | [**number**] |  | defaults to undefined|
| **page** | [**number**] |  | (optional) defaults to 0|
| **size** | [**number**] |  | (optional) defaults to 20|


### Return type

**BaseResponseMapStringObject**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbListDocuments**
> BaseResponseListKnowledgeDocumentVO kbListDocuments()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)
let page: number; // (optional) (default to 0)
let size: number; // (optional) (default to 20)

const { status, data } = await apiInstance.kbListDocuments(
    id,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|
| **page** | [**number**] |  | (optional) defaults to 0|
| **size** | [**number**] |  | (optional) defaults to 20|


### Return type

**BaseResponseListKnowledgeDocumentVO**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbProcessDocument**
> BaseResponseVoid kbProcessDocument()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)
let docId: number; // (default to undefined)

const { status, data } = await apiInstance.kbProcessDocument(
    id,
    docId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|
| **docId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbRecallTest**
> BaseResponseMapStringObject kbRecallTest(requestBody)

输入查询文本，返回向量检索+Rerank后的召回结果，用于调试知识库检索效果

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)
let requestBody: { [key: string]: object; }; //

const { status, data } = await apiInstance.kbRecallTest(
    id,
    requestBody
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **requestBody** | **{ [key: string]: object; }**|  | |
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseMapStringObject**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbSearch**
> BaseResponseListKnowledgeBaseVO kbSearch()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let keyword: string; // (default to undefined)
let userId: number; // (default to undefined)
let page: number; // (optional) (default to 0)
let size: number; // (optional) (default to 20)

const { status, data } = await apiInstance.kbSearch(
    keyword,
    userId,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **keyword** | [**string**] |  | defaults to undefined|
| **userId** | [**number**] |  | defaults to undefined|
| **page** | [**number**] |  | (optional) defaults to 0|
| **size** | [**number**] |  | (optional) defaults to 20|


### Return type

**BaseResponseListKnowledgeBaseVO**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbUpdate**
> BaseResponseKnowledgeBaseVO kbUpdate(updateKnowledgeBaseCommand)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateKnowledgeBaseCommand
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)
let updateKnowledgeBaseCommand: UpdateKnowledgeBaseCommand; //

const { status, data } = await apiInstance.kbUpdate(
    id,
    updateKnowledgeBaseCommand
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateKnowledgeBaseCommand** | **UpdateKnowledgeBaseCommand**|  | |
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseKnowledgeBaseVO**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kbUpdateDocument**
> BaseResponseKnowledgeDocumentVO kbUpdateDocument(requestBody)


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)
let docId: number; // (default to undefined)
let requestBody: { [key: string]: string; }; //

const { status, data } = await apiInstance.kbUpdateDocument(
    id,
    docId,
    requestBody
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **requestBody** | **{ [key: string]: string; }**|  | |
| **id** | [**number**] |  | defaults to undefined|
| **docId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseKnowledgeDocumentVO**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **leaveGroup**
> BaseResponseVoid leaveGroup()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)

const { status, data } = await apiInstance.leaveGroup(
    groupId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAllTemplates**
> BaseResponseListExamTemplateResponse listAllTemplates()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.listAllTemplates();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseListExamTemplateResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAllowedTables**
> BaseResponseListMapStringObject listAllowedTables()

返回工作流数据库查询节点允许访问的安全表名及字段信息

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.listAllowedTables();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseListMapStringObject**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listApplications**
> BaseResponseListTeacherApplicationResponse listApplications()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let status: number; //状态：0-待审核，1-已通过，2-已拒绝 (optional) (default to undefined)
let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.listApplications(
    status,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **status** | [**number**] | 状态：0-待审核，1-已通过，2-已拒绝 | (optional) defaults to undefined|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseListTeacherApplicationResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listArticles**
> BaseResponseDailyArticlePageResponse listArticles()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let category: string; //分类 (optional) (default to undefined)
let difficulty: number; //难度等级 (optional) (default to undefined)
let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.listArticles(
    category,
    difficulty,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **category** | [**string**] | 分类 | (optional) defaults to undefined|
| **difficulty** | [**number**] | 难度等级 | (optional) defaults to undefined|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseDailyArticlePageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAvailableModels**
> BaseResponseListMapStringObject listAvailableModels()

返回所有已启用的AI模型，供工作流LLM节点选择

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.listAvailableModels();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseListMapStringObject**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listBooks**
> BaseResponseListBookDTO listBooks()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let page: number; // (optional) (default to 1)
let size: number; // (optional) (default to 20)

const { status, data } = await apiInstance.listBooks(
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **page** | [**number**] |  | (optional) defaults to 1|
| **size** | [**number**] |  | (optional) defaults to 20|


### Return type

**BaseResponseListBookDTO**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listByUser**
> BaseResponseListWorkflowResponse listByUser()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let userId: number; //用户ID (default to undefined)
let page: number; //页码，从0开始 (optional) (default to 0)
let size: number; //每页数量 (optional) (default to 20)

const { status, data } = await apiInstance.listByUser(
    userId,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **userId** | [**number**] | 用户ID | defaults to undefined|
| **page** | [**number**] | 页码，从0开始 | (optional) defaults to 0|
| **size** | [**number**] | 每页数量 | (optional) defaults to 20|


### Return type

**BaseResponseListWorkflowResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listChapters**
> BaseResponseListChapterResponse listChapters()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)

const { status, data } = await apiInstance.listChapters(
    courseId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **courseId** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseListChapterResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listClasses**
> BaseResponsePageResponseClassResponse listClasses()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 10)
let keyword: string; // (optional) (default to undefined)

const { status, data } = await apiInstance.listClasses(
    pageNum,
    pageSize,
    keyword
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 10|
| **keyword** | [**string**] |  | (optional) defaults to undefined|


### Return type

**BaseResponsePageResponseClassResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listCourses**
> BaseResponseListCourseResponse listCourses()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let status: number; //状态：0-未发布，1-已发布，2-已下架 (optional) (default to undefined)
let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.listCourses(
    status,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **status** | [**number**] | 状态：0-未发布，1-已发布，2-已下架 | (optional) defaults to undefined|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseListCourseResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listCoursesByTeacher**
> BaseResponseListCourseResponse listCoursesByTeacher()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let teacherId: number; //讲师ID (default to undefined)
let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.listCoursesByTeacher(
    teacherId,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **teacherId** | [**number**] | 讲师ID | defaults to undefined|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseListCourseResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listExecutions**
> BaseResponseListExecutionResultResponse listExecutions()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let page: number; //页码，从0开始 (optional) (default to 0)
let size: number; //每页数量 (optional) (default to 20)

const { status, data } = await apiInstance.listExecutions(
    id,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|
| **page** | [**number**] | 页码，从0开始 | (optional) defaults to 0|
| **size** | [**number**] | 每页数量 | (optional) defaults to 20|


### Return type

**BaseResponseListExecutionResultResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listGroups**
> BaseResponseAdminGroupPageResponse listGroups()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let pageNum: number; //页码 (optional) (default to 1)
let pageSize: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.listGroups(
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **pageNum** | [**number**] | 页码 | (optional) defaults to 1|
| **pageSize** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseAdminGroupPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listOrders**
> BaseResponseListOrderResponse listOrders()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let status: number; //订单状态：0-未支付，1-已支付，2-已过期，3-已退款 (optional) (default to undefined)
let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.listOrders(
    status,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **status** | [**number**] | 订单状态：0-未支付，1-已支付，2-已过期，3-已退款 | (optional) defaults to undefined|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseListOrderResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listPublic**
> BaseResponseListWorkflowResponse listPublic()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let page: number; //页码，从0开始 (optional) (default to 0)
let size: number; //每页数量 (optional) (default to 20)

const { status, data } = await apiInstance.listPublic(
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **page** | [**number**] | 页码，从0开始 | (optional) defaults to 0|
| **size** | [**number**] | 每页数量 | (optional) defaults to 20|


### Return type

**BaseResponseListWorkflowResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listReviews**
> BaseResponseListCourseReviewResponse listReviews()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)
let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.listReviews(
    courseId,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **courseId** | [**number**] | 课程ID | defaults to undefined|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseListCourseReviewResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listSections**
> BaseResponseListSectionResponse listSections()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)

const { status, data } = await apiInstance.listSections(
    courseId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **courseId** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseListSectionResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listSystemTemplates**
> BaseResponseListWorkflowTemplateResponse listSystemTemplates()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.listSystemTemplates();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseListWorkflowTemplateResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listTeachers**
> BaseResponseListTeacherResponse listTeachers()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)
let keyword: string; //搜索关键词（讲师姓名） (optional) (default to undefined)

const { status, data } = await apiInstance.listTeachers(
    page,
    size,
    keyword
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|
| **keyword** | [**string**] | 搜索关键词（讲师姓名） | (optional) defaults to undefined|


### Return type

**BaseResponseListTeacherResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listTemplates1**
> BaseResponseListExamTemplateResponse listTemplates1()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

const { status, data } = await apiInstance.listTemplates1();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseListExamTemplateResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listTriggers**
> BaseResponseListWorkflowTriggerResponse listTriggers()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)

const { status, data } = await apiInstance.listTriggers(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseListWorkflowTriggerResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listVersions**
> BaseResponseListWorkflowVersionResponse listVersions()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)

const { status, data } = await apiInstance.listVersions(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseListWorkflowVersionResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listWords**
> BaseResponseDailyWordPageResponse listWords()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let category: string; //分类 (optional) (default to undefined)
let difficulty: number; //难度等级 (optional) (default to undefined)
let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.listWords(
    category,
    difficulty,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **category** | [**string**] | 分类 | (optional) defaults to undefined|
| **difficulty** | [**number**] | 难度等级 | (optional) defaults to undefined|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseDailyWordPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markAsRead**
> BaseResponseVoid markAsRead()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let articleId: number; //文章ID (default to undefined)

const { status, data } = await apiInstance.markAsRead(
    articleId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **articleId** | [**number**] | 文章ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markAsRead1**
> BaseResponseVoid markAsRead1()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)
let messageId: number; // (default to undefined)

const { status, data } = await apiInstance.markAsRead1(
    groupId,
    messageId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] |  | defaults to undefined|
| **messageId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markAsRead2**
> BaseResponseBoolean markAsRead2()

标记与指定用户的消息为已读

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let senderId: number; // (default to undefined)

const { status, data } = await apiInstance.markAsRead2(
    senderId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **senderId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markAsRead3**
> BaseResponseBoolean markAsRead3()

将公告标记为已读

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.markAsRead3(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markRepliesAsRead**
> BaseResponseBoolean markRepliesAsRead()

将反馈的所有回复标记为已读

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.markRepliesAsRead(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **offlineAnnouncement**
> BaseResponseBoolean offlineAnnouncement()

将公告状态改为已下线

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.offlineAnnouncement(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **offlineBanner**
> BaseResponseBoolean offlineBanner()

将轮播图状态设置为已下线

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.offlineBanner(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **phoneLogin**
> BaseResponseLoginUserResponse phoneLogin(phoneLoginRequest)

使用手机号和验证码登录，未注册用户自动注册

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    PhoneLoginRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let phoneLoginRequest: PhoneLoginRequest; //

const { status, data } = await apiInstance.phoneLogin(
    phoneLoginRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **phoneLoginRequest** | **PhoneLoginRequest**|  | |


### Return type

**BaseResponseLoginUserResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **previewPdf**
> string previewPdf()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.previewPdf(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**string**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **previewTemplate**
> string previewTemplate()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //模板ID (default to undefined)

const { status, data } = await apiInstance.previewTemplate(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 模板ID | defaults to undefined|


### Return type

**string**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publish**
> BaseResponseWorkflowResponse publish()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)

const { status, data } = await apiInstance.publish(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseWorkflowResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publishAnnouncement**
> BaseResponseVoid publishAnnouncement(body)


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)
let body: string; //

const { status, data } = await apiInstance.publishAnnouncement(
    groupId,
    body
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **body** | **string**|  | |
| **groupId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publishAnnouncement1**
> BaseResponseBoolean publishAnnouncement1()

将公告状态改为已发布

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.publishAnnouncement1(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publishBanner**
> BaseResponseBoolean publishBanner()

将轮播图状态设置为已发布

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.publishBanner(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publishCourse**
> BaseResponseVoid publishCourse()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //课程ID (default to undefined)

const { status, data } = await apiInstance.publishCourse(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publishExamPaper**
> BaseResponseBoolean publishExamPaper()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.publishExamPaper(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **queryAnnouncements**
> BaseResponseAnnouncementPageResponse queryAnnouncements(queryAnnouncementRequest)

管理员分页查询公告列表

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    QueryAnnouncementRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let queryAnnouncementRequest: QueryAnnouncementRequest; //

const { status, data } = await apiInstance.queryAnnouncements(
    queryAnnouncementRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **queryAnnouncementRequest** | **QueryAnnouncementRequest**|  | |


### Return type

**BaseResponseAnnouncementPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **queryBanners**
> BaseResponseBannerPageResponse queryBanners()

分页查询轮播图列表

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    QueryBannerRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let request: QueryBannerRequest; // (default to undefined)

const { status, data } = await apiInstance.queryBanners(
    request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **request** | **QueryBannerRequest** |  | defaults to undefined|


### Return type

**BaseResponseBannerPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **queryExamPapers**
> BaseResponseExamPaperPageResponse queryExamPapers()


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    QueryExamPaperRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let request: QueryExamPaperRequest; // (default to undefined)

const { status, data } = await apiInstance.queryExamPapers(
    request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **request** | **QueryExamPaperRequest** |  | defaults to undefined|


### Return type

**BaseResponseExamPaperPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **queryFeedbacks**
> BaseResponseFeedbackPageResponse queryFeedbacks(queryFeedbackRequest)

管理员分页查询所有反馈

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    QueryFeedbackRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let queryFeedbackRequest: QueryFeedbackRequest; //

const { status, data } = await apiInstance.queryFeedbacks(
    queryFeedbackRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **queryFeedbackRequest** | **QueryFeedbackRequest**|  | |


### Return type

**BaseResponseFeedbackPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **queryMyQuestions**
> BaseResponseQuestionPageResponse queryMyQuestions()


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    QueryQuestionRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let request: QueryQuestionRequest; // (default to undefined)

const { status, data } = await apiInstance.queryMyQuestions(
    request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **request** | **QueryQuestionRequest** |  | defaults to undefined|


### Return type

**BaseResponseQuestionPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **queryQuestions**
> BaseResponseQuestionPageResponse queryQuestions()


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    QueryQuestionRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let request: QueryQuestionRequest; // (default to undefined)

const { status, data } = await apiInstance.queryQuestions(
    request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **request** | **QueryQuestionRequest** |  | defaults to undefined|


### Return type

**BaseResponseQuestionPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **queryUsers**
> BaseResponseUserPageResponse queryUsers(queryUserRequest)

管理员分页查询用户，支持模糊搜索

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    QueryUserRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let queryUserRequest: QueryUserRequest; //

const { status, data } = await apiInstance.queryUsers(
    queryUserRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **queryUserRequest** | **QueryUserRequest**|  | |


### Return type

**BaseResponseUserPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **quickDynamicScrape**
> BaseResponseArticleResponse quickDynamicScrape()

通过GET方式快速动态抓取单个页面

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let url: string; // (default to undefined)
let waitForJsMs: number; // (optional) (default to 3000)

const { status, data } = await apiInstance.quickDynamicScrape(
    url,
    waitForJsMs
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **url** | [**string**] |  | defaults to undefined|
| **waitForJsMs** | [**number**] |  | (optional) defaults to 3000|


### Return type

**BaseResponseArticleResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **quickScrape**
> BaseResponseArticleResponse quickScrape()

通过GET方式快速抓取单个页面

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let url: string; // (default to undefined)

const { status, data } = await apiInstance.quickScrape(
    url
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **url** | [**string**] |  | defaults to undefined|


### Return type

**BaseResponseArticleResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refreshToken**
> BaseResponseRefreshTokenResponse refreshToken(refreshTokenRequest)

使用Refresh Token获取新的Access Token和Refresh Token

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    RefreshTokenRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let refreshTokenRequest: RefreshTokenRequest; //

const { status, data } = await apiInstance.refreshToken(
    refreshTokenRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **refreshTokenRequest** | **RefreshTokenRequest**|  | |


### Return type

**BaseResponseRefreshTokenResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refund**
> BaseResponseVoid refund()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let orderNo: string; //订单号 (default to undefined)

const { status, data } = await apiInstance.refund(
    orderNo
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **orderNo** | [**string**] | 订单号 | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeCourse**
> BaseResponseVoid removeCourse()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let classId: number; // (default to undefined)
let courseId: number; // (default to undefined)

const { status, data } = await apiInstance.removeCourse(
    classId,
    courseId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **classId** | [**number**] |  | defaults to undefined|
| **courseId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeFromShelf**
> BaseResponseVoid removeFromShelf()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let userId: number; // (default to undefined)
let bookId: number; // (default to undefined)

const { status, data } = await apiInstance.removeFromShelf(
    userId,
    bookId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **userId** | [**number**] |  | defaults to undefined|
| **bookId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeFromWordBook**
> BaseResponseVoid removeFromWordBook()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let wordBookId: number; //生词本记录ID (default to undefined)

const { status, data } = await apiInstance.removeFromWordBook(
    wordBookId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **wordBookId** | [**number**] | 生词本记录ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeMember**
> BaseResponseVoid removeMember()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)
let targetUserId: number; // (default to undefined)

const { status, data } = await apiInstance.removeMember(
    groupId,
    targetUserId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] |  | defaults to undefined|
| **targetUserId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeMember1**
> BaseResponseVoid removeMember1()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let classId: number; // (default to undefined)
let userId: number; // (default to undefined)

const { status, data } = await apiInstance.removeMember1(
    classId,
    userId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **classId** | [**number**] |  | defaults to undefined|
| **userId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeMember2**
> BaseResponseVoid removeMember2()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; //群ID (default to undefined)
let targetUserId: number; //目标用户ID (default to undefined)

const { status, data } = await apiInstance.removeMember2(
    groupId,
    targetUserId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] | 群ID | defaults to undefined|
| **targetUserId** | [**number**] | 目标用户ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removePaperQuestion**
> BaseResponseBoolean removePaperQuestion()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let paperId: number; // (default to undefined)
let sectionId: number; // (default to undefined)
let pqId: number; // (default to undefined)

const { status, data } = await apiInstance.removePaperQuestion(
    paperId,
    sectionId,
    pqId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **paperId** | [**number**] |  | defaults to undefined|
| **sectionId** | [**number**] |  | defaults to undefined|
| **pqId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeTeacher**
> BaseResponseVoid removeTeacher()

管理员移除讲师，用户角色降回学生，需重新申请

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //讲师ID (default to undefined)

const { status, data } = await apiInstance.removeTeacher(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 讲师ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **replyFeedback**
> BaseResponseLong replyFeedback(createReplyRequest)

用户回复自己的反馈

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateReplyRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let createReplyRequest: CreateReplyRequest; //

const { status, data } = await apiInstance.replyFeedback(
    createReplyRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createReplyRequest** | **CreateReplyRequest**|  | |


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **replyFeedback1**
> BaseResponseLong replyFeedback1(createReplyRequest)

管理员回复用户反馈

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    CreateReplyRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let createReplyRequest: CreateReplyRequest; //

const { status, data } = await apiInstance.replyFeedback1(
    createReplyRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createReplyRequest** | **CreateReplyRequest**|  | |


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resetPassword**
> BaseResponseBoolean resetPassword(resetPasswordRequest)

管理员重置指定用户的密码

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    ResetPasswordRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let resetPasswordRequest: ResetPasswordRequest; //

const { status, data } = await apiInstance.resetPassword(
    resetPasswordRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **resetPasswordRequest** | **ResetPasswordRequest**|  | |


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resetProgress**
> BaseResponseVoid resetProgress()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let sectionId: number; //小节ID (default to undefined)

const { status, data } = await apiInstance.resetProgress(
    sectionId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **sectionId** | [**number**] | 小节ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewApplication**
> BaseResponseVoid reviewApplication(reviewApplicationRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    ReviewApplicationRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let reviewApplicationRequest: ReviewApplicationRequest; //

const { status, data } = await apiInstance.reviewApplication(
    reviewApplicationRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **reviewApplicationRequest** | **ReviewApplicationRequest**|  | |


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewCourse**
> BaseResponseLong reviewCourse(reviewCourseRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    ReviewCourseRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)
let reviewCourseRequest: ReviewCourseRequest; //

const { status, data } = await apiInstance.reviewCourse(
    courseId,
    reviewCourseRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **reviewCourseRequest** | **ReviewCourseRequest**|  | |
| **courseId** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rollbackToVersion**
> BaseResponseWorkflowResponse rollbackToVersion()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let versionNumber: number; //版本号 (default to undefined)

const { status, data } = await apiInstance.rollbackToVersion(
    id,
    versionNumber
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|
| **versionNumber** | [**number**] | 版本号 | defaults to undefined|


### Return type

**BaseResponseWorkflowResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeArticleLinks**
> BaseResponseListString scrapeArticleLinks(scrapeRequest)

从列表页获取所有文章链接

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    ScrapeRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let scrapeRequest: ScrapeRequest; //

const { status, data } = await apiInstance.scrapeArticleLinks(
    scrapeRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **scrapeRequest** | **ScrapeRequest**|  | |


### Return type

**BaseResponseListString**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeDynamicArticleLinks**
> BaseResponseListString scrapeDynamicArticleLinks(dynamicScrapeRequest)

从动态页面获取所有文章链接

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    DynamicScrapeRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let dynamicScrapeRequest: DynamicScrapeRequest; //

const { status, data } = await apiInstance.scrapeDynamicArticleLinks(
    dynamicScrapeRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **dynamicScrapeRequest** | **DynamicScrapeRequest**|  | |


### Return type

**BaseResponseListString**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeDynamicMultiplePages**
> BaseResponseScrapeResultResponse scrapeDynamicMultiplePages(batchScrapeRequest)

批量抓取多个动态页面

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    BatchScrapeRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let batchScrapeRequest: BatchScrapeRequest; //
let waitForJsMs: number; // (optional) (default to 3000)

const { status, data } = await apiInstance.scrapeDynamicMultiplePages(
    batchScrapeRequest,
    waitForJsMs
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **batchScrapeRequest** | **BatchScrapeRequest**|  | |
| **waitForJsMs** | [**number**] |  | (optional) defaults to 3000|


### Return type

**BaseResponseScrapeResultResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeDynamicPage**
> BaseResponseArticleResponse scrapeDynamicPage(dynamicScrapeRequest)

使用无头浏览器抓取 JavaScript 渲染的动态页面

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    DynamicScrapeRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let dynamicScrapeRequest: DynamicScrapeRequest; //

const { status, data } = await apiInstance.scrapeDynamicPage(
    dynamicScrapeRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **dynamicScrapeRequest** | **DynamicScrapeRequest**|  | |


### Return type

**BaseResponseArticleResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeDynamicPageWithSelector**
> BaseResponseArticleResponse scrapeDynamicPageWithSelector(dynamicScrapeRequest)

等待页面特定元素加载后再抓取

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    DynamicScrapeRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let dynamicScrapeRequest: DynamicScrapeRequest; //

const { status, data } = await apiInstance.scrapeDynamicPageWithSelector(
    dynamicScrapeRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **dynamicScrapeRequest** | **DynamicScrapeRequest**|  | |


### Return type

**BaseResponseArticleResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeDynamicRecursively**
> BaseResponseScrapeResultResponse scrapeDynamicRecursively(dynamicScrapeRequest)

递归抓取动态网站，支持 SPA 和 JavaScript 渲染页面

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    DynamicScrapeRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let dynamicScrapeRequest: DynamicScrapeRequest; //

const { status, data } = await apiInstance.scrapeDynamicRecursively(
    dynamicScrapeRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **dynamicScrapeRequest** | **DynamicScrapeRequest**|  | |


### Return type

**BaseResponseScrapeResultResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeFromSource**
> BaseResponseScrapeResultResponse scrapeFromSource(sourceScrapeRequest)

使用预设的来源配置抓取内容，支持 Dogo News、Science News for Students 等

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    SourceScrapeRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let sourceScrapeRequest: SourceScrapeRequest; //

const { status, data } = await apiInstance.scrapeFromSource(
    sourceScrapeRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **sourceScrapeRequest** | **SourceScrapeRequest**|  | |


### Return type

**BaseResponseScrapeResultResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeMultiplePages**
> BaseResponseScrapeResultResponse scrapeMultiplePages(batchScrapeRequest)

批量抓取多个URL的页面内容

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    BatchScrapeRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let batchScrapeRequest: BatchScrapeRequest; //

const { status, data } = await apiInstance.scrapeMultiplePages(
    batchScrapeRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **batchScrapeRequest** | **BatchScrapeRequest**|  | |


### Return type

**BaseResponseScrapeResultResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeRecursively**
> BaseResponseScrapeResultResponse scrapeRecursively(scrapeRequest)

从起始URL开始递归抓取网站内容，支持嵌套页面扫描

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    ScrapeRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let scrapeRequest: ScrapeRequest; //

const { status, data } = await apiInstance.scrapeRecursively(
    scrapeRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **scrapeRequest** | **ScrapeRequest**|  | |


### Return type

**BaseResponseScrapeResultResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scrapeSinglePage**
> BaseResponseArticleResponse scrapeSinglePage(scrapeRequest)

抓取指定URL的页面内容，提取标题、作者、来源、正文等信息

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    ScrapeRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let scrapeRequest: ScrapeRequest; //

const { status, data } = await apiInstance.scrapeSinglePage(
    scrapeRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **scrapeRequest** | **ScrapeRequest**|  | |


### Return type

**BaseResponseArticleResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchArticles**
> BaseResponseDailyArticlePageResponse searchArticles()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let keyword: string; //关键词 (default to undefined)
let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.searchArticles(
    keyword,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **keyword** | [**string**] | 关键词 | defaults to undefined|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseDailyArticlePageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchBooks**
> BaseResponseListBookDTO searchBooks()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let keyword: string; // (default to undefined)
let page: number; // (optional) (default to 1)
let size: number; // (optional) (default to 20)

const { status, data } = await apiInstance.searchBooks(
    keyword,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **keyword** | [**string**] |  | defaults to undefined|
| **page** | [**number**] |  | (optional) defaults to 1|
| **size** | [**number**] |  | (optional) defaults to 20|


### Return type

**BaseResponseListBookDTO**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchCourses**
> BaseResponseListCourseResponse searchCourses()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let keyword: string; //关键词 (default to undefined)
let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.searchCourses(
    keyword,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **keyword** | [**string**] | 关键词 | defaults to undefined|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseListCourseResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchGroups**
> BaseResponseGroupPage searchGroups()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let keyword: string; // (default to undefined)
let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 20)

const { status, data } = await apiInstance.searchGroups(
    keyword,
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **keyword** | [**string**] |  | defaults to undefined|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 20|


### Return type

**BaseResponseGroupPage**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchGroups1**
> BaseResponseAdminGroupPageResponse searchGroups1()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let keyword: string; //关键词 (default to undefined)
let pageNum: number; //页码 (optional) (default to 1)
let pageSize: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.searchGroups1(
    keyword,
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **keyword** | [**string**] | 关键词 | defaults to undefined|
| **pageNum** | [**number**] | 页码 | (optional) defaults to 1|
| **pageSize** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseAdminGroupPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchPosts**
> BaseResponsePostPageResponse searchPosts()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let keyword: string; // (default to undefined)
let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 10)

const { status, data } = await apiInstance.searchPosts(
    keyword,
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **keyword** | [**string**] |  | defaults to undefined|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 10|


### Return type

**BaseResponsePostPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchPostsByTag**
> BaseResponsePostPageResponse searchPostsByTag()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let tag: string; // (default to undefined)
let pageNum: number; // (optional) (default to 1)
let pageSize: number; // (optional) (default to 10)

const { status, data } = await apiInstance.searchPostsByTag(
    tag,
    pageNum,
    pageSize
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **tag** | [**string**] |  | defaults to undefined|
| **pageNum** | [**number**] |  | (optional) defaults to 1|
| **pageSize** | [**number**] |  | (optional) defaults to 10|


### Return type

**BaseResponsePostPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchTemplates**
> BaseResponseListWorkflowTemplateResponse searchTemplates()

返回公开模板 + 当前用户自己创建的私有模板

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let keyword: string; //关键词 (optional) (default to undefined)
let category: string; //分类 (optional) (default to undefined)
let page: number; //页码 (optional) (default to 0)
let size: number; //每页数量 (optional) (default to 20)

const { status, data } = await apiInstance.searchTemplates(
    keyword,
    category,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **keyword** | [**string**] | 关键词 | (optional) defaults to undefined|
| **category** | [**string**] | 分类 | (optional) defaults to undefined|
| **page** | [**number**] | 页码 | (optional) defaults to 0|
| **size** | [**number**] | 每页数量 | (optional) defaults to 20|


### Return type

**BaseResponseListWorkflowTemplateResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchUsers**
> BaseResponseSearchUserPageResponse searchUsers(searchUserRequestDTO)

根据关键词搜索用户，用于添加好友

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    SearchUserRequestDTO
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let searchUserRequestDTO: SearchUserRequestDTO; //

const { status, data } = await apiInstance.searchUsers(
    searchUserRequestDTO
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **searchUserRequestDTO** | **SearchUserRequestDTO**|  | |


### Return type

**BaseResponseSearchUserPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchWords**
> BaseResponseDailyWordPageResponse searchWords()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let keyword: string; //关键词 (default to undefined)
let page: number; //页码 (optional) (default to 1)
let size: number; //每页数量 (optional) (default to 10)

const { status, data } = await apiInstance.searchWords(
    keyword,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **keyword** | [**string**] | 关键词 | defaults to undefined|
| **page** | [**number**] | 页码 | (optional) defaults to 1|
| **size** | [**number**] | 每页数量 | (optional) defaults to 10|


### Return type

**BaseResponseDailyWordPageResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendFriendRequest**
> BaseResponseLong sendFriendRequest(sendFriendRequestDTO)

向指定用户发送好友申请

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    SendFriendRequestDTO
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let sendFriendRequestDTO: SendFriendRequestDTO; //

const { status, data } = await apiInstance.sendFriendRequest(
    sendFriendRequestDTO
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **sendFriendRequestDTO** | **SendFriendRequestDTO**|  | |


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendRegisterCode**
> BaseResponseSendResult sendRegisterCode(sendCodeRequest)

发送短信验证码用于注册

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    SendCodeRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let sendCodeRequest: SendCodeRequest; //

const { status, data } = await apiInstance.sendRegisterCode(
    sendCodeRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **sendCodeRequest** | **SendCodeRequest**|  | |


### Return type

**BaseResponseSendResult**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendSms**
> BaseResponseSendResult sendSms(sendSmsRequest)

管理员手动发送短信验证码

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    SendSmsRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let sendSmsRequest: SendSmsRequest; //

const { status, data } = await apiInstance.sendSms(
    sendSmsRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **sendSmsRequest** | **SendSmsRequest**|  | |


### Return type

**BaseResponseSendResult**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setAdmin**
> BaseResponseVoid setAdmin()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)
let targetUserId: number; // (default to undefined)
let isAdmin: boolean; // (default to undefined)

const { status, data } = await apiInstance.setAdmin(
    groupId,
    targetUserId,
    isAdmin
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] |  | defaults to undefined|
| **targetUserId** | [**number**] |  | defaults to undefined|
| **isAdmin** | [**boolean**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setJoinMode**
> BaseResponseVoid setJoinMode()

0-自由加入，1-需审批，2-禁止加入

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)
let mode: number; // (default to undefined)

const { status, data } = await apiInstance.setJoinMode(
    groupId,
    mode
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] |  | defaults to undefined|
| **mode** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setMute**
> BaseResponseVoid setMute()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; //群ID (default to undefined)
let mute: boolean; //是否禁言 (default to undefined)

const { status, data } = await apiInstance.setMute(
    groupId,
    mute
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] | 群ID | defaults to undefined|
| **mute** | [**boolean**] | 是否禁言 | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **smartDynamicScrape**
> BaseResponseScrapeResultResponse smartDynamicScrape()

自动检测是否需要动态抓取，先尝试静态抓取，失败后自动切换到动态抓取

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let url: string; // (default to undefined)
let maxArticles: number; // (optional) (default to 10)
let forceDynamic: boolean; // (optional) (default to false)

const { status, data } = await apiInstance.smartDynamicScrape(
    url,
    maxArticles,
    forceDynamic
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **url** | [**string**] |  | defaults to undefined|
| **maxArticles** | [**number**] |  | (optional) defaults to 10|
| **forceDynamic** | [**boolean**] |  | (optional) defaults to false|


### Return type

**BaseResponseScrapeResultResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **smartScrape**
> BaseResponseScrapeResultResponse smartScrape()

自动识别页面类型并使用最佳策略抓取

### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let url: string; // (default to undefined)
let maxArticles: number; // (optional) (default to 10)

const { status, data } = await apiInstance.smartScrape(
    url,
    maxArticles
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **url** | [**string**] |  | defaults to undefined|
| **maxArticles** | [**number**] |  | (optional) defaults to 10|


### Return type

**BaseResponseScrapeResultResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **studyWord**
> BaseResponseVoid studyWord()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let wordId: number; //单词ID (default to undefined)

const { status, data } = await apiInstance.studyWord(
    wordId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **wordId** | [**number**] | 单词ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **takeOffline**
> BaseResponseVoid takeOffline()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //课程ID (default to undefined)

const { status, data } = await apiInstance.takeOffline(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **textToSpeech**
> string textToSpeech(ttsRequest)

将文本转换为语音，返回音频文件

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    TtsRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let ttsRequest: TtsRequest; //

const { status, data } = await apiInstance.textToSpeech(
    ttsRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **ttsRequest** | **TtsRequest**|  | |


### Return type

**string**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **textToSpeechBase64**
> BaseResponseTtsResponse textToSpeechBase64(ttsRequest)

将文本转换为语音，返回 Base64 编码的音频数据

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    TtsRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let ttsRequest: TtsRequest; //

const { status, data } = await apiInstance.textToSpeechBase64(
    ttsRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **ttsRequest** | **TtsRequest**|  | |


### Return type

**BaseResponseTtsResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toggleCollect**
> BaseResponseVoid toggleCollect()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let wordId: number; //单词ID (default to undefined)

const { status, data } = await apiInstance.toggleCollect(
    wordId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **wordId** | [**number**] | 单词ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toggleCollect1**
> BaseResponseVoid toggleCollect1()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let articleId: number; //文章ID (default to undefined)

const { status, data } = await apiInstance.toggleCollect1(
    articleId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **articleId** | [**number**] | 文章ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toggleFavour**
> BaseResponseBoolean toggleFavour()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let postId: number; // (default to undefined)

const { status, data } = await apiInstance.toggleFavour(
    postId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **postId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toggleFollow**
> BaseResponseBoolean toggleFollow()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let targetUserId: number; // (default to undefined)

const { status, data } = await apiInstance.toggleFollow(
    targetUserId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **targetUserId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toggleLike**
> BaseResponseVoid toggleLike()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let articleId: number; //文章ID (default to undefined)

const { status, data } = await apiInstance.toggleLike(
    articleId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **articleId** | [**number**] | 文章ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toggleThumb**
> BaseResponseBoolean toggleThumb()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let postId: number; // (default to undefined)

const { status, data } = await apiInstance.toggleThumb(
    postId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **postId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **transferOwnership**
> BaseResponseVoid transferOwnership()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)
let newOwnerId: number; // (default to undefined)

const { status, data } = await apiInstance.transferOwnership(
    groupId,
    newOwnerId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **groupId** | [**number**] |  | defaults to undefined|
| **newOwnerId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unbindFromAssistant**
> BaseResponseVoid unbindFromAssistant()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let assistantId: number; //AI助手ID (default to undefined)

const { status, data } = await apiInstance.unbindFromAssistant(
    id,
    assistantId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|
| **assistantId** | [**number**] | AI助手ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unfavouriteCourse**
> BaseResponseVoid unfavouriteCourse()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)

const { status, data } = await apiInstance.unfavouriteCourse(
    courseId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **courseId** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unfollow**
> BaseResponseVoid unfollow()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let targetUserId: number; // (default to undefined)

const { status, data } = await apiInstance.unfollow(
    targetUserId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **targetUserId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unpublishExamPaper**
> BaseResponseBoolean unpublishExamPaper()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.unpublishExamPaper(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **update**
> BaseResponseWorkflowResponse update(updateWorkflowRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateWorkflowRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let updateWorkflowRequest: UpdateWorkflowRequest; //

const { status, data } = await apiInstance.update(
    id,
    updateWorkflowRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateWorkflowRequest** | **UpdateWorkflowRequest**|  | |
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseWorkflowResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateAnnouncement**
> BaseResponseBoolean updateAnnouncement(updateAnnouncementRequest)

更新公告信息

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateAnnouncementRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let updateAnnouncementRequest: UpdateAnnouncementRequest; //

const { status, data } = await apiInstance.updateAnnouncement(
    updateAnnouncementRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateAnnouncementRequest** | **UpdateAnnouncementRequest**|  | |


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateBanner**
> BaseResponseBoolean updateBanner(updateBannerRequest)

更新轮播图信息

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateBannerRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let updateBannerRequest: UpdateBannerRequest; //

const { status, data } = await apiInstance.updateBanner(
    updateBannerRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateBannerRequest** | **UpdateBannerRequest**|  | |


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateChapter**
> BaseResponseVoid updateChapter(updateChapterRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateChapterRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)
let chapterId: number; //章节ID (default to undefined)
let updateChapterRequest: UpdateChapterRequest; //

const { status, data } = await apiInstance.updateChapter(
    courseId,
    chapterId,
    updateChapterRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateChapterRequest** | **UpdateChapterRequest**|  | |
| **courseId** | [**number**] | 课程ID | defaults to undefined|
| **chapterId** | [**number**] | 章节ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateClass**
> BaseResponseVoid updateClass(updateClassRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateClassRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let classId: number; // (default to undefined)
let updateClassRequest: UpdateClassRequest; //

const { status, data } = await apiInstance.updateClass(
    classId,
    updateClassRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateClassRequest** | **UpdateClassRequest**|  | |
| **classId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateConfig**
> BaseResponseScraperConfigResponse updateConfig(scraperConfigRequest)

更新已有的抓取源配置

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    ScraperConfigRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)
let scraperConfigRequest: ScraperConfigRequest; //

const { status, data } = await apiInstance.updateConfig(
    id,
    scraperConfigRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **scraperConfigRequest** | **ScraperConfigRequest**|  | |
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseScraperConfigResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateCourse**
> BaseResponseVoid updateCourse(updateCourseRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateCourseRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //课程ID (default to undefined)
let updateCourseRequest: UpdateCourseRequest; //

const { status, data } = await apiInstance.updateCourse(
    id,
    updateCourseRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateCourseRequest** | **UpdateCourseRequest**|  | |
| **id** | [**number**] | 课程ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateDailyArticle**
> BaseResponseVoid updateDailyArticle(updateDailyArticleRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateDailyArticleRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //文章ID (default to undefined)
let updateDailyArticleRequest: UpdateDailyArticleRequest; //

const { status, data } = await apiInstance.updateDailyArticle(
    id,
    updateDailyArticleRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateDailyArticleRequest** | **UpdateDailyArticleRequest**|  | |
| **id** | [**number**] | 文章ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateDailyWord**
> BaseResponseVoid updateDailyWord(updateDailyWordRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateDailyWordRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //单词ID (default to undefined)
let updateDailyWordRequest: UpdateDailyWordRequest; //

const { status, data } = await apiInstance.updateDailyWord(
    id,
    updateDailyWordRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateDailyWordRequest** | **UpdateDailyWordRequest**|  | |
| **id** | [**number**] | 单词ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateDefinition**
> BaseResponseWorkflowResponse updateDefinition(updateWorkflowDefinitionRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateWorkflowDefinitionRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let updateWorkflowDefinitionRequest: UpdateWorkflowDefinitionRequest; //

const { status, data } = await apiInstance.updateDefinition(
    id,
    updateWorkflowDefinitionRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateWorkflowDefinitionRequest** | **UpdateWorkflowDefinitionRequest**|  | |
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseWorkflowResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateEdge**
> BaseResponseWorkflowEdgeResponse updateEdge(updateEdgeRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateEdgeRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let edgeId: string; //连接线ID (default to undefined)
let updateEdgeRequest: UpdateEdgeRequest; //

const { status, data } = await apiInstance.updateEdge(
    id,
    edgeId,
    updateEdgeRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateEdgeRequest** | **UpdateEdgeRequest**|  | |
| **id** | [**number**] | 工作流ID | defaults to undefined|
| **edgeId** | [**string**] | 连接线ID | defaults to undefined|


### Return type

**BaseResponseWorkflowEdgeResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateExamPaper**
> BaseResponseBoolean updateExamPaper(updateExamPaperRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateExamPaperRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let updateExamPaperRequest: UpdateExamPaperRequest; //

const { status, data } = await apiInstance.updateExamPaper(
    updateExamPaperRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateExamPaperRequest** | **UpdateExamPaperRequest**|  | |


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateFeedbackStatus**
> BaseResponseBoolean updateFeedbackStatus(updateFeedbackStatusRequest)

管理员更新反馈处理状态

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateFeedbackStatusRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let updateFeedbackStatusRequest: UpdateFeedbackStatusRequest; //

const { status, data } = await apiInstance.updateFeedbackStatus(
    updateFeedbackStatusRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateFeedbackStatusRequest** | **UpdateFeedbackStatusRequest**|  | |


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateGroupInfo**
> BaseResponseVoid updateGroupInfo(updateGroupRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateGroupRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; // (default to undefined)
let updateGroupRequest: UpdateGroupRequest; //

const { status, data } = await apiInstance.updateGroupInfo(
    groupId,
    updateGroupRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateGroupRequest** | **UpdateGroupRequest**|  | |
| **groupId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateGroupInfo1**
> BaseResponseVoid updateGroupInfo1(updateGroupRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateGroupRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let groupId: number; //群ID (default to undefined)
let updateGroupRequest: UpdateGroupRequest; //

const { status, data } = await apiInstance.updateGroupInfo1(
    groupId,
    updateGroupRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateGroupRequest** | **UpdateGroupRequest**|  | |
| **groupId** | [**number**] | 群ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateItem**
> BaseResponseBoolean updateItem(updateScheduleItemRequest)

更新课程项信息

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateScheduleItemRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)
let updateScheduleItemRequest: UpdateScheduleItemRequest; //

const { status, data } = await apiInstance.updateItem(
    id,
    updateScheduleItemRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateScheduleItemRequest** | **UpdateScheduleItemRequest**|  | |
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateLearningStatus**
> BaseResponseVoid updateLearningStatus()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let wordBookId: number; //生词本记录ID (default to undefined)
let status: number; //学习状态：0-未学习，1-已学习，2-已掌握 (default to undefined)

const { status, data } = await apiInstance.updateLearningStatus(
    wordBookId,
    status
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **wordBookId** | [**number**] | 生词本记录ID | defaults to undefined|
| **status** | [**number**] | 学习状态：0-未学习，1-已学习，2-已掌握 | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMastery**
> BaseResponseVoid updateMastery()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let wordId: number; //单词ID (default to undefined)
let level: number; //掌握程度：0-未知，1-生词，2-熟悉，3-掌握 (default to undefined)

const { status, data } = await apiInstance.updateMastery(
    wordId,
    level
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **wordId** | [**number**] | 单词ID | defaults to undefined|
| **level** | [**number**] | 掌握程度：0-未知，1-生词，2-熟悉，3-掌握 | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateNode**
> BaseResponseWorkflowNodeResponse updateNode(updateNodeRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateNodeRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let nodeId: string; //节点ID (default to undefined)
let updateNodeRequest: UpdateNodeRequest; //

const { status, data } = await apiInstance.updateNode(
    id,
    nodeId,
    updateNodeRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateNodeRequest** | **UpdateNodeRequest**|  | |
| **id** | [**number**] | 工作流ID | defaults to undefined|
| **nodeId** | [**string**] | 节点ID | defaults to undefined|


### Return type

**BaseResponseWorkflowNodeResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateNodeConfig**
> BaseResponseWorkflowNodeResponse updateNodeConfig(updateNodeConfigRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateNodeConfigRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let nodeId: string; //节点ID (default to undefined)
let updateNodeConfigRequest: UpdateNodeConfigRequest; //

const { status, data } = await apiInstance.updateNodeConfig(
    id,
    nodeId,
    updateNodeConfigRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateNodeConfigRequest** | **UpdateNodeConfigRequest**|  | |
| **id** | [**number**] | 工作流ID | defaults to undefined|
| **nodeId** | [**string**] | 节点ID | defaults to undefined|


### Return type

**BaseResponseWorkflowNodeResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePaperQuestion**
> BaseResponseBoolean updatePaperQuestion(updatePaperQuestionRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdatePaperQuestionRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let paperId: number; // (default to undefined)
let sectionId: number; // (default to undefined)
let pqId: number; // (default to undefined)
let updatePaperQuestionRequest: UpdatePaperQuestionRequest; //

const { status, data } = await apiInstance.updatePaperQuestion(
    paperId,
    sectionId,
    pqId,
    updatePaperQuestionRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updatePaperQuestionRequest** | **UpdatePaperQuestionRequest**|  | |
| **paperId** | [**number**] |  | defaults to undefined|
| **sectionId** | [**number**] |  | defaults to undefined|
| **pqId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePost**
> BaseResponseVoid updatePost(updatePostRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdatePostRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let postId: number; // (default to undefined)
let updatePostRequest: UpdatePostRequest; //

const { status, data } = await apiInstance.updatePost(
    postId,
    updatePostRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updatePostRequest** | **UpdatePostRequest**|  | |
| **postId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateProfile**
> BaseResponseBoolean updateProfile(updateProfileRequest)

用户更新自己的个人资料

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateProfileRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let updateProfileRequest: UpdateProfileRequest; //

const { status, data } = await apiInstance.updateProfile(
    updateProfileRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateProfileRequest** | **UpdateProfileRequest**|  | |


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateProgress**
> BaseResponseVoid updateProgress(updateReadingProgressCommand)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateReadingProgressCommand
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let updateReadingProgressCommand: UpdateReadingProgressCommand; //

const { status, data } = await apiInstance.updateProgress(
    updateReadingProgressCommand
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateReadingProgressCommand** | **UpdateReadingProgressCommand**|  | |


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateProgress1**
> BaseResponseVoid updateProgress1(updateProgressRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateProgressRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let updateProgressRequest: UpdateProgressRequest; //

const { status, data } = await apiInstance.updateProgress1(
    updateProgressRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateProgressRequest** | **UpdateProgressRequest**|  | |


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateQuestion**
> BaseResponseBoolean updateQuestion(updateQuestionRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateQuestionRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let updateQuestionRequest: UpdateQuestionRequest; //

const { status, data } = await apiInstance.updateQuestion(
    updateQuestionRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateQuestionRequest** | **UpdateQuestionRequest**|  | |


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateReview**
> BaseResponseVoid updateReview(reviewCourseRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    ReviewCourseRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let reviewId: number; //评价ID (default to undefined)
let reviewCourseRequest: ReviewCourseRequest; //

const { status, data } = await apiInstance.updateReview(
    reviewId,
    reviewCourseRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **reviewCourseRequest** | **ReviewCourseRequest**|  | |
| **reviewId** | [**number**] | 评价ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateSection**
> BaseResponseBoolean updateSection(addPaperSectionRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    AddPaperSectionRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let paperId: number; // (default to undefined)
let sectionId: number; // (default to undefined)
let addPaperSectionRequest: AddPaperSectionRequest; //

const { status, data } = await apiInstance.updateSection(
    paperId,
    sectionId,
    addPaperSectionRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **addPaperSectionRequest** | **AddPaperSectionRequest**|  | |
| **paperId** | [**number**] |  | defaults to undefined|
| **sectionId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateSection1**
> BaseResponseVoid updateSection1(updateSectionRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateSectionRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let courseId: number; //课程ID (default to undefined)
let sectionId: number; //小节ID (default to undefined)
let updateSectionRequest: UpdateSectionRequest; //

const { status, data } = await apiInstance.updateSection1(
    courseId,
    sectionId,
    updateSectionRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateSectionRequest** | **UpdateSectionRequest**|  | |
| **courseId** | [**number**] | 课程ID | defaults to undefined|
| **sectionId** | [**number**] | 小节ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateSetting**
> BaseResponseBoolean updateSetting(updateScheduleSettingRequest)

更新课表基础配置

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateScheduleSettingRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; // (default to undefined)
let updateScheduleSettingRequest: UpdateScheduleSettingRequest; //

const { status, data } = await apiInstance.updateSetting(
    id,
    updateScheduleSettingRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateScheduleSettingRequest** | **UpdateScheduleSettingRequest**|  | |
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateSettings**
> BaseResponseWorkflowSettingsDTO updateSettings(updateWorkflowSettingsRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateWorkflowSettingsRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let updateWorkflowSettingsRequest: UpdateWorkflowSettingsRequest; //

const { status, data } = await apiInstance.updateSettings(
    id,
    updateWorkflowSettingsRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateWorkflowSettingsRequest** | **UpdateWorkflowSettingsRequest**|  | |
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseWorkflowSettingsDTO**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateTeacher**
> BaseResponseVoid updateTeacher(updateTeacherRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateTeacherRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //讲师ID (default to undefined)
let updateTeacherRequest: UpdateTeacherRequest; //

const { status, data } = await apiInstance.updateTeacher(
    id,
    updateTeacherRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateTeacherRequest** | **UpdateTeacherRequest**|  | |
| **id** | [**number**] | 讲师ID | defaults to undefined|


### Return type

**BaseResponseVoid**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateUser**
> BaseResponseBoolean updateUser(updateUserRequest)

管理员更新用户信息

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateUserRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let updateUserRequest: UpdateUserRequest; //

const { status, data } = await apiInstance.updateUser(
    updateUserRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateUserRequest** | **UpdateUserRequest**|  | |


### Return type

**BaseResponseBoolean**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateVariable**
> BaseResponseWorkflowVariableResponse updateVariable(updateVariableRequest)


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UpdateVariableRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)
let variableName: string; //变量名称 (default to undefined)
let updateVariableRequest: UpdateVariableRequest; //

const { status, data } = await apiInstance.updateVariable(
    id,
    variableName,
    updateVariableRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateVariableRequest** | **UpdateVariableRequest**|  | |
| **id** | [**number**] | 工作流ID | defaults to undefined|
| **variableName** | [**string**] | 变量名称 | defaults to undefined|


### Return type

**BaseResponseWorkflowVariableResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadBook**
> BaseResponseBookDTO uploadBook()


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UploadBookCommand
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let command: UploadBookCommand; // (default to undefined)

const { status, data } = await apiInstance.uploadBook(
    command
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **command** | **UploadBookCommand** |  | defaults to undefined|


### Return type

**BaseResponseBookDTO**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadTemplate1**
> BaseResponseLong uploadTemplate1()


### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UploadTemplate1Request
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let name: string; //模板名称 (default to undefined)
let description: string; //模板描述 (optional) (default to undefined)
let uploadTemplate1Request: UploadTemplate1Request; // (optional)

const { status, data } = await apiInstance.uploadTemplate1(
    name,
    description,
    uploadTemplate1Request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **uploadTemplate1Request** | **UploadTemplate1Request**|  | |
| **name** | [**string**] | 模板名称 | defaults to undefined|
| **description** | [**string**] | 模板描述 | (optional) defaults to undefined|


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userLogin**
> BaseResponseLoginUserResponse userLogin(userLoginRequest)

用户登录并获取 JWT Token

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UserLoginRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let userLoginRequest: UserLoginRequest; //

const { status, data } = await apiInstance.userLogin(
    userLoginRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **userLoginRequest** | **UserLoginRequest**|  | |


### Return type

**BaseResponseLoginUserResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userRegister**
> BaseResponseLong userRegister(userRegisterRequest)

新用户注册接口，需先获取短信验证码

### Example

```typescript
import {
    DefaultApi,
    Configuration,
    UserRegisterRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let userRegisterRequest: UserRegisterRequest; //

const { status, data } = await apiInstance.userRegister(
    userRegisterRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **userRegisterRequest** | **UserRegisterRequest**|  | |


### Return type

**BaseResponseLong**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **validate**
> BaseResponseWorkflowValidationResponse validate()


### Example

```typescript
import {
    DefaultApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new DefaultApi(configuration);

let id: number; //工作流ID (default to undefined)

const { status, data } = await apiInstance.validate(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 工作流ID | defaults to undefined|


### Return type

**BaseResponseWorkflowValidationResponse**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

