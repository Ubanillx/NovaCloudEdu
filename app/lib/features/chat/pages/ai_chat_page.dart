import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:markdown_widget/markdown_widget.dart';
import '../../../config/app_theme.dart';
import '../../../services/file_upload_service.dart';
import '../../../widgets/toast/nova_message.dart';
import '../../../widgets/common/loading_widget.dart';
import '../services/ai_chat_service.dart';

/// AI智慧体对话页面 - 支持会话级SSE流式对话
class AiChatPage extends StatefulWidget {
  final int? sessionId;
  final String title;

  const AiChatPage({
    super.key,
    this.sessionId,
    this.title = 'AI 助手',
  });

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  final AiChatApiService _chatService = AiChatApiService();
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  final FileUploadService _uploadService = FileUploadService();

  List<AiChatMessage> _messages = [];
  bool _isLoading = false;
  bool _isInitializing = true;
  bool _isUploading = false;
  String _streamingContent = '';
  int? _currentSessionId;
  String _title = '';

  // 待发送的图片（本地路径）
  final List<XFile> _pendingImages = [];
  static const int _maxImages = 3;

  // 待发送的文档
  final List<PlatformFile> _pendingDocuments = [];
  static const int _maxDocuments = 3;
  static const List<String> _allowedDocExtensions = ['pdf', 'docx', 'txt', 'md', 'csv', 'html', 'json', 'xml'];

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _currentSessionId = widget.sessionId;
    _initSession();
  }

  Future<void> _initSession() async {
    if (_currentSessionId != null) {
      // 加载已有会话
      final detail = await _chatService.getSessionDetail(_currentSessionId!);
      if (detail != null && mounted) {
        final session = detail['session'] as AiChatSession;
        setState(() {
          _messages = detail['messages'] as List<AiChatMessage>;
          _title = session.title ?? widget.title;
          _isInitializing = false;
        });
        _scrollToBottom();
        return;
      }
    }

    // 创建新会话
    final sessionId = await _chatService.createSession();
    if (mounted) {
      setState(() {
        _currentSessionId = sessionId;
        _isInitializing = false;
      });
    }
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
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  // ==================== 图片管理 ====================

  Future<void> _pickImage(ImageSource source) async {
    if (_pendingImages.length >= _maxImages) {
      NovaMessage.warning(context, '最多上传$_maxImages张图片');
      return;
    }

    final XFile? image = source == ImageSource.gallery
        ? await _uploadService.pickImageFromGallery()
        : await _uploadService.pickImageFromCamera();

    if (image != null && mounted) {
      setState(() => _pendingImages.add(image));
    }
  }

  void _removeImage(int index) {
    setState(() => _pendingImages.removeAt(index));
  }

  void _showImageSourcePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final colors = context.colors;
        return Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).padding.bottom + 16),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 36, height: 4,
                decoration: BoxDecoration(
                  color: colors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.photo_library_rounded, color: AppTheme.brand),
                title: Text('从相册选择', style: TextStyle(color: colors.textPrimary)),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt_rounded, color: AppTheme.brand),
                title: Text('拍照', style: TextStyle(color: colors.textPrimary)),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ==================== 文档管理 ====================

  Future<void> _pickDocument() async {
    if (_pendingDocuments.length >= _maxDocuments) {
      NovaMessage.warning(context, '最多上传$_maxDocuments个文档');
      return;
    }

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: _allowedDocExtensions,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty && mounted) {
      final file = result.files.first;
      if (file.path == null) return;
      setState(() => _pendingDocuments.add(file));
    }
  }

  void _removeDocument(int index) {
    setState(() => _pendingDocuments.removeAt(index));
  }

  String _docIcon(String? ext) {
    switch (ext?.toLowerCase()) {
      case 'pdf': return '📄';
      case 'docx': return '📝';
      case 'txt': case 'md': return '📃';
      case 'csv': return '📊';
      case 'html': case 'htm': return '🌐';
      default: return '📎';
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
  }

  // ==================== 发送消息 ====================

  Future<void> _sendMessage() async {
    final content = _inputController.text.trim();
    if (content.isEmpty || _isLoading) return;
    if (_currentSessionId == null) {
      NovaMessage.error(context, '会话创建失败，请重试');
      return;
    }

    _inputController.clear();
    _focusNode.unfocus();

    // 先保存待上传的附件引用，然后清空预览
    final imagesToUpload = List<XFile>.from(_pendingImages);
    final docsToUpload = List<PlatformFile>.from(_pendingDocuments);
    final hasImages = imagesToUpload.isNotEmpty;
    final hasDocs = docsToUpload.isNotEmpty;

    // 构建附件列表（用于消息展示）
    final attachments = <String>[
      ...imagesToUpload.map((e) => e.path),
      ...docsToUpload.where((d) => d.path != null).map((d) => 'doc:${d.name}'),
    ];

    setState(() {
      _messages.add(AiChatMessage(
        role: 'user',
        content: content,
        attachments: attachments.isNotEmpty ? attachments : null,
      ));
      _pendingImages.clear();
      _pendingDocuments.clear();
      _isLoading = true;
      _streamingContent = '';
    });
    _scrollToBottom();

    setState(() => _isUploading = true);

    // 上传图片
    List<String> imageUrls = [];
    if (hasImages) {
      for (final image in imagesToUpload) {
        final result = await _uploadService.uploadFile(image, 'chat/ai');
        if (result?.fileUrl != null) {
          imageUrls.add(result!.fileUrl!);
        }
      }
    }

    // 上传文档
    List<String> documentUrls = [];
    if (hasDocs) {
      for (final doc in docsToUpload) {
        if (doc.path == null) continue;
        final xFile = XFile(doc.path!);
        final result = await _uploadService.uploadFile(xFile, 'chat/ai');
        if (result?.fileUrl != null) {
          documentUrls.add(result!.fileUrl!);
        }
      }
    }

    if (mounted) setState(() => _isUploading = false);

    // 检查上传结果
    if (hasImages && imageUrls.isEmpty) {
      if (mounted) {
        NovaMessage.error(context, '图片上传失败');
        setState(() => _isLoading = false);
      }
      return;
    }
    if (hasDocs && documentUrls.isEmpty) {
      if (mounted) {
        NovaMessage.error(context, '文档上传失败');
        setState(() => _isLoading = false);
      }
      return;
    }

    await _chatService.sessionStreamChat(
      sessionId: _currentSessionId!,
      message: content,
      imageUrls: imageUrls.isNotEmpty ? imageUrls : null,
      documentUrls: documentUrls.isNotEmpty ? documentUrls : null,
      onData: (data) {
        if (mounted) {
          setState(() {
            _streamingContent += data;
          });
          _scrollToBottom();
        }
      },
      onDone: () {
        if (mounted) {
          setState(() {
            if (_streamingContent.isNotEmpty) {
              _messages.add(AiChatMessage(
                role: 'assistant',
                content: _streamingContent,
              ));
            }
            _streamingContent = '';
            _isLoading = false;
          });
          _scrollToBottom();
          if (_messages.length <= 3) {
            _refreshTitle();
          }
        }
      },
      onError: (error) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            if (_streamingContent.isNotEmpty) {
              _messages.add(AiChatMessage(
                role: 'assistant',
                content: _streamingContent,
              ));
              _streamingContent = '';
            }
          });
          NovaMessage.error(context, '请求失败，请重试');
        }
      },
    );
  }

  Future<void> _refreshTitle() async {
    if (_currentSessionId == null) return;
    final detail = await _chatService.getSessionDetail(_currentSessionId!);
    if (detail != null && mounted) {
      final session = detail['session'] as AiChatSession;
      if (session.title != null && session.title!.isNotEmpty) {
        setState(() => _title = session.title!);
      }
    }
  }

  void _cancelStream() {
    _chatService.cancelStream();
    if (mounted) {
      setState(() {
        if (_streamingContent.isNotEmpty) {
          _messages.add(AiChatMessage(
            role: 'assistant',
            content: '$_streamingContent\n\n*[已停止]*',
          ));
        }
        _streamingContent = '';
        _isLoading = false;
      });
    }
  }

  void _copyMessage(String content) {
    Clipboard.setData(ClipboardData(text: content));
    NovaMessage.success(context, '已复制到剪贴板');
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (_currentSessionId != null)
              Text(
                '会话 #$_currentSessionId',
                style: TextStyle(
                  fontSize: 11,
                  color: colors.textTertiary,
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_comment_outlined,
                color: colors.textSecondary, size: 20),
            onPressed: _startNewSession,
            tooltip: '新对话',
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: _isInitializing
          ? const LoadingWidget(message: '正在初始化...')
          : Column(
              children: [
                Expanded(child: _buildMessageList(colors)),
                _buildInputArea(colors),
              ],
            ),
    );
  }

  void _startNewSession() async {
    if (_isLoading) return;
    final sessionId = await _chatService.createSession();
    if (sessionId != null && mounted) {
      setState(() {
        _currentSessionId = sessionId;
        _messages = [];
        _title = 'AI 助手';
        _streamingContent = '';
      });
    } else if (mounted) {
      NovaMessage.error(context, '创建新会话失败');
    }
  }

  Widget _buildMessageList(AppColors colors) {
    final itemCount = _messages.length + (_streamingContent.isNotEmpty ? 1 : 0);

    if (itemCount == 0) {
      return _buildEmptyState(colors);
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: itemCount,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == _messages.length && _streamingContent.isNotEmpty) {
          return _buildMessageItem(
            AiChatMessage(
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

  Widget _buildEmptyState(AppColors colors) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.brand, AppTheme.brand2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.brand.withOpacity(0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.smart_toy_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '你好，我是智云星课 AI 助手',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '有什么我可以帮助你的吗？',
              style: TextStyle(
                fontSize: 14,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 32),
            // 快捷提示
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _buildQuickPrompt('帮我解释一道数学题', colors),
                _buildQuickPrompt('英语语法有什么技巧？', colors),
                _buildQuickPrompt('帮我制定学习计划', colors),
                _buildQuickPrompt('推荐一些学习方法', colors),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickPrompt(String text, AppColors colors) {
    return GestureDetector(
      onTap: () {
        _inputController.text = text;
        _sendMessage();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.brand.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.brand.withOpacity(0.15)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: AppTheme.brand,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageItem(AiChatMessage message, AppColors colors) {
    final isUser = message.role == 'user';
    return isUser
        ? _buildUserMessage(message, colors)
        : _buildAiMessage(message, colors);
  }

  // 用户消息：右对齐 + 气泡 + 图片缩略图 + 文档标签
  Widget _buildUserMessage(AiChatMessage message, AppColors colors) {
    final imageAttachments = (message.attachments ?? [])
        .where((a) => !a.startsWith('doc:'))
        .toList();
    final docAttachments = (message.attachments ?? [])
        .where((a) => a.startsWith('doc:'))
        .map((a) => a.substring(4))
        .toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 图片缩略图
          if (imageAttachments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8, right: 42),
              child: Wrap(
                alignment: WrapAlignment.end,
                spacing: 6,
                runSpacing: 6,
                children: imageAttachments.map((path) {
                  final isLocalFile = !path.startsWith('http');
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: isLocalFile
                        ? Image.file(
                            File(path),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _imagePlaceholder(),
                          )
                        : Image.network(
                            path,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _imagePlaceholder(),
                          ),
                  );
                }).toList(),
              ),
            ),
          // 文档标签
          if (docAttachments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8, right: 42),
              child: Wrap(
                alignment: WrapAlignment.end,
                spacing: 6,
                runSpacing: 4,
                children: docAttachments.map((name) {
                  final ext = name.contains('.') ? name.split('.').last : '';
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.brand.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.brand.withOpacity(0.2)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_docIcon(ext), style: const TextStyle(fontSize: 14)),
                        const SizedBox(width: 4),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 150),
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.brand,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          // 文字气泡
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 48),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.brand,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.brand.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    message.content,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.brand.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: AppTheme.brand,
                  size: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: 80,
      height: 80,
      color: Colors.grey[200],
      child: Icon(Icons.image_not_supported_outlined, color: Colors.grey[400], size: 24),
    );
  }

  // AI消息：头像+名称在上，Markdown内容在下，无气泡
  Widget _buildAiMessage(AiChatMessage message, AppColors colors) {
    final isDark = context.isDarkMode;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onLongPress: () => _copyMessage(message.content),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 头像 + 名称
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.brand, AppTheme.brand2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.smart_toy_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'AI 助手',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: colors.textSecondary,
                  ),
                ),
                if (message.isStreaming) ...[
                  const SizedBox(width: 8),
                  _buildStreamingIndicator(colors),
                ],
              ],
            ),
            const SizedBox(height: 8),
            // Markdown 内容，直接展示，无气泡
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: MarkdownBlock(
                data: message.content,
                config: isDark
                    ? MarkdownConfig.darkConfig.copy(configs: [
                        PConfig(
                            textStyle: TextStyle(
                          fontSize: 15,
                          color: colors.textPrimary,
                          height: 1.7,
                          letterSpacing: 0.2,
                        )),
                        PreConfig(
                          decoration: BoxDecoration(
                            color: colors.surfaceVariant,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ])
                    : MarkdownConfig.defaultConfig.copy(configs: [
                        PConfig(
                            textStyle: TextStyle(
                          fontSize: 15,
                          color: colors.textPrimary,
                          height: 1.7,
                          letterSpacing: 0.2,
                        )),
                        PreConfig(
                          decoration: BoxDecoration(
                            color: colors.surfaceVariant,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ]),
              ),
            ),
          ],
        ),
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
            valueColor:
                AlwaysStoppedAnimation<Color>(AppTheme.brand.withOpacity(0.5)),
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
        left: 12,
        right: 12,
        top: 8,
        bottom: MediaQuery.of(context).padding.bottom + 8,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 图片预览栏
          if (_pendingImages.isNotEmpty) _buildImagePreview(colors),
          // 文档预览栏
          if (_pendingDocuments.isNotEmpty) _buildDocumentPreview(colors),
          // 上传中提示
          if (_isUploading)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  SizedBox(
                    width: 14, height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppTheme.brand),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '正在上传附件...',
                    style: TextStyle(fontSize: 12, color: colors.textTertiary),
                  ),
                ],
              ),
            ),
          // 输入行
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 附件按钮组
              _buildAttachmentButtons(colors),
              const SizedBox(width: 8),
              // 输入框
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: colors.background,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: colors.border.withOpacity(0.6)),
                  ),
                  child: TextField(
                    controller: _inputController,
                    focusNode: _focusNode,
                    maxLines: 4,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: _pendingImages.isNotEmpty
                          ? '描述图片内容或提问...'
                          : '输入你的问题...',
                      hintStyle:
                          TextStyle(color: colors.textTertiary, fontSize: 14),
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10),
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
              const SizedBox(width: 8),
              // 发送/停止按钮
              _isLoading ? _buildStopButton() : _buildSendButton(),
            ],
          ),
        ],
      ),
    );
  }

  // 图片预览栏
  Widget _buildImagePreview(AppColors colors) {
    return Container(
      height: 76,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _pendingImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(_pendingImages[index].path),
                    width: 68,
                    height: 68,
                    fit: BoxFit.cover,
                  ),
                ),
                // 删除按钮
                Positioned(
                  top: 2,
                  right: 2,
                  child: GestureDetector(
                    onTap: () => _removeImage(index),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // 文档预览栏
  Widget _buildDocumentPreview(AppColors colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _pendingDocuments.asMap().entries.map((entry) {
          final index = entry.key;
          final doc = entry.value;
          final ext = doc.extension;
          return Container(
            margin: const EdgeInsets.only(bottom: 4),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colors.border.withOpacity(0.5)),
            ),
            child: Row(
              children: [
                Text(_docIcon(ext), style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doc.name,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: colors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${ext?.toUpperCase() ?? ''} · ${_formatFileSize(doc.size)}',
                        style: TextStyle(fontSize: 11, color: colors.textTertiary),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _removeDocument(index),
                  child: Icon(Icons.close_rounded, size: 18, color: colors.textTertiary),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // 附件按钮组
  Widget _buildAttachmentButtons(AppColors colors) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 图片按钮
        GestureDetector(
          onTap: _isLoading ? null : _showImageSourcePicker,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _pendingImages.isNotEmpty
                  ? AppTheme.brand.withOpacity(0.1)
                  : colors.background,
              shape: BoxShape.circle,
              border: Border.all(
                color: _pendingImages.isNotEmpty
                    ? AppTheme.brand.withOpacity(0.3)
                    : colors.border.withOpacity(0.5),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.image_rounded,
                  color: _pendingImages.isNotEmpty
                      ? AppTheme.brand
                      : colors.iconSecondary,
                  size: 18,
                ),
                if (_pendingImages.isNotEmpty)
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: AppTheme.brand,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${_pendingImages.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 6),
        // 文档按钮
        GestureDetector(
          onTap: _isLoading ? null : _pickDocument,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _pendingDocuments.isNotEmpty
                  ? AppTheme.brand.withOpacity(0.1)
                  : colors.background,
              shape: BoxShape.circle,
              border: Border.all(
                color: _pendingDocuments.isNotEmpty
                    ? AppTheme.brand.withOpacity(0.3)
                    : colors.border.withOpacity(0.5),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.description_outlined,
                  color: _pendingDocuments.isNotEmpty
                      ? AppTheme.brand
                      : colors.iconSecondary,
                  size: 18,
                ),
                if (_pendingDocuments.isNotEmpty)
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: AppTheme.brand,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${_pendingDocuments.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSendButton() {
    return GestureDetector(
      onTap: _sendMessage,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.brand,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.brand.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(
          Icons.send_rounded,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }

  Widget _buildStopButton() {
    return GestureDetector(
      onTap: _cancelStream,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.redAccent.withOpacity(0.2)),
        ),
        child: const Icon(
          Icons.stop_rounded,
          color: Colors.redAccent,
          size: 22,
        ),
      ),
    );
  }
}
