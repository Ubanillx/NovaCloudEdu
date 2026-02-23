/// Nova 加载组件
library;

import 'package:flutter/material.dart';
import '../../config/app_theme.dart';
import 'dart:math' as math;

/// 品牌主色
const Color _themeColor = AppTheme.brand;

/// Windows 11 风格圆环加载组件
class LoadingWidget extends StatefulWidget {
  final String? message;
  final double size;
  final Color? color;

  const LoadingWidget({
    super.key,
    this.message,
    this.size = 32,
    this.color,
  });

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    // 延迟一帧显示，触发淡入动画
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _isVisible = true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? _themeColor;

    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: widget.size,
              height: widget.size,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _Win11RingPainter(
                      progress: _controller.value,
                      color: color,
                      strokeWidth: math.max(3.5, widget.size / 8),
                    ),
                  );
                },
              ),
            ),
            if (widget.message != null) ...[
              const SizedBox(height: 12),
              Text(
                widget.message!,
                style: TextStyle(
                  fontSize: 14,
                  color: context.colors.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Windows 11 风格圆环绘制器
class _Win11RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _Win11RingPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // 创建渐变着色器 - 从透明到不透明
    final gradient = SweepGradient(
      colors: [
        color.withOpacity(0.1),
        color.withOpacity(0.3),
        color,
        color,
      ],
      stops: const [0.0, 0.5, 0.9, 1.0],
      transform: GradientRotation(progress * 2 * math.pi),
    );

    final paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // 绘制圆环（带缺口）
    const startAngle = -math.pi / 2;
    const sweepAngle = 1.7 * math.pi; // 约 306 度，留出缺口

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle + progress * 2 * math.pi,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _Win11RingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

/// 全屏加载页面
class PageLoading extends StatelessWidget {
  final String? message;
  final Color? backgroundColor;

  const PageLoading({
    super.key,
    this.message,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      child: LoadingWidget(
        size: 40,
        message: message,
      ),
    );
  }
}

/// 加载遮罩层
class LoadingOverlay extends StatefulWidget {
  final Widget child;
  final bool isLoading;
  final String? message;

  const LoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.message,
  });

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: widget.isLoading
              ? Container(
                  key: const ValueKey('overlay'),
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(context.isDarkMode ? 0.3 : 0.1),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: LoadingWidget(
                        size: 36,
                        message: widget.message ?? '请稍候...',
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

/// 骨架屏闪烁效果
class ShimmerLoading extends StatefulWidget {
  final Widget child;

  const ShimmerLoading({super.key, required this.child});

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      Colors.grey[700]!,
                      Colors.grey[600]!,
                      Colors.grey[700]!,
                    ]
                  : [
                      Colors.grey[300]!,
                      Colors.grey[100]!,
                      Colors.grey[300]!,
                    ],
              stops: [
                0.0,
                _controller.value,
                1.0,
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: widget.child,
        );
      },
    );
  }
}

/// 列表骨架屏
class ListSkeleton extends StatelessWidget {
  final int itemCount;
  final double itemHeight;

  const ListSkeleton({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 72,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ShimmerLoading(
            child: Container(
              height: itemHeight,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[700] : Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      },
    );
  }
}
