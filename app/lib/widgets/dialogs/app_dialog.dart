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
  bool isDanger = false,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            if (content != null) ...[
              const SizedBox(height: 12),
              Text(
                content,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TDButton(
                    text: cancelText,
                    theme: TDButtonTheme.light,
                    size: TDButtonSize.large,
                    style: TDButtonStyle(
                      radius: BorderRadius.circular(8),
                      backgroundColor: Colors.grey[100],
                      textColor: Colors.grey[700],
                    ),
                    isBlock: true,
                    onTap: () => Navigator.of(context).pop(false),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TDButton(
                    text: confirmText,
                    theme: isDanger ? TDButtonTheme.danger : TDButtonTheme.primary,
                    size: TDButtonSize.large,
                    style: TDButtonStyle(
                      radius: BorderRadius.circular(8),
                      backgroundColor: isDanger ? Colors.red : null,
                      textColor: isDanger ? Colors.white : null,
                    ),
                    isBlock: true,
                    onTap: () => Navigator.of(context).pop(true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
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
