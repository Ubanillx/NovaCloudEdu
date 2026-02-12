import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import '../../../config/env_config.dart';

/// WebSocket 聊天消息
class WsChatMessage {
  final int? messageId;
  final int? senderId;
  final String? senderName;
  final String? senderAvatar;
  final int? receiverId;
  final String? content;
  final String? type;
  final DateTime? createTime;
  final bool? isRead;

  WsChatMessage({
    this.messageId,
    this.senderId,
    this.senderName,
    this.senderAvatar,
    this.receiverId,
    this.content,
    this.type,
    this.createTime,
    this.isRead,
  });

  factory WsChatMessage.fromJson(Map<String, dynamic> json) {
    return WsChatMessage(
      messageId: json['messageId'] as int?,
      senderId: json['senderId'] as int?,
      senderName: json['senderName'] as String?,
      senderAvatar: json['senderAvatar'] as String?,
      receiverId: json['receiverId'] as int?,
      content: json['content'] as String?,
      type: json['type'] as String?,
      createTime: json['createTime'] != null
          ? DateTime.tryParse(json['createTime'] as String)
          : null,
      isRead: json['isRead'] as bool? ?? json['read'] as bool?,
    );
  }
}

/// 通知事件
class NotificationEvent {
  final String type;
  final Map<String, dynamic> data;
  final DateTime? timestamp;

  NotificationEvent({
    required this.type,
    required this.data,
    this.timestamp,
  });

  factory NotificationEvent.fromJson(Map<String, dynamic> json) {
    return NotificationEvent(
      type: json['type'] as String? ?? '',
      data: json['data'] as Map<String, dynamic>? ?? {},
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'] as String)
          : null,
    );
  }
}

/// 已读回执
class ReadReceipt {
  final int? senderId;
  final DateTime? readTime;

  ReadReceipt({this.senderId, this.readTime});

  factory ReadReceipt.fromJson(Map<String, dynamic> json) {
    return ReadReceipt(
      senderId: json['senderId'] as int?,
      readTime: json['readTime'] != null
          ? DateTime.tryParse(json['readTime'] as String)
          : null,
    );
  }
}

/// 群聊消息
class WsGroupMessage {
  final int? messageId;
  final int? groupId;
  final int? senderId;
  final String? senderName;
  final String? senderAvatar;
  final String? content;
  final String? type;
  final int? replyTo;
  final DateTime? createTime;

  WsGroupMessage({
    this.messageId,
    this.groupId,
    this.senderId,
    this.senderName,
    this.senderAvatar,
    this.content,
    this.type,
    this.replyTo,
    this.createTime,
  });

  factory WsGroupMessage.fromJson(Map<String, dynamic> json) {
    return WsGroupMessage(
      messageId: json['messageId'] as int?,
      groupId: json['groupId'] as int?,
      senderId: json['senderId'] as int?,
      senderName: json['senderName'] as String?,
      senderAvatar: json['senderAvatar'] as String?,
      content: json['content'] as String?,
      type: json['type'] as String?,
      replyTo: json['replyTo'] as int?,
      createTime: json['createTime'] != null
          ? DateTime.tryParse(json['createTime'] as String)
          : null,
    );
  }
}

/// 群已读回执
class WsGroupReadReceipt {
  final int? messageId;
  final int? groupId;
  final int? readerId;
  final String? readerName;
  final String? readerAvatar;
  final int? totalReadCount;
  final DateTime? readTime;

  WsGroupReadReceipt({
    this.messageId,
    this.groupId,
    this.readerId,
    this.readerName,
    this.readerAvatar,
    this.totalReadCount,
    this.readTime,
  });

  factory WsGroupReadReceipt.fromJson(Map<String, dynamic> json) {
    return WsGroupReadReceipt(
      messageId: json['messageId'] as int?,
      groupId: json['groupId'] as int?,
      readerId: json['readerId'] as int?,
      readerName: json['readerName'] as String?,
      readerAvatar: json['readerAvatar'] as String?,
      totalReadCount: json['totalReadCount'] as int?,
      readTime: json['readTime'] != null
          ? DateTime.tryParse(json['readTime'] as String)
          : null,
    );
  }
}

/// WebSocket 聊天服务 - STOMP 协议
class ChatWebSocketService {
  static ChatWebSocketService? _instance;
  static ChatWebSocketService get instance {
    _instance ??= ChatWebSocketService._internal();
    return _instance!;
  }

  ChatWebSocketService._internal();

  StompClient? _stompClient;
  bool _isConnected = false;
  String? _token;
  bool _isRefreshingToken = false;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 3;
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // 消息回调
  final _chatMessageController = StreamController<WsChatMessage>.broadcast();
  final _groupMessageController = StreamController<WsGroupMessage>.broadcast();
  final _notificationController = StreamController<NotificationEvent>.broadcast();
  final _readReceiptController = StreamController<ReadReceipt>.broadcast();
  final _groupReadReceiptController = StreamController<WsGroupReadReceipt>.broadcast();
  final _groupMessageSentController = StreamController<WsGroupMessage>.broadcast();
  final _connectionStateController = StreamController<bool>.broadcast();

  // 已订阅的群组
  final Set<int> _subscribedGroups = {};

  /// 聊天消息流
  Stream<WsChatMessage> get chatMessages => _chatMessageController.stream;

  /// 群聊消息流
  Stream<WsGroupMessage> get groupMessages => _groupMessageController.stream;

  /// 通知流
  Stream<NotificationEvent> get notifications => _notificationController.stream;

  /// 已读回执流
  Stream<ReadReceipt> get readReceipts => _readReceiptController.stream;

  /// 群已读回执流
  Stream<WsGroupReadReceipt> get groupReadReceipts => _groupReadReceiptController.stream;

  /// 群消息发送确认流（发送者专用，含服务端分配的 messageId）
  Stream<WsGroupMessage> get groupMessagesSent => _groupMessageSentController.stream;

  /// 连接状态流
  Stream<bool> get connectionState => _connectionStateController.stream;

  /// 是否已连接
  bool get isConnected => _isConnected;

  /// WebSocket URL
  String get _wsUrl {
    final baseUrl = EnvConfig.apiBaseUrl;
    // 将 http:// 替换为 ws://，https:// 替换为 wss://
    if (baseUrl.startsWith('https://')) {
      return '${baseUrl.replaceFirst('https://', 'wss://')}/ws';
    } else {
      return '${baseUrl.replaceFirst('http://', 'ws://')}/ws';
    }
  }

  /// 连接 WebSocket
  void connect(String token) {
    if (_isConnected && _token == token) {
      debugPrint('WebSocket 已连接，跳过重复连接');
      return;
    }

    _token = token;
    disconnect();

    debugPrint('正在连接 WebSocket: $_wsUrl');

    _reconnectAttempts = 0;

    _stompClient = StompClient(
      config: StompConfig(
        url: _wsUrl,
        onConnect: _onConnect,
        onDisconnect: _onDisconnect,
        onWebSocketError: _onWebSocketError,
        onStompError: _onStompError,
        stompConnectHeaders: {
          'Authorization': 'Bearer $token',
        },
        webSocketConnectHeaders: {
          'Authorization': 'Bearer $token',
        },
        heartbeatIncoming: const Duration(seconds: 10),
        heartbeatOutgoing: const Duration(seconds: 10),
        // 禁用自动重连，由 _onWebSocketError 手动处理（先刷新token再重连）
        reconnectDelay: const Duration(seconds: 0),
      ),
    );

    _stompClient!.activate();
  }

  void _onConnect(StompFrame frame) {
    debugPrint('WebSocket 已连接: ${frame.command}');
    _isConnected = true;
    _reconnectAttempts = 0;
    _connectionStateController.add(true);

    // 订阅私聊消息
    _stompClient!.subscribe(
      destination: '/user/queue/messages',
      callback: (frame) {
        if (frame.body != null) {
          try {
            final json = jsonDecode(frame.body!) as Map<String, dynamic>;
            final message = WsChatMessage.fromJson(json);
            _chatMessageController.add(message);
            debugPrint('收到私聊消息: ${message.content}');
          } catch (e) {
            debugPrint('解析私聊消息失败: $e');
          }
        }
      },
    );

    // 订阅通知
    _stompClient!.subscribe(
      destination: '/user/queue/notifications',
      callback: (frame) {
        if (frame.body != null) {
          try {
            final json = jsonDecode(frame.body!) as Map<String, dynamic>;
            final notification = NotificationEvent.fromJson(json);
            _notificationController.add(notification);
            debugPrint('收到通知: ${notification.type}');
          } catch (e) {
            debugPrint('解析通知失败: $e');
          }
        }
      },
    );

    // 订阅群消息（后端逐个推送，排除发送者）
    _stompClient!.subscribe(
      destination: '/user/queue/group-messages',
      callback: (frame) {
        if (frame.body != null) {
          try {
            final json = jsonDecode(frame.body!) as Map<String, dynamic>;
            final message = WsGroupMessage.fromJson(json);
            _groupMessageController.add(message);
            debugPrint('收到群消息(user queue): ${message.content}');
          } catch (e) {
            debugPrint('解析群消息失败: $e');
          }
        }
      },
    );

    // 订阅群消息发送确认（发送者专用，含服务端分配的 messageId）
    _stompClient!.subscribe(
      destination: '/user/queue/group-message-sent',
      callback: (frame) {
        if (frame.body != null) {
          try {
            final json = jsonDecode(frame.body!) as Map<String, dynamic>;
            final message = WsGroupMessage.fromJson(json);
            _groupMessageSentController.add(message);
            debugPrint('群消息发送确认: messageId=${message.messageId}');
          } catch (e) {
            debugPrint('解析群消息发送确认失败: $e');
          }
        }
      },
    );

    // 订阅已读回执
    _stompClient!.subscribe(
      destination: '/user/queue/read-receipt',
      callback: (frame) {
        if (frame.body != null) {
          try {
            final json = jsonDecode(frame.body!) as Map<String, dynamic>;
            final receipt = ReadReceipt.fromJson(json);
            _readReceiptController.add(receipt);
            debugPrint('收到已读回执: ${receipt.senderId}');
          } catch (e) {
            debugPrint('解析已读回执失败: $e');
          }
        }
      },
    );
  }

  void _onDisconnect(StompFrame frame) {
    debugPrint('WebSocket 已断开');
    _isConnected = false;
    _connectionStateController.add(false);
  }

  void _onWebSocketError(dynamic error) {
    debugPrint('WebSocket 错误: $error');
    _isConnected = false;
    _connectionStateController.add(false);

    // 检测 401 错误（token 过期）
    final errorStr = error.toString();
    if (errorStr.contains('401') || errorStr.contains('not upgraded')) {
      debugPrint('WebSocket 401 错误，尝试刷新 token 后重连...');
      _refreshTokenAndReconnect();
    } else {
      // 非 401 错误，延迟后尝试用当前 token 重连
      _scheduleReconnect();
    }
  }

  /// 延迟重连（非 token 过期的情况）
  void _scheduleReconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      debugPrint('WebSocket 重连次数已达上限 ($_maxReconnectAttempts)，停止重连');
      return;
    }
    _reconnectAttempts++;
    final delay = Duration(seconds: 5 * _reconnectAttempts);
    debugPrint('WebSocket 将在 ${delay.inSeconds}s 后重连 (第 $_reconnectAttempts 次)');
    Future.delayed(delay, () {
      if (!_isConnected && _token != null) {
        connect(_token!);
      }
    });
  }

  /// 刷新 token 并重连 WebSocket
  Future<void> _refreshTokenAndReconnect() async {
    if (_isRefreshingToken) return;
    _isRefreshingToken = true;

    try {
      final refreshToken = await _storage.read(key: _refreshTokenKey);
      if (refreshToken == null || refreshToken.isEmpty) {
        debugPrint('WebSocket: 无 refresh token，无法刷新');
        _isRefreshingToken = false;
        return;
      }

      debugPrint('WebSocket: 正在刷新 token...');
      final refreshDio = Dio(BaseOptions(
        baseUrl: EnvConfig.apiBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ));

      final response = await refreshDio.post(
        '/api/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200 && response.data['code'] == 0) {
        final data = response.data['data'];
        final newToken = data['token'] as String?;
        final newRefreshToken = data['refreshToken'] as String?;

        if (newToken != null && newRefreshToken != null) {
          // 保存新 token
          await _storage.write(key: _tokenKey, value: newToken);
          await _storage.write(key: _refreshTokenKey, value: newRefreshToken);

          debugPrint('WebSocket: token 刷新成功，使用新 token 重连');
          _isRefreshingToken = false;
          // 用新 token 重连
          connect(newToken);
          return;
        }
      }

      debugPrint('WebSocket: token 刷新失败');
    } catch (e) {
      debugPrint('WebSocket: token 刷新异常: $e');
    }

    _isRefreshingToken = false;
  }

  void _onStompError(StompFrame frame) {
    debugPrint('STOMP 错误: ${frame.body}');
  }

  /// 发送私聊消息
  void sendPrivateMessage({
    required int receiverId,
    required String content,
    String type = 'TEXT',
  }) {
    if (!_isConnected || _stompClient == null) {
      debugPrint('WebSocket 未连接，无法发送消息');
      return;
    }

    _stompClient!.send(
      destination: '/app/chat.send',
      body: jsonEncode({
        'receiverId': receiverId,
        'content': content,
        'type': type,
      }),
    );
    debugPrint('发送私聊消息: $content -> $receiverId');
  }

  /// 标记消息已读
  void markAsRead(int senderId) {
    if (!_isConnected || _stompClient == null) {
      debugPrint('WebSocket 未连接，无法标记已读');
      return;
    }

    _stompClient!.send(
      destination: '/app/chat.read',
      body: jsonEncode({
        'senderId': senderId,
      }),
    );
    debugPrint('标记消息已读: $senderId');
  }

  /// 刷新未读数
  void refreshUnreadCount() {
    if (!_isConnected || _stompClient == null) {
      return;
    }

    _stompClient!.send(
      destination: '/app/notification.refreshUnread',
      body: jsonEncode({}),
    );
  }

  /// 订阅群组消息
  void subscribeToGroup(int groupId) {
    if (!_isConnected || _stompClient == null) {
      debugPrint('WebSocket 未连接，无法订阅群组');
      return;
    }

    if (_subscribedGroups.contains(groupId)) {
      debugPrint('已订阅群组 $groupId');
      return;
    }

    _stompClient!.subscribe(
      destination: '/topic/group/$groupId',
      callback: (frame) {
        if (frame.body != null) {
          try {
            final json = jsonDecode(frame.body!) as Map<String, dynamic>;
            final message = WsGroupMessage.fromJson(json);
            _groupMessageController.add(message);
            debugPrint('收到群消息: ${message.content}');
          } catch (e) {
            debugPrint('解析群消息失败: $e');
          }
        }
      },
    );

    // 订阅群已读回执
    _stompClient!.subscribe(
      destination: '/topic/group/$groupId/read-receipts',
      callback: (frame) {
        if (frame.body != null) {
          try {
            final json = jsonDecode(frame.body!) as Map<String, dynamic>;
            final receipt = WsGroupReadReceipt.fromJson(json);
            _groupReadReceiptController.add(receipt);
            debugPrint('收到群已读回执: messageId=${receipt.messageId}, reader=${receipt.readerName}');
          } catch (e) {
            debugPrint('解析群已读回执失败: $e');
          }
        }
      },
    );

    _subscribedGroups.add(groupId);
    debugPrint('已订阅群组 $groupId (消息+已读回执)');
  }

  /// 取消订阅群组消息
  void unsubscribeFromGroup(int groupId) {
    _subscribedGroups.remove(groupId);
    debugPrint('已取消订阅群组 $groupId');
  }

  /// 发送群聊消息
  void sendGroupMessage({
    required int groupId,
    required String content,
    String type = 'TEXT',
    int? replyTo,
  }) {
    if (!_isConnected || _stompClient == null) {
      debugPrint('WebSocket 未连接，无法发送群消息');
      return;
    }

    _stompClient!.send(
      destination: '/app/group.send',
      body: jsonEncode({
        'groupId': groupId,
        'content': content,
        'type': type,
        if (replyTo != null) 'replyTo': replyTo,
      }),
    );
    debugPrint('发送群消息: $content -> 群组$groupId');
  }

  /// 标记群消息已读
  void markGroupMessageAsRead({
    required int groupId,
    required int messageId,
  }) {
    if (!_isConnected || _stompClient == null) {
      debugPrint('WebSocket 未连接，无法标记群消息已读');
      return;
    }

    _stompClient!.send(
      destination: '/app/group.read',
      body: jsonEncode({
        'groupId': groupId,
        'messageId': messageId,
      }),
    );
    debugPrint('标记群消息已读: 群组$groupId 消息$messageId');
  }

  /// 断开连接
  void disconnect() {
    if (_stompClient != null) {
      _stompClient!.deactivate();
      _stompClient = null;
    }
    _isConnected = false;
    _connectionStateController.add(false);
    debugPrint('WebSocket 已断开连接');
  }

  /// 释放资源
  void dispose() {
    disconnect();
    _chatMessageController.close();
    _groupMessageController.close();
    _notificationController.close();
    _readReceiptController.close();
    _groupReadReceiptController.close();
    _connectionStateController.close();
    _subscribedGroups.clear();
    _instance = null;
  }
}
