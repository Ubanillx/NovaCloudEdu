import 'dart:math';
import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';
import '../services/grading_service.dart';

/// 批改结果页
class GradingResultPage extends StatefulWidget {
  final String submissionId;

  const GradingResultPage({super.key, required this.submissionId});

  @override
  State<GradingResultPage> createState() => _GradingResultPageState();
}

class _GradingResultPageState extends State<GradingResultPage> {
  final _gradingService = GradingService();
  GradingResultData? _result;
  bool _isLoading = true;
  final Set<int> _expandedQuestions = {};

  @override
  void initState() {
    super.initState();
    _loadResult();
  }

  Future<void> _loadResult() async {
    final result = await _gradingService.getGradingResult(widget.submissionId);
    if (mounted) {
      setState(() {
        _result = result;
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
        title: Text('批改报告', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
        backgroundColor: colors.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colors.textPrimary),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _result == null
              ? Center(child: Text('暂无批改结果', style: TextStyle(color: colors.textSecondary)))
              : _buildContent(colors),
    );
  }

  Widget _buildContent(AppColors colors) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildScoreOverview(colors),
          const SizedBox(height: 20),
          if (_result!.overallComment != null) ...[
            _buildOverallComment(colors),
            const SizedBox(height: 20),
          ],
          _buildQuestionsList(colors),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // ==================== 得分概览 ====================

  Widget _buildScoreOverview(AppColors colors) {
    final r = _result!;
    final rate = r.scoreRate;
    final ratePercent = (rate * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        children: [
          // 分数环
          SizedBox(
            width: 140,
            height: 140,
            child: CustomPaint(
              painter: _ScoreRingPainter(
                progress: rate,
                color: rate >= 0.8
                    ? Colors.green
                    : rate >= 0.6
                        ? Colors.orange
                        : Colors.red,
                backgroundColor: colors.border,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${r.totalScore}',
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: colors.textPrimary),
                    ),
                    Text(
                      '/ ${r.maxScore}',
                      style: TextStyle(fontSize: 14, color: colors.textSecondary, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // 统计行
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem('得分率', '$ratePercent%', rate >= 0.8 ? Colors.green : rate >= 0.6 ? Colors.orange : Colors.red, colors),
              Container(width: 1, height: 32, color: colors.border),
              _buildStatItem('正确', '${r.correctCount}', Colors.green, colors),
              Container(width: 1, height: 32, color: colors.border),
              _buildStatItem('部分', '${r.partialCount}', Colors.orange, colors),
              Container(width: 1, height: 32, color: colors.border),
              _buildStatItem('错误', '${r.wrongCount}', Colors.red, colors),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color, AppColors colors) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: color)),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 11, color: colors.textTertiary, fontWeight: FontWeight.w500)),
      ],
    );
  }

  // ==================== 总评 ====================

  Widget _buildOverallComment(AppColors colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.brand.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.brand.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: AppTheme.brand, size: 18),
              const SizedBox(width: 8),
              Text('AI 总评', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.brand)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            _result!.overallComment!,
            style: TextStyle(fontSize: 14, color: colors.textPrimary, height: 1.7),
          ),
        ],
      ),
    );
  }

  // ==================== 逐题详情 ====================

  Widget _buildQuestionsList(AppColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('题目详情', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colors.textPrimary)),
        const SizedBox(height: 12),
        ...List.generate(_result!.questions.length, (i) => _buildQuestionCard(_result!.questions[i], i, colors)),
      ],
    );
  }

  Widget _buildQuestionCard(QuestionGradingData q, int index, AppColors colors) {
    final isExpanded = _expandedQuestions.contains(index);
    final statusColor = q.isCorrect ? Colors.green : q.isWrong ? Colors.red : Colors.orange;
    final statusIcon = q.isCorrect ? Icons.check_circle : q.isWrong ? Icons.cancel : Icons.warning_amber_rounded;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        children: [
          // 头部（可点击展开）
          GestureDetector(
            onTap: () => setState(() {
              if (isExpanded) {
                _expandedQuestions.remove(index);
              } else {
                _expandedQuestions.add(index);
              }
            }),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Icon(statusIcon, color: statusColor, size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '第 ${q.questionIndex} 题${q.questionType != null ? '（${q.questionType}）' : ''}',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: colors.textPrimary),
                        ),
                        if (q.comment != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            q.comment!,
                            style: TextStyle(fontSize: 12, color: colors.textSecondary),
                            maxLines: isExpanded ? null : 1,
                            overflow: isExpanded ? null : TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${q.score}/${q.maxScore}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: statusColor),
                  ),
                  const SizedBox(width: 4),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(Icons.expand_more, color: colors.iconSecondary, size: 20),
                  ),
                ],
              ),
            ),
          ),
          // 展开内容
          if (isExpanded)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: colors.border, height: 1),
                  const SizedBox(height: 12),
                  // 题目内容
                  if (q.questionContent != null) ...[
                    _buildDetailSection('题目内容', q.questionContent!, colors),
                    const SizedBox(height: 12),
                  ],
                  // 答案对比
                  if (q.studentAnswer != null || q.standardAnswer != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (q.studentAnswer != null)
                          Expanded(
                            child: _buildAnswerBox(
                              '学生答案',
                              q.studentAnswer!,
                              q.isCorrect ? Colors.green : Colors.red,
                              colors,
                            ),
                          ),
                        if (q.studentAnswer != null && q.standardAnswer != null) const SizedBox(width: 10),
                        if (q.standardAnswer != null)
                          Expanded(
                            child: _buildAnswerBox('参考答案', q.standardAnswer!, Colors.green, colors),
                          ),
                      ],
                    ),
                  // 错误分类
                  if (q.errorCategories.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text('错误类型', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.textSecondary)),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: q.errorCategories.map((cat) {
                        final name = errorCategoryNames[cat] ?? cat;
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red.withValues(alpha: 0.15)),
                          ),
                          child: Text(name, style: const TextStyle(fontSize: 11, color: Colors.red, fontWeight: FontWeight.w600)),
                        );
                      }).toList(),
                    ),
                  ],
                  // 知识点
                  if (q.knowledgePoints.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text('相关知识点', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.textSecondary)),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: q.knowledgePoints.map((kp) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.brand.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(kp, style: TextStyle(fontSize: 11, color: AppTheme.brand, fontWeight: FontWeight.w600)),
                      )).toList(),
                    ),
                  ],
                  // AI 解析
                  if (q.errorDetail != null) ...[
                    const SizedBox(height: 12),
                    _buildDetailSection('AI 深度解析', q.errorDetail!, colors),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, String content, AppColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.textSecondary)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            content,
            style: TextStyle(fontSize: 13, color: colors.textPrimary, height: 1.6),
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerBox(String label, String content, Color accentColor, AppColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.textSecondary)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: accentColor.withValues(alpha: 0.15)),
          ),
          child: Text(
            content,
            style: TextStyle(fontSize: 13, color: colors.textPrimary, height: 1.5),
          ),
        ),
      ],
    );
  }
}

// ==================== 分数环画板 ====================

class _ScoreRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;

  _ScoreRingPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    const strokeWidth = 10.0;

    // 背景环
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    // 进度环
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ScoreRingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
