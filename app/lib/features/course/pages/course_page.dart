import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/common/nova_refresh_header.dart';
import '../../data/mock_data.dart';

/// 课程页面 - 参考smartclass Courses.vue
class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  int _selectedCategory = 0;
  int _selectedGrade = 0;

  final List<String> _gradeOptions = [
    '全部年级',
    '一年级',
    '二年级',
    '三年级',
    '四年级',
    '五年级',
    '六年级',
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 头部
            _buildHeader(),
            // 分类标签
            _buildCategories(),
            // 课程列表
            Expanded(child: _buildCourseList()),
          ],
        ),
      ),
    );
  }

  // 头部
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 8, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '课程中心',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // TODO: 跳转到电子书页面
                },
                icon: const Icon(Icons.menu_book_rounded, color: AppTheme.brand, size: 24),
                tooltip: '电子书',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.calendar_today_outlined, size: 20),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.checklist_rounded, size: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 分类标签
  Widget _buildCategories() {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: MockData.categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = MockData.categories[index];
          final isSelected = _selectedCategory == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.brand : Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Colors.white : Colors.black54,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // 课程列表
  Widget _buildCourseList() {
    return NovaRefreshableList(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      slivers: [
        // 年级筛选（非推荐分类时显示）
        if (_selectedCategory != 0)
          SliverToBoxAdapter(child: _buildGradeFilter()),
        // 课程列表
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index >= MockData.courses.length) return null;
              return _buildCourseCard(MockData.courses[index]);
            }, childCount: MockData.courses.length),
          ),
        ),
      ],
    );
  }

  // 年级筛选
  Widget _buildGradeFilter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => _showGradeSelector(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _gradeOptions[_selectedGrade],
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_drop_down, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showGradeSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '选择年级',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...List.generate(_gradeOptions.length, (index) {
              return ListTile(
                title: Text(_gradeOptions[index]),
                trailing: _selectedGrade == index
                    ? const Icon(Icons.check, color: AppTheme.brand)
                    : null,
                onTap: () {
                  setState(() => _selectedGrade = index);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  // 课程卡片
  Widget _buildCourseCard(Course course) {
    return GestureDetector(
      onTap: () => _showCourseDetail(course),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 封面图
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.network(
                    course.cover,
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: double.infinity,
                      height: 160,
                      color: Colors.grey[100],
                      child: Icon(Icons.image_outlined, size: 40, color: Colors.grey[300]),
                    ),
                  ),
                ),
                if (course.grade != null)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        course.grade!,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // 课程信息
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    course.brief,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildCourseTag(course.tag, AppTheme.brand),
                      const Spacer(),
                      Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${course.duration}min',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.person_outline_rounded,
                        size: 14,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${course.studentsCount}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // 课程详情弹窗
  void _showCourseDetail(Course course) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            controller: scrollController,
            children: [
              // 封面
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  course.cover,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              // 标题
              Text(
                course.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // 简介
              Text(
                course.brief,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              // 标签
              Row(
                children: [
                  _buildDetailTag(course.tag, AppTheme.brand),
                  if (course.grade != null) ...[
                    const SizedBox(width: 8),
                    _buildDetailTag(course.grade!, const Color(0xFF07C160)),
                  ],
                  const SizedBox(width: 8),
                  _buildDetailTag('${course.duration}分钟', Colors.orange),
                ],
              ),
              const SizedBox(height: 24),
              // 开始学习按钮
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.brand,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    '开始学习',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text, style: TextStyle(fontSize: 12, color: color)),
    );
  }
}
