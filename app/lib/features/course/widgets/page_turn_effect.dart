import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// 仿真翻页效果组件（贝塞尔曲线 + 裁剪 + 阴影 2D）
class SimulatedPageTurn extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final int initialPage;
  final ValueChanged<int>? onPageChanged;

  const SimulatedPageTurn({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.initialPage = 0,
    this.onPageChanged,
  });

  @override
  State<SimulatedPageTurn> createState() => SimulatedPageTurnState();
}

class SimulatedPageTurnState extends State<SimulatedPageTurn>
    with SingleTickerProviderStateMixin {
  late int _currentPage;
  late AnimationController _animController;
  late Animation<double> _animation;

  Offset? _dragStart;
  bool _isDragging = false;
  bool _isForward = true;
  double _dragPercent = 0.0;
  bool _animating = false;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage.clamp(0, widget.itemCount - 1);
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void goToPage(int page) {
    if (page < 0 || page >= widget.itemCount || _animating) return;
    setState(() {
      _currentPage = page;
      _dragPercent = 0.0;
    });
  }

  void _onPanStart(DragStartDetails details) {
    if (_animating) return;
    _dragStart = details.localPosition;
    _isDragging = true;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!_isDragging || _dragStart == null || _animating) return;
    final size = context.size;
    if (size == null) return;

    final dx = _dragStart!.dx - details.localPosition.dx;

    if (dx > 0) {
      _isForward = true;
      if (_currentPage >= widget.itemCount - 1) {
        setState(() => _dragPercent = 0.0);
        return;
      }
    } else {
      _isForward = false;
      if (_currentPage <= 0) {
        setState(() => _dragPercent = 0.0);
        return;
      }
    }

    setState(() {
      _dragPercent = (dx.abs() / size.width).clamp(0.0, 1.0);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (!_isDragging || _animating) return;
    _isDragging = false;

    final velocity = details.velocity.pixelsPerSecond.dx;
    bool shouldComplete;

    if (_isForward) {
      shouldComplete = _dragPercent > 0.3 || velocity < -500;
      if (_currentPage >= widget.itemCount - 1) shouldComplete = false;
    } else {
      shouldComplete = _dragPercent > 0.3 || velocity > 500;
      if (_currentPage <= 0) shouldComplete = false;
    }

    _animateToEnd(shouldComplete);
  }

  void _animateToEnd(bool complete) {
    _animating = true;
    final start = _dragPercent;
    final end = complete ? 1.0 : 0.0;

    _animation = Tween<double>(begin: start, end: end).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );

    void statusHandler(AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _animController.removeStatusListener(statusHandler);
        _animation.removeListener(_onAnimTick);
        _animating = false;
        if (complete) {
          final newPage = _isForward ? _currentPage + 1 : _currentPage - 1;
          if (newPage >= 0 && newPage < widget.itemCount) {
            _currentPage = newPage;
            widget.onPageChanged?.call(_currentPage);
          }
        }
        setState(() => _dragPercent = 0.0);
      }
    }

    _animation.addListener(_onAnimTick);
    _animController.addStatusListener(statusHandler);
    _animController.forward(from: 0.0);
  }

  void _onAnimTick() {
    setState(() => _dragPercent = _animation.value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragStart: _onPanStart,
      onHorizontalDragUpdate: _onPanUpdate,
      onHorizontalDragEnd: _onPanEnd,
      child: ClipRect(
        child: Stack(
          children: [
            // 底层 - 即将显示的页面
            if (_dragPercent > 0) _buildRevealedPage(),
            // 顶层 - 当前页面（被裁剪）
            _buildCurrentPage(),
            // 阴影效果
            if (_dragPercent > 0) _buildShadowOverlay(),
            // 翻起的页面背面
            if (_dragPercent > 0) _buildPageBack(),
          ],
        ),
      ),
    );
  }

  Widget _buildRevealedPage() {
    final idx = _isForward ? _currentPage + 1 : _currentPage - 1;
    if (idx < 0 || idx >= widget.itemCount) return const SizedBox.shrink();
    return Positioned.fill(child: widget.itemBuilder(context, idx));
  }

  Widget _buildCurrentPage() {
    if (_dragPercent <= 0) {
      return Positioned.fill(child: widget.itemBuilder(context, _currentPage));
    }
    return Positioned.fill(
      child: ClipPath(
        clipper: _PageCurlClipper(
          percent: _dragPercent,
          isForward: _isForward,
        ),
        child: widget.itemBuilder(context, _currentPage),
      ),
    );
  }

  Widget _buildShadowOverlay() {
    return Positioned.fill(
      child: CustomPaint(
        painter: _FoldShadowPainter(
          percent: _dragPercent,
          isForward: _isForward,
        ),
      ),
    );
  }

  Widget _buildPageBack() {
    return Positioned.fill(
      child: CustomPaint(
        painter: _PageBackPainter(
          percent: _dragPercent,
          isForward: _isForward,
        ),
      ),
    );
  }
}

/// 贝塞尔曲线裁剪器 - 将当前页面裁剪为"未翻起"的部分
class _PageCurlClipper extends CustomClipper<Path> {
  final double percent;
  final bool isForward;

  _PageCurlClipper({required this.percent, required this.isForward});

  @override
  Path getClip(Size size) {
    if (percent <= 0) {
      return Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    }

    final w = size.width;
    final h = size.height;
    final path = Path();

    // 折叠线 X 位置
    final foldX = isForward
        ? w * (1.0 - percent)
        : w * percent;
    // 贝塞尔曲线弯曲量
    final curl = 25.0 * percent;

    if (isForward) {
      // 翻页方向：右→左，保留左侧
      path.moveTo(0, 0);
      path.lineTo(foldX, 0);
      // 右侧边缘用贝塞尔曲线模拟纸张弯曲
      path.cubicTo(
        foldX + curl, h * 0.2,
        foldX - curl * 0.6, h * 0.5,
        foldX + curl, h * 0.8,
      );
      path.lineTo(foldX, h);
      path.lineTo(0, h);
      path.close();
    } else {
      // 翻页方向：左→右，保留右侧
      path.moveTo(foldX, 0);
      path.lineTo(w, 0);
      path.lineTo(w, h);
      path.lineTo(foldX, h);
      path.cubicTo(
        foldX - curl, h * 0.8,
        foldX + curl * 0.6, h * 0.5,
        foldX - curl, h * 0.2,
      );
      path.close();
    }

    return path;
  }

  @override
  bool shouldReclip(covariant _PageCurlClipper old) {
    return percent != old.percent || isForward != old.isForward;
  }
}

/// 折叠线阴影绘制器
class _FoldShadowPainter extends CustomPainter {
  final double percent;
  final bool isForward;

  _FoldShadowPainter({required this.percent, required this.isForward});

  @override
  void paint(Canvas canvas, Size size) {
    if (percent <= 0) return;

    final w = size.width;
    final h = size.height;
    final foldX = isForward ? w * (1.0 - percent) : w * percent;
    final shadowW = 40.0 * percent;

    // 在折叠线两侧绘制阴影渐变
    final rect = Rect.fromLTWH(foldX - shadowW, 0, shadowW * 2, h);
    final gradient = ui.Gradient.linear(
      Offset(foldX - shadowW, 0),
      Offset(foldX + shadowW, 0),
      [
        Colors.black.withValues(alpha: 0.0),
        Colors.black.withValues(alpha: 0.18 * percent),
        Colors.black.withValues(alpha: 0.0),
      ],
      [0.0, 0.5, 1.0],
    );
    canvas.drawRect(rect, Paint()..shader = gradient);
  }

  @override
  bool shouldRepaint(covariant _FoldShadowPainter old) {
    return percent != old.percent || isForward != old.isForward;
  }
}

/// 翻起页面背面效果绘制器
class _PageBackPainter extends CustomPainter {
  final double percent;
  final bool isForward;

  _PageBackPainter({required this.percent, required this.isForward});

  @override
  void paint(Canvas canvas, Size size) {
    if (percent <= 0) return;

    final w = size.width;
    final h = size.height;
    final foldX = isForward ? w * (1.0 - percent) : w * percent;
    final backW = (w * percent * 0.5).clamp(0.0, 80.0);

    Rect backRect;
    ui.Gradient gradient;

    if (isForward) {
      backRect = Rect.fromLTWH(foldX, 0, backW, h);
      gradient = ui.Gradient.linear(
        Offset(foldX, 0),
        Offset(foldX + backW, 0),
        [
          const Color(0xFFEEEEEE).withValues(alpha: 0.9 * percent),
          const Color(0xFFDDDDDD).withValues(alpha: 0.4 * percent),
        ],
      );
    } else {
      backRect = Rect.fromLTWH(foldX - backW, 0, backW, h);
      gradient = ui.Gradient.linear(
        Offset(foldX - backW, 0),
        Offset(foldX, 0),
        [
          const Color(0xFFDDDDDD).withValues(alpha: 0.4 * percent),
          const Color(0xFFEEEEEE).withValues(alpha: 0.9 * percent),
        ],
      );
    }

    canvas.drawRect(backRect, Paint()..shader = gradient);
  }

  @override
  bool shouldRepaint(covariant _PageBackPainter old) {
    return percent != old.percent || isForward != old.isForward;
  }
}
