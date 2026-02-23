import 'package:built_collection/built_collection.dart';
import 'package:nova_api/nova_api.dart';
import '../../../core/network/api_client.dart';

/// 课程学习进度服务
class CourseProgressService {
  final _api = ApiClient.instance;

  /// 更新学习进度
  Future<void> updateProgress({
    required int courseId,
    required int sectionId,
    required int lastPosition,
    required int watchDuration,
    required int progress,
  }) async {
    try {
      await _api.defaultApi.updateProgress1(
        updateProgressRequest: UpdateProgressRequest((b) => b
          ..courseId = courseId
          ..sectionId = sectionId
          ..lastPosition = lastPosition
          ..watchDuration = watchDuration
          ..progress = progress),
      );
    } catch (e) {
      // 静默处理，不阻塞播放
    }
  }

  /// 完成小节
  Future<void> completeSection({
    required int sectionId,
    required int courseId,
  }) async {
    try {
      final response = await _api.defaultApi.completeSection(
        sectionId: sectionId,
        courseId: courseId,
      );
      if (response.data?.code != 0) {
        throw Exception(response.data?.message ?? '标记完成失败');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// 重置进度
  Future<void> resetProgress(int sectionId) async {
    try {
      final response = await _api.defaultApi.resetProgress(sectionId: sectionId);
      if (response.data?.code != 0) {
        throw Exception(response.data?.message ?? '重置进度失败');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// 获取小节进度
  Future<ProgressResponse?> getSectionProgress(int sectionId) async {
    try {
      final response = await _api.defaultApi.getSectionProgress(sectionId: sectionId);
      if (response.data?.code == 0) {
        return response.data?.data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// 获取课程所有小节进度
  Future<BuiltList<ProgressResponse>> getCourseProgress(int courseId) async {
    try {
      final response = await _api.defaultApi.getCourseProgress(courseId: courseId);
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      return BuiltList<ProgressResponse>();
    } catch (e) {
      return BuiltList<ProgressResponse>();
    }
  }
}
