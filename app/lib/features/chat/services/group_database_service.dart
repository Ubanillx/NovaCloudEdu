import 'package:sqflite/sqflite.dart';
import '../../../core/database/database_service.dart';

/// 本地群组模型
class LocalGroup {
  final int? id;
  final int? groupId;
  final String groupName;
  final String? avatar;
  final String? description;
  final int? ownerId;
  final int? memberCount;
  final String? announcement;
  final DateTime? announcementTime;
  final bool mute;
  final DateTime? createTime;
  final DateTime updatedAt;

  LocalGroup({
    this.id,
    this.groupId,
    required this.groupName,
    this.avatar,
    this.description,
    this.ownerId,
    this.memberCount,
    this.announcement,
    this.announcementTime,
    this.mute = false,
    this.createTime,
    required this.updatedAt,
  });

  factory LocalGroup.fromMap(Map<String, dynamic> map) {
    return LocalGroup(
      id: map['id'] as int?,
      groupId: map['group_id'] as int?,
      groupName: map['group_name'] as String? ?? '',
      avatar: map['avatar'] as String?,
      description: map['description'] as String?,
      ownerId: map['owner_id'] as int?,
      memberCount: map['member_count'] as int?,
      announcement: map['announcement'] as String?,
      announcementTime: map['announcement_time'] != null
          ? DateTime.tryParse(map['announcement_time'] as String)
          : null,
      mute: (map['mute'] as int?) == 1,
      createTime: map['create_time'] != null
          ? DateTime.tryParse(map['create_time'] as String)
          : null,
      updatedAt: DateTime.tryParse(map['updated_at'] as String) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'group_id': groupId,
      'group_name': groupName,
      'avatar': avatar,
      'description': description,
      'owner_id': ownerId,
      'member_count': memberCount,
      'announcement': announcement,
      'announcement_time': announcementTime?.toIso8601String(),
      'mute': mute ? 1 : 0,
      'create_time': createTime?.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

/// 本地群成员模型
class LocalGroupMember {
  final int? id;
  final int groupId;
  final int userId;
  final String? userName;
  final String? userAvatar;
  final int role; // 0: 普通成员, 1: 管理员, 2: 群主
  final DateTime? joinTime;

  LocalGroupMember({
    this.id,
    required this.groupId,
    required this.userId,
    this.userName,
    this.userAvatar,
    this.role = 0,
    this.joinTime,
  });

  factory LocalGroupMember.fromMap(Map<String, dynamic> map) {
    return LocalGroupMember(
      id: map['id'] as int?,
      groupId: map['group_id'] as int,
      userId: map['user_id'] as int,
      userName: map['user_name'] as String?,
      userAvatar: map['user_avatar'] as String?,
      role: map['role'] as int? ?? 0,
      joinTime: map['join_time'] != null
          ? DateTime.tryParse(map['join_time'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'group_id': groupId,
      'user_id': userId,
      'user_name': userName,
      'user_avatar': userAvatar,
      'role': role,
      'join_time': joinTime?.toIso8601String(),
    };
  }
}

/// 本地群消息模型
class LocalGroupMessage {
  final int? id;
  final int? messageId;
  final int groupId;
  final int senderId;
  final String? senderName;
  final String? senderAvatar;
  final String? content;
  final String type;
  final int? replyTo;
  final DateTime createTime;
  final int syncStatus; // 0: 已同步, 1: 待同步, 2: 同步失败

  LocalGroupMessage({
    this.id,
    this.messageId,
    required this.groupId,
    required this.senderId,
    this.senderName,
    this.senderAvatar,
    this.content,
    this.type = 'TEXT',
    this.replyTo,
    required this.createTime,
    this.syncStatus = 0,
  });

  factory LocalGroupMessage.fromMap(Map<String, dynamic> map) {
    return LocalGroupMessage(
      id: map['id'] as int?,
      messageId: map['message_id'] as int?,
      groupId: map['group_id'] as int,
      senderId: map['sender_id'] as int,
      senderName: map['sender_name'] as String?,
      senderAvatar: map['sender_avatar'] as String?,
      content: map['content'] as String?,
      type: map['type'] as String? ?? 'TEXT',
      replyTo: map['reply_to'] as int?,
      createTime: DateTime.tryParse(map['create_time'] as String) ?? DateTime.now(),
      syncStatus: map['sync_status'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'message_id': messageId,
      'group_id': groupId,
      'sender_id': senderId,
      'sender_name': senderName,
      'sender_avatar': senderAvatar,
      'content': content,
      'type': type,
      'reply_to': replyTo,
      'create_time': createTime.toIso8601String(),
      'sync_status': syncStatus,
    };
  }

  LocalGroupMessage copyWith({
    int? id,
    int? messageId,
    int? groupId,
    int? senderId,
    String? senderName,
    String? senderAvatar,
    String? content,
    String? type,
    int? replyTo,
    DateTime? createTime,
    int? syncStatus,
  }) {
    return LocalGroupMessage(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      groupId: groupId ?? this.groupId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderAvatar: senderAvatar ?? this.senderAvatar,
      content: content ?? this.content,
      type: type ?? this.type,
      replyTo: replyTo ?? this.replyTo,
      createTime: createTime ?? this.createTime,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}

/// 群聊数据库服务
class GroupDatabaseService {
  final DatabaseService _dbService = DatabaseService();

  Future<Database> get _db async => await _dbService.database;

  // ==================== 群组操作 ====================

  /// 插入或更新群组
  Future<void> upsertGroup(LocalGroup group) async {
    final db = await _db;
    await db.insert(
      'chat_groups',
      group.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// 批量插入或更新群组
  Future<void> upsertGroups(List<LocalGroup> groups) async {
    final db = await _db;
    final batch = db.batch();
    for (final group in groups) {
      batch.insert(
        'chat_groups',
        group.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  /// 获取所有群组
  Future<List<LocalGroup>> getAllGroups() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(
      'chat_groups',
      orderBy: 'updated_at DESC',
    );
    return maps.map((map) => LocalGroup.fromMap(map)).toList();
  }

  /// 获取群组详情
  Future<LocalGroup?> getGroup(int groupId) async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(
      'chat_groups',
      where: 'group_id = ?',
      whereArgs: [groupId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return LocalGroup.fromMap(maps.first);
  }

  /// 删除群组
  Future<void> deleteGroup(int groupId) async {
    final db = await _db;
    await db.delete(
      'chat_groups',
      where: 'group_id = ?',
      whereArgs: [groupId],
    );
    // 同时删除群成员和消息
    await db.delete('group_members', where: 'group_id = ?', whereArgs: [groupId]);
    await db.delete('group_messages', where: 'group_id = ?', whereArgs: [groupId]);
  }

  // ==================== 群成员操作 ====================

  /// 插入或更新群成员
  Future<void> upsertMember(LocalGroupMember member) async {
    final db = await _db;
    await db.insert(
      'group_members',
      member.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// 批量插入或更新群成员
  Future<void> upsertMembers(List<LocalGroupMember> members) async {
    final db = await _db;
    final batch = db.batch();
    for (final member in members) {
      batch.insert(
        'group_members',
        member.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  /// 获取群成员列表
  Future<List<LocalGroupMember>> getGroupMembers(int groupId) async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(
      'group_members',
      where: 'group_id = ?',
      whereArgs: [groupId],
      orderBy: 'role DESC, join_time ASC',
    );
    return maps.map((map) => LocalGroupMember.fromMap(map)).toList();
  }

  /// 删除群成员
  Future<void> deleteMember(int groupId, int userId) async {
    final db = await _db;
    await db.delete(
      'group_members',
      where: 'group_id = ? AND user_id = ?',
      whereArgs: [groupId, userId],
    );
  }

  /// 清空群成员
  Future<void> clearMembers(int groupId) async {
    final db = await _db;
    await db.delete(
      'group_members',
      where: 'group_id = ?',
      whereArgs: [groupId],
    );
  }

  // ==================== 群消息操作 ====================

  /// 插入消息
  Future<int> insertMessage(LocalGroupMessage message) async {
    final db = await _db;
    return await db.insert(
      'group_messages',
      message.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// 批量插入消息
  Future<void> insertMessages(List<LocalGroupMessage> messages) async {
    final db = await _db;
    final batch = db.batch();
    for (final message in messages) {
      batch.insert(
        'group_messages',
        message.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  /// 获取群消息列表
  Future<List<LocalGroupMessage>> getMessages(
    int groupId, {
    int? beforeMessageId,
    int limit = 50,
  }) async {
    final db = await _db;
    
    String whereClause = 'group_id = ?';
    List<dynamic> whereArgs = [groupId];
    
    if (beforeMessageId != null) {
      whereClause += ' AND message_id < ?';
      whereArgs.add(beforeMessageId);
    }
    
    final List<Map<String, dynamic>> maps = await db.query(
      'group_messages',
      where: whereClause,
      whereArgs: whereArgs,
      orderBy: 'create_time DESC',
      limit: limit,
    );
    
    return maps.map((map) => LocalGroupMessage.fromMap(map)).toList();
  }

  /// 获取待同步的消息
  Future<List<LocalGroupMessage>> getPendingSyncMessages(int groupId) async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(
      'group_messages',
      where: 'group_id = ? AND sync_status = ?',
      whereArgs: [groupId, 1],
      orderBy: 'create_time ASC',
    );
    return maps.map((map) => LocalGroupMessage.fromMap(map)).toList();
  }

  /// 更新消息同步状态
  Future<void> updateMessageSyncStatus(int messageId, int syncStatus) async {
    final db = await _db;
    await db.update(
      'group_messages',
      {'sync_status': syncStatus},
      where: 'message_id = ?',
      whereArgs: [messageId],
    );
  }

  /// 更新消息ID（本地消息同步后更新）
  Future<void> updateMessageId(int localId, int serverMessageId) async {
    final db = await _db;
    await db.update(
      'group_messages',
      {'message_id': serverMessageId, 'sync_status': 0},
      where: 'id = ?',
      whereArgs: [localId],
    );
  }

  /// 删除群消息
  Future<void> deleteMessages(int groupId) async {
    final db = await _db;
    await db.delete(
      'group_messages',
      where: 'group_id = ?',
      whereArgs: [groupId],
    );
  }

  /// 获取最新消息ID
  Future<int?> getLatestMessageId(int groupId) async {
    final db = await _db;
    final result = await db.rawQuery('''
      SELECT MAX(message_id) as max_id FROM group_messages
      WHERE group_id = ?
    ''', [groupId]);
    
    if (result.isNotEmpty && result.first['max_id'] != null) {
      return result.first['max_id'] as int;
    }
    return null;
  }

  /// 搜索群消息
  Future<List<LocalGroupMessage>> searchMessages(
    int groupId,
    String keyword,
  ) async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(
      'group_messages',
      where: "group_id = ? AND content LIKE ? AND type = 'TEXT'",
      whereArgs: [groupId, '%$keyword%'],
      orderBy: 'create_time DESC',
      limit: 50,
    );
    return maps.map((map) => LocalGroupMessage.fromMap(map)).toList();
  }

  /// 获取群最后一条消息
  Future<LocalGroupMessage?> getLastMessage(int groupId) async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(
      'group_messages',
      where: 'group_id = ?',
      whereArgs: [groupId],
      orderBy: 'create_time DESC',
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return LocalGroupMessage.fromMap(maps.first);
  }
}
