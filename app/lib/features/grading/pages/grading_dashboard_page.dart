import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';
import '../services/grading_service.dart';
import 'grading_submit_page.dart';

/// 学习画像中心页
class GradingDashboardPage extends StatefulWidget {
  const GradingDashboardPage({super.key});

  @override
  State<GradingDashboardPage> createState() => _GradingDashboardPageState();
}

class _GradingDashboardPageState extends State<GradingDashboardPage> {
  final _gradingService = GradingService();
  GradingStatsData? _stats;
  List<SubjectProfileData> _profiles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final results = await Future.wait([
      _gradingService.getStats(),
      _gradingService.getAllProfiles(),
    ]);
    if (mounted) {
      setState(() {
        _stats = results[0] as GradingStatsData?;
        _profiles = results[1] as List<SubjectProfileData>;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text('学习画像中心', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
        backgroundColor: colors.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colors.textPrimary),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const GradingSubmitPage()),
            ),
            icon: Icon(Icons.edit_note, color: AppTheme.brand, size: 20),
            label: Text('开始批改', style: TextStyle(color: AppTheme.brand, fontWeight: FontWeight.bold, fontSize: 13)),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(colors),
    );
  }

  Widget _buildContent(AppColors colors) {
    final hasData = _stats != null && (_stats!.totalSubmissions > 0);

    if (!hasData) {
      return _buildEmptyState(colors);
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverviewCards(colors),
            const SizedBox(height: 20),
            if (_stats!.scoreTrend.isNotEmpty) ...[
              _buildScoreTrendChart(colors),
              const SizedBox(height: 20),
            ],
            if (_stats!.subjectScoreRates.isNotEmpty) ...[
              _buildSubjectScoreCard(colors),
              const SizedBox(height: 20),
            ],
            if (_stats!.errorDistribution.isNotEmpty) ...[
              _buildErrorDistributionCard(colors),
              const SizedBox(height: 20),
            ],
            if (_profiles.isNotEmpty) ...[
              _buildKnowledgeProfileSection(colors),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(AppColors colors) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: colors.surface,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.bar_chart, size: 40, color: colors.textTertiary),
            ),
            const SizedBox(height: 20),
            Text('暂无学情数据', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colors.textPrimary)),
            const SizedBox(height: 8),
            Text(
              '通过智能批改提交作业后\nAI 将自动为你生成多维度的学习报告',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: colors.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const GradingSubmitPage()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.brand,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: const Text('立即开启第一次批改', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== 概览卡片 ====================

  Widget _buildOverviewCards(AppColors colors) {
    final weakPointTotal = _profiles.fold<int>(0, (sum, p) => sum + p.weakPointCount);
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.6,
      children: [
        _OverviewCard(
          icon: Icons.menu_book_outlined,
          label: '累计批改',
          value: '${_stats!.totalSubmissions}',
          unit: '次',
          color: AppTheme.brand,
          colors: colors,
        ),
        _OverviewCard(
          icon: Icons.gps_fixed,
          label: '平均得分率',
          value: '${(_stats!.avgScoreRate * 100).toInt()}',
          unit: '%',
          color: Colors.green,
          colors: colors,
        ),
        _OverviewCard(
          icon: Icons.emoji_events_outlined,
          label: '覆盖学科',
          value: '${_stats!.subjectScoreRates.length}',
          unit: '门',
          color: Colors.blue,
          colors: colors,
        ),
        _OverviewCard(
          icon: Icons.warning_amber_outlined,
          label: '薄弱知识点',
          value: '$weakPointTotal',
          unit: '个',
          color: Colors.red,
          colors: colors,
        ),
      ],
    );
  }

  // ==================== 得分趋势 ====================

  Widget _buildScoreTrendChart(AppColors colors) {
    final data = _stats!.scoreTrend;
    final maxVal = data.fold<int>(0, (max, d) => d.maxScore != null && d.maxScore! > max ? d.maxScore! : max);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.brand.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.trending_up, color: AppTheme.brand, size: 18),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('最近批改得分趋势', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.textPrimary)),
                  Text('展示最近 10 次提交', style: TextStyle(fontSize: 10, color: colors.textTertiary)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: data.map((item) {
                final score = item.score ?? 0;
                final max = item.maxScore ?? 100;
                final pct = maxVal > 0 ? (score / maxVal) : 0.0;
                final rate = max > 0 ? score / max : 0.0;
                final barColor = rate >= 0.8 ? Colors.green : rate >= 0.6 ? Colors.orange : Colors.red;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '$score',
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: colors.textTertiary),
                        ),
                        const SizedBox(height: 4),
                        Flexible(
                          child: FractionallySizedBox(
                            heightFactor: pct.clamp(0.08, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: barColor,
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDate(item.createTime),
                          style: TextStyle(fontSize: 8, color: colors.textTertiary),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final dt = DateTime.parse(dateStr);
      return '${dt.month}/${dt.day}';
    } catch (_) {
      return '';
    }
  }

  // ==================== 学科得分分布 ====================

  Widget _buildSubjectScoreCard(AppColors colors) {
    final sorted = _stats!.subjectScoreRates.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.bar_chart, color: Colors.green, size: 18),
              ),
              const SizedBox(width: 10),
              Text('学科得分分布', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.textPrimary)),
            ],
          ),
          const SizedBox(height: 16),
          ...sorted.map((entry) {
            final name = subjectNames[entry.key] ?? entry.key;
            final rate = entry.value;
            final barColor = rate >= 0.8 ? Colors.green : rate >= 0.6 ? Colors.orange : Colors.red;

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: colors.textPrimary)),
                      Text(
                        '${(rate * 100).toInt()}%',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: barColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: rate,
                      backgroundColor: colors.border,
                      valueColor: AlwaysStoppedAnimation(barColor),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ==================== 错因分布 ====================

  Widget _buildErrorDistributionCard(AppColors colors) {
    final data = _stats!.errorDistribution;
    final maxCount = data.fold<int>(0, (max, d) => d.count > max ? d.count : max);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.warning_amber, color: Colors.red, size: 18),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('错因深度剖析', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.textPrimary)),
                  Text('识别频繁出现的错误类型', style: TextStyle(fontSize: 10, color: colors.textTertiary)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...data.take(10).map((item) {
            final pct = maxCount > 0 ? item.count / maxCount : 0.0;
            final name = errorCategoryNames[item.category ?? ''] ?? item.categoryName ?? item.category ?? '';

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.textSecondary)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: colors.background,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('${item.count} 次', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: colors.textTertiary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: pct,
                      backgroundColor: colors.border,
                      valueColor: const AlwaysStoppedAnimation(Colors.red),
                      minHeight: 4,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ==================== 知识掌握度 ====================

  Widget _buildKnowledgeProfileSection(AppColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 4, height: 18, decoration: BoxDecoration(color: AppTheme.brand, borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 8),
            Text('各学科知识掌握度', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colors.textPrimary)),
          ],
        ),
        const SizedBox(height: 14),
        ...List.generate(_profiles.length, (i) => _buildSubjectProfileCard(_profiles[i], colors)),
      ],
    );
  }

  Widget _buildSubjectProfileCard(SubjectProfileData profile, AppColors colors) {
    final mastery = profile.avgMasteryLevel;
    final masteryColor = mastery >= 0.8 ? Colors.green : mastery >= 0.6 ? Colors.orange : Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题行
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                profile.subjectName ?? subjectNames[profile.subject ?? ''] ?? profile.subject ?? '',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: colors.textPrimary),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: masteryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: masteryColor.withValues(alpha: 0.2)),
                ),
                child: Text(
                  '掌握度 ${(mastery * 100).toInt()}%',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: masteryColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 统计行
          Row(
            children: [
              _buildProfileStat('知识点', '${profile.totalPoints}', colors.textPrimary, colors),
              const SizedBox(width: 16),
              _buildProfileStat('薄弱', '${profile.weakPointCount}', Colors.red, colors),
              const SizedBox(width: 16),
              _buildProfileStat('优势', '${profile.strongPointCount}', Colors.green, colors),
            ],
          ),
          const SizedBox(height: 12),
          // 掌握度条
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: mastery,
              backgroundColor: colors.border,
              valueColor: AlwaysStoppedAnimation(masteryColor),
              minHeight: 5,
            ),
          ),
          // 薄弱知识点
          if (profile.weakPoints.isNotEmpty) ...[
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(Icons.warning_amber, size: 12, color: Colors.red.shade300),
                const SizedBox(width: 4),
                Text('待攻克知识点', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.red.shade300)),
              ],
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: profile.weakPoints.take(4).map((wp) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.withValues(alpha: 0.1)),
                ),
                child: Text(
                  wp.knowledgePoint ?? '',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.red.shade600),
                ),
              )).toList(),
            ),
          ],
          // 优势知识点
          if (profile.strongPoints.isNotEmpty) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.emoji_events, size: 12, color: Colors.green.shade400),
                const SizedBox(width: 4),
                Text('优势知识点', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.green.shade400)),
              ],
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: profile.strongPoints.take(4).map((sp) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.withValues(alpha: 0.1)),
                ),
                child: Text(
                  sp.knowledgePoint ?? '',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.green.shade600),
                ),
              )).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProfileStat(String label, String value, Color valueColor, AppColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: valueColor)),
        Text(label, style: TextStyle(fontSize: 9, color: colors.textTertiary, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

// ==================== 概览卡片组件 ====================

class _OverviewCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final Color color;
  final AppColors colors;

  const _OverviewCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: colors.textPrimary)),
              const SizedBox(width: 2),
              Text(unit, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: colors.textTertiary)),
            ],
          ),
          Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: colors.textTertiary)),
        ],
      ),
    );
  }
}
