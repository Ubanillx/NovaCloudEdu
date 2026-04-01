import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/network/api_client.dart';
import '../../../services/file_upload_service.dart';

/// OCR 识别的文字块（含坐标）
class TextBlock {
  final Rect boundingBox;
  final String text;
  final double confidence;
  TextBlock({required this.boundingBox, this.text = '', this.confidence = 0.0});
}

/// 相机 OCR 服务 — 服务端百度OCR方案
/// 拍照后上传图片到 OSS，调用后端 /api/grading/ocr/detect 获取文字块+坐标
class CameraOcrService {
  static CameraOcrService? _instance;
  factory CameraOcrService() => _instance ??= CameraOcrService._();
  CameraOcrService._();

  final Dio _dio = ApiClient.instance.dio;
  final _fileUploadService = FileUploadService();

  /// 处理静态图片文件 — 上传到 OSS 后调用后端 OCR
  /// [file] 可以是 File 或 XFile
  Future<List<TextBlock>> processImageFile(dynamic file) async {
    try {
      // 上传图片到 OSS
      XFile xFile;
      if (file is XFile) {
        xFile = file;
      } else if (file is File) {
        xFile = XFile(file.path);
      } else {
        debugPrint('OCR: 不支持的文件类型 ${file.runtimeType}');
        return [];
      }

      final uploadResult = await _fileUploadService.uploadFile(xFile, 'grading/ocr');
      if (uploadResult?.fileUrl == null) {
        debugPrint('OCR: 图片上传失败');
        return [];
      }

      debugPrint('OCR: 图片已上传 ${uploadResult!.fileUrl}');

      // 调用后端 OCR 检测
      final response = await _dio.post(
        '/api/grading/ocr/detect',
        data: {'imageUrl': uploadResult.fileUrl},
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if ((data['code'] == 0 || data['code'] == 200) && data['data'] != null) {
          return _parseBlocks(data['data']);
        }
      }

      debugPrint('OCR: 后端返回异常 ${response.statusCode}');
      return [];
    } catch (e) {
      debugPrint('OCR: 识别失败 $e');
      return [];
    }
  }

  /// 解析后端返回的文字块
  List<TextBlock> _parseBlocks(Map<String, dynamic> data) {
    final blocksJson = data['blocks'] as List<dynamic>? ?? [];
    final List<TextBlock> blocks = [];

    for (final item in blocksJson) {
      final text = item['text'] as String? ?? '';
      final confidence = (item['confidence'] as num?)?.toDouble() ?? 0.0;
      final box = item['boundingBox'] as Map<String, dynamic>?;

      if (box != null) {
        final left = (box['left'] as num?)?.toDouble() ?? 0;
        final top = (box['top'] as num?)?.toDouble() ?? 0;
        final right = (box['right'] as num?)?.toDouble() ?? 0;
        final bottom = (box['bottom'] as num?)?.toDouble() ?? 0;
        blocks.add(TextBlock(
          boundingBox: Rect.fromLTRB(left, top, right, bottom),
          text: text,
          confidence: confidence,
        ));
      }
    }

    debugPrint('OCR: 识别到 ${blocks.length} 个文字块');
    return blocks;
  }

  /// 根据文字块计算建议裁切区域
  /// 合并所有文字块的边界框，加上适当的边距
  static Rect? computeAutoCropRect(List<TextBlock> blocks, Size imageSize) {
    if (blocks.isEmpty) return null;

    double minLeft = double.infinity;
    double minTop = double.infinity;
    double maxRight = 0;
    double maxBottom = 0;

    for (final block in blocks) {
      minLeft = min(minLeft, block.boundingBox.left);
      minTop = min(minTop, block.boundingBox.top);
      maxRight = max(maxRight, block.boundingBox.right);
      maxBottom = max(maxBottom, block.boundingBox.bottom);
    }

    // 加 5% 边距
    final paddingX = imageSize.width * 0.05;
    final paddingY = imageSize.height * 0.05;

    return Rect.fromLTRB(
      max(0, minLeft - paddingX),
      max(0, minTop - paddingY),
      min(imageSize.width, maxRight + paddingX),
      min(imageSize.height, maxBottom + paddingY),
    );
  }

  /// 释放资源
  Future<void> dispose() async {
    _instance = null;
  }
}
