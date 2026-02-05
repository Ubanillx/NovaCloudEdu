import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/cards/app_card.dart';
import '../../../widgets/common/empty_widget.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../../widgets/common/nova_refresh_header.dart';
import '../../../widgets/toast/nova_message.dart';
import '../services/post_service.dart';
import 'post_detail_page.dart';
import 'post_edit_page.dart';
import 'search_page.dart';

/// 圈子页面 - 对接真实 API
class CirclePage extends StatefulWidget {
  const CirclePage({super.key});

  @override
  State<CirclePage> createState() => _CirclePageState();
}

class _CirclePageState extends State<CirclePage>
    with SingleTickerProviderStateMixin {
  final PostService _postService = PostService();
  late TabController _tabController;
  final List<String> _tabs = ['推荐', '关注', '热榜'];

  // 推荐帖子列表数据
  List<PostResponse> _posts = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  int _currentPage = 1;
  bool _hasMore = true;

  // 关注用户帖子列表数据
  List<PostResponse> _followingPosts = [];
  bool _isLoadingFollowing = false;
  bool _isLoadingMoreFollowing = false;
  int _followingPage = 1;
  bool _hasMoreFollowing = true;
  bool _followingLoaded = false; // 标记是否已加载过

  // 热榜帖子列表数据
  List<PostResponse> _topPosts = [];
  bool _isLoadingTop = false;
  bool _isLoadingMoreTop = false;
  int _topPage = 1;
  bool _hasMoreTop = true;
  int _topDays = 7; // 默认7天内
  bool _topLoaded = false; // 标记是否已加载过

  // 点赞/收藏状态缓存
  final Map<int, bool> _thumbStatus = {};
  final Map<int, bool> _favourStatus = {};
  
  // 用户公开信息缓存
  final Map<int, UserPublicResponse> _userInfoCache = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_onTabChanged);
    _loadPosts();
  }

  void _onTabChanged() {
    setState(() {});
    // 懒加载：切换到对应 Tab 时才加载数据
    if (_tabController.index == 1 && !_followingLoaded && !_isLoadingFollowing) {
      _loadFollowingPosts();
    } else if (_tabController.index == 2 && !_topLoaded && !_isLoadingTop) {
      _loadTopPosts();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadPosts() async {
    setState(() {
      _isLoading = true;
      _currentPage = 1;
    });

    try {
      final result = await _postService.getPostList(
        pageNum: 1,
        pageSize: 20,
      );
      if (result != null) {
        setState(() {
          _posts = result.posts?.toList() ?? [];
          _hasMore = _posts.length < (result.total ?? 0);
        });
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '加载失败');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loadMorePosts() async {
    if (_isLoadingMore || !_hasMore) return;
    setState(() => _isLoadingMore = true);

    try {
      final result = await _postService.getPostList(
        pageNum: _currentPage + 1,
        pageSize: 20,
      );
      if (result != null && result.posts != null) {
        setState(() {
          _posts.addAll(result.posts!.toList());
          _currentPage++;
          _hasMore = _posts.length < (result.total ?? 0);
        });
      }
    } catch (e) {
      debugPrint('加载更多失败: $e');
    } finally {
      if (mounted) setState(() => _isLoadingMore = false);
    }
  }

  // ==================== 关注用户帖子 ====================

  Future<void> _loadFollowingPosts() async {
    setState(() {
      _isLoadingFollowing = true;
      _followingPage = 1;
    });

    try {
      final result = await _postService.getFollowingPosts(
        pageNum: 1,
        pageSize: 20,
      );
      if (result != null) {
        setState(() {
          _followingPosts = result.posts?.toList() ?? [];
          _hasMoreFollowing = _followingPosts.length < (result.total ?? 0);
          _followingLoaded = true;
        });
      }
    } catch (e) {
      debugPrint('加载关注帖子失败: $e');
      if (mounted) {
        NovaMessage.error(context, '加载关注帖子失败');
      }
    } finally {
      if (mounted) setState(() => _isLoadingFollowing = false);
    }
  }

  Future<void> _loadMoreFollowingPosts() async {
    if (_isLoadingMoreFollowing || !_hasMoreFollowing) return;
    setState(() => _isLoadingMoreFollowing = true);

    try {
      final result = await _postService.getFollowingPosts(
        pageNum: _followingPage + 1,
        pageSize: 20,
      );
      if (result != null && result.posts != null) {
        setState(() {
          _followingPosts.addAll(result.posts!.toList());
          _followingPage++;
          _hasMoreFollowing = _followingPosts.length < (result.total ?? 0);
        });
      }
    } catch (e) {
      debugPrint('加载更多关注帖子失败: $e');
    } finally {
      if (mounted) setState(() => _isLoadingMoreFollowing = false);
    }
  }

  // ==================== 热榜帖子 ====================

  Future<void> _loadTopPosts() async {
    setState(() {
      _isLoadingTop = true;
      _topPage = 1;
    });

    try {
      final result = await _postService.getTopPostsByDays(
        days: _topDays == 0 ? null : _topDays,
        pageNum: 1,
        pageSize: 20,
      );
      if (result != null) {
        setState(() {
          _topPosts = result.posts?.toList() ?? [];
          _hasMoreTop = _topPosts.length < (result.total ?? 0);
          _topLoaded = true;
        });
      }
    } catch (e) {
      debugPrint('加载热榜失败: $e');
      if (mounted) {
        NovaMessage.error(context, '加载热榜失败');
      }
    } finally {
      if (mounted) setState(() => _isLoadingTop = false);
    }
  }

  Future<void> _loadMoreTopPosts() async {
    if (_isLoadingMoreTop || !_hasMoreTop) return;
    setState(() => _isLoadingMoreTop = true);

    try {
      final result = await _postService.getTopPostsByDays(
        days: _topDays == 0 ? null : _topDays,
        pageNum: _topPage + 1,
        pageSize: 20,
      );
      if (result != null && result.posts != null) {
        setState(() {
          _topPosts.addAll(result.posts!.toList());
          _topPage++;
          _hasMoreTop = _topPosts.length < (result.total ?? 0);
        });
      }
    } catch (e) {
      debugPrint('加载更多热榜失败: $e');
    } finally {
      if (mounted) setState(() => _isLoadingMoreTop = false);
    }
  }

  void _changeTopDays(int days) {
    if (_topDays != days) {
      setState(() => _topDays = days);
      _loadTopPosts();
    }
  }

  Future<UserPublicResponse?> _getUserInfo(int userId) async {
    if (_userInfoCache.containsKey(userId)) {
      return _userInfoCache[userId];
    }
    try {
      final info = await _postService.getCachedUserPublicInfo(userId);
      if (info != null) {
        _userInfoCache[userId] = info;
      }
      return info;
    } catch (e) {
      return null;
    }
  }

  Future<void> _toggleThumb(PostResponse post) async {
    final postId = post.id!;
    try {
      final result = await _postService.toggleThumb(postId);
      if (result != null) {
        setState(() {
          _thumbStatus[postId] = result;
        });
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '操作失败');
      }
    }
  }

  Future<void> _toggleFavour(PostResponse post) async {
    final postId = post.id!;
    try {
      final result = await _postService.toggleFavour(postId);
      if (result != null) {
        setState(() {
          _favourStatus[postId] = result;
        });
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '操作失败');
      }
    }
  }

  void _navigateToSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchPage()),
    );
  }

  void _navigateToCreatePost() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PostEditPage()),
    ).then((result) {
      if (result == true) _loadPosts();
    });
  }

  void _navigateToPostDetail(PostResponse post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostDetailPage(
          postId: post.id!,
          initialPost: post,
        ),
      ),
    ).then((result) {
      if (result == true) _loadPosts();
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
            _buildHeader(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPostList(),
                  _buildFollowingPostList(),
                  _buildTopPostList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 8, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '圈子',
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
                onPressed: _navigateToCreatePost,
                icon: Icon(Icons.add_box_outlined, size: 24, color: colors.iconPrimary),
                tooltip: '发布',
              ),
              IconButton(
                onPressed: _navigateToSearch,
                icon: Icon(Icons.search_rounded, size: 24, color: colors.iconPrimary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final colors = context.colors;
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = _tabController.index == index;
          return GestureDetector(
            onTap: () => _tabController.animateTo(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected 
                    ? AppTheme.brand 
                    : colors.surfaceVariant,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  _tabs[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Colors.white : colors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPostList() {
    if (_isLoading) {
      return const ListSkeleton(itemCount: 5, itemHeight: 160);
    }

    if (_posts.isEmpty) {
      return const EmptyWidget(message: '暂无帖子，快来发布第一篇吧');
    }

    return NovaRefreshableList(
      onRefresh: _loadPosts,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index >= _posts.length) {
                  if (_hasMore) {
                    _loadMorePosts();
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: LoadingWidget(size: 24, message: '加载中...'),
                    );
                  }
                  return null;
                }
                return _buildPostCard(_posts[index]);
              },
              childCount: _posts.length + (_hasMore ? 1 : 0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFollowingPostList() {
    if (_isLoadingFollowing && !_followingLoaded) {
      return const ListSkeleton(itemCount: 5, itemHeight: 160);
    }

    if (_followingPosts.isEmpty && _followingLoaded) {
      return _buildEmptyStateWithAction(
        '关注更多用户，获取精彩内容',
        '去发现',
        _navigateToSearch,
      );
    }

    if (!_followingLoaded) {
      return const ListSkeleton(itemCount: 5, itemHeight: 160);
    }

    return NovaRefreshableList(
      onRefresh: _loadFollowingPosts,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index >= _followingPosts.length) {
                  if (_hasMoreFollowing) {
                    _loadMoreFollowingPosts();
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: LoadingWidget(size: 24, message: '加载中...'),
                    );
                  }
                  return null;
                }
                return _buildPostCard(_followingPosts[index]);
              },
              childCount: _followingPosts.length + (_hasMoreFollowing ? 1 : 0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopPostList() {
    if (_isLoadingTop && !_topLoaded) {
      return const ListSkeleton(itemCount: 5, itemHeight: 120);
    }

    if (!_topLoaded) {
      return const ListSkeleton(itemCount: 5, itemHeight: 120);
    }

    return NovaRefreshableList(
      onRefresh: _loadTopPosts,
      slivers: [
        // 时间筛选器
        SliverToBoxAdapter(
          child: _buildTopDaysFilter(),
        ),
        // 帖子列表
        if (_topPosts.isEmpty)
          const SliverFillRemaining(
            child: EmptyWidget(message: '暂无热门帖子'),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index >= _topPosts.length) {
                    if (_hasMoreTop) {
                      _loadMoreTopPosts();
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: LoadingWidget(size: 24, message: '加载中...'),
                      );
                    }
                    return null;
                  }
                  return _buildTopPostCard(_topPosts[index], index + 1);
                },
                childCount: _topPosts.length + (_hasMoreTop ? 1 : 0),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTopDaysFilter() {
    final colors = context.colors;
    final options = [
      {'label': '24小时', 'days': 1},
      {'label': '7天', 'days': 7},
      {'label': '30天', 'days': 30},
      {'label': '全部', 'days': 0},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: options.map((option) {
          final isSelected = _topDays == option['days'];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => _changeTopDays(option['days'] as int),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppTheme.brand 
                      : colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  option['label'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Colors.white : colors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTopPostCard(PostResponse post, int rank) {
    final colors = context.colors;

    Color rankColor;
    if (rank == 1) {
      rankColor = const Color(0xFFFF6B6B);
    } else if (rank == 2) {
      rankColor = const Color(0xFFFF9F43);
    } else if (rank == 3) {
      rankColor = const Color(0xFFFFD93D);
    } else {
      rankColor = colors.textTertiary;
    }

    return AppCard(
      onTap: () => _navigateToPostDetail(post),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 排名
          Container(
            width: 28,
            height: 28,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: rankColor.withOpacity(rank <= 3 ? 1 : 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '$rank',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: rank <= 3 ? Colors.white : Colors.grey[600],
                ),
              ),
            ),
          ),
          // 内容
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title ?? '',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    color: colors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.thumb_up, size: 14, color: AppTheme.brand),
                    const SizedBox(width: 4),
                    Text(
                      '${post.thumbNum ?? 0}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.brand,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.chat_bubble_outline, size: 14, color: colors.textTertiary),
                    const SizedBox(width: 4),
                    Text(
                      '${post.commentNum ?? 0}',
                      style: TextStyle(fontSize: 12, color: colors.textSecondary),
                    ),
                    const Spacer(),
                    Text(
                      _formatTime(post.createTime),
                      style: TextStyle(fontSize: 11, color: colors.textTertiary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyStateWithAction(String message, String actionText, VoidCallback onAction) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TDEmpty(
            type: TDEmptyType.plain,
            emptyText: message,
            image: Icon(
              Icons.people_outline,
              size: 96,
              color: context.colors.textTertiary,
            ),
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            text: actionText,
            onTap: onAction,
            width: 120,
            size: TDButtonSize.medium,
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(PostResponse post) {
    final colors = context.colors;
    final isDark = context.isDarkMode;
    final hasThumb = _thumbStatus[post.id] ?? false;
    final hasFavour = _favourStatus[post.id] ?? false;
    
    final userId = post.userId;
    final cachedInfo = userId != null ? _userInfoCache[userId] : null;
    
    // 异步加载用户信息
    if (userId != null && !_userInfoCache.containsKey(userId)) {
      _getUserInfo(userId).then((info) {
        if (info != null && mounted) {
          setState(() {});
        }
      });
    }

    return AppCard(
      onTap: () => _navigateToPostDetail(post),
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 用户信息
          Row(
            children: [
              cachedInfo?.userAvatar != null && cachedInfo!.userAvatar!.isNotEmpty
                  ? CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(cachedInfo.userAvatar!),
                      onBackgroundImageError: (_, __) {},
                    )
                  : CircleAvatar(
                      radius: 18,
                      backgroundColor: AppTheme.brand.withOpacity(isDark ? 0.2 : 0.1),
                      child: const Icon(Icons.person, size: 20, color: AppTheme.brand),
                    ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cachedInfo?.userName ?? '用户${post.userId ?? ""}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                      ),
                    ),
                    Text(
                      _formatTime(post.createTime),
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 标题
          Text(
            post.title ?? '',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              height: 1.3,
              color: colors.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          // 内容
          Text(
            post.content ?? '',
            style: TextStyle(
              fontSize: 14,
              color: colors.textSecondary,
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          // 标签
          if (post.tags != null && post.tags!.isNotEmpty && post.tags!.any((t) => t.isNotEmpty)) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: post.tags!
                  .where((t) => t.isNotEmpty)
                  .take(3)
                  .map((tag) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.brand.withOpacity(isDark ? 0.15 : 0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '#$tag',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.brand,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
          const SizedBox(height: 12),
          // 底部操作栏
          Row(
            children: [
              _buildActionButton(
                icon: hasThumb ? Icons.thumb_up : Icons.thumb_up_outlined,
                count: post.thumbNum ?? 0,
                isActive: hasThumb,
                activeColor: AppTheme.brand,
                onTap: () => _toggleThumb(post),
              ),
              const SizedBox(width: 24),
              _buildActionButton(
                icon: Icons.chat_bubble_outline,
                count: post.commentNum ?? 0,
                onTap: () => _navigateToPostDetail(post),
              ),
              const SizedBox(width: 24),
              _buildActionButton(
                icon: hasFavour ? Icons.star : Icons.star_outline,
                count: post.favourNum ?? 0,
                isActive: hasFavour,
                activeColor: colors.warning,
                onTap: () => _toggleFavour(post),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required int count,
    bool isActive = false,
    Color? activeColor,
    VoidCallback? onTap,
  }) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isActive ? activeColor : colors.textTertiary,
          ),
          const SizedBox(width: 4),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 13,
              color: isActive ? activeColor : colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '';
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inMinutes < 1) return '刚刚';
    if (diff.inHours < 1) return '${diff.inMinutes}分钟前';
    if (diff.inDays < 1) return '${diff.inHours}小时前';
    if (diff.inDays < 7) return '${diff.inDays}天前';
    return '${time.month}月${time.day}日';
  }
}
