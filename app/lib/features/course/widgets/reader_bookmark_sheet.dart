import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:nova_api/nova_api.dart';
import '../services/book_service.dart';
import 'reader_settings_sheet.dart';

/// 书签管理底部面板
class ReaderBookmarkSheet extends StatefulWidget {
  final int bookId;
  final int userId;
  final List<ReadingBookmarkDTO> bookmarks;
  final ReaderThemeColors themeColors;
  final ValueChanged<int> onGoToChapter;
  final VoidCallback onRefresh;

  const ReaderBookmarkSheet({
    super.key,
    required this.bookId,
    required this.userId,
    required this.bookmarks,
    required this.themeColors,
    required this.onGoToChapter,
    required this.onRefresh,
  });

  @override
  State<ReaderBookmarkSheet> createState() => _ReaderBookmarkSheetState();
}

class _ReaderBookmarkSheetState extends State<ReaderBookmarkSheet> {
  final BookService _bookService = BookService();
  late List<ReadingBookmarkDTO> _bookmarks;

  ReaderThemeColors get tc => widget.themeColors;

  @override
  void initState() {
    super.initState();
    _bookmarks = List.from(widget.bookmarks);
  }

  Future<void> _deleteBookmark(ReadingBookmarkDTO bookmark) async {
    if (bookmark.id == null) return;
    try {
      await _bookService.deleteBookmark(widget.bookId, bookmark.id!);
      setState(() => _bookmarks.removeWhere((b) => b.id == bookmark.id));
      widget.onRefresh();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('删除书签失败: $e'), backgroundColor: Colors.red[400]),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: tc.bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // 拖拽条
          Center(
            child: Container(
              width: 36, height: 4,
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: tc.muted.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // 标题
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              children: [
                Icon(PhosphorIcons.bookmark(PhosphorIconsStyle.fill), size: 18, color: tc.accent),
                const SizedBox(width: 8),
                Text('书签', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: tc.text)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: tc.card,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${_bookmarks.length}',
                    style: TextStyle(fontSize: 11, color: tc.muted, fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(PhosphorIcons.x(), size: 20, color: tc.muted),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: tc.border),
          // 书签列表
          Expanded(
            child: _bookmarks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(PhosphorIcons.bookmark(), size: 48, color: tc.muted.withValues(alpha: 0.3)),
                        const SizedBox(height: 8),
                        Text('暂无书签', style: TextStyle(fontSize: 14, color: tc.muted.withValues(alpha: 0.5))),
                        Text('在阅读时点击书签按钮添加', style: TextStyle(fontSize: 12, color: tc.muted.withValues(alpha: 0.4))),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _bookmarks.length,
                    separatorBuilder: (_, __) => Divider(height: 1, indent: 16, endIndent: 16, color: tc.border),
                    itemBuilder: (context, index) => _buildBookmarkItem(_bookmarks[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookmarkItem(ReadingBookmarkDTO bookmark) {
    return Dismissible(
      key: ValueKey(bookmark.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red[400],
        child: Icon(PhosphorIcons.trash(), color: Colors.white),
      ),
      onDismissed: (_) => _deleteBookmark(bookmark),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        leading: Container(
          width: 36, height: 36,
          decoration: BoxDecoration(
            color: tc.accent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(PhosphorIcons.bookmark(PhosphorIconsStyle.fill), size: 18, color: tc.accent),
        ),
        title: Text(
          bookmark.bookmarkTitle ?? '书签',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: tc.text),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (bookmark.note != null && bookmark.note!.isNotEmpty)
              Text(
                bookmark.note!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: tc.muted),
              ),
            Text(
              '第 ${(bookmark.chapterIndex ?? 0) + 1} 章',
              style: TextStyle(fontSize: 11, color: tc.muted.withValues(alpha: 0.6)),
            ),
          ],
        ),
        trailing: Icon(PhosphorIcons.caretRight(), size: 18, color: tc.muted),
        onTap: () {
          Navigator.pop(context);
          widget.onGoToChapter(bookmark.chapterIndex ?? 0);
        },
      ),
    );
  }
}

/// 添加书签对话框
Future<Map<String, String>?> showAddBookmarkDialog(BuildContext context, ReaderThemeColors tc) async {
  final titleController = TextEditingController();
  final noteController = TextEditingController();

  return showDialog<Map<String, String>>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: tc.bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Icon(PhosphorIcons.bookmarkSimple(), size: 20, color: tc.accent),
          const SizedBox(width: 8),
          Text('添加书签', style: TextStyle(fontSize: 16, color: tc.text)),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            style: TextStyle(fontSize: 14, color: tc.text),
            decoration: InputDecoration(
              hintText: '书签标题（可选）',
              hintStyle: TextStyle(color: tc.muted, fontSize: 14),
              filled: true,
              fillColor: tc.card,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: tc.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: tc.border),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: noteController,
            style: TextStyle(fontSize: 14, color: tc.text),
            maxLines: 3,
            decoration: InputDecoration(
              hintText: '备注（可选）',
              hintStyle: TextStyle(color: tc.muted, fontSize: 14),
              filled: true,
              fillColor: tc.card,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: tc.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: tc.border),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text('取消', style: TextStyle(color: tc.muted)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, {
            'title': titleController.text.trim(),
            'note': noteController.text.trim(),
          }),
          child: Text('添加', style: TextStyle(color: tc.accent, fontWeight: FontWeight.w600)),
        ),
      ],
    ),
  );
}
