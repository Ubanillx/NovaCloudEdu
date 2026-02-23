import 'package:flutter/material.dart';
import '../../../../config/app_theme.dart';

class ChatSliverHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget>? actions;
  final AppColors colors;
  final bool isDarkMode;

  ChatSliverHeader({
    this.expandedHeight = 120,
    required this.title,
    this.subtitle,
    this.leading,
    this.actions,
    required this.colors,
    required this.isDarkMode,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // 0 -> fully expanded (shrinkOffset = 0)
    // 1 -> fully shrunk (shrinkOffset >= maxExtent - minExtent)
    final shrinkFactor =
        (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    return Container(
      decoration: BoxDecoration(
        color: colors.surface.withOpacity(0.95),
        boxShadow: shrinkFactor > 0.5
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                )
              ]
            : null,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 背景高斯模糊/或其他特效（如果有需要这里可以加）

          // 标题平滑过渡：从大字缩小并移动到中间
          Positioned(
            left: Tween<double>(begin: 24, end: 56).transform(shrinkFactor),
            top: Tween<double>(begin: expandedHeight - 48, end: 12)
                .transform(shrinkFactor),
            child: Column(
              crossAxisAlignment: shrinkFactor > 0.5
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                    fontSize: Tween<double>(begin: 32, end: 18)
                        .transform(shrinkFactor),
                  ),
                ),
                if (shrinkFactor < 0.5 && subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      subtitle!,
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // 顶部标准 AppBar 层
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: minExtent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (leading != null) leading! else const SizedBox(width: 48),
                  if (actions != null) Row(children: actions!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 56 + 10; // 这里替换为你需要的标准导航栏高度 (kToolbarHeight + padding)

  @override
  bool shouldRebuild(covariant ChatSliverHeader oldDelegate) {
    return expandedHeight != oldDelegate.expandedHeight ||
        title != oldDelegate.title ||
        subtitle != oldDelegate.subtitle ||
        leading != oldDelegate.leading ||
        actions != oldDelegate.actions;
  }
}
