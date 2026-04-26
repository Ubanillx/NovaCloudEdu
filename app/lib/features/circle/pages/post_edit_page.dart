import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:nova_api/nova_api.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import '../../../config/app_theme.dart';
import '../../../services/file_upload_service.dart';
import '../../../widgets/toast/nova_message.dart';
import '../constants/post_types.dart';
import '../services/post_service.dart';

/// 发布/编辑帖子页面
class PostEditPage extends StatefulWidget {
  final int? postId;
  final PostDetailResponse? post;

  const PostEditPage({super.key, this.postId, this.post});

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
  String _selectedPostType = '';
  bool _isLoading = false;
  bool _isUploading = false;
  bool _isPreviewMode = false;
  bool _isFullscreen = false;
  bool _showEmojiPicker = false;
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
      _selectedPostType = widget.post!.postType ?? '';
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

  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });
  }

  void _onEmojiSelected(Emoji emoji) {
    final currentText = _contentController.text;
    final selection = _contentController.selection;
    final newText =
        currentText.substring(0, selection.baseOffset) +
        emoji.emoji +
        currentText.substring(selection.extentOffset);
    _contentController.text = newText;
    _contentController.selection = TextSelection.collapsed(
      offset: selection.baseOffset + emoji.emoji.length,
    );
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
              leading: Icon(PhosphorIcons.images(), color: AppTheme.brand),
              title: Text('从相册选择', style: TextStyle(color: colors.textPrimary)),
              onTap: () {
                Navigator.pop(context);
                _uploadFromGallery();
              },
            ),
            ListTile(
              leading: Icon(PhosphorIcons.camera(), color: AppTheme.brand),
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
      final markdownLink = await _fileUploadService.uploadImageForMarkdown(
        file,
      );
      if (markdownLink != null && mounted) {
        final currentText = _contentController.text;
        final selection = _contentController.selection;
        final newText =
            '${currentText.substring(0, selection.baseOffset)}\n$markdownLink\n${currentText.substring(selection.extentOffset)}';
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
    final content = _contentController.text.trim();

    if (content.isEmpty) {
      NovaMessage.warning(context, '请输入内容');
      return;
    }
    if (_selectedPostType.isEmpty) {
      NovaMessage.warning(context, '请选择帖子类型');
      return;
    }

    // 微博风格：内容第一行作为标题，如果没有换行则取前20字
    final lines = content.split('\n');
    final title = lines.first.length > 20
        ? '${lines.first.substring(0, 20)}...'
        : lines.first;

    setState(() => _isLoading = true);

    try {
      if (_isEdit) {
        final success = await _postService.updatePost(
          postId: widget.postId!,
          title: title,
          content: content,
          tags: _tags,
          postType: _selectedPostType,
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
          postType: _selectedPostType,
        );
        if (post != null && mounted) {
          NovaMessage.success(context, '发布成功');
          Navigator.pop(context, true);
        }
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '操作失败: \$e');
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
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            '取消',
            style: TextStyle(color: colors.textPrimary, fontSize: 16),
          ),
        ),
        leadingWidth: 80,
        title: Column(
          children: [
            Text(
              _isEdit ? '编辑帖子' : '发帖子',
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: GestureDetector(
                onTap: _isLoading ? null : _submit,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _isLoading ? colors.textTertiary : AppTheme.brand,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          _isEdit ? '保存' : '发布',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
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
                : _buildWeiboStyleEditor(),
          ),
          // 微博风格底部工具栏 - 卡片样式
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: _showEmojiPicker ? 8 : 12,
            ),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildIconButton(
                  icon: PhosphorIcons.image(),
                  onTap: _isUploading ? null : _pickAndUploadImage,
                ),
                _buildIconButton(
                  icon: PhosphorIcons.smiley(),
                  onTap: _toggleEmojiPicker,
                ),
                const Spacer(),
                _buildIconButton(
                  icon: _isFullscreen
                      ? PhosphorIcons.cornersIn()
                      : PhosphorIcons.cornersOut(),
                  onTap: () {
                    setState(() {
                      _isFullscreen = !_isFullscreen;
                    });
                  },
                ),
                if (_isPreviewMode)
                  _buildIconButton(
                    icon: PhosphorIcons.pencilSimple(),
                    onTap: _togglePreview,
                  )
                else
                  _buildIconButton(
                    icon: PhosphorIcons.eye(),
                    onTap: _togglePreview,
                  ),
              ],
            ),
          ),
          // 表情选择器
          if (_showEmojiPicker)
            SizedBox(
              height: 250,
              child: EmojiPicker(
                onEmojiSelected: (Category? category, Emoji emoji) {
                  _onEmojiSelected(emoji);
                },
                config: Config(
                  height: 250,
                  checkPlatformCompatibility: true,
                  emojiViewConfig: EmojiViewConfig(
                    emojiSizeMax: 28,
                    backgroundColor: colors.surface,
                    columns: 7,
                  ),
                  skinToneConfig: const SkinToneConfig(),
                  categoryViewConfig: CategoryViewConfig(
                    backgroundColor: colors.surface,
                    iconColor: colors.textTertiary,
                    iconColorSelected: AppTheme.brand,
                    indicatorColor: AppTheme.brand,
                  ),
                  bottomActionBarConfig: const BottomActionBarConfig(
                    enabled: false,
                  ),
                  searchViewConfig: SearchViewConfig(
                    backgroundColor: colors.surface,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWeiboStyleEditor() {
    final colors = context.colors;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPostTypeCard(),
          const SizedBox(height: 16),
          // 内容输入卡片
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: _buildContentArea(minLines: 14),
          ),
          const SizedBox(height: 16),
          // 标签卡片
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 标签区域
                if (_tags.isNotEmpty) ...[
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _tags.map((tag) => _buildTagChip(tag)).toList(),
                  ),
                  const SizedBox(height: 12),
                ],
                // 标签输入
                Row(
                  children: [
                    Icon(PhosphorIcons.hash(), size: 18, color: AppTheme.brand),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _tagController,
                        decoration: InputDecoration(
                          hintText: '添加标签话题 (${_tags.length}/5)',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: colors.textTertiary,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.textPrimary,
                        ),
                        onSubmitted: (_) => _addTag(),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    if (_tagController.text.isNotEmpty)
                      GestureDetector(
                        onTap: _addTag,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.brand,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            '添加',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildPostTypeCard() {
    final colors = context.colors;
    final label = getPostTypeLabel(_selectedPostType);

    return GestureDetector(
      onTap: _showPostTypeSheet,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(PhosphorIcons.tag(), size: 20, color: AppTheme.brand),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '帖子类型',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label.isEmpty ? '请选择帖子类型' : label,
                    style: TextStyle(
                      fontSize: 12,
                      color: label.isEmpty
                          ? colors.textTertiary
                          : AppTheme.brand,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              PhosphorIcons.caretRight(),
              size: 18,
              color: colors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  void _showPostTypeSheet() {
    final colors = context.colors;
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.border,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '选择帖子类型',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: postTypeOptions.length,
                  itemBuilder: (context, index) {
                    final option = postTypeOptions[index];
                    final selected = option.value == _selectedPostType;
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        option.label,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontWeight: selected
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                      trailing: selected
                          ? Icon(
                              PhosphorIcons.checkCircle(
                                PhosphorIconsStyle.fill,
                              ),
                              color: AppTheme.brand,
                            )
                          : null,
                      onTap: () {
                        setState(() => _selectedPostType = option.value);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTagChip(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.brand.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '#$tag',
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.brand,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () => _removeTag(tag),
            child: Icon(PhosphorIcons.x(), size: 12, color: AppTheme.brand),
          ),
        ],
      ),
    );
  }

  Widget _buildFullscreenEditor() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: _buildContentArea(minLines: 30, expanded: true),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(
          icon,
          size: 24,
          color: Colors.grey[600], // 使用灰色替代蓝色
        ),
      ),
    );
  }

  Widget _buildContentArea({int minLines = 8, bool expanded = false}) {
    final colors = context.colors;
    // 计算最小高度：行数 * 行高(16 * 1.6)
    final minHeight = minLines * 16.0 * 1.6;

    if (_isPreviewMode) {
      // Markdown 预览
      final content = _contentController.text.isEmpty
          ? SizedBox(
              width: double.infinity,
              child: Text(
                '暂无内容',
                style: TextStyle(color: colors.textTertiary, fontSize: 16),
              ),
            )
          : MarkdownWidget(
              data: _contentController.text,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              config: MarkdownConfig(
                configs: [
                  PConfig(
                    textStyle: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: colors.textPrimary,
                    ),
                  ),
                  ImgConfig(
                    builder: (url, attributes) {
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
                              child: Icon(
                                PhosphorIcons.imageBroken(),
                                color: colors.textTertiary,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
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
        style: TextStyle(fontSize: 16, height: 1.6, color: colors.textPrimary),
        decoration: InputDecoration(
          hintText: '分享新鲜事...',
          hintStyle: TextStyle(color: colors.textTertiary, fontSize: 16),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          counterText: '',
        ),
      );
    }
  }
}
