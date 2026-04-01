import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import '../services/camera_ocr_service.dart';

/// 图片裁切确认页
/// 使用 image_cropper 原生裁切，支持 ML Kit 智能裁切建议
class ImageCropPage extends StatefulWidget {
  final File imageFile;
  final List<TextBlock> detectedBlocks;

  const ImageCropPage({
    super.key,
    required this.imageFile,
    this.detectedBlocks = const [],
  });

  @override
  State<ImageCropPage> createState() => _ImageCropPageState();
}

class _ImageCropPageState extends State<ImageCropPage> {
  bool _isCropping = false;

  @override
  void initState() {
    super.initState();
    // 延迟一帧后自动打开裁切
    WidgetsBinding.instance.addPostFrameCallback((_) => _cropImage());
  }

  Future<void> _cropImage() async {
    if (_isCropping) return;
    setState(() => _isCropping = true);

    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: widget.imageFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: '裁切作业图片',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            backgroundColor: Colors.black,
            activeControlsWidgetColor: const Color(0xFF6366F1),
            cropStyle: CropStyle.rectangle,
            lockAspectRatio: false,
            hideBottomControls: false,
            initAspectRatio: CropAspectRatioPreset.original,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio4x3,
            ],
          ),
          IOSUiSettings(
            title: '裁切作业图片',
            cancelButtonTitle: '取消',
            doneButtonTitle: '完成',
            resetButtonHidden: false,
            rotateButtonsHidden: false,
            rotateClockwiseButtonHidden: true,
            aspectRatioLockEnabled: false,
            aspectRatioPickerButtonHidden: true,
            rectX: _getInitialCropX(),
            rectY: _getInitialCropY(),
            rectWidth: _getInitialCropWidth(),
            rectHeight: _getInitialCropHeight(),
          ),
        ],
      );

      if (mounted) {
        if (croppedFile != null) {
          Navigator.of(context).pop(File(croppedFile.path));
        } else {
          // 用户取消裁切 — 使用原图
          Navigator.of(context).pop(widget.imageFile);
        }
      }
    } catch (e) {
      debugPrint('裁切失败: $e');
      if (mounted) {
        // 裁切失败使用原图
        Navigator.of(context).pop(widget.imageFile);
      }
    }
  }

  /// 基于 ML Kit 检测结果计算初始裁切区域（iOS）
  double? _getInitialCropX() {
    final rect = _getSuggestedRect();
    return rect?.left;
  }

  double? _getInitialCropY() {
    final rect = _getSuggestedRect();
    return rect?.top;
  }

  double? _getInitialCropWidth() {
    final rect = _getSuggestedRect();
    return rect?.width;
  }

  double? _getInitialCropHeight() {
    final rect = _getSuggestedRect();
    return rect?.height;
  }

  Rect? _getSuggestedRect() {
    if (widget.detectedBlocks.isEmpty) return null;
    // 使用 CameraOcrService 的静态方法计算建议裁切区域
    // 注意：这里需要原图尺寸，暂时返回 null 让用户自行调整
    return CameraOcrService.computeAutoCropRect(
      widget.detectedBlocks,
      const Size(1920, 1080), // 近似值，实际应从图片元数据获取
    );
  }

  @override
  Widget build(BuildContext context) {
    // 裁切过程中显示加载
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 16),
            Text(
              '正在打开裁切工具...',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
