import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:nova_api/nova_api.dart';
import '../../../config/app_theme.dart';

/// 章节目录抽屉组件
class ChapterDrawer extends StatelessWidget {
  final List<ChapterDTO> chapters;
  final int currentIndex;
  final ValueChanged<int> onChapterSelected;

  const ChapterDrawer({
    super.key,
    required this.chapters,
    required this.currentIndex,
    required this.onChapterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Drawer(
      backgroundColor: colors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 头部
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Row(
                children: [
                  Icon(PhosphorIcons.list(), size: 20, color: AppTheme.brand),
                  const SizedBox(width: 8),
                  Text(
                    '目录',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${chapters.length}章',
                      style: TextStyle(fontSize: 11, color: colors.textSecondary, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: colors.divider),
            // 章节列表
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                itemCount: chapters.length,
                itemBuilder: (context, index) {
                  final chapter = chapters[index];
                  final isActive = index == currentIndex;
                  return _buildChapterItem(context, chapter, index, isActive, colors);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChapterItem(BuildContext context, ChapterDTO chapter, int index, bool isActive, AppColors colors) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onChapterSelected(index);
          Navigator.pop(context);
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? AppTheme.brand.withValues(alpha: 0.08) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: isActive
                ? Border.all(color: AppTheme.brand.withValues(alpha: 0.2), width: 1)
                : null,
          ),
          child: Row(
            children: [
              // 序号
              SizedBox(
                width: 28,
                child: Text(
                  '${index + 1}'.padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: isActive ? AppTheme.brand : colors.textSecondary.withValues(alpha: 0.5),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // 标题
              Expanded(
                child: Text(
                  chapter.title ?? '第 ${(chapter.chapterIndex ?? index) + 1} 章',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                    color: isActive ? AppTheme.brand : colors.textPrimary,
                  ),
                ),
              ),
              // 当前指示器
              if (isActive)
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppTheme.brand,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
