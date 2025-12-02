/// 对话框组件
/// 使用 TDesign Dialog 组件
library;

import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

/// 显示确认对话框（双按钮）
Future<bool?> showConfirmDialog(
  BuildContext context, {
  required String title,
  String? content,
  String confirmText = '确定',
  String cancelText = '取消',
}) {
  return showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black54,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: TDAlertDialog(
          title: title,
          content: content,
          leftBtn: TDDialogButtonOptions(
            title: cancelText,
            action: () => Navigator.of(context).pop(false),
          ),
          rightBtn: TDDialogButtonOptions(
            title: confirmText,
            theme: TDButtonTheme.primary,
            action: () => Navigator.of(context).pop(true),
          ),
        ),
      );
    },
  );
}

/// 显示提示对话框（单按钮）
Future<void> showAppAlertDialog(
  BuildContext context, {
  required String title,
  String? content,
  String confirmText = '确定',
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black54,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: TDConfirmDialog(
          title: title,
          content: content,
          buttonText: confirmText,
          action: () => Navigator.of(context).pop(),
        ),
      );
    },
  );
}

/// 显示底部操作菜单
void showAppActionSheet(
  BuildContext context, {
  required List<String> items,
  TDActionSheetItemCallback? onSelected,
}) {
  TDActionSheet(
    context,
    visible: true,
    items: items.map((e) => TDActionSheetItem(label: e)).toList(),
    onSelected: onSelected,
  );
}
