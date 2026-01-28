import 'package:nova_api/nova_api.dart';
import '../../../core/network/api_client.dart';

/// 用户反馈服务
class FeedbackService {
  final _api = ApiClient.instance.defaultApi;

  /// 创建反馈
  Future<BaseResponseLong> createFeedback({
    required String feedbackType,
    required String content,
    String? title,
    String? attachment,
  }) async {
    try {
      final response = await _api.createFeedback(
        createFeedbackRequest: CreateFeedbackRequest((b) => b
          ..feedbackType = feedbackType
          ..content = content
          ..title = title
          ..attachment = attachment),
      );
      return response.data!;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取我的反馈列表
  Future<BaseResponseFeedbackPageResponse> getMyFeedbacks({
    int pageNum = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _api.getMyFeedbacks(
        pageNum: pageNum,
        pageSize: pageSize,
      );
      return response.data!;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取反馈详情
  Future<BaseResponseFeedbackDetailResponse> getFeedbackDetail(int id) async {
    try {
      final response = await _api.getFeedbackDetail(id: id);
      return response.data!;
    } catch (e) {
      rethrow;
    }
  }

  /// 删除反馈
  Future<BaseResponseBoolean> deleteFeedback(int id) async {
    try {
      final response = await _api.deleteFeedback(id: id);
      return response.data!;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取反馈回复列表
  Future<BaseResponseListFeedbackReplyResponse> getFeedbackReplies(int id) async {
    try {
      final response = await _api.getFeedbackReplies(id: id);
      return response.data!;
    } catch (e) {
      rethrow;
    }
  }
}
