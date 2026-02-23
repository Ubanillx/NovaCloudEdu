import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../widgets/common/loading_widget.dart';
import '../services/membership_service.dart';

// ==================== 计划配色方案 ====================

class _PlanTheme {
  final List<Color> gradient;
  final Color accent;
  final Color accentSoft;
  final PhosphorIconData icon;

  const _PlanTheme({
    required this.gradient,
    required this.accent,
    required this.accentSoft,
    required this.icon,
  });
}

final _planThemes = <String, _PlanTheme>{
  'FREE': _PlanTheme(
    gradient: const [Color(0xFF94A3B8), Color(0xFF64748B)],
    accent: const Color(0xFF64748B),
    accentSoft: const Color(0xFFF1F5F9),
    icon: PhosphorIcons.user(),
  ),
  'BASIC': _PlanTheme(
    gradient: const [Color(0xFF3B82F6), Color(0xFF6366F1)],
    accent: const Color(0xFF3B82F6),
    accentSoft: const Color(0xFFEFF6FF),
    icon: PhosphorIcons.star(),
  ),
  'PRO': _PlanTheme(
    gradient: const [Color(0xFFF59E0B), Color(0xFFEA580C)],
    accent: const Color(0xFFD97706),
    accentSoft: const Color(0xFFFFFBEB),
    icon: PhosphorIcons.crown(),
  ),
  'TEACHER': _PlanTheme(
    gradient: const [Color(0xFF8B5CF6), Color(0xFFEC4899)],
    accent: const Color(0xFF8B5CF6),
    accentSoft: const Color(0xFFFAF5FF),
    icon: PhosphorIcons.graduationCap(),
  ),
};

// AI功能图标映射
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

// ==================== 主页面 ====================

class MembershipCenterPage extends StatefulWidget {
  const MembershipCenterPage({super.key});

  @override
  State<MembershipCenterPage> createState() => _MembershipCenterPageState();
}

class _MembershipCenterPageState extends State<MembershipCenterPage> {
  final MembershipService _service = MembershipService();

  bool _loading = true;
  List<MembershipPlanData> _plans = [];
  MembershipDetailData? _currentDetail;
  List<MembershipHistoryItem> _history = [];
  String? _purchasingPlanId;
  bool _showHistory = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _loading = true);
    try {
      final results = await Future.wait([
        _service.getPlans(),
        _service.getCurrentMembershipDetail(),
        _service.getMembershipHistory(),
      ]);
      if (mounted) {
        setState(() {
          _plans = results[0] as List<MembershipPlanData>;
          _currentDetail = results[1] as MembershipDetailData?;
          _history = results[2] as List<MembershipHistoryItem>;
          _loading = false;
        });
      }
    } catch (e) {
      debugPrint('获取会员数据失败: $e');
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _handlePurchase(MembershipPlanData plan) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = _planThemes[plan.code] ?? _planThemes['FREE']!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: isDark ? const Color(0xFF1F2937) : Colors.white,
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        actionsPadding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52, height: 52,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: theme.gradient),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(theme.icon, size: 24, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text('确认开通', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.grey[900])),
            const SizedBox(height: 8),
            Text(
              '${planLabels[plan.code] ?? plan.name}  ¥${plan.price.toStringAsFixed(2)} / ${plan.durationText}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[500], height: 1.5),
            ),
            const SizedBox(height: 4),
            Text(
              '购买后请联系管理员确认收款',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey[400]),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: BorderSide(color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB)),
                  ),
                  child: Text('取消', style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: theme.accent,
                  ),
                  child: const Text('确认开通', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    setState(() => _purchasingPlanId = plan.id);
    try {
      final orderNo = await _service.purchaseMembership(plan.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(PhosphorIcons.checkCircle(), color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Expanded(child: Text('订单已创建（$orderNo），请联系管理员确认。')),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: const Color(0xFF16A34A),
          ),
        );
        _fetchData();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(MembershipService.extractErrorMessage(e)),
            backgroundColor: const Color(0xFFDC2626),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _purchasingPlanId = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC);

    return Scaffold(
      backgroundColor: bg,
      body: _loading
          ? _buildSkeleton(isDark)
          : CustomScrollView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                // 顶部 SliverAppBar
                _buildAppBar(isDark),
                // 内容
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // 当前会员状态卡片
                      if (_currentDetail != null) _buildCurrentStatusCard(isDark),
                      const SizedBox(height: 20),
                      // 今日AI额度
                      if (_currentDetail != null) _buildQuotaGrid(isDark),
                      const SizedBox(height: 28),
                      // 区域标题 - 订阅方案
                      _buildSectionTitle('订阅方案', PhosphorIcons.sparkle(), isDark),
                      const SizedBox(height: 14),
                      // 计划卡片
                      ..._plans.map((plan) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildPlanCard(plan, isDark),
                      )),
                      const SizedBox(height: 12),
                      // 会员历史
                      _buildHistorySection(isDark),
                      const SizedBox(height: 16),
                      // 支付说明
                      _buildPaymentInfo(isDark),
                    ]),
                  ),
                ),
              ],
            ),
    );
  }

  // ==================== AppBar ====================
  SliverAppBar _buildAppBar(bool isDark) {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
            ),
            child: Icon(PhosphorIcons.caretLeft(), size: 18, color: isDark ? Colors.white : const Color(0xFF334155)),
          ),
        ),
      ),
      title: Text(
        '会员中心',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: isDark ? Colors.white : const Color(0xFF0F172A),
          letterSpacing: -0.3,
        ),
      ),
      centerTitle: true,
    );
  }

  // ==================== 骨架屏加载态 ====================
  Widget _buildSkeleton(bool isDark) {
    final baseColor = isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0);
    final highlightColor = isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9);

    Widget bone(double w, double h, {double r = 10}) {
      return Container(
        width: w, height: h,
        decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(r)),
      );
    }

    return SafeArea(
      child: ShimmerLoading(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 56, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 当前会员状态卡片骨架
              Container(
                height: 110,
                decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(20)),
              ),
              const SizedBox(height: 20),
              // AI额度网格骨架
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: highlightColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: baseColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    bone(90, 14),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: bone(double.infinity, 80, r: 14)),
                        const SizedBox(width: 12),
                        Expanded(child: bone(double.infinity, 80, r: 14)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: bone(double.infinity, 80, r: 14)),
                        const SizedBox(width: 12),
                        Expanded(child: bone(double.infinity, 80, r: 14)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              // 区域标题骨架
              bone(100, 16),
              const SizedBox(height: 14),
              // 计划卡片骨架
              Container(
                decoration: BoxDecoration(
                  color: highlightColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: baseColor),
                ),
                child: Column(
                  children: [
                    Container(height: 130, decoration: BoxDecoration(color: baseColor, borderRadius: const BorderRadius.vertical(top: Radius.circular(18)))),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: List.generate(5, (i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [bone(14, 14, r: 4), const SizedBox(width: 10), bone(60, 12), const Spacer(), bone(70, 12)],
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== 当前会员状态卡片 ====================
  Widget _buildCurrentStatusCard(bool isDark) {
    final detail = _currentDetail!;
    final planCode = detail.planCode;
    final theme = _planThemes[planCode] ?? _planThemes['FREE']!;
    final label = planLabels[planCode] ?? '免费版';

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: theme.gradient,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: theme.accent.withAlpha(60), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(40),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(theme.icon, size: 22, color: Colors.white),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -0.3)),
                    const SizedBox(height: 3),
                    Text(
                      detail.expireText,
                      style: TextStyle(fontSize: 12, color: Colors.white.withAlpha(180)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(40),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  detail.statusText,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ],
          ),
          if (detail.isActive && detail.expireTime != null) ...[
            const SizedBox(height: 18),
            // 到期进度条
            _buildExpiryProgress(detail),
          ],
        ],
      ),
    );
  }

  Widget _buildExpiryProgress(MembershipDetailData detail) {
    if (detail.startTime == null || detail.expireTime == null) return const SizedBox.shrink();
    final total = detail.expireTime!.difference(detail.startTime!).inDays;
    final elapsed = DateTime.now().difference(detail.startTime!).inDays;
    final remaining = detail.expireTime!.difference(DateTime.now()).inDays;
    final progress = total > 0 ? (elapsed / total).clamp(0.0, 1.0) : 0.0;

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 5,
            backgroundColor: Colors.white.withAlpha(40),
            valueColor: const AlwaysStoppedAnimation(Colors.white),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('已使用 $elapsed 天', style: TextStyle(fontSize: 11, color: Colors.white.withAlpha(160))),
            Text('剩余 $remaining 天', style: TextStyle(fontSize: 11, color: Colors.white.withAlpha(160))),
          ],
        ),
      ],
    );
  }

  // ==================== AI额度网格 ====================
  Widget _buildQuotaGrid(bool isDark) {
    final detail = _currentDetail!;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(PhosphorIcons.lightning(), size: 16, color: isDark ? const Color(0xFFFBBF24) : const Color(0xFFD97706)),
              const SizedBox(width: 8),
              Text(
                '今日 AI 额度',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: isDark ? const Color(0xFFE2E8F0) : const Color(0xFF334155)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = (constraints.maxWidth - 12) / 2;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: aiFeatures.map((f) {
                  final q = detail.quotas[f.key];
                  final isUnlimited = q == null || q.isUnlimited;
                  final color = _featureColor(f.key);

                  return SizedBox(
                    width: itemWidth,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF0F172A) : color.withAlpha(12),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: isDark ? const Color(0xFF334155) : color.withAlpha(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 32, height: 32,
                                decoration: BoxDecoration(
                                  color: color.withAlpha(isDark ? 40 : 25),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(_featureIcon(f.key), size: 16, color: color),
                              ),
                              const Spacer(),
                              if (isUnlimited)
                                Icon(PhosphorIcons.infinity(), size: 18, color: Colors.grey[isDark ? 500 : 400]),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(f.label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569))),
                          const SizedBox(height: 3),
                          if (isUnlimited)
                            Text('无限', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: isDark ? Colors.white : const Color(0xFF0F172A)))
                          else ...[
                            Text(
                              '${q.dailyRemaining}/${q.dailyLimit}',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: isDark ? Colors.white : const Color(0xFF0F172A)),
                            ),
                            const SizedBox(height: 6),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: LinearProgressIndicator(
                                value: 1.0 - q.dailyUsageRatio,
                                minHeight: 4,
                                backgroundColor: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                                valueColor: AlwaysStoppedAnimation(color),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  // ==================== 区域标题 ====================
  Widget _buildSectionTitle(String title, PhosphorIconData icon, bool isDark) {
    return Row(
      children: [
        Icon(icon, size: 18, color: isDark ? const Color(0xFFFBBF24) : const Color(0xFFD97706)),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }

  // ==================== 计划卡片 ====================
  Widget _buildPlanCard(MembershipPlanData plan, bool isDark) {
    final theme = _planThemes[plan.code] ?? _planThemes['FREE']!;
    final isCurrent = _currentDetail != null &&
        (_currentDetail!.isActive || _currentDetail!.isFree) &&
        _currentDetail!.planCode == plan.code;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isCurrent ? theme.accent : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
          width: isCurrent ? 1.5 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // 渐变头部
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: theme.gradient,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 左：图标 + 信息
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(35),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(theme.icon, size: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        planLabels[plan.code] ?? plan.name,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -0.3),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            plan.isFree ? '免费' : '¥${plan.price.toStringAsFixed(plan.price == plan.price.roundToDouble() ? 0 : 2)}',
                            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white, height: 1),
                          ),
                          if (!plan.isFree)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3, left: 3),
                              child: Text(' / ${plan.durationText}', style: TextStyle(fontSize: 13, color: Colors.white.withAlpha(190))),
                            ),
                        ],
                      ),
                      if (plan.description.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(plan.description, style: TextStyle(fontSize: 12, color: Colors.white.withAlpha(180))),
                      ],
                    ],
                  ),
                ),
                // 右：当前标签
                if (isCurrent)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(PhosphorIcons.checkCircle(), size: 12, color: theme.accent),
                        const SizedBox(width: 4),
                        Text('当前', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: theme.accent)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          // 配额明细
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
            child: Column(
              children: [
                ...aiFeatures.map((f) {
                  final q = plan.quotas[f.key];
                  final color = _featureColor(f.key);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Icon(_featureIcon(f.key), size: 15, color: color),
                        const SizedBox(width: 10),
                        Text(f.label, style: TextStyle(fontSize: 13, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
                        const Spacer(),
                        Text(
                          q != null ? q.format() : '无限',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: isDark ? Colors.white : const Color(0xFF0F172A)),
                        ),
                      ],
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Divider(height: 1, color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9)),
                ),
                Row(
                  children: [
                    Icon(PhosphorIcons.video(), size: 15, color: const Color(0xFF06B6D4)),
                    const SizedBox(width: 10),
                    Text('会员课程', style: TextStyle(fontSize: 13, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
                    const Spacer(),
                    Icon(
                      plan.courseMemberAccess ? PhosphorIcons.checkCircle() : PhosphorIcons.xCircle(),
                      size: 16,
                      color: plan.courseMemberAccess ? const Color(0xFF16A34A) : const Color(0xFF94A3B8),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                // 操作按钮
                _buildPlanButton(plan, isCurrent, theme, isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanButton(MembershipPlanData plan, bool isCurrent, _PlanTheme theme, bool isDark) {
    if (isCurrent) {
      return SizedBox(
        width: double.infinity,
        height: 46,
        child: OutlinedButton(
          onPressed: null,
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            side: BorderSide(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
          ),
          child: Text('当前方案', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isDark ? const Color(0xFF475569) : const Color(0xFF94A3B8))),
        ),
      );
    }
    if (plan.isFree) return const SizedBox.shrink();

    return SizedBox(
      width: double.infinity,
      height: 46,
      child: FilledButton(
        onPressed: _purchasingPlanId != null ? null : () => _handlePurchase(plan),
        style: FilledButton.styleFrom(
          backgroundColor: theme.accent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: _purchasingPlanId == plan.id
            ? const SizedBox(width: 20, height: 20, child: LoadingWidget(size: 20, color: Colors.white))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(PhosphorIcons.lightning(), size: 16, color: Colors.white),
                  const SizedBox(width: 6),
                  const Text('立即开通', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                ],
              ),
      ),
    );
  }

  // ==================== 会员历史 ====================
  Widget _buildHistorySection(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _showHistory = !_showHistory),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              child: Row(
                children: [
                  Icon(PhosphorIcons.clockCounterClockwise(), size: 18, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                  const SizedBox(width: 10),
                  Text(
                    '会员记录',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: isDark ? Colors.white : const Color(0xFF0F172A)),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('${_history.length}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
                  ),
                  const Spacer(),
                  AnimatedRotation(
                    turns: _showHistory ? 0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(PhosphorIcons.caretRight(), size: 16, color: isDark ? const Color(0xFF475569) : const Color(0xFF94A3B8)),
                  ),
                ],
              ),
            ),
          ),
          if (_showHistory) ...[
            Divider(height: 1, color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9)),
            if (_history.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36),
                child: Column(
                  children: [
                    Icon(PhosphorIcons.receipt(), size: 32, color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1)),
                    const SizedBox(height: 8),
                    Text('暂无会员记录', style: TextStyle(fontSize: 13, color: isDark ? const Color(0xFF475569) : const Color(0xFF94A3B8))),
                  ],
                ),
              )
            else
              ..._history.map((m) => _buildHistoryItem(m, isDark)),
          ],
        ],
      ),
    );
  }

  Widget _buildHistoryItem(MembershipHistoryItem item, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9))),
      ),
      child: Row(
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(PhosphorIcons.receipt(), size: 14, color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.orderNo ?? '—',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? Colors.white : const Color(0xFF0F172A)),
                ),
                const SizedBox(height: 2),
                Text(
                  '${item.startTime != null ? _formatDate(item.startTime!) : '—'}'
                  ' ~ ${item.expireTime != null ? _formatDate(item.expireTime!) : '永久'}',
                  style: TextStyle(fontSize: 11, color: isDark ? const Color(0xFF475569) : const Color(0xFF94A3B8)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _statusColor(item.status).withAlpha(isDark ? 30 : 20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              item.statusText,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _statusColor(item.status)),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== 支付说明 ====================
  Widget _buildPaymentInfo(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF0F9FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDark ? const Color(0xFF1E3A5F) : const Color(0xFFBAE6FD)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(PhosphorIcons.info(), size: 18, color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF0284C7)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '支付说明',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: isDark ? const Color(0xFF93C5FD) : const Color(0xFF0369A1)),
                ),
                const SizedBox(height: 4),
                Text(
                  '目前支持线下支付，购买后请联系管理员确认收款，确认后会员即刻生效。',
                  style: TextStyle(fontSize: 12, color: isDark ? const Color(0xFF7DD3FC) : const Color(0xFF0284C7), height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== 工具方法 ====================
  Color _statusColor(String? status) {
    switch (status) {
      case 'PENDING': return const Color(0xFFD97706);
      case 'ACTIVE': return const Color(0xFF16A34A);
      case 'EXPIRED': return const Color(0xFF64748B);
      case 'CANCELLED': return const Color(0xFFDC2626);
      default: return const Color(0xFF64748B);
    }
  }

  String _formatDate(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }
}
