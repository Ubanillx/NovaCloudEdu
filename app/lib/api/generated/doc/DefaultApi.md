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
[**addDocument**](DefaultApi.md#adddocument) | **POST** /api/ai/knowledge-bases/{id}/documents | 添加文档
[**addEdge**](DefaultApi.md#addedge) | **POST** /api/workflows/{id}/edges | 添加连接线
[**addItem**](DefaultApi.md#additem) | **POST** /api/schedule/item | 添加课程项
[**addMember**](DefaultApi.md#addmember) | **POST** /api/classes/{classId}/members | 添加成员
[**addNode**](DefaultApi.md#addnode) | **POST** /api/workflows/{id}/nodes | 添加节点
[**addToShelf**](DefaultApi.md#addtoshelf) | **POST** /api/reading/shelf | 添加书籍到书架
[**addToWordBook**](DefaultApi.md#addtowordbook) | **POST** /api/user/word-book/add/{wordId} | 添加单词到生词本
[**addVariable**](DefaultApi.md#addvariable) | **POST** /api/workflows/{id}/variables | 添加变量
[**applyTeacher**](DefaultApi.md#applyteacher) | **POST** /api/teacher/apply | 申请成为讲师
[**applyToJoin**](DefaultApi.md#applytojoin) | **POST** /api/groups/{groupId}/join | 申请加入群
[**archive1**](DefaultApi.md#archive1) | **POST** /api/workflows/{id}/archive | 归档工作流
[**batchBanUsers**](DefaultApi.md#batchbanusers) | **POST** /api/user/admin/ban | 批量封禁/解封用户
[**batchCreateUsers**](DefaultApi.md#batchcreateusers) | **POST** /api/user/admin/batch-create | 批量创建用户
[**batchProcessByKnowledgeBase**](DefaultApi.md#batchprocessbyknowledgebase) | **POST** /api/ai/knowledge-bases/{id}/embed-all | 向量化知识库所有待处理文档
[**batchProcessDocuments**](DefaultApi.md#batchprocessdocuments) | **POST** /api/ai/knowledge-bases/{id}/documents/batch-embed | 批量文档向量化
[**batchProcessDocumentsAsync**](DefaultApi.md#batchprocessdocumentsasync) | **POST** /api/ai/knowledge-bases/{id}/documents/batch-embed-async | 异步批量文档向量化
[**batchUpdate**](DefaultApi.md#batchupdate) | **POST** /api/workflows/{id}/batch-update | 批量更新节点和连接线
[**cancelExecution**](DefaultApi.md#cancelexecution) | **POST** /api/workflows/executions/{executionId}/cancel | 取消执行
[**changePassword**](DefaultApi.md#changepassword) | **POST** /api/user/password | 修改密码
[**checkFavourite**](DefaultApi.md#checkfavourite) | **GET** /api/course/favourite/{courseId}/check | 检查是否已收藏
[**checkFriendship**](DefaultApi.md#checkfriendship) | **GET** /api/friend/check/{userId} | 检查好友关系
[**checkin**](DefaultApi.md#checkin) | **POST** /api/user/checkin | 用户打卡
[**completeSection**](DefaultApi.md#completesection) | **POST** /api/progress/section/{sectionId}/complete | 标记小节为已完成
[**confirmPayment**](DefaultApi.md#confirmpayment) | **POST** /api/admin/order/confirm | 确认收款（管理员手动确认）
[**copy**](DefaultApi.md#copy) | **POST** /api/workflows/{id}/copy | 复制工作流
[**create**](DefaultApi.md#create) | **POST** /api/workflows | 创建工作流
[**create1**](DefaultApi.md#create1) | **POST** /api/ai/knowledge-bases | 创建知识库
[**createAnnouncement**](DefaultApi.md#createannouncement) | **POST** /api/announcement/admin/create | 创建公告
[**createChapter**](DefaultApi.md#createchapter) | **POST** /api/course/{courseId}/chapter | 创建章节（管理员）
[**createClass**](DefaultApi.md#createclass) | **POST** /api/classes | 创建班级
[**createComment**](DefaultApi.md#createcomment) | **POST** /api/posts/{postId}/comments | 发表评论
[**createCourse**](DefaultApi.md#createcourse) | **POST** /api/course | 创建课程（管理员）
[**createDailyArticle**](DefaultApi.md#createdailyarticle) | **POST** /api/daily-article | 创建每日文章（管理员）
[**createDailyWord**](DefaultApi.md#createdailyword) | **POST** /api/daily-word | 创建每日单词（管理员）
[**createFeedback**](DefaultApi.md#createfeedback) | **POST** /api/feedback | 创建反馈
[**createGroup**](DefaultApi.md#creategroup) | **POST** /api/groups | 创建群聊
[**createGroupFromClass**](DefaultApi.md#creategroupfromclass) | **POST** /api/classes/{classId}/chat-group | 基于班级创建群聊
[**createOrder**](DefaultApi.md#createorder) | **POST** /api/order | 创建订单（用户下单）
[**createPost**](DefaultApi.md#createpost) | **POST** /api/posts | 发布帖子
[**createReply**](DefaultApi.md#createreply) | **POST** /api/posts/comments/{commentId}/replies | 发表回复
[**createSection**](DefaultApi.md#createsection) | **POST** /api/course/{courseId}/section | 创建小节（管理员）
[**createSetting**](DefaultApi.md#createsetting) | **POST** /api/schedule/setting | 创建课表配置
[**createUser**](DefaultApi.md#createuser) | **POST** /api/user/admin/create | 创建用户
[**delete**](DefaultApi.md#delete) | **DELETE** /api/workflows/{id} | 删除工作流
[**delete1**](DefaultApi.md#delete1) | **DELETE** /api/ai/knowledge-bases/{id} | 删除知识库
[**deleteAnnouncement**](DefaultApi.md#deleteannouncement) | **DELETE** /api/announcement/admin/delete/{id} | 删除公告
[**deleteBook**](DefaultApi.md#deletebook) | **DELETE** /api/books/{bookId} | 删除书籍
[**deleteChapter**](DefaultApi.md#deletechapter) | **DELETE** /api/course/{courseId}/chapter/{chapterId} | 删除章节（管理员）
[**deleteClass**](DefaultApi.md#deleteclass) | **DELETE** /api/classes/{classId} | 删除班级
[**deleteComment**](DefaultApi.md#deletecomment) | **DELETE** /api/posts/comments/{commentId} | 删除评论
[**deleteCourse**](DefaultApi.md#deletecourse) | **DELETE** /api/course/{id} | 删除课程（管理员）
[**deleteDailyArticle**](DefaultApi.md#deletedailyarticle) | **DELETE** /api/daily-article/{id} | 删除每日文章（管理员）
[**deleteDailyWord**](DefaultApi.md#deletedailyword) | **DELETE** /api/daily-word/{id} | 删除每日单词（管理员）
[**deleteDocument**](DefaultApi.md#deletedocument) | **DELETE** /api/ai/knowledge-bases/{id}/documents/{docId} | 删除文档
[**deleteEdge**](DefaultApi.md#deleteedge) | **DELETE** /api/workflows/{id}/edges/{edgeId} | 删除连接线
[**deleteFeedback**](DefaultApi.md#deletefeedback) | **DELETE** /api/feedback/{id} | 删除反馈
[**deleteFeedback1**](DefaultApi.md#deletefeedback1) | **DELETE** /api/feedback/admin/{id} | 删除反馈
[**deleteFile**](DefaultApi.md#deletefile) | **DELETE** /api/file/{fileId} | 删除文件
[**deleteFriend**](DefaultApi.md#deletefriend) | **DELETE** /api/friend/{friendId} | 删除好友
[**deleteItem**](DefaultApi.md#deleteitem) | **DELETE** /api/schedule/item/{id} | 删除课程项
[**deleteMessage**](DefaultApi.md#deletemessage) | **DELETE** /api/group-chat/{groupId}/messages/{messageId} | 删除消息
[**deleteNode**](DefaultApi.md#deletenode) | **DELETE** /api/workflows/{id}/nodes/{nodeId} | 删除节点
[**deletePost**](DefaultApi.md#deletepost) | **DELETE** /api/posts/{postId} | 删除帖子
[**deleteReply**](DefaultApi.md#deletereply) | **DELETE** /api/posts/replies/{replyId} | 删除回复
[**deleteSection**](DefaultApi.md#deletesection) | **DELETE** /api/course/{courseId}/section/{sectionId} | 删除小节（管理员）
[**deleteVariable**](DefaultApi.md#deletevariable) | **DELETE** /api/workflows/{id}/variables/{variableName} | 删除变量
[**dissolveGroup**](DefaultApi.md#dissolvegroup) | **DELETE** /api/groups/{groupId} | 解散群
[**encryptChapterContent**](DefaultApi.md#encryptchaptercontent) | **POST** /api/books/{bookId}/chapters/{chapterIndex}/encrypt | 加密章节内容
[**execute**](DefaultApi.md#execute) | **POST** /api/workflows/{id}/execute | 执行工作流
[**executeAsync**](DefaultApi.md#executeasync) | **POST** /api/workflows/{id}/execute-async | 异步执行工作流
[**favouriteCourse**](DefaultApi.md#favouritecourse) | **POST** /api/course/favourite/{courseId} | 收藏课程
[**getAllFriends**](DefaultApi.md#getallfriends) | **GET** /api/friend/all | 获取全部好友
[**getAnnouncement**](DefaultApi.md#getannouncement) | **GET** /api/announcement/admin/{id} | 获取公告详情
[**getAnnouncementDetail**](DefaultApi.md#getannouncementdetail) | **GET** /api/announcement/{id} | 获取公告详情
[**getAnnouncementList**](DefaultApi.md#getannouncementlist) | **GET** /api/announcement/list | 获取公告列表
[**getApplication**](DefaultApi.md#getapplication) | **GET** /api/teacher/application/{id} | 获取申请详情
[**getArticlesByDate**](DefaultApi.md#getarticlesbydate) | **GET** /api/daily-article/date/{date} | 获取指定日期文章
[**getBook**](DefaultApi.md#getbook) | **GET** /api/books/{bookId} | 获取书籍详情
[**getBookChapters**](DefaultApi.md#getbookchapters) | **GET** /api/books/{bookId}/chapters | 获取书籍章节列表
[**getById**](DefaultApi.md#getbyid) | **GET** /api/workflows/{id} | 获取工作流详情
[**getById1**](DefaultApi.md#getbyid1) | **GET** /api/ai/knowledge-bases/{id} | 获取知识库详情
[**getChapter**](DefaultApi.md#getchapter) | **GET** /api/course/{courseId}/chapter/{chapterId} | 获取章节详情
[**getChapterContent**](DefaultApi.md#getchaptercontent) | **GET** /api/books/{bookId}/chapters/{chapterIndex} | 获取章节内容
[**getChatHistory**](DefaultApi.md#getchathistory) | **POST** /api/chat/history | 获取聊天历史
[**getCheckinRanking**](DefaultApi.md#getcheckinranking) | **GET** /api/user/checkin/ranking | 打卡排行榜
[**getCheckinStatus**](DefaultApi.md#getcheckinstatus) | **GET** /api/user/checkin/status | 获取打卡状态
[**getClassInfo**](DefaultApi.md#getclassinfo) | **GET** /api/classes/{classId} | 获取班级详情
[**getClassMembers**](DefaultApi.md#getclassmembers) | **GET** /api/classes/{classId}/members | 获取班级成员列表
[**getCollectedArticles**](DefaultApi.md#getcollectedarticles) | **GET** /api/user/daily-article/collected | 获取收藏文章列表
[**getCollectedWords**](DefaultApi.md#getcollectedwords) | **GET** /api/user/daily-word/collected | 获取收藏单词列表
[**getCommentReplies**](DefaultApi.md#getcommentreplies) | **GET** /api/posts/comments/{commentId}/replies | 获取评论回复列表
[**getCourse**](DefaultApi.md#getcourse) | **GET** /api/course/{id} | 获取课程详情
[**getCourseProgress**](DefaultApi.md#getcourseprogress) | **GET** /api/progress/course/{courseId} | 获取课程所有小节的学习进度
[**getCourseProgressSummary**](DefaultApi.md#getcourseprogresssummary) | **GET** /api/progress/course/{courseId}/summary | 获取课程进度汇总
[**getCourseStructure**](DefaultApi.md#getcoursestructure) | **GET** /api/course/{courseId}/structure | 获取课程完整结构（课程+章节+小节）
[**getDailyArticle**](DefaultApi.md#getdailyarticle) | **GET** /api/daily-article/{id} | 获取文章详情
[**getDailyWord**](DefaultApi.md#getdailyword) | **GET** /api/daily-word/{id} | 获取单词详情
[**getDefinition**](DefaultApi.md#getdefinition) | **GET** /api/workflows/{id}/definition | 获取工作流定义详情
[**getEdges**](DefaultApi.md#getedges) | **GET** /api/workflows/{id}/edges | 获取工作流所有连接线
[**getExecutionLogs**](DefaultApi.md#getexecutionlogs) | **GET** /api/workflows/executions/{executionId}/logs | 获取执行日志
[**getExecutionStatus**](DefaultApi.md#getexecutionstatus) | **GET** /api/workflows/executions/{executionId} | 获取执行状态
[**getFavouriteCount**](DefaultApi.md#getfavouritecount) | **GET** /api/course/favourite/{courseId}/count | 获取课程收藏数
[**getFeedbackDetail**](DefaultApi.md#getfeedbackdetail) | **GET** /api/feedback/{id} | 获取反馈详情
[**getFeedbackDetail1**](DefaultApi.md#getfeedbackdetail1) | **GET** /api/feedback/admin/{id} | 获取反馈详情
[**getFeedbackReplies**](DefaultApi.md#getfeedbackreplies) | **GET** /api/feedback/{id}/replies | 获取反馈回复列表
[**getFeedbackReplies1**](DefaultApi.md#getfeedbackreplies1) | **GET** /api/feedback/admin/{id}/replies | 获取反馈回复列表
[**getFilesByBusinessType**](DefaultApi.md#getfilesbybusinesstype) | **GET** /api/file/business-type/{businessType} | 按业务类型获取文件列表（管理员）
[**getFriendList**](DefaultApi.md#getfriendlist) | **POST** /api/friend/list | 获取好友列表
[**getGroupInfo**](DefaultApi.md#getgroupinfo) | **GET** /api/groups/{groupId} | 获取群详情
[**getGroupMembers**](DefaultApi.md#getgroupmembers) | **GET** /api/groups/{groupId}/members | 获取群成员列表
[**getGroupMembersPage**](DefaultApi.md#getgroupmemberspage) | **GET** /api/groups/{groupId}/members/page | 分页获取群成员
[**getLatestMessages**](DefaultApi.md#getlatestmessages) | **GET** /api/group-chat/{groupId}/messages/latest | 获取群最新消息
[**getLikedArticles**](DefaultApi.md#getlikedarticles) | **GET** /api/user/daily-article/liked | 获取点赞文章列表
[**getLoginUser**](DefaultApi.md#getloginuser) | **GET** /api/auth/current | 获取当前用户
[**getMessages**](DefaultApi.md#getmessages) | **GET** /api/group-chat/{groupId}/messages | 获取群聊历史消息（分页）
[**getMessagesBefore**](DefaultApi.md#getmessagesbefore) | **GET** /api/group-chat/{groupId}/messages/before | 获取群聊历史消息（游标分页，获取某消息之前的消息）
[**getMyApplication**](DefaultApi.md#getmyapplication) | **GET** /api/teacher/application/my | 获取当前用户的申请
[**getMyFavourites**](DefaultApi.md#getmyfavourites) | **GET** /api/posts/favourites | 获取我收藏的帖子
[**getMyFavourites1**](DefaultApi.md#getmyfavourites1) | **GET** /api/course/favourite/my | 获取我的收藏列表
[**getMyFeedbacks**](DefaultApi.md#getmyfeedbacks) | **GET** /api/feedback/my | 获取我的反馈列表
[**getMyFiles**](DefaultApi.md#getmyfiles) | **GET** /api/file/my | 获取我的文件列表
[**getMyGroups**](DefaultApi.md#getmygroups) | **GET** /api/groups/my | 获取我加入的群列表
[**getMyOrders**](DefaultApi.md#getmyorders) | **GET** /api/order/my | 获取我的订单列表
[**getMyPosts**](DefaultApi.md#getmyposts) | **GET** /api/posts/my | 获取我的帖子列表
[**getMyReview**](DefaultApi.md#getmyreview) | **GET** /api/course/review/{courseId}/my | 获取我对该课程的评价
[**getMySchedule**](DefaultApi.md#getmyschedule) | **GET** /api/schedule/my | 获取我的课表
[**getMyTeacher**](DefaultApi.md#getmyteacher) | **GET** /api/teacher/my | 获取当前用户的讲师信息
[**getNode**](DefaultApi.md#getnode) | **GET** /api/workflows/{id}/nodes/{nodeId} | 获取单个节点详情
[**getNodeTypes**](DefaultApi.md#getnodetypes) | **GET** /api/workflows/node-types | 获取所有可用的节点类型
[**getNodes**](DefaultApi.md#getnodes) | **GET** /api/workflows/{id}/nodes | 获取工作流所有节点
[**getOrder**](DefaultApi.md#getorder) | **GET** /api/order/{orderNo} | 查询订单详情
[**getPendingCount**](DefaultApi.md#getpendingcount) | **GET** /api/teacher/application/pending/count | 获取待审核申请数量（管理员）
[**getPendingRequests**](DefaultApi.md#getpendingrequests) | **GET** /api/groups/{groupId}/requests | 获取群待审批申请列表
[**getPostComments**](DefaultApi.md#getpostcomments) | **GET** /api/posts/{postId}/comments | 获取帖子评论列表
[**getPostDetail**](DefaultApi.md#getpostdetail) | **GET** /api/posts/{postId} | 获取帖子详情
[**getPostList**](DefaultApi.md#getpostlist) | **GET** /api/posts | 分页获取帖子列表
[**getPostListByType**](DefaultApi.md#getpostlistbytype) | **GET** /api/posts/type/{postType} | 根据类型获取帖子列表
[**getReadArticles**](DefaultApi.md#getreadarticles) | **GET** /api/user/daily-article/read | 获取已阅读文章列表
[**getReadCount**](DefaultApi.md#getreadcount) | **GET** /api/group-chat/messages/{messageId}/read-count | 获取消息已读人数
[**getReceivedRequests**](DefaultApi.md#getreceivedrequests) | **POST** /api/friend/request/received | 获取收到的好友申请
[**getReviewCount**](DefaultApi.md#getreviewcount) | **GET** /api/course/review/{courseId}/count | 获取课程评价数
[**getScheduleBySetting**](DefaultApi.md#getschedulebysetting) | **GET** /api/schedule/setting/{settingId} | 获取特定配置的课表
[**getSection**](DefaultApi.md#getsection) | **GET** /api/course/{courseId}/section/{sectionId} | 获取小节详情
[**getSectionProgress**](DefaultApi.md#getsectionprogress) | **GET** /api/progress/section/{sectionId} | 获取小节学习进度
[**getSentRequests**](DefaultApi.md#getsentrequests) | **POST** /api/friend/request/sent | 获取发送的好友申请
[**getSessionList**](DefaultApi.md#getsessionlist) | **GET** /api/chat/sessions | 获取会话列表
[**getStatistics**](DefaultApi.md#getstatistics) | **GET** /api/admin/order/statistics | 订单统计（管理员）
[**getStats**](DefaultApi.md#getstats) | **GET** /api/user/word-book/stats | 获取生词本统计
[**getStats1**](DefaultApi.md#getstats1) | **GET** /api/user/daily-word/stats | 获取学习统计
[**getStats2**](DefaultApi.md#getstats2) | **GET** /api/user/daily-article/stats | 获取阅读统计
[**getStudiedWords**](DefaultApi.md#getstudiedwords) | **GET** /api/user/daily-word/studied | 获取已学习单词列表
[**getSupportedVoices**](DefaultApi.md#getsupportedvoices) | **GET** /api/speech/tts/voices | 获取支持的发音人列表
[**getTeacher**](DefaultApi.md#getteacher) | **GET** /api/teacher/{id} | 获取讲师信息
[**getTeacherByUserId**](DefaultApi.md#getteacherbyuserid) | **GET** /api/teacher/user/{userId} | 根据用户ID获取讲师信息
[**getTodayArticles**](DefaultApi.md#gettodayarticles) | **GET** /api/daily-article/today | 获取今日推荐文章（个性化推荐）
[**getTodayWords**](DefaultApi.md#gettodaywords) | **GET** /api/daily-word/today | 获取今日推荐单词（个性化推荐）
[**getUnreadCount**](DefaultApi.md#getunreadcount) | **GET** /api/group-chat/{groupId}/unread/count | 获取群未读消息数
[**getUnreadCount1**](DefaultApi.md#getunreadcount1) | **GET** /api/chat/unread/count | 获取未读消息数
[**getUnreadCount2**](DefaultApi.md#getunreadcount2) | **GET** /api/announcement/unread-count | 获取未读公告数量
[**getUserDetail**](DefaultApi.md#getuserdetail) | **GET** /api/user/admin/{id} | 获取用户详情
[**getUserDetailInfo**](DefaultApi.md#getuserdetailinfo) | **GET** /api/user/detail/{id} | 获取用户详细信息
[**getUserPosts**](DefaultApi.md#getuserposts) | **GET** /api/posts/user/{targetUserId} | 获取指定用户的帖子列表
[**getUserPublicInfo**](DefaultApi.md#getuserpublicinfo) | **GET** /api/user/public/{id} | 获取用户公开信息
[**getUserShelf**](DefaultApi.md#getusershelf) | **GET** /api/reading/shelf/{userId} | 获取用户书架
[**getUserStats**](DefaultApi.md#getuserstats) | **GET** /api/user/stats | 获取用户统计数据
[**getVariables**](DefaultApi.md#getvariables) | **GET** /api/workflows/{id}/variables | 获取工作流所有变量
[**getWordBookList**](DefaultApi.md#getwordbooklist) | **GET** /api/user/word-book/list | 获取生词本列表
[**getWordsByDate**](DefaultApi.md#getwordsbydate) | **GET** /api/daily-word/date/{date} | 获取指定日期单词
[**handleFriendRequest**](DefaultApi.md#handlefriendrequest) | **POST** /api/friend/request/handle | 处理好友申请
[**handleJoinRequest**](DefaultApi.md#handlejoinrequest) | **POST** /api/groups/requests/{requestId}/handle | 处理加入申请
[**health**](DefaultApi.md#health) | **GET** /api/health | 健康检查
[**inviteMember**](DefaultApi.md#invitemember) | **POST** /api/groups/{groupId}/invite | 邀请用户加入群
[**leaveGroup**](DefaultApi.md#leavegroup) | **POST** /api/groups/{groupId}/leave | 退出群
[**listApplications**](DefaultApi.md#listapplications) | **GET** /api/teacher/application/list | 获取申请列表（管理员）
[**listArticles**](DefaultApi.md#listarticles) | **GET** /api/daily-article/list | 获取文章列表
[**listBooks**](DefaultApi.md#listbooks) | **GET** /api/books | 获取书籍列表
[**listByCreator**](DefaultApi.md#listbycreator) | **GET** /api/ai/knowledge-bases | 获取用户的知识库列表
[**listByUser**](DefaultApi.md#listbyuser) | **GET** /api/workflows | 获取用户的工作流列表
[**listChapters**](DefaultApi.md#listchapters) | **GET** /api/course/{courseId}/chapter | 获取课程的章节列表
[**listCourses**](DefaultApi.md#listcourses) | **GET** /api/course/list | 获取课程列表
[**listCoursesByTeacher**](DefaultApi.md#listcoursesbyteacher) | **GET** /api/course/teacher/{teacherId} | 获取讲师的课程列表
[**listDocuments**](DefaultApi.md#listdocuments) | **GET** /api/ai/knowledge-bases/{id}/documents | 获取文档列表
[**listOrders**](DefaultApi.md#listorders) | **GET** /api/admin/order/list | 获取订单列表（管理员）
[**listPublic**](DefaultApi.md#listpublic) | **GET** /api/workflows/public | 获取公开的工作流列表
[**listReviews**](DefaultApi.md#listreviews) | **GET** /api/course/review/{courseId}/list | 获取课程评价列表
[**listSections**](DefaultApi.md#listsections) | **GET** /api/course/{courseId}/section | 获取课程的所有小节
[**listTeachers**](DefaultApi.md#listteachers) | **GET** /api/teacher/list | 获取讲师列表
[**listWords**](DefaultApi.md#listwords) | **GET** /api/daily-word/list | 获取单词列表
[**markAsRead**](DefaultApi.md#markasread) | **POST** /api/user/daily-article/{articleId}/read | 标记文章为已阅读
[**markAsRead1**](DefaultApi.md#markasread1) | **POST** /api/group-chat/{groupId}/messages/{messageId}/read | 标记消息已读
[**markAsRead2**](DefaultApi.md#markasread2) | **POST** /api/chat/read/{senderId} | 标记消息已读
[**markAsRead3**](DefaultApi.md#markasread3) | **POST** /api/announcement/{id}/read | 标记公告已读
[**markRepliesAsRead**](DefaultApi.md#markrepliesasread) | **POST** /api/feedback/{id}/read | 标记回复为已读
[**offlineAnnouncement**](DefaultApi.md#offlineannouncement) | **POST** /api/announcement/admin/offline/{id} | 下线公告
[**phoneLogin**](DefaultApi.md#phonelogin) | **POST** /api/auth/login/phone | 手机验证码登录
[**processDocument**](DefaultApi.md#processdocument) | **POST** /api/ai/knowledge-bases/{id}/documents/{docId}/embed | 触发文档向量化
[**publish1**](DefaultApi.md#publish1) | **POST** /api/workflows/{id}/publish | 发布工作流
[**publishAnnouncement**](DefaultApi.md#publishannouncement) | **PUT** /api/groups/{groupId}/announcement | 发布群公告
[**publishAnnouncement1**](DefaultApi.md#publishannouncement1) | **POST** /api/announcement/admin/publish/{id} | 发布公告
[**publishCourse**](DefaultApi.md#publishcourse) | **POST** /api/course/{id}/publish | 发布课程（管理员）
[**queryAnnouncements**](DefaultApi.md#queryannouncements) | **POST** /api/announcement/admin/list | 分页查询公告
[**queryFeedbacks**](DefaultApi.md#queryfeedbacks) | **POST** /api/feedback/admin/list | 分页查询反馈
[**queryUsers**](DefaultApi.md#queryusers) | **POST** /api/user/admin/list | 分页查询用户
[**refund**](DefaultApi.md#refund) | **POST** /api/admin/order/{orderNo}/refund | 退款（管理员）
[**removeCourse**](DefaultApi.md#removecourse) | **DELETE** /api/classes/{classId}/courses/{courseId} | 移除课程
[**removeFromShelf**](DefaultApi.md#removefromshelf) | **DELETE** /api/reading/shelf | 从书架移除书籍
[**removeFromWordBook**](DefaultApi.md#removefromwordbook) | **DELETE** /api/user/word-book/{wordBookId} | 从生词本移除单词
[**removeMember**](DefaultApi.md#removemember) | **DELETE** /api/groups/{groupId}/members/{targetUserId} | 移除成员
[**removeMember1**](DefaultApi.md#removemember1) | **DELETE** /api/classes/{classId}/members/{userId} | 移除成员
[**replyFeedback**](DefaultApi.md#replyfeedback) | **POST** /api/feedback/reply | 回复反馈
[**replyFeedback1**](DefaultApi.md#replyfeedback1) | **POST** /api/feedback/admin/reply | 回复反馈
[**resetPassword**](DefaultApi.md#resetpassword) | **POST** /api/user/admin/reset-password | 重置用户密码
[**resetProgress**](DefaultApi.md#resetprogress) | **POST** /api/progress/section/{sectionId}/reset | 重置小节进度
[**reviewApplication**](DefaultApi.md#reviewapplication) | **POST** /api/teacher/application/review | 审核讲师申请（管理员）
[**reviewCourse**](DefaultApi.md#reviewcourse) | **POST** /api/course/review/{courseId} | 评价课程
[**search**](DefaultApi.md#search) | **GET** /api/ai/knowledge-bases/search | 搜索知识库
[**searchArticles**](DefaultApi.md#searcharticles) | **GET** /api/daily-article/search | 搜索文章
[**searchBooks**](DefaultApi.md#searchbooks) | **GET** /api/books/search | 搜索书籍
[**searchCourses**](DefaultApi.md#searchcourses) | **GET** /api/course/search | 搜索课程
[**searchGroups**](DefaultApi.md#searchgroups) | **GET** /api/groups/search | 搜索群
[**searchPosts**](DefaultApi.md#searchposts) | **GET** /api/posts/search | 搜索帖子
[**searchPostsByTag**](DefaultApi.md#searchpostsbytag) | **GET** /api/posts/tag | 根据标签搜索帖子
[**searchUsers**](DefaultApi.md#searchusers) | **POST** /api/friend/search | 搜索用户
[**searchWords**](DefaultApi.md#searchwords) | **GET** /api/daily-word/search | 搜索单词
[**sendFriendRequest**](DefaultApi.md#sendfriendrequest) | **POST** /api/friend/request/send | 发送好友申请
[**sendRegisterCode**](DefaultApi.md#sendregistercode) | **POST** /api/auth/send-code | 发送注册验证码
[**sendSms**](DefaultApi.md#sendsms) | **POST** /api/user/admin/send-sms | 发送短信验证码
[**setAdmin**](DefaultApi.md#setadmin) | **PUT** /api/groups/{groupId}/members/{targetUserId}/admin | 设置/取消管理员
[**setJoinMode**](DefaultApi.md#setjoinmode) | **PUT** /api/groups/{groupId}/join-mode | 设置群加入模式
[**studyWord**](DefaultApi.md#studyword) | **POST** /api/user/daily-word/{wordId}/study | 标记单词为已学习
[**takeOffline**](DefaultApi.md#takeoffline) | **POST** /api/course/{id}/offline | 下架课程（管理员）
[**textToSpeech**](DefaultApi.md#texttospeech) | **POST** /api/speech/tts | 文本转语音
[**textToSpeechBase64**](DefaultApi.md#texttospeechbase64) | **POST** /api/speech/tts/base64 | 文本转语音 (Base64)
[**toggleCollect**](DefaultApi.md#togglecollect) | **POST** /api/user/daily-word/{wordId}/collect | 收藏/取消收藏单词
[**toggleCollect1**](DefaultApi.md#togglecollect1) | **POST** /api/user/daily-article/{articleId}/collect | 收藏/取消收藏文章
[**toggleFavour**](DefaultApi.md#togglefavour) | **POST** /api/posts/{postId}/favour | 收藏/取消收藏帖子
[**toggleLike**](DefaultApi.md#togglelike) | **POST** /api/user/daily-article/{articleId}/like | 点赞/取消点赞文章
[**toggleThumb**](DefaultApi.md#togglethumb) | **POST** /api/posts/{postId}/thumb | 点赞/取消点赞帖子
[**transferOwnership**](DefaultApi.md#transferownership) | **POST** /api/groups/{groupId}/transfer | 转让群主
[**unfavouriteCourse**](DefaultApi.md#unfavouritecourse) | **DELETE** /api/course/favourite/{courseId} | 取消收藏
[**update**](DefaultApi.md#update) | **PUT** /api/workflows/{id} | 更新工作流基本信息
[**update1**](DefaultApi.md#update1) | **PUT** /api/ai/knowledge-bases/{id} | 更新知识库
[**updateAnnouncement**](DefaultApi.md#updateannouncement) | **PUT** /api/announcement/admin/update | 更新公告
[**updateChapter**](DefaultApi.md#updatechapter) | **PUT** /api/course/{courseId}/chapter/{chapterId} | 更新章节（管理员）
[**updateClass**](DefaultApi.md#updateclass) | **PUT** /api/classes/{classId} | 更新班级信息
[**updateCourse**](DefaultApi.md#updatecourse) | **PUT** /api/course/{id} | 更新课程（管理员）
[**updateDailyArticle**](DefaultApi.md#updatedailyarticle) | **PUT** /api/daily-article/{id} | 更新每日文章（管理员）
[**updateDailyWord**](DefaultApi.md#updatedailyword) | **PUT** /api/daily-word/{id} | 更新每日单词（管理员）
[**updateDefinition**](DefaultApi.md#updatedefinition) | **PUT** /api/workflows/{id}/definition | 更新工作流定义
[**updateEdge**](DefaultApi.md#updateedge) | **PUT** /api/workflows/{id}/edges/{edgeId} | 更新连接线
[**updateFeedbackStatus**](DefaultApi.md#updatefeedbackstatus) | **PUT** /api/feedback/admin/status | 更新反馈状态
[**updateGroupInfo**](DefaultApi.md#updategroupinfo) | **PUT** /api/groups/{groupId} | 更新群信息
[**updateItem**](DefaultApi.md#updateitem) | **PUT** /api/schedule/item/{id} | 更新课程项
[**updateLearningStatus**](DefaultApi.md#updatelearningstatus) | **PUT** /api/user/word-book/{wordBookId}/status | 更新学习状态
[**updateMastery**](DefaultApi.md#updatemastery) | **POST** /api/user/daily-word/{wordId}/mastery | 更新单词掌握程度
[**updateNode**](DefaultApi.md#updatenode) | **PUT** /api/workflows/{id}/nodes/{nodeId} | 更新节点
[**updateNodeConfig**](DefaultApi.md#updatenodeconfig) | **PUT** /api/workflows/{id}/nodes/{nodeId}/config | 更新节点配置
[**updatePost**](DefaultApi.md#updatepost) | **PUT** /api/posts/{postId} | 更新帖子
[**updateProfile**](DefaultApi.md#updateprofile) | **PUT** /api/user/profile | 更新个人资料
[**updateProgress**](DefaultApi.md#updateprogress) | **PUT** /api/reading/progress | 更新阅读进度
[**updateProgress1**](DefaultApi.md#updateprogress1) | **POST** /api/progress | 更新学习进度
[**updateReview**](DefaultApi.md#updatereview) | **PUT** /api/course/review/{reviewId} | 更新评价
[**updateSection**](DefaultApi.md#updatesection) | **PUT** /api/course/{courseId}/section/{sectionId} | 更新小节（管理员）
[**updateSetting**](DefaultApi.md#updatesetting) | **PUT** /api/schedule/setting/{id} | 更新课表配置
[**updateSettings**](DefaultApi.md#updatesettings) | **PUT** /api/workflows/{id}/settings | 更新工作流设置
[**updateTeacher**](DefaultApi.md#updateteacher) | **PUT** /api/teacher/{id} | 更新讲师信息
[**updateUser**](DefaultApi.md#updateuser) | **PUT** /api/user/admin/update | 更新用户
[**updateVariable**](DefaultApi.md#updatevariable) | **PUT** /api/workflows/{id}/variables/{variableName} | 更新变量
[**uploadBook**](DefaultApi.md#uploadbook) | **POST** /api/books/upload | 上传书籍
[**userLogin**](DefaultApi.md#userlogin) | **POST** /api/auth/login | 用户登录
[**userRegister**](DefaultApi.md#userregister) | **POST** /api/auth/register | 用户注册
[**validate**](DefaultApi.md#validate) | **POST** /api/workflows/{id}/validate | 验证工作流定义


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

# **addDocument**
> BaseResponseKnowledgeDocumentVO addDocument(id, userId, requestBody)

添加文档

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final int userId = 789; // int | 
final BuiltMap<String, JsonObject> requestBody = Object; // BuiltMap<String, JsonObject> | 

try {
    final response = api.addDocument(id, userId, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->addDocument: $e\n');
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

# **archive1**
> BaseResponseWorkflowResponse archive1(id)

归档工作流

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID

try {
    final response = api.archive1(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->archive1: $e\n');
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

# **batchProcessByKnowledgeBase**
> BaseResponseBatchProcessResult batchProcessByKnowledgeBase(id)

向量化知识库所有待处理文档

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.batchProcessByKnowledgeBase(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->batchProcessByKnowledgeBase: $e\n');
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

# **batchProcessDocuments**
> BaseResponseBatchProcessResult batchProcessDocuments(id, requestBody)

批量文档向量化

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final BuiltList<int> requestBody = ; // BuiltList<int> | 

try {
    final response = api.batchProcessDocuments(id, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->batchProcessDocuments: $e\n');
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

# **batchProcessDocumentsAsync**
> BaseResponseString batchProcessDocumentsAsync(id, requestBody)

异步批量文档向量化

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final BuiltList<int> requestBody = ; // BuiltList<int> | 

try {
    final response = api.batchProcessDocumentsAsync(id, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->batchProcessDocumentsAsync: $e\n');
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

# **create1**
> BaseResponseKnowledgeBaseVO create1(userId, createKnowledgeBaseCommand)

创建知识库

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int userId = 789; // int | 
final CreateKnowledgeBaseCommand createKnowledgeBaseCommand = ; // CreateKnowledgeBaseCommand | 

try {
    final response = api.create1(userId, createKnowledgeBaseCommand);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->create1: $e\n');
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

# **delete1**
> BaseResponseVoid delete1(id)

删除知识库

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.delete1(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->delete1: $e\n');
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

# **deleteDocument**
> BaseResponseVoid deleteDocument(id, docId)

删除文档

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final int docId = 789; // int | 

try {
    final response = api.deleteDocument(id, docId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteDocument: $e\n');
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

# **deleteSection**
> BaseResponseVoid deleteSection(courseId, sectionId)

删除小节（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID
final int sectionId = 789; // int | 小节ID

try {
    final response = api.deleteSection(courseId, sectionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteSection: $e\n');
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

# **getById1**
> BaseResponseKnowledgeBaseVO getById1(id)

获取知识库详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.getById1(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getById1: $e\n');
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

# **getExecutionLogs**
> BaseResponseListExecutionLogResponse getExecutionLogs(executionId)

获取执行日志

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String executionId = executionId_example; // String | 执行ID

try {
    final response = api.getExecutionLogs(executionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getExecutionLogs: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **executionId** | **String**| 执行ID | 

### Return type

[**BaseResponseListExecutionLogResponse**](BaseResponseListExecutionLogResponse.md)

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

订单统计（管理员）

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
> BaseResponseListDailyWordResponse getTodayWords(size)

获取今日推荐单词（个性化推荐）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int size = 56; // int | 推荐数量

try {
    final response = api.getTodayWords(size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getTodayWords: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **size** | **int**| 推荐数量 | [optional] [default to 10]

### Return type

[**BaseResponseListDailyWordResponse**](BaseResponseListDailyWordResponse.md)

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
> BaseResponseListDailyArticleResponse listArticles(category, difficulty, page, size)

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

[**BaseResponseListDailyArticleResponse**](BaseResponseListDailyArticleResponse.md)

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

# **listByCreator**
> BaseResponseListKnowledgeBaseVO listByCreator(userId, page, size)

获取用户的知识库列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int userId = 789; // int | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.listByCreator(userId, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listByCreator: $e\n');
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

# **listDocuments**
> BaseResponseListKnowledgeDocumentVO listDocuments(id, page, size)

获取文档列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.listDocuments(id, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listDocuments: $e\n');
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

# **listOrders**
> BaseResponseListOrderResponse listOrders(status, page, size)

获取订单列表（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int status = 56; // int | 订单状态：0-未支付，1-已支付，2-已过期，3-已退款
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
 **status** | **int**| 订单状态：0-未支付，1-已支付，2-已过期，3-已退款 | [optional] 
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

# **listTeachers**
> BaseResponseListTeacherResponse listTeachers(page, size)

获取讲师列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int page = 56; // int | 页码
final int size = 56; // int | 每页数量

try {
    final response = api.listTeachers(page, size);
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

### Return type

[**BaseResponseListTeacherResponse**](BaseResponseListTeacherResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listWords**
> BaseResponseListDailyWordResponse listWords(category, difficulty, page, size)

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

[**BaseResponseListDailyWordResponse**](BaseResponseListDailyWordResponse.md)

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

# **processDocument**
> BaseResponseVoid processDocument(id, docId)

触发文档向量化

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final int docId = 789; // int | 

try {
    final response = api.processDocument(id, docId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->processDocument: $e\n');
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

# **publish1**
> BaseResponseWorkflowResponse publish1(id)

发布工作流

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 工作流ID

try {
    final response = api.publish1(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->publish1: $e\n');
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

# **search**
> BaseResponseListKnowledgeBaseVO search(keyword, userId, page, size)

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
    final response = api.search(keyword, userId, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->search: $e\n');
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

# **searchArticles**
> BaseResponseListDailyArticleResponse searchArticles(keyword, page, size)

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

[**BaseResponseListDailyArticleResponse**](BaseResponseListDailyArticleResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchBooks**
> BaseResponseListBookDTO searchBooks(keyword, page, size)

搜索书籍

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String keyword = keyword_example; // String | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.searchBooks(keyword, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->searchBooks: $e\n');
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

# **searchPosts**
> BaseResponsePostPageResponse searchPosts(keyword, pageNum, pageSize)

搜索帖子

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final String keyword = keyword_example; // String | 
final int pageNum = 56; // int | 
final int pageSize = 56; // int | 

try {
    final response = api.searchPosts(keyword, pageNum, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->searchPosts: $e\n');
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
> BaseResponseListDailyWordResponse searchWords(keyword, page, size)

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

[**BaseResponseListDailyWordResponse**](BaseResponseListDailyWordResponse.md)

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

# **update1**
> BaseResponseKnowledgeBaseVO update1(id, updateKnowledgeBaseCommand)

更新知识库

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 
final UpdateKnowledgeBaseCommand updateKnowledgeBaseCommand = ; // UpdateKnowledgeBaseCommand | 

try {
    final response = api.update1(id, updateKnowledgeBaseCommand);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->update1: $e\n');
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
> BaseResponseVoid updateSection(courseId, sectionId, updateSectionRequest)

更新小节（管理员）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int courseId = 789; // int | 课程ID
final int sectionId = 789; // int | 小节ID
final UpdateSectionRequest updateSectionRequest = ; // UpdateSectionRequest | 

try {
    final response = api.updateSection(courseId, sectionId, updateSectionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateSection: $e\n');
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

