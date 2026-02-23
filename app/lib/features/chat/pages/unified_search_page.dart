import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nova_api/nova_api.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/tabs/nova_tab_bar.dart';
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
        final groupInfo = await _groupService.getGroupInfo(
          chatGroup.id?.value ?? 0,
        );
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
            child: Text('取消', style: TextStyle(color: colors.textSecondary)),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab栏 - 使用自定义 NovaTabBar
          NovaTabBar(
            controller: _tabController,
            tabs: _tabs,
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
      height: 40,
      margin: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border.withOpacity(0.3), width: 0.5),
      ),
      child: Row(
        children: [
          // 搜索图标
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: SvgPicture.asset(
              'lib/assests/fonts/icons/搜索.svg',
              width: 18,
              height: 18,
              // 不使用ColorFilter，保持SVG原始线框样式
            ),
          ),
          // 输入框
          Expanded(
            child: TextField(
              controller: _searchController,
              autofocus: true,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(color: colors.textPrimary, fontSize: 14),
              decoration: InputDecoration(
                hintText: '搜索用户或群聊',
                hintStyle: TextStyle(color: colors.textTertiary, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
              onChanged: (value) {
                setState(() {});
                _search(value);
              },
              onSubmitted: (value) {
                _search(value);
              },
            ),
          ),
          // 清除按钮
          if (_searchController.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                _search('');
                setState(() {});
              },
              child: Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: colors.textTertiary.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: colors.textTertiary, size: 14),
              ),
            ),
        ],
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
          ..._groupResults
              .take(3)
              .map((group) => _buildGroupItem(group, colors)),
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
          // 使用搜索SVG图标替代原生图标，保持线框样式
          SvgPicture.asset(
            'lib/assests/fonts/icons/搜索.svg',
            width: 48,
            height: 48,
            // 不使用ColorFilter，保持SVG原始线框样式
          ),
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

  Widget _buildShowMoreButton(
    AppColors colors,
    String text,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 14, color: AppTheme.brand),
            ),
            const SizedBox(width: 4),
            // 使用自定义箭头替代原生图标
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: AppTheme.brand.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_forward_ios, color: AppTheme.brand, size: 10),
            ),
          ],
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
          border: Border.all(color: colors.border.withOpacity(0.3), width: 0.5),
          boxShadow: [
            BoxShadow(
              color: colors.border.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // 用户头像
            _buildAvatar(
              imageUrl: user.userAvatar,
              fallbackText: (user.userName?.isNotEmpty == true)
                  ? user.userName!.substring(0, 1).toUpperCase()
                  : '?',
              backgroundColor: AppTheme.brand.withOpacity(0.1),
              textColor: AppTheme.brand,
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
            // 显示好友状态或箭头
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
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_forward_ios, color: colors.iconSecondary, size: 12),
              ),
          ],
        ),
      ),
    );
  }

  /// 构建头像组件
  Widget _buildAvatar({
    String? imageUrl,
    required String fallbackText,
    required Color backgroundColor,
    required Color textColor,
  }) {
    final colors = context.colors;
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: colors.border.withOpacity(0.2), width: 1),
      ),
      child: imageUrl != null && imageUrl.isNotEmpty
          ? ClipOval(
              child: Image.network(
                imageUrl,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Text(
                    fallbackText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            )
          : Center(
              child: Text(
                fallbackText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
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
          border: Border.all(color: colors.border.withOpacity(0.3), width: 0.5),
          boxShadow: [
            BoxShadow(
              color: colors.border.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // 群聊头像
            _buildAvatar(
              imageUrl: group.avatar,
              fallbackText: (group.groupName?.isNotEmpty == true)
                  ? group.groupName!.substring(0, 1).toUpperCase()
                  : '群',
              backgroundColor: AppTheme.brand.withOpacity(0.1),
              textColor: AppTheme.brand,
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
                    style: TextStyle(fontSize: 13, color: colors.textSecondary),
                  ),
                ],
              ),
            ),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: colors.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_forward_ios, color: colors.iconSecondary, size: 12),
            ),
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
