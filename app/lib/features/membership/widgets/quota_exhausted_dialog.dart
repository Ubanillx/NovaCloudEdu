import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../pages/membership_center_page.dart';

/// 全局AI额度不足对话框
/// 当后端返回 code=42900(日额度) 或 42901(月额度) 时调用
class QuotaExhaustedDialog {
  /// 显示额度不足对话框
  static Future<void> show(BuildContext context, {String? message}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: isDark ? const Color(0xFF1F2937) : Colors.white,
        contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        actionsPadding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF78350F).withAlpha(60) : const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(PhosphorIcons.lightning(), size: 26, color: const Color(0xFFD97706)),
            ),
            const SizedBox(height: 16),
            Text(
              'AI 额度不足',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message ?? '当前功能的使用额度已用完，升级会员可获得更多额度。',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B), height: 1.5),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: BorderSide(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
                  ),
                  child: Text('知道了', style: TextStyle(color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B), fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const MembershipCenterPage()));
                  },
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(PhosphorIcons.crown(), size: 15, color: Colors.white),
                      const SizedBox(width: 6),
                      const Text('查看会员', style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 检查DioException是否为额度不足错误，如果是则弹出对话框
  /// 返回true表示已处理（是额度不足错误），false表示不是
  static bool handleIfQuotaError(BuildContext context, dynamic error) {
    if (error is! Exception) return false;

    // 尝试从DioException中提取code和message
    try {
      final dynamic response = (error as dynamic).response;
      if (response == null) return false;
      final data = response.data;
      if (data is Map<String, dynamic>) {
        final code = data['code'];
        if (code == 42900 || code == 42901) {
          final msg = data['message'] as String?;
          show(context, message: msg);
          return true;
        }
      }
    } catch (_) {
      // Not a DioException or doesn't have the expected structure
    }
    return false;
  }
}
