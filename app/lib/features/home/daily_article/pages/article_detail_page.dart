import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:nova_api/nova_api.dart';
import '../../../../config/app_theme.dart';
import '../../../../widgets/toast/nova_message.dart';
import '../services/daily_article_service.dart';
import 'article_chat_page.dart';

/// 文章详情页面 - 支持Markdown渲染
class ArticleDetailPage extends StatefulWidget {
  final DailyArticleResponse article;

  const ArticleDetailPage({
    super.key,
    required this.article,
  });

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final DailyArticleService _service = DailyArticleService();
  final ScrollController _scrollController = ScrollController();

  bool _isLiked = false;
  bool _isCollected = false;
  bool _isLoading = false;
  int _likeCount = 0;
  int _collectCount = 0;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.article.likeCount ?? 0;
    _collectCount = widget.article.collectCount ?? 0;
    _markAsRead();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _markAsRead() async {
    if (widget.article.id == null) return;
    try {
      await _service.markAsRead(widget.article.id!);
    } catch (e) {
      debugPrint('标记已读失败: $e');
    }
  }

  Future<void> _toggleLike() async {
    if (widget.article.id == null || _isLoading) return;

    setState(() => _isLoading = true);
    try {
      await _service.toggleLike(widget.article.id!);
      setState(() {
        _isLiked = !_isLiked;
        _likeCount += _isLiked ? 1 : -1;
      });
      if (mounted) {
        NovaMessage.success(context, _isLiked ? '点赞成功' : '已取消点赞');
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '操作失败');
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleCollect() async {
    if (widget.article.id == null || _isLoading) return;

    setState(() => _isLoading = true);
    try {
      await _service.toggleCollect(widget.article.id!);
      setState(() {
        _isCollected = !_isCollected;
        _collectCount += _isCollected ? 1 : -1;
      });
      if (mounted) {
        NovaMessage.success(context, _isCollected ? '收藏成功' : '已取消收藏');
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '操作失败');
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _openAiChat() {
    if (widget.article.id == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleChatPage(
          articleId: widget.article.id!,
          articleTitle: widget.article.title ?? '文章',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: colors.background,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // 顶部AppBar
          _buildSliverAppBar(colors, isDark),
          // 文章内容
          SliverToBoxAdapter(
            child: _buildArticleContent(colors, isDark),
          ),
        ],
      ),
      // 底部操作栏
      bottomNavigationBar: _buildBottomBar(colors),
    );
  }

  Widget _buildSliverAppBar(AppColors colors, bool isDark) {
    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      stretch: true,
      backgroundColor: colors.surface,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.35),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.35),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.share_rounded, color: Colors.white, size: 18),
          ),
          onPressed: () {
            NovaMessage.show(context, '分享功能开发中');
          },
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                      : [AppTheme.brand, AppTheme.brand2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // 背景装饰图
            Positioned(
              right: -30,
              bottom: -20,
              child: Icon(
                Icons.auto_stories_rounded,
                size: 180,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // 分类标签
                    if (widget.article.category != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.article.category!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    // 标题
                    Text(
                      widget.article.title ?? '无标题',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.4,
                        letterSpacing: 0.5,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleContent(AppColors colors, bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 40),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 作者和阅读信息
          _buildArticleMeta(colors),
          const SizedBox(height: 32),
          // 摘要（如果有）
          if (widget.article.summary != null && widget.article.summary!.isNotEmpty) ...[
            _buildSummary(colors),
            const SizedBox(height: 32),
          ],
          // Markdown内容
          _buildMarkdownContent(colors, isDark),
          const SizedBox(height: 40),
          // 标签
          if (widget.article.tags != null && widget.article.tags!.isNotEmpty) ...[
            _buildTags(colors),
          ],
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildSummary(AppColors colors) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tips_and_updates_rounded, color: AppTheme.brand, size: 18),
              const SizedBox(width: 8),
              Text(
                'AI 导读',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.article.summary!,
            style: TextStyle(
              fontSize: 15,
              color: colors.textSecondary,
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleMeta(AppColors colors) {
    return Row(
      children: [
        // 作者头像
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppTheme.brand.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: AppTheme.brand.withOpacity(0.2)),
          ),
          child: const Icon(
            Icons.person_rounded,
            color: AppTheme.brand,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.article.author ?? '未知作者',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  _buildMetaItem(colors, Icons.schedule_rounded, '${widget.article.readTime ?? 5}min阅读'),
                  const SizedBox(width: 16),
                  _buildMetaItem(colors, Icons.visibility_outlined, '${widget.article.viewCount ?? 0}次阅读'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetaItem(AppColors colors, IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 14, color: colors.textTertiary),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: colors.textTertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildMarkdownContent(AppColors colors, bool isDark) {
    final content = widget.article.content ?? '';

    if (content.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Text(
            '暂无正文内容',
            style: TextStyle(color: colors.textSecondary),
          ),
        ),
      );
    }

    // Markdown配置
    final config = isDark
        ? MarkdownConfig.darkConfig.copy(configs: [
            H1Config(style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: colors.textPrimary, height: 1.6)),
            H2Config(style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colors.textPrimary, height: 1.6)),
            H3Config(style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: colors.textPrimary, height: 1.6)),
            PConfig(textStyle: TextStyle(fontSize: 17, color: colors.textPrimary, height: 1.8, letterSpacing: 0.2)),
            BlockquoteConfig(sideColor: AppTheme.brand, textColor: colors.textSecondary),
          ])
        : MarkdownConfig.defaultConfig.copy(configs: [
            H1Config(style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: colors.textPrimary, height: 1.6)),
            H2Config(style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colors.textPrimary, height: 1.6)),
            H3Config(style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: colors.textPrimary, height: 1.6)),
            PConfig(textStyle: TextStyle(fontSize: 17, color: colors.textPrimary, height: 1.8, letterSpacing: 0.2)),
            BlockquoteConfig(sideColor: AppTheme.brand, textColor: colors.textSecondary),
          ]);

    return MarkdownBlock(
      data: content,
      config: config,
    );
  }

  Widget _buildTags(AppColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 14,
              decoration: BoxDecoration(
                color: AppTheme.brand,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '相关标签',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: widget.article.tags!.map((tag) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: colors.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.border.withOpacity(0.5)),
              ),
              child: Text(
                '# $tag',
                style: TextStyle(
                  fontSize: 13,
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBottomBar(AppColors colors) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 点赞
          _ActionButton(
            icon: _isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            label: '$_likeCount',
            isActive: _isLiked,
            activeColor: Colors.redAccent,
            onTap: _toggleLike,
            colors: colors,
          ),
          const SizedBox(width: 32),
          // 收藏
          _ActionButton(
            icon: _isCollected ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            label: '$_collectCount',
            isActive: _isCollected,
            activeColor: Colors.amber,
            onTap: _toggleCollect,
            colors: colors,
          ),
          const Spacer(),
          // AI讨论按钮
          GestureDetector(
            onTap: _openAiChat,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                color: AppTheme.brand,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.brand.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.smart_toy_rounded, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'AI 对话',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 操作按钮
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final Color activeColor;
  final VoidCallback onTap;
  final AppColors colors;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.onTap,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? activeColor : colors.textTertiary;
    
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 26,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: colors.textSecondary,
              fontWeight: FontWeight.w600,
              fontFamily: 'Din',
            ),
          ),
        ],
      ),
    );
  }
}
