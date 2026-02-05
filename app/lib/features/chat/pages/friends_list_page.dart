import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/common/empty_widget.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../../widgets/common/nova_refresh_header.dart';
import '../../../widgets/toast/nova_message.dart';
import '../../../widgets/dialogs/app_dialog.dart';
import '../services/friend_service.dart';

/// 好友列表页面
class FriendsListPage extends StatefulWidget {
  const FriendsListPage({super.key});

  @override
  State<FriendsListPage> createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  final _friendService = FriendService();
  
  List<FriendResponse> _friends = [];
  bool _isLoading = true;
  final Set<int> _deletingFriends = {};

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  Future<void> _loadFriends() async {
    setState(() => _isLoading = true);
    try {
      final friends = await _friendService.getAllFriends();
      if (mounted) {
        setState(() {
          _friends = friends;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        NovaMessage.error(context, '加载失败: ${e.toString()}');
      }
    }
  }

  Future<void> _deleteFriend(FriendResponse friend) async {
    if (friend.userId == null) return;

    final confirmed = await showConfirmDialog(
      context,
      title: '删除好友',
      content: '确定要删除好友 ${friend.userName ?? '该用户'} 吗？删除后需要重新添加。',
      confirmText: '删除',
      isDanger: true,
    );

    if (confirmed != true) return;

    setState(() => _deletingFriends.add(friend.userId!));

    try {
      await _friendService.deleteFriend(friend.userId!);
      if (mounted) {
        NovaMessage.success(context, '已删除好友');
        _loadFriends();
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '删除失败: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _deletingFriends.remove(friend.userId!));
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
          icon: Icon(Icons.arrow_back_ios, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '我的好友',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                '${_friends.length}人',
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _buildContent(colors),
    );
  }

  Widget _buildContent(AppColors colors) {
    if (_isLoading) {
      return const LoadingWidget(message: '加载中...');
    }

    if (_friends.isEmpty) {
      return const EmptyWidget(message: '暂无好友');
    }

    return NovaRefreshHeader(
      onRefresh: _loadFriends,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _friends.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) => _buildFriendItem(_friends[index], colors),
      ),
    );
  }

  Widget _buildFriendItem(FriendResponse friend, AppColors colors) {
    final isDeleting = _deletingFriends.contains(friend.userId);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 头像
          CircleAvatar(
            radius: 24,
            backgroundColor: AppTheme.brand.withOpacity(0.1),
            backgroundImage: friend.userAvatar != null && friend.userAvatar!.isNotEmpty
                ? NetworkImage(friend.userAvatar!)
                : null,
            child: friend.userAvatar == null || friend.userAvatar!.isEmpty
                ? Icon(Icons.person, color: AppTheme.brand, size: 24)
                : null,
          ),
          const SizedBox(width: 12),
          // 用户信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friend.userName ?? '未知用户',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '@${friend.userAccount ?? ''}',
                  style: TextStyle(
                    fontSize: 13,
                    color: colors.textSecondary,
                  ),
                ),
                if (friend.userProfile != null && friend.userProfile!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    friend.userProfile!,
                    style: TextStyle(
                      fontSize: 12,
                      color: colors.textTertiary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          // 操作按钮
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 发消息按钮
              GestureDetector(
                onTap: () {
                  // TODO: 跳转到聊天页面
                  NovaMessage.show(context, '聊天功能开发中');
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppTheme.brand.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline,
                    color: AppTheme.brand,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // 更多操作按钮
              GestureDetector(
                onTap: () => _showFriendActions(friend, colors),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: colors.background,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: isDeleting
                      ? SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              colors.textSecondary,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.more_horiz,
                          color: colors.textSecondary,
                          size: 18,
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFriendActions(FriendResponse friend, AppColors colors) {
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: colors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.person_outline, color: colors.textPrimary),
              title: Text(
                '查看资料',
                style: TextStyle(color: colors.textPrimary),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: 跳转到用户资料页面
                NovaMessage.show(context, '查看资料功能开发中');
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_outline, color: colors.error),
              title: Text(
                '删除好友',
                style: TextStyle(color: colors.error),
              ),
              onTap: () {
                Navigator.pop(context);
                _deleteFriend(friend);
              },
            ),
            const SizedBox(height: 8),
            ListTile(
              title: Center(
                child: Text(
                  '取消',
                  style: TextStyle(color: colors.textSecondary),
                ),
              ),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
