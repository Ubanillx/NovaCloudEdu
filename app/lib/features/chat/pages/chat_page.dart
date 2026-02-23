import 'package:flutter/material.dart';
import 'dart:async';
import 'package:nova_api/nova_api.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/common/nova_refresh_header.dart';
import '../../../widgets/common/skeleton_widgets.dart';
import '../../../widgets/tabs/nova_tab_bar.dart';
import '../services/ai_assistant_service.dart';
import '../services/friend_service.dart';
import '../services/chat_service.dart';
import '../services/chat_websocket_service.dart';
import '../services/chat_database_service.dart';
import 'friend_requests_page.dart';
import 'friends_list_page.dart';
import 'private_chat_page.dart';
import 'group_chat_page.dart';
import 'unified_search_page.dart';
import '../services/group_service.dart';
import '../services/notification_service.dart';
import '../../../widgets/dialogs/app_dialog.dart';
import 'ai_chat_page.dart';
import '../widgets/list/chat_list_item.dart';
import 'ai_session_list_page.dart';
import '../../grading/pages/grading_submit_page.dart';
import '../../grading/pages/grading_dashboard_page.dart';
import '../../ppt/pages/ppt_chat_page.dart';

/// 聊天页面 - 参考smartclass ChatContainer.vue
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: _tabs.length, vsync: this)..addListener(() {
        setState(() {});
      });
  final List<String> _tabs = ['历史', '好友', '群聊', '智慧体中心'];
  final _friendService = FriendService();
  final _chatService = ChatService();
  final _groupService = GroupService();
  final _wsService = ChatWebSocketService.instance;
  final _dbService = ChatDatabaseService();
  final _notificationService = NotificationService();
  final _assistantService = AiAssistantService();

  List<FriendResponse> _friends = [];
  List<ChatSessionResponse> _sessions = [];
  List<GroupResponse> _groups = [];
  List<AiAssistantVO> _assistants = [];
  bool _isLoadingFriends = true;
  bool _isLoadingSessions = true;
  bool _isLoadingGroups = true;
  bool _isLoadingAssistants = true;
  int _pendingRequestCount = 0;

  // 缓存最新消息
  final Map<int, String> _lastMessages = {};

  // 群未读数
  Map<int, GroupUnreadCount> _groupUnreadCounts = {};

  StreamSubscription<WsChatMessage>? _messageSubscription;
  StreamSubscription<NotificationEvent>? _notificationSubscription;
  StreamSubscription<Map<int, GroupUnreadCount>>? _groupUnreadSubscription;

  @override
  void initState() {
    super.initState();
    _loadFriends();
    _loadPendingRequests();
    _loadSessions();
    _loadGroups();
    _loadAssistants();
    _subscribeToNotifications();
    _initNotificationService();
  }

  void _initNotificationService() {
    _notificationService.init();
    _groupUnreadSubscription = _notificationService.groupUnreadStream.listen((
      counts,
    ) {
      if (mounted) {
        setState(() => _groupUnreadCounts = counts);
      }
    });
  }

  Future<void> _loadSessions() async {
    try {
      final sessions = await _chatService.getSessionList();
      if (mounted) {
        setState(() {
          _sessions = sessions;
          _isLoadingSessions = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingSessions = false);
      }
    }
  }

  void _subscribeToNotifications() {
    // 监听新消息，刷新会话列表
    _messageSubscription = _wsService.chatMessages.listen((message) {
      // 清除该聊天对象的 lastMessage 缓存，使摘要能及时更新
      final partnerId = message.senderId;
      if (partnerId != null) _lastMessages.remove(partnerId);
      final receiverId = message.receiverId;
      if (receiverId != null) _lastMessages.remove(receiverId);
      _loadSessions();
    });

    // 监听通知
    _notificationSubscription = _wsService.notifications.listen((notification) {
      if (notification.type == 'FRIEND_REQUEST_RECEIVED' ||
          notification.type == 'NEW_FRIEND') {
        _loadPendingRequests();
        _loadFriends();
      } else if (notification.type == 'NEW_PRIVATE_MESSAGE') {
        _loadSessions();
      }
    });
  }

  Future<void> _loadFriends() async {
    try {
      final friends = await _friendService.getAllFriends();
      if (mounted) {
        setState(() {
          _friends = friends;
          _isLoadingFriends = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingFriends = false);
      }
    }
  }

  Future<void> _loadPendingRequests() async {
    try {
      final requests = await _friendService.getReceivedRequests(
        status: 'pending',
      );
      if (mounted) {
        setState(() {
          _pendingRequestCount = requests.length;
        });
      }
    } catch (e) {
      // 静默处理错误
    }
  }

  Future<void> _loadGroups() async {
    try {
      final groups = await _groupService.getMyGroups();
      if (mounted) {
        setState(() {
          _groups = groups;
          _isLoadingGroups = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingGroups = false);
      }
    }
  }

  Future<void> _loadAssistants() async {
    try {
      final assistants = await _assistantService.getPublicAssistants(
        page: 0,
        size: 20,
      );
      if (mounted) {
        setState(() {
          _assistants = assistants;
          _isLoadingAssistants = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingAssistants = false);
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _messageSubscription?.cancel();
    _notificationSubscription?.cancel();
    _groupUnreadSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 导航标签 (使用自定义 NovaTabBar)
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Row(
                children: [
                  NovaTabBar(
                    controller: _tabController,
                    tabs: _tabs,
                  ),
                  const Spacer(),
                ],
              ),
            ),
            // 分隔阴影
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colors.border.withValues(alpha: 0),
                    colors.border.withValues(alpha: 0.5),
                    colors.border.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
            // 内容区域
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildHistoryTab(),
                  _buildFriendsTab(),
                  _buildGroupsTab(),
                  _buildIntelligenceTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      // 添加灵动的悬浮按钮
      floatingActionButton: _LiquidPebbleFab(
        onSearchPressed: _navigateToSearchUser,
        onAddFriendPressed: _navigateToFriendRequests,
        pendingRequestCount: _pendingRequestCount,
      ),
    );
  }

  void _navigateToSearchUser() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const UnifiedSearchPage()));
  }

  void _navigateToFriendRequests() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const FriendRequestsPage()));
    // 返回后刷新待处理申请数量
    _loadPendingRequests();
    _loadFriends();
  }

  void _navigateToFriendsList() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const FriendsListPage()));
    // 返回后刷新好友列表
    _loadFriends();
  }

  // 历史对话
  Widget _buildHistoryTab() {
    final colors = context.colors;

    if (_isLoadingSessions) {
      return const ChatListSkeleton();
    }

    if (_sessions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: colors.textTertiary,
            ),
            const SizedBox(height: 16),
            Text('暂无对话', style: TextStyle(color: colors.textSecondary)),
            const SizedBox(height: 8),
            Text(
              '和好友开始聊天吧',
              style: TextStyle(color: colors.textTertiary, fontSize: 12),
            ),
          ],
        ),
      );
    }

    return NovaRefreshableList(
      onRefresh: _loadSessions,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildSessionItem(_sessions[index], colors),
              childCount: _sessions.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSessionItem(ChatSessionResponse session, AppColors colors) {
    return ChatListItem(
      title: session.partnerName ?? '未知用户',
      avatarUrl: session.partnerAvatar,
      isGroup: false,
      unreadCount: session.unreadCount ?? 0,
      time: session.lastMessageTime != null
          ? _formatSessionTime(session.lastMessageTime!)
          : null,
      subtitleWidget: FutureBuilder<String?>(
        future: _getLastMessage(session.partnerId),
        builder: (context, snapshot) {
          final lastMessage = snapshot.data ?? '';
          return Text(
            lastMessage.isEmpty ? '暂无消息' : lastMessage,
            style: TextStyle(fontSize: 13, color: colors.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        },
      ),
      colors: colors,
      isDarkMode: context.isDarkMode,
      onTap: () => _navigateToChat(session),
    );
  }

  void _navigateToChat(ChatSessionResponse session) async {
    if (session.partnerId == null) return;

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PrivateChatPage(
          partnerId: session.partnerId!,
          partnerName: session.partnerName ?? '未知用户',
          partnerAvatar: session.partnerAvatar,
        ),
      ),
    );
    // 返回后刷新会话列表
    _loadSessions();
  }

  /// 获取与某用户的最新消息
  Future<String?> _getLastMessage(int? partnerId) async {
    if (partnerId == null) return null;

    // 先检查缓存
    if (_lastMessages.containsKey(partnerId)) {
      return _lastMessages[partnerId];
    }

    // 从本地数据库获取最新消息
    try {
      final messages = await _dbService.getMessagesByPartner(
        0, // 当前用户ID，这里简化处理
        partnerId,
        limit: 1,
      );

      if (messages.isNotEmpty) {
        final content = messages.first.content ?? '';
        final type = messages.first.type;

        // 根据消息类型显示不同文本
        String displayText;
        switch (type.toUpperCase()) {
          case 'IMAGE':
            displayText = '[图片]';
            break;
          case 'AUDIO':
            displayText = '[语音]';
            break;
          case 'FILE':
            displayText = '[文件]';
            break;
          case 'VIDEO':
            displayText = '[视频]';
            break;
          case 'CALL':
            displayText = '[通话]';
            break;
          default:
            displayText = content;
        }

        _lastMessages[partnerId] = displayText;
        return displayText;
      }
    } catch (e) {
      // 忽略错误
    }

    return null;
  }

  String _formatSessionTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(time.year, time.month, time.day);

    if (messageDate == today) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return '昨天';
    } else if (now.difference(time).inDays < 7) {
      const weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
      return weekdays[time.weekday - 1];
    } else {
      return '${time.month}/${time.day}';
    }
  }

  // 好友列表
  Widget _buildFriendsTab() {
    final colors = context.colors;

    if (_isLoadingFriends) {
      return const ListItemSkeleton();
    }

    if (_friends.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 64, color: colors.textTertiary),
            const SizedBox(height: 16),
            Text('暂无好友', style: TextStyle(color: colors.textSecondary)),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _navigateToSearchUser,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.brand,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Text(
                  '添加好友',
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

    return NovaRefreshHeader(
      onRefresh: _loadFriends,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _friends.length + 1, // +1 for header
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildFriendsHeader(colors);
          }
          return _buildFriendItem(_friends[index - 1], colors);
        },
      ),
    );
  }

  Widget _buildFriendsHeader(AppColors colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '好友 (${_friends.length})',
            style: TextStyle(
              fontSize: 14,
              color: colors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: _navigateToFriendsList,
            child: Text(
              '查看全部',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.brand,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToFriendChat(FriendResponse friend) async {
    if (friend.userId == null) return;

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PrivateChatPage(
          partnerId: friend.userId!,
          partnerName: friend.userName ?? '未知用户',
          partnerAvatar: friend.userAvatar,
        ),
      ),
    );
    // 返回后刷新会话列表
    _loadSessions();
  }

  Widget _buildFriendItem(FriendResponse friend, AppColors colors) {
    return ChatListItem(
      title: friend.userName ?? '未知用户',
      subtitleWidget: Text(
        friend.userProfile ?? '@${friend.userAccount ?? ""}',
        style: TextStyle(fontSize: 13, color: colors.textSecondary),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      avatarUrl: friend.userAvatar,
      isGroup: false,
      colors: colors,
      isDarkMode: context.isDarkMode,
      onTap: () => _navigateToFriendChat(friend),
      actionIcon: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppTheme.brand.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Icon(Icons.chat_bubble_outline, color: AppTheme.brand, size: 18),
      ),
    );
  }

  // 群聊列表
  Widget _buildGroupsTab() {
    final colors = context.colors;

    if (_isLoadingGroups) {
      return const ChatListSkeleton();
    }

    if (_groups.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.group_outlined, size: 64, color: colors.textTertiary),
            const SizedBox(height: 16),
            Text('暂无群聊', style: TextStyle(color: colors.textSecondary)),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _showCreateGroupDialog,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.brand,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Text(
                  '创建群聊',
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

    return NovaRefreshHeader(
      onRefresh: _loadGroups,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _groups.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildGroupsHeader(colors);
          }
          return _buildGroupItem(_groups[index - 1], colors);
        },
      ),
    );
  }

  Widget _buildGroupsHeader(AppColors colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '我的群聊 (${_groups.length})',
            style: TextStyle(
              fontSize: 14,
              color: colors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: _showCreateGroupDialog,
            child: Row(
              children: [
                Icon(Icons.add, size: 16, color: AppTheme.brand),
                const SizedBox(width: 4),
                Text(
                  '创建群聊',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.brand,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupItem(GroupResponse group, AppColors colors) {
    final groupId = group.id;
    final unreadCount = groupId != null
        ? (_groupUnreadCounts[groupId]?.unreadCount ?? 0)
        : 0;
    final lastMessage = groupId != null
        ? _groupUnreadCounts[groupId]?.lastMessage
        : null;

    return ChatListItem(
      title: group.groupName ?? '未知群聊',
      subtitleWidget: Text(
        lastMessage ?? '${group.memberCount ?? 0}人',
        style: TextStyle(fontSize: 13, color: colors.textSecondary),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      avatarUrl: group.avatar,
      isGroup: true,
      unreadCount: unreadCount,
      colors: colors,
      isDarkMode: context.isDarkMode,
      onTap: () => _navigateToGroupChat(group),
      actionIcon: Icon(Icons.chevron_right, color: colors.iconSecondary),
    );
  }

  void _navigateToGroupChat(GroupResponse group) async {
    if (group.id == null) return;

    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => GroupChatPage(
          groupId: group.id!,
          groupName: group.groupName ?? '群聊',
          groupAvatar: group.avatar,
        ),
      ),
    );

    // 如果返回true，表示退出了群聊，需要刷新列表
    if (result == true && mounted) {
      // 先从本地列表移除
      setState(() {
        _groups.removeWhere((g) => g.id == group.id);
      });
    }
    // 无论如何都刷新一次列表
    _loadGroups();
  }

  void _showCreateGroupDialog() async {
    final groupName = await showInputDialog(
      context,
      title: '创建群聊',
      hintText: '请输入群名称',
      confirmText: '创建',
    );

    if (groupName != null && groupName.isNotEmpty && mounted) {
      try {
        final group = await _groupService.createGroup(groupName: groupName);
        if (group != null && mounted) {
          _loadGroups();
          // 跳转到新创建的群聊
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => GroupChatPage(
                groupId: group.id!,
                groupName: group.groupName ?? groupName,
                groupAvatar: group.avatar,
              ),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('创建失败: $e')));
        }
      }
    }
  }

  // 智慧体中心
  Widget _buildIntelligenceTab() {
    final colors = context.colors;
    return NovaRefreshableList(
      onRefresh: _loadAssistants,
      slivers: [
        // 常驻通用 AI 助手入口
        SliverToBoxAdapter(child: _buildResidentAiAssistant(colors)),
        // 快捷操作
        SliverToBoxAdapter(child: _buildQuickActions(colors)),
        // 智能工具
        SliverToBoxAdapter(child: _buildSmartTools(colors)),
        // 智慧体列表标题
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '更多智慧体',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                Text(
                  '即将上线',
                  style: TextStyle(fontSize: 12, color: colors.textTertiary),
                ),
              ],
            ),
          ),
        ),
        // 智慧体网格
        _isLoadingAssistants
            ? const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : _assistants.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          '暂无智慧体',
                          style: TextStyle(color: colors.textSecondary),
                        ),
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.85,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index >= _assistants.length) return null;
                          return _buildAssistantCard(_assistants[index], colors);
                        },
                        childCount: _assistants.length,
                      ),
                    ),
                  ),
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }

  // 常驻通用AI助手入口
  Widget _buildResidentAiAssistant(AppColors colors) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const AiChatPage()));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colors.border, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: colors.border.withValues(alpha: 0.5),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // AI 头像
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppTheme.brand.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.smart_toy_rounded,
                color: AppTheme.brand,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            // 文字
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '通用 AI 助手',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '智能问答 · 学习辅导 · 知识探索',
                    style: TextStyle(
                      fontSize: 13,
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // 箭头按钮保持蓝色
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.brand.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: AppTheme.brand,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 快捷操作
  Widget _buildQuickActions(AppColors colors) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: _buildQuickActionItem(
              icon: Icons.history_rounded,
              label: '对话历史',
              colors: colors,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AiSessionListPage()),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildQuickActionItem(
              icon: Icons.add_comment_rounded,
              label: '新建对话',
              colors: colors,
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const AiChatPage()));
              },
            ),
          ),
        ],
      ),
    );
  }

  // 智能工具区
  Widget _buildSmartTools(AppColors colors) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '智能工具',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionItem(
                  icon: Icons.edit_note_rounded,
                  label: '智能批改',
                  colors: colors,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const GradingSubmitPage()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionItem(
                  icon: Icons.insights_rounded,
                  label: '学习画像',
                  colors: colors,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const GradingDashboardPage()),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionItem(
                  icon: Icons.slideshow_rounded,
                  label: 'AI制作PPT',
                  colors: colors,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const PptChatPage()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem({
    required IconData icon,
    required String label,
    required AppColors colors,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: context.isDarkMode ? 0.15 : 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppTheme.brand, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 智慧体卡片
  Widget _buildAssistantCard(AiAssistantVO assistant, AppColors colors) {
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: context.isDarkMode ? 0.15 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.brand.withValues(alpha: 0.1),
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: assistant.avatarUrl != null && assistant.avatarUrl!.isNotEmpty
                  ? Image.network(
                      assistant.avatarUrl!,
                      width: 52,
                      height: 52,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => CircleAvatar(
                        radius: 26,
                        backgroundColor: AppTheme.brand.withValues(alpha: 0.1),
                        child: const Icon(
                          Icons.smart_toy_rounded,
                          color: AppTheme.brand,
                          size: 26,
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: 26,
                      backgroundColor: AppTheme.brand.withValues(alpha: 0.1),
                      child: const Icon(
                        Icons.smart_toy_rounded,
                        color: AppTheme.brand,
                        size: 26,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            assistant.name ?? '未命名智慧体',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              assistant.description ?? '暂无描述',
              style: TextStyle(
                fontSize: 11,
                color: colors.textTertiary,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              height: 30,
              child: ElevatedButton(
                onPressed: assistant.id != null
                    ? () => _navigateToAssistantChat(assistant)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.brand.withValues(alpha: 0.08),
                  foregroundColor: AppTheme.brand,
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  assistant.status == 'PUBLISHED' ? '开始对话' : '即将上线',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 导航到智慧体对话页面
  void _navigateToAssistantChat(AiAssistantVO assistant) async {
    if (assistant.id == null) return;

    // 跳转到AI聊天页面，传入智慧体ID
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AiChatPage(
          assistantId: assistant.id,
          assistantName: assistant.name,
          assistantAvatar: assistant.avatarUrl,
        ),
      ),
    );
  }
}

class _LiquidPebbleFab extends StatefulWidget {
  final VoidCallback onSearchPressed;
  final VoidCallback onAddFriendPressed;
  final int pendingRequestCount;

  const _LiquidPebbleFab({
    required this.onSearchPressed,
    required this.onAddFriendPressed,
    required this.pendingRequestCount,
  });

  @override
  State<_LiquidPebbleFab> createState() => _LiquidPebbleFabState();
}

class _LiquidPebbleFabState extends State<_LiquidPebbleFab>
    with TickerProviderStateMixin {
  late final AnimationController _morphController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  )..repeat(reverse: true);

  late final AnimationController _expandController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  bool _isExpanded = false;

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _expandController.forward();
        _morphController.stop(); // 展开时停止形变
      } else {
        _expandController.reverse();
        _morphController.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _morphController.dispose();
    _expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_morphController, _expandController]),
      builder: (context, child) {
        // 尺寸用不会超出范围的曲线，避免容器与内容不同步
        final sizeValue = Curves.easeOutCubic.transform(
          _expandController.value,
        );
        // 视觉效果（旋转、圆角）用带回弹的曲线
        final visualValue = Curves.easeOutBack.transform(
          _expandController.value,
        ).clamp(0.0, 1.0);
        // 高度从 65 伸长到 180 (胶囊形状)
        final height = 65.0 + (180.0 - 65.0) * sizeValue;
        final clampedExpand = sizeValue;

        final double morphValue = _morphController.value;

        // 模拟果冻/呼吸形变
        final BorderRadius collapsedRadius = BorderRadius.only(
          topLeft: Radius.circular(22 + 10 * morphValue),
          topRight: Radius.circular(25 + 7 * (1 - morphValue)),
          bottomLeft: Radius.circular(20 + 12 * morphValue),
          bottomRight: Radius.circular(30 + 5 * (1 - morphValue)),
        );

        // 展开时变成整齐的胶囊 (两侧完全圆角大弧度)
        final BorderRadius expandedRadius = BorderRadius.circular(32);

        // 通过缓动曲线混合两种圆角状态
        final BorderRadius currentRadius = BorderRadius.lerp(
          collapsedRadius,
          expandedRadius,
          visualValue,
        )!;

        return GestureDetector(
          onTap: _toggle,
          child: Container(
            width: 65,
            height: height,
            decoration: BoxDecoration(
              borderRadius: currentRadius,
              boxShadow: [
                BoxShadow(
                  color: Color.lerp(
                    AppTheme.brand.withValues(alpha: 0.4),
                    Colors.black.withValues(alpha: 0.12),
                    clampedExpand,
                  )!,
                  blurRadius: 20 + 10 * clampedExpand,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: currentRadius,
              child: Stack(
                children: [
                  // 蓝色渐变底色
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppTheme.brand, AppTheme.brand2],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                  // 白色遮罩（展开时覆盖上方区域）
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: (height - 65).clamp(0.0, double.infinity),
                    child: Opacity(
                      opacity: clampedExpand,
                      child: Container(color: Colors.white),
                    ),
                  ),
                  // 渐变分割线（X按钮上方）
                  Positioned(
                    top: (height - 65 - 1.5).clamp(0.0, double.infinity),
                    left: 8,
                    right: 8,
                    height: 1.5,
                    child: Opacity(
                      opacity: clampedExpand,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.brand.withValues(alpha: 0.0),
                              AppTheme.brand.withValues(alpha: 0.5),
                              AppTheme.brand2.withValues(alpha: 0.5),
                              AppTheme.brand2.withValues(alpha: 0.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // 底部的 "+" 号（旋转变 "x"）
                  Positioned(
                    bottom: (65.0 - 28) / 2,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Transform.rotate(
                        angle: visualValue * 3.14159 * 0.75,
                        child: const Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),

                  // 内部展开的操作按钮组（始终渲染，用opacity+translate平滑过渡）
                  Positioned(
                    top: 15,
                    left: 0,
                    right: 0,
                    child: IgnorePointer(
                      ignoring: !_isExpanded,
                      child: Opacity(
                        opacity: clampedExpand,
                        child: Transform.translate(
                          offset: Offset(0, 12 * (1.0 - clampedExpand)),
                          child: SizedBox(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildActionBtn(
                                  icon: Icons.search_rounded,
                                  iconColor: const Color(0xFF5C6BC0),
                                  onTap: widget.onSearchPressed,
                                ),
                                Container(
                                  width: 24,
                                  height: 1,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.grey.withValues(alpha: 0.0),
                                        Colors.grey.withValues(alpha: 0.2),
                                        Colors.grey.withValues(alpha: 0.0),
                                      ],
                                    ),
                                  ),
                                ),
                                _buildActionBtn(
                                  icon: Icons.person_add_rounded,
                                  iconColor: const Color(0xFF26A69A),
                                  onTap: widget.onAddFriendPressed,
                                  badgeCount: widget.pendingRequestCount,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionBtn({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = Colors.white,
    int badgeCount = 0,
  }) {
    return GestureDetector(
      onTap: () {
        _toggle(); // 点击后自动收起胶囊
        onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          if (badgeCount > 0)
            Positioned(
              right: 6,
              top: 2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  badgeCount > 99 ? '99+' : '$badgeCount',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
