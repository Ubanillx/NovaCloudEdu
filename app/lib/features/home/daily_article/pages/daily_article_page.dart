import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import '../../../../config/app_theme.dart';
import '../../../../widgets/common/loading_widget.dart';
import '../../../../widgets/common/empty_widget.dart';
import '../../../../widgets/toast/nova_message.dart';
import '../services/daily_article_service.dart';
import 'article_detail_page.dart';

/// 每日美文页面
class DailyArticlePage extends StatefulWidget {
  const DailyArticlePage({super.key});

  @override
  State<DailyArticlePage> createState() => _DailyArticlePageState();
}

class _DailyArticlePageState extends State<DailyArticlePage> {
  final DailyArticleService _service = DailyArticleService();
  final PageController _pageController = PageController();

  List<DailyArticleResponse> _articles = [];
  bool _isLoading = true;
  bool _hasError = false;
  int _currentIndex = 0;
  int _selectedSize = 5;

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadArticles() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final articles = await _service.getTodayArticles(size: _selectedSize);
      if (mounted) {
        setState(() {
          _articles = articles;
          _isLoading = false;
          _currentIndex = 0;
        });
        if (_pageController.hasClients) {
          _pageController.jumpToPage(0);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
        NovaMessage.error(context, '加载失败，请重试');
      }
    }
  }

  void _showSettingsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _SettingsSheet(
        selectedSize: _selectedSize,
        onApply: (size) {
          setState(() => _selectedSize = size);
          _loadArticles();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text(
          '每日美文',
          style: TextStyle(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.tune_rounded, color: colors.textPrimary),
            onPressed: _showSettingsSheet,
            tooltip: '设置',
          ),
        ],
      ),
      body: _buildBody(colors),
    );
  }

  Widget _buildBody(AppColors colors) {
    if (_isLoading) {
      return const PageLoading(message: '正在加载文章...');
    }

    if (_hasError) {
      return NetworkErrorWidget(
        message: '加载失败，请重试',
        onRetry: _loadArticles,
      );
    }

    if (_articles.isEmpty) {
      return const EmptyWidget(
        message: '暂无文章数据',
      );
    }

    return Column(
      children: [
        // 进度指示器
        _buildProgressIndicator(colors),
        // 文章卡片
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: _articles.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return _buildArticleCard(_articles[index], colors);
            },
          ),
        ),
        // 底部操作栏
        _buildBottomBar(colors),
      ],
    );
  }

  Widget _buildProgressIndicator(AppColors colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_currentIndex + 1} / ${_articles.length}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                  fontFamily: 'Din',
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.brand.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '今日精选',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.brand,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: (_currentIndex + 1) / _articles.length,
              backgroundColor: colors.surfaceVariant,
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.brand),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard(DailyArticleResponse article, AppColors colors) {
    final isDark = context.isDarkMode;

    return GestureDetector(
      onTap: () => _navigateToDetail(article),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                : [AppTheme.brand, AppTheme.brand2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: (isDark ? Colors.black : AppTheme.brand).withOpacity(0.25),
              blurRadius: 25,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              // 背景装饰圆圈
              Positioned(
                top: -50,
                right: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 分类和难度标签
                    Row(
                      children: [
                        if (article.category != null)
                          _buildCardTag(article.category!, Colors.white.withOpacity(0.25)),
                        const SizedBox(width: 8),
                        if (article.difficultyDesc != null)
                          _buildCardTag(article.difficultyDesc!, Colors.white.withOpacity(0.15)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // 标题
                    Text(
                      article.title ?? '无标题',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.4,
                        letterSpacing: 0.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                    // 作者
                    if (article.author != null)
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 1,
                            color: Colors.white54,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            article.author!,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 24),
                    // 摘要
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Text(
                            article.summary ?? article.content ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.95),
                              height: 1.8,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // 底部卡片统计
                    _buildCardFooter(article),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardTag(String text, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildCardFooter(DailyArticleResponse article) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildFooterIconItem(Icons.schedule_rounded, '${article.readTime ?? 5}min'),
            const SizedBox(width: 16),
            _buildFooterIconItem(Icons.visibility_outlined, '${article.viewCount ?? 0}'),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.touch_app_rounded, color: Colors.white70, size: 16),
            const SizedBox(width: 4),
            Text(
              '点击阅读全文',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterIconItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 16),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(AppColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 上一篇
          _CircleIconButton(
            icon: Icons.chevron_left_rounded,
            onTap: _currentIndex > 0
                ? () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutQuart,
                    );
                  }
                : null,
            colors: colors,
          ),
          // 阅读全文按钮
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () => _navigateToDetail(_articles[_currentIndex]),
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppTheme.brand,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.brand.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.menu_book_rounded, color: Colors.white, size: 20),
                      SizedBox(width: 10),
                      Text(
                        '阅读全文',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // 下一篇
          _CircleIconButton(
            icon: Icons.chevron_right_rounded,
            onTap: _currentIndex < _articles.length - 1
                ? () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutQuart,
                    );
                  }
                : null,
            colors: colors,
          ),
        ],
      ),
    );
  }

  void _navigateToDetail(DailyArticleResponse article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailPage(article: article),
      ),
    );
  }
}

/// 圆形图标按钮
class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final AppColors colors;

  const _CircleIconButton({
    required this.icon,
    this.onTap,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onTap == null;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: colors.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: isDisabled ? colors.textTertiary : colors.textPrimary,
          size: 24,
        ),
      ),
    );
  }
}

/// 设置底部弹窗
class _SettingsSheet extends StatefulWidget {
  final int selectedSize;
  final void Function(int size) onApply;

  const _SettingsSheet({
    required this.selectedSize,
    required this.onApply,
  });

  @override
  State<_SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<_SettingsSheet> {
  late int _size;

  @override
  void initState() {
    super.initState();
    _size = widget.selectedSize;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 拖动指示器
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: colors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // 标题
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              '阅读设置',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: colors.textPrimary,
              ),
            ),
          ),
          // 文章数量
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '每日文章数量',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: DailyArticleService.sizeOptions.map((size) {
                    final isSelected = _size == size;
                    return GestureDetector(
                      onTap: () => setState(() => _size = size),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.brand
                              : colors.surfaceVariant,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$size篇',
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected
                                ? Colors.white
                                : colors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          // 确认按钮
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onApply(_size);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.brand,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    '应用设置',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
