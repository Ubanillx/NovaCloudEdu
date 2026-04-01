import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../../widgets/toast/nova_message.dart';
import '../services/course_service.dart';
import '../services/course_favourite_service.dart';
import '../services/order_service.dart';
import 'video_player_page.dart';

/// 课程详情页 - 参考 web CourseDetailUserPage.tsx
class CourseDetailPage extends StatefulWidget {
  final int courseId;

  const CourseDetailPage({super.key, required this.courseId});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  final CourseService _courseService = CourseService();
  final CourseFavouriteService _favouriteService = CourseFavouriteService();
  final OrderService _orderService = OrderService();

  CourseStructureResponse? _structure;
  CourseProgressSummaryResponse? _progress;
  bool _isFavourited = false;
  int _favouriteCount = 0;
  bool _loading = true;
  bool _purchasing = false;

  // 从 structure 中获取
  CourseResponse? get _course => _structure?.course;
  bool get _hasAccess => _structure?.hasAccess ?? false;
  BuiltList<ChapterResponse> get _chapters => _structure?.chapters ?? BuiltList<ChapterResponse>();

  // 展开的章节
  final Set<int> _expandedChapters = {};

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _loading = true);
    try {
      // 并行加载核心数据
      final structureFuture = _courseService.getCourseStructure(widget.courseId);

      final structure = await structureFuture;
      if (!mounted) return;
      setState(() {
        _structure = structure;
        // 默认全部展开
        for (final ch in (structure.chapters ?? BuiltList<ChapterResponse>())) {
          if (ch.id != null) _expandedChapters.add(ch.id!);
        }
      });

      // 并行加载可选数据（不阻塞主渲染）
      final results = await Future.wait([
        _favouriteService.check(widget.courseId),
        _favouriteService.count(widget.courseId),
        _courseService.getCourseProgressSummary(widget.courseId).then<CourseProgressSummaryResponse?>((v) => v).catchError((_) => null),
      ]);

      if (!mounted) return;
      setState(() {
        _isFavourited = results[0] as bool;
        _favouriteCount = results[1] as int;
        final progResult = results[2];
        if (progResult is CourseProgressSummaryResponse) {
          _progress = progResult;
        }
        _loading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        NovaMessage.error(context, '加载课程信息失败');
      }
    }
  }

  void _toggleChapter(int chapterId) {
    setState(() {
      if (_expandedChapters.contains(chapterId)) {
        _expandedChapters.remove(chapterId);
      } else {
        _expandedChapters.add(chapterId);
      }
    });
  }

  Future<void> _handleFavourite() async {
    try {
      if (_isFavourited) {
        await _favouriteService.unfavourite(widget.courseId);
      } else {
        await _favouriteService.favourite(widget.courseId);
      }
      if (mounted) {
        setState(() {
          _isFavourited = !_isFavourited;
          _favouriteCount += _isFavourited ? 1 : -1;
        });
        NovaMessage.success(context, _isFavourited ? '已收藏' : '已取消收藏');
      }
    } catch (e) {
      if (mounted) NovaMessage.error(context, '操作失败');
    }
  }

  void _handleStartLearn() {
    // 找到第一个可访问的小节
    final sortedChapters = _chapters.toList()
      ..sort((a, b) => (a.sort ?? 0).compareTo(b.sort ?? 0));
    for (final ch in sortedChapters) {
      final sections = (ch.sections ?? BuiltList<SectionResponse>()).toList()
        ..sort((a, b) => (a.sort ?? 0).compareTo(b.sort ?? 0));
      for (final sec in sections) {
        if (sec.accessible == true && sec.id != null) {
          _navigateToPlayer(sec.id!);
          return;
        }
      }
    }
    NovaMessage.warning(context, '课程暂无可学习的小节');
  }

  void _handleSectionClick(SectionResponse section) {
    if (section.accessible != true) {
      if (_course?.courseType == 2) {
        NovaMessage.warning(context, '此小节需要开通会员或购买课程后观看');
      } else {
        NovaMessage.warning(context, '此小节需要购买课程后观看');
      }
      return;
    }
    if (section.id != null) {
      _navigateToPlayer(section.id!);
    }
  }

  void _navigateToPlayer(int sectionId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VideoPlayerPage(
          courseId: widget.courseId,
          initialSectionId: sectionId,
        ),
      ),
    ).then((_) {
      // 返回时刷新进度
      _fetchData();
    });
  }

  Future<void> _handlePurchase() async {
    if (_purchasing) return;
    setState(() => _purchasing = true);
    try {
      final orderNo = await _orderService.createOrder(widget.courseId);
      if (!mounted) return;
      // 免费课/会员课自动完成支付
      if (_course?.courseType == 0 || _course?.courseType == 2) {
        NovaMessage.success(context, '课程开通成功');
        _fetchData();
      } else {
        NovaMessage.success(context, '订单创建成功：$orderNo');
        // TODO: 对接真实支付流程
        NovaMessage.warning(context, '请联系管理员确认支付');
      }
    } catch (e) {
      if (mounted) {
        final msg = e.toString().replaceFirst('Exception: ', '');
        NovaMessage.error(context, msg);
      }
    } finally {
      if (mounted) setState(() => _purchasing = false);
    }
  }

  // ==================== UI ====================

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      body: _loading
          ? PageLoading(
              message: '加载课程中...',
              backgroundColor: colors.background,
            )
          : _course == null
              ? _buildEmpty(colors)
              : _buildContent(colors),
    );
  }

  Widget _buildEmpty(AppColors colors) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('课程不存在或已下架',
              style: TextStyle(color: colors.textSecondary, fontSize: 16)),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('返回'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(AppColors colors) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              // 封面 Hero + AppBar
              _buildSliverAppBar(colors),
              // 课程概览
              SliverToBoxAdapter(child: _buildOverview(colors)),
              // 课程目录
              SliverToBoxAdapter(child: _buildChapterList(colors)),
              // 底部间距
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
        // 底部操作栏
        _buildBottomBar(colors),
      ],
    );
  }

  Widget _buildSliverAppBar(AppColors colors) {
    return SliverAppBar(
      expandedHeight: 260,
      pinned: true,
      backgroundColor: colors.surface,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(PhosphorIcons.arrowLeft(), color: Colors.white, size: 20),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // 封面图
            if (_course?.coverImage != null && _course!.coverImage!.isNotEmpty)
              Image.network(
                _course!.coverImage!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildCoverPlaceholder(),
              )
            else
              _buildCoverPlaceholder(),
            // 渐变遮罩
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54],
                ),
              ),
            ),
            // 播放按钮
            if (_hasAccess)
              Center(
                child: GestureDetector(
                  onTap: _handleStartLearn,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white30),
                    ),
                    child: Icon(PhosphorIcons.play(PhosphorIconsStyle.fill),
                        color: Colors.white, size: 36),
                  ),
                ),
              ),
            // 底部信息
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标签行
                  Wrap(
                    spacing: 6,
                    children: [
                      if (_course?.difficultyDesc != null)
                        _buildBadge(_course!.difficultyDesc!, _getDifficultyColor(_course!.difficulty)),
                      if (_course?.courseType == 0)
                        _buildBadge('免费', Colors.green),
                      if (_course?.courseType == 1)
                        _buildBadge('付费', Colors.amber),
                      if (_course?.courseType == 2)
                        _buildBadge('会员', Colors.purple),
                      if (_hasAccess && _course?.courseType != 0)
                        _buildBadge('已解锁', Colors.teal),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // 标题
                  Text(
                    _course?.title ?? '',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (_course?.subtitle != null && _course!.subtitle!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      _course!.subtitle!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverPlaceholder() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.brand, Color(0xFF5C6BC0)],
        ),
      ),
      child: Center(
        child: Icon(PhosphorIcons.bookOpen(), size: 64, color: Colors.white30),
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.25),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color.withOpacity(0.9),
        ),
      ),
    );
  }

  Color _getDifficultyColor(int? difficulty) {
    switch (difficulty) {
      case 1: return Colors.green;
      case 2: return Colors.blue;
      case 3: return Colors.orange;
      case 4: return Colors.deepOrange;
      case 5: return Colors.red;
      default: return Colors.grey;
    }
  }

  Widget _buildOverview(AppColors colors) {
    final sortedChapters = _chapters.toList()
      ..sort((a, b) => (a.sort ?? 0).compareTo(b.sort ?? 0));
    final totalSections = sortedChapters.fold<int>(
        0, (sum, ch) => sum + (ch.sections?.length ?? 0));
    final totalDuration = sortedChapters.fold<int>(
        0,
        (sum, ch) =>
            sum +
            (ch.sections ?? BuiltList<SectionResponse>())
                .fold<int>(0, (s, sec) => s + (sec.duration ?? 0)));

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 统计信息行
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              if (_course?.courseTypeDesc != null)
                _buildInfoChip(
                  PhosphorIcons.book(),
                  _course!.courseTypeDesc!,
                  AppTheme.brand,
                ),
              _buildInfoChip(
                PhosphorIcons.bookOpen(),
                '${sortedChapters.length}章 · $totalSections节',
                colors.textSecondary,
              ),
              if (totalDuration > 0)
                _buildInfoChip(
                  PhosphorIcons.clock(),
                  _formatDuration(totalDuration),
                  colors.textSecondary,
                ),
              _buildInfoChip(
                PhosphorIcons.users(),
                '${_course?.studentCount ?? 0}人学习',
                colors.textSecondary,
              ),
              if (_course?.ratingScore != null && _course!.ratingScore! > 0)
                _buildInfoChip(
                  PhosphorIcons.star(PhosphorIconsStyle.fill),
                  _course!.ratingScore!.toStringAsFixed(1),
                  Colors.amber,
                ),
            ],
          ),
          // 描述
          if (_course?.description != null && _course!.description!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              _course!.description!,
              style: TextStyle(
                fontSize: 14,
                color: colors.textSecondary,
                height: 1.6,
              ),
            ),
          ],
          // 标签
          if (_course?.tags != null && _course!.tags!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Divider(color: colors.border.withOpacity(0.3), height: 1),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: _course!.tags!.map((tag) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.border.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tag,
                  style: TextStyle(fontSize: 12, color: colors.textSecondary),
                ),
              )).toList(),
            ),
          ],
          // 学习进度
          if (_progress != null && (_progress!.completionRate ?? 0) > 0) ...[
            const SizedBox(height: 16),
            Divider(color: colors.border.withOpacity(0.3), height: 1),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('学习进度', style: TextStyle(fontSize: 13, color: colors.textSecondary)),
                Text(
                  '${_progress!.completionRate ?? 0}%',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.brand,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (_progress!.completionRate ?? 0) / 100.0,
                backgroundColor: colors.border.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.brand),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '已完成 ${_progress!.completedSections ?? 0} / ${_progress!.totalSections ?? 0} 小节',
              style: TextStyle(fontSize: 12, color: colors.textTertiary),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(fontSize: 13, color: color, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildChapterList(AppColors colors) {
    final sortedChapters = _chapters.toList()
      ..sort((a, b) => (a.sort ?? 0).compareTo(b.sort ?? 0));
    final totalSections = sortedChapters.fold<int>(
        0, (sum, ch) => sum + (ch.sections?.length ?? 0));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // 标题栏
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '课程目录',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                Text(
                  '${sortedChapters.length}章 · $totalSections节',
                  style: TextStyle(fontSize: 12, color: colors.textTertiary),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: colors.border.withOpacity(0.2)),
          // 章节列表
          if (sortedChapters.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Icon(PhosphorIcons.bookOpen(), size: 40, color: colors.textTertiary),
                  const SizedBox(height: 8),
                  Text('课程内容正在筹备中...',
                      style: TextStyle(fontSize: 13, color: colors.textTertiary)),
                ],
              ),
            )
          else
            ...sortedChapters.asMap().entries.map((entry) {
              final ci = entry.key;
              final chapter = entry.value;
              return _buildChapterItem(colors, chapter, ci);
            }),
        ],
      ),
    );
  }

  Widget _buildChapterItem(AppColors colors, ChapterResponse chapter, int index) {
    final isExpanded = _expandedChapters.contains(chapter.id);
    final sections = (chapter.sections ?? BuiltList<SectionResponse>()).toList()
      ..sort((a, b) => (a.sort ?? 0).compareTo(b.sort ?? 0));

    return Column(
      children: [
        // 章节行
        InkWell(
          onTap: () => _toggleChapter(chapter.id!),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // 序号/展开图标
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isExpanded
                        ? AppTheme.brand
                        : AppTheme.brand.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: isExpanded
                        ? Icon(PhosphorIcons.caretDown(), size: 16, color: Colors.white)
                        : Text(
                            '${index + 1}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.brand,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                // 标题
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chapter.title ?? '',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${sections.length} 小节',
                        style: TextStyle(fontSize: 12, color: colors.textTertiary),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isExpanded ? PhosphorIcons.caretDown() : PhosphorIcons.caretRight(),
                  size: 20,
                  color: colors.textTertiary,
                ),
              ],
            ),
          ),
        ),
        // 展开的小节列表
        if (isExpanded && sections.isNotEmpty)
          ...sections.asMap().entries.map((entry) {
            final si = entry.key;
            final section = entry.value;
            return _buildSectionItem(colors, section, si);
          }),
        Divider(height: 1, color: colors.border.withOpacity(0.1)),
      ],
    );
  }

  Widget _buildSectionItem(AppColors colors, SectionResponse section, int index) {
    final accessible = section.accessible == true;

    return InkWell(
      onTap: () => _handleSectionClick(section),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(56, 10, 16, 10),
        child: Row(
          children: [
            // 播放/锁图标
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: accessible
                    ? AppTheme.brand.withOpacity(0.1)
                    : colors.border.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: accessible
                    ? Icon(PhosphorIcons.play(PhosphorIconsStyle.fill),
                        size: 14, color: AppTheme.brand)
                    : Icon(PhosphorIcons.lock(),
                        size: 12, color: colors.textTertiary),
              ),
            ),
            const SizedBox(width: 10),
            // 标题
            Expanded(
              child: Text(
                '${index + 1}. ${section.title ?? ''}',
                style: TextStyle(
                  fontSize: 14,
                  color: accessible ? colors.textPrimary : colors.textTertiary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // 标签
            if (section.isFree == true)
              Container(
                margin: const EdgeInsets.only(left: 6),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('免费',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green)),
              ),
            if (!accessible)
              Container(
                margin: const EdgeInsets.only(left: 6),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: colors.border.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('需购买',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: colors.textTertiary)),
              ),
            // 时长
            if (section.duration != null && section.duration! > 0)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  _formatDurationShort(section.duration!),
                  style: TextStyle(fontSize: 12, color: colors.textTertiary),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(AppColors colors) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 12 + MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(context.isDarkMode ? 0.3 : 0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 收藏按钮
          GestureDetector(
            onTap: _handleFavourite,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: _isFavourited
                    ? Colors.red.withOpacity(0.08)
                    : colors.border.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isFavourited
                      ? Colors.red.withOpacity(0.3)
                      : colors.border.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isFavourited ? PhosphorIcons.heart(PhosphorIconsStyle.fill) : PhosphorIcons.heart(),
                    size: 20,
                    color: _isFavourited ? Colors.red : colors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$_favouriteCount',
                    style: TextStyle(
                      fontSize: 13,
                      color: _isFavourited ? Colors.red : colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // 主操作按钮
          Expanded(
            child: _hasAccess
                ? _buildPrimaryButton(
                    icon: PhosphorIcons.play(PhosphorIconsStyle.fill),
                    label: (_progress != null && (_progress!.completionRate ?? 0) > 0)
                        ? '继续学习'
                        : '开始学习',
                    onTap: _handleStartLearn,
                  )
                : _buildPrimaryButton(
                    icon: _purchasing ? null : PhosphorIcons.shoppingCart(),
                    label: _purchasing
                        ? '处理中...'
                        : (_course?.courseType == 2 ? '立即开通' : '立即购买 ¥${_course?.price ?? 0}'),
                    onTap: _purchasing ? null : _handlePurchase,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton({
    IconData? icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTheme.brand, Color(0xFF0066DD)],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppTheme.brand.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
            ],
            if (_purchasing)
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            if (!_purchasing || icon != null)
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(int seconds) {
    if (seconds >= 3600) {
      final h = seconds ~/ 3600;
      final m = (seconds % 3600) ~/ 60;
      return '$h小时${m > 0 ? '$m分钟' : ''}';
    }
    final m = seconds ~/ 60;
    return m > 0 ? '$m分钟' : '$seconds秒';
  }

  String _formatDurationShort(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    if (m > 0) {
      return '$m:${s.toString().padLeft(2, '0')}';
    }
    return '0:${s.toString().padLeft(2, '0')}';
  }
}
