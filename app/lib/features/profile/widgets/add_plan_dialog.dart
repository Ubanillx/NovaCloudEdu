import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import '../../../config/app_theme.dart';
import '../../../core/database/models/study_plan.dart';

/// 添加/编辑学习计划对话框
class AddPlanDialog extends StatefulWidget {
  final StudyPlan? plan; // 编辑时传入

  const AddPlanDialog({super.key, this.plan});

  @override
  State<AddPlanDialog> createState() => _AddPlanDialogState();
}

class _AddPlanDialogState extends State<AddPlanDialog> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  int _priority = 0;
  DateTime _targetDate = DateTime.now();

  bool get isEditing => widget.plan != null;

  @override
  void initState() {
    super.initState();
    if (widget.plan != null) {
      _titleController.text = widget.plan!.title;
      _descController.text = widget.plan!.description ?? '';
      _priority = widget.plan!.priority;
      _targetDate = widget.plan!.targetDate;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Dialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            Row(
              children: [
                Icon(
                  isEditing ? Icons.edit_note_rounded : Icons.add_task_rounded,
                  color: colors.info,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  isEditing ? '编辑计划' : '添加学习计划',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 计划标题
            Text(
              '计划内容',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              style: TextStyle(color: colors.textPrimary),
              decoration: InputDecoration(
                hintText: '请输入学习计划',
                hintStyle: TextStyle(color: colors.textTertiary),
                filled: true,
                fillColor: colors.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 16),

            // 描述（可选）
            Text(
              '备注（可选）',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              style: TextStyle(color: colors.textPrimary),
              maxLines: 2,
              decoration: InputDecoration(
                hintText: '添加备注信息',
                hintStyle: TextStyle(color: colors.textTertiary),
                filled: true,
                fillColor: colors.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 16),

            // 优先级
            Text(
              '优先级',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildPriorityChip(0, '普通', colors.info),
                const SizedBox(width: 8),
                _buildPriorityChip(1, '重要', const Color(0xFFF59E0B)),
                const SizedBox(width: 8),
                _buildPriorityChip(2, '紧急', const Color(0xFFEF4444)),
              ],
            ),
            const SizedBox(height: 16),

            // 目标日期
            Text(
              '目标日期',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _selectDate,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_rounded, size: 20, color: colors.iconSecondary),
                    const SizedBox(width: 12),
                    Text(
                      _formatDate(_targetDate),
                      style: TextStyle(
                        fontSize: 15,
                        color: colors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.chevron_right_rounded, color: colors.iconSecondary),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 按钮
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: colors.border),
                      ),
                    ),
                    child: Text(
                      '取消',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.info,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      isEditing ? '保存' : '添加',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityChip(int value, String label, Color color) {
    final colors = context.colors;
    final isSelected = _priority == value;

    return GestureDetector(
      onTap: () => setState(() => _priority = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.15) : colors.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? color : colors.textSecondary,
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final initialDate = [_targetDate.year, _targetDate.month, _targetDate.day];
    final now = DateTime.now();
    
    TDPicker.showDatePicker(
      context,
      title: '选择目标日期',
      onConfirm: (selected) {
        setState(() {
          _targetDate = DateTime(
            selected['year']!,
            selected['month']!,
            selected['day']!,
          );
        });
        Navigator.of(context).pop();
      },
      onCancel: (selected) {
        Navigator.of(context).pop();
      },
      dateStart: [now.year - 1, now.month, now.day],
      dateEnd: [now.year + 1, now.month, now.day],
      initialDate: initialDate,
    );
  }

  void _submit() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入计划内容')),
      );
      return;
    }

    final plan = StudyPlan(
      id: widget.plan?.id,
      title: title,
      description: _descController.text.trim().isEmpty ? null : _descController.text.trim(),
      targetDate: _targetDate,
      priority: _priority,
      isCompleted: widget.plan?.isCompleted ?? false,
      completedAt: widget.plan?.completedAt,
      createdAt: widget.plan?.createdAt,
    );

    Navigator.pop(context, plan);
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return '今天';
    }
    final tomorrow = now.add(const Duration(days: 1));
    if (date.year == tomorrow.year && date.month == tomorrow.month && date.day == tomorrow.day) {
      return '明天';
    }
    return '${date.year}年${date.month}月${date.day}日';
  }
}
