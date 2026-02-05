import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/common/nova_refresh_header.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../data/mock_data.dart';
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

/// 聊天页面 - 参考smartclass ChatContainer.vue
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['历史对话', '好友', '群聊', '智慧体中心'];
  final _friendService = FriendService();
  final _chatService = ChatService();
  final _groupService = GroupService();
  final _wsService = ChatWebSocketService.instance;
  final _dbService = ChatDatabaseService();
  final _notificationService = NotificationService();
  
  List<FriendResponse> _friends = [];
  List<ChatSessionResponse> _sessions = [];
  List<GroupResponse> _groups = [];
  bool _isLoadingFriends = true;
  bool _isLoadingSessions = true;
  bool _isLoadingGroups = true;
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
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    _loadFriends();
    _loadPendingRequests();
    _loadSessions();
    _loadGroups();
    _subscribeToNotifications();
    _initNotificationService();
  }

  void _initNotificationService() {
    _notificationService.init();
    _groupUnreadSubscription = _notificationService.groupUnreadStream.listen((counts) {
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
      final requests = await _friendService.getReceivedRequests(status: 'pending');
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
            // 头部
            _buildHeader(),
            // 导航标签
            _buildTabBar(),
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
    );
  }

  // 头部
  Widget _buildHeader() {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 8, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '对话',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: colors.textPrimary,
            ),
          ),
          Row(
            children: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () => _navigateToFriendRequests(),
                    icon: Icon(Icons.person_add_outlined, size: 24, color: colors.iconPrimary),
                  ),
                  if (_pendingRequestCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          _pendingRequestCount > 99 ? '99+' : '$_pendingRequestCount',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              IconButton(
                onPressed: () => _navigateToSearchUser(),
                icon: Icon(Icons.search_rounded, size: 24, color: colors.iconPrimary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToSearchUser() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const UnifiedSearchPage()),
    );
  }

  void _navigateToFriendRequests() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const FriendRequestsPage()),
    );
    // 返回后刷新待处理申请数量
    _loadPendingRequests();
    _loadFriends();
  }

  void _navigateToFriendsList() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const FriendsListPage()),
    );
    // 返回后刷新好友列表
    _loadFriends();
  }

  // 导航标签
  Widget _buildTabBar() {
    final colors = context.colors;
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = _tabController.index == index;
          return GestureDetector(
            onTap: () => _tabController.animateTo(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.brand : colors.surfaceVariant,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  _tabs[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Colors.white : colors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // 历史对话
  Widget _buildHistoryTab() {
    final colors = context.colors;
    
    if (_isLoadingSessions) {
      return const LoadingWidget(message: '加载中...');
    }
    
    if (_sessions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 64, color: colors.textTertiary),
            const SizedBox(height: 16),
            Text('暂无对话', style: TextStyle(color: colors.textSecondary)),
            const SizedBox(height: 8),
            Text('和好友开始聊天吧', style: TextStyle(color: colors.textTertiary, fontSize: 12)),
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
    return GestureDetector(
      onTap: () => _navigateToChat(session),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
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
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppTheme.brand.withOpacity(0.1),
                  backgroundImage: session.partnerAvatar != null &&
                          session.partnerAvatar!.isNotEmpty
                      ? NetworkImage(session.partnerAvatar!)
                      : null,
                  child: session.partnerAvatar == null ||
                          session.partnerAvatar!.isEmpty
                      ? Icon(Icons.person, color: AppTheme.brand, size: 24)
                      : null,
                ),
                if ((session.unreadCount ?? 0) > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        (session.unreadCount ?? 0) > 99
                            ? '99+'
                            : '${session.unreadCount}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            // 内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          session.partnerName ?? '未知用户',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: colors.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (session.lastMessageTime != null)
                        Text(
                          _formatSessionTime(session.lastMessageTime!),
                          style: TextStyle(
                            fontSize: 12,
                            color: colors.textTertiary,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  FutureBuilder<String?>(
                    future: _getLastMessage(session.partnerId),
                    builder: (context, snapshot) {
                      final lastMessage = snapshot.data ?? '';
                      return Text(
                        lastMessage.isEmpty ? '暂无消息' : lastMessage,
                        style: TextStyle(
                          fontSize: 13,
                          color: colors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
      return const LoadingWidget(message: '加载中...');
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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
    return GestureDetector(
      onTap: () => _navigateToFriendChat(friend),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
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
            // 内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    friend.userName ?? '未知用户',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    friend.userProfile ?? '@${friend.userAccount ?? ""}',
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
            // 聊天图标
            Container(
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
          ],
        ),
      ),
    );
  }

  // 群聊列表
  Widget _buildGroupsTab() {
    final colors = context.colors;
    
    if (_isLoadingGroups) {
      return const LoadingWidget(message: '加载中...');
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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
    final unreadCount = groupId != null ? (_groupUnreadCounts[groupId]?.unreadCount ?? 0) : 0;
    final lastMessage = groupId != null ? _groupUnreadCounts[groupId]?.lastMessage : null;
    
    return GestureDetector(
      onTap: () => _navigateToGroupChat(group),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
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
            // 头像带未读角标
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppTheme.brand.withOpacity(0.1),
                  backgroundImage: group.avatar != null && group.avatar!.isNotEmpty
                      ? NetworkImage(group.avatar!)
                      : null,
                  child: group.avatar == null || group.avatar!.isEmpty
                      ? Icon(Icons.group, color: AppTheme.brand, size: 24)
                      : null,
                ),
                if (unreadCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                      child: Text(
                        unreadCount > 99 ? '99+' : '$unreadCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
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
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastMessage ?? '${group.memberCount ?? 0}人',
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
            Icon(
              Icons.chevron_right,
              color: colors.iconSecondary,
            ),
          ],
        ),
      ),
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('创建失败: $e')),
          );
        }
      }
    }
  }

  // 智慧体中心
  Widget _buildIntelligenceTab() {
    return NovaRefreshableList(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index >= MockData.aiAssistants.length) return null;
                return _buildAssistantCard(MockData.aiAssistants[index]);
              },
              childCount: MockData.aiAssistants.length,
            ),
          ),
        ),
      ],
    );
  }

  // 智慧体卡片
  Widget _buildAssistantCard(AiAssistant assistant) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[100]!, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.brand.withOpacity(0.1),
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                assistant.avatar,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => CircleAvatar(
                  radius: 30,
                  backgroundColor: AppTheme.brand.withOpacity(0.1),
                  child: const Icon(Icons.smart_toy_rounded, color: AppTheme.brand, size: 30),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            assistant.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              assistant.description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              height: 32,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.brand.withOpacity(0.1),
                  foregroundColor: AppTheme.brand,
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  '立即开启',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
