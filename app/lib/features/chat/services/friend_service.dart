import 'package:nova_api/nova_api.dart';
import '../../../core/network/api_client.dart';

/// 好友服务
class FriendService {
  final _api = ApiClient.instance;

  /// 搜索用户
  Future<List<SearchUserResponse>> searchUsers({
    required String keyword,
    int pageNum = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _api.defaultApi.searchUsers(
        searchUserRequestDTO: SearchUserRequestDTO((b) => b
          ..keyword = keyword
          ..pageNum = pageNum
          ..pageSize = pageSize),
      );
      return response.data?.data?.records?.toList() ?? [];
    } catch (e) {
      rethrow;
    }
  }

  /// 发送好友申请
  Future<bool> sendFriendRequest({
    required int receiverId,
    String? message,
  }) async {
    try {
      final response = await _api.defaultApi.sendFriendRequest(
        sendFriendRequestDTO: SendFriendRequestDTO((b) => b
          ..receiverId = receiverId
          ..message = message),
      );
      return response.data?.data != null;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取收到的好友申请
  Future<List<FriendRequestResponse>> getReceivedRequests({
    String? status,
    int pageNum = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _api.defaultApi.getReceivedRequests(
        friendRequestListDTO: FriendRequestListDTO((b) => b
          ..status = status
          ..pageNum = pageNum
          ..pageSize = pageSize),
      );
      return response.data?.data?.records?.toList() ?? [];
    } catch (e) {
      rethrow;
    }
  }

  /// 获取发送的好友申请
  Future<List<FriendRequestResponse>> getSentRequests({
    String? status,
    int pageNum = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _api.defaultApi.getSentRequests(
        friendRequestListDTO: FriendRequestListDTO((b) => b
          ..status = status
          ..pageNum = pageNum
          ..pageSize = pageSize),
      );
      return response.data?.data?.records?.toList() ?? [];
    } catch (e) {
      rethrow;
    }
  }

  /// 处理好友申请（接受/拒绝）
  Future<bool> handleFriendRequest({
    required int requestId,
    required bool accept,
  }) async {
    try {
      final response = await _api.defaultApi.handleFriendRequest(
        handleFriendRequestDTO: HandleFriendRequestDTO((b) => b
          ..requestId = requestId
          ..accept = accept),
      );
      return response.data?.data == true;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取好友列表（分页）
  Future<List<FriendResponse>> getFriendList({
    int pageNum = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _api.defaultApi.getFriendList(
        friendListRequestDTO: FriendListRequestDTO((b) => b
          ..pageNum = pageNum
          ..pageSize = pageSize),
      );
      return response.data?.data?.records?.toList() ?? [];
    } catch (e) {
      rethrow;
    }
  }

  /// 获取全部好友
  Future<List<FriendResponse>> getAllFriends() async {
    try {
      final response = await _api.defaultApi.getAllFriends();
      return response.data?.data?.toList() ?? [];
    } catch (e) {
      rethrow;
    }
  }

  /// 删除好友
  Future<bool> deleteFriend(int friendId) async {
    try {
      final response = await _api.defaultApi.deleteFriend(friendId: friendId);
      return response.data?.data == true;
    } catch (e) {
      rethrow;
    }
  }

  /// 检查好友关系
  Future<bool> checkFriendship(int userId) async {
    try {
      final response = await _api.defaultApi.checkFriendship(userId: userId);
      return response.data?.data == true;
    } catch (e) {
      rethrow;
    }
  }
}
