import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/common/skeleton_widgets.dart';
import '../../../widgets/toast/nova_message.dart';
import '../../../widgets/dialogs/app_dialog.dart';
import '../constants/post_types.dart';
import '../services/post_service.dart';
import '../../chat/services/friend_service.dart';
import '../../chat/pages/private_chat_page.dart';
import 'post_detail_page.dart';

/// 用户公开资料页面
class UserProfilePage extends StatefulWidget {
  final int userId;
  final UserPublicResponse? initialUserInfo;

  const UserProfilePage({
    super.key,
    required this.userId,
    this.initialUserInfo,
  });

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final PostService _postService = PostService();
  final FriendService _friendService = FriendService();

  UserPublicResponse? _userInfo;
  List<PostResponse> _posts = [];
  bool _isLoading = true;
  bool _isLoadingPosts = false;
  bool _isFollowing = false;
  bool _isLoadingFollow = false;
  bool _isFriend = false;
  bool _hasPendingRequest = false;
  bool _isLoadingFriend = false;

  @override
  void initState() {
    super.initState();
    _userInfo = widget.initialUserInfo;
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      // 加载用户信息
      final userInfo = await _postService.getUserPublicInfo(widget.userId);
      if (userInfo != null && mounted) {
        setState(() => _userInfo = userInfo);
      }

      // 检查关注状态
      final followStatus = await _postService.isFollowing(widget.userId);
      if (followStatus != null && mounted) {
        setState(() => _isFollowing = followStatus);
      }

      // 检查好友状态
      await _checkFriendStatus();

      // 加载用户帖子
      await _loadPosts();
    } catch (e) {
      debugPrint('加载用户信息失败: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loadPosts() async {
    if (_isLoadingPosts) return;
    setState(() => _isLoadingPosts = true);
    try {
      final posts = await _postService.getUserPosts(widget.userId);
      if (posts != null && mounted) {
        setState(() => _posts = posts);
      }
    } catch (e) {
      debugPrint('加载用户帖子失败: $e');
    } finally {
      if (mounted) setState(() => _isLoadingPosts = false);
    }
  }

  Future<void> _toggleFollow() async {
    if (_isLoadingFollow) return;
    setState(() => _isLoadingFollow = true);
    try {
      final result = await _postService.toggleFollow(widget.userId);
      if (mounted) {
        setState(() => _isFollowing = result);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('操作失败: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoadingFollow = false);
    }
  }

  /// 检查好友状态
  Future<void> _checkFriendStatus() async {
    try {
      final isFriend = await _friendService.checkFriendship(widget.userId);
      if (mounted) {
        setState(() => _isFriend = isFriend);
      }
    } catch (e) {
      debugPrint('检查好友状态失败: $e');
    }
  }

  /// 发送好友申请
  Future<void> _sendFriendRequest() async {
    if (_isLoadingFriend) return;

    // 显示输入验证消息对话框
    final message = await showInputDialog(
      context,
      title: '添加好友',
      hintText: '请输入验证消息（可选）',
      confirmText: '发送申请',
    );

    if (message == null) return; // 用户取消

    setState(() => _isLoadingFriend = true);
    try {
      final success = await _friendService.sendFriendRequest(
        receiverId: widget.userId,
        message: message.isNotEmpty ? message : null,
      );
      if (mounted) {
        if (success) {
          NovaMessage.success(context, '好友申请已发送');
          setState(() => _hasPendingRequest = true);
        } else {
          NovaMessage.error(context, '发送失败');
        }
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '发送失败');
      }
    } finally {
      if (mounted) setState(() => _isLoadingFriend = false);
    }
  }

  /// 开始聊天
  void _startChat() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PrivateChatPage(
          partnerId: widget.userId,
          partnerName: _userInfo?.userName ?? '用户${widget.userId}',
          partnerAvatar: _userInfo?.userAvatar,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(_userInfo?.userName ?? '用户资料'),
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(PhosphorIcons.caretLeft(), color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const ProfileSkeleton()
          : RefreshIndicator(
              onRefresh: _loadData,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _buildHeader()),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  SliverToBoxAdapter(child: _buildBasicInfoCard()),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  SliverToBoxAdapter(child: _buildPostsHeader()),
                  _buildPostsList(),
                  const SliverToBoxAdapter(child: SizedBox(height: 40)),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    final colors = context.colors;
    return Container(
      color: colors.surface,
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          const SizedBox(height: 24),
          // 头像
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: colors.border.withOpacity(0.2),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipOval(
              child:
                  _userInfo?.userAvatar != null &&
                      _userInfo!.userAvatar!.isNotEmpty
                  ? Image.network(
                      _userInfo!.userAvatar!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildDefaultAvatar(),
                    )
                  : _buildDefaultAvatar(),
            ),
          ),
          const SizedBox(height: 16),
          // 昵称
          Text(
            _userInfo?.userName ?? '用户${widget.userId}',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 24),
          // 操作按钮
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                // 关注按钮
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoadingFollow ? null : _toggleFollow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isFollowing
                          ? colors.surfaceVariant
                          : AppTheme.brand,
                      foregroundColor: _isFollowing
                          ? colors.textSecondary
                          : Colors.white,
                      elevation: _isFollowing ? 0 : 2,
                      shadowColor: AppTheme.brand.withOpacity(0.4),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: _isLoadingFollow
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _isFollowing
                                    ? PhosphorIcons.check(
                                        PhosphorIconsStyle.fill,
                                      )
                                    : PhosphorIcons.plus(
                                        PhosphorIconsStyle.fill,
                                      ),
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _isFollowing ? '已关注' : '关注',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                // 好友/聊天按钮
                Expanded(
                  child: _isFriend
                      ? ElevatedButton(
                          onPressed: _startChat,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(PhosphorIcons.chatTeardropText(), size: 18),
                              SizedBox(width: 4),
                              Text(
                                '发消息',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ElevatedButton(
                          onPressed: _hasPendingRequest || _isLoadingFriend
                              ? null
                              : _sendFriendRequest,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _hasPendingRequest
                                ? colors.surfaceVariant
                                : Colors.orange,
                            foregroundColor: _hasPendingRequest
                                ? colors.textSecondary
                                : Colors.white,
                            elevation: _hasPendingRequest ? 0 : 2,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: _isLoadingFriend
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _hasPendingRequest
                                          ? PhosphorIcons.hourglass(
                                              PhosphorIconsStyle.fill,
                                            )
                                          : PhosphorIcons.userPlus(),
                                      size: 18,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _hasPendingRequest ? '已申请' : '加好友',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    final colors = context.colors;
    return Container(
      width: 100,
      height: 100,
      color: colors.surfaceVariant,
      child: Icon(PhosphorIcons.user(), size: 50, color: colors.iconSecondary),
    );
  }

  Widget _buildBasicInfoCard() {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              '基本信息',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildInfoRow('角色', _buildRoleTag()),
                _buildDivider(),
                _buildInfoRow('等级', _buildLevelTag()),
                if (_userInfo?.userGender != null) ...[
                  _buildDivider(),
                  _buildInfoRow('性别', _buildGenderTag()),
                ],
                if (_userInfo?.userProfile != null &&
                    _userInfo!.userProfile!.isNotEmpty) ...[
                  _buildDivider(),
                  _buildProfileRow(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, Widget content) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: colors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Align(alignment: Alignment.centerLeft, child: content),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileRow() {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '简介',
              style: TextStyle(
                fontSize: 14,
                color: colors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              _userInfo!.userProfile!,
              style: TextStyle(
                fontSize: 14,
                color: colors.textPrimary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: context.colors.divider.withOpacity(0.5),
      indent: 20,
      endIndent: 20,
    );
  }

  Widget _buildRoleTag() {
    final role = _userInfo?.role;
    final label = role == 'admin'
        ? '管理员'
        : (role == 'user' ? '普通用户' : (role ?? '未知'));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.brand.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: AppTheme.brand,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLevelTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        'Lv.${_userInfo?.level ?? 0}',
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(offset: Offset(0, 1), blurRadius: 2, color: Colors.black12),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderTag() {
    final gender = _userInfo?.userGender;
    final isMale = gender == 0; // 假设0是男，1是女
    final color = isMale ? context.colors.info : const Color(0xFFEC4899);
    final icon = isMale
        ? PhosphorIcons.genderMale(PhosphorIconsStyle.fill)
        : PhosphorIcons.genderFemale(PhosphorIconsStyle.fill);
    final label = isMale ? '男' : '女';

    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPostsHeader() {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Row(
              children: [
                Text(
                  'TA 的帖子',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surfaceVariant,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    '${_posts.length}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: colors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsList() {
    final colors = context.colors;
    if (_isLoadingPosts) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: PostListSkeleton(itemCount: 2),
        ),
      );
    }

    if (_posts.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Icon(
                PhosphorIcons.article(),
                size: 48,
                color: colors.iconSecondary.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text('暂无帖子', style: TextStyle(color: colors.textTertiary)),
            ],
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
          child: _buildPostItem(_posts[index]),
        ),
        childCount: _posts.length,
      ),
    );
  }

  Widget _buildPostItem(PostResponse post) {
    final colors = context.colors;
    final postTypeLabel = getPostTypeLabel(post.postType);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PostDetailPage(postId: post.id!, initialPost: post),
          ),
        ).then((_) => _loadPosts());
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title ?? '',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              post.content ?? '',
              style: TextStyle(
                fontSize: 14,
                color: colors.textSecondary,
                height: 1.5,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (post.tags != null && post.tags!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: post.tags!
                    .take(3)
                    .map(
                      (tag) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.brand.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '#$tag',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.brand,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  _formatTime(post.createTime),
                  style: TextStyle(fontSize: 12, color: colors.textTertiary),
                ),
                if (postTypeLabel.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.brand.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      postTypeLabel,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppTheme.brand,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                const Spacer(),
                Icon(
                  PhosphorIcons.thumbsUp(PhosphorIconsStyle.fill),
                  size: 16,
                  color: colors.iconSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  '${post.thumbNum ?? 0}',
                  style: TextStyle(fontSize: 12, color: colors.textSecondary),
                ),
                const SizedBox(width: 16),
                Icon(
                  PhosphorIcons.chatTeardropText(PhosphorIconsStyle.fill),
                  size: 16,
                  color: colors.iconSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  '${post.commentNum ?? 0}',
                  style: TextStyle(fontSize: 12, color: colors.textSecondary),
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
