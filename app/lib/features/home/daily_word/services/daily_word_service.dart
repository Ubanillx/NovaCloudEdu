import 'package:flutter/foundation.dart';
import 'package:nova_api/nova_api.dart';
import '../../../../core/network/api_client.dart';

/// 每日单词服务
class DailyWordService {
  final _api = ApiClient.instance;

  /// 单词分类列表
  static const List<String> wordCategories = [
    '小学三年级',
    '小学四年级',
    '小学五年级',
    '小学六年级',
    '初中七年级',
    '初中八年级',
    '初中九年级',
    '初中',
    '初中(乱序)',
    '外研社初中',
    '高中',
    '高中(乱序)',
    '北师高中',
    '四级',
    '四级(乱序)',
    '专四',
    '专四(乱序)',
    '六级',
    '六级(乱序)',
    '考研',
    '考研(乱序)',
    '专八',
    '专八(乱序)',
    '托福',
    '雅思',
    '雅思(乱序)',
    'GRE',
    'GMAT',
    'GMAT(乱序)',
    'SAT',
    'BEC商务英语',
  ];

  /// 推荐数量选项
  static const List<int> sizeOptions = [5, 10, 15, 20, 30, 50];

  /// 获取今日推荐单词
  Future<List<DailyWordResponse>> getTodayWords({
    int size = 10,
    String? type,
  }) async {
    try {
      final response = await _api.defaultApi.getTodayWords(
        size: size,
        type: type,
      );
      if (response.data?.data != null) {
        return response.data!.data!.toList();
      }
      return [];
    } catch (e) {
      debugPrint('获取今日单词失败: $e');
      rethrow;
    }
  }

  /// 获取单词详情
  Future<DailyWordResponse?> getWordDetail(int wordId) async {
    try {
      final response = await _api.defaultApi.getDailyWord(id: wordId);
      return response.data?.data;
    } catch (e) {
      debugPrint('获取单词详情失败: $e');
      rethrow;
    }
  }

  /// 搜索单词
  Future<List<DailyWordResponse>> searchWords({
    required String keyword,
    int page = 1,
    int size = 10,
  }) async {
    try {
      final response = await _api.defaultApi.searchWords(
        keyword: keyword,
        page: page,
        size: size,
      );
      if (response.data?.data?.records != null) {
        return response.data!.data!.records!.toList();
      }
      return [];
    } catch (e) {
      debugPrint('搜索单词失败: $e');
      rethrow;
    }
  }

  /// 添加单词到生词本
  Future<bool> addToWordBook(int wordId) async {
    try {
      final response = await _api.defaultApi.addToWordBook(wordId: wordId);
      return response.data?.code == 0;
    } catch (e) {
      debugPrint('添加到生词本失败: $e');
      rethrow;
    }
  }

  /// 从生词本移除单词
  Future<bool> removeFromWordBook(int wordBookId) async {
    try {
      final response = await _api.defaultApi.removeFromWordBook(wordBookId: wordBookId);
      return response.data?.code == 0;
    } catch (e) {
      debugPrint('从生词本移除失败: $e');
      rethrow;
    }
  }

  /// 获取生词本列表
  Future<List<UserWordBookResponse>> getWordBookList({
    int? status,
    int page = 1,
    int size = 20,
  }) async {
    try {
      final response = await _api.defaultApi.getWordBookList(
        status: status,
        page: page,
        size: size,
      );
      if (response.data?.data != null) {
        return response.data!.data!.toList();
      }
      return [];
    } catch (e) {
      debugPrint('获取生词本列表失败: $e');
      rethrow;
    }
  }

  /// 获取生词本统计
  Future<WordBookStats?> getWordBookStats() async {
    try {
      final response = await _api.defaultApi.getStats();
      return response.data?.data;
    } catch (e) {
      debugPrint('获取生词本统计失败: $e');
      rethrow;
    }
  }

  /// 标记单词为已学习
  Future<bool> studyWord(int wordId) async {
    try {
      final response = await _api.defaultApi.studyWord(wordId: wordId);
      return response.data?.code == 0;
    } catch (e) {
      debugPrint('标记已学习失败: $e');
      rethrow;
    }
  }

  /// 更新单词掌握程度
  /// level: 掌握程度等级
  Future<bool> updateMastery(int wordId, int level) async {
    try {
      final response = await _api.defaultApi.updateMastery(
        wordId: wordId,
        level: level,
      );
      return response.data?.code == 0;
    } catch (e) {
      debugPrint('更新掌握程度失败: $e');
      rethrow;
    }
  }

  /// 更新学习状态
  Future<bool> updateLearningStatus(int wordBookId, int status) async {
    try {
      final response = await _api.defaultApi.updateLearningStatus(
        wordBookId: wordBookId,
        status: status,
      );
      return response.data?.code == 0;
    } catch (e) {
      debugPrint('更新学习状态失败: $e');
      rethrow;
    }
  }

  /// 获取已学习单词列表
  Future<List<UserDailyWordResponse>> getStudiedWords({
    int page = 1,
    int size = 20,
  }) async {
    try {
      final response = await _api.defaultApi.getStudiedWords(
        page: page,
        size: size,
      );
      if (response.data?.data != null) {
        return response.data!.data!.toList();
      }
      return [];
    } catch (e) {
      debugPrint('获取已学习单词失败: $e');
      rethrow;
    }
  }

  /// 获取收藏单词列表
  Future<List<UserDailyWordResponse>> getCollectedWords({
    int page = 1,
    int size = 20,
  }) async {
    try {
      final response = await _api.defaultApi.getCollectedWords(
        page: page,
        size: size,
      );
      if (response.data?.data != null) {
        return response.data!.data!.toList();
      }
      return [];
    } catch (e) {
      debugPrint('获取收藏单词失败: $e');
      rethrow;
    }
  }
}
