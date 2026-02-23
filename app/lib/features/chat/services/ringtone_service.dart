import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// 铃声服务 - 使用 audioplayers 播放程序生成的铃声
/// 无需外部音频文件，运行时生成 WAV 数据
class RingtoneService {
  static final RingtoneService _instance = RingtoneService._();
  factory RingtoneService() => _instance;
  RingtoneService._();

  AudioPlayer? _player;
  bool _isPlaying = false;

  String? _tempFilePath;

  /// 播放来电铃声（双音节 beep-beep，循环）
  Future<void> playIncoming() async {
    await stop();
    try {
      final wav = _generateTone(
        frequency: 880,
        segments: [
          _ToneSegment(0.0, 0.15, true),
          _ToneSegment(0.15, 0.25, false),
          _ToneSegment(0.25, 0.40, true),
          _ToneSegment(0.40, 2.5, false),
        ],
        totalDuration: 2.5,
      );
      await _playWav(wav, 'ringtone_incoming.wav');
      debugPrint('[Ringtone] 来电铃声播放中');
    } catch (e) {
      debugPrint('[Ringtone] 播放来电铃声失败: $e');
    }
  }

  /// 播放去电回铃音（长音 1s，间隔 3s，循环）
  Future<void> playOutgoing() async {
    await stop();
    try {
      final wav = _generateTone(
        frequency: 440,
        segments: [
          _ToneSegment(0.0, 1.0, true),
          _ToneSegment(1.0, 4.0, false),
        ],
        totalDuration: 4.0,
      );
      await _playWav(wav, 'ringtone_outgoing.wav');
      debugPrint('[Ringtone] 去电回铃音播放中');
    } catch (e) {
      debugPrint('[Ringtone] 播放去电回铃音失败: $e');
    }
  }

  /// 将 WAV 写入临时文件并播放
  Future<void> _playWav(Uint8List wavData, String filename) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(wavData, flush: true);
    _tempFilePath = file.path;

    _player = AudioPlayer();
    await _player!.setReleaseMode(ReleaseMode.loop);
    await _player!.play(DeviceFileSource(file.path));
    _isPlaying = true;
  }

  /// 停止铃声
  Future<void> stop() async {
    if (_player != null) {
      try {
        await _player!.stop();
        await _player!.dispose();
      } catch (_) {}
      _player = null;
    }
    _isPlaying = false;
    // 清理临时文件
    if (_tempFilePath != null) {
      try {
        final f = File(_tempFilePath!);
        if (await f.exists()) await f.delete();
      } catch (_) {}
      _tempFilePath = null;
    }
  }

  bool get isPlaying => _isPlaying;

  /// 生成 WAV 格式的音频数据
  Uint8List _generateTone({
    required double frequency,
    required List<_ToneSegment> segments,
    required double totalDuration,
  }) {
    const sampleRate = 44100;
    const bitsPerSample = 16;
    const channels = 1;
    final numSamples = (sampleRate * totalDuration).toInt();
    final samples = Int16List(numSamples);

    for (int i = 0; i < numSamples; i++) {
      final t = i / sampleRate;
      double amplitude = 0;

      for (final seg in segments) {
        if (t >= seg.start && t < seg.end && seg.hasSound) {
          // 正弦波 + 淡入淡出
          final segDuration = seg.end - seg.start;
          final segT = t - seg.start;
          double envelope = 1.0;
          if (segT < 0.01) {
            envelope = segT / 0.01; // 淡入
          } else if (segT > segDuration - 0.01) {
            envelope = (segDuration - segT) / 0.01; // 淡出
          }
          amplitude = sin(2 * pi * frequency * t) * 0.4 * envelope;
          break;
        }
      }

      samples[i] = (amplitude * 32767).toInt().clamp(-32768, 32767);
    }

    // 构建 WAV 文件头
    final dataSize = numSamples * (bitsPerSample ~/ 8);
    final fileSize = 36 + dataSize;
    final buffer = ByteData(44 + dataSize);

    // RIFF header
    buffer.setUint8(0, 0x52); // R
    buffer.setUint8(1, 0x49); // I
    buffer.setUint8(2, 0x46); // F
    buffer.setUint8(3, 0x46); // F
    buffer.setUint32(4, fileSize, Endian.little);
    buffer.setUint8(8, 0x57); // W
    buffer.setUint8(9, 0x41); // A
    buffer.setUint8(10, 0x56); // V
    buffer.setUint8(11, 0x45); // E

    // fmt chunk
    buffer.setUint8(12, 0x66); // f
    buffer.setUint8(13, 0x6D); // m
    buffer.setUint8(14, 0x74); // t
    buffer.setUint8(15, 0x20); // space
    buffer.setUint32(16, 16, Endian.little);
    buffer.setUint16(20, 1, Endian.little); // PCM
    buffer.setUint16(22, channels, Endian.little);
    buffer.setUint32(24, sampleRate, Endian.little);
    buffer.setUint32(
        28, sampleRate * channels * bitsPerSample ~/ 8, Endian.little);
    buffer.setUint16(32, channels * bitsPerSample ~/ 8, Endian.little);
    buffer.setUint16(34, bitsPerSample, Endian.little);

    // data chunk
    buffer.setUint8(36, 0x64); // d
    buffer.setUint8(37, 0x61); // a
    buffer.setUint8(38, 0x74); // t
    buffer.setUint8(39, 0x61); // a
    buffer.setUint32(40, dataSize, Endian.little);

    for (int i = 0; i < numSamples; i++) {
      buffer.setInt16(44 + i * 2, samples[i], Endian.little);
    }

    return buffer.buffer.asUint8List();
  }
}

class _ToneSegment {
  final double start;
  final double end;
  final bool hasSound;

  const _ToneSegment(this.start, this.end, this.hasSound);
}
