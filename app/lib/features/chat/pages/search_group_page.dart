import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/toast/nova_message.dart';
import '../services/group_service.dart';

/// 搜索群聊页面
class SearchGroupPage extends StatefulWidget {
  const SearchGroupPage({super.key});

  @override
  State<SearchGroupPage> createState() => _SearchGroupPageState();
}

class _SearchGroupPageState extends State<SearchGroupPage> {
  final _groupService = GroupService();
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  List<GroupResponse> _searchResults = [];
  bool _isSearching = false;
  String _searchType = 'name'; // name, id

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final keyword = _searchController.text.trim();
    if (keyword.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    setState(() => _isSearching = true);
    try {
      if (_searchType == 'id') {
        // 按群ID搜索
        final groupId = int.tryParse(keyword);
        if (groupId != null) {
          final group = await _groupService.getGroupInfo(groupId);
          if (group != null && mounted) {
            setState(() => _searchResults = [group]);
          } else if (mounted) {
            setState(() => _searchResults = []);
          }
        } else {
          if (mounted) {
            NovaMessage.warning(context, '请输入有效的群ID');
            setState(() => _searchResults = []);
          }
        }
      } else {
        // 按群名称搜索
        final result = await _groupService.searchGroups(keyword: keyword);
        if (mounted) {
          // GroupPage返回的是ChatGroup列表，需要转换为GroupResponse
          final groups = result?.groups?.toList() ?? [];
          // 由于ChatGroup和GroupResponse结构不同，需要按ID重新获取详情
          final groupResponses = <GroupResponse>[];
          for (final chatGroup in groups) {
            final groupIdValue = chatGroup.id?.value;
            if (groupIdValue != null) {
              final groupInfo = await _groupService.getGroupInfo(groupIdValue);
              if (groupInfo != null) {
                groupResponses.add(groupInfo);
              }
            }
          }
          setState(() => _searchResults = groupResponses);
        }
      }
    } catch (e) {
      debugPrint('搜索群聊失败: $e');
      if (mounted) {
        NovaMessage.error(context, '搜索失败');
      }
    } finally {
      if (mounted) setState(() => _isSearching = false);
    }
  }

  Future<void> _applyToJoin(GroupResponse group) async {
    if (group.id == null) return;

    try {
      final result = await _groupService.applyToJoin(groupId: group.id!);
      if (result != null && mounted) {
        NovaMessage.success(context, '申请已发送');
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '申请失败');
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
        foregroundColor: colors.textPrimary,
        elevation: 0,
        title: const Text('搜索群聊'),
      ),
      body: Column(
        children: [
          // 搜索栏
          Container(
            color: colors.surface,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // 搜索类型切换
                Row(
                  children: [
                    _buildSearchTypeChip('按名称', 'name', colors),
                    const SizedBox(width: 12),
                    _buildSearchTypeChip('按群ID', 'id', colors),
                  ],
                ),
                const SizedBox(height: 12),
                // 搜索输入框
                TextField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: _searchType == 'id' ? '输入群ID' : '输入群名称',
                    hintStyle: TextStyle(color: colors.textTertiary),
                    prefixIcon: Icon(Icons.search, color: colors.iconSecondary),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: colors.iconSecondary,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchResults = []);
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: colors.surfaceVariant,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  style: TextStyle(color: colors.textPrimary),
                  keyboardType: _searchType == 'id'
                      ? TextInputType.number
                      : TextInputType.text,
                  textInputAction: TextInputAction.search,
                  onChanged: (_) => setState(() {}),
                  onSubmitted: (_) => _search(),
                ),
                const SizedBox(height: 12),
                // 搜索按钮
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSearching ? null : _search,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.brand,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isSearching
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
                        : const Text('搜索'),
                  ),
                ),
              ],
            ),
          ),
          // 搜索结果
          Expanded(child: _buildSearchResults(colors)),
        ],
      ),
    );
  }

  Widget _buildSearchTypeChip(String label, String type, AppColors colors) {
    final isSelected = _searchType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _searchType = type;
          _searchResults = [];
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.brand : colors.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : colors.textSecondary,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(AppColors colors) {
    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: colors.iconSecondary),
            const SizedBox(height: 16),
            Text(
              _searchType == 'id' ? '输入群ID搜索' : '输入群名称搜索',
              style: TextStyle(color: colors.textSecondary),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final group = _searchResults[index];
        return _buildGroupItem(group, colors);
      },
    );
  }

  Widget _buildGroupItem(GroupResponse group, AppColors colors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppTheme.brand.withOpacity(0.1),
            backgroundImage: group.avatar != null && group.avatar!.isNotEmpty
                ? NetworkImage(group.avatar!)
                : null,
            child: group.avatar == null || group.avatar!.isEmpty
                ? Icon(Icons.group, color: AppTheme.brand, size: 28)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.groupName ?? '未知群聊',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'ID: ${group.id ?? ""}',
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.textTertiary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${group.memberCount ?? 0}人',
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.textTertiary,
                      ),
                    ),
                  ],
                ),
                if (group.description != null && group.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      group.description!,
                      style: TextStyle(
                        fontSize: 13,
                        color: colors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () => _applyToJoin(group),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.brand,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('申请加入'),
          ),
        ],
      ),
    );
  }
}
