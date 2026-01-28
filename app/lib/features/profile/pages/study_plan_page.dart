import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../../core/database/models/study_plan.dart';
import '../../../core/database/repositories/study_plan_repository.dart';
import '../../../widgets/toast/nova_message.dart';

/// 学习计划页面 - 查看历史计划
class StudyPlanPage extends StatefulWidget {
  const StudyPlanPage({super.key});

  @override
  State<StudyPlanPage> createState() => _StudyPlanPageState();
}

class _StudyPlanPageState extends State<StudyPlanPage> {
  final StudyPlanRepository _repository = StudyPlanRepository();
  Map<String, List<StudyPlan>> _groupedPlans = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPlans();
  }

  Future<void> _loadPlans() async {
    setState(() => _isLoading = true);
    try {
      final grouped = await _repository.getHistoryGroupedByDate(limit: 100);
      if (mounted) {
        setState(() {
          _groupedPlans = grouped;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        NovaMessage.error(context, '加载失败: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: colors.iconPrimary, size: 20),
        ),
        title: Text(
          '学习计划历史',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const LoadingWidget(message: '加载中...')
          : _groupedPlans.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(
                  onRefresh: _loadPlans,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _groupedPlans.length,
                    itemBuilder: (context, index) {
                      final dateKey = _groupedPlans.keys.elementAt(index);
                      final plans = _groupedPlans[dateKey]!;
                      return _buildDateSection(dateKey, plans);
                    },
                  ),
                ),
    );
  }

  Widget _buildEmptyState() {
    final colors = context.colors;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_note_outlined,
            size: 80,
            color: colors.iconSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            '暂无学习计划',
            style: TextStyle(
              fontSize: 16,
              color: colors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '快去添加你的第一个学习计划吧',
            style: TextStyle(
              fontSize: 14,
              color: colors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSection(String dateKey, List<StudyPlan> plans) {
    final colors = context.colors;
    final completedCount = plans.where((p) => p.isCompleted).length;
    final isToday = _isToday(dateKey);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isToday ? const Color(0xFF3B82F6) : colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isToday ? '今天' : _formatDateDisplay(dateKey),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isToday ? Colors.white : colors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '$completedCount/${plans.length} 已完成',
                style: TextStyle(
                  fontSize: 13,
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        ...plans.map((plan) => _buildPlanItem(plan)),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildPlanItem(StudyPlan plan) {
    final colors = context.colors;
    final priorityColor = _getPriorityColor(plan.priority);
    
    return Dismissible(
      key: Key('plan_${plan.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: colors.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await _showDeleteConfirm();
      },
      onDismissed: (direction) => _deletePlan(plan),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: plan.isCompleted ? colors.success.withOpacity(0.3) : colors.border,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _toggleComplete(plan),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // 完成状态
                  GestureDetector(
                    onTap: () => _toggleComplete(plan),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: plan.isCompleted ? colors.success : Colors.transparent,
                        border: Border.all(
                          color: plan.isCompleted ? colors.success : colors.border,
                          width: 2,
                        ),
                      ),
                      child: plan.isCompleted
                          ? const Icon(Icons.check, size: 16, color: Colors.white)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // 优先级标识
                  if (plan.priority > 0)
                    Container(
                      width: 4,
                      height: 32,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: priorityColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  // 内容
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plan.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
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
                              color: colors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  // 优先级标签
                  if (plan.priority > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: priorityColor.withOpacity(0.1),
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
          ),
        ),
      ),
    );
  }

  Future<void> _toggleComplete(StudyPlan plan) async {
    try {
      await _repository.toggleComplete(plan.id!, !plan.isCompleted);
      await _loadPlans();
      if (mounted) {
        NovaMessage.success(context, plan.isCompleted ? '已取消完成' : '已完成');
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '操作失败');
      }
    }
  }

  Future<bool> _showDeleteConfirm() async {
    final colors = context.colors;
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('确认删除', style: TextStyle(color: colors.textPrimary)),
        content: Text('确定要删除这个学习计划吗？', style: TextStyle(color: colors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('取消', style: TextStyle(color: colors.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('删除', style: TextStyle(color: colors.error)),
          ),
        ],
      ),
    ) ?? false;
  }

  Future<void> _deletePlan(StudyPlan plan) async {
    try {
      await _repository.delete(plan.id!);
      if (mounted) {
        NovaMessage.success(context, '已删除');
      }
    } catch (e) {
      await _loadPlans();
      if (mounted) {
        NovaMessage.error(context, '删除失败');
      }
    }
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 2:
        return const Color(0xFFEF4444); // 紧急 - 红色
      case 1:
        return const Color(0xFFF59E0B); // 重要 - 橙色
      default:
        return const Color(0xFF3B82F6); // 普通 - 蓝色
    }
  }

  bool _isToday(String dateKey) {
    final now = DateTime.now();
    final todayStr = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    return dateKey == todayStr;
  }

  String _formatDateDisplay(String dateKey) {
    final parts = dateKey.split('-');
    if (parts.length == 3) {
      return '${parts[1]}月${parts[2]}日';
    }
    return dateKey;
  }
}
