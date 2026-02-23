import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/common/skeleton_widgets.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../../widgets/toast/nova_message.dart';
import '../services/course_service.dart';
import 'course_detail_page.dart';

/// 课程搜索页
class CourseSearchPage extends StatefulWidget {
  const CourseSearchPage({super.key});

  @override
  State<CourseSearchPage> createState() => _CourseSearchPageState();
}

class _CourseSearchPageState extends State<CourseSearchPage> {
  final CourseService _courseService = CourseService();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<CourseResponse> _results = [];
  bool _isLoading = false;
  bool _hasSearched = false;
  int _currentPage = 1;
  bool _hasMore = true;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // 自动聚焦搜索框
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.trim().isNotEmpty) {
        _search(query.trim());
      } else {
        setState(() {
          _results = [];
          _hasSearched = false;
        });
      }
    });
  }

  Future<void> _search(String keyword) async {
    setState(() {
      _isLoading = true;
      _hasSearched = true;
      _currentPage = 1;
    });

    try {
      final results = await _courseService.searchCourses(
        keyword: keyword,
        page: 1,
        size: 20,
      );
      if (mounted) {
        setState(() {
          _results = results.toList();
          _hasMore = results.length >= 20;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        NovaMessage.error(context, '搜索失败');
      }
    }
  }

  Future<void> _loadMore() async {
    if (_isLoading || !_hasMore) return;
    final keyword = _searchController.text.trim();
    if (keyword.isEmpty) return;

    try {
      final results = await _courseService.searchCourses(
        keyword: keyword,
        page: _currentPage + 1,
        size: 20,
      );
      if (mounted) {
        setState(() {
          _results.addAll(results.toList());
          _currentPage++;
          _hasMore = results.length >= 20;
        });
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 搜索栏
            _buildSearchBar(colors),
            // 分隔线
            Divider(height: 1, color: colors.border.withOpacity(0.3)),
            // 结果
            Expanded(child: _buildContent(colors)),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(AppColors colors) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: Row(
        children: [
          IconButton(
            icon: Icon(PhosphorIcons.arrowLeft(), color: colors.iconPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: colors.border.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _focusNode,
                onChanged: _onSearchChanged,
                onSubmitted: (v) {
                  if (v.trim().isNotEmpty) _search(v.trim());
                },
                style: TextStyle(fontSize: 15, color: colors.textPrimary),
                decoration: InputDecoration(
                  hintText: '搜索课程...',
                  hintStyle: TextStyle(color: colors.textTertiary, fontSize: 15),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  prefixIcon: Icon(PhosphorIcons.magnifyingGlass(), size: 20, color: colors.textTertiary),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(PhosphorIcons.x(), size: 18, color: colors.textTertiary),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _results = [];
                              _hasSearched = false;
                            });
                          },
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(AppColors colors) {
    if (_isLoading && _results.isEmpty) {
      return const CourseListSkeleton();
    }

    if (!_hasSearched) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(PhosphorIcons.magnifyingGlass(), size: 56, color: colors.textTertiary.withOpacity(0.3)),
            const SizedBox(height: 12),
            Text(
              '搜索你感兴趣的课程',
              style: TextStyle(color: colors.textTertiary, fontSize: 15),
            ),
          ],
        ),
      );
    }

    if (_results.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(PhosphorIcons.magnifyingGlassMinus(), size: 56, color: colors.textTertiary.withOpacity(0.3)),
            const SizedBox(height: 12),
            Text(
              '没有找到相关课程',
              style: TextStyle(color: colors.textTertiary, fontSize: 15),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _results.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= _results.length) {
          _loadMore();
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: LoadingWidget(size: 24)),
          );
        }
        return _buildCourseItem(_results[index], colors);
      },
    );
  }

  Widget _buildCourseItem(CourseResponse course, AppColors colors) {
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
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // 封面
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                course.coverImage ?? '',
                width: 100,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 100,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppTheme.brand.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(PhosphorIcons.bookOpen(),
                      size: 28, color: AppTheme.brand),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // 信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (course.subtitle != null && course.subtitle!.isNotEmpty)
                    Text(
                      course.subtitle!,
                      style: TextStyle(fontSize: 12, color: colors.textSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      if (course.courseTypeDesc != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.brand.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            course.courseTypeDesc!,
                            style: const TextStyle(
                                fontSize: 10, color: AppTheme.brand, fontWeight: FontWeight.w500),
                          ),
                        ),
                      const Spacer(),
                      if (course.price != null && course.price! > 0)
                        Text(
                          '¥${course.price}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: colors.warning,
                          ),
                        )
                      else
                        Text(
                          '免费',
                          style: TextStyle(
                            fontSize: 13,
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
}
