/// 空状态组件
/// 使用 TDesign Empty 组件
library;

import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class EmptyWidget extends StatelessWidget {
  final String? message;
  final TDEmptyType type;
  final Widget? image;

  const EmptyWidget({
    super.key,
    this.message,
    this.type = TDEmptyType.plain,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TDEmpty(type: type, emptyText: message ?? '暂无数据', image: image),
    );
  }
}

/// 网络错误空状态（带重试按钮）
class NetworkErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  final String? message;

  const NetworkErrorWidget({super.key, this.onRetry, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TDEmpty(
        type: TDEmptyType.operation,
        emptyText: message ?? '网络连接失败',
        image: Icon(
          TDIcons.close_circle,
          size: 96,
          color: TDTheme.of(context).errorColor6,
        ),
        operationText: '重试',
        onTapEvent: onRetry,
      ),
    );
  }
}
