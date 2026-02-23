import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/camera_ocr_service.dart';
import '../widgets/camera_guide_overlay.dart';
import '../widgets/text_detection_overlay.dart';
import '../widgets/capture_thumbnail_bar.dart';
import 'image_crop_page.dart';

/// 作业拍照相机页
/// 返回 List<File> — 裁切后的图片文件列表
class GradingCameraPage extends StatefulWidget {
  final int existingImageCount;
  final int maxImages;

  const GradingCameraPage({
    super.key,
    this.existingImageCount = 0,
    this.maxImages = 10,
  });

  @override
  State<GradingCameraPage> createState() => _GradingCameraPageState();
}

class _GradingCameraPageState extends State<GradingCameraPage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isInitialized = false;
  bool _isCapturing = false;
  bool _isRearCamera = true;
  FlashMode _flashMode = FlashMode.auto;

  // ML Kit 文字检测
  final _ocrService = CameraOcrService();
  List<TextBlock> _detectedBlocks = [];
  bool _enableTextDetection = true;

  // 已拍图片
  final List<File> _capturedImages = [];

  // 快门动画
  late final AnimationController _shutterAnimController;
  bool _showShutterFlash = false;

  // 权限状态
  bool _permissionDenied = false;

  int get _remainingSlots => widget.maxImages - widget.existingImageCount - _capturedImages.length;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _shutterAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _checkPermissionAndInit();
    // 强制竖屏
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    _ocrService.dispose();
    _shutterAnimController.dispose();
    // 恢复屏幕方向
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      _cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
    }
  }

  Future<void> _checkPermissionAndInit() async {
    final status = await Permission.camera.status;
    if (status.isGranted) {
      _initCamera();
    } else {
      final result = await Permission.camera.request();
      if (result.isGranted) {
        _initCamera();
      } else {
        if (mounted) setState(() => _permissionDenied = true);
      }
    }
  }

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        debugPrint('没有可用的相机');
        return;
      }

      final camera = _isRearCamera
          ? _cameras.firstWhere(
              (c) => c.lensDirection == CameraLensDirection.back,
              orElse: () => _cameras.first,
            )
          : _cameras.firstWhere(
              (c) => c.lensDirection == CameraLensDirection.front,
              orElse: () => _cameras.first,
            );

      _cameraController = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _cameraController!.initialize();
      await _cameraController!.setFlashMode(_flashMode);

      // 启动帧流用于文字检测
      if (_enableTextDetection) {
        _startImageStream();
      }

      if (mounted) {
        setState(() => _isInitialized = true);
      }
    } catch (e) {
      debugPrint('相机初始化失败: $e');
    }
  }

  void _startImageStream() {
    if (_cameraController == null || !_cameraController!.value.isInitialized) return;

    try {
      _cameraController!.startImageStream((CameraImage image) async {
        if (!_enableTextDetection || !mounted) return;

        final blocks = await _ocrService.processFrame(
          image,
          _cameraController!.description,
        );

        if (blocks != null && mounted) {
          setState(() => _detectedBlocks = blocks);
        }
      });
    } catch (e) {
      debugPrint('启动帧流失败: $e');
    }
  }

  Future<void> _stopImageStream() async {
    try {
      if (_cameraController != null && _cameraController!.value.isStreamingImages) {
        await _cameraController!.stopImageStream();
      }
    } catch (e) {
      debugPrint('停止帧流失败: $e');
    }
  }

  // ==================== 拍照 ====================

  Future<void> _takePhoto() async {
    if (_isCapturing || _cameraController == null || !_cameraController!.value.isInitialized) return;
    if (_remainingSlots <= 0) return;

    setState(() => _isCapturing = true);

    try {
      // 停止帧流后再拍照（避免冲突）
      await _stopImageStream();

      // 快门白色闪烁动画
      _triggerShutterFlash();

      final XFile photo = await _cameraController!.takePicture();

      // 压缩图片
      final file = await _compressImage(File(photo.path));

      // 保存最后检测到的文字块用于裁切建议
      final lastBlocks = List<TextBlock>.from(_detectedBlocks);

      if (mounted) {
        // 自动进入裁切
        final croppedFile = await Navigator.of(context).push<File>(
          MaterialPageRoute(
            builder: (_) => ImageCropPage(
              imageFile: file,
              detectedBlocks: lastBlocks,
            ),
          ),
        );

        if (croppedFile != null && mounted) {
          setState(() => _capturedImages.add(croppedFile));
        }
      }
    } catch (e) {
      debugPrint('拍照失败: $e');
    } finally {
      if (mounted) {
        setState(() => _isCapturing = false);
        // 重新启动帧流
        if (_enableTextDetection) {
          _startImageStream();
        }
      }
    }
  }

  Future<void> _pickFromGallery() async {
    if (_remainingSlots <= 0) return;

    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 90,
    );

    if (picked == null) return;

    final file = File(picked.path);

    if (mounted) {
      final croppedFile = await Navigator.of(context).push<File>(
        MaterialPageRoute(
          builder: (_) => ImageCropPage(imageFile: file, detectedBlocks: const []),
        ),
      );

      if (croppedFile != null && mounted) {
        setState(() => _capturedImages.add(croppedFile));
      }
    }
  }

  void _onThumbnailTap(int index) {
    // 点击缩略图预览，可删除
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                _capturedImages[index],
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.5,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() => _capturedImages.removeAt(index));
                    Navigator.pop(ctx);
                  },
                  icon: const Icon(Icons.delete_outline, size: 18),
                  label: const Text('删除'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white24,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('关闭'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _finishCapture() {
    Navigator.of(context).pop(_capturedImages);
  }

  // ==================== 快门动画 + 压缩 ====================

  void _triggerShutterFlash() {
    setState(() => _showShutterFlash = true);
    _shutterAnimController.forward().then((_) {
      _shutterAnimController.reverse().then((_) {
        if (mounted) setState(() => _showShutterFlash = false);
      });
    });
    // 触发轻微触感反馈
    HapticFeedback.lightImpact();
  }

  /// 压缩图片 — 保持清晰度的同时减小体积
  Future<File> _compressImage(File file) async {
    try {
      final fileSize = await file.length();
      // 只对超过 2MB 的图片压缩
      if (fileSize <= 2 * 1024 * 1024) return file;

      // 裁切时 image_cropper 会自动压缩输出
      debugPrint('图片压缩: ${fileSize ~/ 1024}KB, 裁切时将自动优化');
      return file;
    } catch (e) {
      debugPrint('图片压缩失败: $e');
      return file;
    }
  }

  // ==================== 工具栏操作 ====================

  Future<void> _toggleFlash() async {
    if (_cameraController == null) return;

    FlashMode nextMode;
    switch (_flashMode) {
      case FlashMode.auto:
        nextMode = FlashMode.always;
        break;
      case FlashMode.always:
        nextMode = FlashMode.off;
        break;
      default:
        nextMode = FlashMode.auto;
    }

    await _cameraController!.setFlashMode(nextMode);
    setState(() => _flashMode = nextMode);
  }

  Future<void> _toggleCamera() async {
    if (_cameras.length < 2) return;

    await _stopImageStream();
    await _cameraController?.dispose();

    setState(() {
      _isRearCamera = !_isRearCamera;
      _isInitialized = false;
      _detectedBlocks.clear();
    });

    await _initCamera();
  }

  void _toggleTextDetection() {
    setState(() {
      _enableTextDetection = !_enableTextDetection;
      if (!_enableTextDetection) {
        _stopImageStream();
        _detectedBlocks.clear();
      } else {
        _startImageStream();
      }
    });
  }

  // ==================== UI ====================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _permissionDenied
          ? _buildPermissionDenied()
          : _isInitialized && _cameraController != null
              ? _buildCameraView()
              : const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
    );
  }

  Widget _buildPermissionDenied() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white10,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.camera_alt_outlined, color: Colors.white38, size: 36),
            ),
            const SizedBox(height: 24),
            const Text(
              '需要相机权限',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '拍照批改功能需要访问您的相机\n请在设置中开启相机权限',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54, fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(null),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white70,
                    side: const BorderSide(color: Colors.white24),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text('返回'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => openAppSettings(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text('去设置', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraView() {
    final controller = _cameraController!;

    return Stack(
      fit: StackFit.expand,
      children: [
        // 相机预览
        Center(
          child: CameraPreview(controller),
        ),

        // 文字检测叠加层
        if (_enableTextDetection && _detectedBlocks.isNotEmpty)
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return TextDetectionOverlay(
                  blocks: _detectedBlocks,
                  imageSize: Size(
                    controller.value.previewSize?.height ?? constraints.maxWidth,
                    controller.value.previewSize?.width ?? constraints.maxHeight,
                  ),
                  previewSize: Size(constraints.maxWidth, constraints.maxHeight),
                  rotation: InputImageRotation.values.firstWhere(
                    (r) => r.rawValue == controller.description.sensorOrientation,
                    orElse: () => InputImageRotation.rotation0deg,
                  ),
                );
              },
            ),
          ),

        // 引导框
        const Positioned.fill(
          child: CameraGuideOverlay(),
        ),

        // 快门白色闪烁效果
        if (_showShutterFlash)
          AnimatedBuilder(
            animation: _shutterAnimController,
            builder: (_, __) => Container(
              color: Colors.white.withValues(alpha: _shutterAnimController.value * 0.6),
            ),
          ),

        // 顶部工具栏
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: _buildToolbar(),
        ),

        // 底部操作栏
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: CaptureThumbnailBar(
            onCapture: _takePhoto,
            onGallery: _pickFromGallery,
            onComplete: _finishCapture,
            onThumbnailTap: _onThumbnailTap,
            capturedImages: _capturedImages,
            maxImages: _remainingSlots + _capturedImages.length,
            isCapturing: _isCapturing,
          ),
        ),
      ],
    );
  }

  Widget _buildToolbar() {
    final flashIcon = _flashMode == FlashMode.auto
        ? Icons.flash_auto
        : _flashMode == FlashMode.always
            ? Icons.flash_on
            : Icons.flash_off;

    final flashLabel = _flashMode == FlashMode.auto
        ? '自动'
        : _flashMode == FlashMode.always
            ? '开启'
            : '关闭';

    return Container(
      padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 8, 16, 12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black54, Colors.transparent],
        ),
      ),
      child: Row(
        children: [
          // 关闭
          _buildToolButton(
            icon: Icons.close,
            label: '关闭',
            onTap: () => Navigator.of(context).pop(null),
          ),
          const Spacer(),
          // 文字检测开关
          _buildToolButton(
            icon: _enableTextDetection ? Icons.text_fields : Icons.text_fields,
            label: _enableTextDetection ? '检测开' : '检测关',
            onTap: _toggleTextDetection,
            isActive: _enableTextDetection,
          ),
          const SizedBox(width: 20),
          // 闪光灯
          _buildToolButton(
            icon: flashIcon,
            label: flashLabel,
            onTap: _toggleFlash,
          ),
          const SizedBox(width: 20),
          // 翻转相机
          _buildToolButton(
            icon: Icons.flip_camera_ios_outlined,
            label: '翻转',
            onTap: _toggleCamera,
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFF6366F1) : Colors.white,
            size: 24,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: isActive ? const Color(0xFF6366F1) : Colors.white70,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
