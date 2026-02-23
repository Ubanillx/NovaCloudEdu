import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../config/app_theme.dart';

class PptDownloadCard extends StatefulWidget {
  final String url;
  final String? fileName;
  final AppColors colors;

  const PptDownloadCard({
    super.key,
    required this.url,
    this.fileName,
    required this.colors,
  });

  @override
  State<PptDownloadCard> createState() => _PptDownloadCardState();
}

class _PptDownloadCardState extends State<PptDownloadCard> {
  bool _isDownloading = false;
  double _progress = 0;
  String? _localPath;

  Future<void> _download() async {
    if (_isDownloading) return;

    // 如果已下载，直接打开
    if (_localPath != null && await File(_localPath!).exists()) {
      await OpenFilex.open(_localPath!);
      return;
    }

    setState(() {
      _isDownloading = true;
      _progress = 0;
    });

    try {
      final dir = await getTemporaryDirectory();
      final fileName = widget.fileName ?? 'presentation.pptx';
      final filePath = '${dir.path}/$fileName';

      await Dio().download(
        widget.url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            setState(() => _progress = received / total);
          }
        },
      );

      setState(() {
        _localPath = filePath;
        _isDownloading = false;
      });

      await OpenFilex.open(filePath);
    } catch (e) {
      setState(() => _isDownloading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('下载失败: $e'), backgroundColor: AppTheme.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.colors;
    final displayName = widget.fileName ?? 'PPT 文件';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // AI 头像
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppTheme.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(PhosphorIcons.checkCircle(PhosphorIconsStyle.fill), size: 18, color: AppTheme.green),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.green.withValues(alpha: 0.2)),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.green.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppTheme.green.withValues(alpha: 0.12), AppTheme.teal.withValues(alpha: 0.08)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(PhosphorIcons.fileDoc(PhosphorIconsStyle.fill), size: 22, color: AppTheme.green),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: colors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'PPT 生成完毕！',
                            style: TextStyle(fontSize: 12, color: AppTheme.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // 下载进度条
                if (_isDownloading)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: _progress,
                        minHeight: 4,
                        backgroundColor: colors.divider,
                        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.green),
                      ),
                    ),
                  ),
                // 操作按钮
                Row(
                  children: [
                    Expanded(
                      child: _buildButton(
                        icon: _isDownloading
                            ? PhosphorIcons.hourglassMedium()
                            : (_localPath != null ? PhosphorIcons.arrowSquareOut() : PhosphorIcons.downloadSimple()),
                        label: _isDownloading
                            ? '下载中 ${(_progress * 100).toInt()}%'
                            : (_localPath != null ? '打开文件' : '下载文件'),
                        isPrimary: true,
                        onTap: _download,
                        colors: colors,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
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
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            gradient: isPrimary
                ? const LinearGradient(
                    colors: [Color(0xFF10B981), Color(0xFF059669)],
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
                      color: AppTheme.green.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 17, color: isPrimary ? Colors.white : colors.textSecondary),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
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
