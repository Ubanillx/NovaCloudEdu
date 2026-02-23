import 'dart:async';
import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';
import '../services/rtc_models.dart';
import '../services/call_service.dart';
import 'call_screen_page.dart';

/// 来电覆盖层管理器
class IncomingCallOverlayManager {
  static OverlayEntry? _overlayEntry;

  /// 显示来电浮层
  static void show(BuildContext context, CurrentCall call) {
    dismiss();
    _overlayEntry = OverlayEntry(
      builder: (_) => IncomingCallOverlay(
        call: call,
        onAccept: () {
          dismiss();
          CallService().answerCall();
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CallScreenPage()),
          );
        },
        onReject: () {
          dismiss();
          CallService().rejectCall();
        },
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  /// 关闭来电浮层
  static void dismiss() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

/// 来电浮层 Widget
class IncomingCallOverlay extends StatefulWidget {
  final CurrentCall call;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const IncomingCallOverlay({
    super.key,
    required this.call,
    required this.onAccept,
    required this.onReject,
  });

  @override
  State<IncomingCallOverlay> createState() => _IncomingCallOverlayState();
}

class _IncomingCallOverlayState extends State<IncomingCallOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  Timer? _timeoutTimer;
  int _countdown = 30;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _timeoutTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() => _countdown--);
        if (_countdown <= 0) {
          widget.onReject();
        }
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _timeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isVideo = widget.call.mediaType == MediaType.video;

    return Material(
      color: Colors.black54,
      child: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 头像（脉冲动画）
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: child,
                    );
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.brand.withOpacity(0.1),
                      border: Border.all(
                        color: AppTheme.brand.withOpacity(0.3),
                        width: 3,
                      ),
                    ),
                    child: widget.call.peerAvatar != null &&
                            widget.call.peerAvatar!.isNotEmpty
                        ? ClipOval(
                            child: Image.network(
                              widget.call.peerAvatar!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  Icon(Icons.person, color: AppTheme.brand, size: 40),
                            ),
                          )
                        : Icon(Icons.person, color: AppTheme.brand, size: 40),
                  ),
                ),
                const SizedBox(height: 16),

                // 名字
                Text(
                  widget.call.peerName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),

                // 通话类型
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isVideo ? Icons.videocam : Icons.phone,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isVideo ? '视频通话邀请' : '语音通话邀请',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // 倒计时
                Text(
                  '${_countdown}s',
                  style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                ),
                const SizedBox(height: 28),

                // 操作按钮
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 拒绝
                    GestureDetector(
                      onTap: widget.onReject,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFEF4444),
                        ),
                        child: const Icon(
                          Icons.call_end,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                    // 接听
                    GestureDetector(
                      onTap: widget.onAccept,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF22C55E),
                        ),
                        child: Icon(
                          isVideo ? Icons.videocam : Icons.call,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
