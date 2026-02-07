import 'package:nova_api/nova_api.dart';
import '../../../core/network/api_client.dart';

/// 消息已读用户信息（本地模型，无需 OpenAPI 生成）
class ReadUserInfo {
  final int? userId;
  final String? userName;
  final String? userAvatar;
  final String? readTime;

  ReadUserInfo({this.userId, this.userName, this.userAvatar, this.readTime});

  factory ReadUserInfo.fromJson(Map<String, dynamic> json) {
    return ReadUserInfo(
      userId: json['userId'] as int?,
      userName: json['userName'] as String?,
      userAvatar: json['userAvatar'] as String?,
      readTime: json['readTime'] as String?,
    );
  }
}

/// 群组服务
class GroupService {
  final _api = ApiClient.instance;

  /// 创建群组
  Future<GroupResponse?> createGroup({
    required String groupName,
    String? avatar,
    String? description,
  }) async {
    try {
      final response = await _api.defaultApi.createGroup(
        createGroupRequest: CreateGroupRequest((b) => b
          ..groupName = groupName
          ..avatar = avatar
          ..description = description),
      );
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取我的群组列表
  Future<List<GroupResponse>> getMyGroups() async {
    try {
      final response = await _api.defaultApi.getMyGroups();
      return response.data?.data?.toList() ?? [];
    } catch (e) {
      rethrow;
    }
  }

  /// 获取群组详情
  Future<GroupResponse?> getGroupInfo(int groupId) async {
    try {
      final response = await _api.defaultApi.getGroupInfo(groupId: groupId);
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取群成员列表
  Future<List<GroupMemberResponse>> getGroupMembers(int groupId) async {
    try {
      final response = await _api.defaultApi.getGroupMembers(groupId: groupId);
      return response.data?.data?.toList() ?? [];
    } catch (e) {
      rethrow;
    }
  }

  /// 申请加入群组
  Future<JoinRequestResponse?> applyToJoin({
    required int groupId,
    String? message,
  }) async {
    try {
      final response = await _api.defaultApi.applyToJoin(
        groupId: groupId,
        joinGroupRequest: JoinGroupRequest((b) => b..message = message),
      );
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 退出群组
  Future<bool> leaveGroup(int groupId) async {
    try {
      await _api.defaultApi.leaveGroup(groupId: groupId);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 移除群成员
  Future<bool> removeMember({
    required int groupId,
    required int targetUserId,
  }) async {
    try {
      await _api.defaultApi.removeMember(
        groupId: groupId,
        targetUserId: targetUserId,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 更新群组信息
  Future<bool> updateGroupInfo({
    required int groupId,
    String? groupName,
    String? avatar,
    String? description,
  }) async {
    try {
      await _api.defaultApi.updateGroupInfo(
        groupId: groupId,
        updateGroupRequest: UpdateGroupRequest((b) => b
          ..groupName = groupName
          ..avatar = avatar
          ..description = description),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 解散群组
  Future<bool> dissolveGroup(int groupId) async {
    try {
      await _api.defaultApi.dissolveGroup(groupId: groupId);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 获取群消息历史
  Future<GroupMessagePageResponse?> getMessages({
    required int groupId,
    int pageNum = 1,
    int pageSize = 50,
  }) async {
    try {
      final response = await _api.defaultApi.getMessages(
        groupId: groupId,
        pageNum: pageNum,
        pageSize: pageSize,
      );
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取最新消息
  Future<List<GroupMessageItem>> getLatestMessages({
    required int groupId,
    int limit = 50,
  }) async {
    try {
      final response = await _api.defaultApi.getLatestMessages(
        groupId: groupId,
        limit: limit,
      );
      return response.data?.data?.toList() ?? [];
    } catch (e) {
      rethrow;
    }
  }

  /// 搜索群组
  Future<GroupPage?> searchGroups({
    required String keyword,
    int pageNum = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _api.defaultApi.searchGroups(
        keyword: keyword,
        pageNum: pageNum,
        pageSize: pageSize,
      );
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 邀请成员加入群组
  Future<bool> inviteMember({
    required int groupId,
    required int inviteeId,
  }) async {
    try {
      await _api.defaultApi.inviteMember(
        groupId: groupId,
        inviteeId: inviteeId,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 获取入群申请列表
  Future<List<JoinRequestResponse>> getPendingRequests(int groupId) async {
    try {
      final response = await _api.defaultApi.getPendingRequests(groupId: groupId);
      return response.data?.data?.toList() ?? [];
    } catch (e) {
      rethrow;
    }
  }

  /// 处理入群申请
  Future<bool> handleJoinRequest({
    required int requestId,
    required bool approve,
  }) async {
    try {
      await _api.defaultApi.handleJoinRequest(
        requestId: requestId,
        handleJoinRequestDTO: HandleJoinRequestDTO((b) => b..approve = approve),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 获取消息已读用户列表（含昵称头像）
  Future<List<ReadUserInfo>> getReadUsers(int messageId) async {
    try {
      final response = await _api.dio.get('/api/group-chat/messages/$messageId/read-users');
      final data = response.data;
      if (data != null && data['code'] == 0 && data['data'] is List) {
        return (data['data'] as List)
            .map((e) => ReadUserInfo.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  /// 转让群主
  Future<bool> transferOwnership({
    required int groupId,
    required int newOwnerId,
  }) async {
    try {
      await _api.defaultApi.transferOwnership(
        groupId: groupId,
        newOwnerId: newOwnerId,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

}
