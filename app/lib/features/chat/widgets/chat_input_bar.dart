import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../../../config/app_theme.dart';
import '../../../services/file_upload_service.dart';
import '../../../widgets/toast/nova_message.dart';
import '../services/audio_service.dart';

/// 聊天输入栏
class ChatInputBar extends StatefulWidget {
  final Function(String content, String type) onSend;
  final VoidCallback? onTyping;

  const ChatInputBar({
    super.key,
    required this.onSend,
    this.onTyping,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final _messageController = TextEditingController();
  final _fileUploadService = FileUploadService();
  final _audioService = AudioService();
  
  bool _isSending = false;
  bool _isRecording = false;
  bool _showMorePanel = false;
  int _recordingDuration = 0;
  
  StreamSubscription<int>? _durationSubscription;

  @override
  void initState() {
    super.initState();
    _audioService.init();
    _durationSubscription = _audioService.recordingDuration.listen((duration) {
      if (mounted) {
        setState(() => _recordingDuration = duration);
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _durationSubscription?.cancel();
    super.dispose();
  }

  Future<void> _sendTextMessage() async {
    final content = _messageController.text.trim();
    if (content.isEmpty || _isSending) return;

    setState(() => _isSending = true);
    _messageController.clear();

    try {
      widget.onSend(content, 'TEXT');
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      XFile? file;
      if (source == ImageSource.gallery) {
        file = await _fileUploadService.pickImageFromGallery();
      } else {
        file = await _fileUploadService.pickImageFromCamera();
      }

      if (file == null) return;

      setState(() => _isSending = true);
      _hideMorePanel();

      final result = await _fileUploadService.uploadFile(file, 'chat/file');
      if (result?.fileUrl != null) {
        widget.onSend(result!.fileUrl!, 'IMAGE');
      } else {
        if (mounted) {
          NovaMessage.error(context, '图片上传失败');
        }
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '图片上传失败');
      }
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) return;

      final file = result.files.first;
      if (file.path == null) return;

      setState(() => _isSending = true);
      _hideMorePanel();

      final xFile = XFile(file.path!);
      final uploadResult = await _fileUploadService.uploadFile(xFile, 'chat/file');
      
      if (uploadResult?.fileUrl != null) {
        // 格式: fileName|fileUrl|fileSize
        final fileSize = _formatFileSize(file.size);
        final content = '${file.name}|${uploadResult!.fileUrl}|$fileSize';
        widget.onSend(content, 'FILE');
      } else {
        if (mounted) {
          NovaMessage.error(context, '文件上传失败');
        }
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '文件上传失败');
      }
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  Future<void> _startRecording() async {
    final started = await _audioService.startRecording();
    if (started) {
      setState(() {
        _isRecording = true;
        _recordingDuration = 0;
      });
    } else {
      if (mounted) {
        NovaMessage.error(context, '无法开始录音，请检查麦克风权限');
      }
    }
  }

  Future<void> _stopRecording() async {
    if (!_isRecording) return;

    final path = await _audioService.stopRecording();
    setState(() => _isRecording = false);

    if (path == null || _recordingDuration < 1) {
      if (mounted) {
        NovaMessage.show(context, '录音时间太短');
      }
      return;
    }

    // 上传录音文件
    setState(() => _isSending = true);
    try {
      final file = XFile(path);
      final result = await _fileUploadService.uploadFile(file, 'chat/file');
      
      if (result?.fileUrl != null) {
        // 格式: audioUrl|duration
        final content = '${result!.fileUrl}|$_recordingDuration';
        widget.onSend(content, 'AUDIO');
      } else {
        if (mounted) {
          NovaMessage.error(context, '语音上传失败');
        }
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '语音上传失败');
      }
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
      // 删除本地临时文件
      try {
        await File(path).delete();
      } catch (_) {}
    }
  }

  Future<void> _cancelRecording() async {
    await _audioService.cancelRecording();
    setState(() => _isRecording = false);
  }

  void _toggleMorePanel() {
    setState(() => _showMorePanel = !_showMorePanel);
  }

  void _hideMorePanel() {
    if (_showMorePanel) {
      setState(() => _showMorePanel = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 主输入栏
        Container(
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 8,
            bottom: _showMorePanel ? 8 : bottomPadding + 8,
          ),
          decoration: BoxDecoration(
            color: colors.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: _isRecording ? _buildRecordingBar(colors) : _buildInputBar(colors),
        ),
        // 更多功能面板
        if (_showMorePanel) _buildMorePanel(colors, bottomPadding),
      ],
    );
  }

  Widget _buildInputBar(AppColors colors) {
    return Row(
      children: [
        // 语音按钮
        IconButton(
          icon: Icon(Icons.mic_none, color: colors.textSecondary),
          onPressed: _startRecording,
        ),
        // 输入框
        Expanded(
          child: Container(
            constraints: const BoxConstraints(maxHeight: 100),
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: _messageController,
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendTextMessage(),
              onChanged: (_) => widget.onTyping?.call(),
              decoration: InputDecoration(
                hintText: '输入消息...',
                hintStyle: TextStyle(color: colors.textTertiary),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
            ),
          ),
        ),
        // 更多功能按钮
        IconButton(
          icon: Icon(
            _showMorePanel ? Icons.keyboard : Icons.add_circle_outline,
            color: colors.textSecondary,
          ),
          onPressed: _toggleMorePanel,
        ),
        // 发送按钮
        GestureDetector(
          onTap: _sendTextMessage,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.brand,
              borderRadius: BorderRadius.circular(20),
            ),
            child: _isSending
                ? const Padding(
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.send, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildRecordingBar(AppColors colors) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          // 取消按钮
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: _cancelRecording,
          ),
          // 录音动画和时长
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _formatDuration(_recordingDuration),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '录音中...',
                  style: TextStyle(
                    fontSize: 14,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // 发送按钮
          GestureDetector(
            onTap: _stopRecording,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.brand,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Widget _buildMorePanel(AppColors colors, double bottomPadding) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: bottomPadding + 16,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMoreItem(
            icon: Icons.photo_library,
            label: '相册',
            onTap: () => _pickImage(ImageSource.gallery),
            colors: colors,
          ),
          _buildMoreItem(
            icon: Icons.camera_alt,
            label: '拍照',
            onTap: () => _pickImage(ImageSource.camera),
            colors: colors,
          ),
          _buildMoreItem(
            icon: Icons.insert_drive_file,
            label: '文件',
            onTap: _pickFile,
            colors: colors,
          ),
        ],
      ),
    );
  }

  Widget _buildMoreItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required AppColors colors,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: colors.textSecondary, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
