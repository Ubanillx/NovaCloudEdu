import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../config/app_theme.dart';

class PptProgressCard extends StatelessWidget {
  final int current;
  final int total;
  final AppColors colors;

  const PptProgressCard({
    super.key,
    required this.current,
    required this.total,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final pct = total > 0 ? (current / total * 100).round() : 0;
    final isDone = total > 0 && current >= total;
    final progress = total > 0 ? current / total : 0.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // AI 头像
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppTheme.brand.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(PhosphorIcons.sparkle(PhosphorIconsStyle.fill), size: 16, color: AppTheme.brand),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: colors.divider.withValues(alpha: 0.6)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: isDone
                            ? AppTheme.green.withValues(alpha: 0.1)
                            : AppTheme.brand.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: isDone
                          ? Icon(PhosphorIcons.check(PhosphorIconsStyle.bold), size: 18, color: AppTheme.green)
                          : const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppTheme.brand,
                              ),
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isDone ? '幻灯片生成完成' : '正在生成幻灯片',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: colors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            current > 0 ? '第 $current / $total 页' : '准备中...',
                            style: TextStyle(fontSize: 12, color: colors.textTertiary),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: (isDone ? AppTheme.green : AppTheme.brand).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$pct%',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isDone ? AppTheme.green : AppTheme.brand,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // 渐变进度条
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Stack(
                    children: [
                      Container(
                        height: 6,
                        width: double.infinity,
                        color: colors.surfaceVariant,
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                        height: 6,
                        width: progress * (MediaQuery.of(context).size.width - 110),
                        decoration: BoxDecoration(
                          gradient: isDone
                              ? const LinearGradient(colors: [Color(0xFF10B981), Color(0xFF34D399)])
                              : const LinearGradient(colors: [Color(0xFF007BFF), Color(0xFF0EA5E9)]),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
