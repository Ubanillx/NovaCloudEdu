import 'package:built_collection/built_collection.dart';
import 'package:nova_api/nova_api.dart';
import '../../../core/network/api_client.dart';

/// 课程收藏服务
class CourseFavouriteService {
  final _api = ApiClient.instance;

  /// 收藏课程
  Future<void> favourite(int courseId) async {
    try {
      final response = await _api.defaultApi.favouriteCourse(courseId: courseId);
      if (response.data?.code != 0) {
        throw Exception(response.data?.message ?? '收藏失败');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// 取消收藏
  Future<void> unfavourite(int courseId) async {
    try {
      final response = await _api.defaultApi.unfavouriteCourse(courseId: courseId);
      if (response.data?.code != 0) {
        throw Exception(response.data?.message ?? '取消收藏失败');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// 检查是否已收藏
  Future<bool> check(int courseId) async {
    try {
      final response = await _api.defaultApi.checkFavourite(courseId: courseId);
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// 获取课程收藏数
  Future<int> count(int courseId) async {
    try {
      final response = await _api.defaultApi.getFavouriteCount(courseId: courseId);
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  /// 获取我的收藏列表
  Future<BuiltList<CourseResponse>> getMyFavourites({
    int page = 1,
    int size = 20,
  }) async {
    try {
      final response = await _api.defaultApi.getMyFavourites1(
        page: page,
        size: size,
      );
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '获取收藏列表失败');
    } catch (e) {
      rethrow;
    }
  }
}
