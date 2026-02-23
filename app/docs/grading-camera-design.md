# 作业拍照批改相机 — 设计方案

> 参考作业帮拍照搜题体验，为智能批改提供专业级拍照→裁切→识别→批改全链路

---

## 一、核心体验目标

| 能力 | 作业帮参考 | 我们的实现 |
|------|-----------|-----------|
| **专用相机** | 横向引导框，提示"将题目放入框内" | ✅ 自定义相机页，带半透明引导框 |
| **实时文字检测** | 拍照前能看到文字高亮区域 | ✅ Google ML Kit 实时文字区域叠加 |
| **智能裁切** | 拍照后自动裁切到题目区域 | ✅ 自动检测文字边界 + 手动微调裁切框 |
| **多张连拍** | 一次拍多页，左下角缩略图计数 | ✅ 连拍模式，底部缩略图滚动条 |
| **闪光灯/翻转** | 顶部工具栏 | ✅ 闪光灯（自动/开/关）+ 前后摄切换 |
| **相册导入** | 拍照页左下角相册入口 | ✅ 复用已有 image_picker |
| **题目自动分割** | 识别并框出每道题 | ⭐ Phase 2: 后端 OCR 返回题目边界框，客户端渲染 |

---

## 二、技术选型

### 2.1 依赖包

| 包 | 版本 | 用途 | 下载量 | 备注 |
|---|------|------|--------|------|
| `camera` | ^0.11.4 | 相机预览 + 拍照控制 | 560K | Flutter 官方，支持流式帧 |
| `image_cropper` | ^11.0.0 | 拍照后裁切 | 306K | 最成熟，原生UI裁切 |
| `google_mlkit_text_recognition` | ^0.15.1 | 端侧实时 OCR | 128K | 支持中文，无需网络 |
| `google_mlkit_commons` | (依赖自动引入) | ML Kit 公共基础 | — | — |
| `image` | (已有) | 图片处理/压缩 | — | — |
| `image_picker` | ^1.0.0 | 相册选图 | ✅ 已有 | 保留 |

> **新增 3 个包：** `camera` + `image_cropper` + `google_mlkit_text_recognition`

### 2.2 为什么不用 image_picker 的相机？

| | image_picker | camera 包 |
|---|---|---|
| 相机预览自定义 | ❌ 系统相机 | ✅ 完全自定义 |
| 实时帧处理 | ❌ | ✅ startImageStream |
| 引导框叠加 | ❌ | ✅ Stack + Overlay |
| 连拍不退出 | ❌ 拍一张就返回 | ✅ 持续预览 |
| 闪光灯精细控制 | ❌ | ✅ FlashMode |

---

## 三、页面架构

```
GradingSubmitPage（已有）
  ├── [新] GradingCameraPage         — 专用拍照页
  │     ├── CameraPreview            — 相机预览 + 引导框叠加
  │     ├── TextDetectionOverlay     — 实时文字区域高亮
  │     ├── CameraToolbar            — 顶部工具栏（闪光灯/翻转/关闭）
  │     ├── CaptureBar               — 底部拍照按钮 + 相册入口 + 缩略图
  │     └── 拍照后 → ImageCropPage
  ├── [新] ImageCropPage             — 裁切确认页
  │     ├── image_cropper 原生裁切
  │     └── 确认后返回图片列表
  └── [新] QuestionPreviewSheet      — 题目预览（Phase 2）
        ├── 识别到的题目列表
        └── 点击定位 / 手动分割
```

---

## 四、交互流程

### 4.1 主流程

```
[提交批改页] 点击"拍照"
    ↓
[相机页] 打开自定义相机
    ├── 实时预览 + 半透明引导框
    ├── 顶部: 闪光灯 | 翻转相机 | 关闭
    ├── 底部: [相册] [📷 拍照按钮] [已拍: 3张]
    ├── 拍照 → 快速预览 0.3s → 继续拍照
    ├── 点击缩略图 → 进入裁切页
    └── 点击"完成" → 返回所有图片
           ↓
[裁切页] (每张可选裁切)
    ├── 自动检测文字区域，预设裁切框
    ├── 用户可拖动调整
    ├── 旋转 90°
    └── 确认裁切
           ↓
[提交批改页] 图片列表更新
    ├── 显示裁切后缩略图
    ├── 可删除/重拍
    └── 提交批改 → SSE 流式
```

### 4.2 实时文字检测流程

```
camera.startImageStream()
    ↓ 每帧 (节流: 500ms)
google_mlkit_text_recognition.processImage()
    ↓
提取 TextBlock 边界框
    ↓
CustomPainter 在预览上绘制半透明蓝色矩形
    ↓ 拍照时
利用最后一帧的文字边界 → 计算裁切建议区域
```

### 4.3 智能裁切逻辑

```dart
/// 自动裁切策略
Rect computeAutoCropRect(List<TextBlock> blocks, Size imageSize) {
  if (blocks.isEmpty) return Rect.fromLTWH(0, 0, imageSize.width, imageSize.height);
  
  // 1. 合并所有文字块的边界
  double left = double.infinity, top = double.infinity;
  double right = 0, bottom = 0;
  for (final block in blocks) {
    final rect = block.boundingBox;
    left = min(left, rect.left);
    top = min(top, rect.top);
    right = max(right, rect.right);
    bottom = max(bottom, rect.bottom);
  }
  
  // 2. 扩展边距 (5% padding)
  final padX = (right - left) * 0.05;
  final padY = (bottom - top) * 0.05;
  
  return Rect.fromLTRB(
    max(0, left - padX),
    max(0, top - padY),
    min(imageSize.width, right + padX),
    min(imageSize.height, bottom + padY),
  );
}
```

---

## 五、文件结构

```
features/grading/
├── services/
│   └── grading_service.dart              (已有)
├── pages/
│   ├── grading_submit_page.dart          (已有，修改：接入相机页)
│   ├── grading_result_page.dart          (已有)
│   ├── grading_dashboard_page.dart       (已有)
│   ├── grading_camera_page.dart          [新] 专用拍照页
│   └── image_crop_page.dart              [新] 裁切确认页
├── widgets/
│   ├── text_detection_overlay.dart       [新] 实时文字检测叠加层
│   ├── camera_guide_overlay.dart         [新] 拍照引导框
│   └── capture_thumbnail_bar.dart        [新] 底部缩略图条
└── services/
    └── camera_ocr_service.dart           [新] ML Kit OCR 封装
```

**新增文件：5 个**
**修改文件：1 个** (grading_submit_page.dart)

---

## 六、核心组件设计

### 6.1 GradingCameraPage

```dart
class GradingCameraPage extends StatefulWidget {
  /// 已有图片数量（用于显示计数）
  final int existingImageCount;
  /// 最大可拍数量
  final int maxImages;
  
  /// 返回: List<File> 裁切后的图片文件列表
}
```

**状态管理：**
```dart
class _GradingCameraPageState extends State<GradingCameraPage> {
  late CameraController _cameraController;
  
  // 相机状态
  FlashMode _flashMode = FlashMode.auto;
  bool _isRearCamera = true;
  bool _isCapturing = false;
  
  // 已拍图片
  final List<File> _capturedImages = [];
  
  // ML Kit 文字检测
  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.chinese);
  List<TextBlock> _detectedBlocks = [];
  bool _isProcessingFrame = false;
  DateTime _lastFrameTime = DateTime.now();
  
  // 生命周期
  @override void initState() → 初始化相机 + 开始帧监听
  @override void dispose() → 释放相机 + ML Kit
}
```

**UI 布局：**
```
Stack(
  children: [
    // 底层: 相机预览
    CameraPreview(_cameraController),
    
    // 叠加层: 文字区域高亮
    TextDetectionOverlay(blocks: _detectedBlocks),
    
    // 叠加层: 引导框
    CameraGuideOverlay(message: '将作业放入框内'),
    
    // 顶部工具栏
    Positioned(top: 0, child: CameraToolbar(...)),
    
    // 底部操作栏
    Positioned(bottom: 0, child: CaptureBar(
      onCapture: _takePhoto,
      onGallery: _pickFromGallery,
      onComplete: _finishCapture,
      thumbnails: _capturedImages,
      count: _capturedImages.length,
    )),
  ],
)
```

### 6.2 TextDetectionOverlay

```dart
class TextDetectionOverlay extends StatelessWidget {
  final List<TextBlock> blocks;
  final Size imageSize;    // 相机帧尺寸
  final Size previewSize;  // 预览组件尺寸
  
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TextBlockPainter(
        blocks: blocks,
        imageSize: imageSize,
        previewSize: previewSize,
        blockColor: Colors.blue.withOpacity(0.15),
        borderColor: Colors.blue.withOpacity(0.5),
      ),
    );
  }
}
```

### 6.3 CameraGuideOverlay

```dart
/// 半透明遮罩 + 中间透明区域 + 引导文字
class CameraGuideOverlay extends StatelessWidget {
  // 四周半透明黑色遮罩
  // 中间矩形透明区域（圆角）
  // 四角高亮标记
  // 底部文字: "将作业放入框内"
}
```

### 6.4 ImageCropPage

```dart
class ImageCropPage extends StatelessWidget {
  final File imageFile;
  final Rect? suggestedCropRect;  // ML Kit 建议的裁切区域
  
  /// 使用 image_cropper 包
  /// 预设 suggestedCropRect 作为初始裁切框
  /// 返回: File? 裁切后的图片，null 表示取消
}
```

---

## 七、实时帧处理优化策略

### 7.1 性能问题

- 相机帧率 30fps，每帧都做 OCR 会卡
- ML Kit 处理一帧中文 ~50-100ms
- 需要节流 + 异步隔离

### 7.2 优化方案

```dart
void _onCameraFrame(CameraImage image) {
  // 节流: 500ms 一次
  if (DateTime.now().difference(_lastFrameTime).inMilliseconds < 500) return;
  if (_isProcessingFrame) return;
  
  _isProcessingFrame = true;
  _lastFrameTime = DateTime.now();
  
  // 转换图片格式
  final inputImage = _convertCameraImage(image);
  
  // 异步处理，不阻塞相机
  _textRecognizer.processImage(inputImage).then((recognizedText) {
    if (mounted) {
      setState(() {
        _detectedBlocks = recognizedText.blocks;
        _isProcessingFrame = false;
      });
    }
  }).catchError((_) {
    _isProcessingFrame = false;
  });
}
```

### 7.3 帧格式转换

```dart
InputImage _convertCameraImage(CameraImage image) {
  // Android: YUV420 → InputImage.fromBytes
  // iOS: bgra8888 → InputImage.fromBytes
  final rotation = InputImageRotationValue.fromRawValue(
    _cameraController.description.sensorOrientation,
  );
  
  return InputImage.fromBytes(
    bytes: _concatenatePlanes(image.planes),
    metadata: InputImageMetadata(
      size: Size(image.width.toDouble(), image.height.toDouble()),
      rotation: rotation ?? InputImageRotation.rotation0deg,
      format: Platform.isAndroid
          ? InputImageFormat.yuv_420_888
          : InputImageFormat.bgra8888,
      bytesPerRow: image.planes.first.bytesPerRow,
    ),
  );
}
```

---

## 八、分阶段实施计划

### Phase 1: 基础拍照 + 裁切（优先级最高，2-3天）

| # | 任务 | 描述 |
|---|------|------|
| 1.1 | 添加依赖 | `camera` + `image_cropper` |
| 1.2 | CameraOcrService | 相机初始化/释放/拍照封装 |
| 1.3 | GradingCameraPage | 自定义相机页（预览+引导框+工具栏+连拍） |
| 1.4 | CameraGuideOverlay | 半透明引导框组件 |
| 1.5 | CaptureThumbnailBar | 底部拍照按钮+缩略图条 |
| 1.6 | ImageCropPage | image_cropper 裁切页封装 |
| 1.7 | 集成 | GradingSubmitPage 接入相机页 |

### Phase 2: 实时文字检测（1-2天）

| # | 任务 | 描述 |
|---|------|------|
| 2.1 | 添加依赖 | `google_mlkit_text_recognition` |
| 2.2 | TextDetectionOverlay | 实时文字区域高亮叠加层 |
| 2.3 | 帧处理管线 | 节流 + 异步 OCR + 坐标转换 |
| 2.4 | 智能裁切建议 | 基于文字边界自动计算裁切区域 |

### Phase 3: 体验优化（1天）

| # | 任务 | 描述 |
|---|------|------|
| 3.1 | 拍照动画 | 快门音效 + 白色闪烁 + 缩略图弹入动画 |
| 3.2 | 图片压缩 | 拍照后自动压缩（保持清晰度前提下减小体积） |
| 3.3 | 权限处理 | 相机权限请求 + 引导设置页 |
| 3.4 | 横竖屏适配 | 相机预览方向 + UI 适配 |

### Phase 4: 题目分割预览（未来扩展）

| # | 任务 | 描述 |
|---|------|------|
| 4.1 | 后端支持 | OCR 接口返回题目边界框坐标 |
| 4.2 | QuestionPreviewSheet | 题目分割预览，点击定位 |
| 4.3 | 手动分割 | 用户手动划线分割题目 |

---

## 九、iOS/Android 平台配置

### iOS (Info.plist)
```xml
<!-- 已有 -->
<key>NSCameraUsageDescription</key>
<string>需要使用相机拍摄作业照片</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>需要访问相册选择作业图片</string>

<!-- 新增: ML Kit 需要 -->
<!-- (ML Kit 自动配置，无需额外 plist) -->
```

### Android (AndroidManifest.xml)
```xml
<!-- 已有 -->
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>

<!-- 新增: camera 包需要 -->
<uses-feature android:name="android.hardware.camera" android:required="false"/>
<uses-feature android:name="android.hardware.camera.autofocus" android:required="false"/>
```

### Android minSdkVersion
- `camera` 要求: minSdkVersion 21 ✅ (已满足)
- `google_mlkit_text_recognition` 要求: minSdkVersion 21 ✅

---

## 十、风险评估

| 风险 | 影响 | 缓解方案 |
|------|------|---------|
| ML Kit 中文识别精度 | 部分手写字体识别率低 | 仅用于辅助引导，不影响后端 OCR 精度 |
| 相机帧处理卡顿 | 低端机可能掉帧 | 节流500ms + 可关闭实时检测 |
| image_cropper iOS 兼容 | 部分 iOS 版本裁切UI异常 | 使用 native 裁切，稳定性高 |
| 包体积增加 | ML Kit ~15MB (含中文模型) | 可做按需下载（ML Kit 支持） |
| HEIC 格式 | iOS 拍照默认 HEIC | camera 包直接输出 JPEG，无需转换 |

---

## 十一、效果对比

### 改造前（当前实现）
```
点击"添加图片" → BottomSheet(拍照/相册) → 系统相机 → 拍一张返回 → 上传
```
- ❌ 系统相机，无引导
- ❌ 无裁切，整张上传
- ❌ 每次只能拍一张
- ❌ 无文字检测反馈

### 改造后
```
点击"拍照批改" → 专用相机(引导框+实时检测) → 连拍多张 → 逐张裁切 → 批量上传
```
- ✅ 专业拍题相机，学生一看就懂
- ✅ 实时文字区域高亮，拍照有信心
- ✅ 智能裁切建议，省去手动调整
- ✅ 连拍模式，多页作业一次搞定
- ✅ 裁切后体积更小，上传更快

---

## 十二、总结

| 维度 | 详情 |
|------|------|
| **新增依赖** | 3 个 (`camera` + `image_cropper` + `google_mlkit_text_recognition`) |
| **新增文件** | 5 个 |
| **修改文件** | 1 个 (`grading_submit_page.dart`) |
| **分 4 个阶段** | Phase 1 基础拍照裁切 → Phase 2 实时检测 → Phase 3 体验优化 → Phase 4 题目分割 |
| **建议先做** | Phase 1 + Phase 2（核心体验，3-4天） |
| **技术难点** | 相机帧处理性能优化、坐标系转换、裁切区域计算 |
