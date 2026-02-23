import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

/// 相机 OCR 服务 — 封装 ML Kit 文字识别
class CameraOcrService {
  static CameraOcrService? _instance;
  factory CameraOcrService() => _instance ??= CameraOcrService._();
  CameraOcrService._();

  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.chinese);

  bool _isProcessing = false;
  DateTime _lastProcessTime = DateTime.now();

  /// 节流间隔（毫秒）
  static const int _throttleMs = 500;

  /// 处理相机帧，返回识别到的文字块
  /// 内置节流逻辑，避免频繁调用
  Future<List<TextBlock>?> processFrame(CameraImage image, CameraDescription camera) async {
    if (_isProcessing) return null;

    final now = DateTime.now();
    if (now.difference(_lastProcessTime).inMilliseconds < _throttleMs) return null;

    _isProcessing = true;
    _lastProcessTime = now;

    try {
      final inputImage = _convertCameraImage(image, camera);
      if (inputImage == null) {
        _isProcessing = false;
        return null;
      }

      final recognized = await _textRecognizer.processImage(inputImage);
      _isProcessing = false;
      return recognized.blocks;
    } catch (e) {
      debugPrint('OCR 帧处理失败: $e');
      _isProcessing = false;
      return null;
    }
  }

  /// 处理静态图片文件
  Future<List<TextBlock>> processImageFile(File file) async {
    try {
      final inputImage = InputImage.fromFile(file);
      final recognized = await _textRecognizer.processImage(inputImage);
      return recognized.blocks;
    } catch (e) {
      debugPrint('OCR 图片处理失败: $e');
      return [];
    }
  }

  /// 根据文字块计算建议裁切区域
  static Rect? computeAutoCropRect(List<TextBlock> blocks, Size imageSize) {
    if (blocks.isEmpty) return null;

    double left = double.infinity, top = double.infinity;
    double right = 0, bottom = 0;

    for (final block in blocks) {
      final rect = block.boundingBox;
      left = min(left, rect.left);
      top = min(top, rect.top);
      right = max(right, rect.right);
      bottom = max(bottom, rect.bottom);
    }

    // 扩展 5% 边距
    final padX = (right - left) * 0.05;
    final padY = (bottom - top) * 0.05;

    return Rect.fromLTRB(
      max(0, left - padX),
      max(0, top - padY),
      min(imageSize.width, right + padX),
      min(imageSize.height, bottom + padY),
    );
  }

  /// 转换相机帧为 ML Kit InputImage
  InputImage? _convertCameraImage(CameraImage image, CameraDescription camera) {
    final sensorOrientation = camera.sensorOrientation;

    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotation.values.firstWhere(
        (r) => r.rawValue == sensorOrientation,
        orElse: () => InputImageRotation.rotation0deg,
      );
    } else if (Platform.isAndroid) {
      rotation = InputImageRotation.values.firstWhere(
        (r) => r.rawValue == sensorOrientation,
        orElse: () => InputImageRotation.rotation0deg,
      );
    }

    if (rotation == null) return null;

    final format = Platform.isAndroid
        ? InputImageFormat.yuv_420_888
        : InputImageFormat.bgra8888;

    if (image.planes.isEmpty) return null;

    return InputImage.fromBytes(
      bytes: _concatenatePlanes(image.planes),
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: image.planes.first.bytesPerRow,
      ),
    );
  }

  Uint8List _concatenatePlanes(List<Plane> planes) {
    final allBytes = WriteBuffer();
    for (final plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  /// 释放资源
  Future<void> dispose() async {
    await _textRecognizer.close();
    _instance = null;
  }
}
