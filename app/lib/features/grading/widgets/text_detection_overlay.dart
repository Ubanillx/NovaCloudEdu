import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

/// 实时文字检测叠加层
/// 在相机预览上绘制识别到的文字区域
class TextDetectionOverlay extends StatelessWidget {
  final List<TextBlock> blocks;
  final Size imageSize;
  final Size previewSize;
  final InputImageRotation rotation;

  const TextDetectionOverlay({
    super.key,
    required this.blocks,
    required this.imageSize,
    required this.previewSize,
    this.rotation = InputImageRotation.rotation0deg,
  });

  @override
  Widget build(BuildContext context) {
    if (blocks.isEmpty) return const SizedBox.shrink();

    return CustomPaint(
      size: previewSize,
      painter: _TextBlockPainter(
        blocks: blocks,
        imageSize: imageSize,
        previewSize: previewSize,
        rotation: rotation,
      ),
    );
  }
}

class _TextBlockPainter extends CustomPainter {
  final List<TextBlock> blocks;
  final Size imageSize;
  final Size previewSize;
  final InputImageRotation rotation;

  _TextBlockPainter({
    required this.blocks,
    required this.imageSize,
    required this.previewSize,
    required this.rotation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = const Color(0x226366F1)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = const Color(0x886366F1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (final block in blocks) {
      final rect = _translateRect(block.boundingBox);
      final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(4));
      canvas.drawRRect(rrect, fillPaint);
      canvas.drawRRect(rrect, borderPaint);
    }
  }

  Rect _translateRect(Rect rect) {
    // 计算缩放比例
    double scaleX, scaleY;

    switch (rotation) {
      case InputImageRotation.rotation90deg:
      case InputImageRotation.rotation270deg:
        scaleX = previewSize.width / imageSize.height;
        scaleY = previewSize.height / imageSize.width;
        break;
      default:
        scaleX = previewSize.width / imageSize.width;
        scaleY = previewSize.height / imageSize.height;
    }

    return Rect.fromLTRB(
      rect.left * scaleX,
      rect.top * scaleY,
      rect.right * scaleX,
      rect.bottom * scaleY,
    );
  }

  @override
  bool shouldRepaint(covariant _TextBlockPainter oldDelegate) {
    return oldDelegate.blocks != blocks;
  }
}
