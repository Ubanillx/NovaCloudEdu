import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/common/skeleton_widgets.dart';
import '../../../widgets/common/nova_refresh_header.dart';
import '../../../widgets/common/empty_widget.dart';
import '../../../widgets/dialogs/app_dialog.dart';
import '../../../widgets/toast/nova_message.dart';
import '../services/ai_chat_service.dart';
import 'ai_chat_page.dart';

/// AI会话历史列表页面
class AiSessionListPage extends StatefulWidget {
  const AiSessionListPage({super.key});

  @override
  State<AiSessionListPage> createState() => _AiSessionListPageState();
}

class _AiSessionListPageState extends State<AiSessionListPage> {
  final AiChatApiService _chatService = AiChatApiService();
  List<AiChatSession> _sessions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  @override
  void dispose() {
    _chatService.dispose();
    super.dispose();
  }

  Future<void> _loadSessions() async {
    final sessions = await _chatService.listSessions();
    if (mounted) {
      setState(() {
        _sessions = sessions;
        _isLoading = false;
      });
    }
  }

  void _openSession(AiChatSession session) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AiChatPage(
          sessionId: session.sessionId,
          title: session.title ?? 'AI 助手',
          assistantId: session.assistantId,
          assistantName: session.assistantName,
          assistantAvatar: session.assistantAvatar,
        ),
      ),
    );
    _loadSessions();
  }

  void _createNewSession() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AiChatPage(),
      ),
    );
    _loadSessions();
  }

  Future<void> _deleteSession(AiChatSession session) async {
    final confirmed = await showConfirmDialog(
      context,
      title: '删除会话',
      content: '确定要删除「${session.title ?? '未命名会话'}」吗？删除后无法恢复。',
      confirmText: '删除',
      isDanger: true,
    );

    if (confirmed == true) {
      final success = await _chatService.deleteSession(session.sessionId);
      if (success && mounted) {
        NovaMessage.success(context, '已删除');
        _loadSessions();
      } else if (mounted) {
        NovaMessage.error(context, '删除失败');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface.withOpacity(0.95),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: colors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '对话历史',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_comment_outlined,
                color: AppTheme.brand, size: 22),
            onPressed: _createNewSession,
            tooltip: '新建对话',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _isLoading
          ? const ChatListSkeleton()
          : _sessions.isEmpty
              ? _buildEmpty(colors)
              : _buildSessionList(colors),
    );
  }

  Widget _buildEmpty(AppColors colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const EmptyWidget(message: '暂无对话历史'),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: _createNewSession,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.brand,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Text(
                '开始新对话',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionList(AppColors colors) {
    return NovaRefreshHeader(
      onRefresh: _loadSessions,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _sessions.length,
        itemBuilder: (context, index) =>
            _buildSessionItem(_sessions[index], colors),
      ),
    );
  }

  Widget _buildSessionItem(AiChatSession session, AppColors colors) {
    return Dismissible(
      key: Key('session_${session.sessionId}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        return await showConfirmDialog(
          context,
          title: '删除会话',
          content: '确定要删除「${session.title ?? '未命名会话'}」吗？',
          confirmText: '删除',
          isDanger: true,
        );
      },
      onDismissed: (_) async {
        await _chatService.deleteSession(session.sessionId);
        _loadSessions();
      },
      child: GestureDetector(
        onTap: () => _openSession(session),
        onLongPress: () => _deleteSession(session),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(context.isDarkMode ? 0.2 : 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // 显示智慧体头像或默认图标
              if (session.assistantAvatar != null && session.assistantAvatar!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    session.assistantAvatar!,
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.brand.withOpacity(0.15),
                            AppTheme.brand2.withOpacity(0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.smart_toy_rounded,
                          color: AppTheme.brand, size: 22),
                    ),
                  ),
                )
              else
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.brand.withOpacity(0.15),
                        AppTheme.brand2.withOpacity(0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    session.assistantId != null
                        ? Icons.smart_toy_rounded
                        : Icons.chat_bubble_outline_rounded,
                    color: AppTheme.brand,
                    size: 22,
                  ),
                ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.assistantName ?? session.title ?? '未命名会话',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '${session.messageCount} 条消息',
                          style: TextStyle(
                            fontSize: 12,
                            color: colors.textTertiary,
                          ),
                        ),
                        if (session.updateTime != null) ...[
                          Text(
                            '  ·  ',
                            style: TextStyle(
                              fontSize: 12,
                              color: colors.textTertiary,
                            ),
                          ),
                          Text(
                            _formatTime(session.updateTime!),
                            style: TextStyle(
                              fontSize: 12,
                              color: colors.textTertiary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: colors.iconSecondary, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(time.year, time.month, time.day);

    if (date == today) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else if (date == today.subtract(const Duration(days: 1))) {
      return '昨天';
    } else if (now.difference(time).inDays < 7) {
      const weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
      return weekdays[time.weekday - 1];
    } else {
      return '${time.month}/${time.day}';
    }
  }
}
