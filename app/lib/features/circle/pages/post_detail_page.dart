import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:nova_api/nova_api.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/dialogs/app_dialog.dart';
import '../../../widgets/toast/nova_message.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../../widgets/common/skeleton_widgets.dart';
import '../services/post_service.dart';
import '../../auth/services/auth_service.dart';

/// 帖子详情页
class PostDetailPage extends StatefulWidget {
  final int postId;
  final PostResponse? initialPost;

  const PostDetailPage({
    super.key,
    required this.postId,
    this.initialPost,
  });

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final PostService _postService = PostService();
  final AuthService _authService = AuthService();
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  PostDetailResponse? _post;
  List<CommentResponse> _comments = [];
  bool _isLoading = true;
  bool _isLoadingComments = false;
  bool _hasThumb = false;
  bool _hasFavour = false;
  int _currentUserId = 0;
  int _commentPage = 1;
  bool _hasMoreComments = true;
  
  // 用户公开信息缓存
  UserPublicResponse? _authorInfo;
  final Map<int, UserPublicResponse> _commentUserInfoCache = {};

  @override
  void initState() {
    super.initState();
    _loadData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreComments();
    }
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final userInfo = await _authService.getUserInfo();
      if (userInfo != null && userInfo['id'] != null) {
        _currentUserId = int.tryParse(userInfo['id'].toString()) ?? 0;
      }

      final post = await _postService.getPostDetail(widget.postId);
      if (post != null) {
        setState(() {
          _post = post;
          _hasThumb = post.hasThumb ?? false;
          _hasFavour = post.hasFavour ?? false;
        });
        // 加载帖子作者信息
        if (post.userId != null) {
          _loadAuthorInfo(post.userId!);
        }
      }
      await _loadComments();
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

  Future<void> _loadComments() async {
    if (_isLoadingComments) return;
    setState(() => _isLoadingComments = true);
    try {
      final result = await _postService.getPostComments(
        postId: widget.postId,
        pageNum: 1,
        pageSize: 20,
      );
      if (result != null) {
        setState(() {
          _comments = result.comments?.toList() ?? [];
          _commentPage = 1;
          _hasMoreComments = _comments.length < (result.total ?? 0);
        });
      }
    } catch (e) {
      debugPrint('加载评论失败: $e');
    } finally {
      if (mounted) setState(() => _isLoadingComments = false);
    }
  }

  Future<void> _loadMoreComments() async {
    if (_isLoadingComments || !_hasMoreComments) return;
    setState(() => _isLoadingComments = true);
    try {
      final result = await _postService.getPostComments(
        postId: widget.postId,
        pageNum: _commentPage + 1,
        pageSize: 20,
      );
      if (result != null && result.comments != null) {
        setState(() {
          _comments.addAll(result.comments!.toList());
          _commentPage++;
          _hasMoreComments = _comments.length < (result.total ?? 0);
        });
      }
    } catch (e) {
      debugPrint('加载更多评论失败: $e');
    } finally {
      if (mounted) setState(() => _isLoadingComments = false);
    }
  }

  Future<void> _loadAuthorInfo(int userId) async {
    try {
      final info = await _postService.getCachedUserPublicInfo(userId);
      if (info != null && mounted) {
        setState(() {
          _authorInfo = info;
        });
      }
    } catch (e) {
      debugPrint('加载作者信息失败: $e');
    }
  }

  Future<UserPublicResponse?> _getCommentUserInfo(int userId) async {
    if (_commentUserInfoCache.containsKey(userId)) {
      return _commentUserInfoCache[userId];
    }
    try {
      final info = await _postService.getCachedUserPublicInfo(userId);
      if (info != null) {
        _commentUserInfoCache[userId] = info;
      }
      return info;
    } catch (e) {
      return null;
    }
  }

  Future<void> _toggleThumb() async {
    try {
      final result = await _postService.toggleThumb(widget.postId);
      if (result != null) {
        setState(() {
          _hasThumb = result;
          if (_post != null) {
            _post = _post!.rebuild((b) => b
              ..thumbNum = (b.thumbNum ?? 0) + (result ? 1 : -1));
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('操作失败: $e')),
        );
      }
    }
  }

  Future<void> _toggleFavour() async {
    try {
      final result = await _postService.toggleFavour(widget.postId);
      if (result != null) {
        setState(() {
          _hasFavour = result;
          if (_post != null) {
            _post = _post!.rebuild((b) => b
              ..favourNum = (b.favourNum ?? 0) + (result ? 1 : -1));
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('操作失败: $e')),
        );
      }
    }
  }

  Future<void> _submitComment() async {
    final content = _commentController.text.trim();
    if (content.isEmpty) return;

    try {
      final comment = await _postService.createComment(
        postId: widget.postId,
        content: content,
      );
      if (comment != null) {
        _commentController.clear();
        FocusScope.of(context).unfocus();
        await _loadComments();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('评论成功')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('评论失败: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(PhosphorIcons.caretLeft(), color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '帖子详情',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          if (_post != null && _post!.userId == _currentUserId)
            IconButton(
              icon: Icon(PhosphorIcons.dotsThree(), color: colors.textPrimary),
              onPressed: () => _showPostMenu(),
            ),
        ],
      ),
      body: _isLoading
          ? const DetailPageSkeleton()
          : _post == null
              ? Center(child: Text('帖子不存在', style: TextStyle(color: colors.textSecondary)))
              : Column(
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _loadData,
                        child: CustomScrollView(
                          controller: _scrollController,
                          slivers: [
                            SliverToBoxAdapter(child: _buildPostContent()),
                            SliverToBoxAdapter(child: _buildCommentHeader()),
                            _buildCommentList(),
                          ],
                        ),
                      ),
                    ),
                    _buildBottomBar(),
                  ],
                ),
    );
  }

  Widget _buildPostContent() {
    final colors = context.colors;
    return Container(
      color: colors.surface,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 作者信息
          Row(
            children: [
              GestureDetector(
                onTap: () => _showUserInfoCard(_authorInfo, _post?.userId),
                child: _authorInfo?.userAvatar != null && _authorInfo!.userAvatar!.isNotEmpty
                    ? CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(_authorInfo!.userAvatar!),
                        onBackgroundImageError: (_, __) {},
                      )
                    : CircleAvatar(
                        radius: 20,
                        backgroundColor: AppTheme.brand.withOpacity(0.1),
                        child: Icon(PhosphorIcons.user(), color: AppTheme.brand),
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () => _showUserInfoCard(_authorInfo, _post?.userId),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _authorInfo?.userName ?? '用户${_post?.userId ?? ""}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: colors.textPrimary,
                        ),
                      ),
                      Text(
                        _formatTime(_post?.createTime),
                        style: TextStyle(
                          fontSize: 12,
                          color: colors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 标题
          Text(
            _post?.title ?? '',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1.4,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          // 内容 (支持 Markdown 渲染)
          if (_post?.content != null && _post!.content!.isNotEmpty)
            MarkdownWidget(
              data: _post!.content!,
              shrinkWrap: true,
              config: MarkdownConfig(
                configs: [
                  PConfig(
                    textStyle: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: colors.textPrimary,
                    ),
                  ),
                  H1Config(
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                  H2Config(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                  H3Config(
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                  LinkConfig(
                    style: const TextStyle(
                      color: AppTheme.brand,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  PreConfig(
                    decoration: BoxDecoration(
                      color: colors.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  CodeConfig(
                    style: TextStyle(
                      backgroundColor: colors.surfaceVariant,
                      fontFamily: 'monospace',
                      color: colors.textPrimary,
                    ),
                  ),
                  ImgConfig(builder: (url, attributes) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: colors.surfaceVariant,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: colors.surfaceVariant,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Icon(PhosphorIcons.imageBroken(), color: colors.textTertiary, size: 48),
                                  const SizedBox(height: 8),
                                  Text('图片加载失败', style: TextStyle(color: colors.textSecondary)),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          // 标签
          if (_post?.tags != null && _post!.tags!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _post!.tags!.map((tag) => _buildTag(tag)).toList(),
            ),
          ],
          const SizedBox(height: 16),
          // 互动数据
          Row(
            children: [
              _buildInteractionButton(
                icon: _hasThumb ? PhosphorIcons.thumbsUp(PhosphorIconsStyle.fill) : PhosphorIcons.thumbsUp(),
                count: _post?.thumbNum ?? 0,
                isActive: _hasThumb,
                onTap: _toggleThumb,
              ),
              const SizedBox(width: 24),
              _buildInteractionButton(
                icon: _hasFavour ? PhosphorIcons.star(PhosphorIconsStyle.fill) : PhosphorIcons.star(),
                count: _post?.favourNum ?? 0,
                isActive: _hasFavour,
                activeColor: Colors.amber,
                onTap: _toggleFavour,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    required int count,
    required bool isActive,
    required VoidCallback onTap,
    Color activeColor = AppTheme.brand,
  }) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isActive ? activeColor : colors.textTertiary,
          ),
          const SizedBox(width: 6),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 14,
              color: isActive ? activeColor : colors.textSecondary,
              fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.brand.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '#$tag',
        style: const TextStyle(
          fontSize: 12,
          color: AppTheme.brand,
        ),
      ),
    );
  }

  Widget _buildCommentHeader() {
    final colors = context.colors;
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      color: colors.surface,
      child: Row(
        children: [
          Text(
            '评论',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${_post?.commentNum ?? 0}',
            style: TextStyle(
              fontSize: 14,
              color: colors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentList() {
    final colors = context.colors;
    if (_comments.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(40),
          color: colors.surface,
          child: Column(
            children: [
              Icon(PhosphorIcons.chatTeardropText(), size: 48, color: colors.textTertiary),
              const SizedBox(height: 16),
              Text(
                '暂无评论，快来抢沙发吧',
                style: TextStyle(color: colors.textSecondary),
              ),
            ],
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index >= _comments.length) {
            return _hasMoreComments
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: LoadingWidget(size: 24)),
                  )
                : null;
          }
          return _buildCommentItem(_comments[index]);
        },
        childCount: _comments.length + (_hasMoreComments ? 1 : 0),
      ),
    );
  }

  Widget _buildCommentItem(CommentResponse comment) {
    final colors = context.colors;
    final userId = comment.userId;
    final cachedInfo = userId != null ? _commentUserInfoCache[userId] : null;
    
    // 异步加载用户信息
    if (userId != null && !_commentUserInfoCache.containsKey(userId)) {
      _getCommentUserInfo(userId).then((info) {
        if (info != null && mounted) {
          setState(() {});
        }
      });
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          bottom: BorderSide(color: colors.border, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _showUserInfoCard(cachedInfo, userId),
            child: cachedInfo?.userAvatar != null && cachedInfo!.userAvatar!.isNotEmpty
                ? CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(cachedInfo.userAvatar!),
                    onBackgroundImageError: (_, __) {},
                  )
                : CircleAvatar(
                    radius: 16,
                    backgroundColor: colors.surfaceVariant,
                    child: Icon(PhosphorIcons.user(), size: 16, color: colors.textTertiary),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _showUserInfoCard(cachedInfo, userId),
                      child: Text(
                        cachedInfo?.userName ?? '用户${comment.userId ?? ""}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _formatTime(comment.createTime),
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.textTertiary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  comment.content ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    final colors = context.colors;
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: MediaQuery.of(context).padding.bottom + 8,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: colors.surfaceVariant,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: '写评论...',
                  hintStyle: TextStyle(fontSize: 14, color: colors.textTertiary),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
                style: TextStyle(fontSize: 14, color: colors.textPrimary),
                onSubmitted: (_) => _submitComment(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _submitComment,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.brand,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '发送',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
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

  void _showUserInfoCard(UserPublicResponse? userInfo, int? userId) {
    if (userInfo == null && userId == null) return;
    
    // 不显示自己的卡片关注按钮
    final isSelf = userId == _currentUserId;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (modalContext) => _UserInfoCardContent(
        userInfo: userInfo,
        userId: userId,
        isSelf: isSelf,
        postService: _postService,
      ),
    );
  }

  void _showPostMenu() {
    final colors = context.colors;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 顶部指示条
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 20),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // 编辑按钮
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.brand.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(PhosphorIcons.pencilSimple(), color: AppTheme.brand, size: 22),
                ),
                title: Text('编辑帖子', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: colors.textPrimary)),
                onTap: () {
                  Navigator.pop(context);
                  _editPost();
                },
              ),
              // 删除按钮
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(PhosphorIcons.trash(), color: Colors.red, size: 22),
                ),
                title: const Text('删除帖子', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  _deletePost();
                },
              ),
              const SizedBox(height: 16),
              Divider(height: 8, thickness: 8, color: colors.surfaceVariant),
              // 取消按钮
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  color: colors.surface,
                  child: Text(
                    '取消',
                    style: TextStyle(fontSize: 16, color: colors.textPrimary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editPost() {
    Navigator.pushNamed(
      context,
      '/circle/edit',
      arguments: {'postId': widget.postId, 'post': _post},
    ).then((result) {
      if (result == true) _loadData();
    });
  }

  Future<void> _deletePost() async {
    final confirm = await showConfirmDialog(
      context,
      title: '确认删除',
      content: '删除后无法恢复，确定要删除这篇帖子吗？',
      confirmText: '删除',
      cancelText: '取消',
      isDanger: true,
    );

    if (confirm == true) {
      try {
        final success = await _postService.deletePost(widget.postId);
        if (success && mounted) {
          Navigator.pop(context, true);
          NovaMessage.success(context, '删除成功');
        }
      } catch (e) {
        if (mounted) {
          NovaMessage.error(context, '删除失败: $e');
        }
      }
    }
  }
}

/// 用户信息卡片内容 Widget
class _UserInfoCardContent extends StatefulWidget {
  final UserPublicResponse? userInfo;
  final int? userId;
  final bool isSelf;
  final PostService postService;

  const _UserInfoCardContent({
    required this.userInfo,
    required this.userId,
    required this.isSelf,
    required this.postService,
  });

  @override
  State<_UserInfoCardContent> createState() => _UserInfoCardContentState();
}

class _UserInfoCardContentState extends State<_UserInfoCardContent> {
  bool _isFollowing = false;
  bool _isLoadingFollow = false;

  @override
  void initState() {
    super.initState();
    _checkFollowStatus();
  }

  Future<void> _checkFollowStatus() async {
    if (widget.userId == null || widget.isSelf) return;
    try {
      final result = await widget.postService.isFollowing(widget.userId!);
      if (result != null && mounted) {
        setState(() => _isFollowing = result);
      }
    } catch (e) {
      debugPrint('检查关注状态失败: $e');
    }
  }

  Future<void> _toggleFollow() async {
    if (widget.userId == null || _isLoadingFollow) return;
    setState(() => _isLoadingFollow = true);
    try {
      final result = await widget.postService.toggleFollow(widget.userId!);
      if (mounted) {
        setState(() => _isFollowing = result);
      }
    } catch (e) {
      debugPrint('关注操作失败: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoadingFollow = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = widget.userInfo;
    final userId = widget.userId;
    final isSelf = widget.isSelf;

    return Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                // 头像
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    if (userId != null) {
                      Navigator.pushNamed(
                        context,
                        '/circle/user-profile',
                        arguments: {'userId': userId, 'userInfo': userInfo},
                      );
                    }
                  },
                  child: userInfo?.userAvatar != null && userInfo!.userAvatar!.isNotEmpty
                      ? CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(userInfo.userAvatar!),
                          onBackgroundImageError: (_, __) {},
                        )
                      : CircleAvatar(
                          radius: 40,
                          backgroundColor: AppTheme.brand.withOpacity(0.1),
                          child: Icon(PhosphorIcons.user(), size: 40, color: AppTheme.brand),
                        ),
                ),
                const SizedBox(height: 12),
                // 昵称
                Text(
                  userInfo?.userName ?? '用户${userId ?? ""}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // 角色/等级
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (userInfo?.role != null && userInfo!.role!.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.brand.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          userInfo.role!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.brand,
                          ),
                        ),
                      ),
                    if (userInfo?.level != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Lv.${userInfo!.level}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.amber,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                // 简介
                if (userInfo?.userProfile != null && userInfo!.userProfile!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      userInfo.userProfile!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                // 操作按钮
                if (userId != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        // 关注按钮（非自己时显示）
                        if (!isSelf)
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _isLoadingFollow ? null : _toggleFollow,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isFollowing ? Colors.grey[200] : AppTheme.brand,
                                foregroundColor: _isFollowing ? Colors.grey[700] : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: _isLoadingFollow
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : Text(_isFollowing ? '已关注' : '关注'),
                            ),
                          ),
                      ],
                    ),
                  ),
                // 查看详情
                if (userId != null) ...[
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        '/circle/user-profile',
                        arguments: {'userId': userId, 'userInfo': userInfo},
                      );
                    },
                    child: Text(
                      '查看详细资料',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
              ],
            ),
          );
  }
}
