import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../config/app_theme.dart';

class PptOutlineCard extends StatefulWidget {
  final String markdown;
  final bool isConfirmed;
  final AppColors colors;
  final VoidCallback? onConfirm;
  final ValueChanged<String>? onRevise;
  final ValueChanged<String>? onOutlineEdited;

  const PptOutlineCard({
    super.key,
    required this.markdown,
    this.isConfirmed = false,
    required this.colors,
    this.onConfirm,
    this.onRevise,
    this.onOutlineEdited,
  });

  @override
  State<PptOutlineCard> createState() => _PptOutlineCardState();
}

class _PptOutlineCardState extends State<PptOutlineCard> {
  bool _showRevise = false;
  bool _isEditing = false;
  final _feedbackController = TextEditingController();
  late TextEditingController _editController;

  @override
  void initState() {
    super.initState();
    _editController = TextEditingController(text: widget.markdown);
  }

  @override
  void didUpdateWidget(covariant PptOutlineCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.markdown != widget.markdown && !_isEditing) {
      _editController.text = widget.markdown;
    }
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    _editController.dispose();
    super.dispose();
  }

  void _submitRevise() {
    final text = _feedbackController.text.trim();
    if (text.isEmpty || widget.onRevise == null) return;
    widget.onRevise!(text);
    _feedbackController.clear();
    setState(() => _showRevise = false);
  }

  void _saveEdit() {
    final edited = _editController.text.trim();
    if (edited.isEmpty || edited == widget.markdown) {
      setState(() => _isEditing = false);
      return;
    }
    widget.onOutlineEdited?.call(edited);
    setState(() => _isEditing = false);
  }

  void _cancelEdit() {
    _editController.text = widget.markdown;
    setState(() => _isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.colors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // AI 头像
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppTheme.brand.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(PhosphorIcons.sparkle(PhosphorIconsStyle.fill), size: 16, color: AppTheme.brand),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 大纲卡片
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: colors.divider.withValues(alpha: 0.6)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: _isEditing
                                ? AppTheme.purple.withValues(alpha: 0.1)
                                : AppTheme.brand.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            _isEditing ? PhosphorIcons.notepad() : PhosphorIcons.listBullets(),
                            size: 14,
                            color: _isEditing ? AppTheme.purple : AppTheme.brand,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _isEditing ? '编辑大纲' : 'AI 生成的大纲',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: colors.textSecondary,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const Spacer(),
                        if (!widget.isConfirmed && !_isEditing && !_showRevise)
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => setState(() => _isEditing = true),
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(PhosphorIcons.pencilSimpleLine(), size: 14, color: AppTheme.brand),
                                    const SizedBox(width: 4),
                                    Text('直接编辑', style: TextStyle(fontSize: 11, color: AppTheme.brand, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (_isEditing)
                      Column(
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxHeight: 300),
                            decoration: BoxDecoration(
                              color: colors.background,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppTheme.brand.withValues(alpha: 0.3)),
                            ),
                            child: TextField(
                              controller: _editController,
                              maxLines: null,
                              style: TextStyle(fontSize: 13, color: colors.textPrimary, fontFamily: 'monospace', height: 1.6),
                              decoration: InputDecoration(
                                hintText: '编辑 Markdown 大纲...',
                                hintStyle: TextStyle(color: colors.textTertiary),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _buildActionButton(
                                icon: PhosphorIcons.floppyDisk(),
                                label: '保存修改',
                                isPrimary: true,
                                onTap: _saveEdit,
                                colors: colors,
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: _cancelEdit,
                                child: Text('取消', style: TextStyle(fontSize: 13, color: colors.textTertiary)),
                              ),
                            ],
                          ),
                        ],
                      )
                    else
                      MarkdownBlock(
                        data: widget.markdown,
                        config: MarkdownConfig(
                          configs: [
                            H1Config(style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: colors.textPrimary)),
                            H2Config(style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: colors.textPrimary)),
                            H3Config(style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: colors.textSecondary)),
                            PConfig(textStyle: TextStyle(fontSize: 13, color: colors.textSecondary, height: 1.5)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // 操作按钮
              if (!widget.isConfirmed && !_showRevise)
                Row(
                  children: [
                    _buildActionButton(
                      icon: PhosphorIcons.check(),
                      label: '确认大纲',
                      isPrimary: true,
                      onTap: widget.onConfirm,
                      colors: colors,
                    ),
                    const SizedBox(width: 8),
                    _buildActionButton(
                      icon: PhosphorIcons.pencilSimple(),
                      label: '修改大纲',
                      isPrimary: false,
                      onTap: () => setState(() => _showRevise = true),
                      colors: colors,
                    ),
                  ],
                ),
              // 修改输入
              if (!widget.isConfirmed && _showRevise)
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colors.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: colors.divider),
                      ),
                      child: TextField(
                        controller: _feedbackController,
                        maxLines: 3,
                        style: TextStyle(fontSize: 14, color: colors.textPrimary),
                        decoration: InputDecoration(
                          hintText: '请描述你希望修改的内容...',
                          hintStyle: TextStyle(color: colors.textTertiary),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(12),
                        ),
                        autofocus: true,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildActionButton(
                          icon: PhosphorIcons.paperPlaneRight(),
                          label: '提交修改',
                          isPrimary: true,
                          onTap: _submitRevise,
                          colors: colors,
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => setState(() => _showRevise = false),
                          child: Text('取消', style: TextStyle(fontSize: 13, color: colors.textTertiary)),
                        ),
                      ],
                    ),
                  ],
                ),
              // 已确认标签
              if (widget.isConfirmed)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppTheme.green.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(PhosphorIcons.checkCircle(PhosphorIconsStyle.fill), size: 14, color: AppTheme.green),
                      const SizedBox(width: 6),
                      Text(
                        '大纲已确认',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.green),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required bool isPrimary,
    required AppColors colors,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            gradient: isPrimary
                ? const LinearGradient(
                    colors: [Color(0xFF007BFF), Color(0xFF0069D9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isPrimary ? null : colors.surface,
            borderRadius: BorderRadius.circular(12),
            border: isPrimary ? null : Border.all(color: colors.divider),
            boxShadow: isPrimary
                ? [
                    BoxShadow(
                      color: AppTheme.brand.withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 15, color: isPrimary ? Colors.white : colors.textSecondary),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isPrimary ? Colors.white : colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
