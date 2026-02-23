import 'package:built_collection/built_collection.dart';
import 'package:nova_api/nova_api.dart';
import '../../../core/network/api_client.dart';

/// 课程评价服务
class CourseReviewService {
  final _api = ApiClient.instance;

  /// 评价课程
  Future<int> review(int courseId, int rating) async {
    try {
      final response = await _api.defaultApi.reviewCourse(
        courseId: courseId,
        reviewCourseRequest: ReviewCourseRequest((b) => b..rating = rating),
      );
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '评价失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 更新评价
  Future<void> updateReview(int reviewId, int rating) async {
    try {
      final response = await _api.defaultApi.updateReview(
        reviewId: reviewId,
        reviewCourseRequest: ReviewCourseRequest((b) => b..rating = rating),
      );
      if (response.data?.code != 0) {
        throw Exception(response.data?.message ?? '更新评价失败');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// 获取课程评价列表
  Future<BuiltList<CourseReviewResponse>> listReviews(
    int courseId, {
    int page = 1,
    int size = 20,
  }) async {
    try {
      final response = await _api.defaultApi.listReviews(
        courseId: courseId,
        page: page,
        size: size,
      );
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '获取评价列表失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 获取我的评价
  Future<CourseReviewResponse?> getMyReview(int courseId) async {
    try {
      final response = await _api.defaultApi.getMyReview(courseId: courseId);
      if (response.data?.code == 0) {
        return response.data?.data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// 获取评价数量
  Future<int> getReviewCount(int courseId) async {
    try {
      final response = await _api.defaultApi.getReviewCount(courseId: courseId);
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }
}
