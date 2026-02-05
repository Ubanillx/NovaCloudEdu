import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import '../../../config/app_theme.dart';
import '../../../core/network/api_client.dart';
import '../../../widgets/cards/app_card.dart';
import '../../../widgets/common/empty_widget.dart';
import '../../../widgets/common/loading_widget.dart';
import '../services/post_service.dart';
import 'post_detail_page.dart';
import 'user_profile_page.dart';

/// 聚合搜索页面（帖子+用户）
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  final PostService _postService = PostService();
  final DefaultApi _api = ApiClient.instance.defaultApi;
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  final List<String> _tabs = ['帖子', '用户'];
  String _keyword = '';
  bool _isSearching = false;

  // 帖子搜索结果
  List<PostResponse> _posts = [];
  bool _isLoadingPosts = false;
  int _postPage = 1;
  bool _hasMorePosts = true;

  // 点赞/收藏状态缓存
  final Map<int, bool> _thumbStatus = {};
  final Map<int, bool> _favourStatus = {};

  // 用户搜索结果
  List<SearchUserResponse> _users = [];
  bool _isLoadingUsers = false;

  // 用户公开信息缓存
  final Map<int, UserPublicResponse> _userInfoCache = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging && _keyword.isNotEmpty) {
        _search();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String value) {
    final keyword = value.trim();
    if (keyword.isEmpty) return;
    setState(() {
      _keyword = keyword;
      _isSearching = true;
    });
    _search();
  }

  Future<void> _search() async {
    if (_tabController.index == 0) {
      await _searchPosts();
    } else {
      await _searchUsers();
    }
  }

  Future<void> _searchPosts() async {
    if (_isLoadingPosts) return;
    setState(() {
      _isLoadingPosts = true;
      _postPage = 1;
    });

    try {
      final result = await _postService.searchPosts(
        keyword: _keyword,
        pageNum: 1,
        pageSize: 20,
      );
      if (result != null) {
        setState(() {
          _posts = result.posts?.toList() ?? [];
          _hasMorePosts = _posts.length < (result.total ?? 0);
        });
      }
    } catch (e) {
      debugPrint('搜索帖子失败: $e');
    } finally {
      if (mounted) setState(() => _isLoadingPosts = false);
    }
  }

  Future<void> _loadMorePosts() async {
    if (_isLoadingPosts || !_hasMorePosts) return;
    setState(() => _isLoadingPosts = true);

    try {
      final result = await _postService.searchPosts(
        keyword: _keyword,
        pageNum: _postPage + 1,
        pageSize: 20,
      );
      if (result != null && result.posts != null) {
        setState(() {
          _posts.addAll(result.posts!.toList());
          _postPage++;
          _hasMorePosts = _posts.length < (result.total ?? 0);
        });
      }
    } catch (e) {
      debugPrint('加载更多帖子失败: $e');
    } finally {
      if (mounted) setState(() => _isLoadingPosts = false);
    }
  }

  Future<void> _searchUsers() async {
    if (_isLoadingUsers) return;
    setState(() => _isLoadingUsers = true);

    try {
      final response = await _api.searchUsers(
        searchUserRequestDTO: SearchUserRequestDTO((b) => b
          ..keyword = _keyword
          ..pageNum = 1
          ..pageSize = 20),
      );
      if (response.data?.data?.records != null) {
        setState(() {
          _users = response.data!.data!.records!.toList();
        });
      }
    } catch (e) {
      debugPrint('搜索用户失败: $e');
    } finally {
      if (mounted) setState(() => _isLoadingUsers = false);
    }
  }

  Future<void> _toggleThumb(PostResponse post) async {
    final postId = post.id!;
    try {
      final result = await _postService.toggleThumb(postId);
      if (result != null) {
        setState(() {
          _thumbStatus[postId] = result;
          // 更新列表中的数据显示
          final index = _posts.indexWhere((p) => p.id == postId);
          if (index != -1) {
            final oldPost = _posts[index];
            _posts[index] = oldPost.rebuild((b) => b
              ..thumbNum = (b.thumbNum ?? 0) + (result ? 1 : -1));
          }
        });
      }
    } catch (e) {
      // 忽略错误
    }
  }

  Future<void> _toggleFavour(PostResponse post) async {
    final postId = post.id!;
    try {
      final result = await _postService.toggleFavour(postId);
      if (result != null) {
        setState(() {
          _favourStatus[postId] = result;
          // 更新列表中的数据显示
          final index = _posts.indexWhere((p) => p.id == postId);
          if (index != -1) {
            final oldPost = _posts[index];
            _posts[index] = oldPost.rebuild((b) => b
              ..favourNum = (b.favourNum ?? 0) + (result ? 1 : -1));
          }
        });
      }
    } catch (e) {
      // 忽略错误
    }
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _keyword = '';
      _isSearching = false;
      _posts.clear();
      _users.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: context.colors.surface,
        foregroundColor: context.colors.textPrimary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: context.colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: _buildSearchBar(),
      ),
      body: _isSearching ? _buildSearchResults() : _buildSearchHint(),
    );
  }

  Widget _buildSearchBar() {
    final colors = context.colors;
    return Container(
      height: 40,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.search, size: 20, color: colors.textTertiary),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              autofocus: false,
              decoration: InputDecoration(
                hintText: '搜索帖子、用户...',
                hintStyle: TextStyle(fontSize: 14, color: colors.textTertiary),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                isDense: true,
              ),
              style: TextStyle(fontSize: 14, color: colors.textPrimary),
              onSubmitted: _onSearchSubmitted,
              textInputAction: TextInputAction.search,
            ),
          ),
          if (_searchController.text.isNotEmpty)
            GestureDetector(
              onTap: _clearSearch,
              child: Icon(Icons.cancel, size: 18, color: colors.textTertiary),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchHint() {
    final colors = context.colors;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_rounded, size: 64, color: colors.textTertiary),
          const SizedBox(height: 16),
          Text(
            '搜索帖子或用户',
            style: TextStyle(
              fontSize: 16,
              color: colors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            color: context.colors.surface,
            child: TabBar(
              controller: _tabController,
              labelColor: AppTheme.brand,
              unselectedLabelColor: context.colors.textSecondary,
              labelStyle: const TextStyle(fontWeight: FontWeight.w600),
              indicatorColor: AppTheme.brand,
              indicatorSize: TabBarIndicatorSize.label,
              dividerColor: Colors.transparent,
              tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
            ),
          ),
        ),
        SliverFillRemaining(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildPostResults(),
              _buildUserResults(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPostResults() {
    if (_isLoadingPosts && _posts.isEmpty) {
      return const Center(child: LoadingWidget());
    }

    if (_posts.isEmpty) {
      return const EmptyWidget(message: '没有找到相关帖子');
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.pixels >= notification.metrics.maxScrollExtent - 200) {
          _loadMorePosts();
        }
        return false;
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _posts.length + (_hasMorePosts ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= _posts.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: LoadingWidget(size: 24),
            );
          }
          return _buildPostItem(_posts[index]);
        },
      ),
    );
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

  Widget _buildPostItem(PostResponse post) {
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailPage(
              postId: post.id!,
              initialPost: post,
            ),
          ),
        );
      },
      margin: const EdgeInsets.only(bottom: 12),
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

  Widget _buildUserResults() {
    if (_isLoadingUsers) {
      return const Center(child: LoadingWidget());
    }

    if (_users.isEmpty) {
      return const EmptyWidget(message: '没有找到相关用户');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _users.length,
      itemBuilder: (context, index) => _buildUserItem(_users[index]),
    );
  }

  Widget _buildUserItem(SearchUserResponse user) {
    final colors = context.colors;
    return AppCard(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfilePage(
              userId: user.userId!,
            ),
          ),
        );
      },
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppTheme.brand.withOpacity(0.1),
            backgroundImage: (user.userAvatar != null && user.userAvatar!.isNotEmpty)
                ? NetworkImage(user.userAvatar!)
                : null,
            child: (user.userAvatar == null || user.userAvatar!.isEmpty)
                ? const Icon(Icons.person, color: AppTheme.brand)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.userName ?? '用户${user.userId}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
                if (user.userProfile != null && user.userProfile!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    user.userProfile!,
                    style: TextStyle(
                      fontSize: 13,
                      color: colors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: colors.iconSecondary),
        ],
      ),
    );
  }
}
