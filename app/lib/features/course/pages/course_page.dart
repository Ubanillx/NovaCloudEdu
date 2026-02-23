import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/common/skeleton_widgets.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../../widgets/common/nova_refresh_header.dart';
import '../../../widgets/toast/nova_message.dart';
import '../services/course_service.dart';
import 'course_detail_page.dart';
import 'course_search_page.dart';
import 'schedule_page.dart';
import 'task_list_page.dart';
import 'bookshelf_page.dart';

/// 课程页面 - 参考smartclass Courses.vue
class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final CourseService _courseService = CourseService();
  
  List<CourseResponse> _courses = [];
  bool _isLoading = true;
  int _currentPage = 1;
  bool _hasMore = true;
  
  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
            // 分隔阴影
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colors.border.withValues(alpha: 0),
                    colors.border.withValues(alpha: 0.5),
                    colors.border.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
            // 课程列表
            Expanded(
              child: _buildCourseList(),
            ),
          ],
        ),
      ),
    );
  }

  // 头部
  Widget _buildHeader() {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 8, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '课程中心',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: colors.textPrimary,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BookshelfPage()),
                  );
                },
                icon: Icon(PhosphorIcons.bookOpenText(), size: 22, color: colors.iconPrimary),
                tooltip: '电子书库',
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CourseSearchPage()),
                  );
                },
                icon: Icon(PhosphorIcons.magnifyingGlass(), size: 22, color: colors.iconPrimary),
                tooltip: '搜索课程',
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SchedulePage()),
                  );
                },
                icon: Icon(PhosphorIcons.calendarBlank(), size: 20, color: colors.iconPrimary),
                tooltip: '课程表',
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TaskListPage()),
                  );
                },
                icon: Icon(PhosphorIcons.listChecks(), size: 22, color: colors.iconPrimary),
                tooltip: '任务清单',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 课程列表
  Widget _buildCourseList() {
    if (_isLoading && _courses.isEmpty) {
      return const CourseListSkeleton();
    }
    
    if (_courses.isEmpty) {
      return const Center(child: Text('暂无课程'));
    }

    return NovaRefreshableList(
      onRefresh: _loadCourses,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index >= _courses.length) {
                if (_hasMore) {
                  _loadMoreCourses();
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: LoadingWidget(size: 24)),
                  );
                }
                return null;
              }
              return _buildCourseCard(_courses[index]);
            }, childCount: _courses.length + (_hasMore ? 1 : 0)),
          ),
        ),
      ],
    );
  }

  // 加载课程列表
  Future<void> _loadCourses() async {
    setState(() {
      _isLoading = true;
      _currentPage = 1;
    });
    
    try {
      final courses = await _courseService.getCourses(
        page: 1,
        size: 20,
      );
      if (mounted) {
        setState(() {
          _courses = courses.toList();
          _hasMore = courses.length >= 20;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        NovaMessage.error(context, '加载课程失败');
      }
    }
  }

  // 加载更多课程
  Future<void> _loadMoreCourses() async {
    if (_isLoading || !_hasMore) return;
    
    try {
      final courses = await _courseService.getCourses(
        page: _currentPage + 1,
        size: 20,
      );
      if (mounted) {
        setState(() {
          _courses.addAll(courses.toList());
          _currentPage++;
          _hasMore = courses.length >= 20;
        });
      }
    } catch (e) {
      // 静默处理
    }
  }

  // 课程卡片
  Widget _buildCourseCard(CourseResponse course) {
    final colors = context.colors;
    return GestureDetector(
      onTap: () {
        if (course.id != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CourseDetailPage(courseId: course.id!),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.04),
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
                    top: Radius.circular(24),
                  ),
                  child: Image.network(
                    course.coverImage ?? '',
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: double.infinity,
                      height: 160,
                      color: Colors.grey[100],
                      child: Icon(PhosphorIcons.image(), size: 40, color: Colors.grey[300]),
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
                    course.title ?? '未知课程',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    course.subtitle ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      color: colors.textSecondary,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildCourseTag(course.courseTypeDesc ?? '课程', AppTheme.brand),
                      const Spacer(),
                      if (course.price != null && course.price! > 0)
                        Text(
                          '¥${course.price}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: colors.warning,
                          ),
                        )
                      else
                        Text(
                          '免费',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: colors.success,
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

}
