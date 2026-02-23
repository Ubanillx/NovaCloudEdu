import 'dart:async';
import 'package:flutter/foundation.dart';
import 'chat_database_service.dart';
import 'chat_service.dart';
import 'chat_websocket_service.dart';

/// 聊天同步服务 - 负责本地数据库与云端的同步
class ChatSyncService {
  static final ChatSyncService _instance = ChatSyncService._internal();
  factory ChatSyncService() => _instance;
  ChatSyncService._internal();

  final _dbService = ChatDatabaseService();
  final _chatService = ChatService();
  final _wsService = ChatWebSocketService.instance;

  int? _currentUserId;
  Timer? _syncTimer;
  bool _isSyncing = false;

  // 同步状态流
  final _syncStateController = StreamController<bool>.broadcast();
  Stream<bool> get syncState => _syncStateController.stream;

  /// 初始化同步服务
  void init(int currentUserId) {
    _currentUserId = currentUserId;
    
    // 监听新消息，保存到本地
    _wsService.chatMessages.listen(_onNewMessage);
    
    // 启动定时同步（每5分钟）
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      syncPendingMessages();
    });
  }

  /// 处理新收到的消息
  void _onNewMessage(WsChatMessage message) async {
    if (_currentUserId == null) return;

    final localMessage = LocalChatMessage(
      messageId: message.messageId,
      senderId: message.senderId ?? 0,
      senderName: message.senderName,
      senderAvatar: message.senderAvatar,
      receiverId: message.receiverId ?? _currentUserId!,
      content: message.content,
      type: message.type ?? 'TEXT',
      isRead: message.isRead ?? false,
      isSent: true,
      createTime: message.createTime ?? DateTime.now(),
      syncStatus: 0, // 已同步（来自服务器）
    );

    await _dbService.insertMessage(localMessage);

    // 更新会话
    final partnerId = message.senderId == _currentUserId
        ? message.receiverId ?? 0
        : message.senderId ?? 0;
    
    await _updateSession(partnerId, message);
  }

  /// 更新会话信息
  Future<void> _updateSession(int partnerId, WsChatMessage message) async {
    final existingSession = await _dbService.getSessionByPartner(partnerId);

    // 根据消息类型生成会话摘要
    String lastMessage;
    switch ((message.type ?? 'TEXT').toUpperCase()) {
      case 'IMAGE':
        lastMessage = '[图片]';
        break;
      case 'AUDIO':
        lastMessage = '[语音]';
        break;
      case 'FILE':
        lastMessage = '[文件]';
        break;
      case 'VIDEO':
        lastMessage = '[视频]';
        break;
      case 'CALL':
        lastMessage = '[通话]';
        break;
      default:
        lastMessage = message.content ?? '';
    }

    final session = LocalChatSession(
      sessionId: existingSession?.sessionId,
      partnerId: partnerId,
      partnerName: existingSession?.partnerName ?? message.senderName,
      partnerAvatar: existingSession?.partnerAvatar ?? message.senderAvatar,
      lastMessage: lastMessage,
      lastMessageTime: message.createTime ?? DateTime.now(),
      unreadCount: (existingSession?.unreadCount ?? 0) + 1,
      updatedAt: DateTime.now(),
    );

    await _dbService.upsertSession(session);
  }

  /// 保存发送的消息到本地（待同步）
  Future<LocalChatMessage> saveOutgoingMessage({
    required int receiverId,
    required String content,
    required String type,
  }) async {
    if (_currentUserId == null) {
      throw Exception('用户未登录');
    }

    final message = LocalChatMessage(
      messageId: DateTime.now().millisecondsSinceEpoch,
      senderId: _currentUserId!,
      receiverId: receiverId,
      content: content,
      type: type,
      isRead: false,
      isSent: false,
      createTime: DateTime.now(),
      syncStatus: 1, // 待同步
    );

    await _dbService.insertMessage(message);
    return message;
  }

  /// 标记消息已发送成功
  Future<void> markMessageSent(int localMessageId, int serverMessageId) async {
    await _dbService.updateMessageSyncStatus(localMessageId, 0);
  }

  /// 从云端同步会话列表
  Future<void> syncSessions() async {
    try {
      final sessions = await _chatService.getSessionList();
      
      final localSessions = sessions.map((s) => LocalChatSession(
        sessionId: s.sessionId,
        partnerId: s.partnerId ?? 0,
        partnerName: s.partnerName,
        partnerAvatar: s.partnerAvatar,
        lastMessageTime: s.lastMessageTime,
        unreadCount: s.unreadCount ?? 0,
        updatedAt: DateTime.now(),
      )).toList();

      await _dbService.upsertSessions(localSessions);
      debugPrint('同步会话列表完成: ${sessions.length}条');
    } catch (e) {
      debugPrint('同步会话列表失败: $e');
    }
  }

  /// 从云端同步指定用户的聊天记录
  Future<void> syncMessagesWithPartner(int partnerId, {int? afterMessageId}) async {
    if (_currentUserId == null) return;

    try {
      _syncStateController.add(true);
      _isSyncing = true;

      // 从云端获取消息
      final messages = await _chatService.getChatHistory(
        partnerId: partnerId,
        beforeMessageId: afterMessageId,
      );

      if (messages.isEmpty) {
        debugPrint('没有新消息需要同步');
        return;
      }

      // 转换并保存到本地
      final localMessages = messages.map((m) => LocalChatMessage(
        messageId: m.messageId,
        senderId: m.senderId ?? 0,
        senderName: m.senderName,
        senderAvatar: m.senderAvatar,
        receiverId: m.receiverId ?? 0,
        content: m.content,
        type: m.type ?? 'TEXT',
        isRead: m.read ?? false,
        isSent: true,
        createTime: m.createTime ?? DateTime.now(),
        syncStatus: 0,
      )).toList();

      await _dbService.insertMessages(localMessages);
      debugPrint('同步消息完成: ${messages.length}条');
    } catch (e) {
      debugPrint('同步消息失败: $e');
    } finally {
      _isSyncing = false;
      _syncStateController.add(false);
    }
  }

  /// 同步待发送的消息到云端
  Future<void> syncPendingMessages() async {
    if (_isSyncing) return;

    try {
      final pendingMessages = await _dbService.getPendingSyncMessages();
      if (pendingMessages.isEmpty) return;

      debugPrint('开始同步${pendingMessages.length}条待发送消息');

      for (final message in pendingMessages) {
        try {
          // 通过WebSocket发送
          _wsService.sendPrivateMessage(
            receiverId: message.receiverId,
            content: message.content ?? '',
            type: message.type,
          );

          // 标记为已同步
          if (message.messageId != null) {
            await _dbService.updateMessageSyncStatus(message.messageId!, 0);
          }
        } catch (e) {
          // 标记为同步失败
          if (message.messageId != null) {
            await _dbService.updateMessageSyncStatus(message.messageId!, 2);
          }
          debugPrint('消息同步失败: ${message.messageId}, $e');
        }
      }
    } catch (e) {
      debugPrint('同步待发送消息失败: $e');
    }
  }

  /// 获取本地消息（优先本地，无则从云端获取）
  Future<List<LocalChatMessage>> getMessages(
    int partnerId, {
    int limit = 50,
    int? beforeMessageId,
  }) async {
    if (_currentUserId == null) return [];

    // 先从本地获取
    var messages = await _dbService.getMessagesByPartner(
      _currentUserId!,
      partnerId,
      limit: limit,
      beforeMessageId: beforeMessageId,
    );

    // 如果本地没有数据，从云端同步
    if (messages.isEmpty && beforeMessageId == null) {
      await syncMessagesWithPartner(partnerId);
      messages = await _dbService.getMessagesByPartner(
        _currentUserId!,
        partnerId,
        limit: limit,
      );
    }

    return messages;
  }

  /// 获取本地会话列表
  Future<List<LocalChatSession>> getSessions() async {
    var sessions = await _dbService.getAllSessions();
    
    // 如果本地没有数据，从云端同步
    if (sessions.isEmpty) {
      await syncSessions();
      sessions = await _dbService.getAllSessions();
    }

    return sessions;
  }

  /// 标记消息已读
  Future<void> markAsRead(int partnerId) async {
    if (_currentUserId == null) return;

    // 更新本地
    await _dbService.markMessagesAsRead(partnerId, _currentUserId!);
    await _dbService.clearSessionUnreadCount(partnerId);

    // 通知服务器
    _wsService.markAsRead(partnerId);
  }

  /// 清空与某用户的聊天记录
  Future<void> clearChatHistory(int partnerId) async {
    if (_currentUserId == null) return;
    await _dbService.deleteMessagesByPartner(_currentUserId!, partnerId);
    await _dbService.deleteSession(partnerId);
  }

  /// 获取总未读数
  Future<int> getTotalUnreadCount() async {
    return await _dbService.getTotalUnreadCount();
  }

  /// 释放资源
  void dispose() {
    _syncTimer?.cancel();
    _syncStateController.close();
  }
}
