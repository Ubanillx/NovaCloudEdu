import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'rtc_models.dart';
import 'rtc_signaling_service.dart';
import 'webrtc_service.dart';
import 'livekit_service.dart';
import 'ringtone_service.dart';

/// 全局通话状态编排服务
class CallService {
  static final CallService _instance = CallService._internal();
  factory CallService() => _instance;
  CallService._internal();

  final _signaling = RtcSignalingService.instance;
  final _webrtc = WebRTCService();
  final _livekit = LiveKitService();
  final _ringtone = RingtoneService();

  CallState _callState = CallState.idle;
  CurrentCall? _currentCall;
  IncomingCallData? _pendingIncoming;

  // 通话计时
  Timer? _callTimer;
  int _callDuration = 0;

  // 订阅
  final List<StreamSubscription> _subscriptions = [];

  // 事件流
  final _callStateController = StreamController<CallState>.broadcast();
  final _currentCallController = StreamController<CurrentCall?>.broadcast();
  final _callDurationController = StreamController<int>.broadcast();

  Stream<CallState> get callStateStream => _callStateController.stream;
  Stream<CurrentCall?> get currentCallStream => _currentCallController.stream;
  Stream<int> get callDurationStream => _callDurationController.stream;

  CallState get callState => _callState;
  CurrentCall? get currentCall => _currentCall;
  int get callDuration => _callDuration;
  WebRTCService get webrtc => _webrtc;
  LiveKitService get livekit => _livekit;

  /// 初始化 — 绑定信令事件
  void init() {
    _disposeSubscriptions();

    _subscriptions.addAll([
      _signaling.incomingCall.listen(_onIncomingCall),
      _signaling.callAnswered.listen(_onCallAnswered),
      _signaling.iceCandidate.listen(_onIceCandidate),
      _signaling.callRejected.listen(_onCallRejected),
      _signaling.callBusy.listen(_onCallBusy),
      _signaling.callEnded.listen(_onCallEnded),
      _signaling.sfuFallback.listen(_onSfuFallback),
      _signaling.turnConfig.listen(_onTurnConfig),
      _signaling.error.listen(_onError),
      _webrtc.iceCandidate.listen(_onLocalIceCandidate),
      _webrtc.iceState.listen(_onIceStateChange),
    ]);

    debugPrint('[CallService] 已初始化');
  }

  // ============ 用户操作 ============

  // 错误消息流（供 UI 显示 Toast）
  final _errorMessageController = StreamController<String>.broadcast();
  Stream<String> get errorMessage => _errorMessageController.stream;

  /// 发起通话
  Future<void> startCall(String targetUserId, String targetName,
      String? targetAvatar, MediaType mediaType) async {
    if (_callState != CallState.idle) {
      debugPrint('[CallService] 当前不是空闲状态，无法发起通话');
      _errorMessageController.add('当前正在通话中');
      return;
    }

    if (!_signaling.isConnected) {
      debugPrint('[CallService] 信令服务未连接，无法发起通话');
      _errorMessageController.add('通话服务未连接，请检查网络');
      return;
    }

    final callId = DateTime.now().millisecondsSinceEpoch.toString();

    _currentCall = CurrentCall(
      callId: callId,
      peerId: targetUserId,
      peerName: targetName,
      peerAvatar: targetAvatar,
      mediaType: mediaType,
    );
    _setCallState(CallState.ringingOut);

    try {
      await _webrtc.getUserMedia(mediaType);
      await _webrtc.initPeerConnection();
      final sdp = await _webrtc.createOffer();

      _signaling.sendInvite(InviteData(
        callId: callId,
        targetUserId: targetUserId,
        mediaType: mediaType == MediaType.video ? 'video' : 'audio',
        sdp: sdp,
      ));

      debugPrint('[CallService] 已发起呼叫: $callId -> $targetUserId');
    } catch (e) {
      debugPrint('[CallService] 发起通话失败: $e');
      await _endCall();
    }
  }

  /// 接听来电
  Future<void> answerCall() async {
    if (_callState != CallState.ringingIn || _pendingIncoming == null) return;

    _setCallState(CallState.connecting);

    try {
      final incoming = _pendingIncoming!;
      final mediaType = incoming.mediaType == 'video' ? MediaType.video : MediaType.audio;

      await _webrtc.getUserMedia(mediaType);
      await _webrtc.initPeerConnection();
      debugPrint('[CallService] 接听中, Offer SDP长度: ${incoming.sdp.length}');
      final answerSdp = await _webrtc.handleOffer(incoming.sdp);

      _signaling.sendAnswer(AnswerData(
        callId: incoming.callId,
        sdp: answerSdp,
      ));

      _pendingIncoming = null;
      debugPrint('[CallService] 已接听: ${incoming.callId}');
    } catch (e) {
      debugPrint('[CallService] 接听失败: $e');
      await _endCall();
    }
  }

  /// 拒绝来电
  void rejectCall() {
    if (_callState != CallState.ringingIn || _currentCall == null) return;
    _signaling.sendReject(_currentCall!.callId);
    _endCall();
  }

  /// 挂断
  void hangUp() {
    if (_currentCall == null) return;
    _signaling.sendBye(_currentCall!.callId);
    _endCall();
  }

  /// 切换静音
  bool toggleMute() {
    if (_currentCall?.mode == CallMode.sfu) {
      return _livekit.toggleMute();
    }
    return _webrtc.toggleMute();
  }

  /// 切换视频
  bool toggleVideo() {
    if (_currentCall?.mode == CallMode.sfu) {
      return _livekit.toggleVideo();
    }
    return _webrtc.toggleVideo();
  }

  /// 切换摄像头
  Future<void> switchCamera() {
    if (_currentCall?.mode == CallMode.sfu) {
      return _livekit.switchCamera();
    }
    return _webrtc.switchCamera();
  }

  // ============ 信令事件处理 ============

  void _onIncomingCall(IncomingCallData data) {
    if (_callState != CallState.idle) {
      _signaling.sendBusy(data.callId);
      return;
    }

    _pendingIncoming = data;
    _currentCall = CurrentCall(
      callId: data.callId,
      peerId: data.callerUserId,
      peerName: data.callerName,
      peerAvatar: data.callerAvatar,
      mediaType: data.mediaType == 'video' ? MediaType.video : MediaType.audio,
    );
    _setCallState(CallState.ringingIn);
    debugPrint('[CallService] 来电: ${data.callId} from ${data.callerName}, SDP长度: ${data.sdp.length}');
  }

  Future<void> _onCallAnswered(AnswerData data) async {
    if (_callState != CallState.ringingOut) return;
    _setCallState(CallState.connecting);

    try {
      debugPrint('[CallService] 收到 Answer SDP长度: ${data.sdp.length}');
      await _webrtc.setRemoteAnswer(data.sdp);
      _setCallState(CallState.connected);
      _startCallTimer();
      debugPrint('[CallService] 对方已接听');
    } catch (e) {
      debugPrint('[CallService] 设置远程 Answer 失败: $e');
      await _endCall();
    }
  }

  void _onIceCandidate(ICEData data) {
    _webrtc.addIceCandidate(data.candidate);
  }

  void _onCallRejected(CallControlData data) {
    debugPrint('[CallService] 对方已拒绝');
    _endCall();
  }

  void _onCallBusy(CallControlData data) {
    debugPrint('[CallService] 对方忙线');
    _endCall();
  }

  void _onCallEnded(CallEndedData data) {
    debugPrint('[CallService] 通话结束: ${data.reason}');
    _endCall();
  }

  void _onSfuFallback(SFUFallbackData data) {
    debugPrint('[CallService] SFU 降级: ${data.livekitUrl}');
    _switchToSfu(data);
  }

  /// 执行 P2P → SFU 降级切换
  Future<void> _switchToSfu(SFUFallbackData data) async {
    if (_currentCall == null) return;

    debugPrint('[CallService] 正在从 P2P 切换到 SFU...');

    // 1. 清理 P2P WebRTC 资源
    await _webrtc.cleanup();

    // 2. 标记为 SFU 模式
    _currentCall!.mode = CallMode.sfu;
    _currentCallController.add(_currentCall);

    // 3. 连接 LiveKit Room
    try {
      await _livekit.connect(
        data.livekitUrl,
        data.token,
        _currentCall!.mediaType,
      );

      // 监听 LiveKit 断开事件
      _subscriptions.add(
        _livekit.disconnected.listen((_) {
          debugPrint('[CallService] LiveKit 断开');
          _endCall();
        }),
      );

      if (_callState != CallState.connected) {
        _setCallState(CallState.connected);
        _startCallTimer();
      }

      debugPrint('[CallService] SFU 降级完成');
    } catch (e) {
      debugPrint('[CallService] SFU 降级失败: $e');
      _errorMessageController.add('SFU 降级失败，通话已结束');
      await _endCall();
    }
  }

  void _onTurnConfig(TURNConfigData data) {
    _webrtc.updateTurnConfig(data);
  }

  void _onError(RtcErrorData data) {
    debugPrint('[CallService] 信令错误: [${data.code}] ${data.message}');
    if (_callState == CallState.ringingOut || _callState == CallState.connecting) {
      _endCall();
    }
  }

  // ============ 本地 WebRTC 事件 ============

  void _onLocalIceCandidate(RTCIceCandidate candidate) {
    if (_currentCall == null) return;
    final candidateJson = jsonEncode({
      'candidate': candidate.candidate,
      'sdpMid': candidate.sdpMid,
      'sdpMLineIndex': candidate.sdpMLineIndex,
    });
    _signaling.sendICE(ICEData(
      callId: _currentCall!.callId,
      candidate: candidateJson,
    ));
  }

  void _onIceStateChange(RTCIceConnectionState state) {
    if (state == RTCIceConnectionState.RTCIceConnectionStateConnected ||
        state == RTCIceConnectionState.RTCIceConnectionStateCompleted) {
      if (_callState == CallState.connecting) {
        _setCallState(CallState.connected);
        _startCallTimer();
      }
    } else if (state == RTCIceConnectionState.RTCIceConnectionStateFailed) {
      debugPrint('[CallService] ICE 失败，请求 SFU 降级');
      if (_currentCall != null) {
        _signaling.sendFallbackSFU(_currentCall!.callId);
      }
    }
  }

  // ============ 内部方法 ============

  void _setCallState(CallState state) {
    _callState = state;
    _callStateController.add(state);
    _currentCallController.add(_currentCall);

    // 铃声管理
    if (state == CallState.ringingIn) {
      _ringtone.playIncoming();
    } else if (state == CallState.ringingOut) {
      _ringtone.playOutgoing();
    } else {
      _ringtone.stop();
    }

    debugPrint('[CallService] 状态: $state');
  }

  void _startCallTimer() {
    _callTimer?.cancel();
    _callDuration = 0;
    _currentCall?.startTime = DateTime.now();
    _callTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _callDuration++;
      _callDurationController.add(_callDuration);
    });
  }

  Future<void> _endCall() async {
    _callTimer?.cancel();
    _callTimer = null;
    _callDuration = 0;
    _pendingIncoming = null;

    // 清理 P2P 和 SFU 资源
    await _webrtc.cleanup();
    await _livekit.disconnect();

    _currentCall = null;
    _setCallState(CallState.idle);
  }

  void _disposeSubscriptions() {
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();
  }

  void dispose() {
    _disposeSubscriptions();
    _callTimer?.cancel();
    _callStateController.close();
    _currentCallController.close();
    _callDurationController.close();
  }
}
