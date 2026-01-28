import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

/// tests for AIApi
void main() {
  final instance = NovaApi().getAIApi();

  group(AIApi, () {
    // 归档AI助手
    //
    //Future<BaseResponseAiAssistantVO> archive(int id) async
    test('test archive', () async {
      // TODO
    });

    // 提问（新对话）
    //
    //Future<BaseResponseMapStringObject> askQuestion(int bookId, BuiltMap<String, JsonObject> requestBody) async
    test('test askQuestion', () async {
      // TODO
    });

    // 绑定知识库
    //
    //Future<BaseResponseVoid> bindKnowledgeBase(int id, int kbId) async
    test('test bindKnowledgeBase', () async {
      // TODO
    });

    // 绑定工作流到AI助手
    //
    //Future<BaseResponseVoid> bindWorkflow(int id, int workflowId) async
    test('test bindWorkflow', () async {
      // TODO
    });

    // 继续对话
    //
    //Future<BaseResponseMapStringObject> continueConversation(int bookId, int conversationId, BuiltMap<String, String> requestBody) async
    test('test continueConversation', () async {
      // TODO
    });

    // 创建AI助手
    //
    //Future<BaseResponseAiAssistantVO> create2(int userId, CreateAiAssistantCommand createAiAssistantCommand) async
    test('test create2', () async {
      // TODO
    });

    // 删除AI助手
    //
    //Future<BaseResponseVoid> delete2(int id) async
    test('test delete2', () async {
      // TODO
    });

    // 执行AI助手绑定的工作流
    //
    //Future<BaseResponseMapStringObject> executeWorkflow(int id, int workflowId, int userId, { BuiltMap<String, JsonObject> requestBody }) async
    test('test executeWorkflow', () async {
      // TODO
    });

    // 提取章节知识点
    //
    //Future<BaseResponseListKnowledgePoint> extractKnowledgePoints(int bookId, int chapterId) async
    test('test extractKnowledgePoints', () async {
      // TODO
    });

    // 生成阅读测试
    //
    //Future<BaseResponseReadingQuiz> generateQuiz(int bookId, int chapterId, { int questionCount, String difficulty }) async
    test('test generateQuiz', () async {
      // TODO
    });

    // 生成章节总结
    //
    //Future<BaseResponseChapterSummary> generateSummary(int bookId, int chapterId, { String summaryType }) async
    test('test generateSummary', () async {
      // TODO
    });

    // 获取章节所有总结
    //
    //Future<BaseResponseListChapterSummary> getAllSummaries(int bookId, int chapterId) async
    test('test getAllSummaries', () async {
      // TODO
    });

    // 获取AI助手详情
    //
    //Future<BaseResponseAiAssistantVO> getById2(int id) async
    test('test getById2', () async {
      // TODO
    });

    // 获取对话历史
    //
    //Future<BaseResponseAiConversation> getConversation(int bookId, int conversationId) async
    test('test getConversation', () async {
      // TODO
    });

    // 获取章节知识点
    //
    //Future<BaseResponseListKnowledgePoint> getKnowledgePoints(int bookId, int chapterId, { String type }) async
    test('test getKnowledgePoints', () async {
      // TODO
    });

    // 获取章节最新测试
    //
    //Future<BaseResponseReadingQuiz> getLatestQuiz(int bookId, int chapterId) async
    test('test getLatestQuiz', () async {
      // TODO
    });

    // 获取测试
    //
    //Future<BaseResponseReadingQuiz> getQuiz(int bookId, int quizId) async
    test('test getQuiz', () async {
      // TODO
    });

    // 获取章节总结
    //
    //Future<BaseResponseChapterSummary> getSummary(int bookId, int chapterId, { String summaryType }) async
    test('test getSummary', () async {
      // TODO
    });

    // 获取用户对话列表
    //
    //Future<BaseResponseListAiConversation> getUserConversations(int bookId, int userId, { int page, int size }) async
    test('test getUserConversations', () async {
      // TODO
    });

    // 获取AI助手绑定的工作流列表
    //
    //Future<BaseResponseListLong> getWorkflows(int id) async
    test('test getWorkflows', () async {
      // TODO
    });

    // 获取用户的AI助手列表
    //
    //Future<BaseResponseListAiAssistantVO> listByCreator1(int userId, { int page, int size }) async
    test('test listByCreator1', () async {
      // TODO
    });

    // 获取公开的AI助手列表
    //
    //Future<BaseResponseListAiAssistantVO> listPublic1({ int page, int size }) async
    test('test listPublic1', () async {
      // TODO
    });

    // 发布AI助手
    //
    //Future<BaseResponseAiAssistantVO> publish(int id) async
    test('test publish', () async {
      // TODO
    });

    // 重新提取知识点
    //
    //Future<BaseResponseListKnowledgePoint> regenerateKnowledgePoints(int bookId, int chapterId) async
    test('test regenerateKnowledgePoints', () async {
      // TODO
    });

    // 重新生成总结
    //
    //Future<BaseResponseChapterSummary> regenerateSummary(int bookId, int chapterId, { String summaryType }) async
    test('test regenerateSummary', () async {
      // TODO
    });

    // 搜索AI助手
    //
    //Future<BaseResponseListAiAssistantVO> search1(String keyword, { int page, int size }) async
    test('test search1', () async {
      // TODO
    });

    // 搜索知识点
    //
    //Future<BaseResponseListKnowledgePoint> searchKnowledgePoints(int bookId, String keyword, { int page, int size }) async
    test('test searchKnowledgePoints', () async {
      // TODO
    });

    // 流式对话
    //
    // 使用SSE推送方式进行AI对话
    //
    //Future<SseEmitter> streamChat(ChatRequest chatRequest) async
    test('test streamChat', () async {
      // TODO
    });

    // 提交答案并评分
    //
    //Future<BaseResponseMapStringObject> submitAnswers(int bookId, int quizId, BuiltMap<String, BuiltList<String>> requestBody) async
    test('test submitAnswers', () async {
      // TODO
    });

    // 解绑知识库
    //
    //Future<BaseResponseVoid> unbindKnowledgeBase(int id, int kbId) async
    test('test unbindKnowledgeBase', () async {
      // TODO
    });

    // 解绑工作流
    //
    //Future<BaseResponseVoid> unbindWorkflow(int id, int workflowId) async
    test('test unbindWorkflow', () async {
      // TODO
    });

    // 更新AI助手
    //
    //Future<BaseResponseAiAssistantVO> update2(int id, UpdateAiAssistantCommand updateAiAssistantCommand) async
    test('test update2', () async {
      // TODO
    });
  });
}
