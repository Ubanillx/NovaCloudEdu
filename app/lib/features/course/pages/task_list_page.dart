import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import '../../../config/app_theme.dart';
import '../../../core/database/models/study_plan.dart';
import '../../../core/database/repositories/study_plan_repository.dart';
import '../../../widgets/toast/nova_message.dart';
import '../../../widgets/common/nova_refresh_header.dart';
import '../../../widgets/common/skeleton_widgets.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/dialogs/app_dialog.dart';
import '../../../widgets/cards/app_card.dart';
import '../../../widgets/common/empty_widget.dart';
import '../../profile/widgets/add_plan_dialog.dart';
import '../../profile/pages/study_plan_page.dart';

/// 任务清单页面 - 与个人中心的今日学习计划同步
class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final StudyPlanRepository _planRepository = StudyPlanRepository();
  List<StudyPlan> _todayPlans = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTodayPlans();
  }

  Future<void> _loadTodayPlans() async {
    try {
      final plans = await _planRepository.getTodayPlans();
      if (mounted) {
        setState(() {
          _todayPlans = plans;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _addPlan() async {
    final result = await showDialog<StudyPlan>(
      context: context,
      builder: (context) => const AddPlanDialog(),
    );
    if (result != null) {
      try {
        await _planRepository.insert(result);
        await _loadTodayPlans();
        if (mounted) {
          NovaMessage.success(context, '添加成功');
        }
      } catch (e) {
        if (mounted) {
          NovaMessage.error(context, '添加失败');
        }
      }
    }
  }

  Future<void> _togglePlanComplete(StudyPlan plan) async {
    try {
      await _planRepository.toggleComplete(plan.id!, !plan.isCompleted);
      await _loadTodayPlans();
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '操作失败');
      }
    }
  }

  Future<void> _deletePlan(StudyPlan plan) async {
    try {
      await _planRepository.delete(plan.id!);
      await _loadTodayPlans();
      if (mounted) {
        NovaMessage.success(context, '已删除');
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '删除失败');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final completedCount = _todayPlans.where((p) => p.isCompleted).length;
    final progress = _todayPlans.isEmpty ? 0.0 : completedCount / _todayPlans.length;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(PhosphorIcons.caretLeft(), color: colors.iconPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '今日任务',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(PhosphorIcons.clockCounterClockwise(), color: colors.iconPrimary, size: 22),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const StudyPlanPage()),
              ).then((_) => _loadTodayPlans());
            },
            tooltip: '历史记录',
          ),
        ],
      ),
      body: NovaRefreshableList(
        onRefresh: _loadTodayPlans,
        slivers: [
          // 进度卡片
          SliverToBoxAdapter(child: _buildProgressCard(progress, completedCount)),
          // 任务列表
          SliverToBoxAdapter(child: _buildTaskList()),
          // 底部间距
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: PrimaryButton(
          text: '添加学习任务',
          onTap: _addPlan,
          size: TDButtonSize.large,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildProgressCard(double progress, int completedCount) {
    final totalCount = _todayPlans.length;
    final colors = context.colors;

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '今日学习进度',
                    style: TextStyle(
                      fontSize: 14,
                      color: colors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      color: colors.textPrimary,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppTheme.brand.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 6,
                        backgroundColor: AppTheme.brand.withValues(alpha: 0.1),
                        valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.brand),
                      ),
                    ),
                    Icon(
                      PhosphorIcons.sparkle(),
                      color: AppTheme.brand,
                      size: 28,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatBadge(PhosphorIcons.checkCircle(PhosphorIconsStyle.fill), '$completedCount', '已达成', colors.success),
              const SizedBox(width: 12),
              _buildStatBadge(PhosphorIcons.circle(), '${totalCount - completedCount}', '进行中', AppTheme.brand),
              const SizedBox(width: 12),
              _buildStatBadge(PhosphorIcons.listBullets(), '$totalCount', '总任务', colors.textSecondary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBadge(IconData icon, String value, String label, Color color) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colors.surfaceVariant.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    final colors = context.colors;

    if (_isLoading) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: const ListItemSkeleton(itemCount: 4, showAvatar: false),
      );
    }

    if (_todayPlans.isEmpty) {
      return _buildEmptyState();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              '任务列表',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
          ),
          ..._todayPlans.map((plan) => _buildTaskItem(plan)),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 80),
      child: EmptyWidget(
        message: '今天还没有学习任务\n点击下方按钮添加一个吧',
      ),
    );
  }

  Widget _buildTaskItem(StudyPlan plan) {
    final colors = context.colors;
    final priorityColor = _getPriorityColor(plan.priority);

    return Dismissible(
      key: Key('task_${plan.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: colors.error,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Icon(PhosphorIcons.trash(), color: Colors.white, size: 24),
      ),
      confirmDismiss: (direction) async {
        return await showConfirmDialog(
          context,
          title: '确认删除',
          content: '确定要删除这个任务吗？',
          isDanger: true,
        );
      },
      onDismissed: (direction) => _deletePlan(plan),
      child: AppCard(
        onTap: () => _togglePlanComplete(plan),
        margin: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
        padding: const EdgeInsets.all(16),
        borderRadius: 24,
        child: Row(
          children: [
            // 完成状态按钮
            GestureDetector(
              onTap: () => _togglePlanComplete(plan),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: plan.isCompleted ? colors.success : Colors.transparent,
                  border: Border.all(
                    color: plan.isCompleted ? colors.success : colors.border,
                    width: 2,
                  ),
                ),
                child: plan.isCompleted
                    ? Icon(PhosphorIcons.check(), size: 18, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(width: 14),
            // 内容
            Expanded(
              child: Opacity(
                opacity: plan.isCompleted ? 0.6 : 1.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: plan.isCompleted ? FontWeight.w500 : FontWeight.w600,
                        color: plan.isCompleted ? colors.textTertiary : colors.textPrimary,
                        decoration: plan.isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    if (plan.description != null && plan.description!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        plan.description!,
                        style: TextStyle(
                          fontSize: 13,
                          color: colors.textTertiary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            // 优先级标签
            if (plan.priority > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: priorityColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  plan.priorityText,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: priorityColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 2:
        return const Color(0xFFEF4444); // 紧急 - 红色
      case 1:
        return const Color(0xFFF59E0B); // 重要 - 橙色
      default:
        return context.colors.info; // 普通 - 蓝色
    }
  }
}
