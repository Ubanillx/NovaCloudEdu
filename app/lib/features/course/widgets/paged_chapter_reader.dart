import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nova_api/nova_api.dart';
import 'reader_settings_sheet.dart';
import 'page_turn_effect.dart';
import '../../../widgets/common/loading_widget.dart';

/// 页面引用：全局页码 → (章节索引, 章节内局部页码)
class PageRef {
  final int chapterIndex;
  final int localPage;
  const PageRef(this.chapterIndex, this.localPage);
}

/// 按屏幕大小分页的阅读器组件
/// 将章节内容按视口高度分割成多个页面，支持水平滑动和仿真翻页
class PagedChapterReader extends StatefulWidget {
  final int chapterCount;
  final Map<int, ChapterContentDTO> chapterCache;
  final ReaderSettings settings;
  final ReaderThemeColors themeColors;
  final int initialChapterIndex;
  final PageTurnMode mode;
  final GlobalKey<SimulatedPageTurnState>? simulatedKey;
  final bool showAppBar;
  final ValueChanged<int> onChapterChanged;
  final Future<void> Function(int) onLoadChapter;

  const PagedChapterReader({
    super.key,
    required this.chapterCount,
    required this.chapterCache,
    required this.settings,
    required this.themeColors,
    required this.initialChapterIndex,
    required this.mode,
    this.simulatedKey,
    required this.showAppBar,
    required this.onChapterChanged,
    required this.onLoadChapter,
  });

  @override
  State<PagedChapterReader> createState() => PagedChapterReaderState();
}

class PagedChapterReaderState extends State<PagedChapterReader> {
  // 每个章节测量后的内容高度
  final Map<int, double> _contentHeights = {};
  // 测量用的 GlobalKey
  final Map<int, GlobalKey> _measureKeys = {};
  // 已完成测量的章节
  final Set<int> _measured = {};
  // 已请求加载的章节（防止 build 中重复调用）
  final Set<int> _requestedChapters = {};
  // 当前全局页码
  int _currentGlobalPage = 0;
  // 视口高度（内容区域）
  double _pageHeight = 0;
  // PageView 控制器（水平模式）
  PageController? _pageCtrl;

  /// 获取章节的页数（未测量默认1页）
  int pagesForChapter(int ch) {
    final h = _contentHeights[ch];
    if (h == null || _pageHeight <= 0) return 1;
    return (h / _pageHeight).ceil().clamp(1, 9999);
  }

  /// 总页数
  int get totalPages {
    int total = 0;
    for (int i = 0; i < widget.chapterCount; i++) {
      total += pagesForChapter(i);
    }
    return total;
  }

  /// 全局页码 → (章节, 局部页码)
  PageRef globalToLocal(int gp) {
    int cumulative = 0;
    for (int i = 0; i < widget.chapterCount; i++) {
      final count = pagesForChapter(i);
      if (gp < cumulative + count) {
        return PageRef(i, gp - cumulative);
      }
      cumulative += count;
    }
    return PageRef(widget.chapterCount - 1, 0);
  }

  /// (章节, 局部页码) → 全局页码
  int localToGlobal(int ch, int lp) {
    int cumulative = 0;
    for (int i = 0; i < ch; i++) {
      cumulative += pagesForChapter(i);
    }
    return cumulative + lp;
  }

  @override
  void initState() {
    super.initState();
    // 初始全局页码 = 初始章节的第一页
    _currentGlobalPage = localToGlobal(widget.initialChapterIndex, 0);
  }

  @override
  void dispose() {
    _pageCtrl?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PagedChapterReader oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 缓存变化时触发测量
    if (widget.chapterCache.length != oldWidget.chapterCache.length) {
      _scheduleMeasurement();
    }
  }

  void _scheduleMeasurement() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      bool changed = false;
      for (final entry in widget.chapterCache.entries) {
        final idx = entry.key;
        final key = _measureKeys[idx];
        if (key != null && !_measured.contains(idx)) {
          final box = key.currentContext?.findRenderObject() as RenderBox?;
          if (box != null && box.hasSize) {
            _contentHeights[idx] = box.size.height;
            _measured.add(idx);
            changed = true;
          }
        }
      }
      if (changed && mounted) {
        // 重建 PageController
        final tp = totalPages;
        _currentGlobalPage = _currentGlobalPage.clamp(0, tp - 1);
        _pageCtrl?.dispose();
        _pageCtrl = PageController(initialPage: _currentGlobalPage);
        setState(() {});
      }
    });
  }

  /// 跳转到指定章节
  void goToChapter(int chapterIndex) {
    final gp = localToGlobal(chapterIndex, 0);
    if (widget.mode == PageTurnMode.horizontal) {
      _pageCtrl?.jumpToPage(gp);
    } else {
      setState(() => _currentGlobalPage = gp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      _pageHeight = constraints.maxHeight;
      // 确保 PageController 已创建
      _pageCtrl ??= PageController(initialPage: _currentGlobalPage);

      return Stack(
        children: [
          // 测量层（Offstage，不可见）
          _buildMeasureLayer(constraints.maxWidth),
          // 显示层
          _buildDisplayLayer(),
        ],
      );
    });
  }

  /// 离屏测量层：对未测量的缓存章节进行布局测量
  Widget _buildMeasureLayer(double maxWidth) {
    final toMeasure = widget.chapterCache.entries
        .where((e) => !_measured.contains(e.key))
        .toList();
    if (toMeasure.isEmpty) return const SizedBox.shrink();

    // 触发测量
    WidgetsBinding.instance.addPostFrameCallback((_) => _scheduleMeasurement());

    return Offstage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: toMeasure.map((entry) {
          _measureKeys.putIfAbsent(entry.key, () => GlobalKey());
          return SizedBox(
            key: _measureKeys[entry.key],
            width: maxWidth - 40, // 20px padding each side
            child: _buildRawHtml(entry.value),
          );
        }).toList(),
      ),
    );
  }

  /// 显示层
  Widget _buildDisplayLayer() {
    final tc = widget.themeColors;
    final tp = totalPages;
    if (tp == 0) {
      return Center(child: Text('暂无内容', style: TextStyle(color: tc.muted)));
    }

    if (widget.mode == PageTurnMode.horizontal) {
      return PageView.builder(
        controller: _pageCtrl,
        itemCount: tp,
        onPageChanged: _onPageChanged,
        itemBuilder: (ctx, gp) => _buildSinglePage(gp),
      );
    } else {
      // 仿真翻页
      return SimulatedPageTurn(
        key: widget.simulatedKey,
        itemCount: tp,
        initialPage: _currentGlobalPage,
        onPageChanged: _onPageChanged,
        itemBuilder: (ctx, gp) => _buildSinglePage(gp),
      );
    }
  }

  void _onPageChanged(int gp) {
    _currentGlobalPage = gp;
    final ref = globalToLocal(gp);
    widget.onChapterChanged(ref.chapterIndex);
    // 预加载相邻章节
    _preloadNearby(ref.chapterIndex);
  }

  void _preloadNearby(int ch) {
    _ensureChapterRequested(ch);
    if (ch > 0) _ensureChapterRequested(ch - 1);
    if (ch < widget.chapterCount - 1) _ensureChapterRequested(ch + 1);

    // 当接近章节末尾时，提前预加载下下章
    final ref = globalToLocal(_currentGlobalPage);
    final pages = pagesForChapter(ref.chapterIndex);
    if (pages > 1 && ref.localPage >= pages - 2 && ch + 2 < widget.chapterCount) {
      _ensureChapterRequested(ch + 2);
    }
  }

  /// 确保章节已请求加载（去重，不在 build 中直接调用 onLoadChapter）
  void _ensureChapterRequested(int ch) {
    if (ch < 0 || ch >= widget.chapterCount) return;
    if (widget.chapterCache.containsKey(ch)) return;
    if (_requestedChapters.contains(ch)) return;
    _requestedChapters.add(ch);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      widget.onLoadChapter(ch);
    });
  }

  /// 构建全局第 gp 页的内容
  Widget _buildSinglePage(int gp) {
    final tc = widget.themeColors;
    final ref = globalToLocal(gp);
    final content = widget.chapterCache[ref.chapterIndex];

    if (content == null) {
      _ensureChapterRequested(ref.chapterIndex);
      return Container(
        color: tc.bg,
        child: Center(child: LoadingWidget(message: '加载中...', color: tc.accent)),
      );
    }

    // 如果章节还没测量完成，显示第一页（整页滚动）
    if (!_measured.contains(ref.chapterIndex)) {
      return Container(
        color: tc.bg,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (content.title != null) _buildTitle(content.title!, tc),
              _buildRawHtml(content),
            ],
          ),
        ),
      );
    }

    // 已测量 → 用 ClipRect + OverflowBox + Transform 显示对应的局部页
    final yOffset = ref.localPage * _pageHeight;
    return Container(
      color: tc.bg,
      child: SizedBox(
        height: _pageHeight,
        child: ClipRect(
          child: OverflowBox(
            alignment: Alignment.topLeft,
            minHeight: 0,
            maxHeight: double.infinity,
            child: Transform.translate(
              offset: Offset(0, -yOffset),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 只在第一页显示标题
                    if (ref.localPage == 0 && content.title != null)
                      _buildTitle(content.title!, tc),
                    _buildRawHtml(content),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title, ReaderThemeColors tc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        title,
        style: TextStyle(
          fontSize: widget.settings.fontSize + 6,
          fontWeight: FontWeight.bold,
          color: tc.text,
          height: 1.4,
          fontFamily: widget.settings.isSerif ? 'serif' : null,
        ),
      ),
    );
  }

  /// 渲染章节的 HTML 内容（不含标题）
  Widget _buildRawHtml(ChapterContentDTO content) {
    if (content.content == null) return const SizedBox.shrink();
    final tc = widget.themeColors;
    final s = widget.settings;
    return Html(
      data: content.content!,
      style: {
        'body': Style(
          fontSize: FontSize(s.fontSize),
          lineHeight: LineHeight(s.lineHeight),
          color: tc.text,
          fontFamily: s.isSerif ? 'serif' : null,
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
        'p': Style(
          fontSize: FontSize(s.fontSize),
          lineHeight: LineHeight(s.lineHeight),
          color: tc.text,
          margin: Margins.only(bottom: s.fontSize * 0.8),
        ),
        'h1': Style(
          fontSize: FontSize(s.fontSize + 8),
          fontWeight: FontWeight.bold,
          color: tc.text,
          margin: Margins.only(top: 24, bottom: 12),
        ),
        'h2': Style(
          fontSize: FontSize(s.fontSize + 5),
          fontWeight: FontWeight.bold,
          color: tc.text,
          margin: Margins.only(top: 20, bottom: 10),
        ),
        'h3': Style(
          fontSize: FontSize(s.fontSize + 3),
          fontWeight: FontWeight.w600,
          color: tc.text,
          margin: Margins.only(top: 16, bottom: 8),
        ),
        'img': Style(
          display: Display.inlineBlock,
        ),
        'blockquote': Style(
          padding: HtmlPaddings.only(left: 12),
          border: Border(left: BorderSide(color: tc.accent, width: 3)),
          color: tc.muted,
          fontStyle: FontStyle.italic,
        ),
        'code': Style(
          backgroundColor: tc.card,
          padding: HtmlPaddings.symmetric(horizontal: 4, vertical: 2),
          fontSize: FontSize(s.fontSize - 2),
          fontFamily: 'monospace',
        ),
        'pre': Style(
          backgroundColor: tc.card,
          padding: HtmlPaddings.all(12),
        ),
        'a': Style(
          color: tc.accent,
          textDecoration: TextDecoration.underline,
        ),
      },
    );
  }
}
