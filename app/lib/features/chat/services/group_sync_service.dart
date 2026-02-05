import 'package:flutter/foundation.dart';
import 'group_service.dart';
import 'group_database_service.dart';
import 'user_info_service.dart';

/// 群聊同步服务
class GroupSyncService {
  final GroupService _groupService = GroupService();
  final GroupDatabaseService _dbService = GroupDatabaseService();
  final UserInfoService _userInfoService = UserInfoService();

  /// 同步群组列表
  Future<List<LocalGroup>> syncGroups() async {
    try {
      // 从服务器获取群组列表
      final serverGroups = await _groupService.getMyGroups();
      
      // 转换并保存到本地
      final localGroups = serverGroups.map((g) => LocalGroup(
        groupId: g.id,
        groupName: g.groupName ?? '',
        avatar: g.avatar,
        description: g.description,
        ownerId: g.ownerId,
        memberCount: g.memberCount,
        announcement: g.announcement,
        announcementTime: g.announcementTime,
        mute: g.mute ?? false,
        createTime: g.createTime,
        updatedAt: DateTime.now(),
      )).toList();
      
      await _dbService.upsertGroups(localGroups);
      
      return localGroups;
    } catch (e) {
      debugPrint('同步群组列表失败: $e');
      // 返回本地数据
      return await _dbService.getAllGroups();
    }
  }

  /// 同步群组详情
  Future<LocalGroup?> syncGroupInfo(int groupId) async {
    try {
      final serverGroup = await _groupService.getGroupInfo(groupId);
      if (serverGroup == null) return null;
      
      final localGroup = LocalGroup(
        groupId: serverGroup.id,
        groupName: serverGroup.groupName ?? '',
        avatar: serverGroup.avatar,
        description: serverGroup.description,
        ownerId: serverGroup.ownerId,
        memberCount: serverGroup.memberCount,
        announcement: serverGroup.announcement,
        announcementTime: serverGroup.announcementTime,
        mute: serverGroup.mute ?? false,
        createTime: serverGroup.createTime,
        updatedAt: DateTime.now(),
      );
      
      await _dbService.upsertGroup(localGroup);
      return localGroup;
    } catch (e) {
      debugPrint('同步群组详情失败: $e');
      return await _dbService.getGroup(groupId);
    }
  }

  /// 同步群成员
  Future<List<LocalGroupMember>> syncGroupMembers(int groupId) async {
    try {
      final serverMembers = await _groupService.getGroupMembers(groupId);
      
      // 收集所有需要获取用户信息的userId
      final userIds = serverMembers
          .where((m) => m.userId != null && (m.userName == null || m.userAvatar == null))
          .map((m) => m.userId!)
          .toSet()
          .toList();
      
      // 批量获取用户信息
      final userInfoMap = await _userInfoService.getUserInfoBatch(userIds);
      
      final localMembers = serverMembers.map((m) {
        final userId = m.userId ?? 0;
        final userInfo = userInfoMap[userId];
        return LocalGroupMember(
          groupId: groupId,
          userId: userId,
          userName: m.userName ?? userInfo?.userName,
          userAvatar: m.userAvatar ?? userInfo?.userAvatar,
          role: m.role ?? 0,
          joinTime: m.joinTime,
        );
      }).toList();
      
      // 清空旧成员，插入新成员
      await _dbService.clearMembers(groupId);
      await _dbService.upsertMembers(localMembers);
      
      return localMembers;
    } catch (e) {
      debugPrint('同步群成员失败: $e');
      return await _dbService.getGroupMembers(groupId);
    }
  }

  /// 同步群消息
  Future<List<LocalGroupMessage>> syncMessages(int groupId, {int limit = 50}) async {
    try {
      final serverMessages = await _groupService.getLatestMessages(
        groupId: groupId,
        limit: limit,
      );
      
      // 收集所有需要获取用户信息的senderId
      final senderIds = serverMessages
          .where((m) => m.senderId != null && (m.senderName == null || m.senderAvatar == null))
          .map((m) => m.senderId!)
          .toSet()
          .toList();
      
      // 批量获取用户信息
      final userInfoMap = await _userInfoService.getUserInfoBatch(senderIds);
      
      final localMessages = serverMessages.map((m) {
        final senderId = m.senderId ?? 0;
        final userInfo = userInfoMap[senderId];
        return LocalGroupMessage(
          messageId: m.messageId,
          groupId: groupId,
          senderId: senderId,
          senderName: m.senderName ?? userInfo?.userName,
          senderAvatar: m.senderAvatar ?? userInfo?.userAvatar,
          content: m.content,
          type: m.type ?? 'TEXT',
          replyTo: m.replyTo,
          createTime: m.createTime ?? DateTime.now(),
          syncStatus: 0,
        );
      }).toList();
      
      await _dbService.insertMessages(localMessages);
      
      return localMessages;
    } catch (e) {
      debugPrint('同步群消息失败: $e');
      return await _dbService.getMessages(groupId, limit: limit);
    }
  }

  /// 获取本地群组列表
  Future<List<LocalGroup>> getLocalGroups() async {
    return await _dbService.getAllGroups();
  }

  /// 获取本地群消息
  Future<List<LocalGroupMessage>> getLocalMessages(
    int groupId, {
    int? beforeMessageId,
    int limit = 50,
  }) async {
    return await _dbService.getMessages(
      groupId,
      beforeMessageId: beforeMessageId,
      limit: limit,
    );
  }

  /// 保存本地消息（发送前）
  Future<int> saveLocalMessage(LocalGroupMessage message) async {
    return await _dbService.insertMessage(message);
  }

  /// 更新消息同步状态
  Future<void> updateMessageSyncStatus(int messageId, int status) async {
    await _dbService.updateMessageSyncStatus(messageId, status);
  }

  /// 保存WebSocket收到的消息
  Future<LocalGroupMessage> saveReceivedMessage({
    required int messageId,
    required int groupId,
    required int senderId,
    String? senderName,
    String? senderAvatar,
    String? content,
    String? type,
    int? replyTo,
    DateTime? createTime,
  }) async {
    // 如果缺少发送者信息，尝试获取
    String? finalSenderName = senderName;
    String? finalSenderAvatar = senderAvatar;
    
    if (finalSenderName == null || finalSenderAvatar == null) {
      final userInfo = await _userInfoService.getUserInfo(senderId);
      finalSenderName ??= userInfo?.userName;
      finalSenderAvatar ??= userInfo?.userAvatar;
    }
    
    final message = LocalGroupMessage(
      messageId: messageId,
      groupId: groupId,
      senderId: senderId,
      senderName: finalSenderName,
      senderAvatar: finalSenderAvatar,
      content: content,
      type: type ?? 'TEXT',
      replyTo: replyTo,
      createTime: createTime ?? DateTime.now(),
      syncStatus: 0,
    );
    await _dbService.insertMessage(message);
    return message;
  }

  /// 搜索群消息
  Future<List<LocalGroupMessage>> searchMessages(int groupId, String keyword) async {
    return await _dbService.searchMessages(groupId, keyword);
  }

  /// 获取群最后一条消息
  Future<LocalGroupMessage?> getLastMessage(int groupId) async {
    return await _dbService.getLastMessage(groupId);
  }

  /// 删除群组（退出或解散时）
  Future<void> deleteGroup(int groupId) async {
    await _dbService.deleteGroup(groupId);
  }
}
