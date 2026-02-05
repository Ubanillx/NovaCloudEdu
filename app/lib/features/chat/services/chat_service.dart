import 'package:nova_api/nova_api.dart';
import '../../../core/network/api_client.dart';

/// 聊天服务 - HTTP API
class ChatService {
  final _api = ApiClient.instance;

  /// 获取会话列表
  Future<List<ChatSessionResponse>> getSessionList() async {
    try {
      final response = await _api.defaultApi.getSessionList();
      return response.data?.data?.toList() ?? [];
    } catch (e) {
      rethrow;
    }
  }

  /// 获取聊天历史记录
  Future<List<ChatMessageResponse>> getChatHistory({
    required int partnerId,
    int page = 1,
    int size = 20,
    int? beforeMessageId,
  }) async {
    try {
      final response = await _api.defaultApi.getChatHistory(
        chatHistoryRequestDTO: ChatHistoryRequestDTO((b) => b
          ..partnerId = partnerId
          ..page = page
          ..size = size
          ..beforeMessageId = beforeMessageId),
      );
      return response.data?.data?.messages?.toList() ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
