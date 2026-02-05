import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import '../../../config/app_theme.dart';
import '../services/friend_service.dart';
import '../services/group_service.dart';
import 'private_chat_page.dart';
import 'group_chat_page.dart';

/// 统一搜索页面（用户+群聊）
class UnifiedSearchPage extends StatefulWidget {
  const UnifiedSearchPage({super.key});

  @override
  State<UnifiedSearchPage> createState() => _UnifiedSearchPageState();
}

class _UnifiedSearchPageState extends State<UnifiedSearchPage>
    with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  final _friendService = FriendService();
  final _groupService = GroupService();

  late TabController _tabController;
  final List<String> _tabs = ['全部', '用户', '群聊'];

  List<SearchUserResponse> _userResults = [];
  List<GroupResponse> _groupResults = [];
  bool _isSearching = false;
  String _searchKeyword = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _search(String keyword) async {
    if (keyword.isEmpty) {
      setState(() {
        _userResults = [];
        _groupResults = [];
        _searchKeyword = '';
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _searchKeyword = keyword;
    });

    try {
      // 并行搜索用户和群聊
      final results = await Future.wait([
        _searchUsers(keyword),
        _searchGroups(keyword),
      ]);

      if (mounted) {
        setState(() {
          _userResults = results[0] as List<SearchUserResponse>;
          _groupResults = results[1] as List<GroupResponse>;
          _isSearching = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSearching = false);
      }
    }
  }

  Future<List<SearchUserResponse>> _searchUsers(String keyword) async {
    try {
      final result = await _friendService.searchUsers(keyword: keyword);
      return result;
    } catch (e) {
      return [];
    }
  }

  Future<List<GroupResponse>> _searchGroups(String keyword) async {
    try {
      // 尝试按群ID搜索
      final groupId = int.tryParse(keyword);
      if (groupId != null) {
        final group = await _groupService.getGroupInfo(groupId);
        if (group != null) {
          return [group];
        }
      }
      // 按名称搜索
      final result = await _groupService.searchGroups(keyword: keyword);
      final groups = result?.groups?.toList();
      if (groups == null) return [];
      // 转换ChatGroup到GroupResponse
      final responses = <GroupResponse>[];
      for (final chatGroup in groups) {
        final groupInfo = await _groupService.getGroupInfo(chatGroup.id?.value ?? 0);
        if (groupInfo != null) {
          responses.add(groupInfo);
        }
      }
      return responses;
    } catch (e) {
      return [];
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
        titleSpacing: 0,
        title: _buildSearchBar(colors),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              '取消',
              style: TextStyle(color: colors.textSecondary),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab栏
          Material(
            color: colors.surface,
            elevation: 0, // 移除阴影
            child: TabBar(
              controller: _tabController,
              labelColor: AppTheme.brand,
              unselectedLabelColor: colors.textSecondary,
              indicatorColor: AppTheme.brand,
              indicatorSize: TabBarIndicatorSize.label,
              dividerColor: Colors.transparent, // 去除分割线
              dividerHeight: 0, // 确保分割线高度为0
              tabs: _tabs.map((t) => Tab(text: t)).toList(),
            ),
          ),
          // 搜索结果
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAllResults(colors),
                _buildUserResults(colors),
                _buildGroupResults(colors),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(AppColors colors) {
    return Container(
      height: 36,
      margin: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        textAlignVertical: TextAlignVertical.center, // 垂直居中
        style: TextStyle(color: colors.textPrimary, fontSize: 14), // 明确设置文字样式
        decoration: InputDecoration(
          hintText: '搜索用户或群聊',
          hintStyle: TextStyle(color: colors.textTertiary, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: colors.textTertiary, size: 20),
          border: InputBorder.none,
          isDense: true, // 紧凑模式
          contentPadding: const EdgeInsets.only(right: 16), // 移除垂直padding，只保留右侧
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: colors.textTertiary, size: 18),
                  padding: EdgeInsets.zero, // 移除IconButton的padding
                  constraints: const BoxConstraints(), // 移除最小尺寸限制
                  onPressed: () {
                    _searchController.clear();
                    _search('');
                  },
                )
              : null,
        ),
        onChanged: (value) {
          _search(value);
        },
        onSubmitted: (value) {
          _search(value);
        },
      ),
    );
  }

  Widget _buildAllResults(AppColors colors) {
    if (_searchKeyword.isEmpty) {
      return _buildEmptyHint(colors, '输入关键词搜索用户或群聊');
    }

    if (_isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_userResults.isEmpty && _groupResults.isEmpty) {
      return _buildEmptyHint(colors, '未找到相关结果');
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 用户结果
        if (_userResults.isNotEmpty) ...[
          _buildSectionHeader(colors, '用户', _userResults.length),
          ..._userResults.take(3).map((user) => _buildUserItem(user, colors)),
          if (_userResults.length > 3)
            _buildShowMoreButton(colors, '查看更多用户', () {
              _tabController.animateTo(1);
            }),
          const SizedBox(height: 16),
        ],
        // 群聊结果
        if (_groupResults.isNotEmpty) ...[
          _buildSectionHeader(colors, '群聊', _groupResults.length),
          ..._groupResults.take(3).map((group) => _buildGroupItem(group, colors)),
          if (_groupResults.length > 3)
            _buildShowMoreButton(colors, '查看更多群聊', () {
              _tabController.animateTo(2);
            }),
        ],
      ],
    );
  }

  Widget _buildUserResults(AppColors colors) {
    if (_searchKeyword.isEmpty) {
      return _buildEmptyHint(colors, '输入关键词搜索用户');
    }

    if (_isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_userResults.isEmpty) {
      return _buildEmptyHint(colors, '未找到相关用户');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _userResults.length,
      itemBuilder: (context, index) {
        return _buildUserItem(_userResults[index], colors);
      },
    );
  }

  Widget _buildGroupResults(AppColors colors) {
    if (_searchKeyword.isEmpty) {
      return _buildEmptyHint(colors, '输入关键词搜索群聊');
    }

    if (_isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_groupResults.isEmpty) {
      return _buildEmptyHint(colors, '未找到相关群聊');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _groupResults.length,
      itemBuilder: (context, index) {
        return _buildGroupItem(_groupResults[index], colors);
      },
    );
  }

  Widget _buildEmptyHint(AppColors colors, String hint) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64, color: colors.iconSecondary),
          const SizedBox(height: 16),
          Text(
            hint,
            style: TextStyle(color: colors.textSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(AppColors colors, String title, int count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        '$title ($count)',
        style: TextStyle(
          fontSize: 14,
          color: colors.textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildShowMoreButton(AppColors colors, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.brand,
          ),
        ),
      ),
    );
  }

  Widget _buildUserItem(SearchUserResponse user, AppColors colors) {
    return GestureDetector(
      onTap: () => _navigateToUserChat(user),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: colors.surfaceVariant,
              backgroundImage: user.userAvatar != null && user.userAvatar!.isNotEmpty
                  ? NetworkImage(user.userAvatar!)
                  : null,
              child: user.userAvatar == null || user.userAvatar!.isEmpty
                  ? Icon(Icons.person, color: colors.iconSecondary)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.userName ?? '未知用户',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: colors.textPrimary,
                    ),
                  ),
                  if (user.userProfile != null && user.userProfile!.isNotEmpty)
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
              ),
            ),
            // 显示好友状态
            if (user.isFriend == true)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.brand.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '好友',
                  style: TextStyle(fontSize: 12, color: AppTheme.brand),
                ),
              )
            else
              Icon(Icons.chevron_right, color: colors.iconSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupItem(GroupResponse group, AppColors colors) {
    return GestureDetector(
      onTap: () => _navigateToGroupChat(group),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppTheme.brand.withOpacity(0.1),
              backgroundImage: group.avatar != null && group.avatar!.isNotEmpty
                  ? NetworkImage(group.avatar!)
                  : null,
              child: group.avatar == null || group.avatar!.isEmpty
                  ? Icon(Icons.group, color: AppTheme.brand)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.groupName ?? '未知群聊',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: colors.textPrimary,
                    ),
                  ),
                  Text(
                    '${group.memberCount ?? 0}人',
                    style: TextStyle(
                      fontSize: 13,
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: colors.iconSecondary),
          ],
        ),
      ),
    );
  }

  void _navigateToUserChat(SearchUserResponse user) {
    if (user.userId == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PrivateChatPage(
          partnerId: user.userId!,
          partnerName: user.userName ?? '用户',
          partnerAvatar: user.userAvatar,
        ),
      ),
    );
  }

  void _navigateToGroupChat(GroupResponse group) {
    if (group.id == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GroupChatPage(
          groupId: group.id!,
          groupName: group.groupName ?? '群聊',
          groupAvatar: group.avatar,
        ),
      ),
    );
  }
}
