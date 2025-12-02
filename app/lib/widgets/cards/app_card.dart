/// 卡片组件
/// 使用 TDesign 样式的卡片
library;

import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

/// 通用卡片
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double? borderRadius;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: TDTheme.of(context).whiteColor1,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        boxShadow: [
          BoxShadow(
            color: TDTheme.of(context).grayColor3.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// 列表项卡片
class ListItemCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final VoidCallback? onTap;

  const ListItemCard({
    super.key,
    required this.title,
    this.subtitle,
    this.leftIcon,
    this.rightIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TDCell(
      title: title,
      note: subtitle,
      leftIcon: leftIcon,
      rightIcon: rightIcon,
      arrow: onTap != null,
      onClick: onTap != null ? (_) => onTap!() : null,
    );
  }
}
