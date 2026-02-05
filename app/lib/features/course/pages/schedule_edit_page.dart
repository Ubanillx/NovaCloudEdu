import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';

import '../../../config/app_theme.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/inputs/app_input.dart';
import '../../../widgets/toast/nova_message.dart';
import '../services/schedule_service.dart';

/// 课程编辑页面（添加/编辑）
class ScheduleEditPage extends StatefulWidget {
  final ClassScheduleItemResponse? item;
  final int? defaultDayOfWeek;
  final int? defaultSection;

  const ScheduleEditPage({
    super.key,
    this.item,
    this.defaultDayOfWeek,
    this.defaultSection,
  });

  bool get isEdit => item != null;

  @override
  State<ScheduleEditPage> createState() => _ScheduleEditPageState();
}

class _ScheduleEditPageState extends State<ScheduleEditPage> {
  final ScheduleService _service = ScheduleService();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _courseNameController;
  late TextEditingController _teacherNameController;
  late TextEditingController _locationController;
  late TextEditingController _remarkController;

  int _dayOfWeek = 1;
  int _startSection = 1;
  int _endSection = 2;
  int _startWeek = 1;
  int _endWeek = 20;
  int _weekType = 0; // 0: 全部, 1: 单周, 2: 双周
  int _courseType = 0;
  Color _selectedColor = const Color(0xFF5B8FF9);

  bool _isSubmitting = false;

  final List<String> _weekDays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
  final List<String> _weekTypes = ['每周', '单周', '双周'];
  final List<String> _courseTypes = ['必修课', '选修课', '实验课', '其他'];

  final List<Color> _colorOptions = [
    const Color(0xFF5B8FF9),
    const Color(0xFF5AD8A6),
    const Color(0xFF5D7092),
    const Color(0xFFF6BD16),
    const Color(0xFFE86452),
    const Color(0xFF6DC8EC),
    const Color(0xFF945FB9),
    const Color(0xFFFF9845),
  ];

  @override
  void initState() {
    super.initState();
    _initControllers();
    _initFormData();
  }

  void _initControllers() {
    _courseNameController = TextEditingController();
    _teacherNameController = TextEditingController();
    _locationController = TextEditingController();
    _remarkController = TextEditingController();
  }

  void _initFormData() {
    if (widget.isEdit) {
      final item = widget.item!;
      _courseNameController.text = item.courseName ?? '';
      _teacherNameController.text = item.teacherName ?? '';
      _locationController.text = item.location ?? '';
      _remarkController.text = item.remark ?? '';
      _dayOfWeek = item.dayOfWeek ?? 1;
      _startSection = item.startSection ?? 1;
      _endSection = item.endSection ?? 2;
      _startWeek = item.startWeek ?? 1;
      _endWeek = item.endWeek ?? 20;
      _weekType = item.weekType ?? 0;
      _courseType = item.courseType ?? 0;

      if (item.color != null && item.color!.isNotEmpty) {
        try {
          _selectedColor = Color(int.parse(item.color!.replaceFirst('#', '0xFF')));
        } catch (_) {}
      }
    } else {
      if (widget.defaultDayOfWeek != null) {
        _dayOfWeek = widget.defaultDayOfWeek!;
      }
      if (widget.defaultSection != null) {
        _startSection = widget.defaultSection!;
        _endSection = widget.defaultSection! + 1;
        if (_endSection > 12) _endSection = 12;
      }
    }
  }

  @override
  void dispose() {
    _courseNameController.dispose();
    _teacherNameController.dispose();
    _locationController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.isEdit ? '编辑课程' : '添加课程',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSection('基本信息', colors, [
              AppInput(
                label: '课程名称',
                placeholder: '请输入课程名称',
                controller: _courseNameController,
              ),
              const SizedBox(height: 16),
              AppInput(
                label: '授课教师',
                placeholder: '请输入教师姓名（选填）',
                controller: _teacherNameController,
              ),
              const SizedBox(height: 16),
              AppInput(
                label: '上课地点',
                placeholder: '请输入教室/地点（选填）',
                controller: _locationController,
              ),
            ]),
            const SizedBox(height: 24),
            _buildSection('上课时间', colors, [
              _buildDayOfWeekSelector(colors),
              const SizedBox(height: 16),
              _buildSectionSelector(colors),
            ]),
            const SizedBox(height: 24),
            _buildSection('周次设置', colors, [
              _buildWeekRangeSelector(colors),
              const SizedBox(height: 16),
              _buildWeekTypeSelector(colors),
            ]),
            const SizedBox(height: 24),
            _buildSection('其他设置', colors, [
              _buildCourseTypeSelector(colors),
              const SizedBox(height: 16),
              _buildColorSelector(colors),
              const SizedBox(height: 16),
              AppInput(
                label: '备注',
                placeholder: '添加备注信息（选填）',
                controller: _remarkController,
                maxLines: 3,
              ),
            ]),
            const SizedBox(height: 32),
            PrimaryButton(
              text: widget.isEdit ? '保存修改' : '添加课程',
              onTap: _submit,
              isLoading: _isSubmitting,
              disabled: _isSubmitting,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, AppColors colors, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDayOfWeekSelector(AppColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '星期',
          style: TextStyle(
            fontSize: 14,
            color: colors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(7, (index) {
            final isSelected = _dayOfWeek == index + 1;
            return GestureDetector(
              onTap: () => setState(() => _dayOfWeek = index + 1),
              child: Container(
                width: 44,
                height: 36,
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.brand : colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    _weekDays[index],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? Colors.white : colors.textPrimary,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSectionSelector(AppColors colors) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '开始节次',
                style: TextStyle(fontSize: 14, color: colors.textSecondary),
              ),
              const SizedBox(height: 8),
              _buildDropdown(
                value: _startSection,
                items: List.generate(12, (i) => i + 1),
                onChanged: (v) {
                  setState(() {
                    _startSection = v!;
                    if (_endSection < _startSection) {
                      _endSection = _startSection;
                    }
                  });
                },
                colors: colors,
                labelBuilder: (v) => '第 $v 节',
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '结束节次',
                style: TextStyle(fontSize: 14, color: colors.textSecondary),
              ),
              const SizedBox(height: 8),
              _buildDropdown(
                value: _endSection,
                items: List.generate(12 - _startSection + 1, (i) => _startSection + i),
                onChanged: (v) => setState(() => _endSection = v!),
                colors: colors,
                labelBuilder: (v) => '第 $v 节',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeekRangeSelector(AppColors colors) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '开始周',
                style: TextStyle(fontSize: 14, color: colors.textSecondary),
              ),
              const SizedBox(height: 8),
              _buildDropdown(
                value: _startWeek,
                items: List.generate(20, (i) => i + 1),
                onChanged: (v) {
                  setState(() {
                    _startWeek = v!;
                    if (_endWeek < _startWeek) {
                      _endWeek = _startWeek;
                    }
                  });
                },
                colors: colors,
                labelBuilder: (v) => '第 $v 周',
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '结束周',
                style: TextStyle(fontSize: 14, color: colors.textSecondary),
              ),
              const SizedBox(height: 8),
              _buildDropdown(
                value: _endWeek,
                items: List.generate(20 - _startWeek + 1, (i) => _startWeek + i),
                onChanged: (v) => setState(() => _endWeek = v!),
                colors: colors,
                labelBuilder: (v) => '第 $v 周',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeekTypeSelector(AppColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '周类型',
          style: TextStyle(fontSize: 14, color: colors.textSecondary),
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(3, (index) {
            final isSelected = _weekType == index;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _weekType = index),
                child: Container(
                  margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.brand : colors.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      _weekTypes[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected ? Colors.white : colors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCourseTypeSelector(AppColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '课程类型',
          style: TextStyle(fontSize: 14, color: colors.textSecondary),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(_courseTypes.length, (index) {
            final isSelected = _courseType == index;
            return GestureDetector(
              onTap: () => setState(() => _courseType = index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.brand : colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _courseTypes[index],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Colors.white : colors.textPrimary,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildColorSelector(AppColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '课程颜色',
          style: TextStyle(fontSize: 14, color: colors.textSecondary),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _colorOptions.map((color) {
            final isSelected = _selectedColor.value == color.value;
            return GestureDetector(
              onTap: () => setState(() => _selectedColor = color),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: colors.textPrimary, width: 3)
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white, size: 20)
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDropdown<T>({
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    required AppColors colors,
    required String Function(T) labelBuilder,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: colors.textSecondary),
          dropdownColor: colors.surface,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                labelBuilder(item),
                style: TextStyle(
                  fontSize: 14,
                  color: colors.textPrimary,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final courseName = _courseNameController.text.trim();
    if (courseName.isEmpty) {
      NovaMessage.warning(context, '请输入课程名称');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final colorHex = '#${_selectedColor.value.toRadixString(16).substring(2).toUpperCase()}';

      if (widget.isEdit) {
        final id = int.tryParse(widget.item!.id ?? '');
        if (id == null) {
          throw Exception('无效的课程ID');
        }

        final request = UpdateScheduleItemRequest((b) => b
          ..courseName = courseName
          ..teacherName = _teacherNameController.text.trim()
          ..location = _locationController.text.trim()
          ..dayOfWeek = _dayOfWeek
          ..startSection = _startSection
          ..endSection = _endSection
          ..startWeek = _startWeek
          ..endWeek = _endWeek
          ..weekType = _weekType
          ..color = colorHex
          ..remark = _remarkController.text.trim());

        await _service.updateItem(id, request);
      } else {
        final request = AddScheduleItemRequest((b) => b
          ..settingId = 1 // 默认配置ID，实际应从上下文获取
          ..courseName = courseName
          ..teacherName = _teacherNameController.text.trim()
          ..location = _locationController.text.trim()
          ..dayOfWeek = _dayOfWeek
          ..startSection = _startSection
          ..endSection = _endSection
          ..startWeek = _startWeek
          ..endWeek = _endWeek
          ..weekType = _weekType
          ..courseType = _courseType
          ..color = colorHex
          ..remark = _remarkController.text.trim());

        await _service.addItem(request);
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '保存失败: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}
