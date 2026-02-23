import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../widgets/common/loading_widget.dart';
import '../services/membership_service.dart';
import '../pages/membership_center_page.dart';

// 计划图标映射
PhosphorIconData _planIcon(String code) {
  switch (code) {
    case 'FREE': return PhosphorIcons.user();
    case 'BASIC': return PhosphorIcons.star();
    case 'PRO': return PhosphorIcons.crown();
    case 'TEACHER': return PhosphorIcons.graduationCap();
    default: return PhosphorIcons.user();
  }
}

List<Color> _planGradient(String code) {
  switch (code) {
    case 'FREE': return const [Color(0xFF94A3B8), Color(0xFF64748B)];
    case 'BASIC': return const [Color(0xFF3B82F6), Color(0xFF6366F1)];
    case 'PRO': return const [Color(0xFFF59E0B), Color(0xFFEA580C)];
    case 'TEACHER': return const [Color(0xFF8B5CF6), Color(0xFFEC4899)];
    default: return const [Color(0xFF94A3B8), Color(0xFF64748B)];
  }
}

PhosphorIconData _featureIcon(String key) {
  switch (key) {
    case 'AI_CHAT': return PhosphorIcons.chatCircleDots();
    case 'AI_PPT': return PhosphorIcons.presentation();
    case 'AI_EXAM': return PhosphorIcons.exam();
    case 'AI_BOOK': return PhosphorIcons.bookOpenText();
    case 'AI_GRADING': return PhosphorIcons.checkSquareOffset();
    default: return PhosphorIcons.sparkle();
  }
}

Color _featureColor(String key) {
  switch (key) {
    case 'AI_CHAT': return const Color(0xFF3B82F6);
    case 'AI_PPT': return const Color(0xFFF59E0B);
    case 'AI_EXAM': return const Color(0xFF8B5CF6);
    case 'AI_BOOK': return const Color(0xFF10B981);
    case 'AI_GRADING': return const Color(0xFFEC4899);
    default: return const Color(0xFF6366F1);
  }
}

/// 首页嵌入式会员权益卡片
class MembershipCard extends StatefulWidget {
  const MembershipCard({super.key});

  @override
  State<MembershipCard> createState() => _MembershipCardState();
}

class _MembershipCardState extends State<MembershipCard> {
  final MembershipService _service = MembershipService();
  bool _loading = true;
  MembershipDetailData? _detail;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final detail = await _service.getCurrentMembershipDetail();
      if (mounted) setState(() { _detail = detail; _loading = false; });
    } catch (e) {
      debugPrint('MembershipCard 加载失败: $e');
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_loading) {
      return _buildCardSkeleton(isDark);
    }

    final planCode = _detail?.planCode ?? 'FREE';
    final gradient = _planGradient(planCode);
    final planLabel = planLabels[planCode] ?? '免费版';

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 头部：渐变条 + 会员信息
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [gradient.first.withAlpha(isDark ? 40 : 18), gradient.last.withAlpha(isDark ? 25 : 10)],
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(11),
                    boxShadow: [BoxShadow(color: gradient.first.withAlpha(40), blurRadius: 8, offset: const Offset(0, 3))],
                  ),
                  child: Icon(_planIcon(planCode), size: 18, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(planLabel, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: isDark ? Colors.white : const Color(0xFF0F172A), letterSpacing: -0.3)),
                      const SizedBox(height: 2),
                      Text(
                        _detail?.expireText ?? '未开通会员',
                        style: TextStyle(fontSize: 11, color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8)),
                      ),
                    ],
                  ),
                ),
                if (planCode == 'FREE')
                  _buildUpgradeButton(context, gradient),
              ],
            ),
          ),

          // AI 额度列表
          if (_detail != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(PhosphorIcons.lightning(), size: 12, color: isDark ? const Color(0xFFFBBF24) : const Color(0xFFD97706)),
                      const SizedBox(width: 5),
                      Text('AI 额度', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8), letterSpacing: 0.5)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...aiFeatures.map((f) {
                    final q = _detail!.quotas[f.key];
                    if (q == null) return const SizedBox.shrink();
                    return _QuotaRow(label: f.label, featureKey: f.key, quota: q, isDark: isDark);
                  }),
                ],
              ),
            ),

          // 底部入口
          InkWell(
            onTap: () => _navigateToCenter(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('查看会员详情', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8))),
                  const SizedBox(width: 4),
                  Icon(PhosphorIcons.caretRight(), size: 12, color: isDark ? const Color(0xFF475569) : const Color(0xFF94A3B8)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpgradeButton(BuildContext context, List<Color> gradient) {
    return GestureDetector(
      onTap: () => _navigateToCenter(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: gradient.first.withAlpha(40), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(PhosphorIcons.lightning(), size: 13, color: Colors.white),
            const SizedBox(width: 4),
            const Text('升级', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildCardSkeleton(bool isDark) {
    final base = isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0);
    Widget bone(double w, double h, {double r = 8}) => Container(
      width: w, height: h,
      decoration: BoxDecoration(color: base, borderRadius: BorderRadius.circular(r)),
    );

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
      ),
      clipBehavior: Clip.antiAlias,
      child: ShimmerLoading(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 头部骨架
              Row(
                children: [
                  bone(38, 38, r: 11),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [bone(80, 14), const SizedBox(height: 6), bone(110, 10)],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // 额度行骨架
              ...List.generate(3, (_) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(children: [bone(13, 13, r: 3), const SizedBox(width: 8), bone(50, 10), const Spacer(), bone(40, 10)]),
              )),
              const SizedBox(height: 8),
              // 底部骨架
              Center(child: bone(80, 10)),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToCenter(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const MembershipCenterPage()));
  }
}

/// 单条额度行
class _QuotaRow extends StatelessWidget {
  final String label;
  final String featureKey;
  final QuotaRemaining quota;
  final bool isDark;

  const _QuotaRow({
    required this.label,
    required this.featureKey,
    required this.quota,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final color = _featureColor(featureKey);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(_featureIcon(featureKey), size: 13, color: color),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
          const Spacer(),
          if (quota.isUnlimited)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(PhosphorIcons.infinity(), size: 14, color: isDark ? const Color(0xFF475569) : const Color(0xFFCBD5E1)),
                const SizedBox(width: 4),
                Text('无限', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155))),
              ],
            )
          else ...[
            Text(
              '${quota.dailyRemaining}/${quota.dailyLimit}',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: isDark ? Colors.white : const Color(0xFF0F172A)),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: 1.0 - quota.dailyUsageRatio,
                  minHeight: 3,
                  backgroundColor: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                  valueColor: AlwaysStoppedAnimation(color),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
