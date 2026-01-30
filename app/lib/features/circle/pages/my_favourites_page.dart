import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import '../../../config/app_theme.dart';
import '../services/post_service.dart';
import 'post_detail_page.dart';

/// 我的收藏帖子页面
class MyFavouritesPage extends StatefulWidget {
  const MyFavouritesPage({super.key});

  @override
  State<MyFavouritesPage> createState() => _MyFavouritesPageState();
}

class _MyFavouritesPageState extends State<MyFavouritesPage> {
  final PostService _postService = PostService();
  List<PostResponse> _posts = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  int _currentPage = 1;
  bool _hasMore = true;
  
  // 用户公开信息缓存
  final Map<int, UserPublicResponse> _userInfoCache = {};

  @override
  void initState() {
    super.initState();
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    setState(() {
      _isLoading = true;
      _currentPage = 1;
    });

    try {
      final result = await _postService.getMyFavourites(
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('加载失败: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || !_hasMore) return;
    setState(() => _isLoadingMore = true);

    try {
      final result = await _postService.getMyFavourites(
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

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '我的收藏',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _posts.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(
                  onRefresh: _loadFavourites,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification &&
                          notification.metrics.pixels >=
                              notification.metrics.maxScrollExtent - 200) {
                        _loadMore();
                      }
                      return false;
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _posts.length + (_hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= _posts.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return _buildPostItem(_posts[index]);
                      },
                    ),
                  ),
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star_outline, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            '暂无收藏',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '收藏感兴趣的帖子，方便随时查看',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
        ],
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
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailPage(
              postId: post.id!,
              initialPost: post,
            ),
          ),
        ).then((_) => _loadFavourites());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                cachedInfo?.userAvatar != null && cachedInfo!.userAvatar!.isNotEmpty
                    ? CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(cachedInfo.userAvatar!),
                        onBackgroundImageError: (_, __) {},
                      )
                    : CircleAvatar(
                        radius: 16,
                        backgroundColor: AppTheme.brand.withOpacity(0.1),
                        child: const Icon(Icons.person, size: 16, color: AppTheme.brand),
                      ),
                const SizedBox(width: 8),
                Text(
                  cachedInfo?.userName ?? '用户${post.userId ?? ""}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  _formatTime(post.createTime),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              post.title ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              post.content ?? '',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (post.tags != null && post.tags!.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                children: post.tags!
                    .take(3)
                    .map((tag) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.brand.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '#$tag',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppTheme.brand,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.thumb_up_outlined, size: 14, color: Colors.grey[400]),
                const SizedBox(width: 4),
                Text(
                  '${post.thumbNum ?? 0}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
                const SizedBox(width: 16),
                Icon(Icons.chat_bubble_outline, size: 14, color: Colors.grey[400]),
                const SizedBox(width: 4),
                Text(
                  '${post.commentNum ?? 0}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.star, size: 14, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '${post.favourNum ?? 0}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ],
        ),
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
