import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

/// tests for DefaultApi
void main() {
  final instance = NovaApi().getDefaultApi();

  group(DefaultApi, () {
    // 激活课表配置
    //
    // 将某学期配置设为当前激活
    //
    //Future<BaseResponseBoolean> activateSetting(int id) async
    test('test activateSetting', () async {
      // TODO
    });

    // 添加评论
    //
    //Future<BaseResponseVoid> addComment(int articleId, AddCommentRequest addCommentRequest) async
    test('test addComment', () async {
      // TODO
    });

    // 添加课程
    //
    //Future<BaseResponseVoid> addCourse(int classId, AddClassCourseRequest addClassCourseRequest) async
    test('test addCourse', () async {
      // TODO
    });

    // 添加文档
    //
    //Future<BaseResponseKnowledgeDocumentVO> addDocument(int id, int userId, BuiltMap<String, JsonObject> requestBody) async
    test('test addDocument', () async {
      // TODO
    });

    // 添加连接线
    //
    //Future<BaseResponseWorkflowEdgeResponse> addEdge(int id, AddEdgeRequest addEdgeRequest) async
    test('test addEdge', () async {
      // TODO
    });

    // 添加课程项
    //
    // 向课表中添加课程
    //
    //Future<BaseResponseLong> addItem(AddScheduleItemRequest addScheduleItemRequest) async
    test('test addItem', () async {
      // TODO
    });

    // 添加成员
    //
    //Future<BaseResponseVoid> addMember(int classId, AddClassMemberRequest addClassMemberRequest) async
    test('test addMember', () async {
      // TODO
    });

    // 添加节点
    //
    //Future<BaseResponseWorkflowNodeResponse> addNode(int id, AddNodeRequest addNodeRequest) async
    test('test addNode', () async {
      // TODO
    });

    // 添加书籍到书架
    //
    //Future<BaseResponseVoid> addToShelf(int userId, int bookId) async
    test('test addToShelf', () async {
      // TODO
    });

    // 添加单词到生词本
    //
    //Future<BaseResponseLong> addToWordBook(int wordId) async
    test('test addToWordBook', () async {
      // TODO
    });

    // 添加变量
    //
    //Future<BaseResponseWorkflowVariableResponse> addVariable(int id, AddVariableRequest addVariableRequest) async
    test('test addVariable', () async {
      // TODO
    });

    // 申请成为讲师
    //
    //Future<BaseResponseLong> applyTeacher(ApplyTeacherRequest applyTeacherRequest) async
    test('test applyTeacher', () async {
      // TODO
    });

    // 申请加入群
    //
    //Future<BaseResponseJoinRequestResponse> applyToJoin(int groupId, { JoinGroupRequest joinGroupRequest }) async
    test('test applyToJoin', () async {
      // TODO
    });

    // 归档工作流
    //
    //Future<BaseResponseWorkflowResponse> archive1(int id) async
    test('test archive1', () async {
      // TODO
    });

    // 批量封禁/解封用户
    //
    // 管理员批量封禁或解封用户
    //
    //Future<BaseResponseBoolean> batchBanUsers(BatchBanUserRequest batchBanUserRequest) async
    test('test batchBanUsers', () async {
      // TODO
    });

    // 批量创建用户
    //
    // 管理员批量创建用户
    //
    //Future<BaseResponseListLong> batchCreateUsers(BatchCreateUserRequest batchCreateUserRequest) async
    test('test batchCreateUsers', () async {
      // TODO
    });

    // 向量化知识库所有待处理文档
    //
    //Future<BaseResponseBatchProcessResult> batchProcessByKnowledgeBase(int id) async
    test('test batchProcessByKnowledgeBase', () async {
      // TODO
    });

    // 批量文档向量化
    //
    //Future<BaseResponseBatchProcessResult> batchProcessDocuments(int id, BuiltList<int> requestBody) async
    test('test batchProcessDocuments', () async {
      // TODO
    });

    // 异步批量文档向量化
    //
    //Future<BaseResponseString> batchProcessDocumentsAsync(int id, BuiltList<int> requestBody) async
    test('test batchProcessDocumentsAsync', () async {
      // TODO
    });

    // 批量更新节点和连接线
    //
    //Future<BaseResponseWorkflowDefinitionResponse> batchUpdate(int id, BatchUpdateNodesRequest batchUpdateNodesRequest) async
    test('test batchUpdate', () async {
      // TODO
    });

    // 取消执行
    //
    //Future<BaseResponseVoid> cancelExecution(String executionId) async
    test('test cancelExecution', () async {
      // TODO
    });

    // 修改密码
    //
    // 用户修改自己的密码，需要验证旧密码
    //
    //Future<BaseResponseBoolean> changePassword(ChangePasswordRequest changePasswordRequest) async
    test('test changePassword', () async {
      // TODO
    });

    // 检查是否已收藏
    //
    //Future<BaseResponseBoolean> checkFavourite(int courseId) async
    test('test checkFavourite', () async {
      // TODO
    });

    // 检查好友关系
    //
    // 检查当前用户与目标用户是否是好友
    //
    //Future<BaseResponseBoolean> checkFriendship(int userId) async
    test('test checkFriendship', () async {
      // TODO
    });

    // 标记小节为已完成
    //
    //Future<BaseResponseVoid> completeSection(int sectionId, int courseId) async
    test('test completeSection', () async {
      // TODO
    });

    // 确认收款（管理员手动确认）
    //
    //Future<BaseResponseVoid> confirmPayment(ConfirmPaymentRequest confirmPaymentRequest) async
    test('test confirmPayment', () async {
      // TODO
    });

    // 复制工作流
    //
    //Future<BaseResponseWorkflowResponse> copy(int id, String newName, int userId) async
    test('test copy', () async {
      // TODO
    });

    // 创建工作流
    //
    //Future<BaseResponseWorkflowResponse> create(CreateWorkflowRequest createWorkflowRequest) async
    test('test create', () async {
      // TODO
    });

    // 创建知识库
    //
    //Future<BaseResponseKnowledgeBaseVO> create1(int userId, CreateKnowledgeBaseCommand createKnowledgeBaseCommand) async
    test('test create1', () async {
      // TODO
    });

    // 创建公告
    //
    // 创建新公告，初始状态为草稿
    //
    //Future<BaseResponseLong> createAnnouncement(CreateAnnouncementRequest createAnnouncementRequest) async
    test('test createAnnouncement', () async {
      // TODO
    });

    // 创建章节（管理员）
    //
    //Future<BaseResponseLong> createChapter(int courseId, CreateChapterRequest createChapterRequest) async
    test('test createChapter', () async {
      // TODO
    });

    // 创建班级
    //
    //Future<BaseResponseClassResponse> createClass(CreateClassRequest createClassRequest) async
    test('test createClass', () async {
      // TODO
    });

    // 发表评论
    //
    //Future<BaseResponseCommentResponse> createComment(int postId, CreateCommentRequest createCommentRequest) async
    test('test createComment', () async {
      // TODO
    });

    // 创建课程（管理员）
    //
    //Future<BaseResponseLong> createCourse(CreateCourseRequest createCourseRequest) async
    test('test createCourse', () async {
      // TODO
    });

    // 创建每日文章（管理员）
    //
    //Future<BaseResponseLong> createDailyArticle(CreateDailyArticleRequest createDailyArticleRequest) async
    test('test createDailyArticle', () async {
      // TODO
    });

    // 创建每日单词（管理员）
    //
    //Future<BaseResponseLong> createDailyWord(CreateDailyWordRequest createDailyWordRequest) async
    test('test createDailyWord', () async {
      // TODO
    });

    // 创建反馈
    //
    // 用户提交新的反馈
    //
    //Future<BaseResponseLong> createFeedback(CreateFeedbackRequest createFeedbackRequest) async
    test('test createFeedback', () async {
      // TODO
    });

    // 创建群聊
    //
    //Future<BaseResponseGroupResponse> createGroup(CreateGroupRequest createGroupRequest) async
    test('test createGroup', () async {
      // TODO
    });

    // 基于班级创建群聊
    //
    //Future<BaseResponseLong> createGroupFromClass(int classId) async
    test('test createGroupFromClass', () async {
      // TODO
    });

    // 创建订单（用户下单）
    //
    //Future<BaseResponseString> createOrder(CreateOrderRequest createOrderRequest) async
    test('test createOrder', () async {
      // TODO
    });

    // 发布帖子
    //
    //Future<BaseResponsePostResponse> createPost(CreatePostRequest createPostRequest) async
    test('test createPost', () async {
      // TODO
    });

    // 发表回复
    //
    //Future<BaseResponseReplyResponse> createReply(int commentId, CreateReplyRequest createReplyRequest) async
    test('test createReply', () async {
      // TODO
    });

    // 创建小节（管理员）
    //
    //Future<BaseResponseLong> createSection(int courseId, CreateSectionRequest createSectionRequest) async
    test('test createSection', () async {
      // TODO
    });

    // 创建课表配置
    //
    // 管理员/教师创建班级课表配置
    //
    //Future<BaseResponseLong> createSetting(CreateScheduleSettingRequest createScheduleSettingRequest) async
    test('test createSetting', () async {
      // TODO
    });

    // 创建用户
    //
    // 管理员创建单个用户
    //
    //Future<BaseResponseLong> createUser(CreateUserRequest createUserRequest) async
    test('test createUser', () async {
      // TODO
    });

    // 删除工作流
    //
    //Future<BaseResponseVoid> delete(int id) async
    test('test delete', () async {
      // TODO
    });

    // 删除知识库
    //
    //Future<BaseResponseVoid> delete1(int id) async
    test('test delete1', () async {
      // TODO
    });

    // 删除公告
    //
    // 逻辑删除公告
    //
    //Future<BaseResponseBoolean> deleteAnnouncement(int id) async
    test('test deleteAnnouncement', () async {
      // TODO
    });

    // 删除书籍
    //
    //Future<BaseResponseVoid> deleteBook(int bookId) async
    test('test deleteBook', () async {
      // TODO
    });

    // 删除章节（管理员）
    //
    //Future<BaseResponseVoid> deleteChapter(int courseId, int chapterId) async
    test('test deleteChapter', () async {
      // TODO
    });

    // 删除班级
    //
    //Future<BaseResponseVoid> deleteClass(int classId) async
    test('test deleteClass', () async {
      // TODO
    });

    // 删除评论
    //
    //Future<BaseResponseVoid> deleteComment(int commentId) async
    test('test deleteComment', () async {
      // TODO
    });

    // 删除课程（管理员）
    //
    //Future<BaseResponseVoid> deleteCourse(int id) async
    test('test deleteCourse', () async {
      // TODO
    });

    // 删除每日文章（管理员）
    //
    //Future<BaseResponseVoid> deleteDailyArticle(int id) async
    test('test deleteDailyArticle', () async {
      // TODO
    });

    // 删除每日单词（管理员）
    //
    //Future<BaseResponseVoid> deleteDailyWord(int id) async
    test('test deleteDailyWord', () async {
      // TODO
    });

    // 删除文档
    //
    //Future<BaseResponseVoid> deleteDocument(int id, int docId) async
    test('test deleteDocument', () async {
      // TODO
    });

    // 删除连接线
    //
    //Future<BaseResponseVoid> deleteEdge(int id, String edgeId) async
    test('test deleteEdge', () async {
      // TODO
    });

    // 删除反馈
    //
    // 用户删除自己的反馈
    //
    //Future<BaseResponseBoolean> deleteFeedback(int id) async
    test('test deleteFeedback', () async {
      // TODO
    });

    // 删除反馈
    //
    // 管理员删除反馈
    //
    //Future<BaseResponseBoolean> deleteFeedback1(int id) async
    test('test deleteFeedback1', () async {
      // TODO
    });

    // 删除文件
    //
    //Future<BaseResponseVoid> deleteFile(int fileId) async
    test('test deleteFile', () async {
      // TODO
    });

    // 删除好友
    //
    // 删除指定好友
    //
    //Future<BaseResponseBoolean> deleteFriend(int friendId) async
    test('test deleteFriend', () async {
      // TODO
    });

    // 删除课程项
    //
    // 删除课程项
    //
    //Future<BaseResponseBoolean> deleteItem(int id) async
    test('test deleteItem', () async {
      // TODO
    });

    // 删除消息
    //
    //Future<BaseResponseVoid> deleteMessage(int groupId, int messageId) async
    test('test deleteMessage', () async {
      // TODO
    });

    // 删除节点
    //
    //Future<BaseResponseVoid> deleteNode(int id, String nodeId) async
    test('test deleteNode', () async {
      // TODO
    });

    // 删除帖子
    //
    //Future<BaseResponseVoid> deletePost(int postId) async
    test('test deletePost', () async {
      // TODO
    });

    // 删除回复
    //
    //Future<BaseResponseVoid> deleteReply(int replyId) async
    test('test deleteReply', () async {
      // TODO
    });

    // 删除小节（管理员）
    //
    //Future<BaseResponseVoid> deleteSection(int courseId, int sectionId) async
    test('test deleteSection', () async {
      // TODO
    });

    // 删除变量
    //
    //Future<BaseResponseVoid> deleteVariable(int id, String variableName) async
    test('test deleteVariable', () async {
      // TODO
    });

    // 解散群
    //
    //Future<BaseResponseVoid> dissolveGroup(int groupId) async
    test('test dissolveGroup', () async {
      // TODO
    });

    // 加密章节内容
    //
    // 对指定章节的内容进行AES加密存储
    //
    //Future<BaseResponseVoid> encryptChapterContent(int bookId, int chapterIndex) async
    test('test encryptChapterContent', () async {
      // TODO
    });

    // 执行工作流
    //
    //Future<BaseResponseExecutionResultResponse> execute(int id, ExecuteWorkflowRequest executeWorkflowRequest) async
    test('test execute', () async {
      // TODO
    });

    // 异步执行工作流
    //
    //Future<BaseResponseAsyncExecutionResponse> executeAsync(int id, ExecuteWorkflowRequest executeWorkflowRequest) async
    test('test executeAsync', () async {
      // TODO
    });

    // 收藏课程
    //
    //Future<BaseResponseVoid> favouriteCourse(int courseId) async
    test('test favouriteCourse', () async {
      // TODO
    });

    // 获取全部好友
    //
    // 获取当前用户的全部好友列表
    //
    //Future<BaseResponseListFriendResponse> getAllFriends() async
    test('test getAllFriends', () async {
      // TODO
    });

    // 获取公告详情
    //
    // 获取公告详细信息，包含阅读统计
    //
    //Future<BaseResponseAnnouncementResponse> getAnnouncement(int id) async
    test('test getAnnouncement', () async {
      // TODO
    });

    // 获取公告详情
    //
    // 获取公告详细内容
    //
    //Future<BaseResponseAnnouncementDetailResponse> getAnnouncementDetail(int id) async
    test('test getAnnouncementDetail', () async {
      // TODO
    });

    // 获取公告列表
    //
    // 获取用户可见的公告列表，包含已读状态
    //
    //Future<BaseResponseUserAnnouncementPageResponse> getAnnouncementList({ int pageNum, int pageSize }) async
    test('test getAnnouncementList', () async {
      // TODO
    });

    // 获取申请详情
    //
    //Future<BaseResponseTeacherApplicationResponse> getApplication(int id) async
    test('test getApplication', () async {
      // TODO
    });

    // 获取指定日期文章
    //
    //Future<BaseResponseListDailyArticleResponse> getArticlesByDate(Date date) async
    test('test getArticlesByDate', () async {
      // TODO
    });

    // 获取书籍详情
    //
    //Future<BaseResponseBookDTO> getBook(int bookId) async
    test('test getBook', () async {
      // TODO
    });

    // 获取书籍章节列表
    //
    //Future<BaseResponseListChapterDTO> getBookChapters(int bookId) async
    test('test getBookChapters', () async {
      // TODO
    });

    // 获取工作流详情
    //
    //Future<BaseResponseWorkflowResponse> getById(int id) async
    test('test getById', () async {
      // TODO
    });

    // 获取知识库详情
    //
    //Future<BaseResponseKnowledgeBaseVO> getById1(int id) async
    test('test getById1', () async {
      // TODO
    });

    // 获取章节详情
    //
    //Future<BaseResponseChapterResponse> getChapter(int courseId, int chapterId) async
    test('test getChapter', () async {
      // TODO
    });

    // 获取章节内容
    //
    //Future<BaseResponseChapterContentDTO> getChapterContent(int bookId, int chapterIndex) async
    test('test getChapterContent', () async {
      // TODO
    });

    // 获取聊天历史
    //
    // 获取与指定用户的聊天历史记录
    //
    //Future<BaseResponseChatMessagePageResponse> getChatHistory(ChatHistoryRequestDTO chatHistoryRequestDTO) async
    test('test getChatHistory', () async {
      // TODO
    });

    // 获取班级详情
    //
    //Future<BaseResponseClassResponse> getClassInfo(int classId) async
    test('test getClassInfo', () async {
      // TODO
    });

    // 获取班级成员列表
    //
    //Future<BaseResponsePageResponseClassMemberResponse> getClassMembers(int classId, { int pageNum, int pageSize }) async
    test('test getClassMembers', () async {
      // TODO
    });

    // 获取收藏文章列表
    //
    //Future<BaseResponseListUserDailyArticleResponse> getCollectedArticles({ int page, int size }) async
    test('test getCollectedArticles', () async {
      // TODO
    });

    // 获取收藏单词列表
    //
    //Future<BaseResponseListUserDailyWordResponse> getCollectedWords({ int page, int size }) async
    test('test getCollectedWords', () async {
      // TODO
    });

    // 获取评论回复列表
    //
    //Future<BaseResponseReplyPageResponse> getCommentReplies(int commentId, { int pageNum, int pageSize }) async
    test('test getCommentReplies', () async {
      // TODO
    });

    // 获取课程详情
    //
    //Future<BaseResponseCourseResponse> getCourse(int id) async
    test('test getCourse', () async {
      // TODO
    });

    // 获取课程所有小节的学习进度
    //
    //Future<BaseResponseListProgressResponse> getCourseProgress(int courseId) async
    test('test getCourseProgress', () async {
      // TODO
    });

    // 获取课程进度汇总
    //
    //Future<BaseResponseCourseProgressSummaryResponse> getCourseProgressSummary(int courseId) async
    test('test getCourseProgressSummary', () async {
      // TODO
    });

    // 获取课程完整结构（课程+章节+小节）
    //
    //Future<BaseResponseCourseStructureResponse> getCourseStructure(int courseId) async
    test('test getCourseStructure', () async {
      // TODO
    });

    // 获取文章详情
    //
    //Future<BaseResponseDailyArticleResponse> getDailyArticle(int id) async
    test('test getDailyArticle', () async {
      // TODO
    });

    // 获取单词详情
    //
    //Future<BaseResponseDailyWordResponse> getDailyWord(int id) async
    test('test getDailyWord', () async {
      // TODO
    });

    // 获取工作流定义详情
    //
    //Future<BaseResponseWorkflowDefinitionResponse> getDefinition(int id) async
    test('test getDefinition', () async {
      // TODO
    });

    // 获取工作流所有连接线
    //
    //Future<BaseResponseListWorkflowEdgeResponse> getEdges(int id) async
    test('test getEdges', () async {
      // TODO
    });

    // 获取执行日志
    //
    //Future<BaseResponseListExecutionLogResponse> getExecutionLogs(String executionId) async
    test('test getExecutionLogs', () async {
      // TODO
    });

    // 获取执行状态
    //
    //Future<BaseResponseExecutionResultResponse> getExecutionStatus(String executionId) async
    test('test getExecutionStatus', () async {
      // TODO
    });

    // 获取课程收藏数
    //
    //Future<BaseResponseLong> getFavouriteCount(int courseId) async
    test('test getFavouriteCount', () async {
      // TODO
    });

    // 获取反馈详情
    //
    // 获取指定反馈的详细信息及回复列表
    //
    //Future<BaseResponseFeedbackDetailResponse> getFeedbackDetail(int id) async
    test('test getFeedbackDetail', () async {
      // TODO
    });

    // 获取反馈详情
    //
    // 管理员获取反馈详细信息
    //
    //Future<BaseResponseFeedbackDetailResponse> getFeedbackDetail1(int id) async
    test('test getFeedbackDetail1', () async {
      // TODO
    });

    // 获取反馈回复列表
    //
    // 获取指定反馈的所有回复
    //
    //Future<BaseResponseListFeedbackReplyResponse> getFeedbackReplies(int id) async
    test('test getFeedbackReplies', () async {
      // TODO
    });

    // 获取反馈回复列表
    //
    // 管理员获取反馈的所有回复
    //
    //Future<BaseResponseListFeedbackReplyResponse> getFeedbackReplies1(int id) async
    test('test getFeedbackReplies1', () async {
      // TODO
    });

    // 按业务类型获取文件列表（管理员）
    //
    //Future<BaseResponseListFileInfoResponse> getFilesByBusinessType(String businessType, { int page, int size }) async
    test('test getFilesByBusinessType', () async {
      // TODO
    });

    // 获取好友列表
    //
    // 获取当前用户的好友列表
    //
    //Future<BaseResponseFriendPageResponse> getFriendList(FriendListRequestDTO friendListRequestDTO) async
    test('test getFriendList', () async {
      // TODO
    });

    // 获取群详情
    //
    //Future<BaseResponseGroupResponse> getGroupInfo(int groupId) async
    test('test getGroupInfo', () async {
      // TODO
    });

    // 获取群成员列表
    //
    //Future<BaseResponseListGroupMemberResponse> getGroupMembers(int groupId) async
    test('test getGroupMembers', () async {
      // TODO
    });

    // 分页获取群成员
    //
    //Future<BaseResponseMemberPage> getGroupMembersPage(int groupId, { int pageNum, int pageSize }) async
    test('test getGroupMembersPage', () async {
      // TODO
    });

    // 获取群最新消息
    //
    //Future<BaseResponseListGroupMessageItem> getLatestMessages(int groupId, { int limit }) async
    test('test getLatestMessages', () async {
      // TODO
    });

    // 获取点赞文章列表
    //
    //Future<BaseResponseListUserDailyArticleResponse> getLikedArticles({ int page, int size }) async
    test('test getLikedArticles', () async {
      // TODO
    });

    // 获取当前用户
    //
    // 获取当前登录用户信息
    //
    //Future<BaseResponseLoginUserResponse> getLoginUser() async
    test('test getLoginUser', () async {
      // TODO
    });

    // 获取群聊历史消息（分页）
    //
    //Future<BaseResponseGroupMessagePageResponse> getMessages(int groupId, { int pageNum, int pageSize }) async
    test('test getMessages', () async {
      // TODO
    });

    // 获取群聊历史消息（游标分页，获取某消息之前的消息）
    //
    //Future<BaseResponseListGroupMessageItem> getMessagesBefore(int groupId, int beforeMessageId, { int limit }) async
    test('test getMessagesBefore', () async {
      // TODO
    });

    // 获取当前用户的申请
    //
    //Future<BaseResponseTeacherApplicationResponse> getMyApplication() async
    test('test getMyApplication', () async {
      // TODO
    });

    // 获取我收藏的帖子
    //
    //Future<BaseResponsePostPageResponse> getMyFavourites({ int pageNum, int pageSize }) async
    test('test getMyFavourites', () async {
      // TODO
    });

    // 获取我的收藏列表
    //
    //Future<BaseResponseListCourseResponse> getMyFavourites1({ int page, int size }) async
    test('test getMyFavourites1', () async {
      // TODO
    });

    // 获取我的反馈列表
    //
    // 分页获取当前用户的反馈列表
    //
    //Future<BaseResponseFeedbackPageResponse> getMyFeedbacks({ int pageNum, int pageSize }) async
    test('test getMyFeedbacks', () async {
      // TODO
    });

    // 获取我的文件列表
    //
    //Future<BaseResponseListFileInfoResponse> getMyFiles({ int page, int size }) async
    test('test getMyFiles', () async {
      // TODO
    });

    // 获取我加入的群列表
    //
    //Future<BaseResponseListGroupResponse> getMyGroups() async
    test('test getMyGroups', () async {
      // TODO
    });

    // 获取我的订单列表
    //
    //Future<BaseResponseListOrderResponse> getMyOrders({ int page, int size }) async
    test('test getMyOrders', () async {
      // TODO
    });

    // 获取我的帖子列表
    //
    //Future<BaseResponseListPostResponse> getMyPosts() async
    test('test getMyPosts', () async {
      // TODO
    });

    // 获取我对该课程的评价
    //
    //Future<BaseResponseCourseReviewResponse> getMyReview(int courseId) async
    test('test getMyReview', () async {
      // TODO
    });

    // 获取我的课表
    //
    // 获取当前登录用户的完整课表（包括班级课表、执教课表、个人日程）
    //
    //Future<BaseResponseListClassScheduleItemResponse> getMySchedule() async
    test('test getMySchedule', () async {
      // TODO
    });

    // 获取当前用户的讲师信息
    //
    //Future<BaseResponseTeacherResponse> getMyTeacher() async
    test('test getMyTeacher', () async {
      // TODO
    });

    // 获取单个节点详情
    //
    //Future<BaseResponseWorkflowNodeResponse> getNode(int id, String nodeId) async
    test('test getNode', () async {
      // TODO
    });

    // 获取所有可用的节点类型
    //
    //Future<BaseResponseListNodeTypeResponse> getNodeTypes() async
    test('test getNodeTypes', () async {
      // TODO
    });

    // 获取工作流所有节点
    //
    //Future<BaseResponseListWorkflowNodeResponse> getNodes(int id) async
    test('test getNodes', () async {
      // TODO
    });

    // 查询订单详情
    //
    //Future<BaseResponseOrderResponse> getOrder(String orderNo) async
    test('test getOrder', () async {
      // TODO
    });

    // 获取待审核申请数量（管理员）
    //
    //Future<BaseResponseLong> getPendingCount() async
    test('test getPendingCount', () async {
      // TODO
    });

    // 获取群待审批申请列表
    //
    //Future<BaseResponseListJoinRequestResponse> getPendingRequests(int groupId) async
    test('test getPendingRequests', () async {
      // TODO
    });

    // 获取帖子评论列表
    //
    //Future<BaseResponseCommentPageResponse> getPostComments(int postId, { int pageNum, int pageSize }) async
    test('test getPostComments', () async {
      // TODO
    });

    // 获取帖子详情
    //
    //Future<BaseResponsePostDetailResponse> getPostDetail(int postId) async
    test('test getPostDetail', () async {
      // TODO
    });

    // 分页获取帖子列表
    //
    //Future<BaseResponsePostPageResponse> getPostList({ int pageNum, int pageSize }) async
    test('test getPostList', () async {
      // TODO
    });

    // 根据类型获取帖子列表
    //
    //Future<BaseResponsePostPageResponse> getPostListByType(String postType, { int pageNum, int pageSize }) async
    test('test getPostListByType', () async {
      // TODO
    });

    // 获取已阅读文章列表
    //
    //Future<BaseResponseListUserDailyArticleResponse> getReadArticles({ int page, int size }) async
    test('test getReadArticles', () async {
      // TODO
    });

    // 获取消息已读人数
    //
    //Future<BaseResponseInteger> getReadCount(int messageId) async
    test('test getReadCount', () async {
      // TODO
    });

    // 获取收到的好友申请
    //
    // 获取当前用户收到的好友申请列表
    //
    //Future<BaseResponseFriendRequestPageResponse> getReceivedRequests(FriendRequestListDTO friendRequestListDTO) async
    test('test getReceivedRequests', () async {
      // TODO
    });

    // 获取课程评价数
    //
    //Future<BaseResponseLong> getReviewCount(int courseId) async
    test('test getReviewCount', () async {
      // TODO
    });

    // 获取特定配置的课表
    //
    // 根据配置ID获取课表预览
    //
    //Future<BaseResponseScheduleResponse> getScheduleBySetting(int settingId) async
    test('test getScheduleBySetting', () async {
      // TODO
    });

    // 获取小节详情
    //
    //Future<BaseResponseSectionResponse> getSection(int courseId, int sectionId) async
    test('test getSection', () async {
      // TODO
    });

    // 获取小节学习进度
    //
    //Future<BaseResponseProgressResponse> getSectionProgress(int sectionId) async
    test('test getSectionProgress', () async {
      // TODO
    });

    // 获取发送的好友申请
    //
    // 获取当前用户发送的好友申请列表
    //
    //Future<BaseResponseFriendRequestPageResponse> getSentRequests(FriendRequestListDTO friendRequestListDTO) async
    test('test getSentRequests', () async {
      // TODO
    });

    // 获取会话列表
    //
    // 获取当前用户的所有私聊会话
    //
    //Future<BaseResponseListChatSessionResponse> getSessionList() async
    test('test getSessionList', () async {
      // TODO
    });

    // 订单统计（管理员）
    //
    //Future<BaseResponseOrderStatistics> getStatistics() async
    test('test getStatistics', () async {
      // TODO
    });

    // 获取生词本统计
    //
    //Future<BaseResponseWordBookStats> getStats() async
    test('test getStats', () async {
      // TODO
    });

    // 获取学习统计
    //
    //Future<BaseResponseLearningStats> getStats1() async
    test('test getStats1', () async {
      // TODO
    });

    // 获取阅读统计
    //
    //Future<BaseResponseReadingStats> getStats2() async
    test('test getStats2', () async {
      // TODO
    });

    // 获取已学习单词列表
    //
    //Future<BaseResponseListUserDailyWordResponse> getStudiedWords({ int page, int size }) async
    test('test getStudiedWords', () async {
      // TODO
    });

    // 获取支持的发音人列表
    //
    //Future<BaseResponseString> getSupportedVoices() async
    test('test getSupportedVoices', () async {
      // TODO
    });

    // 获取讲师信息
    //
    //Future<BaseResponseTeacherResponse> getTeacher(int id) async
    test('test getTeacher', () async {
      // TODO
    });

    // 根据用户ID获取讲师信息
    //
    //Future<BaseResponseTeacherResponse> getTeacherByUserId(int userId) async
    test('test getTeacherByUserId', () async {
      // TODO
    });

    // 获取今日推荐文章（个性化推荐）
    //
    //Future<BaseResponseListDailyArticleResponse> getTodayArticles({ int size }) async
    test('test getTodayArticles', () async {
      // TODO
    });

    // 获取今日推荐单词（个性化推荐）
    //
    //Future<BaseResponseListDailyWordResponse> getTodayWords({ int size }) async
    test('test getTodayWords', () async {
      // TODO
    });

    // 获取群未读消息数
    //
    //Future<BaseResponseInteger> getUnreadCount(int groupId) async
    test('test getUnreadCount', () async {
      // TODO
    });

    // 获取未读消息数
    //
    // 获取当前用户的未读消息总数
    //
    //Future<BaseResponseInteger> getUnreadCount1() async
    test('test getUnreadCount1', () async {
      // TODO
    });

    // 获取未读公告数量
    //
    // 获取当前用户未读公告的数量
    //
    //Future<BaseResponseLong> getUnreadCount2() async
    test('test getUnreadCount2', () async {
      // TODO
    });

    // 获取用户详情
    //
    // 管理员获取用户详细信息
    //
    //Future<BaseResponseUserDetailResponse> getUserDetail(int id) async
    test('test getUserDetail', () async {
      // TODO
    });

    // 获取指定用户的帖子列表
    //
    //Future<BaseResponseListPostResponse> getUserPosts(int targetUserId) async
    test('test getUserPosts', () async {
      // TODO
    });

    // 获取用户公开信息
    //
    // 获取其他用户的公开信息（非敏感）
    //
    //Future<BaseResponseUserPublicResponse> getUserPublicInfo(int id) async
    test('test getUserPublicInfo', () async {
      // TODO
    });

    // 获取用户书架
    //
    //Future<BaseResponseListUserShelfDTO> getUserShelf(int userId, { int page, int size }) async
    test('test getUserShelf', () async {
      // TODO
    });

    // 获取工作流所有变量
    //
    //Future<BaseResponseListWorkflowVariableResponse> getVariables(int id) async
    test('test getVariables', () async {
      // TODO
    });

    // 获取生词本列表
    //
    //Future<BaseResponseListUserWordBookResponse> getWordBookList({ int status, int page, int size }) async
    test('test getWordBookList', () async {
      // TODO
    });

    // 获取指定日期单词
    //
    //Future<BaseResponseListDailyWordResponse> getWordsByDate(Date date) async
    test('test getWordsByDate', () async {
      // TODO
    });

    // 处理好友申请
    //
    // 接受或拒绝好友申请
    //
    //Future<BaseResponseBoolean> handleFriendRequest(HandleFriendRequestDTO handleFriendRequestDTO) async
    test('test handleFriendRequest', () async {
      // TODO
    });

    // 处理加入申请
    //
    //Future<BaseResponseVoid> handleJoinRequest(int requestId, HandleJoinRequestDTO handleJoinRequestDTO) async
    test('test handleJoinRequest', () async {
      // TODO
    });

    // 健康检查
    //
    // 检查服务是否正常运行
    //
    //Future<BaseResponseString> health() async
    test('test health', () async {
      // TODO
    });

    // 邀请用户加入群
    //
    //Future<BaseResponseVoid> inviteMember(int groupId, int inviteeId) async
    test('test inviteMember', () async {
      // TODO
    });

    // 退出群
    //
    //Future<BaseResponseVoid> leaveGroup(int groupId) async
    test('test leaveGroup', () async {
      // TODO
    });

    // 获取申请列表（管理员）
    //
    //Future<BaseResponseListTeacherApplicationResponse> listApplications({ int status, int page, int size }) async
    test('test listApplications', () async {
      // TODO
    });

    // 获取文章列表
    //
    //Future<BaseResponseListDailyArticleResponse> listArticles({ String category, int difficulty, int page, int size }) async
    test('test listArticles', () async {
      // TODO
    });

    // 获取书籍列表
    //
    //Future<BaseResponseListBookDTO> listBooks({ int page, int size }) async
    test('test listBooks', () async {
      // TODO
    });

    // 获取用户的知识库列表
    //
    //Future<BaseResponseListKnowledgeBaseVO> listByCreator(int userId, { int page, int size }) async
    test('test listByCreator', () async {
      // TODO
    });

    // 获取用户的工作流列表
    //
    //Future<BaseResponseListWorkflowResponse> listByUser(int userId, { int page, int size }) async
    test('test listByUser', () async {
      // TODO
    });

    // 获取课程的章节列表
    //
    //Future<BaseResponseListChapterResponse> listChapters(int courseId) async
    test('test listChapters', () async {
      // TODO
    });

    // 获取课程列表
    //
    //Future<BaseResponseListCourseResponse> listCourses({ int status, int page, int size }) async
    test('test listCourses', () async {
      // TODO
    });

    // 获取讲师的课程列表
    //
    //Future<BaseResponseListCourseResponse> listCoursesByTeacher(int teacherId, { int page, int size }) async
    test('test listCoursesByTeacher', () async {
      // TODO
    });

    // 获取文档列表
    //
    //Future<BaseResponseListKnowledgeDocumentVO> listDocuments(int id, { int page, int size }) async
    test('test listDocuments', () async {
      // TODO
    });

    // 获取订单列表（管理员）
    //
    //Future<BaseResponseListOrderResponse> listOrders({ int status, int page, int size }) async
    test('test listOrders', () async {
      // TODO
    });

    // 获取公开的工作流列表
    //
    //Future<BaseResponseListWorkflowResponse> listPublic({ int page, int size }) async
    test('test listPublic', () async {
      // TODO
    });

    // 获取课程评价列表
    //
    //Future<BaseResponseListCourseReviewResponse> listReviews(int courseId, { int page, int size }) async
    test('test listReviews', () async {
      // TODO
    });

    // 获取课程的所有小节
    //
    //Future<BaseResponseListSectionResponse> listSections(int courseId) async
    test('test listSections', () async {
      // TODO
    });

    // 获取讲师列表
    //
    //Future<BaseResponseListTeacherResponse> listTeachers({ int page, int size }) async
    test('test listTeachers', () async {
      // TODO
    });

    // 获取单词列表
    //
    //Future<BaseResponseListDailyWordResponse> listWords({ String category, int difficulty, int page, int size }) async
    test('test listWords', () async {
      // TODO
    });

    // 标记文章为已阅读
    //
    //Future<BaseResponseVoid> markAsRead(int articleId) async
    test('test markAsRead', () async {
      // TODO
    });

    // 标记消息已读
    //
    //Future<BaseResponseVoid> markAsRead1(int groupId, int messageId) async
    test('test markAsRead1', () async {
      // TODO
    });

    // 标记消息已读
    //
    // 标记与指定用户的消息为已读
    //
    //Future<BaseResponseBoolean> markAsRead2(int senderId) async
    test('test markAsRead2', () async {
      // TODO
    });

    // 标记公告已读
    //
    // 将公告标记为已读
    //
    //Future<BaseResponseBoolean> markAsRead3(int id) async
    test('test markAsRead3', () async {
      // TODO
    });

    // 标记回复为已读
    //
    // 将反馈的所有回复标记为已读
    //
    //Future<BaseResponseBoolean> markRepliesAsRead(int id) async
    test('test markRepliesAsRead', () async {
      // TODO
    });

    // 下线公告
    //
    // 将公告状态改为已下线
    //
    //Future<BaseResponseBoolean> offlineAnnouncement(int id) async
    test('test offlineAnnouncement', () async {
      // TODO
    });

    // 手机验证码登录
    //
    // 使用手机号和验证码登录，未注册用户自动注册
    //
    //Future<BaseResponseLoginUserResponse> phoneLogin(PhoneLoginRequest phoneLoginRequest) async
    test('test phoneLogin', () async {
      // TODO
    });

    // 触发文档向量化
    //
    //Future<BaseResponseVoid> processDocument(int id, int docId) async
    test('test processDocument', () async {
      // TODO
    });

    // 发布工作流
    //
    //Future<BaseResponseWorkflowResponse> publish1(int id) async
    test('test publish1', () async {
      // TODO
    });

    // 发布群公告
    //
    //Future<BaseResponseVoid> publishAnnouncement(int groupId, String body) async
    test('test publishAnnouncement', () async {
      // TODO
    });

    // 发布公告
    //
    // 将公告状态改为已发布
    //
    //Future<BaseResponseBoolean> publishAnnouncement1(int id) async
    test('test publishAnnouncement1', () async {
      // TODO
    });

    // 发布课程（管理员）
    //
    //Future<BaseResponseVoid> publishCourse(int id) async
    test('test publishCourse', () async {
      // TODO
    });

    // 分页查询公告
    //
    // 管理员分页查询公告列表
    //
    //Future<BaseResponseAnnouncementPageResponse> queryAnnouncements(QueryAnnouncementRequest queryAnnouncementRequest) async
    test('test queryAnnouncements', () async {
      // TODO
    });

    // 分页查询反馈
    //
    // 管理员分页查询所有反馈
    //
    //Future<BaseResponseFeedbackPageResponse> queryFeedbacks(QueryFeedbackRequest queryFeedbackRequest) async
    test('test queryFeedbacks', () async {
      // TODO
    });

    // 分页查询用户
    //
    // 管理员分页查询用户，支持模糊搜索
    //
    //Future<BaseResponseUserPageResponse> queryUsers(QueryUserRequest queryUserRequest) async
    test('test queryUsers', () async {
      // TODO
    });

    // 退款（管理员）
    //
    //Future<BaseResponseVoid> refund(String orderNo) async
    test('test refund', () async {
      // TODO
    });

    // 移除课程
    //
    //Future<BaseResponseVoid> removeCourse(int classId, int courseId) async
    test('test removeCourse', () async {
      // TODO
    });

    // 从书架移除书籍
    //
    //Future<BaseResponseVoid> removeFromShelf(int userId, int bookId) async
    test('test removeFromShelf', () async {
      // TODO
    });

    // 从生词本移除单词
    //
    //Future<BaseResponseVoid> removeFromWordBook(int wordBookId) async
    test('test removeFromWordBook', () async {
      // TODO
    });

    // 移除成员
    //
    //Future<BaseResponseVoid> removeMember(int groupId, int targetUserId) async
    test('test removeMember', () async {
      // TODO
    });

    // 移除成员
    //
    //Future<BaseResponseVoid> removeMember1(int classId, int userId) async
    test('test removeMember1', () async {
      // TODO
    });

    // 回复反馈
    //
    // 用户回复自己的反馈
    //
    //Future<BaseResponseLong> replyFeedback(CreateReplyRequest createReplyRequest) async
    test('test replyFeedback', () async {
      // TODO
    });

    // 回复反馈
    //
    // 管理员回复用户反馈
    //
    //Future<BaseResponseLong> replyFeedback1(CreateReplyRequest createReplyRequest) async
    test('test replyFeedback1', () async {
      // TODO
    });

    // 重置用户密码
    //
    // 管理员重置指定用户的密码
    //
    //Future<BaseResponseBoolean> resetPassword(ResetPasswordRequest resetPasswordRequest) async
    test('test resetPassword', () async {
      // TODO
    });

    // 重置小节进度
    //
    //Future<BaseResponseVoid> resetProgress(int sectionId) async
    test('test resetProgress', () async {
      // TODO
    });

    // 审核讲师申请（管理员）
    //
    //Future<BaseResponseVoid> reviewApplication(ReviewApplicationRequest reviewApplicationRequest) async
    test('test reviewApplication', () async {
      // TODO
    });

    // 评价课程
    //
    //Future<BaseResponseLong> reviewCourse(int courseId, ReviewCourseRequest reviewCourseRequest) async
    test('test reviewCourse', () async {
      // TODO
    });

    // 搜索知识库
    //
    //Future<BaseResponseListKnowledgeBaseVO> search(String keyword, int userId, { int page, int size }) async
    test('test search', () async {
      // TODO
    });

    // 搜索文章
    //
    //Future<BaseResponseListDailyArticleResponse> searchArticles(String keyword, { int page, int size }) async
    test('test searchArticles', () async {
      // TODO
    });

    // 搜索书籍
    //
    //Future<BaseResponseListBookDTO> searchBooks(String keyword, { int page, int size }) async
    test('test searchBooks', () async {
      // TODO
    });

    // 搜索课程
    //
    //Future<BaseResponseListCourseResponse> searchCourses(String keyword, { int page, int size }) async
    test('test searchCourses', () async {
      // TODO
    });

    // 搜索群
    //
    //Future<BaseResponseGroupPage> searchGroups(String keyword, { int pageNum, int pageSize }) async
    test('test searchGroups', () async {
      // TODO
    });

    // 搜索帖子
    //
    //Future<BaseResponsePostPageResponse> searchPosts(String keyword, { int pageNum, int pageSize }) async
    test('test searchPosts', () async {
      // TODO
    });

    // 根据标签搜索帖子
    //
    //Future<BaseResponsePostPageResponse> searchPostsByTag(String tag, { int pageNum, int pageSize }) async
    test('test searchPostsByTag', () async {
      // TODO
    });

    // 搜索用户
    //
    // 根据关键词搜索用户，用于添加好友
    //
    //Future<BaseResponseSearchUserPageResponse> searchUsers(SearchUserRequestDTO searchUserRequestDTO) async
    test('test searchUsers', () async {
      // TODO
    });

    // 搜索单词
    //
    //Future<BaseResponseListDailyWordResponse> searchWords(String keyword, { int page, int size }) async
    test('test searchWords', () async {
      // TODO
    });

    // 发送好友申请
    //
    // 向指定用户发送好友申请
    //
    //Future<BaseResponseLong> sendFriendRequest(SendFriendRequestDTO sendFriendRequestDTO) async
    test('test sendFriendRequest', () async {
      // TODO
    });

    // 发送注册验证码
    //
    // 发送短信验证码用于注册
    //
    //Future<BaseResponseSendResult> sendRegisterCode(SendCodeRequest sendCodeRequest) async
    test('test sendRegisterCode', () async {
      // TODO
    });

    // 发送短信验证码
    //
    // 管理员手动发送短信验证码
    //
    //Future<BaseResponseSendResult> sendSms(SendSmsRequest sendSmsRequest) async
    test('test sendSms', () async {
      // TODO
    });

    // 设置/取消管理员
    //
    //Future<BaseResponseVoid> setAdmin(int groupId, int targetUserId, bool isAdmin) async
    test('test setAdmin', () async {
      // TODO
    });

    // 设置群加入模式
    //
    // 0-自由加入，1-需审批，2-禁止加入
    //
    //Future<BaseResponseVoid> setJoinMode(int groupId, int mode) async
    test('test setJoinMode', () async {
      // TODO
    });

    // 标记单词为已学习
    //
    //Future<BaseResponseVoid> studyWord(int wordId) async
    test('test studyWord', () async {
      // TODO
    });

    // 下架课程（管理员）
    //
    //Future<BaseResponseVoid> takeOffline(int id) async
    test('test takeOffline', () async {
      // TODO
    });

    // 文本转语音
    //
    // 将文本转换为语音，返回音频文件
    //
    //Future<String> textToSpeech(TtsRequest ttsRequest) async
    test('test textToSpeech', () async {
      // TODO
    });

    // 文本转语音 (Base64)
    //
    // 将文本转换为语音，返回 Base64 编码的音频数据
    //
    //Future<BaseResponseTtsResponse> textToSpeechBase64(TtsRequest ttsRequest) async
    test('test textToSpeechBase64', () async {
      // TODO
    });

    // 收藏/取消收藏单词
    //
    //Future<BaseResponseVoid> toggleCollect(int wordId) async
    test('test toggleCollect', () async {
      // TODO
    });

    // 收藏/取消收藏文章
    //
    //Future<BaseResponseVoid> toggleCollect1(int articleId) async
    test('test toggleCollect1', () async {
      // TODO
    });

    // 收藏/取消收藏帖子
    //
    //Future<BaseResponseBoolean> toggleFavour(int postId) async
    test('test toggleFavour', () async {
      // TODO
    });

    // 点赞/取消点赞文章
    //
    //Future<BaseResponseVoid> toggleLike(int articleId) async
    test('test toggleLike', () async {
      // TODO
    });

    // 点赞/取消点赞帖子
    //
    //Future<BaseResponseBoolean> toggleThumb(int postId) async
    test('test toggleThumb', () async {
      // TODO
    });

    // 转让群主
    //
    //Future<BaseResponseVoid> transferOwnership(int groupId, int newOwnerId) async
    test('test transferOwnership', () async {
      // TODO
    });

    // 取消收藏
    //
    //Future<BaseResponseVoid> unfavouriteCourse(int courseId) async
    test('test unfavouriteCourse', () async {
      // TODO
    });

    // 更新工作流基本信息
    //
    //Future<BaseResponseWorkflowResponse> update(int id, UpdateWorkflowRequest updateWorkflowRequest) async
    test('test update', () async {
      // TODO
    });

    // 更新知识库
    //
    //Future<BaseResponseKnowledgeBaseVO> update1(int id, UpdateKnowledgeBaseCommand updateKnowledgeBaseCommand) async
    test('test update1', () async {
      // TODO
    });

    // 更新公告
    //
    // 更新公告信息
    //
    //Future<BaseResponseBoolean> updateAnnouncement(UpdateAnnouncementRequest updateAnnouncementRequest) async
    test('test updateAnnouncement', () async {
      // TODO
    });

    // 更新章节（管理员）
    //
    //Future<BaseResponseVoid> updateChapter(int courseId, int chapterId, UpdateChapterRequest updateChapterRequest) async
    test('test updateChapter', () async {
      // TODO
    });

    // 更新班级信息
    //
    //Future<BaseResponseVoid> updateClass(int classId, UpdateClassRequest updateClassRequest) async
    test('test updateClass', () async {
      // TODO
    });

    // 更新课程（管理员）
    //
    //Future<BaseResponseVoid> updateCourse(int id, UpdateCourseRequest updateCourseRequest) async
    test('test updateCourse', () async {
      // TODO
    });

    // 更新每日文章（管理员）
    //
    //Future<BaseResponseVoid> updateDailyArticle(int id, UpdateDailyArticleRequest updateDailyArticleRequest) async
    test('test updateDailyArticle', () async {
      // TODO
    });

    // 更新每日单词（管理员）
    //
    //Future<BaseResponseVoid> updateDailyWord(int id, UpdateDailyWordRequest updateDailyWordRequest) async
    test('test updateDailyWord', () async {
      // TODO
    });

    // 更新工作流定义
    //
    //Future<BaseResponseWorkflowResponse> updateDefinition(int id, UpdateWorkflowDefinitionRequest updateWorkflowDefinitionRequest) async
    test('test updateDefinition', () async {
      // TODO
    });

    // 更新连接线
    //
    //Future<BaseResponseWorkflowEdgeResponse> updateEdge(int id, String edgeId, UpdateEdgeRequest updateEdgeRequest) async
    test('test updateEdge', () async {
      // TODO
    });

    // 更新反馈状态
    //
    // 管理员更新反馈处理状态
    //
    //Future<BaseResponseBoolean> updateFeedbackStatus(UpdateFeedbackStatusRequest updateFeedbackStatusRequest) async
    test('test updateFeedbackStatus', () async {
      // TODO
    });

    // 更新群信息
    //
    //Future<BaseResponseVoid> updateGroupInfo(int groupId, UpdateGroupRequest updateGroupRequest) async
    test('test updateGroupInfo', () async {
      // TODO
    });

    // 更新课程项
    //
    // 更新课程项信息
    //
    //Future<BaseResponseBoolean> updateItem(int id, UpdateScheduleItemRequest updateScheduleItemRequest) async
    test('test updateItem', () async {
      // TODO
    });

    // 更新学习状态
    //
    //Future<BaseResponseVoid> updateLearningStatus(int wordBookId, int status) async
    test('test updateLearningStatus', () async {
      // TODO
    });

    // 更新单词掌握程度
    //
    //Future<BaseResponseVoid> updateMastery(int wordId, int level) async
    test('test updateMastery', () async {
      // TODO
    });

    // 更新节点
    //
    //Future<BaseResponseWorkflowNodeResponse> updateNode(int id, String nodeId, UpdateNodeRequest updateNodeRequest) async
    test('test updateNode', () async {
      // TODO
    });

    // 更新节点配置
    //
    //Future<BaseResponseWorkflowNodeResponse> updateNodeConfig(int id, String nodeId, UpdateNodeConfigRequest updateNodeConfigRequest) async
    test('test updateNodeConfig', () async {
      // TODO
    });

    // 更新帖子
    //
    //Future<BaseResponseVoid> updatePost(int postId, UpdatePostRequest updatePostRequest) async
    test('test updatePost', () async {
      // TODO
    });

    // 更新个人资料
    //
    // 用户更新自己的个人资料
    //
    //Future<BaseResponseBoolean> updateProfile(UpdateProfileRequest updateProfileRequest) async
    test('test updateProfile', () async {
      // TODO
    });

    // 更新阅读进度
    //
    //Future<BaseResponseVoid> updateProgress(UpdateReadingProgressCommand updateReadingProgressCommand) async
    test('test updateProgress', () async {
      // TODO
    });

    // 更新学习进度
    //
    //Future<BaseResponseVoid> updateProgress1(UpdateProgressRequest updateProgressRequest) async
    test('test updateProgress1', () async {
      // TODO
    });

    // 更新评价
    //
    //Future<BaseResponseVoid> updateReview(int reviewId, ReviewCourseRequest reviewCourseRequest) async
    test('test updateReview', () async {
      // TODO
    });

    // 更新小节（管理员）
    //
    //Future<BaseResponseVoid> updateSection(int courseId, int sectionId, UpdateSectionRequest updateSectionRequest) async
    test('test updateSection', () async {
      // TODO
    });

    // 更新课表配置
    //
    // 更新课表基础配置
    //
    //Future<BaseResponseBoolean> updateSetting(int id, UpdateScheduleSettingRequest updateScheduleSettingRequest) async
    test('test updateSetting', () async {
      // TODO
    });

    // 更新工作流设置
    //
    //Future<BaseResponseWorkflowSettingsDTO> updateSettings(int id, UpdateWorkflowSettingsRequest updateWorkflowSettingsRequest) async
    test('test updateSettings', () async {
      // TODO
    });

    // 更新讲师信息
    //
    //Future<BaseResponseVoid> updateTeacher(int id, UpdateTeacherRequest updateTeacherRequest) async
    test('test updateTeacher', () async {
      // TODO
    });

    // 更新用户
    //
    // 管理员更新用户信息
    //
    //Future<BaseResponseBoolean> updateUser(UpdateUserRequest updateUserRequest) async
    test('test updateUser', () async {
      // TODO
    });

    // 更新变量
    //
    //Future<BaseResponseWorkflowVariableResponse> updateVariable(int id, String variableName, UpdateVariableRequest updateVariableRequest) async
    test('test updateVariable', () async {
      // TODO
    });

    // 上传书籍
    //
    //Future<BaseResponseBookDTO> uploadBook(UploadBookCommand command) async
    test('test uploadBook', () async {
      // TODO
    });

    // 上传文件（按业务类型）
    //
    //Future<BaseResponseUploadFileResponse> uploadFile(String businessType, { UploadFileRequest uploadFileRequest }) async
    test('test uploadFile', () async {
      // TODO
    });

    // 用户登录
    //
    // 用户登录并获取 JWT Token
    //
    //Future<BaseResponseLoginUserResponse> userLogin(UserLoginRequest userLoginRequest) async
    test('test userLogin', () async {
      // TODO
    });

    // 用户注册
    //
    // 新用户注册接口，需先获取短信验证码
    //
    //Future<BaseResponseLong> userRegister(UserRegisterRequest userRegisterRequest) async
    test('test userRegister', () async {
      // TODO
    });

    // 验证工作流定义
    //
    //Future<BaseResponseWorkflowValidationResponse> validate(int id) async
    test('test validate', () async {
      // TODO
    });
  });
}
