import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:nova_api/nova_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../../widgets/toast/nova_message.dart';
import '../../auth/services/auth_service.dart';
import '../services/book_service.dart';
import '../widgets/chapter_drawer.dart';
import '../widgets/reader_settings_sheet.dart';
import '../widgets/reader_ai_panel.dart';
import '../widgets/reader_bookmark_sheet.dart';
import '../widgets/page_turn_effect.dart';
import '../widgets/paged_chapter_reader.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// 电子书阅读器页面
class BookReaderPage extends StatefulWidget {
  final int bookId;
  final int initialChapterIndex;

  const BookReaderPage({
    super.key,
    required this.bookId,
    this.initialChapterIndex = 0,
  });

  @override
  State<BookReaderPage> createState() => _BookReaderPageState();
}

class _BookReaderPageState extends State<BookReaderPage> {
  final BookService _bookService = BookService();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // 数据
  BookDTO? _book;
  List<ChapterDTO> _chapters = [];
  int _currentChapterIndex = 0;
  bool _isLoading = true;
  bool _isContentLoading = false;
  int? _userId;

  // 章节内容缓存（预加载用）
  final Map<int, ChapterContentDTO> _chapterCache = {};
  final Set<int> _loadingChapters = {};

  // 竖直滚动模式 - 已加载的连续章节范围
  int _verticalStartChapter = 0;
  int _verticalEndChapter = 0;

  // 水平/仿真模式 - 分页阅读器
  final GlobalKey<PagedChapterReaderState> _pagedReaderKey = GlobalKey();
  final GlobalKey<SimulatedPageTurnState> _simulatedKey = GlobalKey();

  // 阅读设置
  final ReaderSettings _settings = ReaderSettings();

  // PDF 相关
  bool _isPdf = false;
  String? _pdfLocalPath;
  bool _pdfLoading = false;

  // 书签
  List<ReadingBookmarkDTO> _bookmarks = [];

  // UI 状态
  bool _showAppBar = true;

  ChapterContentDTO? get _currentContent => _chapterCache[_currentChapterIndex];

  @override
  void initState() {
    super.initState();
    _currentChapterIndex = widget.initialChapterIndex;
    _verticalStartChapter = _currentChapterIndex;
    _verticalEndChapter = _currentChapterIndex;
    _scrollController.addListener(_onVerticalScroll);
    _loadData();
  }

  @override
  void dispose() {
    _saveProgress();
    _scrollController.removeListener(_onVerticalScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    // 获取用户ID
    final userInfo = await AuthService().getUserInfo();
    if (userInfo != null && userInfo['id'] != null) {
      _userId = int.tryParse(userInfo['id'].toString());
    }

    try {
      final book = await _bookService.getBook(widget.bookId);
      final chapters = await _bookService.getBookChapters(widget.bookId);
      if (mounted) {
        setState(() {
          _book = book;
          _chapters = chapters.toList();
          _isPdf = book.fileType?.toUpperCase() == 'PDF';
          _isLoading = false;
        });
        _loadBookmarks();
        if (_isPdf) {
          _loadPdf();
        } else if (_chapters.isNotEmpty) {
          _initPageController();
          _loadChapterToCache(_currentChapterIndex).then((_) {
            if (mounted) setState(() => _isContentLoading = false);
            _preloadAdjacentChapters(_currentChapterIndex);
          });
          setState(() => _isContentLoading = true);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        NovaMessage.error(context, '加载书籍失败: ${e.toString()}');
      }
    }
  }

  void _initPageController() {
    // PagedChapterReader 内部管理 PageController，此处仅做兼容
  }

  /// 加载章节到缓存（不会重复加载）
  Future<void> _loadChapterToCache(int index) async {
    if (index < 0 || index >= _chapters.length) return;
    if (_chapterCache.containsKey(index) || _loadingChapters.contains(index)) return;

    _loadingChapters.add(index);
    try {
      final content = await _bookService.getChapterContent(widget.bookId, index);
      if (mounted) {
        _chapterCache[index] = content;
        setState(() {});
      }
    } catch (e) {
      debugPrint('预加载章节 $index 失败: $e');
    } finally {
      _loadingChapters.remove(index);
    }
  }

  /// 预加载当前章节的前后章节
  void _preloadAdjacentChapters(int index) {
    if (index + 1 < _chapters.length) _loadChapterToCache(index + 1);
    if (index - 1 >= 0) _loadChapterToCache(index - 1);
  }

  /// 竖直滚动模式 - 监听滚动位置，自动加载更多章节
  void _onVerticalScroll() {
    if (_settings.pageTurnMode != PageTurnMode.vertical) return;
    if (!_scrollController.hasClients) return;

    final pos = _scrollController.position;
    final maxScroll = pos.maxScrollExtent;
    final current = pos.pixels;

    // 接近底部时，扩展加载下一章节
    if (maxScroll - current < 600 && _verticalEndChapter < _chapters.length - 1) {
      final next = _verticalEndChapter + 1;
      if (!_chapterCache.containsKey(next) && !_loadingChapters.contains(next)) {
        _loadChapterToCache(next).then((_) {
          if (mounted) {
            setState(() => _verticalEndChapter = next);
            _preloadAdjacentChapters(next);
          }
        });
      } else if (_chapterCache.containsKey(next)) {
        setState(() => _verticalEndChapter = next);
      }
    }

    // 接近顶部时，扩展加载上一章节
    if (current < 600 && _verticalStartChapter > 0) {
      final prev = _verticalStartChapter - 1;
      if (!_chapterCache.containsKey(prev) && !_loadingChapters.contains(prev)) {
        _loadChapterToCache(prev).then((_) {
          if (mounted) setState(() => _verticalStartChapter = prev);
        });
      } else if (_chapterCache.containsKey(prev)) {
        setState(() => _verticalStartChapter = prev);
      }
    }

    // 更新当前章节索引（用于底栏进度显示）
    _updateCurrentChapterFromScroll();
  }

  /// 根据滚动位置推算当前章节
  void _updateCurrentChapterFromScroll() {
    // 简化：基于已加载章节数和滚动比例推算
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    if (pos.maxScrollExtent <= 0) return;

    final ratio = pos.pixels / pos.maxScrollExtent;
    final totalLoaded = _verticalEndChapter - _verticalStartChapter + 1;
    final estimated = _verticalStartChapter + (ratio * totalLoaded).floor();
    final newIndex = estimated.clamp(_verticalStartChapter, _verticalEndChapter);

    if (newIndex != _currentChapterIndex) {
      setState(() => _currentChapterIndex = newIndex);
      _saveProgress();
      _preloadAdjacentChapters(newIndex);
    }
  }

  Future<void> _loadPdf() async {
    setState(() => _pdfLoading = true);
    try {
      final url = await _bookService.getPdfUrl(widget.bookId);
      debugPrint('PDF URL: $url');
      final dir = await getTemporaryDirectory();
      final filePath = '${dir.path}/book_${widget.bookId}.pdf';
      final file = File(filePath);

      // 如果缓存文件太小（可能是上次下载失败的残留），删除重新下载
      if (await file.exists() && await file.length() < 1024) {
        await file.delete();
      }

      if (!await file.exists()) {
        final downloadDio = Dio(BaseOptions(
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(minutes: 5),
        ));
        await downloadDio.download(url, filePath);
      }

      if (mounted) {
        setState(() {
          _pdfLocalPath = filePath;
          _pdfLoading = false;
        });
      }
    } catch (e) {
      debugPrint('PDF加载失败: $e');
      if (mounted) {
        setState(() => _pdfLoading = false);
        NovaMessage.error(context, 'PDF加载失败: ${e.toString().length > 50 ? e.toString().substring(0, 50) : e}');
      }
    }
  }

  Future<void> _saveProgress() async {
    if (_userId == null) return;
    await _bookService.updateProgress(
      userId: _userId!,
      bookId: widget.bookId,
      chapterIndex: _currentChapterIndex,
    );
  }

  void _goToChapter(int index) {
    if (index < 0 || index >= _chapters.length) return;
    setState(() => _currentChapterIndex = index);

    switch (_settings.pageTurnMode) {
      case PageTurnMode.vertical:
        _verticalStartChapter = index;
        _verticalEndChapter = index;
        _loadChapterToCache(index).then((_) {
          if (mounted) {
            setState(() {});
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.hasClients) _scrollController.jumpTo(0);
            });
            _preloadAdjacentChapters(index);
          }
        });
        break;
      case PageTurnMode.horizontal:
      case PageTurnMode.simulated:
        _pagedReaderKey.currentState?.goToChapter(index);
        _preloadAdjacentChapters(index);
        break;
    }
    _saveProgress();
  }

  void _toggleAppBar() {
    setState(() => _showAppBar = !_showAppBar);
  }

  void _openSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => ReaderSettingsSheet(
        settings: _settings,
        onChanged: () => setState(() {}),
      ),
    );
  }

  void _openChapterDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  Future<void> _loadBookmarks() async {
    if (_userId == null) return;
    try {
      final bms = await _bookService.getBookmarks(widget.bookId, _userId!);
      if (mounted) setState(() => _bookmarks = bms.toList());
    } catch (_) {}
  }

  void _openAiPanel() {
    final currentChapter = _chapters.isNotEmpty && _currentChapterIndex < _chapters.length
        ? _chapters[_currentChapterIndex]
        : null;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => ReaderAiPanel(
        bookId: widget.bookId,
        chapterId: currentChapter?.id,
        chapterIndex: _currentChapterIndex,
        userId: _userId ?? 0,
        themeColors: _settings.themeColors,
      ),
    );
  }

  void _openBookmarks() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => ReaderBookmarkSheet(
        bookId: widget.bookId,
        userId: _userId ?? 0,
        bookmarks: _bookmarks,
        themeColors: _settings.themeColors,
        onGoToChapter: _goToChapter,
        onRefresh: _loadBookmarks,
      ),
    );
  }

  Future<void> _addBookmark() async {
    if (_userId == null) return;
    final result = await showAddBookmarkDialog(context, _settings.themeColors);
    if (result == null) return;
    final currentChapter = _chapters.isNotEmpty && _currentChapterIndex < _chapters.length
        ? _chapters[_currentChapterIndex]
        : null;
    try {
      await _bookService.createBookmark(
        bookId: widget.bookId,
        userId: _userId!,
        chapterId: currentChapter?.id ?? 0,
        chapterIndex: _currentChapterIndex,
        bookmarkTitle: result['title']?.isNotEmpty == true ? result['title'] : '第${_currentChapterIndex + 1}章书签',
        note: result['note']?.isNotEmpty == true ? result['note'] : null,
      );
      if (mounted) {
        NovaMessage.success(context, '书签已添加');
        _loadBookmarks();
      }
    } catch (e) {
      if (mounted) NovaMessage.error(context, '添加书签失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: _settings.themeColors.bg,
        body: const PageLoading(),
      );
    }

    final tc = _settings.themeColors;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: tc.bg,
      drawer: !_isPdf && _chapters.isNotEmpty
          ? ChapterDrawer(
              chapters: _chapters,
              currentIndex: _currentChapterIndex,
              onChapterSelected: _goToChapter,
            )
          : null,
      body: GestureDetector(
        onTap: _toggleAppBar,
        child: Stack(
          children: [
            // 主内容区
            _isPdf ? _buildPdfContent(tc) : _buildHtmlContent(tc),
            // 顶部栏
            if (_showAppBar) _buildTopBar(tc),
            // 底部进度条
            if (_showAppBar && !_isPdf && _chapters.isNotEmpty) _buildBottomBar(tc),
          ],
        ),
      ),
    );
  }

  // ==================== HTML 阅读器（模式分发） ====================

  Widget _buildHtmlContent(ReaderThemeColors tc) {
    if (_isContentLoading) {
      return Center(child: LoadingWidget(message: '加载中...', color: tc.accent));
    }

    switch (_settings.pageTurnMode) {
      case PageTurnMode.vertical:
        return _buildVerticalScrollContent(tc);
      case PageTurnMode.horizontal:
        return _buildHorizontalSwipeContent(tc);
      case PageTurnMode.simulated:
        return _buildSimulatedContent(tc);
    }
  }

  // ==================== 竖直滚动模式（无感章节拼接） ====================

  Widget _buildVerticalScrollContent(ReaderThemeColors tc) {
    // 收集已加载的连续章节
    final List<int> loadedIndices = [];
    for (int i = _verticalStartChapter; i <= _verticalEndChapter; i++) {
      if (_chapterCache.containsKey(i)) {
        loadedIndices.add(i);
      }
    }

    if (loadedIndices.isEmpty) {
      return Center(
        child: Text('暂无内容', style: TextStyle(color: tc.muted, fontSize: 15)),
      );
    }

    return SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.fromLTRB(20, _showAppBar ? 90 : 40, 20, _showAppBar ? 90 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final idx in loadedIndices) ...[
            _buildChapterHtml(_chapterCache[idx]!, tc),
            // 章节间分隔线
            if (idx != loadedIndices.last)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  children: [
                    Expanded(child: Divider(color: tc.border)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        _chapters[idx + 1].title ?? '第 ${idx + 2} 章',
                        style: TextStyle(fontSize: 11, color: tc.muted),
                      ),
                    ),
                    Expanded(child: Divider(color: tc.border)),
                  ],
                ),
              ),
          ],
          // 底部加载指示器
          if (_verticalEndChapter < _chapters.length - 1)
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Center(
                child: SizedBox(
                  width: 20, height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: tc.accent),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ==================== 水平滑动 / 仿真翻页 共用分页阅读器 ====================

  Widget _buildHorizontalSwipeContent(ReaderThemeColors tc) => _buildPagedReader(tc, PageTurnMode.horizontal);
  Widget _buildSimulatedContent(ReaderThemeColors tc) => _buildPagedReader(tc, PageTurnMode.simulated);

  Widget _buildPagedReader(ReaderThemeColors tc, PageTurnMode mode) {
    return PagedChapterReader(
      key: _pagedReaderKey,
      chapterCount: _chapters.length,
      chapterCache: _chapterCache,
      settings: _settings,
      themeColors: tc,
      initialChapterIndex: _currentChapterIndex,
      mode: mode,
      simulatedKey: mode == PageTurnMode.simulated ? _simulatedKey : null,
      showAppBar: _showAppBar,
      onChapterChanged: (index) {
        setState(() => _currentChapterIndex = index);
        _saveProgress();
      },
      onLoadChapter: _loadChapterToCache,
    );
  }

  /// 构建单个章节的 HTML 渲染内容
  Widget _buildChapterHtml(ChapterContentDTO content, ReaderThemeColors tc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 章节标题
        if (content.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              content.title!,
              style: TextStyle(
                fontSize: _settings.fontSize + 6,
                fontWeight: FontWeight.bold,
                color: tc.text,
                height: 1.4,
                fontFamily: _settings.isSerif ? 'serif' : null,
              ),
            ),
          ),
        // HTML 内容
        if (content.content != null)
          Html(
            data: content.content!,
            style: {
              'body': Style(
                fontSize: FontSize(_settings.fontSize),
                lineHeight: LineHeight(_settings.lineHeight),
                color: tc.text,
                fontFamily: _settings.isSerif ? 'serif' : null,
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
              ),
              'p': Style(
                fontSize: FontSize(_settings.fontSize),
                lineHeight: LineHeight(_settings.lineHeight),
                color: tc.text,
                margin: Margins.only(bottom: _settings.fontSize * 0.8),
              ),
              'h1': Style(
                fontSize: FontSize(_settings.fontSize + 8),
                fontWeight: FontWeight.bold,
                color: tc.text,
                margin: Margins.only(top: 24, bottom: 12),
              ),
              'h2': Style(
                fontSize: FontSize(_settings.fontSize + 5),
                fontWeight: FontWeight.bold,
                color: tc.text,
                margin: Margins.only(top: 20, bottom: 10),
              ),
              'h3': Style(
                fontSize: FontSize(_settings.fontSize + 3),
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
                fontSize: FontSize(_settings.fontSize - 2),
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
          ),
      ],
    );
  }

  // ==================== PDF 阅读器 ====================

  Widget _buildPdfContent(ReaderThemeColors tc) {
    if (_pdfLoading || _pdfLocalPath == null) {
      return Center(child: LoadingWidget(message: 'PDF加载中...', color: tc.accent));
    }

    // 使用 flutter_pdfview
    // 注意：需要动态导入，这里用条件构建
    return _buildPdfViewer(tc);
  }

  Widget _buildPdfViewer(ReaderThemeColors tc) {
    // flutter_pdfview 需要在运行时检测
    try {
      return _PdfViewWrapper(filePath: _pdfLocalPath!, themeColors: tc);
    } catch (e) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(PhosphorIcons.filePdf(), size: 64, color: tc.muted),
            const SizedBox(height: 12),
            Text('PDF 预览暂不可用', style: TextStyle(color: tc.muted, fontSize: 15)),
          ],
        ),
      );
    }
  }

  // ==================== 顶部栏 ====================

  Widget _buildTopBar(ReaderThemeColors tc) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        opacity: _showAppBar ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [tc.bg, tc.bg.withValues(alpha: 0.0)],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 4, 4, 16),
              child: Row(
                children: [
                  // 返回
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(PhosphorIcons.caretLeft(), size: 20, color: tc.text),
                  ),
                  // 标题
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _book?.title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: tc.text,
                          ),
                        ),
                        if (!_isPdf && _currentContent?.title != null)
                          Text(
                            _currentContent!.title!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 11, color: tc.muted),
                          ),
                      ],
                    ),
                  ),
                  // 功能按钮
                  if (!_isPdf)
                    IconButton(
                      onPressed: _openChapterDrawer,
                      icon: Icon(PhosphorIcons.list(), size: 22, color: tc.text),
                      tooltip: '目录',
                    ),
                  IconButton(
                    onPressed: _addBookmark,
                    icon: Icon(PhosphorIcons.bookmarkSimple(), size: 22, color: tc.text),
                    tooltip: '添加书签',
                  ),
                  IconButton(
                    onPressed: _openBookmarks,
                    icon: Badge(
                      isLabelVisible: _bookmarks.isNotEmpty,
                      label: Text('${_bookmarks.length}', style: const TextStyle(fontSize: 8)),
                      child: Icon(PhosphorIcons.bookmarks(), size: 22, color: tc.text),
                    ),
                    tooltip: '书签列表',
                  ),
                  IconButton(
                    onPressed: _openAiPanel,
                    icon: Icon(PhosphorIcons.sparkle(), size: 22, color: tc.text),
                    tooltip: 'AI 助手',
                  ),
                  IconButton(
                    onPressed: _openSettings,
                    icon: Icon(PhosphorIcons.textAa(), size: 22, color: tc.text),
                    tooltip: '设置',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==================== 底部进度条 ====================

  Widget _buildBottomBar(ReaderThemeColors tc) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        opacity: _showAppBar ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [tc.bg, tc.bg.withValues(alpha: 0.0)],
            ),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 翻页模式指示
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _settings.pageTurnMode == PageTurnMode.vertical
                            ? PhosphorIcons.arrowsDownUp()
                            : _settings.pageTurnMode == PageTurnMode.horizontal
                                ? PhosphorIcons.arrowsLeftRight()
                                : PhosphorIcons.bookOpenText(),
                        size: 14,
                        color: tc.muted.withValues(alpha: 0.5),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _settings.pageTurnMode == PageTurnMode.vertical
                            ? '竖直滚动'
                            : _settings.pageTurnMode == PageTurnMode.horizontal
                                ? '水平滑动'
                                : '仿真翻页',
                        style: TextStyle(fontSize: 10, color: tc.muted.withValues(alpha: 0.5)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // 进度
                  Text(
                    '${_currentChapterIndex + 1} / ${_chapters.length}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: tc.muted,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: _chapters.isNotEmpty
                          ? (_currentChapterIndex + 1) / _chapters.length
                          : 0,
                      minHeight: 3,
                      backgroundColor: tc.border,
                      valueColor: AlwaysStoppedAnimation(tc.accent),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== PDF Viewer 封装 ====================

class _PdfViewWrapper extends StatefulWidget {
  final String filePath;
  final ReaderThemeColors themeColors;

  const _PdfViewWrapper({required this.filePath, required this.themeColors});

  @override
  State<_PdfViewWrapper> createState() => _PdfViewWrapperState();
}

class _PdfViewWrapperState extends State<_PdfViewWrapper> {
  int _currentPage = 0;
  int _totalPages = 0;

  @override
  Widget build(BuildContext context) {
    final tc = widget.themeColors;
    return Stack(
      children: [
        PDFView(
          filePath: widget.filePath,
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: true,
          pageFling: true,
          fitPolicy: FitPolicy.BOTH,
          onRender: (pages) {
            if (mounted && pages != null) {
              setState(() => _totalPages = pages);
            }
          },
          onPageChanged: (page, total) {
            if (mounted) {
              setState(() {
                _currentPage = page ?? 0;
                _totalPages = total ?? _totalPages;
              });
            }
          },
        ),
        if (_totalPages > 0)
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: tc.card.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: tc.border),
                ),
                child: Text(
                  '${_currentPage + 1} / $_totalPages',
                  style: TextStyle(fontSize: 12, color: tc.text, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
