import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/toast/nova_message.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../services/feedback_service.dart';

/// 创建反馈页面
class FeedbackCreatePage extends StatefulWidget {
  const FeedbackCreatePage({super.key});

  @override
  State<FeedbackCreatePage> createState() => _FeedbackCreatePageState();
}

class _FeedbackCreatePageState extends State<FeedbackCreatePage> {
  final FeedbackService _feedbackService = FeedbackService();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  String _selectedType = 'BUG';
  bool _isSubmitting = false;

  final List<Map<String, dynamic>> _feedbackTypes = [
    {'value': 'BUG', 'label': 'Bug反馈', 'icon': Icons.bug_report_rounded, 'color': const Color(0xFFEF4444)},
    {'value': 'FEATURE', 'label': '功能建议', 'icon': Icons.lightbulb_rounded, 'color': const Color(0xFF8B5CF6)},
    {'value': 'CONTENT', 'label': '内容问题', 'icon': Icons.article_rounded, 'color': const Color(0xFF3B82F6)},
    {'value': 'OTHER', 'label': '其他', 'icon': Icons.more_horiz_rounded, 'color': const Color(0xFF94A3B8)},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final response = await _feedbackService.createFeedback(
        feedbackType: _selectedType,
        content: _contentController.text.trim(),
        title: _titleController.text.trim().isEmpty ? null : _titleController.text.trim(),
      );

      if (mounted) {
        if (response.code == 0) {
          NovaMessage.success(context, '反馈提交成功');
          Navigator.of(context).pop(true);
        } else {
          NovaMessage.error(context, response.message ?? '提交失败');
        }
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '提交失败: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios_rounded, color: colors.textPrimary, size: 20),
        ),
        title: Text(
          '提交反馈',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('反馈类型', colors),
                const SizedBox(height: 12),
                _buildTypeSelector(colors),
                const SizedBox(height: 24),
                _buildSectionTitle('反馈标题（可选）', colors),
                const SizedBox(height: 12),
                _buildTitleInput(colors),
                const SizedBox(height: 24),
                _buildSectionTitle('反馈内容', colors),
                const SizedBox(height: 12),
                _buildContentInput(colors),
                const SizedBox(height: 32),
                _buildSubmitButton(colors),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, AppColors colors) {
    return Text(
      title,
      style: TextStyle(
        color: colors.textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTypeSelector(AppColors colors) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _feedbackTypes.map((type) {
        final isSelected = _selectedType == type['value'];
        final color = type['color'] as Color;

        return GestureDetector(
          onTap: () => setState(() => _selectedType = type['value']),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? color.withOpacity(context.isDarkMode ? 0.2 : 0.1)
                  : colors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? color : colors.border,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  type['icon'] as IconData,
                  size: 20,
                  color: isSelected ? color : colors.textSecondary,
                ),
                const SizedBox(width: 8),
                Text(
                  type['label'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? color : colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTitleInput(AppColors colors) {
    return TextFormField(
      controller: _titleController,
      style: TextStyle(color: colors.textPrimary, fontSize: 16),
      decoration: InputDecoration(
        hintText: '请输入反馈标题',
        hintStyle: TextStyle(color: colors.textTertiary),
        filled: true,
        fillColor: colors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildContentInput(AppColors colors) {
    return TextFormField(
      controller: _contentController,
      style: TextStyle(color: colors.textPrimary, fontSize: 16),
      maxLines: 6,
      maxLength: 500,
      decoration: InputDecoration(
        hintText: '请详细描述您遇到的问题或建议...',
        hintStyle: TextStyle(color: colors.textTertiary),
        filled: true,
        fillColor: colors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
        ),
        contentPadding: const EdgeInsets.all(16),
        counterStyle: TextStyle(color: colors.textTertiary),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '请输入反馈内容';
        }
        if (value.trim().length < 10) {
          return '反馈内容至少10个字符';
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton(AppColors colors) {
    return PrimaryButton(
      text: '提交反馈',
      onTap: _submitFeedback,
      isLoading: _isSubmitting,
    );
  }
}
