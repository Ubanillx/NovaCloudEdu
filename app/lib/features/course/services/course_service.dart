import 'package:built_collection/built_collection.dart';
import 'package:nova_api/nova_api.dart';
import '../../../core/network/api_client.dart';

/// 课程服务
class CourseService {
  final _api = ApiClient.instance;

  /// 获取课程列表
  Future<BuiltList<CourseResponse>> getCourses({
    int? status = 1, // 默认获取已发布课程
    int page = 1,
    int size = 20,
  }) async {
    try {
      final response = await _api.defaultApi.listCourses(
        status: status,
        page: page,
        size: size,
      );
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '获取课程列表失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 获取课程详情
  Future<CourseResponse> getCourseDetail(int courseId) async {
    try {
      final response = await _api.defaultApi.getCourse(id: courseId);
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '获取课程详情失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 获取推荐课程
  Future<BuiltList<CourseResponse>> getRecommendedCourses({
    int size = 10,
  }) async {
    try {
      final response = await _api.defaultApi.listCourses(
        status: 1,
        page: 1,
        size: size,
      );
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '获取推荐课程失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 搜索课程
  Future<BuiltList<CourseResponse>> searchCourses({
    required String keyword,
    int page = 1,
    int size = 20,
  }) async {
    try {
      final response = await _api.defaultApi.searchCourses(
        keyword: keyword,
        page: page,
        size: size,
      );
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '搜索课程失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 获取讲师的课程列表
  Future<BuiltList<CourseResponse>> getCoursesByTeacher({
    required int teacherId,
    int page = 1,
    int size = 20,
  }) async {
    try {
      final response = await _api.defaultApi.listCoursesByTeacher(
        teacherId: teacherId,
        page: page,
        size: size,
      );
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '获取讲师课程失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 获取课程完整结构（课程+章节+小节+权限）
  Future<CourseStructureResponse> getCourseStructure(int courseId) async {
    try {
      final response = await _api.defaultApi.getCourseStructure(
        courseId: courseId,
      );
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '获取课程结构失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 获取课程进度汇总
  Future<CourseProgressSummaryResponse> getCourseProgressSummary(int courseId) async {
    try {
      final response = await _api.defaultApi.getCourseProgressSummary(
        courseId: courseId,
      );
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '获取课程进度失败');
    } catch (e) {
      rethrow;
    }
  }
}
