import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';

class CheckinService {
  final Dio _dio = ApiClient.instance.dio;
  
  // 缓存用户统计数据
  static UserStats? _cachedUserStats;
  static DateTime? _cacheTime;

  /// 用户打卡
  Future<CheckinResult> checkin() async {
    try {
      final response = await _dio.post('/api/user/checkin');
      return CheckinResult.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  /// 获取用户统计数据（带缓存）
  /// [forceRefresh] 为 true 时强制刷新，否则使用缓存
  Future<UserStats> getUserStats({bool forceRefresh = false}) async {
    // 如果不强制刷新且有缓存，直接返回缓存数据
    if (!forceRefresh && _cachedUserStats != null) {
      return _cachedUserStats!;
    }
    
    try {
      final response = await _dio.get('/api/user/stats');
      final stats = UserStats.fromJson(response.data['data']);
      // 更新缓存
      _cachedUserStats = stats;
      _cacheTime = DateTime.now();
      return stats;
    } catch (e) {
      // 如果请求失败但有缓存，返回缓存数据
      if (_cachedUserStats != null) {
        return _cachedUserStats!;
      }
      rethrow;
    }
  }
  
  /// 清除缓存
  void clearCache() {
    _cachedUserStats = null;
    _cacheTime = null;
  }
  
  /// 更新缓存中的打卡状态（打卡成功后调用）
  void updateCacheAfterCheckin(CheckinResult result) {
    if (_cachedUserStats != null) {
      _cachedUserStats = UserStats(
        registerDays: _cachedUserStats!.registerDays,
        totalCheckinDays: result.totalCheckinDays,
        currentStreak: result.streakDays,
        checkedInToday: true,
        totalLikes: _cachedUserStats!.totalLikes,
      );
    }
  }

  /// 获取打卡排行榜
  Future<List<CheckinRankingItem>> getCheckinRanking({int limit = 10}) async {
    try {
      final response = await _dio.get(
        '/api/user/checkin/ranking',
        queryParameters: {'limit': limit},
      );
      final List<dynamic> data = response.data['data'];
      return data.map((item) => CheckinRankingItem.fromJson(item)).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// 获取打卡状态
  Future<CheckinStatus> getCheckinStatus() async {
    try {
      final response = await _dio.get('/api/user/checkin/status');
      return CheckinStatus.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}

/// 打卡结果
class CheckinResult {
  final bool success;
  final int streakDays;
  final int totalCheckinDays;
  final int maxStreak;

  CheckinResult({
    required this.success,
    required this.streakDays,
    required this.totalCheckinDays,
    required this.maxStreak,
  });

  factory CheckinResult.fromJson(Map<String, dynamic> json) {
    return CheckinResult(
      success: json['success'] ?? false,
      streakDays: json['streakDays'] ?? 0,
      totalCheckinDays: json['totalCheckinDays'] ?? 0,
      maxStreak: json['maxStreak'] ?? 0,
    );
  }
}

/// 用户统计数据
class UserStats {
  final int registerDays;
  final int totalCheckinDays;
  final int currentStreak;
  final bool checkedInToday;
  final int totalLikes;

  UserStats({
    required this.registerDays,
    required this.totalCheckinDays,
    required this.currentStreak,
    required this.checkedInToday,
    required this.totalLikes,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      registerDays: json['registerDays'] ?? 0,
      totalCheckinDays: json['totalCheckinDays'] ?? 0,
      currentStreak: json['currentStreak'] ?? 0,
      checkedInToday: json['checkedInToday'] ?? false,
      totalLikes: json['totalLikes'] ?? 0,
    );
  }
}

/// 打卡排行榜项
class CheckinRankingItem {
  final int userId;
  final String userName;
  final String? userAvatar;
  final int totalCheckinDays;
  final int currentStreak;
  final int rank;

  CheckinRankingItem({
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.totalCheckinDays,
    required this.currentStreak,
    required this.rank,
  });

  factory CheckinRankingItem.fromJson(Map<String, dynamic> json) {
    return CheckinRankingItem(
      userId: json['userId'] ?? 0,
      userName: json['userName'] ?? '',
      userAvatar: json['userAvatar'],
      totalCheckinDays: json['totalCheckinDays'] ?? 0,
      currentStreak: json['currentStreak'] ?? 0,
      rank: json['rank'] ?? 0,
    );
  }
}

/// 打卡状态
class CheckinStatus {
  final bool checkedInToday;
  final int currentStreak;
  final int totalCheckinDays;

  CheckinStatus({
    required this.checkedInToday,
    required this.currentStreak,
    required this.totalCheckinDays,
  });

  factory CheckinStatus.fromJson(Map<String, dynamic> json) {
    return CheckinStatus(
      checkedInToday: json['checkedInToday'] ?? false,
      currentStreak: json['currentStreak'] ?? 0,
      totalCheckinDays: json['totalCheckinDays'] ?? 0,
    );
  }
}
