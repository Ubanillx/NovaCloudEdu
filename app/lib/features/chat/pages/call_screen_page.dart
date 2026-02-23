import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:livekit_client/livekit_client.dart' as lk;
import '../../../config/app_theme.dart';
import '../services/rtc_models.dart';
import '../services/call_service.dart';

/// 通话界面
class CallScreenPage extends StatefulWidget {
  const CallScreenPage({super.key});

  @override
  State<CallScreenPage> createState() => _CallScreenPageState();
}

class _CallScreenPageState extends State<CallScreenPage> {
  final _callService = CallService();

  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  final List<StreamSubscription> _subscriptions = [];

  CallState _callState = CallState.idle;
  CurrentCall? _currentCall;
  int _duration = 0;
  bool _isMuted = false;
  bool _isVideoOff = false;

  // LiveKit SFU 视频轨道
  lk.VideoTrack? _lkRemoteVideoTrack;
  lk.VideoTrack? _lkLocalVideoTrack;

  // 本地小窗拖拽位置
  Offset _localVideoOffset = const Offset(16, 80);

  @override
  void initState() {
    super.initState();
    _initRenderers();
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();

    // 绑定已有的流
    final localStream = _callService.webrtc.currentLocalStream;
    if (localStream != null) {
      _localRenderer.srcObject = localStream;
    }
    final remoteStream = _callService.webrtc.currentRemoteStream;
    if (remoteStream != null) {
      _remoteRenderer.srcObject = remoteStream;
    }

    _callState = _callService.callState;
    _currentCall = _callService.currentCall;
    _isMuted = _callService.webrtc.isMuted;
    _isVideoOff = _callService.webrtc.isVideoOff;
    _bindStreams();
    if (mounted) setState(() {});
  }

  void _bindStreams() {
    _subscriptions.addAll([
      _callService.callStateStream.listen((state) {
        if (mounted) {
          setState(() => _callState = state);
          if (state == CallState.ended || state == CallState.idle) {
            Navigator.of(context).pop();
          }
        }
      }),
      _callService.currentCallStream.listen((call) {
        if (mounted) setState(() => _currentCall = call);
      }),
      _callService.callDurationStream.listen((d) {
        if (mounted) setState(() => _duration = d);
      }),
      _callService.webrtc.localStream.listen((stream) {
        _localRenderer.srcObject = stream;
        if (mounted) setState(() {});
      }),
      _callService.webrtc.remoteStream.listen((stream) {
        _remoteRenderer.srcObject = stream;
        if (mounted) setState(() {});
      }),
      // LiveKit SFU 视频轨道
      _callService.livekit.remoteVideoTrack.listen((track) {
        if (mounted) setState(() => _lkRemoteVideoTrack = track);
      }),
      _callService.livekit.localVideoTrack.listen((track) {
        if (mounted) setState(() => _lkLocalVideoTrack = track);
      }),
    ]);

    // 初始化 LiveKit 已有轨道
    _lkRemoteVideoTrack = _callService.livekit.currentRemoteVideoTrack;
    _lkLocalVideoTrack = _callService.livekit.currentLocalVideoTrack;
  }

  @override
  void dispose() {
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  String _formatDuration(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  String get _statusText {
    switch (_callState) {
      case CallState.ringingOut:
        return '正在呼叫...';
      case CallState.ringingIn:
        return '来电中...';
      case CallState.connecting:
        return '连接中...';
      case CallState.connected:
        return _formatDuration(_duration);
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isVideo = _currentCall?.mediaType == MediaType.video;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // 主内容
            if (isVideo) _buildVideoUI() else _buildAudioUI(),

            // 底部控制栏
            Positioned(
              left: 0,
              right: 0,
              bottom: 40,
              child: _buildControls(isVideo),
            ),
          ],
        ),
      ),
    );
  }

  // ============ 视频模式 ============

  bool get _isSfuMode => _currentCall?.mode == CallMode.sfu;

  Widget _buildVideoUI() {
    return Stack(
      children: [
        // 远程视频（全屏）
        Positioned.fill(child: _buildRemoteVideo()),

        // 状态文字 + SFU 标识
        Positioned(
          top: 16,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isSfuMode) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('SFU', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    _statusText,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),

        // 本地小窗（可拖拽）
        if (_hasLocalVideo())
          Positioned(
            left: _localVideoOffset.dx,
            top: _localVideoOffset.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _localVideoOffset += details.delta;
                });
              },
              child: Container(
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white30, width: 1),
                ),
                clipBehavior: Clip.antiAlias,
                child: _buildLocalVideo(),
              ),
            ),
          ),
      ],
    );
  }

  bool _hasLocalVideo() {
    if (_isSfuMode) return _lkLocalVideoTrack != null;
    return _localRenderer.srcObject != null;
  }

  Widget _buildRemoteVideo() {
    if (_isSfuMode) {
      if (_lkRemoteVideoTrack != null) {
        return lk.VideoTrackRenderer(
          _lkRemoteVideoTrack!,
          fit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
          mirrorMode: lk.VideoViewMirrorMode.mirror,
        );
      }
      return _buildWaitingUI();
    }
    // P2P 模式
    if (_remoteRenderer.srcObject != null) {
      return RTCVideoView(
        _remoteRenderer,
        mirror: true,
        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
      );
    }
    return _buildWaitingUI();
  }

  Widget _buildLocalVideo() {
    if (_isSfuMode && _lkLocalVideoTrack != null) {
      return lk.VideoTrackRenderer(
        _lkLocalVideoTrack!,
        fit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        mirrorMode: lk.VideoViewMirrorMode.mirror,
      );
    }
    return RTCVideoView(
      _localRenderer,
      mirror: true,
      objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
    );
  }

  // ============ 音频模式 ============

  Widget _buildAudioUI() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 头像
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.brand.withOpacity(0.15),
            ),
            child: _currentCall?.peerAvatar != null &&
                    _currentCall!.peerAvatar!.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      _currentCall!.peerAvatar!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.person, color: Colors.white54, size: 50),
                    ),
                  )
                : const Icon(Icons.person, color: Colors.white54, size: 50),
          ),
          const SizedBox(height: 20),

          // 名字
          Text(
            _currentCall?.peerName ?? '未知用户',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),

          // 状态
          Text(
            _statusText,
            style: const TextStyle(color: Colors.white60, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // ============ 等待连接 ============

  Widget _buildWaitingUI() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1),
            ),
            child: _currentCall?.peerAvatar != null &&
                    _currentCall!.peerAvatar!.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      _currentCall!.peerAvatar!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.person, color: Colors.white38, size: 40),
                    ),
                  )
                : const Icon(Icons.person, color: Colors.white38, size: 40),
          ),
          const SizedBox(height: 16),
          Text(
            _currentCall?.peerName ?? '',
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            _statusText,
            style: const TextStyle(color: Colors.white60, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // ============ 控制栏 ============

  Widget _buildControls(bool isVideo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 静音
        _buildControlButton(
          icon: _isMuted ? Icons.mic_off : Icons.mic,
          label: _isMuted ? '取消静音' : '静音',
          isActive: _isMuted,
          onTap: () {
            setState(() => _isMuted = _callService.toggleMute());
          },
        ),

        // 视频开关（仅视频模式）
        if (isVideo)
          _buildControlButton(
            icon: _isVideoOff ? Icons.videocam_off : Icons.videocam,
            label: _isVideoOff ? '开启视频' : '关闭视频',
            isActive: _isVideoOff,
            onTap: () {
              setState(() => _isVideoOff = _callService.toggleVideo());
            },
          ),

        // 切换摄像头（仅视频模式）
        if (isVideo)
          _buildControlButton(
            icon: Icons.cameraswitch,
            label: '翻转',
            onTap: () => _callService.switchCamera(),
          ),

        // 挂断
        _buildControlButton(
          icon: Icons.call_end,
          label: '挂断',
          color: const Color(0xFFEF4444),
          iconColor: Colors.white,
          onTap: () => _callService.hangUp(),
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    bool isActive = false,
    Color? color,
    Color? iconColor,
    required VoidCallback onTap,
  }) {
    final bgColor = color ?? (isActive ? Colors.white : Colors.white24);
    final fgColor = iconColor ?? (isActive ? Colors.black87 : Colors.white);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
            ),
            child: Icon(icon, color: fgColor, size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
