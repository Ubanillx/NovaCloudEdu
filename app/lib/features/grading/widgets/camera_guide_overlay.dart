import 'package:flutter/material.dart';

/// 拍照引导框叠加层
/// 半透明遮罩 + 中间透明矩形区域 + 四角高亮 + 引导文字
class CameraGuideOverlay extends StatelessWidget {
  final String message;
  final double horizontalPadding;
  final double verticalPadding;

  const CameraGuideOverlay({
    super.key,
    this.message = '将作业放入框内',
    this.horizontalPadding = 24,
    this.verticalPadding = 80,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final guideRect = Rect.fromLTRB(
          horizontalPadding,
          verticalPadding,
          constraints.maxWidth - horizontalPadding,
          constraints.maxHeight - verticalPadding - 100, // 留出底部操作栏空间
        );

        return Stack(
          children: [
            // 半透明遮罩（四周）
            CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: _GuideOverlayPainter(guideRect: guideRect),
            ),
            // 四角高亮标记
            _buildCornerMarkers(guideRect),
            // 引导文字
            Positioned(
              left: guideRect.left,
              right: constraints.maxWidth - guideRect.right,
              top: guideRect.top - 36,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCornerMarkers(Rect rect) {
    const cornerLength = 24.0;
    const cornerWidth = 3.0;
    const color = Colors.white;

    return Stack(
      children: [
        // 左上
        Positioned(
          left: rect.left - cornerWidth / 2,
          top: rect.top - cornerWidth / 2,
          child: _CornerMark(
            cornerLength: cornerLength,
            cornerWidth: cornerWidth,
            color: color,
            topLeft: true,
          ),
        ),
        // 右上
        Positioned(
          right: (rect.left == 0 ? 0 : rect.left) > 0
              ? rect.left - cornerWidth / 2 // mirror
              : 0,
          left: rect.right - cornerLength + cornerWidth / 2,
          top: rect.top - cornerWidth / 2,
          child: _CornerMark(
            cornerLength: cornerLength,
            cornerWidth: cornerWidth,
            color: color,
            topRight: true,
          ),
        ),
        // 左下
        Positioned(
          left: rect.left - cornerWidth / 2,
          top: rect.bottom - cornerLength + cornerWidth / 2,
          child: _CornerMark(
            cornerLength: cornerLength,
            cornerWidth: cornerWidth,
            color: color,
            bottomLeft: true,
          ),
        ),
        // 右下
        Positioned(
          left: rect.right - cornerLength + cornerWidth / 2,
          top: rect.bottom - cornerLength + cornerWidth / 2,
          child: _CornerMark(
            cornerLength: cornerLength,
            cornerWidth: cornerWidth,
            color: color,
            bottomRight: true,
          ),
        ),
      ],
    );
  }
}

class _CornerMark extends StatelessWidget {
  final double cornerLength;
  final double cornerWidth;
  final Color color;
  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;

  const _CornerMark({
    required this.cornerLength,
    required this.cornerWidth,
    required this.color,
    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(cornerLength, cornerLength),
      painter: _CornerPainter(
        cornerWidth: cornerWidth,
        color: color,
        topLeft: topLeft,
        topRight: topRight,
        bottomLeft: bottomLeft,
        bottomRight: bottomRight,
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final double cornerWidth;
  final Color color;
  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;

  _CornerPainter({
    required this.cornerWidth,
    required this.color,
    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = cornerWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    if (topLeft) {
      canvas.drawLine(Offset(0, 0), Offset(size.width, 0), paint);
      canvas.drawLine(Offset(0, 0), Offset(0, size.height), paint);
    }
    if (topRight) {
      canvas.drawLine(Offset(0, 0), Offset(size.width, 0), paint);
      canvas.drawLine(Offset(size.width, 0), Offset(size.width, size.height), paint);
    }
    if (bottomLeft) {
      canvas.drawLine(Offset(0, size.height), Offset(size.width, size.height), paint);
      canvas.drawLine(Offset(0, 0), Offset(0, size.height), paint);
    }
    if (bottomRight) {
      canvas.drawLine(Offset(0, size.height), Offset(size.width, size.height), paint);
      canvas.drawLine(Offset(size.width, 0), Offset(size.width, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GuideOverlayPainter extends CustomPainter {
  final Rect guideRect;

  _GuideOverlayPainter({required this.guideRect});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withValues(alpha: 0.5);

    // 整个屏幕
    final fullRect = Rect.fromLTWH(0, 0, size.width, size.height);

    // 用 Path 挖洞
    final path = Path()
      ..addRect(fullRect)
      ..addRRect(RRect.fromRectAndRadius(guideRect, const Radius.circular(12)))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);

    // 引导框边线
    final borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRRect(
      RRect.fromRectAndRadius(guideRect, const Radius.circular(12)),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _GuideOverlayPainter oldDelegate) {
    return oldDelegate.guideRect != guideRect;
  }
}
