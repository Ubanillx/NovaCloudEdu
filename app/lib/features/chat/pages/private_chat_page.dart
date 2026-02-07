import 'dart:async';
import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../../widgets/toast/nova_message.dart';
import '../services/chat_sync_service.dart';
import '../services/chat_database_service.dart';
import '../services/chat_websocket_service.dart';
import '../widgets/message_content_widget.dart';
import '../widgets/chat_input_bar.dart';
import '../services/friend_service.dart';
import '../../circle/pages/user_profile_page.dart';
import '../../../widgets/dialogs/app_dialog.dart';

/// 私聊会话页面
class PrivateChatPage extends StatefulWidget {
  final int partnerId;
  final String partnerName;
  final String? partnerAvatar;

  const PrivateChatPage({
    super.key,
    required this.partnerId,
    required this.partnerName,
    this.partnerAvatar,
  });

  @override
  State<PrivateChatPage> createState() => _PrivateChatPageState();
}

class _PrivateChatPageState extends State<PrivateChatPage> {
  final _syncService = ChatSyncService();
  final _wsService = ChatWebSocketService.instance;
  final _scrollController = ScrollController();
  
  List<LocalChatMessage> _messages = [];
  bool _isLoading = true;
  bool _hasMore = true;
  
  StreamSubscription<WsChatMessage>? _messageSubscription;
  StreamSubscription<ReadReceipt>? _readReceiptSubscription;

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _subscribeToMessages();
    // 标记消息已读
    _wsService.markAsRead(widget.partnerId);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageSubscription?.cancel();
    _readReceiptSubscription?.cancel();
    super.dispose();
  }

  void _subscribeToMessages() {
    // 监听新消息
    _messageSubscription = _wsService.chatMessages.listen((message) {
      // 只处理来自当前聊天对象的消息
      if (message.senderId == widget.partnerId) {
        setState(() {
          // 防重：如果该 messageId 已存在则不插入
          final exists = message.messageId != null &&
              _messages.any((m) => m.messageId == message.messageId);
          if (!exists) {
            _messages.insert(0, LocalChatMessage(
              messageId: message.messageId,
              senderId: message.senderId ?? 0,
              senderName: message.senderName,
              senderAvatar: message.senderAvatar,
              receiverId: message.receiverId ?? 0,
              content: message.content,
              type: message.type ?? 'TEXT',
              isRead: message.isRead ?? false,
              isSent: true,
              createTime: message.createTime ?? DateTime.now(),
            ));
          }
        });
        // 标记已读
        _syncService.markAsRead(widget.partnerId);
        // 滚动到底部
        _scrollToBottom();
      }
    });

    // 监听已读回执
    _readReceiptSubscription = _wsService.readReceipts.listen((receipt) {
      if (receipt.senderId == widget.partnerId) {
        // 更新消息已读状态
        setState(() {
          _messages = _messages.map((msg) {
            if (msg.receiverId == widget.partnerId && !msg.isRead) {
              return msg.copyWith(isRead: true);
            }
            return msg;
          }).toList();
        });
      }
    });
  }

  Future<void> _loadMessages({bool loadMore = false}) async {
    if (!loadMore) {
      setState(() => _isLoading = true);
    }

    try {
      final beforeId = loadMore && _messages.isNotEmpty
          ? _messages.last.messageId
          : null;
      
      // 使用同步服务获取消息（优先本地，无则从云端）
      final messages = await _syncService.getMessages(
        widget.partnerId,
        limit: 50,
        beforeMessageId: beforeId,
      );

      if (mounted) {
        setState(() {
          if (loadMore) {
            _messages.addAll(messages);
          } else {
            _messages = messages;
          }
          _hasMore = messages.length >= 50;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        NovaMessage.error(context, '加载消息失败');
      }
    }
  }

  Future<void> _sendMessage(String content, String type) async {
    if (content.isEmpty) return;

    // 本地添加消息（乐观更新）
    final now = DateTime.now();
    final localMessage = LocalChatMessage(
      messageId: now.millisecondsSinceEpoch,
      senderId: 0, // 当前用户ID由同步服务管理
      receiverId: widget.partnerId,
      content: content,
      type: type,
      isRead: false,
      isSent: false,
      createTime: now,
      syncStatus: 1, // 待同步
    );

    // 先添加到UI
    setState(() {
      _messages.insert(0, localMessage);
    });
    _scrollToBottom();

    // 保存到本地数据库
    final dbService = ChatDatabaseService();
    await dbService.insertMessage(localMessage);

    // 尝试通过 WebSocket 发送消息
    try {
      if (_wsService.isConnected) {
        _wsService.sendPrivateMessage(
          receiverId: widget.partnerId,
          content: content,
          type: type,
        );
        // 发送成功，更新同步状态
        await dbService.updateMessageSyncStatus(localMessage.messageId!, 0);
        // 更新UI中的消息状态
        setState(() {
          final index = _messages.indexWhere((m) => m.messageId == localMessage.messageId);
          if (index >= 0) {
            _messages[index] = _messages[index].copyWith(isSent: true, syncStatus: 0);
          }
        });
      } else {
        // 网络未连接，标记为发送失败
        await dbService.updateMessageSyncStatus(localMessage.messageId!, 2);
        if (mounted) {
          NovaMessage.show(context, '网络未连接，消息已保存，稍后自动重试');
        }
      }
    } catch (e) {
      // 发送失败，标记为同步失败
      await dbService.updateMessageSyncStatus(localMessage.messageId!, 2);
      if (mounted) {
        NovaMessage.error(context, '发送失败，消息已保存');
      }
    }
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
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: AppTheme.brand.withOpacity(0.1),
              backgroundImage: widget.partnerAvatar != null &&
                      widget.partnerAvatar!.isNotEmpty
                  ? NetworkImage(widget.partnerAvatar!)
                  : null,
              child: widget.partnerAvatar == null || widget.partnerAvatar!.isEmpty
                  ? Icon(Icons.person, color: AppTheme.brand, size: 16)
                  : null,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.partnerName,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
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
          // 消息列表
          Expanded(
            child: _isLoading
                ? const LoadingWidget(message: '加载中...')
                : _buildMessageList(colors),
          ),
          // 输入框
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
              color: colors.textTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              '暂无消息，开始聊天吧',
              style: TextStyle(
                color: colors.textSecondary,
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
            _scrollController.position.extentAfter < 100 &&
            _hasMore &&
            !_isLoading) {
          _loadMessages(loadMore: true);
        }
        return false;
      },
      child: ListView.builder(
        controller: _scrollController,
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[index];
          final isMe = message.senderId != widget.partnerId;
          final showTime = index == _messages.length - 1 ||
              _shouldShowTime(message, _messages[index + 1]);

          return _buildMessageItem(message, isMe, showTime, colors);
        },
      ),
    );
  }

  bool _shouldShowTime(LocalChatMessage current, LocalChatMessage previous) {
    return current.createTime.difference(previous.createTime).inMinutes > 5;
  }

  Widget _buildMessageItem(
    LocalChatMessage message,
    bool isMe,
    bool showTime,
    AppColors colors,
  ) {
    return Column(
      children: [
        if (showTime)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              _formatTime(message.createTime),
              style: TextStyle(
                fontSize: 12,
                color: colors.textTertiary,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isMe) ...[
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppTheme.brand.withOpacity(0.1),
                  backgroundImage: widget.partnerAvatar != null &&
                          widget.partnerAvatar!.isNotEmpty
                      ? NetworkImage(widget.partnerAvatar!)
                      : null,
                  child: widget.partnerAvatar == null ||
                          widget.partnerAvatar!.isEmpty
                      ? Icon(Icons.person, color: AppTheme.brand, size: 16)
                      : null,
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: _buildMessageContent(message, isMe, colors),
              ),
              if (isMe) ...[
                const SizedBox(width: 4),
                _buildMessageStatus(message, colors),
              ],
            ],
          ),
        ),
      ],
    );
  }

  /// 构建消息内容（根据类型决定是否显示消息框）
  Widget _buildMessageContent(LocalChatMessage message, bool isMe, AppColors colors) {
    final type = message.type.toUpperCase();
    final content = message.content ?? '';
    
    // 图片消息不显示消息框
    if (type == 'IMAGE') {
      return MessageContentWidget(
        content: content,
        type: message.type,
        isMe: isMe,
        colors: colors,
      );
    }
    
    // 其他消息显示消息框
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

  /// 构建消息状态图标（发送中/已发送/已读/发送失败）
  Widget _buildMessageStatus(LocalChatMessage message, AppColors colors) {
    // 发送失败
    if (message.syncStatus == 2) {
      return GestureDetector(
        onTap: () => _retrySendMessage(message),
        child: const Icon(
          Icons.error_outline,
          size: 16,
          color: Colors.red,
        ),
      );
    }
    
    // 发送中（待同步）
    if (message.syncStatus == 1 || !message.isSent) {
      return SizedBox(
        width: 14,
        height: 14,
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          valueColor: AlwaysStoppedAnimation<Color>(colors.textTertiary),
        ),
      );
    }
    
    // 已读/已发送
    return Icon(
      message.isRead ? Icons.done_all : Icons.done,
      size: 14,
      color: message.isRead ? AppTheme.brand : colors.textTertiary,
    );
  }

  /// 重试发送失败的消息
  Future<void> _retrySendMessage(LocalChatMessage message) async {
    if (message.content == null) return;

    final dbService = ChatDatabaseService();
    
    // 更新状态为发送中
    await dbService.updateMessageSyncStatus(message.messageId!, 1);
    setState(() {
      final index = _messages.indexWhere((m) => m.messageId == message.messageId);
      if (index >= 0) {
        _messages[index] = _messages[index].copyWith(syncStatus: 1);
      }
    });

    // 尝试重新发送
    try {
      if (_wsService.isConnected) {
        _wsService.sendPrivateMessage(
          receiverId: widget.partnerId,
          content: message.content!,
          type: message.type,
        );
        await dbService.updateMessageSyncStatus(message.messageId!, 0);
        setState(() {
          final index = _messages.indexWhere((m) => m.messageId == message.messageId);
          if (index >= 0) {
            _messages[index] = _messages[index].copyWith(isSent: true, syncStatus: 0);
          }
        });
      } else {
        await dbService.updateMessageSyncStatus(message.messageId!, 2);
        setState(() {
          final index = _messages.indexWhere((m) => m.messageId == message.messageId);
          if (index >= 0) {
            _messages[index] = _messages[index].copyWith(syncStatus: 2);
          }
        });
        if (mounted) {
          NovaMessage.show(context, '网络未连接');
        }
      }
    } catch (e) {
      await dbService.updateMessageSyncStatus(message.messageId!, 2);
      setState(() {
        final index = _messages.indexWhere((m) => m.messageId == message.messageId);
        if (index >= 0) {
          _messages[index] = _messages[index].copyWith(syncStatus: 2);
        }
      });
    }
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

  /// 显示更多菜单
  void _showMoreMenu(BuildContext context, AppColors colors) {
    showAppActionSheet(
      context,
      items: ['查找聊天记录', '查看个人资料', '删除好友'],
      onSelected: (item, index) {
        switch (index) {
          case 0:
            _showSearchDialog(context);
            break;
          case 1:
            _viewUserProfile();
            break;
          case 2:
            _confirmDeleteFriend(context);
            break;
        }
      },
    );
  }

  /// 显示搜索对话框
  void _showSearchDialog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatSearchPage(
          partnerId: widget.partnerId,
          partnerName: widget.partnerName,
        ),
      ),
    );
  }

  /// 查看用户资料
  void _viewUserProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserProfilePage(userId: widget.partnerId),
      ),
    );
  }

  /// 确认删除好友
  void _confirmDeleteFriend(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      title: '删除好友',
      content: '确定要删除好友 ${widget.partnerName} 吗？删除后将清空聊天记录。',
      confirmText: '删除',
      isDanger: true,
    );
    
    if (confirmed == true && mounted) {
      try {
        final friendService = FriendService();
        final success = await friendService.deleteFriend(widget.partnerId);
        if (success && mounted) {
          NovaMessage.success(context, '已删除好友');
          Navigator.pop(context);
        } else if (mounted) {
          NovaMessage.error(context, '删除失败');
        }
      } catch (e) {
        if (mounted) {
          NovaMessage.error(context, '删除失败');
        }
      }
    }
  }
}

/// 聊天记录搜索页面
class ChatSearchPage extends StatefulWidget {
  final int partnerId;
  final String partnerName;

  const ChatSearchPage({
    super.key,
    required this.partnerId,
    required this.partnerName,
  });

  @override
  State<ChatSearchPage> createState() => _ChatSearchPageState();
}

class _ChatSearchPageState extends State<ChatSearchPage> {
  final _searchController = TextEditingController();
  final _dbService = ChatDatabaseService();
  List<LocalChatMessage> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _search(String keyword) async {
    if (keyword.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    setState(() => _isSearching = true);

    try {
      final results = await _dbService.searchMessages(
        0, // 当前用户ID
        widget.partnerId,
        keyword,
      );
      if (mounted) {
        setState(() {
          _searchResults = results;
          _isSearching = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSearching = false);
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
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: '搜索与 ${widget.partnerName} 的聊天记录',
            hintStyle: TextStyle(color: colors.textTertiary, fontSize: 15),
            border: InputBorder.none,
          ),
          style: TextStyle(color: colors.textPrimary, fontSize: 15),
          onChanged: (value) => _search(value),
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: Icon(Icons.clear, color: colors.textSecondary),
              onPressed: () {
                _searchController.clear();
                setState(() => _searchResults = []);
              },
            ),
        ],
      ),
      body: _isSearching
          ? const Center(child: CircularProgressIndicator())
          : _searchResults.isEmpty
              ? Center(
                  child: Text(
                    _searchController.text.isEmpty
                        ? '输入关键词搜索聊天记录'
                        : '未找到相关记录',
                    style: TextStyle(color: colors.textTertiary),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final message = _searchResults[index];
                    return _buildSearchResultItem(message, colors);
                  },
                ),
    );
  }

  Widget _buildSearchResultItem(LocalChatMessage message, AppColors colors) {
    final isMe = message.senderId != widget.partnerId;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                isMe ? '我' : widget.partnerName,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isMe ? AppTheme.brand : colors.textPrimary,
                ),
              ),
              const Spacer(),
              Text(
                _formatSearchTime(message.createTime),
                style: TextStyle(fontSize: 12, color: colors.textTertiary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            message.content ?? '',
            style: TextStyle(fontSize: 14, color: colors.textPrimary),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  String _formatSearchTime(DateTime time) {
    return '${time.year}/${time.month}/${time.day} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
