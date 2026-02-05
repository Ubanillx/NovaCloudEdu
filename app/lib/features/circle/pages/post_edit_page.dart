import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:nova_api/nova_api.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import '../../../config/app_theme.dart';
import '../../../services/file_upload_service.dart';
import '../../../widgets/toast/nova_message.dart';
import '../services/post_service.dart';

/// 发布/编辑帖子页面
class PostEditPage extends StatefulWidget {
  final int? postId;
  final PostDetailResponse? post;

  const PostEditPage({
    super.key,
    this.postId,
    this.post,
  });

  @override
  State<PostEditPage> createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {
  final PostService _postService = PostService();
  final FileUploadService _fileUploadService = FileUploadService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final List<String> _tags = [];
  bool _isLoading = false;
  bool _isUploading = false;
  bool _isPreviewMode = false;
  bool _isFullscreen = false;
  bool get _isEdit => widget.postId != null;

  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      _titleController.text = widget.post!.title ?? '';
      _contentController.text = widget.post!.content ?? '';
      if (widget.post!.tags != null) {
        _tags.addAll(widget.post!.tags!.toList());
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty && !_tags.contains(tag) && _tags.length < 5) {
      setState(() {
        _tags.add(tag);
        _tagController.clear();
      });
    } else if (_tags.length >= 5) {
      NovaMessage.warning(context, '最多添加5个标签');
    } else if (_tags.contains(tag)) {
      NovaMessage.warning(context, '标签已存在');
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  void _togglePreview() {
    setState(() {
      _isPreviewMode = !_isPreviewMode;
    });
  }

  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
    });
  }

  Future<void> _pickAndUploadImage() async {
    final colors = context.colors;
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppTheme.brand),
              title: Text('从相册选择', style: TextStyle(color: colors.textPrimary)),
              onTap: () {
                Navigator.pop(context);
                _uploadFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppTheme.brand),
              title: Text('拍照', style: TextStyle(color: colors.textPrimary)),
              onTap: () {
                Navigator.pop(context);
                _uploadFromCamera();
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadFromGallery() async {
    final file = await _fileUploadService.pickImageFromGallery();
    if (file != null) {
      await _uploadImage(file);
    }
  }

  Future<void> _uploadFromCamera() async {
    final file = await _fileUploadService.pickImageFromCamera();
    if (file != null) {
      await _uploadImage(file);
    }
  }

  Future<void> _uploadImage(dynamic file) async {
    setState(() => _isUploading = true);
    try {
      final markdownLink = await _fileUploadService.uploadImageForMarkdown(file);
      if (markdownLink != null && mounted) {
        final currentText = _contentController.text;
        final selection = _contentController.selection;
        final newText = '${currentText.substring(0, selection.baseOffset)}\n$markdownLink\n${currentText.substring(selection.extentOffset)}';
        _contentController.text = newText;
        _contentController.selection = TextSelection.collapsed(
          offset: selection.baseOffset + markdownLink.length + 2,
        );
        NovaMessage.success(context, '图片上传成功');
      } else if (mounted) {
        NovaMessage.error(context, '图片上传失败');
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '图片上传失败: $e');
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty) {
      NovaMessage.warning(context, '请输入标题');
      return;
    }

    if (content.isEmpty) {
      NovaMessage.warning(context, '请输入内容');
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (_isEdit) {
        final success = await _postService.updatePost(
          postId: widget.postId!,
          title: title,
          content: content,
          tags: _tags,
        );
        if (success && mounted) {
          NovaMessage.success(context, '更新成功');
          Navigator.pop(context, true);
        }
      } else {
        final post = await _postService.createPost(
          title: title,
          content: content,
          tags: _tags,
        );
        if (post != null && mounted) {
          NovaMessage.success(context, '发布成功');
          Navigator.pop(context, true);
        }
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '操作失败: $e');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
          icon: Icon(Icons.close, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _isEdit ? '编辑帖子' : '发布帖子',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: TDButton(
                text: _isEdit ? '保存' : '发布',
                size: TDButtonSize.small,
                type: TDButtonType.fill,
                theme: TDButtonTheme.primary,
                width: 64,
                height: 32,
                icon: _isLoading ? TDIcons.loading : null,
                onTap: _submit,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _isFullscreen
                ? _buildFullscreenEditor()
                : _buildNormalEditor(),
          ),
          // 工具栏
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border(
                top: BorderSide(color: colors.border),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.05),
                  offset: const Offset(0, -2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildToolbarButton(
                    icon: Icons.image,
                    label: '图片',
                    onTap: _pickAndUploadImage,
                    isLoading: _isUploading,
                  ),
                  _buildToolbarButton(
                    icon: _isPreviewMode ? Icons.edit : Icons.preview,
                    label: _isPreviewMode ? '编辑' : '预览',
                    onTap: _togglePreview,
                  ),
                  _buildToolbarButton(
                    icon: _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                    label: _isFullscreen ? '退出' : '全屏',
                    onTap: _toggleFullscreen,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNormalEditor() {
    final colors = context.colors;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题输入
          TextField(
            controller: _titleController,
            maxLength: 50,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.3,
              color: colors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: '请输入标题',
              hintStyle: TextStyle(
                color: colors.textTertiary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              border: InputBorder.none,
              counterText: '',
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 20),
          
          // 内容区域（编辑或预览）
          _buildContentArea(minLines: 15),
          
          const SizedBox(height: 30),
          Divider(height: 1, color: colors.border),
          const SizedBox(height: 20),

          // 标签区域
          Row(
            children: [
              const Icon(Icons.tag, size: 20, color: AppTheme.brand),
              const SizedBox(width: 8),
              Text(
                '添加标签',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '(${_tags.length}/5)',
                style: TextStyle(
                  fontSize: 14,
                  color: colors.textTertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // 标签输入
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: colors.surfaceVariant,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _tagController,
                    decoration: InputDecoration(
                      hintText: '输入标签话题',
                      hintStyle: TextStyle(fontSize: 14, color: colors.textTertiary),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(bottom: 10),
                    ),
                    style: TextStyle(fontSize: 14, color: colors.textPrimary),
                    onSubmitted: (_) => _addTag(),
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              TDButton(
                text: '添加',
                size: TDButtonSize.small,
                type: TDButtonType.outline,
                theme: TDButtonTheme.primary,
                onTap: _addTag,
              ),
            ],
          ),
          
          if (_tags.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _tags.map((tag) => _buildTagChip(tag)).toList(),
            ),
          ],
          
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildFullscreenEditor() {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: _buildContentArea(minLines: 20, expanded: true),
          ),
        ),
      ],
    );
  }

  Widget _buildContentArea({int minLines = 8, bool expanded = false}) {
    final colors = context.colors;
    // 计算最小高度：行数 * 行高(16 * 1.6)
    final minHeight = minLines * 16.0 * 1.6;
    
    if (_isPreviewMode) {
      // Markdown 预览
      final content = _contentController.text.isEmpty
          ? Text(
              '暂无内容',
              style: TextStyle(
                color: colors.textTertiary,
                fontSize: 16,
              ),
            )
          : MarkdownWidget(
              data: _contentController.text,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              config: MarkdownConfig(
                configs: [
                  PConfig(textStyle: TextStyle(fontSize: 16, height: 1.6, color: colors.textPrimary)),
                  ImgConfig(builder: (url, attributes) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: colors.surfaceVariant,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.broken_image, color: colors.textTertiary),
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            );
      
      if (expanded) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: minHeight),
            child: content,
          ),
        );
      }
      return ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: content,
      );
    } else {
      // 内容输入
      final colors = context.colors;
      return TextField(
        controller: _contentController,
        maxLines: expanded ? null : null,
        minLines: expanded ? null : minLines,
        maxLength: 2000,
        expands: expanded,
        textAlignVertical: expanded ? TextAlignVertical.top : null,
        style: TextStyle(
          fontSize: 16,
          height: 1.6,
          color: colors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: '分享你的想法...',
          hintStyle: TextStyle(
            color: colors.textTertiary,
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          counterText: '',
        ),
      );
    }
  }

  Widget _buildToolbarButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isLoading = false,
  }) {
    final colors = context.colors;
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading)
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              Icon(icon, size: 20, color: AppTheme.brand),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: colors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagChip(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.brand.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '#$tag',
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.brand,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () => _removeTag(tag),
            child: const Icon(
              Icons.close,
              size: 14,
              color: AppTheme.brand,
            ),
          ),
        ],
      ),
    );
  }
}
