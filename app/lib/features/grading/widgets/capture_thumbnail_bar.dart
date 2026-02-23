import 'dart:io';
import 'package:flutter/material.dart';

/// 底部拍照操作栏
/// 包含: 相册入口 | 拍照按钮 | 已拍缩略图 + 完成按钮
class CaptureThumbnailBar extends StatelessWidget {
  final VoidCallback onCapture;
  final VoidCallback onGallery;
  final VoidCallback onComplete;
  final ValueChanged<int> onThumbnailTap;
  final List<File> capturedImages;
  final int maxImages;
  final bool isCapturing;

  const CaptureThumbnailBar({
    super.key,
    required this.onCapture,
    required this.onGallery,
    required this.onComplete,
    required this.onThumbnailTap,
    required this.capturedImages,
    this.maxImages = 10,
    this.isCapturing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 12, 20, MediaQuery.of(context).padding.bottom + 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black54, Colors.black87],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 缩略图滚动条
          if (capturedImages.isNotEmpty)
            Container(
              height: 56,
              margin: const EdgeInsets.only(bottom: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: capturedImages.length,
                itemBuilder: (_, i) => _buildThumbnail(capturedImages[i], i),
              ),
            ),
          // 操作行
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 相册入口
              _buildGalleryButton(),
              // 拍照按钮
              _buildCaptureButton(),
              // 完成按钮
              _buildCompleteButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnail(File file, int index) {
    return GestureDetector(
      onTap: () => onThumbnailTap(index),
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white38, width: 1.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Image.file(
            file,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey[800],
              child: const Icon(Icons.image, color: Colors.white38, size: 20),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGalleryButton() {
    return GestureDetector(
      onTap: onGallery,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
        ),
        child: const Icon(Icons.photo_library_outlined, color: Colors.white, size: 22),
      ),
    );
  }

  Widget _buildCaptureButton() {
    final canCapture = capturedImages.length < maxImages && !isCapturing;

    return GestureDetector(
      onTap: canCapture ? onCapture : null,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
        ),
        padding: const EdgeInsets.all(4),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCapturing
                ? Colors.white60
                : canCapture
                    ? Colors.white
                    : Colors.white30,
          ),
          child: isCapturing
              ? const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black54),
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildCompleteButton() {
    final hasImages = capturedImages.isNotEmpty;

    return GestureDetector(
      onTap: hasImages ? onComplete : null,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: hasImages ? const Color(0xFF6366F1) : Colors.white12,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.check,
              color: hasImages ? Colors.white : Colors.white38,
              size: 22,
            ),
            if (hasImages)
              Positioned(
                top: 2,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${capturedImages.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
