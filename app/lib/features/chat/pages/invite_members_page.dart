import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/toast/nova_message.dart';
import '../services/friend_service.dart';
import '../services/group_service.dart';

/// 邀请成员页面
class InviteMembersPage extends StatefulWidget {
  final int groupId;
  final List<int> existingMemberIds;

  const InviteMembersPage({
    super.key,
    required this.groupId,
    this.existingMemberIds = const [],
  });

  @override
  State<InviteMembersPage> createState() => _InviteMembersPageState();
}

class _InviteMembersPageState extends State<InviteMembersPage> {
  final _friendService = FriendService();
  final _groupService = GroupService();

  List<FriendResponse> _friends = [];
  Set<int> _selectedIds = {};
  bool _isLoading = true;
  bool _isInviting = false;

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
        // 过滤掉已经是群成员的好友
        final filteredFriends = friends
            .where((f) => f.userId != null && !widget.existingMemberIds.contains(f.userId))
            .toList();
        setState(() {
          _friends = filteredFriends;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('加载好友列表失败: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _toggleSelection(int userId) {
    setState(() {
      if (_selectedIds.contains(userId)) {
        _selectedIds.remove(userId);
      } else {
        _selectedIds.add(userId);
      }
    });
  }

  Future<void> _inviteMembers() async {
    if (_selectedIds.isEmpty) {
      NovaMessage.warning(context, '请选择要邀请的好友');
      return;
    }

    setState(() => _isInviting = true);
    try {
      int successCount = 0;
      int failCount = 0;

      for (final userId in _selectedIds) {
        final success = await _groupService.inviteMember(
          groupId: widget.groupId,
          inviteeId: userId,
        );
        if (success) {
          successCount++;
        } else {
          failCount++;
        }
      }

      if (mounted) {
        if (failCount == 0) {
          NovaMessage.success(context, '已邀请 $successCount 位好友');
        } else {
          NovaMessage.warning(context, '成功邀请 $successCount 位，失败 $failCount 位');
        }
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '邀请失败');
      }
    } finally {
      if (mounted) setState(() => _isInviting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        title: const Text('邀请好友'),
        actions: [
          TextButton(
            onPressed: _selectedIds.isEmpty || _isInviting ? null : _inviteMembers,
            child: _isInviting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    '邀请 (${_selectedIds.length})',
                    style: TextStyle(
                      color: _selectedIds.isEmpty
                          ? colors.textTertiary
                          : AppTheme.brand,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _friends.isEmpty
              ? _buildEmptyState(colors)
              : _buildFriendList(colors),
    );
  }

  Widget _buildEmptyState(AppColors colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 64, color: colors.iconSecondary),
          const SizedBox(height: 16),
          Text(
            '没有可邀请的好友',
            style: TextStyle(color: colors.textSecondary),
          ),
          const SizedBox(height: 8),
          Text(
            '所有好友都已在群中',
            style: TextStyle(color: colors.textTertiary, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendList(AppColors colors) {
    return Column(
      children: [
        // 全选/取消全选
        Container(
          color: colors.surface,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '好友列表 (${_friends.length})',
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 14,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_selectedIds.length == _friends.length) {
                      _selectedIds.clear();
                    } else {
                      _selectedIds = _friends
                          .where((f) => f.userId != null)
                          .map((f) => f.userId!)
                          .toSet();
                    }
                  });
                },
                child: Text(
                  _selectedIds.length == _friends.length ? '取消全选' : '全选',
                  style: TextStyle(
                    color: AppTheme.brand,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        // 好友列表
        Expanded(
          child: ListView.builder(
            itemCount: _friends.length,
            itemBuilder: (context, index) {
              final friend = _friends[index];
              return _buildFriendItem(friend, colors);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFriendItem(FriendResponse friend, AppColors colors) {
    final isSelected = friend.userId != null && _selectedIds.contains(friend.userId);

    return InkWell(
      onTap: () {
        if (friend.userId != null) {
          _toggleSelection(friend.userId!);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // 选择框
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppTheme.brand : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppTheme.brand : colors.border,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            // 头像
            CircleAvatar(
              radius: 22,
              backgroundColor: colors.surfaceVariant,
              backgroundImage: friend.userAvatar != null &&
                      friend.userAvatar!.isNotEmpty
                  ? NetworkImage(friend.userAvatar!)
                  : null,
              child: friend.userAvatar == null || friend.userAvatar!.isEmpty
                  ? Icon(Icons.person, color: colors.iconSecondary)
                  : null,
            ),
            const SizedBox(width: 12),
            // 名称
            Expanded(
              child: Text(
                friend.userName ?? '未知用户',
                style: TextStyle(
                  fontSize: 16,
                  color: colors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
