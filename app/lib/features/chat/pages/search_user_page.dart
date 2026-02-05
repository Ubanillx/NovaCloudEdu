import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/common/empty_widget.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../../widgets/inputs/app_input.dart';
import '../../../widgets/toast/nova_message.dart';
import '../../../widgets/dialogs/app_dialog.dart';
import '../services/friend_service.dart';

/// 搜索用户页面 - 添加好友
class SearchUserPage extends StatefulWidget {
  const SearchUserPage({super.key});

  @override
  State<SearchUserPage> createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  final _searchController = TextEditingController();
  final _friendService = FriendService();
  
  List<SearchUserResponse> _users = [];
  bool _isLoading = false;
  bool _hasSearched = false;
  final Set<int> _sendingRequests = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchUsers() async {
    final keyword = _searchController.text.trim();
    if (keyword.isEmpty) {
      NovaMessage.warning(context, '请输入搜索关键词');
      return;
    }

    setState(() {
      _isLoading = true;
      _hasSearched = true;
    });

    try {
      final users = await _friendService.searchUsers(keyword: keyword);
      if (mounted) {
        setState(() {
          _users = users;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        NovaMessage.error(context, '搜索失败: ${e.toString()}');
      }
    }
  }

  Future<void> _sendFriendRequest(SearchUserResponse user) async {
    if (user.userId == null) return;
    
    final message = await showInputDialog(
      context,
      title: '发送好友申请',
      hintText: '请输入验证消息（可选）',
    );
    
    if (message == null) return; // 用户取消

    setState(() => _sendingRequests.add(user.userId!));

    try {
      await _friendService.sendFriendRequest(
        receiverId: user.userId!,
        message: message.isNotEmpty ? message : null,
      );
      if (mounted) {
        NovaMessage.success(context, '好友申请已发送');
        // 刷新列表
        _searchUsers();
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '发送失败: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _sendingRequests.remove(user.userId!));
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
          '添加好友',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 搜索栏
          Container(
            padding: const EdgeInsets.all(16),
            color: colors.surface,
            child: SearchInput(
              controller: _searchController,
              placeholder: '搜索用户名或账号',
              onSubmitted: (_) => _searchUsers(),
            ),
          ),
          // 搜索结果
          Expanded(
            child: _buildContent(colors),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(AppColors colors) {
    if (_isLoading) {
      return const LoadingWidget(message: '搜索中...');
    }

    if (!_hasSearched) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 64,
              color: colors.textTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              '输入用户名或账号搜索',
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    if (_users.isEmpty) {
      return const EmptyWidget(message: '未找到相关用户');
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _users.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _buildUserItem(_users[index], colors),
    );
  }

  Widget _buildUserItem(SearchUserResponse user, AppColors colors) {
    final isSending = _sendingRequests.contains(user.userId);
    
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
            backgroundImage: user.userAvatar != null && user.userAvatar!.isNotEmpty
                ? NetworkImage(user.userAvatar!)
                : null,
            child: user.userAvatar == null || user.userAvatar!.isEmpty
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
                  user.userName ?? '未知用户',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '@${user.userAccount ?? ''}',
                  style: TextStyle(
                    fontSize: 13,
                    color: colors.textSecondary,
                  ),
                ),
                if (user.userProfile != null && user.userProfile!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    user.userProfile!,
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
          _buildActionButton(user, colors, isSending),
        ],
      ),
    );
  }

  Widget _buildActionButton(SearchUserResponse user, AppColors colors, bool isSending) {
    if (user.isFriend == true) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: colors.success.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          '已是好友',
          style: TextStyle(
            fontSize: 12,
            color: colors.success,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    if (user.hasPendingRequest == true) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: colors.warning.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          '已申请',
          style: TextStyle(
            fontSize: 12,
            color: colors.warning,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: isSending ? null : () => _sendFriendRequest(user),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppTheme.brand,
          borderRadius: BorderRadius.circular(16),
        ),
        child: isSending
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                '添加',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }
}
