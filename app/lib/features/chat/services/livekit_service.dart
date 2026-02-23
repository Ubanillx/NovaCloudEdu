import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:livekit_client/livekit_client.dart';
import 'rtc_models.dart';

/// LiveKit SFU 服务 — 封装 Room 连接/发布/订阅
class LiveKitService {
  static final LiveKitService _instance = LiveKitService._internal();
  factory LiveKitService() => _instance;
  LiveKitService._internal();

  Room? _room;
  EventsListener<RoomEvent>? _listener;
  LocalParticipant? _localParticipant;

  bool _isMuted = false;
  bool _isVideoOff = false;
  bool _isFrontCamera = true;

  // 事件流
  final _remoteVideoTrackController = StreamController<VideoTrack?>.broadcast();
  final _localVideoTrackController = StreamController<VideoTrack?>.broadcast();
  final _connectionStateController = StreamController<ConnectionState>.broadcast();
  final _disconnectedController = StreamController<void>.broadcast();

  Stream<VideoTrack?> get remoteVideoTrack => _remoteVideoTrackController.stream;
  Stream<VideoTrack?> get localVideoTrack => _localVideoTrackController.stream;
  Stream<ConnectionState> get connectionState => _connectionStateController.stream;
  Stream<void> get disconnected => _disconnectedController.stream;

  Room? get room => _room;
  bool get isConnected => _room?.connectionState == ConnectionState.connected;
  bool get isMuted => _isMuted;
  bool get isVideoOff => _isVideoOff;

  /// 获取远程参与者的视频轨道
  VideoTrack? get currentRemoteVideoTrack {
    if (_room == null) return null;
    for (final participant in _room!.remoteParticipants.values) {
      for (final pub in participant.videoTrackPublications) {
        if (pub.subscribed && pub.track != null && !pub.muted) {
          return pub.track as VideoTrack;
        }
      }
    }
    return null;
  }

  /// 获取本地视频轨道
  VideoTrack? get currentLocalVideoTrack {
    if (_localParticipant == null) return null;
    for (final pub in _localParticipant!.videoTrackPublications) {
      if (pub.track != null) {
        return pub.track as VideoTrack;
      }
    }
    return null;
  }

  /// 连接 LiveKit Room
  Future<void> connect(String url, String token, MediaType mediaType) async {
    debugPrint('[LiveKit] 正在连接: $url');

    _room = Room(
      roomOptions: RoomOptions(
        adaptiveStream: true,
        dynacast: true,
        defaultAudioPublishOptions: const AudioPublishOptions(
          dtx: true,
        ),
        defaultVideoPublishOptions: const VideoPublishOptions(
          videoSimulcastLayers: [
            VideoParameters(dimensions: VideoDimensionsPresets.h180_169),
            VideoParameters(dimensions: VideoDimensionsPresets.h360_169),
          ],
        ),
      ),
    );

    // 监听事件
    _listener = _room!.createListener()
      ..on<RoomDisconnectedEvent>((event) {
        debugPrint('[LiveKit] 已断开: ${event.reason}');
        _disconnectedController.add(null);
      })
      ..on<TrackSubscribedEvent>((event) {
        debugPrint('[LiveKit] 订阅轨道: ${event.track.sid}');
        if (event.track is VideoTrack) {
          _remoteVideoTrackController.add(event.track as VideoTrack);
        }
      })
      ..on<TrackUnsubscribedEvent>((event) {
        if (event.track is VideoTrack) {
          _remoteVideoTrackController.add(null);
        }
      })
      ..on<ParticipantDisconnectedEvent>((event) {
        debugPrint('[LiveKit] 远程参与者离开: ${event.participant.identity}');
        _remoteVideoTrackController.add(null);
      });

    _room!.addListener(_onRoomChanged);

    try {
      await _room!.connect(url, token);
      _localParticipant = _room!.localParticipant;

      // 发布音频
      await _localParticipant?.setMicrophoneEnabled(true);

      // 视频通话时发布视频
      if (mediaType == MediaType.video) {
        try {
          await _localParticipant?.setCameraEnabled(true);
          _localVideoTrackController.add(currentLocalVideoTrack);
        } catch (e) {
          debugPrint('[LiveKit] 发布视频失败: $e');
        }
      }

      debugPrint('[LiveKit] 已连接, 参与者: ${_room!.remoteParticipants.length}');
    } catch (e) {
      debugPrint('[LiveKit] 连接失败: $e');
      rethrow;
    }
  }

  void _onRoomChanged() {
    if (_room != null) {
      _connectionStateController.add(_room!.connectionState);
    }
  }

  /// 切换静音
  bool toggleMute() {
    _isMuted = !_isMuted;
    _localParticipant?.setMicrophoneEnabled(!_isMuted);
    debugPrint('[LiveKit] 静音: $_isMuted');
    return _isMuted;
  }

  /// 切换视频
  bool toggleVideo() {
    _isVideoOff = !_isVideoOff;
    _localParticipant?.setCameraEnabled(!_isVideoOff);
    _localVideoTrackController.add(_isVideoOff ? null : currentLocalVideoTrack);
    debugPrint('[LiveKit] 视频关闭: $_isVideoOff');
    return _isVideoOff;
  }

  /// 切换摄像头
  Future<void> switchCamera() async {
    if (_localParticipant != null) {
      for (final pub in _localParticipant!.videoTrackPublications) {
        if (pub.track != null) {
          final track = pub.track as LocalVideoTrack;
          try {
            _isFrontCamera = !_isFrontCamera;
            final newPosition = _isFrontCamera
                ? CameraPosition.front
                : CameraPosition.back;
            await track.setCameraPosition(newPosition);
            debugPrint('[LiveKit] 切换摄像头: $newPosition');
          } catch (e) {
            _isFrontCamera = !_isFrontCamera; // 回滚
            debugPrint('[LiveKit] 切换摄像头失败: $e');
          }
          break;
        }
      }
    }
  }

  /// 断开连接并清理
  Future<void> disconnect() async {
    debugPrint('[LiveKit] 断开连接');

    _listener?.dispose();
    _listener = null;

    _room?.removeListener(_onRoomChanged);
    await _room?.disconnect();
    await _room?.dispose();
    _room = null;
    _localParticipant = null;

    _isMuted = false;
    _isVideoOff = false;

    _remoteVideoTrackController.add(null);
    _localVideoTrackController.add(null);
  }

  void dispose() {
    disconnect();
    _remoteVideoTrackController.close();
    _localVideoTrackController.close();
    _connectionStateController.close();
    _disconnectedController.close();
  }
}
