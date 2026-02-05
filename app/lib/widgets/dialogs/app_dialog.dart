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

/// ActionSheet回调类型
typedef ActionSheetCallback = void Function(String item, int index);

/// 显示底部操作菜单
void showAppActionSheet(
  BuildContext context, {
  required List<String> items,
  ActionSheetCallback? onSelected,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 拖动指示器
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // 选项列表
            ...items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  if (index > 0) Divider(height: 1, color: Colors.grey[200]),
                  InkWell(
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      onSelected?.call(item, index);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        item,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            // 取消按钮
            Container(
              height: 8,
              color: Colors.grey[100],
            ),
            InkWell(
              onTap: () => Navigator.of(sheetContext).pop(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const Text(
                  '取消',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// 显示输入对话框
Future<String?> showInputDialog(
  BuildContext context, {
  required String title,
  String? hintText,
  String? initialValue,
  String confirmText = '确定',
  String cancelText = '取消',
  int maxLines = 1,
}) {
  final controller = TextEditingController(text: initialValue);
  return showDialog<String>(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              maxLines: maxLines,
              autofocus: true,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
              ),
            ),
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
                    onTap: () => Navigator.of(context).pop(null),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TDButton(
                    text: confirmText,
                    theme: TDButtonTheme.primary,
                    size: TDButtonSize.large,
                    style: TDButtonStyle(
                      radius: BorderRadius.circular(8),
                    ),
                    isBlock: true,
                    onTap: () => Navigator.of(context).pop(controller.text),
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
