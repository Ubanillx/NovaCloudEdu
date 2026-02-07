import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nova_api/nova_api.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../../widgets/toast/nova_message.dart';
import '../../../widgets/dialogs/app_dialog.dart';
import '../../auth/services/auth_service.dart';
import '../services/group_service.dart';
import '../services/group_sync_service.dart';
import '../services/group_database_service.dart';
import '../services/chat_websocket_service.dart';
import '../services/user_info_service.dart';
import '../widgets/message_content_widget.dart';
import '../widgets/chat_input_bar.dart';
import 'invite_members_page.dart';

/// 群聊会话页面
class GroupChatPage extends StatefulWidget {
  final int groupId;
  final String groupName;
  final String? groupAvatar;

  const GroupChatPage({
    super.key,
    required this.groupId,
    required this.groupName,
    this.groupAvatar,
  });

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  final _groupService = GroupService();
  final _syncService = GroupSyncService();
  final _userInfoService = UserInfoService();
  final _wsService = ChatWebSocketService.instance;
  final _scrollController = ScrollController();

  List<LocalGroupMessage> _messages = [];
  GroupResponse? _groupInfo;
  List<GroupMemberResponse> _members = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  int? _currentUserId;
  String? _currentUserName;
  String? _currentUserAvatar;
  
  // 用户信息缓存（用于补全群成员信息）
  final Map<int, UserPublicResponse> _userInfoCache = {};

  StreamSubscription<WsGroupMessage>? _messageSubscription;
  StreamSubscription<WsGroupReadReceipt>? _readReceiptSubscription;
  StreamSubscription<WsGroupMessage>? _sentConfirmSubscription;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    _loadData();
    _subscribeToMessages();
    _subscribeToReadReceipts();
    _subscribeToSentConfirmation();
  }

  Future<void> _loadCurrentUser() async {
    final userInfo = await AuthService().getUserInfo();
    if (userInfo != null && userInfo['id'] != null && mounted) {
      setState(() {
        _currentUserId = int.tryParse(userInfo['id'].toString());
        _currentUserName = userInfo['userName'] as String?;
        _currentUserAvatar = userInfo['userAvatar'] as String?;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageSubscription?.cancel();
    _readReceiptSubscription?.cancel();
    _sentConfirmSubscription?.cancel();
    _wsService.unsubscribeFromGroup(widget.groupId);
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      // 订阅群组消息
      _wsService.subscribeToGroup(widget.groupId);

      // 第一步：先从本地加载消息（极快，毫秒级），立即展示给用户
      final localMessages = await _syncService.getLocalMessages(widget.groupId);
      if (mounted && localMessages.isNotEmpty) {
        setState(() {
          _messages = localMessages;
          _isLoading = false; // 有本地消息就立即结束loading
        });
      }

      // 第二步：并行加载群信息、群成员（互不依赖）
      final results = await Future.wait([
        _groupService.getGroupInfo(widget.groupId),
        _groupService.getGroupMembers(widget.groupId),
      ]);

      final groupInfo = results[0] as GroupResponse?;
      final members = results[1] as List<GroupMemberResponse>;

      if (mounted) {
        setState(() {
          if (groupInfo != null) _groupInfo = groupInfo;
          _members = members;
        });
      }

      // 第三步：后台补全用户信息（不阻塞UI）
      _prefetchUserInfo(members);

      // 第四步：后台同步服务器最新消息
      _backgroundSyncMessages();
    } catch (e) {
      debugPrint('加载群聊数据失败: $e');
    } finally {
      if (mounted && _isLoading) setState(() => _isLoading = false);
    }
  }

  /// 后台预取用户信息（不阻塞UI）
  void _prefetchUserInfo(List<GroupMemberResponse> members) async {
    try {
      final userIds = members
          .where((m) => m.userId != null && (m.userName == null || m.userAvatar == null))
          .map((m) => m.userId!)
          .toSet()
          .toList();

      if (userIds.isNotEmpty) {
        final userInfoMap = await _userInfoService.getUserInfoBatch(userIds);
        if (mounted) {
          setState(() => _userInfoCache.addAll(userInfoMap));
        }
      }
    } catch (e) {
      debugPrint('预取用户信息失败: $e');
    }
  }

  /// 后台同步服务器最新消息
  void _backgroundSyncMessages() async {
    try {
      final syncedMessages = await _syncService.syncMessages(widget.groupId);
      if (mounted && syncedMessages.isNotEmpty) {
        setState(() => _messages = syncedMessages);
      }

      // 标记最后一条非自己发的消息为已读
      final allMessages = syncedMessages.isNotEmpty ? syncedMessages : _messages;
      if (allMessages.isNotEmpty && _currentUserId != null) {
        final lastOtherMsg = allMessages.firstWhere(
          (m) => m.senderId != _currentUserId,
          orElse: () => allMessages.first,
        );
        if (lastOtherMsg.messageId != null && lastOtherMsg.senderId != _currentUserId) {
          _wsService.markGroupMessageAsRead(
            groupId: widget.groupId,
            messageId: lastOtherMsg.messageId!,
          );
        }
      }
    } catch (e) {
      debugPrint('后台同步消息失败: $e');
    }
  }

  Future<void> _loadMoreMessages() async {
    if (_isLoadingMore || _messages.isEmpty) return;
    
    setState(() => _isLoadingMore = true);
    try {
      final oldestMessage = _messages.last;
      final moreMessages = await _syncService.getLocalMessages(
        widget.groupId,
        beforeMessageId: oldestMessage.messageId,
      );
      if (mounted && moreMessages.isNotEmpty) {
        setState(() => _messages.addAll(moreMessages));
      }
    } catch (e) {
      debugPrint('加载更多消息失败: $e');
    } finally {
      if (mounted) setState(() => _isLoadingMore = false);
    }
  }

  void _subscribeToMessages() {
    _messageSubscription = _wsService.groupMessages.listen((message) async {
      if (message.groupId == widget.groupId) {
        // 保存到本地数据库（会自动获取用户信息）
        final localMessage = await _syncService.saveReceivedMessage(
          messageId: message.messageId ?? 0,
          groupId: message.groupId ?? widget.groupId,
          senderId: message.senderId ?? 0,
          senderName: message.senderName,
          senderAvatar: message.senderAvatar,
          content: message.content,
          type: message.type,
          replyTo: message.replyTo,
          createTime: message.createTime,
        );
        
        // 更新UI（使用已补全用户信息的消息，先去重）
        if (mounted) {
          setState(() {
            // 防重：如果该 messageId 已存在则不插入
            final exists = _messages.any((m) => m.messageId == localMessage.messageId);
            if (!exists) {
              _messages.insert(0, localMessage);
            }
          });
          _scrollToBottom();
        }

        // 收到他人消息时，标记已读
        if (message.messageId != null &&
            _currentUserId != null &&
            message.senderId != _currentUserId) {
          _wsService.markGroupMessageAsRead(
            groupId: widget.groupId,
            messageId: message.messageId!,
          );
        }
      }
    });
  }

  void _subscribeToSentConfirmation() {
    _sentConfirmSubscription = _wsService.groupMessagesSent.listen((confirmed) {
      if (confirmed.groupId == widget.groupId && mounted) {
        setState(() {
          // 找到乐观消息（messageId == null，content 匹配）并更新为真实消息
          final idx = _messages.indexWhere(
            (m) => m.messageId == null && m.content == confirmed.content,
          );
          if (idx != -1) {
            _messages[idx] = LocalGroupMessage(
              messageId: confirmed.messageId,
              groupId: widget.groupId,
              senderId: _currentUserId ?? 0,
              senderName: _currentUserName,
              senderAvatar: _currentUserAvatar,
              content: confirmed.content,
              type: confirmed.type ?? 'TEXT',
              replyTo: confirmed.replyTo,
              createTime: confirmed.createTime ?? DateTime.now(),
              syncStatus: 0,
            );
          }
        });
        // 保存到本地数据库
        if (confirmed.messageId != null) {
          _syncService.saveReceivedMessage(
            messageId: confirmed.messageId!,
            groupId: widget.groupId,
            senderId: _currentUserId ?? 0,
            senderName: _currentUserName,
            senderAvatar: _currentUserAvatar,
            content: confirmed.content,
            type: confirmed.type,
            replyTo: confirmed.replyTo,
            createTime: confirmed.createTime,
          );
        }
      }
    });
  }

  void _subscribeToReadReceipts() {
    _readReceiptSubscription = _wsService.groupReadReceipts.listen((receipt) {
      if (receipt.groupId == widget.groupId && mounted) {
        // 目前 Flutter 端没有 readCount 字段在本地消息中，
        // 但当已读用户 BottomSheet 打开时可以实时刷新。
        // 这里触发一次 setState 以便 UI 感知变化。
        setState(() {});
      }
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendMessage(String content, String type) async {
    if (content.isEmpty) return;

    // 乐观更新：立即显示自己发的消息（后端不再回传给发送者）
    if (_currentUserId != null && mounted) {
      setState(() {
        _messages.insert(0, LocalGroupMessage(
          groupId: widget.groupId,
          senderId: _currentUserId!,
          senderName: _currentUserName,
          senderAvatar: _currentUserAvatar,
          content: content,
          type: type,
          createTime: DateTime.now(),
          syncStatus: 1,
        ));
      });
      _scrollToBottom();
    }

    _wsService.sendGroupMessage(
      groupId: widget.groupId,
      content: content,
      type: type,
    );
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
        title: GestureDetector(
          onTap: () => _showGroupInfo(context),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppTheme.brand.withOpacity(0.1),
                backgroundImage: widget.groupAvatar != null &&
                        widget.groupAvatar!.isNotEmpty
                    ? NetworkImage(widget.groupAvatar!)
                    : null,
                child: widget.groupAvatar == null || widget.groupAvatar!.isEmpty
                    ? Icon(Icons.group, color: AppTheme.brand, size: 16)
                    : null,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.groupName,
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${_groupInfo?.memberCount ?? _members.length}人',
                      style: TextStyle(
                        color: colors.textTertiary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: colors.textPrimary),
            onPressed: () => _showMoreMenu(context, colors),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const LoadingWidget(message: '加载中...')
                : _buildMessageList(colors),
          ),
          ChatInputBar(
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(AppColors colors) {
    if (_messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: colors.iconSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              '暂无消息',
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '发送第一条消息开始群聊吧',
              style: TextStyle(
                color: colors.textTertiary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            _scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent - 100) {
          _loadMoreMessages();
        }
        return false;
      },
      child: ListView.builder(
        controller: _scrollController,
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _messages.length + (_isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _messages.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          }
          final message = _messages[index];
          final showTime = index == _messages.length - 1 ||
              _shouldShowTime(message, _messages[index + 1]);
          return _buildMessageItem(message, showTime, colors);
        },
      ),
    );
  }

  bool _shouldShowTime(LocalGroupMessage current, LocalGroupMessage previous) {
    return current.createTime.difference(previous.createTime).inMinutes > 5;
  }

  Widget _buildMessageItem(
      LocalGroupMessage message, bool showTime, AppColors colors) {
    // 判断是否是自己发送的消息
    final isMe = _currentUserId != null && message.senderId == _currentUserId;

    return Column(
      children: [
        if (showTime)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              _formatTime(message.createTime),
              style: TextStyle(
                color: colors.textTertiary,
                fontSize: 12,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isMe) ...[
                GestureDetector(
                  onTap: () {
                    // TODO: 查看用户资料
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: colors.surfaceVariant,
                    backgroundImage: message.senderAvatar != null &&
                            message.senderAvatar!.isNotEmpty
                        ? NetworkImage(message.senderAvatar!)
                        : null,
                    child: message.senderAvatar == null ||
                            message.senderAvatar!.isEmpty
                        ? Icon(Icons.person,
                            color: colors.iconSecondary, size: 18)
                        : null,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    if (!isMe)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4, left: 4),
                        child: Text(
                          message.senderName ?? '未知用户',
                          style: TextStyle(
                            color: colors.textTertiary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    _buildMessageContent(message, isMe, colors),
                    if (isMe)
                      Padding(
                        padding: const EdgeInsets.only(top: 4, right: 4),
                        child: GestureDetector(
                          onTap: message.messageId != null
                              ? () => _showReadUsers(context, message.messageId!)
                              : null,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                message.messageId != null ? Icons.done_all : Icons.access_time,
                                size: 14,
                                color: AppTheme.brand.withOpacity(0.6),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                message.messageId != null ? '查看已读' : '发送中',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppTheme.brand.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (isMe) const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageContent(
      LocalGroupMessage message, bool isMe, AppColors colors) {
    final type = message.type.toUpperCase();
    final content = message.content ?? '';

    if (type == 'IMAGE') {
      return MessageContentWidget(
        content: content,
        type: message.type,
        isMe: isMe,
        colors: colors,
      );
    }

    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: type == 'AUDIO' ? 8 : 14,
        vertical: type == 'AUDIO' ? 4 : 10,
      ),
      decoration: BoxDecoration(
        color: isMe ? AppTheme.brand : colors.surface,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: Radius.circular(isMe ? 16 : 4),
          bottomRight: Radius.circular(isMe ? 4 : 16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: MessageContentWidget(
        content: content,
        type: message.type,
        isMe: isMe,
        colors: colors,
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(time.year, time.month, time.day);

    String timeStr =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

    if (messageDate == today) {
      return timeStr;
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return '昨天 $timeStr';
    } else if (now.difference(time).inDays < 7) {
      const weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
      return '${weekdays[time.weekday - 1]} $timeStr';
    } else {
      return '${time.month}/${time.day} $timeStr';
    }
  }

  void _showReadUsers(BuildContext context, int messageId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return _ReadUsersSheet(
          messageId: messageId,
          groupService: _groupService,
        );
      },
    );
  }

  void _showMoreMenu(BuildContext context, AppColors colors) {
    // 判断当前用户是否是群主
    final isOwner = _groupInfo?.ownerId == _currentUserId;
    
    showAppActionSheet(
      context,
      items: ['群成员', '群设置', isOwner ? '解散群聊' : '退出群聊'],
      onSelected: (item, index) {
        switch (index) {
          case 0:
            _showMemberList(context);
            break;
          case 1:
            _showGroupSettings(context);
            break;
          case 2:
            if (isOwner) {
              _confirmDissolveGroup(context);
            } else {
              _confirmLeaveGroup(context);
            }
            break;
        }
      },
    );
  }

  void _confirmDissolveGroup(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      title: '解散群聊',
      content: '确定要解散群聊 ${widget.groupName} 吗？解散后所有成员将被移出，且无法恢复。',
      confirmText: '解散',
      isDanger: true,
    );

    if (confirmed == true && mounted) {
      final success = await _groupService.dissolveGroup(widget.groupId);
      if (success && mounted) {
        // 删除本地数据
        await _syncService.deleteGroup(widget.groupId);
        NovaMessage.success(context, '群聊已解散');
        Navigator.pop(context, true);
      } else if (mounted) {
        NovaMessage.error(context, '解散失败');
      }
    }
  }

  void _showGroupInfo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GroupInfoPage(
          groupId: widget.groupId,
          groupInfo: _groupInfo,
          members: _members,
          userInfoCache: _userInfoCache,
        ),
      ),
    );
  }

  void _showMemberList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GroupMembersPage(
          groupId: widget.groupId,
          members: _members,
          userInfoCache: _userInfoCache,
        ),
      ),
    );
  }

  void _showGroupSettings(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GroupSettingsPage(
          groupId: widget.groupId,
          groupInfo: _groupInfo,
          members: _members,
          userInfoCache: _userInfoCache,
          currentUserId: _currentUserId,
        ),
      ),
    );

    if (result == 'leave' && mounted) {
      _confirmLeaveGroup(context);
    } else if (result == 'dissolve' && mounted) {
      _confirmDissolveGroup(context);
    } else if (result == 'refresh' && mounted) {
      // 刷新群信息
      final groupInfo = await _groupService.getGroupInfo(widget.groupId);
      if (groupInfo != null && mounted) {
        setState(() => _groupInfo = groupInfo);
      }
    }
  }

  void _confirmLeaveGroup(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      title: '退出群聊',
      content: '确定要退出群聊 ${widget.groupName} 吗？',
      confirmText: '退出',
      isDanger: true,
    );

    if (confirmed == true && mounted) {
      final success = await _groupService.leaveGroup(widget.groupId);
      if (success && mounted) {
        // 删除本地数据
        await _syncService.deleteGroup(widget.groupId);
        NovaMessage.success(context, '已退出群聊');
        // 返回true表示需要刷新列表
        Navigator.pop(context, true);
      } else if (mounted) {
        NovaMessage.error(context, '退出失败');
      }
    }
  }
}

/// 已读用户列表 BottomSheet
class _ReadUsersSheet extends StatefulWidget {
  final int messageId;
  final GroupService groupService;

  const _ReadUsersSheet({
    required this.messageId,
    required this.groupService,
  });

  @override
  State<_ReadUsersSheet> createState() => _ReadUsersSheetState();
}

class _ReadUsersSheetState extends State<_ReadUsersSheet> {
  List<ReadUserInfo> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReadUsers();
  }

  Future<void> _loadReadUsers() async {
    try {
      final users = await widget.groupService.getReadUsers(widget.messageId);
      if (mounted) {
        setState(() {
          _users = users;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        NovaMessage.error(context, '加载已读列表失败');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 拖动条
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: colors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // 标题
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Row(
              children: [
                Icon(Icons.done_all, size: 18, color: AppTheme.brand),
                const SizedBox(width: 8),
                Text(
                  '${_users.length} 人已读',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: colors.divider),
          // 列表
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            )
          else if (_users.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                '暂无已读记录',
                style: TextStyle(
                  fontSize: 14,
                  color: colors.textTertiary,
                ),
              ),
            )
          else
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  final user = _users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: colors.surfaceVariant,
                      backgroundImage: user.userAvatar != null &&
                              user.userAvatar!.isNotEmpty
                          ? NetworkImage(user.userAvatar!)
                          : null,
                      child: user.userAvatar == null ||
                              user.userAvatar!.isEmpty
                          ? Icon(Icons.person,
                              color: colors.iconSecondary, size: 20)
                          : null,
                    ),
                    title: Text(
                      user.userName ?? '未知用户',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: colors.textPrimary,
                      ),
                    ),
                    dense: true,
                  );
                },
              ),
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

/// 群信息页面
class GroupInfoPage extends StatelessWidget {
  final int groupId;
  final GroupResponse? groupInfo;
  final List<GroupMemberResponse> members;
  final Map<int, UserPublicResponse>? userInfoCache;

  const GroupInfoPage({
    super.key,
    required this.groupId,
    this.groupInfo,
    required this.members,
    this.userInfoCache,
  });

  // 获取成员显示名称
  String _getMemberName(GroupMemberResponse member) {
    if (member.userName != null && member.userName!.isNotEmpty) {
      return member.userName!;
    }
    if (member.userId != null && userInfoCache != null) {
      final userInfo = userInfoCache![member.userId!];
      if (userInfo?.userName != null) {
        return userInfo!.userName!;
      }
    }
    return '未知用户';
  }

  // 获取成员头像
  String? _getMemberAvatar(GroupMemberResponse member) {
    if (member.userAvatar != null && member.userAvatar!.isNotEmpty) {
      return member.userAvatar;
    }
    if (member.userId != null && userInfoCache != null) {
      final userInfo = userInfoCache![member.userId!];
      return userInfo?.userAvatar;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('群信息'),
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: ListView(
        children: [
          // 群头像和名称
          Container(
            color: colors.surface,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppTheme.brand.withOpacity(0.1),
                  backgroundImage: groupInfo?.avatar != null &&
                          groupInfo!.avatar!.isNotEmpty
                      ? NetworkImage(groupInfo!.avatar!)
                      : null,
                  child: groupInfo?.avatar == null || groupInfo!.avatar!.isEmpty
                      ? Icon(Icons.group, color: AppTheme.brand, size: 40)
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  groupInfo?.groupName ?? '群聊',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${groupInfo?.memberCount ?? members.length}人',
                  style: TextStyle(
                    fontSize: 14,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // 群公告
          if (groupInfo?.announcement != null &&
              groupInfo!.announcement!.isNotEmpty)
            Container(
              color: colors.surface,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '群公告',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    groupInfo!.announcement!,
                    style: TextStyle(
                      fontSize: 14,
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          // 群简介
          Container(
            color: colors.surface,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '群简介',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  groupInfo?.description ?? '暂无简介',
                  style: TextStyle(
                    fontSize: 14,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // 群成员预览
          Container(
            color: colors.surface,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '群成员',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GroupMembersPage(
                              groupId: groupId,
                              members: members,
                              userInfoCache: userInfoCache,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        '查看全部 ${members.length}',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.brand,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: members.take(8).map((member) {
                    final memberAvatar = _getMemberAvatar(member);
                    final memberName = _getMemberName(member);
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: colors.surfaceVariant,
                          backgroundImage: memberAvatar != null &&
                                  memberAvatar.isNotEmpty
                              ? NetworkImage(memberAvatar)
                              : null,
                          child: memberAvatar == null ||
                                  memberAvatar.isEmpty
                              ? Icon(Icons.person,
                                  color: colors.iconSecondary, size: 24)
                              : null,
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: 48,
                          child: Text(
                            memberName,
                            style: TextStyle(
                              fontSize: 12,
                              color: colors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 群成员列表页面
class GroupMembersPage extends StatefulWidget {
  final int groupId;
  final List<GroupMemberResponse> members;
  final Map<int, UserPublicResponse>? userInfoCache;
  final VoidCallback? onMembersChanged;

  const GroupMembersPage({
    super.key,
    required this.groupId,
    required this.members,
    this.userInfoCache,
    this.onMembersChanged,
  });

  @override
  State<GroupMembersPage> createState() => _GroupMembersPageState();
}

class _GroupMembersPageState extends State<GroupMembersPage> {
  late List<GroupMemberResponse> _members;

  @override
  void initState() {
    super.initState();
    _members = List.from(widget.members);
  }

  // 获取成员显示名称
  String _getMemberName(GroupMemberResponse member) {
    if (member.userName != null && member.userName!.isNotEmpty) {
      return member.userName!;
    }
    if (member.userId != null && widget.userInfoCache != null) {
      final userInfo = widget.userInfoCache![member.userId!];
      if (userInfo?.userName != null) {
        return userInfo!.userName!;
      }
    }
    return '未知用户';
  }

  // 获取成员头像
  String? _getMemberAvatar(GroupMemberResponse member) {
    if (member.userAvatar != null && member.userAvatar!.isNotEmpty) {
      return member.userAvatar;
    }
    if (member.userId != null && widget.userInfoCache != null) {
      final userInfo = widget.userInfoCache![member.userId!];
      return userInfo?.userAvatar;
    }
    return null;
  }

  void _navigateToInvite(BuildContext context) async {
    final existingIds = _members
        .where((m) => m.userId != null)
        .map((m) => m.userId!)
        .toList();

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => InviteMembersPage(
          groupId: widget.groupId,
          existingMemberIds: existingIds,
        ),
      ),
    );

    if (result == true) {
      widget.onMembersChanged?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text('群成员 (${_members.length})'),
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => _navigateToInvite(context),
            tooltip: '邀请好友',
          ),
        ],
      ),
      body: Column(
        children: [
          // 邀请好友入口
          InkWell(
            onTap: () => _navigateToInvite(context),
            child: Container(
              padding: const EdgeInsets.all(16),
              color: colors.surface,
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppTheme.brand.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Icon(Icons.add, color: AppTheme.brand),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '邀请好友加入群聊',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.brand,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          // 成员列表
          Expanded(
            child: ListView.builder(
              itemCount: _members.length,
              itemBuilder: (context, index) {
                final member = _members[index];
                final memberName = _getMemberName(member);
                final memberAvatar = _getMemberAvatar(member);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: colors.surfaceVariant,
                    backgroundImage: memberAvatar != null && memberAvatar.isNotEmpty
                        ? NetworkImage(memberAvatar)
                        : null,
                    child: memberAvatar == null || memberAvatar.isEmpty
                        ? Icon(Icons.person, color: colors.iconSecondary)
                        : null,
                  ),
                  title: Text(
                    memberName,
                    style: TextStyle(color: colors.textPrimary),
                  ),
                  subtitle: member.role != null && member.role! > 0
                      ? Text(
                          member.role == 2 ? '群主' : '管理员',
                          style: TextStyle(
                            color: member.role == 2 ? Colors.orange : AppTheme.brand,
                            fontSize: 12,
                          ),
                        )
                      : null,
                  trailing: member.role == 2
                      ? Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            '群主',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 12,
                            ),
                          ),
                        )
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 群设置页面
class GroupSettingsPage extends StatefulWidget {
  final int groupId;
  final GroupResponse? groupInfo;
  final List<GroupMemberResponse> members;
  final Map<int, UserPublicResponse>? userInfoCache;
  final int? currentUserId;

  const GroupSettingsPage({
    super.key,
    required this.groupId,
    this.groupInfo,
    required this.members,
    this.userInfoCache,
    this.currentUserId,
  });

  @override
  State<GroupSettingsPage> createState() => _GroupSettingsPageState();
}

class _GroupSettingsPageState extends State<GroupSettingsPage> {
  final _groupService = GroupService();

  @override
  void initState() {
    super.initState();
  }

  // 复制群号到剪贴板
  void _copyGroupNumber() {
    final groupNumber = widget.groupInfo?.groupNumber;
    if (groupNumber != null && groupNumber.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: groupNumber));
      NovaMessage.success(context, '群号已复制');
    }
  }

  // 编辑群名称
  Future<void> _editGroupName() async {
    final result = await showInputDialog(
      context,
      title: '修改群名称',
      hintText: '请输入新的群名称',
      initialValue: widget.groupInfo?.groupName,
    );
    if (result != null && result.isNotEmpty && result != widget.groupInfo?.groupName) {
      final success = await _groupService.updateGroupInfo(
        groupId: widget.groupId,
        groupName: result,
      );
      if (success) {
        NovaMessage.success(context, '群名称已更新');
        if (mounted) Navigator.pop(context, 'refresh'); // 通知刷新
      } else {
        NovaMessage.error(context, '更新失败');
      }
    }
  }

  // 编辑群简介
  Future<void> _editGroupDescription() async {
    final result = await showInputDialog(
      context,
      title: '修改群简介',
      hintText: '请输入群简介',
      initialValue: widget.groupInfo?.description,
      maxLines: 3,
    );
    if (result != null && result != widget.groupInfo?.description) {
      final success = await _groupService.updateGroupInfo(
        groupId: widget.groupId,
        description: result,
      );
      if (success) {
        NovaMessage.success(context, '群简介已更新');
        if (mounted) Navigator.pop(context, 'refresh'); // 通知刷新
      } else {
        NovaMessage.error(context, '更新失败');
      }
    }
  }

  // 获取成员显示名称
  String _getMemberName(GroupMemberResponse member) {
    if (member.userName != null && member.userName!.isNotEmpty) {
      return member.userName!;
    }
    if (member.userId != null && widget.userInfoCache != null) {
      final userInfo = widget.userInfoCache![member.userId!];
      if (userInfo?.userName != null) {
        return userInfo!.userName!;
      }
    }
    return '未知用户';
  }

  // 获取成员头像
  String? _getMemberAvatar(GroupMemberResponse member) {
    if (member.userAvatar != null && member.userAvatar!.isNotEmpty) {
      return member.userAvatar;
    }
    if (member.userId != null && widget.userInfoCache != null) {
      final userInfo = widget.userInfoCache![member.userId!];
      return userInfo?.userAvatar;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isOwner = widget.groupInfo?.ownerId == widget.currentUserId;

    return Scaffold(
      backgroundColor: colors.background, // 修复背景颜色
      appBar: AppBar(
        title: const Text('群设置'),
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          // 群成员预览区域
          _buildSectionContainer(
            colors,
            child: Column(
              children: [
                _buildMembersGrid(colors),
                const Divider(height: 1),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GroupMembersPage(
                          groupId: widget.groupId,
                          members: widget.members,
                          userInfoCache: widget.userInfoCache,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '查看全部群成员 (${widget.members.length})',
                          style: TextStyle(
                            fontSize: 14,
                            color: colors.textSecondary,
                          ),
                        ),
                        Icon(Icons.chevron_right, size: 16, color: colors.textSecondary),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 12),
          
          // 群信息设置
          _buildSectionContainer(
            colors,
            child: Column(
              children: [
                _buildSettingItem(
                  colors,
                  title: '群号',
                  value: widget.groupInfo?.groupNumber ?? '未生成',
                  trailing: IconButton(
                    icon: Icon(Icons.copy, size: 18, color: colors.textSecondary),
                    onPressed: () {
                      _copyGroupNumber();
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  onTap: null, // 群号不可修改
                ),
                _buildDivider(colors),
                _buildSettingItem(
                  colors,
                  title: '群名称',
                  value: widget.groupInfo?.groupName ?? '未命名',
                  onTap: isOwner ? () => _editGroupName() : null,
                ),
                _buildDivider(colors),
                _buildSettingItem(
                  colors,
                  title: '群简介',
                  value: widget.groupInfo?.description?.isNotEmpty == true
                      ? widget.groupInfo!.description!
                      : '未设置',
                  onTap: isOwner ? () => _editGroupDescription() : null,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 退出/解散按钮
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, isOwner ? 'dissolve' : 'leave'); 
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.surface,
                foregroundColor: Colors.red,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                isOwner ? '解散群聊' : '退出群聊',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionContainer(AppColors colors, {required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }

  Widget _buildMembersGrid(AppColors colors) {
    // 显示前4个成员 + 添加按钮
    final displayMembers = widget.members.take(4).toList();
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...displayMembers.map((member) {
            final avatar = _getMemberAvatar(member);
            final name = _getMemberName(member);
            return Expanded(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: colors.surfaceVariant,
                    backgroundImage: avatar != null ? NetworkImage(avatar) : null,
                    child: avatar == null
                        ? Icon(Icons.person, color: colors.iconSecondary)
                        : null,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 12,
                      color: colors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          }),
          // 添加按钮
          Expanded(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InviteMembersPage(
                          groupId: widget.groupId,
                          existingMemberIds: widget.members
                              .where((m) => m.userId != null)
                              .map((m) => m.userId!)
                              .toList(),
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(color: colors.border, width: 1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add, color: colors.textSecondary),
                  ),
                ),
                const SizedBox(height: 4),
                const SizedBox(height: 16), // 占位保持对齐
              ],
            ),
          ),
          // 补齐剩余空间（如果成员不足4个）
          if (displayMembers.length < 4)
            ...List.generate(
              4 - displayMembers.length,
              (index) => const Expanded(child: SizedBox()),
            ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    AppColors colors, {
    required String title,
    String? value,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: colors.textPrimary,
              ),
            ),
            const Spacer(),
            if (value != null)
              Expanded(
                flex: 2,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: colors.textSecondary,
                  ),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            if (trailing != null) ...[
              const SizedBox(width: 8),
              trailing,
            ] else 
              Icon(Icons.chevron_right, size: 20, color: colors.iconSecondary),
          ],
        ),
      ),
    );
  }


  Widget _buildDivider(AppColors colors) {
    return Divider(height: 1, indent: 16, color: colors.border);
  }
}
