import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

/// Nova 下拉刷新组件
/// 
/// 使用原生 RefreshIndicator，简洁高效
class NovaRefreshHeader extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  final Color? color;

  const NovaRefreshHeader({
    super.key,
    required this.onRefresh,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color ?? AppTheme.brand,
      backgroundColor: Colors.white,
      displacement: 40,
      strokeWidth: 3.0,
      child: child,
    );
  }
}

/// 封装的可刷新列表组件
class NovaRefreshableList extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final List<Widget> slivers;
  final ScrollPhysics? physics;
  final Color? color;

  const NovaRefreshableList({
    super.key,
    required this.onRefresh,
    required this.slivers,
    this.physics,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color ?? AppTheme.brand,
      backgroundColor: Colors.white,
      displacement: 40,
      strokeWidth: 3.0,
      child: CustomScrollView(
        physics: physics ?? const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: slivers,
      ),
    );
  }
}
