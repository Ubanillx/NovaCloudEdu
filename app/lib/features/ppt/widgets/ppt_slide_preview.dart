import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../config/app_theme.dart';
import '../services/ppt_generation_service.dart';

class PptSlidePreview extends StatefulWidget {
  final List<GeneratedSlide> slides;
  final int currentSlide;
  final int totalSlides;
  final AppColors colors;
  final ValueChanged<List<GeneratedSlide>>? onReorder;

  const PptSlidePreview({
    super.key,
    required this.slides,
    required this.currentSlide,
    required this.totalSlides,
    required this.colors,
    this.onReorder,
  });

  @override
  State<PptSlidePreview> createState() => _PptSlidePreviewState();
}

class _PptSlidePreviewState extends State<PptSlidePreview> {
  bool _isReordering = false;

  @override
  Widget build(BuildContext context) {
    final colors = widget.colors;
    return Container(
      height: _isReordering ? 145 : 125,
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: _isReordering
                        ? AppTheme.brand.withValues(alpha: 0.1)
                        : colors.surfaceVariant.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    _isReordering ? PhosphorIcons.arrowsLeftRight() : PhosphorIcons.presentation(),
                    size: 13,
                    color: _isReordering ? AppTheme.brand : colors.textTertiary,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  _isReordering ? '拖拽排序' : '幻灯片预览',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _isReordering ? AppTheme.brand : colors.textSecondary,
                  ),
                ),
                const SizedBox(width: 6),
                if (widget.totalSlides > 0 && !_isReordering)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.brand.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${widget.currentSlide}/${widget.totalSlides}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.brand,
                      ),
                    ),
                  ),
                const Spacer(),
                if (widget.onReorder != null && widget.slides.length > 1)
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => setState(() => _isReordering = !_isReordering),
                      borderRadius: BorderRadius.circular(8),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _isReordering ? AppTheme.brand : colors.surfaceVariant.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _isReordering ? '完成' : '排序',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _isReordering ? Colors.white : colors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: _isReordering
                ? _buildReorderableList(colors)
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: widget.slides.length,
                    itemBuilder: (context, index) {
                      final slide = widget.slides[index];
                      return _buildSlideThumb(slide, index, context, colors);
                    },
                  ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _buildReorderableList(AppColors colors) {
    return ReorderableListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: widget.slides.length,
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) newIndex--;
        final item = widget.slides.removeAt(oldIndex);
        widget.slides.insert(newIndex, item);
        widget.onReorder?.call(List.from(widget.slides));
        setState(() {});
      },
      proxyDecorator: (child, index, animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) => Material(
            color: Colors.transparent,
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: child,
          ),
          child: child,
        );
      },
      itemBuilder: (context, index) {
        final slide = widget.slides[index];
        return Container(
          key: ValueKey('reorder_$index'),
          width: 96,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.brand.withValues(alpha: 0.3), width: 1.5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Stack(
              fit: StackFit.expand,
              children: [
                slide.previewImageUrl != null && slide.previewImageUrl!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: slide.previewImageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (_, _) => _buildPlaceholder(colors),
                        errorWidget: (_, _, _) => _buildPlaceholder(colors, isError: true),
                      )
                    : _buildPlaceholder(colors),
                // 页码 + 拖拽指示
                Positioned(
                  bottom: 2,
                  left: 2,
                  right: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      Icon(PhosphorIcons.dotsSixVertical(), size: 14, color: Colors.white.withValues(alpha: 0.7)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSlideThumb(GeneratedSlide slide, int index, BuildContext context, AppColors colors) {
    return AnimatedScale(
      scale: slide.isNew ? 0.85 : 1.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      child: GestureDetector(
        onTap: () => _showFullPreview(context, slide, index),
        child: Container(
          width: 100,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              fit: StackFit.expand,
              children: [
                slide.previewImageUrl != null && slide.previewImageUrl!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: slide.previewImageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (_, _) => _buildPlaceholder(colors),
                        errorWidget: (_, _, _) => _buildPlaceholder(colors, isError: true),
                      )
                    : _buildPlaceholder(colors),
                // 页码标签
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(AppColors colors, {bool isError = false}) {
    return Container(
      color: colors.surfaceVariant,
      child: Center(
        child: Icon(
          isError ? PhosphorIcons.imageBroken() : PhosphorIcons.presentation(),
          size: 20,
          color: colors.iconSecondary,
        ),
      ),
    );
  }

  void _showFullPreview(BuildContext context, GeneratedSlide slide, int index) {
    if (slide.previewImageUrl == null || slide.previewImageUrl!.isEmpty) return;

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black87,
        barrierDismissible: true,
        pageBuilder: (_, _, _) => _FullScreenSlideViewer(
          slides: widget.slides,
          initialIndex: index,
        ),
      ),
    );
  }
}

class _FullScreenSlideViewer extends StatefulWidget {
  final List<GeneratedSlide> slides;
  final int initialIndex;

  const _FullScreenSlideViewer({
    required this.slides,
    required this.initialIndex,
  });

  @override
  State<_FullScreenSlideViewer> createState() => _FullScreenSlideViewerState();
}

class _FullScreenSlideViewerState extends State<_FullScreenSlideViewer> {
  late PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Stack(
          children: [
            // PageView
            PageView.builder(
              controller: _pageController,
              itemCount: widget.slides.length,
              onPageChanged: (i) => setState(() => _currentPage = i),
              itemBuilder: (context, index) {
                final s = widget.slides[index];
                if (s.previewImageUrl == null || s.previewImageUrl!.isEmpty) {
                  return Center(
                    child: Icon(PhosphorIcons.imageBroken(), size: 48, color: Colors.white38),
                  );
                }
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: s.previewImageUrl!,
                        fit: BoxFit.contain,
                        placeholder: (_, _) => const SizedBox(
                          height: 200,
                          child: Center(child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            // 顶部关闭 + 页码
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Icon(PhosphorIcons.x(), size: 20, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_currentPage + 1} / ${widget.slides.length}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 底部指示器
            if (widget.slides.length > 1)
              Positioned(
                bottom: MediaQuery.of(context).padding.bottom + 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.slides.length, (i) {
                    final active = i == _currentPage;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: active ? 20 : 6,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: active ? Colors.white : Colors.white38,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  }),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
