import 'package:flutter/foundation.dart';
import 'package:nova_api/nova_api.dart';
import '../../../../core/network/api_client.dart';

/// 每日美文服务
class DailyArticleService {
  final _api = ApiClient.instance;

  /// 文章分类列表
  static const List<String> articleCategories = [
    '励志',
    '情感',
    '哲理',
    '生活',
    '自然',
    '文化',
    '历史',
    '科技',
  ];

  /// 推荐数量选项
  static const List<int> sizeOptions = [3, 5, 10, 15, 20];

  /// 获取今日推荐文章
  Future<List<DailyArticleResponse>> getTodayArticles({
    int size = 5,
  }) async {
    try {
      final response = await _api.defaultApi.getTodayArticles(
        size: size,
      );
      if (response.data?.data != null) {
        return response.data!.data!.toList();
      }
      return [];
    } catch (e) {
      debugPrint('获取今日文章失败: $e');
      rethrow;
    }
  }

  /// 获取文章详情
  Future<DailyArticleResponse?> getArticleDetail(int articleId) async {
    try {
      final response = await _api.defaultApi.getDailyArticle(id: articleId);
      return response.data?.data;
    } catch (e) {
      debugPrint('获取文章详情失败: $e');
      rethrow;
    }
  }

  /// 按日期获取文章
  Future<List<DailyArticleResponse>> getArticlesByDate(Date date) async {
    try {
      final response = await _api.defaultApi.getArticlesByDate(date: date);
      if (response.data?.data != null) {
        return response.data!.data!.toList();
      }
      return [];
    } catch (e) {
      debugPrint('按日期获取文章失败: $e');
      rethrow;
    }
  }

  /// 标记文章为已读
  Future<bool> markAsRead(int articleId) async {
    try {
      final response = await _api.defaultApi.markAsRead(
        articleId: articleId,
      );
      return response.data?.code == 0;
    } catch (e) {
      debugPrint('标记已读失败: $e');
      rethrow;
    }
  }

  /// 点赞/取消点赞文章
  Future<bool> toggleLike(int articleId) async {
    try {
      final response = await _api.defaultApi.toggleLike(
        articleId: articleId,
      );
      return response.data?.code == 0;
    } catch (e) {
      debugPrint('点赞操作失败: $e');
      rethrow;
    }
  }

  /// 收藏/取消收藏文章
  Future<bool> toggleCollect(int articleId) async {
    try {
      final response = await _api.defaultApi.toggleCollect1(
        articleId: articleId,
      );
      return response.data?.code == 0;
    } catch (e) {
      debugPrint('收藏操作失败: $e');
      rethrow;
    }
  }

  /// 添加评论
  Future<bool> addComment(int articleId, String content) async {
    try {
      final request = AddCommentRequest((b) => b..content = content);
      final response = await _api.defaultApi.addComment(
        articleId: articleId,
        addCommentRequest: request,
      );
      return response.data?.code == 0;
    } catch (e) {
      debugPrint('添加评论失败: $e');
      rethrow;
    }
  }

  /// 获取已读文章列表
  Future<List<UserDailyArticleResponse>> getReadArticles({
    int page = 1,
    int size = 10,
  }) async {
    try {
      final response = await _api.defaultApi.getReadArticles(
        page: page,
        size: size,
      );
      if (response.data?.data != null) {
        return response.data!.data!.toList();
      }
      return [];
    } catch (e) {
      debugPrint('获取已读文章失败: $e');
      rethrow;
    }
  }

  /// 获取点赞文章列表
  Future<List<UserDailyArticleResponse>> getLikedArticles({
    int page = 1,
    int size = 10,
  }) async {
    try {
      final response = await _api.defaultApi.getLikedArticles(
        page: page,
        size: size,
      );
      if (response.data?.data != null) {
        return response.data!.data!.toList();
      }
      return [];
    } catch (e) {
      debugPrint('获取点赞文章失败: $e');
      rethrow;
    }
  }

  /// 获取收藏文章列表
  Future<List<UserDailyArticleResponse>> getCollectedArticles({
    int page = 1,
    int size = 10,
  }) async {
    try {
      final response = await _api.defaultApi.getCollectedArticles(
        page: page,
        size: size,
      );
      if (response.data?.data != null) {
        return response.data!.data!.toList();
      }
      return [];
    } catch (e) {
      debugPrint('获取收藏文章失败: $e');
      rethrow;
    }
  }

  /// 获取用户文章统计
  Future<ReadingStats?> getUserArticleStats() async {
    try {
      final response = await _api.defaultApi.getStats2();
      return response.data?.data;
    } catch (e) {
      debugPrint('获取用户文章统计失败: $e');
      rethrow;
    }
  }
}
