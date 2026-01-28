import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

enum NovaMessageType { info, success, warning, error }

class NovaMessage {
  static OverlayEntry? _currentEntry;
  static final List<_MessageData> _queue = [];
  static bool _isShowing = false;

  static void show(
    BuildContext context,
    String message, {
    NovaMessageType type = NovaMessageType.info,
    Duration duration = const Duration(seconds: 2),
  }) {
    _queue.add(_MessageData(message, type, duration));
    if (!_isShowing) {
      _showNext(context);
    }
  }

  static void success(BuildContext context, String message) =>
      show(context, message, type: NovaMessageType.success);

  static void error(BuildContext context, String message) =>
      show(context, message, type: NovaMessageType.error);

  static void warning(BuildContext context, String message) =>
      show(context, message, type: NovaMessageType.warning);

  static void _showNext(BuildContext context) {
    if (_queue.isEmpty) {
      _isShowing = false;
      return;
    }

    _isShowing = true;
    final data = _queue.removeAt(0);
    final overlayState = Overlay.of(context);

    _currentEntry = OverlayEntry(
      builder: (context) => _NovaMessageWidget(
        message: data.message,
        type: data.type,
        onDismissed: () {
          _currentEntry?.remove();
          _currentEntry = null;
          _showNext(context);
        },
        duration: data.duration,
      ),
    );

    overlayState.insert(_currentEntry!);
  }
}

class _MessageData {
  final String message;
  final NovaMessageType type;
  final Duration duration;

  _MessageData(this.message, this.type, this.duration);
}

class _NovaMessageWidget extends StatefulWidget {
  final String message;
  final NovaMessageType type;
  final VoidCallback onDismissed;
  final Duration duration;

  const _NovaMessageWidget({
    required this.message,
    required this.type,
    required this.onDismissed,
    required this.duration,
  });

  @override
  State<_NovaMessageWidget> createState() => _NovaMessageWidgetState();
}

class _NovaMessageWidgetState extends State<_NovaMessageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();

    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse().then((_) => widget.onDismissed());
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
    final colors = context.colors;
    final isDark = context.isDarkMode;
    IconData icon;
    Color color;

    switch (widget.type) {
      case NovaMessageType.success:
        icon = Icons.check_circle_rounded;
        color = colors.success;
        break;
      case NovaMessageType.error:
        icon = Icons.error_rounded;
        color = colors.error;
        break;
      case NovaMessageType.warning:
        icon = Icons.warning_rounded;
        color = colors.warning;
        break;
      case NovaMessageType.info:
        icon = Icons.info_rounded;
        color = colors.info;
        break;
    }

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SlideTransition(
            position: _offsetAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    border: Border.all(
                      color: color.withOpacity(isDark ? 0.3 : 0.15),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, color: color, size: 20),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          widget.message,
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
