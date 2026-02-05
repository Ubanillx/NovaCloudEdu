import 'package:sqflite/sqflite.dart';
import '../../../core/database/database_service.dart';

/// 聊天消息本地模型
class LocalChatMessage {
  final int? id;
  final int? messageId;
  final int senderId;
  final String? senderName;
  final String? senderAvatar;
  final int receiverId;
  final String? content;
  final String type;
  final bool isRead;
  final bool isSent;
  final DateTime createTime;
  final int syncStatus; // 0: 已同步, 1: 待同步, 2: 同步失败

  LocalChatMessage({
    this.id,
    this.messageId,
    required this.senderId,
    this.senderName,
    this.senderAvatar,
    required this.receiverId,
    this.content,
    this.type = 'TEXT',
    this.isRead = false,
    this.isSent = true,
    required this.createTime,
    this.syncStatus = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'message_id': messageId,
      'sender_id': senderId,
      'sender_name': senderName,
      'sender_avatar': senderAvatar,
      'receiver_id': receiverId,
      'content': content,
      'type': type,
      'is_read': isRead ? 1 : 0,
      'is_sent': isSent ? 1 : 0,
      'create_time': createTime.toIso8601String(),
      'sync_status': syncStatus,
    };
  }

  factory LocalChatMessage.fromMap(Map<String, dynamic> map) {
    return LocalChatMessage(
      id: map['id'] as int?,
      messageId: map['message_id'] as int?,
      senderId: map['sender_id'] as int,
      senderName: map['sender_name'] as String?,
      senderAvatar: map['sender_avatar'] as String?,
      receiverId: map['receiver_id'] as int,
      content: map['content'] as String?,
      type: map['type'] as String? ?? 'TEXT',
      isRead: (map['is_read'] as int?) == 1,
      isSent: (map['is_sent'] as int?) == 1,
      createTime: DateTime.parse(map['create_time'] as String),
      syncStatus: map['sync_status'] as int? ?? 0,
    );
  }

  LocalChatMessage copyWith({
    int? id,
    int? messageId,
    int? senderId,
    String? senderName,
    String? senderAvatar,
    int? receiverId,
    String? content,
    String? type,
    bool? isRead,
    bool? isSent,
    DateTime? createTime,
    int? syncStatus,
  }) {
    return LocalChatMessage(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderAvatar: senderAvatar ?? this.senderAvatar,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      isSent: isSent ?? this.isSent,
      createTime: createTime ?? this.createTime,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}

/// 聊天会话本地模型
class LocalChatSession {
  final int? id;
  final int? sessionId;
  final int partnerId;
  final String? partnerName;
  final String? partnerAvatar;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final int unreadCount;
  final DateTime updatedAt;

  LocalChatSession({
    this.id,
    this.sessionId,
    required this.partnerId,
    this.partnerName,
    this.partnerAvatar,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadCount = 0,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'session_id': sessionId,
      'partner_id': partnerId,
      'partner_name': partnerName,
      'partner_avatar': partnerAvatar,
      'last_message': lastMessage,
      'last_message_time': lastMessageTime?.toIso8601String(),
      'unread_count': unreadCount,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory LocalChatSession.fromMap(Map<String, dynamic> map) {
    return LocalChatSession(
      id: map['id'] as int?,
      sessionId: map['session_id'] as int?,
      partnerId: map['partner_id'] as int,
      partnerName: map['partner_name'] as String?,
      partnerAvatar: map['partner_avatar'] as String?,
      lastMessage: map['last_message'] as String?,
      lastMessageTime: map['last_message_time'] != null
          ? DateTime.parse(map['last_message_time'] as String)
          : null,
      unreadCount: map['unread_count'] as int? ?? 0,
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }
}

/// 聊天数据库服务
class ChatDatabaseService {
  static final ChatDatabaseService _instance = ChatDatabaseService._internal();
  factory ChatDatabaseService() => _instance;
  ChatDatabaseService._internal();

  final _dbService = DatabaseService();

  Future<Database> get _db => _dbService.database;

  // ==================== 消息操作 ====================

  /// 插入消息
  Future<int> insertMessage(LocalChatMessage message) async {
    final db = await _db;
    return await db.insert(
      'chat_messages',
      message.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// 批量插入消息
  Future<void> insertMessages(List<LocalChatMessage> messages) async {
    final db = await _db;
    final batch = db.batch();
    for (final message in messages) {
      batch.insert(
        'chat_messages',
        message.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  /// 获取与某用户的聊天记录
  Future<List<LocalChatMessage>> getMessagesByPartner(
    int currentUserId,
    int partnerId, {
    int limit = 50,
    int? beforeMessageId,
  }) async {
    final db = await _db;
    
    String whereClause = '''
      ((sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?))
    ''';
    List<dynamic> whereArgs = [currentUserId, partnerId, partnerId, currentUserId];
    
    if (beforeMessageId != null) {
      whereClause += ' AND message_id < ?';
      whereArgs.add(beforeMessageId);
    }
    
    final List<Map<String, dynamic>> maps = await db.query(
      'chat_messages',
      where: whereClause,
      whereArgs: whereArgs,
      orderBy: 'create_time DESC',
      limit: limit,
    );
    
    return maps.map((map) => LocalChatMessage.fromMap(map)).toList();
  }

  /// 获取待同步的消息
  Future<List<LocalChatMessage>> getPendingSyncMessages() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(
      'chat_messages',
      where: 'sync_status = ?',
      whereArgs: [1],
      orderBy: 'create_time ASC',
    );
    return maps.map((map) => LocalChatMessage.fromMap(map)).toList();
  }

  /// 更新消息同步状态
  Future<void> updateMessageSyncStatus(int messageId, int syncStatus) async {
    final db = await _db;
    await db.update(
      'chat_messages',
      {'sync_status': syncStatus},
      where: 'message_id = ?',
      whereArgs: [messageId],
    );
  }

  /// 更新消息已读状态
  Future<void> markMessagesAsRead(int senderId, int receiverId) async {
    final db = await _db;
    await db.update(
      'chat_messages',
      {'is_read': 1},
      where: 'sender_id = ? AND receiver_id = ? AND is_read = 0',
      whereArgs: [senderId, receiverId],
    );
  }

  /// 删除与某用户的所有消息
  Future<void> deleteMessagesByPartner(int currentUserId, int partnerId) async {
    final db = await _db;
    await db.delete(
      'chat_messages',
      where: '(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)',
      whereArgs: [currentUserId, partnerId, partnerId, currentUserId],
    );
  }

  /// 获取最新消息ID
  Future<int?> getLatestMessageId(int currentUserId, int partnerId) async {
    final db = await _db;
    final result = await db.rawQuery('''
      SELECT MAX(message_id) as max_id FROM chat_messages
      WHERE (sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)
    ''', [currentUserId, partnerId, partnerId, currentUserId]);
    
    if (result.isNotEmpty && result.first['max_id'] != null) {
      return result.first['max_id'] as int;
    }
    return null;
  }

  /// 搜索聊天记录
  Future<List<LocalChatMessage>> searchMessages(
    int currentUserId,
    int partnerId,
    String keyword,
  ) async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(
      'chat_messages',
      where: '''
        ((sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?))
        AND content LIKE ?
        AND type = 'TEXT'
      ''',
      whereArgs: [currentUserId, partnerId, partnerId, currentUserId, '%$keyword%'],
      orderBy: 'create_time DESC',
      limit: 50,
    );
    return maps.map((map) => LocalChatMessage.fromMap(map)).toList();
  }

  // ==================== 会话操作 ====================

  /// 插入或更新会话
  Future<void> upsertSession(LocalChatSession session) async {
    final db = await _db;
    await db.insert(
      'chat_sessions',
      session.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// 批量插入或更新会话
  Future<void> upsertSessions(List<LocalChatSession> sessions) async {
    final db = await _db;
    final batch = db.batch();
    for (final session in sessions) {
      batch.insert(
        'chat_sessions',
        session.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  /// 获取所有会话
  Future<List<LocalChatSession>> getAllSessions() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(
      'chat_sessions',
      orderBy: 'last_message_time DESC',
    );
    return maps.map((map) => LocalChatSession.fromMap(map)).toList();
  }

  /// 获取指定会话
  Future<LocalChatSession?> getSessionByPartner(int partnerId) async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(
      'chat_sessions',
      where: 'partner_id = ?',
      whereArgs: [partnerId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return LocalChatSession.fromMap(maps.first);
  }

  /// 更新会话未读数
  Future<void> updateSessionUnreadCount(int partnerId, int unreadCount) async {
    final db = await _db;
    await db.update(
      'chat_sessions',
      {'unread_count': unreadCount},
      where: 'partner_id = ?',
      whereArgs: [partnerId],
    );
  }

  /// 清空会话未读数
  Future<void> clearSessionUnreadCount(int partnerId) async {
    await updateSessionUnreadCount(partnerId, 0);
  }

  /// 删除会话
  Future<void> deleteSession(int partnerId) async {
    final db = await _db;
    await db.delete(
      'chat_sessions',
      where: 'partner_id = ?',
      whereArgs: [partnerId],
    );
  }

  /// 获取总未读数
  Future<int> getTotalUnreadCount() async {
    final db = await _db;
    final result = await db.rawQuery(
      'SELECT SUM(unread_count) as total FROM chat_sessions',
    );
    if (result.isNotEmpty && result.first['total'] != null) {
      return result.first['total'] as int;
    }
    return 0;
  }

  // ==================== 清理操作 ====================

  /// 清空所有聊天数据
  Future<void> clearAllChatData() async {
    final db = await _db;
    await db.delete('chat_messages');
    await db.delete('chat_sessions');
  }

  /// 删除指定天数前的消息
  Future<void> deleteOldMessages(int days) async {
    final db = await _db;
    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    await db.delete(
      'chat_messages',
      where: 'create_time < ?',
      whereArgs: [cutoffDate.toIso8601String()],
    );
  }
}
