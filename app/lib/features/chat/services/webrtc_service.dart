import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'rtc_models.dart';

/// WebRTC 管理服务 — 封装 RTCPeerConnection 生命周期
class WebRTCService {
  static final WebRTCService _instance = WebRTCService._internal();
  factory WebRTCService() => _instance;
  WebRTCService._internal();

  RTCPeerConnection? _pc;
  MediaStream? _localStream;
  MediaStream? _remoteStream;

  bool _isMuted = false;
  bool _isVideoOff = false;
  bool _isFrontCamera = true;
  final List<String> _pendingCandidates = [];

  // ICE 服务器配置（TURN 由信令推送后动态更新）
  final List<Map<String, dynamic>> _iceServers = [
    {'urls': ['stun:stun.l.google.com:19302']},
  ];

  // 事件流
  final _remoteStreamController = StreamController<MediaStream?>.broadcast();
  final _localStreamController = StreamController<MediaStream?>.broadcast();
  final _iceStateController = StreamController<RTCIceConnectionState>.broadcast();
  final _iceCandidateController = StreamController<RTCIceCandidate>.broadcast();

  Stream<MediaStream?> get remoteStream => _remoteStreamController.stream;
  Stream<MediaStream?> get localStream => _localStreamController.stream;
  Stream<RTCIceConnectionState> get iceState => _iceStateController.stream;
  Stream<RTCIceCandidate> get iceCandidate => _iceCandidateController.stream;

  MediaStream? get currentLocalStream => _localStream;
  MediaStream? get currentRemoteStream => _remoteStream;
  bool get isMuted => _isMuted;
  bool get isVideoOff => _isVideoOff;

  /// 更新 TURN 服务器配置
  void updateTurnConfig(TURNConfigData config) {
    for (final url in config.urls) {
      _iceServers.add({
        'urls': [url],
        'username': config.username,
        'credential': config.credential,
      });
    }
    debugPrint('[WebRTC] TURN 配置已更新: ${config.urls}');
  }

  /// 获取本地媒体流
  Future<MediaStream> getUserMedia(MediaType mediaType) async {
    final constraints = <String, dynamic>{
      'audio': true,
      'video': mediaType == MediaType.video
          ? {'facingMode': 'user', 'width': 640, 'height': 480}
          : false,
    };

    _localStream = await navigator.mediaDevices.getUserMedia(constraints);
    _localStreamController.add(_localStream);
    debugPrint('[WebRTC] 获取本地媒体流: audio=true, video=${mediaType == MediaType.video}');
    return _localStream!;
  }

  /// 创建 PeerConnection
  Future<void> initPeerConnection() async {
    final config = {
      'iceServers': _iceServers,
      'sdpSemantics': 'unified-plan',
    };

    _pc = await createPeerConnection(config, {});

    // 添加本地流轨道
    if (_localStream != null) {
      for (final track in _localStream!.getTracks()) {
        await _pc!.addTrack(track, _localStream!);
      }
    }

    // 监听远程流
    _pc!.onTrack = (RTCTrackEvent event) {
      if (event.streams.isNotEmpty) {
        _remoteStream = event.streams[0];
        _remoteStreamController.add(_remoteStream);
        debugPrint('[WebRTC] 收到远程流');
      }
    };

    // 监听 ICE candidate
    _pc!.onIceCandidate = (RTCIceCandidate candidate) {
      _iceCandidateController.add(candidate);
    };

    // 监听 ICE 连接状态
    _pc!.onIceConnectionState = (RTCIceConnectionState state) {
      debugPrint('[WebRTC] ICE 状态: $state');
      _iceStateController.add(state);
    };

    _pc!.onConnectionState = (RTCPeerConnectionState state) {
      debugPrint('[WebRTC] 连接状态: $state');
    };

    debugPrint('[WebRTC] PeerConnection 已创建');
  }

  /// 创建 Offer
  Future<String> createOffer() async {
    if (_pc == null) throw StateError('PeerConnection 未创建');

    final offer = await _pc!.createOffer({
      'offerToReceiveAudio': true,
      'offerToReceiveVideo': true,
    });
    await _pc!.setLocalDescription(offer);
    debugPrint('[WebRTC] Offer 已创建');
    return offer.sdp ?? '';
  }

  /// 设置远程 Offer 并创建 Answer
  Future<String> handleOffer(String sdp) async {
    if (_pc == null) throw StateError('PeerConnection 未创建');
    if (sdp.isEmpty) throw StateError('Offer SDP 为空，无法设置远程描述');
    debugPrint('[WebRTC] handleOffer SDP 长度: ${sdp.length}');

    await _pc!.setRemoteDescription(RTCSessionDescription(sdp, 'offer'));
    await _flushPendingCandidates();
    final answer = await _pc!.createAnswer({});
    await _pc!.setLocalDescription(answer);
    debugPrint('[WebRTC] Answer 已创建');
    return answer.sdp ?? '';
  }

  /// 设置远程 Answer
  Future<void> setRemoteAnswer(String sdp) async {
    if (_pc == null) return;
    if (sdp.isEmpty) {
      debugPrint('[WebRTC] Answer SDP 为空，跳过 setRemoteDescription');
      return;
    }
    debugPrint('[WebRTC] setRemoteAnswer SDP 长度: ${sdp.length}');
    await _pc!.setRemoteDescription(RTCSessionDescription(sdp, 'answer'));
    await _flushPendingCandidates();
    debugPrint('[WebRTC] 远程 Answer 已设置');
  }

  /// 添加远程 ICE Candidate（PC 未创建或远程描述未设置时缓冲）
  Future<void> addIceCandidate(String candidateJson) async {
    if (_pc == null) {
      _pendingCandidates.add(candidateJson);
      return;
    }
    final remoteDesc = await _pc!.getRemoteDescription();
    if (remoteDesc == null) {
      _pendingCandidates.add(candidateJson);
      return;
    }
    try {
      final json = jsonDecode(candidateJson) as Map<String, dynamic>;
      final candidate = RTCIceCandidate(
        json['candidate'] as String?,
        json['sdpMid'] as String?,
        json['sdpMLineIndex'] as int?,
      );
      await _pc!.addCandidate(candidate);
    } catch (e) {
      debugPrint('[WebRTC] 添加 ICE candidate 失败: $e');
    }
  }

  /// 刷新缓冲的 ICE 候选
  Future<void> _flushPendingCandidates() async {
    if (_pendingCandidates.isEmpty) return;
    debugPrint('[WebRTC] 刷新 ${_pendingCandidates.length} 个缓冲的 ICE 候选');
    final candidates = List<String>.from(_pendingCandidates);
    _pendingCandidates.clear();
    for (final c in candidates) {
      await addIceCandidate(c);
    }
  }

  /// 切换静音
  bool toggleMute() {
    _isMuted = !_isMuted;
    if (_localStream != null) {
      for (final track in _localStream!.getAudioTracks()) {
        track.enabled = !_isMuted;
      }
    }
    debugPrint('[WebRTC] 静音: $_isMuted');
    return _isMuted;
  }

  /// 切换视频
  bool toggleVideo() {
    _isVideoOff = !_isVideoOff;
    if (_localStream != null) {
      for (final track in _localStream!.getVideoTracks()) {
        track.enabled = !_isVideoOff;
      }
    }
    debugPrint('[WebRTC] 视频关闭: $_isVideoOff');
    return _isVideoOff;
  }

  /// 切换摄像头
  Future<void> switchCamera() async {
    if (_localStream != null) {
      final videoTracks = _localStream!.getVideoTracks();
      if (videoTracks.isNotEmpty) {
        await Helper.switchCamera(videoTracks[0]);
        _isFrontCamera = !_isFrontCamera;
        debugPrint('[WebRTC] 切换摄像头: ${_isFrontCamera ? "前置" : "后置"}');
      }
    }
  }

  /// 清理资源
  Future<void> cleanup() async {
    debugPrint('[WebRTC] 清理资源');

    _localStream?.getTracks().forEach((track) => track.stop());
    _localStream?.dispose();
    _localStream = null;
    _localStreamController.add(null);

    _remoteStream?.dispose();
    _remoteStream = null;
    _remoteStreamController.add(null);

    await _pc?.close();
    _pc = null;

    _isMuted = false;
    _isVideoOff = false;
    _isFrontCamera = true;
    _pendingCandidates.clear();

    // 重置 TURN 配置
    _iceServers.removeWhere((s) => s.containsKey('username'));
  }

  /// 释放所有资源
  void dispose() {
    cleanup();
    _remoteStreamController.close();
    _localStreamController.close();
    _iceStateController.close();
    _iceCandidateController.close();
  }
}
