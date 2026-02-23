import 'dart:async';
import 'package:flutter/foundation.dart';
import 'chat_websocket_service.dart';

/// 未读数统计
class UnreadCount {
  final int privateMessageCount;
  final int groupMessageCount;
  final int friendRequestCount;
  final int systemNotificationCount;

  UnreadCount({
    this.privateMessageCount = 0,
    this.groupMessageCount = 0,
    this.friendRequestCount = 0,
    this.systemNotificationCount = 0,
  });

  int get totalCount =>
      privateMessageCount + groupMessageCount + friendRequestCount + systemNotificationCount;

  UnreadCount copyWith({
    int? privateMessageCount,
    int? groupMessageCount,
    int? friendRequestCount,
    int? systemNotificationCount,
  }) {
    return UnreadCount(
      privateMessageCount: privateMessageCount ?? this.privateMessageCount,
      groupMessageCount: groupMessageCount ?? this.groupMessageCount,
      friendRequestCount: friendRequestCount ?? this.friendRequestCount,
      systemNotificationCount: systemNotificationCount ?? this.systemNotificationCount,
    );
  }
}

/// 群未读数
class GroupUnreadCount {
  final int groupId;
  final int unreadCount;
  final String? lastMessage;
  final DateTime? lastMessageTime;

  GroupUnreadCount({
    required this.groupId,
    this.unreadCount = 0,
    this.lastMessage,
    this.lastMessageTime,
  });
}

/// 全局通知服务
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final _wsService = ChatWebSocketService.instance;

  // 未读数
  UnreadCount _unreadCount = UnreadCount();
  final Map<int, GroupUnreadCount> _groupUnreadCounts = {};

  // 流控制器
  final _unreadCountController = StreamController<UnreadCount>.broadcast();
  final _groupUnreadController = StreamController<Map<int, GroupUnreadCount>>.broadcast();
  final _newNotificationController = StreamController<NotificationEvent>.broadcast();

  StreamSubscription<NotificationEvent>? _notificationSubscription;

  /// 未读数流
  Stream<UnreadCount> get unreadCountStream => _unreadCountController.stream;

  /// 群未读数流
  Stream<Map<int, GroupUnreadCount>> get groupUnreadStream => _groupUnreadController.stream;

  /// 新通知流
  Stream<NotificationEvent> get newNotifications => _newNotificationController.stream;

  /// 当前未读数
  UnreadCount get currentUnreadCount => _unreadCount;

  /// 群未读数
  Map<int, GroupUnreadCount> get groupUnreadCounts => Map.unmodifiable(_groupUnreadCounts);

  /// 初始化
  void init() {
    _notificationSubscription?.cancel();
    _notificationSubscription = _wsService.notifications.listen(_handleNotification);
    
    // 请求刷新未读数
    _wsService.refreshUnreadCount();
  }

  void _handleNotification(NotificationEvent event) {
    debugPrint('处理通知: ${event.type}');
    _newNotificationController.add(event);

    switch (event.type) {
      case 'NEW_PRIVATE_MESSAGE':
        _unreadCount = _unreadCount.copyWith(
          privateMessageCount: _unreadCount.privateMessageCount + 1,
        );
        _unreadCountController.add(_unreadCount);
        break;

      case 'PRIVATE_MESSAGE_READ':
        // 私聊消息被读取，可能需要更新未读数
        break;

      case 'NEW_GROUP_MESSAGE':
        final groupId = event.data['groupId'] as int?;
        if (groupId != null) {
          _updateGroupUnread(
            groupId,
            increment: 1,
            lastMessage: event.data['content'] as String?,
            lastMessageTime: DateTime.now(),
          );
        }
        _unreadCount = _unreadCount.copyWith(
          groupMessageCount: _unreadCount.groupMessageCount + 1,
        );
        _unreadCountController.add(_unreadCount);
        break;

      case 'GROUP_MESSAGE_READ':
        final groupId = event.data['groupId'] as int?;
        if (groupId != null) {
          _clearGroupUnread(groupId);
        }
        break;

      case 'FRIEND_REQUEST_RECEIVED':
        _unreadCount = _unreadCount.copyWith(
          friendRequestCount: _unreadCount.friendRequestCount + 1,
        );
        _unreadCountController.add(_unreadCount);
        break;

      case 'FRIEND_REQUEST_HANDLED':
      case 'NEW_FRIEND':
        // 好友请求已处理
        break;

      case 'GROUP_JOIN_REQUEST_RECEIVED':
      case 'GROUP_INVITED':
      case 'GROUP_REMOVED':
        // 群组相关通知
        break;

      case 'UNREAD_COUNT_CHANGED':
        // 服务器推送的未读数更新（字段名与后端对齐）
        _unreadCount = UnreadCount(
          privateMessageCount: event.data['privateUnread'] as int? ?? 0,
          groupMessageCount: event.data['groupUnread'] as int? ?? 0,
          friendRequestCount: event.data['friendRequestCount'] as int? ?? 0,
          systemNotificationCount: event.data['systemNotificationCount'] as int? ?? 0,
        );
        _unreadCountController.add(_unreadCount);
        debugPrint('未读数更新: private=${_unreadCount.privateMessageCount}, group=${_unreadCount.groupMessageCount}, friend=${_unreadCount.friendRequestCount}, total=${_unreadCount.totalCount}');
        break;

      case 'SYSTEM_NOTIFICATION':
        _unreadCount = _unreadCount.copyWith(
          systemNotificationCount: _unreadCount.systemNotificationCount + 1,
        );
        _unreadCountController.add(_unreadCount);
        break;
    }
  }

  void _updateGroupUnread(
    int groupId, {
    int increment = 0,
    String? lastMessage,
    DateTime? lastMessageTime,
  }) {
    final current = _groupUnreadCounts[groupId];
    _groupUnreadCounts[groupId] = GroupUnreadCount(
      groupId: groupId,
      unreadCount: (current?.unreadCount ?? 0) + increment,
      lastMessage: lastMessage ?? current?.lastMessage,
      lastMessageTime: lastMessageTime ?? current?.lastMessageTime,
    );
    _groupUnreadController.add(_groupUnreadCounts);
  }

  void _clearGroupUnread(int groupId) {
    if (_groupUnreadCounts.containsKey(groupId)) {
      final old = _groupUnreadCounts[groupId]!;
      _groupUnreadCounts[groupId] = GroupUnreadCount(
        groupId: groupId,
        unreadCount: 0,
        lastMessage: old.lastMessage,
        lastMessageTime: old.lastMessageTime,
      );
      _groupUnreadController.add(_groupUnreadCounts);
    }
  }

  /// 标记群消息已读
  void markGroupAsRead(int groupId) {
    _clearGroupUnread(groupId);
    // 同时更新总未读数
    final groupTotal = _groupUnreadCounts.values
        .fold<int>(0, (sum, g) => sum + g.unreadCount);
    _unreadCount = _unreadCount.copyWith(groupMessageCount: groupTotal);
    _unreadCountController.add(_unreadCount);
  }

  /// 标记私聊已读
  void markPrivateAsRead(int senderId) {
    _wsService.markAsRead(senderId);
    // 本地更新（实际数量应该从服务器获取）
    if (_unreadCount.privateMessageCount > 0) {
      _unreadCount = _unreadCount.copyWith(
        privateMessageCount: _unreadCount.privateMessageCount - 1,
      );
      _unreadCountController.add(_unreadCount);
    }
  }

  /// 清除好友请求未读数
  void clearFriendRequestUnread() {
    _unreadCount = _unreadCount.copyWith(friendRequestCount: 0);
    _unreadCountController.add(_unreadCount);
  }

  /// 清除系统通知未读数
  void clearSystemNotificationUnread() {
    _unreadCount = _unreadCount.copyWith(systemNotificationCount: 0);
    _unreadCountController.add(_unreadCount);
  }

  /// 刷新未读数
  void refreshUnreadCount() {
    _wsService.refreshUnreadCount();
  }

  /// 获取群未读数
  int getGroupUnreadCount(int groupId) {
    return _groupUnreadCounts[groupId]?.unreadCount ?? 0;
  }

  /// 释放资源
  void dispose() {
    _notificationSubscription?.cancel();
    _unreadCountController.close();
    _groupUnreadController.close();
    _newNotificationController.close();
  }
}
