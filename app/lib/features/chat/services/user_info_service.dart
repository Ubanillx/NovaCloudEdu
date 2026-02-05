import 'package:nova_api/nova_api.dart';
import '../../../core/network/api_client.dart';

/// 用户信息服务（带缓存）
class UserInfoService {
  static final UserInfoService _instance = UserInfoService._internal();
  factory UserInfoService() => _instance;
  UserInfoService._internal();

  final DefaultApi _api = ApiClient.instance.defaultApi;
  
  // 用户信息缓存
  final Map<int, UserPublicResponse> _userInfoCache = {};

  /// 获取用户公开信息
  Future<UserPublicResponse?> getUserInfo(int userId) async {
    // 先检查缓存
    if (_userInfoCache.containsKey(userId)) {
      return _userInfoCache[userId];
    }
    
    try {
      final response = await _api.getUserPublicInfo(id: userId);
      final userInfo = response.data?.data;
      if (userInfo != null) {
        _userInfoCache[userId] = userInfo;
      }
      return userInfo;
    } catch (e) {
      return null;
    }
  }

  /// 批量获取用户信息
  Future<Map<int, UserPublicResponse>> getUserInfoBatch(List<int> userIds) async {
    final result = <int, UserPublicResponse>{};
    final uncachedIds = <int>[];
    
    // 先从缓存获取
    for (final userId in userIds) {
      if (_userInfoCache.containsKey(userId)) {
        result[userId] = _userInfoCache[userId]!;
      } else {
        uncachedIds.add(userId);
      }
    }
    
    // 获取未缓存的用户信息
    for (final userId in uncachedIds) {
      final userInfo = await getUserInfo(userId);
      if (userInfo != null) {
        result[userId] = userInfo;
      }
    }
    
    return result;
  }

  /// 获取用户头像
  Future<String?> getUserAvatar(int userId) async {
    final userInfo = await getUserInfo(userId);
    return userInfo?.userAvatar;
  }

  /// 获取用户昵称
  Future<String?> getUserName(int userId) async {
    final userInfo = await getUserInfo(userId);
    return userInfo?.userName;
  }

  /// 清除缓存
  void clearCache() {
    _userInfoCache.clear();
  }

  /// 从缓存获取（不发起请求）
  UserPublicResponse? getCachedUserInfo(int userId) {
    return _userInfoCache[userId];
  }
}
