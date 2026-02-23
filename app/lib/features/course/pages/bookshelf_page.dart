import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nova_api/nova_api.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../../widgets/common/skeleton_widgets.dart';
import '../../../widgets/common/empty_widget.dart';
import '../../../widgets/toast/nova_message.dart';
import '../../auth/services/auth_service.dart';
import '../services/book_service.dart';
import 'book_reader_page.dart';

/// 电子书书架页面
class BookshelfPage extends StatefulWidget {
  const BookshelfPage({super.key});

  @override
  State<BookshelfPage> createState() => _BookshelfPageState();
}

class _BookshelfPageState extends State<BookshelfPage> with SingleTickerProviderStateMixin {
  final BookService _bookService = BookService();
  late TabController _tabController;

  // 我的书架
  List<UserShelfDTO> _shelfBooks = [];
  bool _shelfLoading = true;

  // 全部书籍
  List<BookDTO> _allBooks = [];
  bool _allBooksLoading = true;
  int _allBooksPage = 1;
  bool _allBooksHasMore = true;

  // 搜索
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<BookDTO> _searchResults = [];

  int? _userId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) setState(() {});
    });
    _loadUserAndData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUserAndData() async {
    final userInfo = await AuthService().getUserInfo();
    if (userInfo != null && userInfo['id'] != null) {
      _userId = int.tryParse(userInfo['id'].toString());
    }
    await Future.wait([_loadShelf(), _loadAllBooks()]);
  }

  Future<void> _loadShelf() async {
    if (_userId == null) {
      if (mounted) setState(() => _shelfLoading = false);
      return;
    }
    try {
      final shelf = await _bookService.getUserShelf(_userId!);
      if (mounted) {
        setState(() {
          _shelfBooks = shelf.toList();
          _shelfLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _shelfLoading = false);
    }
  }

  Future<void> _loadAllBooks() async {
    try {
      _allBooksPage = 1;
      final books = await _bookService.listBooks(page: _allBooksPage, size: 20);
      if (mounted) {
        setState(() {
          _allBooks = books.toList();
          _allBooksHasMore = books.length >= 20;
          _allBooksLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _allBooksLoading = false);
    }
  }

  Future<void> _loadMoreBooks() async {
    if (!_allBooksHasMore) return;
    try {
      _allBooksPage++;
      final books = await _bookService.listBooks(page: _allBooksPage, size: 20);
      if (mounted) {
        setState(() {
          _allBooks.addAll(books.toList());
          _allBooksHasMore = books.length >= 20;
        });
      }
    } catch (e) {
      _allBooksPage--;
    }
  }

  Future<void> _searchBooks(String keyword) async {
    if (keyword.trim().isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults = [];
      });
      return;
    }
    setState(() => _isSearching = true);
    try {
      final results = await _bookService.searchBooks(keyword: keyword.trim());
      if (mounted) {
        setState(() => _searchResults = results.toList());
      }
    } catch (e) {
      if (mounted) NovaMessage.error(context, '搜索失败');
    }
  }

  Future<void> _addToShelf(BookDTO book) async {
    if (_userId == null || book.id == null) return;
    try {
      await _bookService.addToShelf(_userId!, book.id!);
      if (mounted) {
        NovaMessage.success(context, '已加入书架');
        _loadShelf();
      }
    } catch (e) {
      if (mounted) NovaMessage.error(context, '加入书架失败');
    }
  }

  Future<void> _removeFromShelf(UserShelfDTO shelfItem) async {
    if (_userId == null || shelfItem.bookId == null) return;
    try {
      await _bookService.removeFromShelf(_userId!, shelfItem.bookId!);
      if (mounted) {
        NovaMessage.success(context, '已移出书架');
        _loadShelf();
      }
    } catch (e) {
      if (mounted) NovaMessage.error(context, '移出书架失败');
    }
  }

  void _openReader(int bookId, {int? initialChapter}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookReaderPage(
          bookId: bookId,
          initialChapterIndex: initialChapter ?? 0,
        ),
      ),
    ).then((_) {
      // 返回后刷新书架数据
      _loadShelf();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(colors),
            _buildSearchBar(colors),
            if (_isSearching)
              Expanded(child: _buildSearchResults(colors))
            else ...[
              _buildTabBar(colors),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildShelfTab(colors),
                    _buildAllBooksTab(colors),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ==================== 顶部栏 ====================

  Widget _buildHeader(AppColors colors) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 20, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(PhosphorIcons.caretLeft(), size: 22, color: colors.iconPrimary),
            style: IconButton.styleFrom(
              backgroundColor: colors.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              fixedSize: const Size(44, 44),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '电子书库',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: colors.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
                if (_shelfBooks.isNotEmpty)
                  Text(
                    '${_shelfBooks.length} 本在架',
                    style: TextStyle(fontSize: 12, color: colors.textSecondary, height: 1.5),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== 搜索栏 ====================

  Widget _buildSearchBar(AppColors colors) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.divider.withValues(alpha: 0.5)),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (v) => _searchBooks(v),
          style: TextStyle(fontSize: 14, color: colors.textPrimary),
          decoration: InputDecoration(
            hintText: '搜索书名或作者...',
            hintStyle: TextStyle(color: colors.textTertiary, fontSize: 14),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Icon(PhosphorIcons.magnifyingGlass(), size: 20, color: colors.iconSecondary),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 44),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(PhosphorIcons.xCircle(PhosphorIconsStyle.fill), size: 18, color: colors.iconSecondary),
                    onPressed: () {
                      _searchController.clear();
                      _searchBooks('');
                    },
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  // ==================== Tab 栏 ====================

  Widget _buildTabBar(AppColors colors) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppTheme.brand,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppTheme.brand.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: colors.textSecondary,
        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        dividerHeight: 0,
        splashFactory: NoSplash.splashFactory,
        tabs: [
          Tab(
            height: 38,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIcons.bookmarks(_tabController.index == 0
                      ? PhosphorIconsStyle.fill : PhosphorIconsStyle.regular),
                  size: 16,
                ),
                const SizedBox(width: 6),
                const Text('我的书架'),
              ],
            ),
          ),
          Tab(
            height: 38,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIcons.books(_tabController.index == 1
                      ? PhosphorIconsStyle.fill : PhosphorIconsStyle.regular),
                  size: 16,
                ),
                const SizedBox(width: 6),
                const Text('书库浏览'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== 我的书架 ====================

  Widget _buildShelfTab(AppColors colors) {
    if (_shelfLoading) return const GridCardSkeleton();
    if (_shelfBooks.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(PhosphorIcons.bookmarks(), size: 64,
                color: colors.textTertiary.withValues(alpha: 0.3)),
            const SizedBox(height: 16),
            Text('书架空空如也',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
                    color: colors.textSecondary)),
            const SizedBox(height: 6),
            Text('去书库浏览添加感兴趣的书籍吧',
                style: TextStyle(fontSize: 13, color: colors.textTertiary)),
            const SizedBox(height: 24),
            FilledButton.tonalIcon(
              onPressed: () => _tabController.animateTo(1),
              icon: Icon(PhosphorIcons.compass(), size: 18),
              label: const Text('浏览书库'),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.brand.withValues(alpha: 0.1),
                foregroundColor: AppTheme.brand,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _loadShelf,
      color: AppTheme.brand,
      child: GridView.builder(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 14,
          childAspectRatio: 0.52,
        ),
        itemCount: _shelfBooks.length,
        itemBuilder: (ctx, i) => _buildShelfCard(_shelfBooks[i], colors),
      ),
    );
  }

  Widget _buildShelfCard(UserShelfDTO item, AppColors colors) {
    final progress = (item.readingProgress != null && item.readingProgress! > 0)
        ? (item.readingProgress!.toDouble() / 100.0).clamp(0.0, 1.0)
        : 0.0;

    return GestureDetector(
      onTap: () {
        if (item.bookId != null) {
          _openReader(item.bookId!, initialChapter: item.lastChapterIndex);
        }
      },
      onLongPress: () => _showShelfItemMenu(item),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 封面
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                        alpha: context.isDarkMode ? 0.3 : 0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _buildCoverImage(item.bookCoverUrl, colors),
                  ),
                  // 进度条叠加在封面底部
                  if (progress > 0)
                    Positioned(
                      left: 0, right: 0, bottom: 0,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(12)),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 3,
                          backgroundColor: Colors.black.withValues(alpha: 0.2),
                          valueColor:
                              const AlwaysStoppedAnimation(AppTheme.brand),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // 标题
          Text(
            item.bookTitle ?? '未知书名',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 2),
          // 作者 / 进度
          Text(
            progress > 0
                ? '已读 ${(progress * 100).toStringAsFixed(0)}%'
                : item.bookAuthor ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              color: progress > 0 ? AppTheme.brand : colors.textTertiary,
              fontWeight: progress > 0 ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _showShelfItemMenu(UserShelfDTO item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final colors = context.colors;
        return Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36, height: 4,
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  decoration: BoxDecoration(
                    color: colors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // 书籍信息头
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 40, height: 56,
                          child: _buildCoverImage(item.bookCoverUrl, colors),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.bookTitle ?? '未知书名',
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: colors.textPrimary)),
                            const SizedBox(height: 2),
                            Text(item.bookAuthor ?? '未知作者',
                                style: TextStyle(fontSize: 12,
                                    color: colors.textSecondary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: colors.divider),
                // 操作
                ListTile(
                  leading: Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(PhosphorIcons.trash(), size: 18,
                        color: Colors.red[400]),
                  ),
                  title: Text('移出书架',
                      style: TextStyle(fontSize: 15,
                          color: Colors.red[400],
                          fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.pop(ctx);
                    _removeFromShelf(item);
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==================== 全部书籍 ====================

  Widget _buildAllBooksTab(AppColors colors) {
    if (_allBooksLoading) return const GridCardSkeleton();
    if (_allBooks.isEmpty) {
      return const EmptyWidget(message: '暂无书籍');
    }
    return RefreshIndicator(
      onRefresh: _loadAllBooks,
      color: AppTheme.brand,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              notification.metrics.pixels >=
                  notification.metrics.maxScrollExtent - 100) {
            _loadMoreBooks();
          }
          return false;
        },
        child: GridView.builder(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 14,
            childAspectRatio: 0.52,
          ),
          itemCount: _allBooks.length,
          itemBuilder: (ctx, i) => _buildBookCard(_allBooks[i], colors),
        ),
      ),
    );
  }

  Widget _buildBookCard(BookDTO book, AppColors colors) {
    final isInShelf = _shelfBooks.any((s) => s.bookId == book.id);

    return GestureDetector(
      onTap: () {
        if (book.id != null) _openReader(book.id!);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 封面
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                        alpha: context.isDarkMode ? 0.3 : 0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _buildCoverImage(book.coverUrl, colors),
                  ),
                  // 文件类型标签
                  if (book.fileType != null)
                    Positioned(
                      top: 6, left: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: _getFileTypeColor(book.fileType!),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          book.fileType!.toUpperCase(),
                          style: const TextStyle(color: Colors.white,
                              fontSize: 8, fontWeight: FontWeight.w700,
                              letterSpacing: 0.5),
                        ),
                      ),
                    ),
                  // 在架标记
                  if (isInShelf)
                    Positioned(
                      top: 6, right: 6,
                      child: Container(
                        width: 22, height: 22,
                        decoration: BoxDecoration(
                          color: AppTheme.brand,
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.brand.withValues(alpha: 0.4),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(PhosphorIcons.check(), size: 12,
                            color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // 标题
          Text(
            book.title ?? '未知书名',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 2),
          // 作者 / 加入书架
          Row(
            children: [
              Expanded(
                child: Text(
                  book.author ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10, color: colors.textTertiary),
                ),
              ),
              if (!isInShelf)
                GestureDetector(
                  onTap: () => _addToShelf(book),
                  child: Icon(PhosphorIcons.plus(), size: 16,
                      color: AppTheme.brand),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // ==================== 搜索结果 ====================

  Widget _buildSearchResults(AppColors colors) {
    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(PhosphorIcons.magnifyingGlass(), size: 56,
                color: colors.textTertiary.withValues(alpha: 0.3)),
            const SizedBox(height: 12),
            Text('未找到相关书籍',
                style: TextStyle(fontSize: 14, color: colors.textSecondary)),
          ],
        ),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 14,
        childAspectRatio: 0.52,
      ),
      itemCount: _searchResults.length,
      itemBuilder: (ctx, i) => _buildBookCard(_searchResults[i], colors),
    );
  }

  // ==================== 工具方法 ====================

  Widget _buildCoverImage(String? url, AppColors colors) {
    if (url != null && url.isNotEmpty) {
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (_, __) => _buildCoverPlaceholder(colors),
          errorWidget: (_, __, ___) => _buildDefaultCover(colors),
        ),
      );
    }
    return _buildDefaultCover(colors);
  }

  Widget _buildCoverPlaceholder(AppColors colors) {
    return Container(
      color: colors.surface,
      child: Center(
        child: SizedBox(
          width: 20, height: 20,
          child: ShimmerLoading(
            child: SkeletonBox(height: 20, width: 20, borderRadius: 4),
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultCover(AppColors colors) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.brand.withValues(alpha: 0.08),
            AppTheme.brand.withValues(alpha: 0.18),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(PhosphorIcons.bookOpen(), size: 32,
              color: AppTheme.brand.withValues(alpha: 0.4)),
          const SizedBox(height: 4),
          Text(
            '暂无封面',
            style: TextStyle(fontSize: 9,
                color: AppTheme.brand.withValues(alpha: 0.4),
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Color _getFileTypeColor(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return Colors.red[400]!;
      case 'epub':
        return Colors.green[400]!;
      case 'txt':
        return Colors.blue[400]!;
      case 'docx':
      case 'doc':
        return Colors.indigo[400]!;
      default:
        return Colors.grey[400]!;
    }
  }
}
