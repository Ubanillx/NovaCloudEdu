import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import '../../../../config/app_theme.dart';
import '../../../../widgets/toast/nova_message.dart';
import '../services/article_chat_service.dart';

/// 文章AI聊天页面 - 支持SSE流式对话
class ArticleChatPage extends StatefulWidget {
  final int articleId;
  final String articleTitle;

  const ArticleChatPage({
    super.key,
    required this.articleId,
    required this.articleTitle,
  });

  @override
  State<ArticleChatPage> createState() => _ArticleChatPageState();
}

class _ArticleChatPageState extends State<ArticleChatPage> {
  final ArticleChatService _chatService = ArticleChatService();
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  List<ArticleChatMessage> _messages = [];
  bool _isLoading = false;
  String _streamingContent = '';

  @override
  void initState() {
    super.initState();
    // 添加欢迎消息
    _messages.add(ArticleChatMessage(
      role: 'assistant',
      content: '你好！我是AI助手，很高兴与你讨论《${widget.articleTitle}》这篇文章。\n\n你可以问我关于文章内容的任何问题，比如：\n- 这篇文章的主要观点是什么？\n- 作者想表达什么思想？\n- 文章中有哪些值得深思的地方？',
    ));
  }

  @override
  void dispose() {
    _chatService.dispose();
    _inputController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  Future<void> _sendMessage() async {
    final content = _inputController.text.trim();
    if (content.isEmpty || _isLoading) return;

    _inputController.clear();
    _focusNode.unfocus();

    // 添加用户消息
    setState(() {
      _messages.add(ArticleChatMessage(
        role: 'user',
        content: content,
      ));
      _isLoading = true;
      _streamingContent = '';
    });
    _scrollToBottom();

    // 构建历史记录（排除欢迎消息）
    final history = _messages.length > 1
        ? _messages.sublist(1, _messages.length - 1)
        : <ArticleChatMessage>[];

    // 发送SSE请求
    await _chatService.sendMessageStream(
      articleId: widget.articleId,
      message: content,
      history: history,
      onData: (data) {
        setState(() {
          _streamingContent += data;
        });
        _scrollToBottom();
      },
      onDone: () {
        setState(() {
          // 将流式内容转换为正式消息
          if (_streamingContent.isNotEmpty) {
            _messages.add(ArticleChatMessage(
              role: 'assistant',
              content: _streamingContent,
            ));
          }
          _streamingContent = '';
          _isLoading = false;
        });
        _scrollToBottom();
      },
      onError: (error) {
        setState(() {
          _isLoading = false;
          _streamingContent = '';
        });
        if (mounted) {
          NovaMessage.error(context, '请求失败，请重试');
        }
      },
    );
  }

  void _cancelStream() {
    _chatService.cancelStream();
    setState(() {
      if (_streamingContent.isNotEmpty) {
        _messages.add(ArticleChatMessage(
          role: 'assistant',
          content: '$_streamingContent\n\n[已取消]',
        ));
      }
      _streamingContent = '';
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface.withOpacity(0.8),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: colors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI 深度讨论',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            Text(
              widget.articleTitle,
              style: TextStyle(
                fontSize: 11,
                color: colors.textTertiary,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.cleaning_services_rounded, color: colors.textSecondary, size: 20),
            onPressed: () => _clearMessages(),
            tooltip: '清空对话',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // 顶部提示
          _buildTopTip(colors),
          // 消息列表
          Expanded(
            child: _buildMessageList(colors),
          ),
          // 输入区域
          _buildInputArea(colors),
        ],
      ),
    );
  }

  Widget _buildTopTip(AppColors colors) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.brand.withOpacity(0.05),
        border: Border(bottom: BorderSide(color: colors.border.withOpacity(0.5))),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, size: 14, color: AppTheme.brand.withOpacity(0.7)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'AI 助手已阅读全文，你可以针对细节进行提问',
              style: TextStyle(
                fontSize: 12,
                color: colors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(AppColors colors) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: _messages.length + (_streamingContent.isNotEmpty ? 1 : 0),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        // 显示流式内容
        if (index == _messages.length && _streamingContent.isNotEmpty) {
          return _buildMessageItem(
            ArticleChatMessage(
              role: 'assistant',
              content: _streamingContent,
              isStreaming: true,
            ),
            colors,
          );
        }
        return _buildMessageItem(_messages[index], colors);
      },
    );
  }

  Widget _buildMessageItem(ArticleChatMessage message, AppColors colors) {
    final isUser = message.role == 'user';
    final isDark = context.isDarkMode;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            // AI头像
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.brand, AppTheme.brand2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.brand.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.smart_toy_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isUser
                    ? AppTheme.brand
                    : colors.surface,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isUser ? 20 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: isUser ? null : Border.all(color: colors.border.withOpacity(0.5)),
              ),
              child: isUser
                  ? Text(
                      message.content,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        height: 1.6,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 使用Markdown渲染AI回复
                        MarkdownBlock(
                          data: message.content,
                          config: isDark
                              ? MarkdownConfig.darkConfig.copy(configs: [
                                  PConfig(textStyle: TextStyle(
                                    fontSize: 15,
                                    color: colors.textPrimary,
                                    height: 1.7,
                                    letterSpacing: 0.2,
                                  )),
                                ])
                              : MarkdownConfig.defaultConfig.copy(configs: [
                                  PConfig(textStyle: TextStyle(
                                    fontSize: 15,
                                    color: colors.textPrimary,
                                    height: 1.7,
                                    letterSpacing: 0.2,
                                  )),
                                ]),
                        ),
                        if (message.isStreaming) ...[
                          const SizedBox(height: 12),
                          _buildStreamingIndicator(colors),
                        ],
                      ],
                    ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 10),
            // 用户头像
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.brand.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.brand.withOpacity(0.2)),
              ),
              child: const Icon(
                Icons.person_rounded,
                color: AppTheme.brand,
                size: 20,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStreamingIndicator(AppColors colors) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 12,
          height: 12,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.brand.withOpacity(0.5)),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'AI 正在思考...',
          style: TextStyle(
            fontSize: 12,
            color: colors.textTertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildInputArea(AppColors colors) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: colors.border.withOpacity(0.8)),
              ),
              child: TextField(
                controller: _inputController,
                focusNode: _focusNode,
                maxLines: 5,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: '想对文章说点什么...',
                  hintStyle: TextStyle(color: colors.textTertiary, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
                style: TextStyle(
                  fontSize: 15,
                  color: colors.textPrimary,
                ),
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          _isLoading
              ? _buildStopButton()
              : _buildSendButton(),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return GestureDetector(
      onTap: _sendMessage,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppTheme.brand,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.brand.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.send_rounded,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildStopButton() {
    return GestureDetector(
      onTap: _cancelStream,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.redAccent.withOpacity(0.2)),
        ),
        child: const Icon(
          Icons.stop_rounded,
          color: Colors.redAccent,
          size: 24,
        ),
      ),
    );
  }

  void _clearMessages() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('清空对话'),
        content: const Text('确定要清空所有对话记录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _messages = [
                  ArticleChatMessage(
                    role: 'assistant',
                    content: '对话已清空。你可以继续提问关于《${widget.articleTitle}》的问题。',
                  ),
                ];
              });
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
