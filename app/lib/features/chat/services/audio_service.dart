import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// 录音状态
enum RecordingState {
  idle,
  recording,
  paused,
}

/// 播放状态
enum PlayingState {
  idle,
  playing,
  paused,
}

/// 音频服务 - 录音和播放
class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();
  
  RecordingState _recordingState = RecordingState.idle;
  PlayingState _playingState = PlayingState.idle;
  String? _currentRecordingPath;
  String? _currentPlayingUrl;
  
  // 录音时长计时器
  Timer? _recordingTimer;
  int _recordingDuration = 0;
  
  // 状态流
  final _recordingStateController = StreamController<RecordingState>.broadcast();
  final _playingStateController = StreamController<PlayingState>.broadcast();
  final _recordingDurationController = StreamController<int>.broadcast();
  final _playingPositionController = StreamController<Duration>.broadcast();
  
  /// 录音状态流
  Stream<RecordingState> get recordingState => _recordingStateController.stream;
  
  /// 播放状态流
  Stream<PlayingState> get playingState => _playingStateController.stream;
  
  /// 录音时长流（秒）
  Stream<int> get recordingDuration => _recordingDurationController.stream;
  
  /// 播放进度流
  Stream<Duration> get playingPosition => _playingPositionController.stream;
  
  /// 当前录音状态
  RecordingState get currentRecordingState => _recordingState;
  
  /// 当前播放状态
  PlayingState get currentPlayingState => _playingState;
  
  /// 当前录音时长（秒）
  int get currentRecordingDuration => _recordingDuration;

  /// 初始化
  Future<void> init() async {
    // 监听播放状态
    _player.onPlayerStateChanged.listen((state) {
      switch (state) {
        case PlayerState.playing:
          _playingState = PlayingState.playing;
          break;
        case PlayerState.paused:
          _playingState = PlayingState.paused;
          break;
        case PlayerState.stopped:
        case PlayerState.completed:
        case PlayerState.disposed:
          _playingState = PlayingState.idle;
          _currentPlayingUrl = null;
          break;
      }
      _playingStateController.add(_playingState);
    });

    // 监听播放进度
    _player.onPositionChanged.listen((position) {
      _playingPositionController.add(position);
    });
  }

  /// 请求录音权限
  Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  /// 检查录音权限
  Future<bool> hasMicrophonePermission() async {
    return await Permission.microphone.isGranted;
  }

  /// 开始录音
  Future<bool> startRecording() async {
    try {
      // 检查权限
      if (!await hasMicrophonePermission()) {
        final granted = await requestMicrophonePermission();
        if (!granted) {
          debugPrint('录音权限被拒绝');
          return false;
        }
      }

      // 检查是否支持录音
      final hasPermission = await _recorder.hasPermission();
      if (!hasPermission) {
        debugPrint('录音器没有权限');
        return false;
      }

      // 获取临时目录
      final directory = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      _currentRecordingPath = '${directory.path}/audio_$timestamp.m4a';

      // 开始录音
      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
        ),
        path: _currentRecordingPath!,
      );

      _recordingState = RecordingState.recording;
      _recordingStateController.add(_recordingState);
      
      // 开始计时
      _recordingDuration = 0;
      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _recordingDuration++;
        _recordingDurationController.add(_recordingDuration);
      });

      debugPrint('开始录音: $_currentRecordingPath');
      return true;
    } catch (e) {
      debugPrint('开始录音失败: $e');
      return false;
    }
  }

  /// 停止录音并返回文件路径
  Future<String?> stopRecording() async {
    try {
      _recordingTimer?.cancel();
      _recordingTimer = null;

      final path = await _recorder.stop();
      
      _recordingState = RecordingState.idle;
      _recordingStateController.add(_recordingState);

      if (path != null && File(path).existsSync()) {
        debugPrint('录音完成: $path, 时长: $_recordingDuration秒');
        return path;
      }
      return null;
    } catch (e) {
      debugPrint('停止录音失败: $e');
      _recordingState = RecordingState.idle;
      _recordingStateController.add(_recordingState);
      return null;
    }
  }

  /// 取消录音
  Future<void> cancelRecording() async {
    try {
      _recordingTimer?.cancel();
      _recordingTimer = null;

      await _recorder.stop();
      
      // 删除录音文件
      if (_currentRecordingPath != null) {
        final file = File(_currentRecordingPath!);
        if (file.existsSync()) {
          await file.delete();
        }
      }
      
      _recordingState = RecordingState.idle;
      _recordingStateController.add(_recordingState);
      _currentRecordingPath = null;
      _recordingDuration = 0;
      
      debugPrint('录音已取消');
    } catch (e) {
      debugPrint('取消录音失败: $e');
    }
  }

  /// 播放音频
  Future<void> play(String url) async {
    try {
      // 如果正在播放其他音频，先停止
      if (_playingState == PlayingState.playing && _currentPlayingUrl != url) {
        await stop();
      }

      _currentPlayingUrl = url;
      
      if (url.startsWith('http://') || url.startsWith('https://')) {
        await _player.play(UrlSource(url));
      } else {
        await _player.play(DeviceFileSource(url));
      }
      
      debugPrint('开始播放: $url');
    } catch (e) {
      debugPrint('播放失败: $e');
    }
  }

  /// 暂停播放
  Future<void> pause() async {
    try {
      await _player.pause();
    } catch (e) {
      debugPrint('暂停失败: $e');
    }
  }

  /// 恢复播放
  Future<void> resume() async {
    try {
      await _player.resume();
    } catch (e) {
      debugPrint('恢复播放失败: $e');
    }
  }

  /// 停止播放
  Future<void> stop() async {
    try {
      await _player.stop();
      _currentPlayingUrl = null;
    } catch (e) {
      debugPrint('停止播放失败: $e');
    }
  }

  /// 获取音频时长
  Future<Duration?> getAudioDuration(String url) async {
    try {
      if (url.startsWith('http://') || url.startsWith('https://')) {
        await _player.setSource(UrlSource(url));
      } else {
        await _player.setSource(DeviceFileSource(url));
      }
      return await _player.getDuration();
    } catch (e) {
      debugPrint('获取音频时长失败: $e');
      return null;
    }
  }

  /// 是否正在播放指定URL
  bool isPlaying(String url) {
    return _playingState == PlayingState.playing && _currentPlayingUrl == url;
  }

  /// 释放资源
  void dispose() {
    _recordingTimer?.cancel();
    _recorder.dispose();
    _player.dispose();
    _recordingStateController.close();
    _playingStateController.close();
    _recordingDurationController.close();
    _playingPositionController.close();
  }
}
