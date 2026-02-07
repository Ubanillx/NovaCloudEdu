import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:open_filex/open_filex.dart';
import '../../../config/app_theme.dart';
import '../services/audio_service.dart';
import '../services/file_cache_service.dart';

/// 消息类型
enum MessageType {
  text,
  image,
  file,
  audio,
  video,
}

/// 消息内容组件 - 根据消息类型显示不同内容
class MessageContentWidget extends StatelessWidget {
  final String content;
  final String type;
  final bool isMe;
  final AppColors colors;

  const MessageContentWidget({
    super.key,
    required this.content,
    required this.type,
    required this.isMe,
    required this.colors,
  });

  MessageType get messageType {
    switch (type.toUpperCase()) {
      case 'IMAGE':
        return MessageType.image;
      case 'FILE':
        return MessageType.file;
      case 'AUDIO':
        return MessageType.audio;
      case 'VIDEO':
        return MessageType.video;
      default:
        return MessageType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (messageType) {
      case MessageType.image:
        return _buildImageMessage(context);
      case MessageType.file:
        return _buildFileMessage(context);
      case MessageType.audio:
        return _buildAudioMessage(context);
      case MessageType.video:
        return _buildVideoMessage(context);
      case MessageType.text:
        return _buildTextMessage();
    }
  }

  Widget _buildTextMessage() {
    return Text(
      content,
      style: TextStyle(
        fontSize: 15,
        color: isMe ? Colors.white : colors.textPrimary,
        height: 1.4,
      ),
    );
  }

  Widget _buildImageMessage(BuildContext context) {
    return GestureDetector(
      onTap: () => _showImagePreview(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 200,
            maxHeight: 200,
          ),
          child: CachedNetworkImage(
            imageUrl: content,
            cacheManager: ChatFileCacheManager.instance.cacheManager,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              width: 150,
              height: 150,
              color: colors.background,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppTheme.brand,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              width: 150,
              height: 100,
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.broken_image, color: colors.textTertiary, size: 32),
                  const SizedBox(height: 4),
                  Text(
                    '图片加载失败',
                    style: TextStyle(fontSize: 12, color: colors.textTertiary),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showImagePreview(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ImagePreviewPage(imageUrl: content),
      ),
    );
  }

  Widget _buildFileMessage(BuildContext context) {
    // 解析文件信息 (格式: fileName|fileUrl|fileSize 或直接是URL)
    String fileName;
    String fileUrl;
    String fileSize = '';
    
    if (content.contains('|')) {
      final parts = content.split('|');
      fileName = parts.isNotEmpty ? parts[0] : '未知文件';
      fileUrl = parts.length > 1 ? parts[1] : content;
      fileSize = parts.length > 2 ? parts[2] : '';
    } else {
      // 直接是URL，从 URL 提取文件名
      fileUrl = content;
      fileName = Uri.parse(content).pathSegments.isNotEmpty 
          ? Uri.parse(content).pathSegments.last 
          : '未知文件';
    }
    
    final fileInfo = _getFileInfo(fileName);

    return FileMessageWidget(
      fileName: fileName,
      fileUrl: fileUrl,
      fileSize: fileSize,
      fileIcon: fileInfo.icon,
      fileColor: fileInfo.color,
      isMe: isMe,
      colors: colors,
    );
  }

  /// 获取文件信息（图标和颜色）
  _FileInfo _getFileInfo(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();
    switch (ext) {
      case 'pdf':
        return _FileInfo(Icons.picture_as_pdf, const Color(0xFFE53935));
      case 'doc':
      case 'docx':
        return _FileInfo(Icons.description, const Color(0xFF2196F3));
      case 'xls':
      case 'xlsx':
        return _FileInfo(Icons.table_chart, const Color(0xFF4CAF50));
      case 'ppt':
      case 'pptx':
        return _FileInfo(Icons.slideshow, const Color(0xFFFF9800));
      case 'txt':
      case 'md':
        return _FileInfo(Icons.article, const Color(0xFF607D8B));
      case 'zip':
      case 'rar':
      case '7z':
        return _FileInfo(Icons.folder_zip, const Color(0xFF795548));
      case 'mp3':
      case 'wav':
      case 'aac':
      case 'm4a':
        return _FileInfo(Icons.audio_file, const Color(0xFF1989FA));
      case 'mp4':
      case 'avi':
      case 'mov':
      case 'mkv':
        return _FileInfo(Icons.video_file, const Color(0xFFE91E63));
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'webp':
        return _FileInfo(Icons.image, const Color(0xFF00BCD4));
      default:
        return _FileInfo(Icons.insert_drive_file, const Color(0xFF9E9E9E));
    }
  }

  Widget _buildAudioMessage(BuildContext context) {
    // 解析音频信息 (格式: audioUrl|duration)
    final parts = content.split('|');
    final audioUrl = parts.isNotEmpty ? parts[0] : content;
    final duration = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;

    return AudioMessageWidget(
      audioUrl: audioUrl,
      duration: duration,
      isMe: isMe,
      colors: colors,
    );
  }

  Widget _buildVideoMessage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: 播放视频
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 200,
              height: 150,
              color: Colors.black,
              child: Icon(
                Icons.videocam,
                color: Colors.white54,
                size: 48,
              ),
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.black54,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}

/// 音频消息组件
class AudioMessageWidget extends StatefulWidget {
  final String audioUrl;
  final int duration;
  final bool isMe;
  final AppColors colors;

  const AudioMessageWidget({
    super.key,
    required this.audioUrl,
    required this.duration,
    required this.isMe,
    required this.colors,
  });

  @override
  State<AudioMessageWidget> createState() => _AudioMessageWidgetState();
}

class _AudioMessageWidgetState extends State<AudioMessageWidget> {
  final _audioService = AudioService();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioService.playingState.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = _audioService.isPlaying(widget.audioUrl);
        });
      }
    });
  }

  void _togglePlay() {
    if (_isPlaying) {
      _audioService.stop();
    } else {
      _audioService.play(widget.audioUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = 80.0 + (widget.duration * 4).clamp(0, 120).toDouble();

    return GestureDetector(
      onTap: _togglePlay,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: widget.isMe ? Colors.white : AppTheme.brand,
              size: 24,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                children: List.generate(
                  4,
                  (index) => Expanded(
                    child: Container(
                      height: 4 + (index % 2 == 0 ? 8 : 4).toDouble(),
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: widget.isMe
                            ? Colors.white.withOpacity(0.6)
                            : AppTheme.brand.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${widget.duration}"',
              style: TextStyle(
                fontSize: 12,
                color: widget.isMe ? Colors.white70 : widget.colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 文件信息类
class _FileInfo {
  final IconData icon;
  final Color color;
  
  _FileInfo(this.icon, this.color);
}

/// 文件消息组件
class FileMessageWidget extends StatefulWidget {
  final String fileName;
  final String fileUrl;
  final String fileSize;
  final IconData fileIcon;
  final Color fileColor;
  final bool isMe;
  final AppColors colors;

  const FileMessageWidget({
    super.key,
    required this.fileName,
    required this.fileUrl,
    required this.fileSize,
    required this.fileIcon,
    required this.fileColor,
    required this.isMe,
    required this.colors,
  });

  @override
  State<FileMessageWidget> createState() => _FileMessageWidgetState();
}

class _FileMessageWidgetState extends State<FileMessageWidget> {
  bool _isDownloading = false;
  double _downloadProgress = 0;

  Future<void> _downloadAndOpenFile() async {
    if (_isDownloading) return;

    setState(() {
      _isDownloading = true;
      _downloadProgress = 0;
    });

    try {
      // 使用缓存服务下载到持久化目录
      final filePath = await ChatFileCacheManager.instance.downloadToPersistent(
        widget.fileUrl,
        widget.fileName,
      );

      // 打开文件
      await OpenFilex.open(filePath);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('文件打开失败: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isDownloading = false);
      }
    }
  }

  String _formatFileSize(String size) {
    if (size.isEmpty) return '';
    final bytes = int.tryParse(size);
    if (bytes == null) return size;
    
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _downloadAndOpenFile,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.isMe ? Colors.white.withOpacity(0.15) : widget.colors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.isMe ? Colors.white.withOpacity(0.2) : widget.colors.border,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 文件图标
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: widget.fileColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _isDownloading
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: _downloadProgress,
                          strokeWidth: 2,
                          color: widget.fileColor,
                        ),
                        Text(
                          '${(_downloadProgress * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 10,
                            color: widget.fileColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : Icon(
                      widget.fileIcon,
                      color: widget.fileColor,
                      size: 24,
                    ),
            ),
            const SizedBox(width: 12),
            // 文件信息
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.fileName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: widget.isMe ? Colors.white : widget.colors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.fileSize.isNotEmpty)
                        Text(
                          _formatFileSize(widget.fileSize),
                          style: TextStyle(
                            fontSize: 12,
                            color: widget.isMe ? Colors.white60 : widget.colors.textTertiary,
                          ),
                        ),
                      if (widget.fileSize.isNotEmpty)
                        Text(
                          ' · ',
                          style: TextStyle(
                            fontSize: 12,
                            color: widget.isMe ? Colors.white60 : widget.colors.textTertiary,
                          ),
                        ),
                      Text(
                        '点击预览',
                        style: TextStyle(
                          fontSize: 12,
                          color: widget.isMe ? Colors.white60 : AppTheme.brand,
                        ),
                      ),
                    ],
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

/// 图片预览页面
class ImagePreviewPage extends StatelessWidget {
  final String imageUrl;

  const ImagePreviewPage({super.key, required this.imageUrl});

  Future<void> _saveImage(BuildContext context) async {
    try {
      final fileName = Uri.parse(imageUrl).pathSegments.isNotEmpty
          ? Uri.parse(imageUrl).pathSegments.last
          : 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await ChatFileCacheManager.instance.downloadToPersistent(imageUrl, fileName);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('图片已保存')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('保存失败: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Colors.white),
            onPressed: () => _saveImage(context),
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            cacheManager: ChatFileCacheManager.instance.cacheManager,
            fit: BoxFit.contain,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
            errorWidget: (context, url, error) => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.broken_image, color: Colors.white54, size: 64),
                  SizedBox(height: 16),
                  Text(
                    '图片加载失败',
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
