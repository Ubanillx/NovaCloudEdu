import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../config/app_theme.dart';
import '../services/ppt_generation_service.dart';

class PptTemplateSelector extends StatefulWidget {
  final List<PptTemplate> templates;
  final bool isLoading;
  final ValueChanged<PptTemplate> onSelect;
  final Future<bool> Function(String filePath, String name)? onUploadTemplate;

  const PptTemplateSelector({
    super.key,
    required this.templates,
    this.isLoading = false,
    required this.onSelect,
    this.onUploadTemplate,
  });

  @override
  State<PptTemplateSelector> createState() => _PptTemplateSelectorState();
}

class _PptTemplateSelectorState extends State<PptTemplateSelector> {
  int _selectedIndex = -1;
  bool _isUploading = false;

  Future<void> _pickAndUpload() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pptx'],
    );
    if (result == null || result.files.isEmpty) return;
    final file = result.files.first;
    if (file.path == null) return;

    final name = file.name.replaceAll('.pptx', '');
    setState(() => _isUploading = true);
    try {
      final success = await widget.onUploadTemplate?.call(file.path!, name) ?? false;
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text('模板上传成功'), backgroundColor: AppTheme.green),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 拖拽条
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 6),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // 标题
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppTheme.brand.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(PhosphorIcons.swatches(PhosphorIconsStyle.fill), size: 16, color: AppTheme.brand),
                ),
                const SizedBox(width: 10),
                Text(
                  '选择 PPT 模板',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(PhosphorIcons.x(), color: colors.iconSecondary, size: 22),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Container(height: 0.5, color: colors.divider.withValues(alpha: 0.5)),
          // 上传按钮
          if (widget.onUploadTemplate != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
              child: _isUploading
                  ? const Center(child: Padding(padding: EdgeInsets.all(8), child: CircularProgressIndicator(strokeWidth: 2)))
                  : OutlinedButton.icon(
                      onPressed: _pickAndUpload,
                      icon: Icon(PhosphorIcons.uploadSimple(), size: 18),
                      label: const Text('上传自定义模板'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.brand,
                        side: BorderSide(color: AppTheme.brand.withValues(alpha: 0.4)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        minimumSize: const Size(double.infinity, 0),
                      ),
                    ),
            ),
          // 内容
          Flexible(
            child: widget.isLoading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : widget.templates.isEmpty
                    ? _buildEmptyState(colors)
                    : _buildGrid(colors),
          ),
          // 确认按钮
          if (_selectedIndex >= 0)
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, bottomPadding + 14),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF007BFF), Color(0xFF0069D9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.brand.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: FilledButton(
                    onPressed: () => widget.onSelect(widget.templates[_selectedIndex]),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text(
                      '使用此模板',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 0.3),
                    ),
                  ),
                ),
              ),
            ),
          if (_selectedIndex < 0) SizedBox(height: bottomPadding + 12),
        ],
      ),
    );
  }

  Widget _buildEmptyState(AppColors colors) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(PhosphorIcons.tray(), size: 40, color: colors.iconSecondary),
            const SizedBox(height: 12),
            Text('暂无可用模板', style: TextStyle(color: colors.textTertiary, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(AppColors colors) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: widget.templates.length,
      itemBuilder: (context, index) {
        final tpl = widget.templates[index];
        final isSelected = index == _selectedIndex;
        return _buildTemplateCard(tpl, isSelected, index, colors);
      },
    );
  }

  Widget _buildTemplateCard(PptTemplate tpl, bool isSelected, int index, AppColors colors) {
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.brand.withValues(alpha: 0.03) : colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.brand : colors.divider.withValues(alpha: 0.6),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppTheme.brand.withValues(alpha: 0.12)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: isSelected ? 12 : 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 封面图
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    tpl.coverUrl != null && tpl.coverUrl!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: tpl.coverUrl!,
                            fit: BoxFit.cover,
                            placeholder: (_, _) => Container(
                              color: colors.surfaceVariant,
                              child: Icon(PhosphorIcons.presentation(), size: 32, color: colors.iconSecondary),
                            ),
                            errorWidget: (_, _, _) => Container(
                              color: colors.surfaceVariant,
                              child: Icon(PhosphorIcons.imageBroken(), size: 32, color: colors.iconSecondary),
                            ),
                          )
                        : Container(
                            color: colors.surfaceVariant,
                            child: Icon(PhosphorIcons.presentation(), size: 32, color: colors.iconSecondary),
                          ),
                    if (isSelected)
                      Positioned(
                        top: 6,
                        right: 6,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: AppTheme.brand,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(PhosphorIcons.check(PhosphorIconsStyle.bold), size: 14, color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // 信息
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tpl.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? AppTheme.brand : colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${tpl.slideCount} 页',
                    style: TextStyle(fontSize: 11, color: colors.textTertiary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
