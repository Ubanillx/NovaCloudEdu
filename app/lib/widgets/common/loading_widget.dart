/// 加载组件
/// 使用 TDesign Loading 组件
library;

import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final TDLoadingSize size;

  const LoadingWidget({
    super.key,
    this.message,
    this.size = TDLoadingSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TDLoading(
        size: size,
        icon: TDLoadingIcon.circle,
        text: message,
        axis: Axis.vertical,
      ),
    );
  }
}

/// 页面加载组件
class PageLoading extends StatelessWidget {
  const PageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: TDLoading(
        size: TDLoadingSize.large,
        icon: TDLoadingIcon.circle,
      ),
    );
  }
}
