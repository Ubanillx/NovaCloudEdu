import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';

import '../../../config/app_theme.dart';
import '../../../widgets/common/empty_widget.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../../widgets/common/nova_refresh_header.dart';
import '../../../widgets/toast/nova_message.dart';
import '../services/schedule_service.dart';
import 'schedule_edit_page.dart';

/// 课程表页面
class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final ScheduleService _service = ScheduleService();
  
  bool _isLoading = true;
  String? _error;
  BuiltList<ClassScheduleItemResponse>? _scheduleItems;
  
  int _currentWeek = 1;
  final int _totalWeeks = 20;
  final int _sectionsPerDay = 12;
  final List<String> _weekDays = ['一', '二', '三', '四', '五', '六', '日'];

  // 课程颜色列表
  final List<Color> _courseColors = [
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
    _loadSchedule();
  }

  Future<void> _loadSchedule() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    
    try {
      final items = await _service.getMySchedule();
      if (mounted) {
        setState(() {
          _scheduleItems = items;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
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
        centerTitle: true,
        title: Text(
          '课程表',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: colors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_rounded, color: colors.textPrimary, size: 24),
            onPressed: _navigateToAddCourse,
            tooltip: '添加课程',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildWeekSelector(colors),
          Expanded(child: _buildContent(colors)),
        ],
      ),
    );
  }

  Widget _buildWeekSelector(AppColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          bottom: BorderSide(color: colors.divider, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.chevron_left_rounded,
              color: _currentWeek > 1 ? colors.textPrimary : colors.textTertiary,
            ),
            onPressed: _currentWeek > 1
                ? () => setState(() => _currentWeek--)
                : null,
          ),
          GestureDetector(
            onTap: _showWeekPicker,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.brand.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '第 $_currentWeek 周',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.brand,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_drop_down, color: AppTheme.brand, size: 20),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.chevron_right_rounded,
              color: _currentWeek < _totalWeeks ? colors.textPrimary : colors.textTertiary,
            ),
            onPressed: _currentWeek < _totalWeeks
                ? () => setState(() => _currentWeek++)
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(AppColors colors) {
    if (_isLoading) {
      return const PageLoading(message: '加载课表中...');
    }
    
    if (_error != null) {
      return NetworkErrorWidget(
        message: _error,
        onRetry: _loadSchedule,
      );
    }
    
    return NovaRefreshHeader(
      onRefresh: _loadSchedule,
      child: SingleChildScrollView(
        child: _buildScheduleGrid(colors),
      ),
    );
  }

  Widget _buildScheduleGrid(AppColors colors) {
    final screenWidth = MediaQuery.of(context).size.width;
    final timeColumnWidth = 40.0;
    final dayColumnWidth = (screenWidth - timeColumnWidth) / 7;
    final cellHeight = 60.0;

    return Column(
      children: [
        // 星期头部
        _buildWeekHeader(colors, timeColumnWidth, dayColumnWidth),
        // 课程表格
        _buildTimeGrid(colors, timeColumnWidth, dayColumnWidth, cellHeight),
      ],
    );
  }

  Widget _buildWeekHeader(AppColors colors, double timeColumnWidth, double dayColumnWidth) {
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          bottom: BorderSide(color: colors.divider, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          // 左上角空白
          SizedBox(
            width: timeColumnWidth,
            height: 44,
            child: Center(
              child: Text(
                '节',
                style: TextStyle(
                  fontSize: 12,
                  color: colors.textTertiary,
                ),
              ),
            ),
          ),
          // 星期列
          ...List.generate(7, (index) {
            final isToday = _isToday(index + 1);
            return Container(
              width: dayColumnWidth,
              height: 44,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: colors.divider, width: 0.5),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: isToday
                          ? BoxDecoration(
                              color: AppTheme.brand,
                              borderRadius: BorderRadius.circular(10),
                            )
                          : null,
                      child: Text(
                        '周${_weekDays[index]}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isToday ? FontWeight.w600 : FontWeight.normal,
                          color: isToday ? Colors.white : colors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTimeGrid(AppColors colors, double timeColumnWidth, double dayColumnWidth, double cellHeight) {
    // 获取当前周的课程
    final weekItems = _getItemsForCurrentWeek();
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 节次列
        Column(
          children: List.generate(_sectionsPerDay, (index) {
            return Container(
              width: timeColumnWidth,
              height: cellHeight,
              decoration: BoxDecoration(
                color: colors.surface,
                border: Border(
                  bottom: BorderSide(color: colors.divider, width: 0.5),
                ),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.textTertiary,
                  ),
                ),
              ),
            );
          }),
        ),
        // 课程格子
        ...List.generate(7, (dayIndex) {
          return SizedBox(
            width: dayColumnWidth,
            child: Stack(
              children: [
                // 背景格子
                Column(
                  children: List.generate(_sectionsPerDay, (sectionIndex) {
                    return GestureDetector(
                      onTap: () => _onCellTap(dayIndex + 1, sectionIndex + 1),
                      child: Container(
                        width: dayColumnWidth,
                        height: cellHeight,
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: colors.divider, width: 0.5),
                            bottom: BorderSide(color: colors.divider, width: 0.5),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                // 课程卡片
                ...weekItems
                    .where((item) => item.dayOfWeek == dayIndex + 1)
                    .map((item) => _buildCourseCard(
                          item,
                          dayColumnWidth,
                          cellHeight,
                          colors,
                        )),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildCourseCard(
    ClassScheduleItemResponse item,
    double width,
    double cellHeight,
    AppColors colors,
  ) {
    final startSection = item.startSection ?? 1;
    final endSection = item.endSection ?? startSection;
    final top = (startSection - 1) * cellHeight;
    final height = (endSection - startSection + 1) * cellHeight;
    
    // 解析颜色或使用默认颜色
    Color cardColor;
    if (item.color != null && item.color!.isNotEmpty) {
      try {
        cardColor = Color(int.parse(item.color!.replaceFirst('#', '0xFF')));
      } catch (_) {
        cardColor = _courseColors[item.courseName.hashCode % _courseColors.length];
      }
    } else {
      cardColor = _courseColors[(item.courseName ?? '').hashCode % _courseColors.length];
    }

    return Positioned(
      top: top,
      left: 2,
      right: 2,
      height: height - 4,
      child: GestureDetector(
        onTap: () => _showCourseDetail(item),
        child: Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: cardColor.withOpacity(context.isDarkMode ? 0.3 : 0.15),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: cardColor.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.courseName ?? '未命名课程',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: cardColor,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (item.location != null && item.location!.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  '@${item.location}',
                  style: TextStyle(
                    fontSize: 9,
                    color: cardColor.withOpacity(0.8),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (item.teacherName != null && item.teacherName!.isNotEmpty) ...[
                const SizedBox(height: 1),
                Text(
                  item.teacherName!,
                  style: TextStyle(
                    fontSize: 9,
                    color: cardColor.withOpacity(0.7),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  List<ClassScheduleItemResponse> _getItemsForCurrentWeek() {
    if (_scheduleItems == null) return [];
    
    return _scheduleItems!.where((item) {
      final startWeek = item.startWeek ?? 1;
      final endWeek = item.endWeek ?? _totalWeeks;
      final weekType = item.weekType ?? 0; // 0: 全部, 1: 单周, 2: 双周
      
      if (_currentWeek < startWeek || _currentWeek > endWeek) {
        return false;
      }
      
      if (weekType == 1 && _currentWeek % 2 == 0) {
        return false; // 单周课，当前是双周
      }
      if (weekType == 2 && _currentWeek % 2 == 1) {
        return false; // 双周课，当前是单周
      }
      
      return true;
    }).toList();
  }

  bool _isToday(int dayOfWeek) {
    final now = DateTime.now();
    final weekday = now.weekday;
    return weekday == dayOfWeek;
  }

  void _showWeekPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('取消'),
                    ),
                    Text(
                      '选择周次',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: context.colors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 60),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: _totalWeeks,
                  itemBuilder: (context, index) {
                    final week = index + 1;
                    final isSelected = week == _currentWeek;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _currentWeek = week);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.brand
                              : context.colors.surfaceVariant,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '$week',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              color: isSelected
                                  ? Colors.white
                                  : context.colors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onCellTap(int dayOfWeek, int section) {
    _navigateToAddCourse(dayOfWeek: dayOfWeek, section: section);
  }

  void _navigateToAddCourse({int? dayOfWeek, int? section}) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ScheduleEditPage(
          defaultDayOfWeek: dayOfWeek,
          defaultSection: section,
        ),
      ),
    );
    
    if (result == true && mounted) {
      _loadSchedule();
      NovaMessage.success(context, '课程添加成功');
    }
  }

  void _showCourseDetail(ClassScheduleItemResponse item) {
    final colors = context.colors;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item.courseName ?? '未命名课程',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: colors.textSecondary),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildDetailRow(Icons.access_time_rounded, '时间',
                  '周${_weekDays[(item.dayOfWeek ?? 1) - 1]} 第${item.startSection}-${item.endSection}节', colors),
              if (item.location != null && item.location!.isNotEmpty)
                _buildDetailRow(Icons.location_on_outlined, '地点', item.location!, colors),
              if (item.teacherName != null && item.teacherName!.isNotEmpty)
                _buildDetailRow(Icons.person_outline_rounded, '教师', item.teacherName!, colors),
              _buildDetailRow(Icons.date_range_rounded, '周次',
                  '第${item.startWeek ?? 1}-${item.endWeek ?? _totalWeeks}周${_getWeekTypeText(item.weekType)}', colors),
              if (item.remark != null && item.remark!.isNotEmpty)
                _buildDetailRow(Icons.notes_rounded, '备注', item.remark!, colors),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _editCourse(item),
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text('编辑'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.brand,
                        side: const BorderSide(color: AppTheme.brand),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _deleteCourse(item),
                      icon: const Icon(Icons.delete_outline_rounded),
                      label: const Text('删除'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colors.error,
                        side: BorderSide(color: colors.error),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, AppColors colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: colors.textTertiary),
          const SizedBox(width: 12),
          Text(
            '$label：',
            style: TextStyle(
              fontSize: 14,
              color: colors.textSecondary,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: colors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getWeekTypeText(int? weekType) {
    switch (weekType) {
      case 1:
        return ' (单周)';
      case 2:
        return ' (双周)';
      default:
        return '';
    }
  }

  void _editCourse(ClassScheduleItemResponse item) async {
    Navigator.pop(context);
    
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ScheduleEditPage(item: item),
      ),
    );
    
    if (result == true && mounted) {
      _loadSchedule();
      NovaMessage.success(context, '课程更新成功');
    }
  }

  void _deleteCourse(ClassScheduleItemResponse item) async {
    Navigator.pop(context);
    
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除"${item.courseName}"吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    
    if (confirmed == true && mounted) {
      try {
        final id = int.tryParse(item.id ?? '');
        if (id != null) {
          await _service.deleteItem(id);
          _loadSchedule();
          if (mounted) {
            NovaMessage.success(context, '删除成功');
          }
        }
      } catch (e) {
        if (mounted) {
          NovaMessage.error(context, '删除失败: $e');
        }
      }
    }
  }
}
