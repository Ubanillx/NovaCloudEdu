import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';

/// 自定义 Tab 栏组件 - 荧光笔涂鸦风格
/// 从 chat_page.dart 提取的自定义 Tab 栏
class NovaTabBar extends StatelessWidget {
  final TabController controller;
  final List<String>? tabs;
  final List<Widget>? tabWidgets;
  final Color? indicatorColor;
  final EdgeInsetsGeometry? padding;

  const NovaTabBar({
    super.key,
    required this.controller,
    this.tabs,
    this.tabWidgets,
    this.indicatorColor,
    this.padding,
  }) : assert(tabs != null || tabWidgets != null, 'tabs 或 tabWidgets 必须提供其一');

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final indicator = indicatorColor ?? AppTheme.brand;
    final items = tabWidgets ?? tabs!.map((t) => Text(t)).toList();

    return Container(
      height: 44,
      margin: EdgeInsets.zero,
      padding: padding ?? EdgeInsets.zero,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(items.length, (index) {
          return AnimatedBuilder(
            animation: controller.animation!,
            builder: (context, child) {
              // 计算当前 tab 离选中状态有多近
              final value = (controller.animation!.value - index).abs();
              final isSelected = value < 0.5;

              // 动画进度 0 到 1 (1表示完全选中，0表示未选中)
              final progress = (1.0 - value).clamp(0.0, 1.0);

              return GestureDetector(
                onTap: () => controller.animateTo(index),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  child: Transform.scale(
                    scale: 1.0 + (0.05 * progress),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        // 荧光笔涂鸦效果 (底部的高光标记)
                        Positioned(
                          bottom: 0,
                          left: 2,
                          right: 2,
                          height: 10,
                          child: Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateZ(-0.035)
                              ..multiply(Matrix4.skewX(-0.26))
                              ..scale(progress, 1.0, 1.0),
                            alignment: Alignment.centerLeft,
                            child: Opacity(
                              opacity: progress,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: indicator,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Tab 内容层
                        DefaultTextStyle(
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: isSelected
                                ? colors.textPrimary
                                : colors.textSecondary,
                          ),
                          child: items[index],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    ),
  );
  }
}
