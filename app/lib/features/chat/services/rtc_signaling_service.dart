import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:dio/dio.dart';
import '../../../config/env_config.dart';
import 'rtc_models.dart';

/// RTC 信令服务 — 原生 WebSocket（独立于 STOMP 聊天连接）
class RtcSignalingService {
  static RtcSignalingService? _instance;
  static RtcSignalingService get instance {
    _instance ??= RtcSignalingService._internal();
    return _instance!;
  }

  RtcSignalingService._internal();

  WebSocketChannel? _channel;
  bool _isConnected = false;
  String? _token;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  bool _isRefreshingToken = false;
  bool _disposed = false;
  bool _isReconnecting = false;

  static const int _maxReconnectAttempts = 5;
  static const Duration _heartbeatInterval = Duration(seconds: 30);
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // 事件流
  final _incomingCallController = StreamController<IncomingCallData>.broadcast();
  final _callAnsweredController = StreamController<AnswerData>.broadcast();
  final _iceCandidateController = StreamController<ICEData>.broadcast();
  final _callRejectedController = StreamController<CallControlData>.broadcast();
  final _callBusyController = StreamController<CallControlData>.broadcast();
  final _callEndedController = StreamController<CallEndedData>.broadcast();
  final _sfuFallbackController = StreamController<SFUFallbackData>.broadcast();
  final _turnConfigController = StreamController<TURNConfigData>.broadcast();
  final _errorController = StreamController<RtcErrorData>.broadcast();
  final _connectionStateController = StreamController<bool>.broadcast();

  Stream<IncomingCallData> get incomingCall => _incomingCallController.stream;
  Stream<AnswerData> get callAnswered => _callAnsweredController.stream;
  Stream<ICEData> get iceCandidate => _iceCandidateController.stream;
  Stream<CallControlData> get callRejected => _callRejectedController.stream;
  Stream<CallControlData> get callBusy => _callBusyController.stream;
  Stream<CallEndedData> get callEnded => _callEndedController.stream;
  Stream<SFUFallbackData> get sfuFallback => _sfuFallbackController.stream;
  Stream<TURNConfigData> get turnConfig => _turnConfigController.stream;
  Stream<RtcErrorData> get error => _errorController.stream;
  Stream<bool> get connectionState => _connectionStateController.stream;

  bool get isConnected => _isConnected;

  /// 连接 RTC 信令服务器
  void connect(String token) {
    if (_isConnected && _token == token) return;
    _token = token;
    _disposed = false;
    disconnect(clearToken: false);
    _doConnect();
  }

  void _doConnect() {
    if (_token == null || _disposed) return;

    final wsUrl = '${EnvConfig.rtcWsUrl}/ws?token=$_token';
    debugPrint('[RTC Signaling] 正在连接: ${EnvConfig.rtcWsUrl}/ws');

    try {
      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

      // 等待连接就绪（捕获握手失败）
      _channel!.ready.then((_) {
        _isConnected = true;
        _reconnectAttempts = 0;
        _connectionStateController.add(true);
        _startHeartbeat();
        debugPrint('[RTC Signaling] 已连接');
      }).catchError((e) {
        debugPrint('[RTC Signaling] 握手失败: $e');
        _isConnected = false;
        _connectionStateController.add(false);
        _channel = null;
        if (!_disposed) _scheduleReconnect();
      });

      _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: false,
      );
    } catch (e) {
      debugPrint('[RTC Signaling] 连接失败: $e');
      _isConnected = false;
      _connectionStateController.add(false);
      _scheduleReconnect();
    }
  }

  void _onMessage(dynamic rawMessage) {
    try {
      final json = jsonDecode(rawMessage as String) as Map<String, dynamic>;
      final msg = RtcMessage.fromJson(json);

      switch (msg.type) {
        case 'incoming_call':
          if (msg.data != null) {
            _incomingCallController.add(IncomingCallData.fromJson(msg.data!));
          }
          break;
        case 'call_answered':
          if (msg.data != null) {
            _callAnsweredController.add(AnswerData.fromJson(msg.data!));
          }
          break;
        case 'ice_candidate':
          if (msg.data != null) {
            _iceCandidateController.add(ICEData.fromJson(msg.data!));
          }
          break;
        case 'call_rejected':
          if (msg.data != null) {
            _callRejectedController.add(CallControlData.fromJson(msg.data!));
          }
          break;
        case 'call_busy':
          if (msg.data != null) {
            _callBusyController.add(CallControlData.fromJson(msg.data!));
          }
          break;
        case 'call_ended':
          if (msg.data != null) {
            _callEndedController.add(CallEndedData.fromJson(msg.data!));
          }
          break;
        case 'sfu_fallback':
          if (msg.data != null) {
            _sfuFallbackController.add(SFUFallbackData.fromJson(msg.data!));
          }
          break;
        case 'turn_config':
          if (msg.data != null) {
            _turnConfigController.add(TURNConfigData.fromJson(msg.data!));
          }
          break;
        case 'error':
          if (msg.data != null) {
            _errorController.add(RtcErrorData.fromJson(msg.data!));
          }
          break;
        case 'heartbeat_ack':
          break;
        default:
          debugPrint('[RTC Signaling] 未知消息类型: ${msg.type}');
      }
    } catch (e) {
      debugPrint('[RTC Signaling] 解析消息失败: $e');
    }
  }

  void _onError(dynamic error) {
    debugPrint('[RTC Signaling] WebSocket 错误: $error');
    _handleDisconnect();
  }

  void _onDone() {
    debugPrint('[RTC Signaling] WebSocket 已关闭');
    _handleDisconnect();
  }

  void _handleDisconnect() {
    if (!_isConnected && _channel == null) return; // 已处理过
    _isConnected = false;
    _connectionStateController.add(false);
    _stopHeartbeat();
    _channel = null;
    if (!_disposed && !_isReconnecting) {
      _scheduleReconnect();
    }
  }

  // ============ 心跳 ============

  void _startHeartbeat() {
    _stopHeartbeat();
    _heartbeatTimer = Timer.periodic(_heartbeatInterval, (_) {
      _send(RtcMessage(type: 'heartbeat'));
    });
  }

  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  // ============ 重连 ============

  void _scheduleReconnect() {
    if (_disposed || _isReconnecting || _reconnectAttempts >= _maxReconnectAttempts) {
      if (_reconnectAttempts >= _maxReconnectAttempts) {
        debugPrint('[RTC Signaling] 重连次数已达上限 ($_maxReconnectAttempts)，停止重连');
      }
      return;
    }
    _isReconnecting = true;
    _reconnectAttempts++;
    final delay = Duration(seconds: 3 * _reconnectAttempts);
    debugPrint('[RTC Signaling] ${delay.inSeconds}s 后重连 (第$_reconnectAttempts次)');
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () {
      _isReconnecting = false;
      if (!_isConnected && !_disposed) {
        _doConnect();
      }
    });
  }

  Future<void> _refreshTokenAndReconnect() async {
    if (_isRefreshingToken) return;
    _isRefreshingToken = true;

    try {
      final refreshToken = await _storage.read(key: _refreshTokenKey);
      if (refreshToken == null || refreshToken.isEmpty) {
        debugPrint('[RTC Signaling] 无 refresh token');
        _isRefreshingToken = false;
        return;
      }

      final dio = Dio(BaseOptions(
        baseUrl: EnvConfig.apiBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ));

      final response = await dio.post('/api/auth/refresh', data: {'refreshToken': refreshToken});
      if (response.statusCode == 200 && response.data['code'] == 0) {
        final data = response.data['data'];
        final newToken = data['token'] as String?;
        final newRefreshToken = data['refreshToken'] as String?;
        if (newToken != null && newRefreshToken != null) {
          await _storage.write(key: _tokenKey, value: newToken);
          await _storage.write(key: _refreshTokenKey, value: newRefreshToken);
          _isRefreshingToken = false;
          _token = newToken;
          _reconnectAttempts = 0;
          _doConnect();
          return;
        }
      }
    } catch (e) {
      debugPrint('[RTC Signaling] Token 刷新失败: $e');
    }
    _isRefreshingToken = false;
  }

  // ============ 发送方法 ============

  void _send(RtcMessage msg) {
    if (_channel != null && _isConnected) {
      _channel!.sink.add(jsonEncode(msg.toJson()));
    }
  }

  void sendInvite(InviteData data) {
    _send(RtcMessage(type: 'invite', data: data.toJson()));
  }

  void sendAnswer(AnswerData data) {
    _send(RtcMessage(type: 'answer', data: data.toJson()));
  }

  void sendICE(ICEData data) {
    _send(RtcMessage(type: 'ice', data: data.toJson()));
  }

  void sendBye(String callId) {
    _send(RtcMessage(type: 'bye', data: CallControlData(callId: callId).toJson()));
  }

  void sendReject(String callId) {
    _send(RtcMessage(type: 'reject', data: CallControlData(callId: callId).toJson()));
  }

  void sendBusy(String callId) {
    _send(RtcMessage(type: 'busy', data: CallControlData(callId: callId).toJson()));
  }

  void sendFallbackSFU(String callId) {
    _send(RtcMessage(type: 'fallback_sfu', data: CallControlData(callId: callId).toJson()));
  }

  // ============ 生命周期 ============

  void disconnect({bool clearToken = true}) {
    _stopHeartbeat();
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _channel?.sink.close();
    _channel = null;
    _isConnected = false;
    _connectionStateController.add(false);
    if (clearToken) _token = null;
  }

  void dispose() {
    _disposed = true;
    disconnect();
    _incomingCallController.close();
    _callAnsweredController.close();
    _iceCandidateController.close();
    _callRejectedController.close();
    _callBusyController.close();
    _callEndedController.close();
    _sfuFallbackController.close();
    _turnConfigController.close();
    _errorController.close();
    _connectionStateController.close();
    _instance = null;
  }
}
