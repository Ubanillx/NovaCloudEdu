/// Toast 提示组件
/// 使用 TDesign Toast 组件
library;

import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

/// Toast 工具类
class AppToast {
  AppToast._();

  /// 显示普通提示
  static void show(BuildContext context, String message) {
    TDToast.showText(message, context: context);
  }

  /// 显示成功提示
  static void success(BuildContext context, String message) {
    TDToast.showSuccess(message, context: context);
  }

  /// 显示警告提示
  static void warning(BuildContext context, String message) {
    TDToast.showWarning(message, context: context);
  }

  /// 显示失败提示
  static void error(BuildContext context, String message) {
    TDToast.showFail(message, context: context);
  }

  /// 显示加载中
  static void loading(BuildContext context, {String? message}) {
    TDToast.showLoading(context: context, text: message ?? '加载中...');
  }

  /// 隐藏 Toast
  static void dismiss() {
    TDToast.dismissLoading();
  }
}
