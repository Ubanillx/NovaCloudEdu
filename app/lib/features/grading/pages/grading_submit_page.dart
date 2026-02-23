import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/toast/nova_message.dart';
import '../services/grading_service.dart';
import 'grading_camera_page.dart';
import 'grading_result_page.dart';

/// 智能批改提交页
class GradingSubmitPage extends StatefulWidget {
  const GradingSubmitPage({super.key});

  @override
  State<GradingSubmitPage> createState() => _GradingSubmitPageState();
}

class _GradingSubmitPageState extends State<GradingSubmitPage> {
  final _gradingService = GradingService();

  // 模式选择
  String _gradingMode = 'GENERAL'; // GENERAL | EXAM_PAPER

  // 表单
  final _titleController = TextEditingController();
  String _selectedSubject = '';
  String _selectedGrade = '';

  // 图片
  final List<_UploadedImage> _images = [];
  bool _isUploading = false;

  // 历史
  List<GradingHistoryItem> _history = [];
  bool _isLoadingHistory = true;

  // 试卷选择
  List<ExamPaperItem> _papers = [];
  ExamPaperItem? _selectedPaper;
  bool _isLoadingPapers = false;

  // 批改进度
  bool _isGrading = false;
  String _progressMessage = '';
  int _progressCurrent = 0;
  int _progressTotal = 0;
  String _currentPhase = 'idle'; // idle, ocr, grading, done, error
  final List<GradingSseEvent> _gradedQuestions = [];
  String? _overallComment;
  String? _completedSubmissionId;
  StreamSubscription<GradingSseEvent>? _sseSubscription;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _sseSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadHistory() async {
    final history = await _gradingService.getHistory(page: 1, size: 5);
    if (mounted) {
      setState(() {
        _history = history;
        _isLoadingHistory = false;
      });
    }
  }

  Future<void> _loadPapers() async {
    setState(() => _isLoadingPapers = true);
    final papers = await _gradingService.getPublishedPapers();
    if (mounted) {
      setState(() {
        _papers = papers;
        _isLoadingPapers = false;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    if (_images.length >= 10) {
      NovaMessage.warning(context, '最多上传10张图片');
      return;
    }

    XFile? file;
    if (source == ImageSource.gallery) {
      file = await _gradingService.pickImageFromGallery();
    } else {
      file = await _gradingService.pickImageFromCamera();
    }

    if (file == null) return;

    final uploadImage = _UploadedImage(localPath: file.path, name: file.name);
    setState(() {
      _images.add(uploadImage);
      _isUploading = true;
    });

    final url = await _gradingService.uploadGradingImage(file);
    if (mounted) {
      setState(() {
        if (url != null) {
          uploadImage.remoteUrl = url;
          uploadImage.status = _UploadStatus.success;
        } else {
          uploadImage.status = _UploadStatus.failed;
        }
        _isUploading = _images.any((img) => img.status == _UploadStatus.uploading);
      });
    }
  }

  void _removeImage(int index) {
    setState(() => _images.removeAt(index));
  }

  void _startGrading() {
    final urls = _images
        .where((img) => img.remoteUrl != null)
        .map((img) => img.remoteUrl!)
        .toList();

    if (urls.isEmpty) {
      NovaMessage.warning(context, '请先上传作业图片');
      return;
    }

    setState(() {
      _isGrading = true;
      _currentPhase = 'ocr';
      _progressMessage = '正在准备...';
      _progressCurrent = 0;
      _progressTotal = 0;
      _gradedQuestions.clear();
      _overallComment = null;
      _completedSubmissionId = null;
    });

    final stream = _gradingService.submitAndGrade(
      gradingMode: _gradingMode,
      title: _titleController.text.isNotEmpty ? _titleController.text : null,
      subject: _selectedSubject.isNotEmpty ? _selectedSubject : null,
      grade: _selectedGrade.isNotEmpty ? _selectedGrade : null,
      imageUrls: urls,
      examPaperId: _selectedPaper?.id,
    );

    _sseSubscription = stream.listen(
      (event) {
        if (!mounted) return;
        setState(() {
          if (event.isError) {
            _currentPhase = 'error';
            _progressMessage = event.error ?? '批改失败';
          } else if (event.isOcr) {
            _currentPhase = 'ocr';
            _progressMessage = event.message ?? '图像识别中...';
          } else if (event.isOcrDone) {
            _currentPhase = 'grading';
            _progressMessage = event.message ?? '识别完成';
            _progressTotal = event.questionCount ?? 0;
          } else if (event.isQuestionGraded) {
            _currentPhase = 'grading';
            _progressCurrent = event.index ?? _progressCurrent;
            _progressMessage = '正在批改第 ${event.index}/${event.total ?? _progressTotal} 题';
            _progressTotal = event.total ?? _progressTotal;
            _gradedQuestions.add(event);
          } else if (event.isDone) {
            _currentPhase = 'done';
            _progressMessage = '批改完成';
            _completedSubmissionId = event.submissionId;
            _overallComment = event.overallComment;
            _progressCurrent = _progressTotal;
          } else if (event.message != null) {
            _progressMessage = event.message!;
            if (event.index != null) _progressCurrent = event.index!;
            if (event.total != null) _progressTotal = event.total!;
          }
        });
      },
      onDone: () {
        if (mounted && _currentPhase != 'done' && _currentPhase != 'error') {
          setState(() => _currentPhase = 'done');
        }
      },
      onError: (e) {
        if (mounted) {
          setState(() {
            _currentPhase = 'error';
            _progressMessage = '批改失败: $e';
          });
        }
      },
    );
  }

  void _resetGrading() {
    _sseSubscription?.cancel();
    setState(() {
      _isGrading = false;
      _currentPhase = 'idle';
      _progressMessage = '';
      _progressCurrent = 0;
      _progressTotal = 0;
      _gradedQuestions.clear();
      _overallComment = null;
      _completedSubmissionId = null;
      _images.clear();
    });
    _loadHistory();
  }

  void _viewResult(String submissionId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GradingResultPage(submissionId: submissionId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text('智能批改', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
        backgroundColor: colors.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colors.textPrimary),
      ),
      body: _isGrading ? _buildGradingProgress(colors) : _buildSubmitForm(colors),
    );
  }

  // ==================== 提交表单 ====================

  Widget _buildSubmitForm(AppColors colors) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageUploadCard(colors),
          const SizedBox(height: 16),
          _buildSettingsCard(colors),
          const SizedBox(height: 20),
          _buildSubmitButton(colors),
          const SizedBox(height: 24),
          _buildHistorySection(colors),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  /// 包裹卡片的通用容器
  Widget _buildSectionCard({required AppColors colors, required List<Widget> children, EdgeInsetsGeometry? padding}) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }

  /// 段落标题
  Widget _buildSectionTitle(String title, AppColors colors, {IconData? icon}) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18, color: AppTheme.brand),
          const SizedBox(width: 8),
        ],
        Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: colors.textPrimary)),
      ],
    );
  }

  // ==================== 图片卡片 ====================

  Widget _buildImageUploadCard(AppColors colors) {
    final canAdd = _images.length < 10;
    return _buildSectionCard(
      colors: colors,
      children: [
        Row(
          children: [
            _buildSectionTitle('作业图片', colors, icon: Icons.image_outlined),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('${_images.length}/10', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: colors.textTertiary)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // 拍照 / 相册
        if (canAdd)
          Row(
            children: [
              Expanded(
                child: _buildImageActionButton(
                  icon: Icons.camera_alt_rounded,
                  label: '拍照',
                  colors: colors,
                  onTap: _openCamera,
                  isPrimary: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildImageActionButton(
                  icon: Icons.photo_library_rounded,
                  label: '相册',
                  colors: colors,
                  onTap: () => _pickImage(ImageSource.gallery),
                  isPrimary: false,
                ),
              ),
            ],
          ),
        if (_images.isEmpty && canAdd) ...[
          const SizedBox(height: 16),
          Center(
            child: Text(
              '拍照或从相册选择作业图片',
              style: TextStyle(fontSize: 12, color: colors.textTertiary),
            ),
          ),
        ],
        if (_images.isNotEmpty) ...[
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: _images.length,
            itemBuilder: (_, i) => _buildImageTile(_images[i], i, colors),
          ),
        ],
      ],
    );
  }

  // ==================== 设置卡片 ====================

  Widget _buildSettingsCard(AppColors colors) {
    return _buildSectionCard(
      colors: colors,
      children: [
        _buildSectionTitle('批改设置', colors, icon: Icons.tune_rounded),
        const SizedBox(height: 16),
        // 模式选择
        Row(
          children: [
            Expanded(
              child: _ModeCard(
                icon: Icons.auto_awesome,
                title: '通用助手',
                subtitle: 'AI 自动识别',
                isSelected: _gradingMode == 'GENERAL',
                colors: colors,
                onTap: () => setState(() {
                  _gradingMode = 'GENERAL';
                  _selectedPaper = null;
                }),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ModeCard(
                icon: Icons.description_outlined,
                title: '试卷批改',
                subtitle: '关联试卷精准',
                isSelected: _gradingMode == 'EXAM_PAPER',
                colors: colors,
                onTap: () {
                  setState(() => _gradingMode = 'EXAM_PAPER');
                  if (_papers.isEmpty) _loadPapers();
                },
              ),
            ),
          ],
        ),
        // 试卷选择器
        if (_gradingMode == 'EXAM_PAPER') ...[
          const SizedBox(height: 16),
          _buildPaperSelector(colors),
        ],
        const SizedBox(height: 16),
        Divider(height: 1, color: colors.divider),
        const SizedBox(height: 16),
        // 表单字段
        _buildTextField(
          controller: _titleController,
          hint: '作业标题（可选）',
          icon: Icons.title,
          colors: colors,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildDropdown(
                value: _selectedSubject,
                items: subjectOptions.map((s) => DropdownMenuItem(value: s['code']!, child: Text(s['name']!, style: const TextStyle(fontSize: 14)))).toList(),
                hint: '学科',
                icon: Icons.school_outlined,
                colors: colors,
                onChanged: (v) => setState(() => _selectedSubject = v ?? ''),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildDropdown(
                value: _selectedGrade,
                items: gradeOptions.map((g) => DropdownMenuItem(value: g['code']!, child: Text(g['name']!, style: const TextStyle(fontSize: 14)))).toList(),
                hint: '年级',
                icon: Icons.grade_outlined,
                colors: colors,
                onChanged: (v) => setState(() => _selectedGrade = v ?? ''),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaperSelector(AppColors colors) {
    return GestureDetector(
      onTap: () => _showPaperPicker(colors),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _selectedPaper != null ? AppTheme.brand.withValues(alpha: 0.04) : colors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _selectedPaper != null ? AppTheme.brand.withValues(alpha: 0.3) : colors.divider),
        ),
        child: Row(
          children: [
            Icon(Icons.quiz_outlined, color: _selectedPaper != null ? AppTheme.brand : colors.iconSecondary, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: _selectedPaper != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_selectedPaper!.title ?? '', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: colors.textPrimary)),
                        const SizedBox(height: 2),
                        Text(
                          '${_selectedPaper!.subjectName ?? ''} · ${_selectedPaper!.grade ?? ''} · ${_selectedPaper!.totalScore ?? 0}分',
                          style: TextStyle(fontSize: 11, color: colors.textSecondary),
                        ),
                      ],
                    )
                  : Text('点击选择试卷', style: TextStyle(fontSize: 13, color: colors.textTertiary)),
            ),
            Icon(Icons.chevron_right_rounded, color: colors.iconSecondary, size: 20),
          ],
        ),
      ),
    );
  }

  void _showPaperPicker(AppColors colors) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (_, scrollController) {
          return Column(
            children: [
              const SizedBox(height: 12),
              Container(width: 40, height: 4, decoration: BoxDecoration(color: colors.border, borderRadius: BorderRadius.circular(2))),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('选择试卷', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colors.textPrimary)),
              ),
              if (_isLoadingPapers)
                const Expanded(child: Center(child: CircularProgressIndicator()))
              else if (_papers.isEmpty)
                Expanded(child: Center(child: Text('暂无可用试卷', style: TextStyle(color: colors.textSecondary))))
              else
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _papers.length,
                    itemBuilder: (_, i) {
                      final paper = _papers[i];
                      final isSelected = _selectedPaper?.id == paper.id;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedPaper = paper;
                            if (paper.subject != null) _selectedSubject = paper.subject!;
                            if (paper.grade != null) _selectedGrade = paper.grade!;
                          });
                          Navigator.pop(ctx);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: isSelected ? AppTheme.brand.withValues(alpha: 0.05) : colors.background,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: isSelected ? AppTheme.brand : colors.border),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(paper.title ?? '', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: colors.textPrimary)),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${paper.subjectName ?? ''} · ${paper.grade ?? ''} · ${paper.totalScore ?? 0}分',
                                      style: TextStyle(fontSize: 12, color: colors.textSecondary),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(Icons.check_circle, color: AppTheme.brand, size: 22),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required AppColors colors,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.divider),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 14, color: colors.textPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: colors.textTertiary),
          prefixIcon: Icon(icon, size: 20, color: colors.iconSecondary),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<DropdownMenuItem<String>> items,
    required String hint,
    required IconData icon,
    required AppColors colors,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.divider),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: items,
          onChanged: onChanged,
          isExpanded: true,
          icon: Icon(Icons.expand_more, color: colors.iconSecondary, size: 20),
          style: TextStyle(fontSize: 14, color: colors.textPrimary),
          dropdownColor: colors.surface,
        ),
      ),
    );
  }

  Widget _buildImageActionButton({
    required IconData icon,
    required String label,
    required AppColors colors,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return Material(
      color: isPrimary ? AppTheme.brand.withValues(alpha: 0.06) : colors.background,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isPrimary ? AppTheme.brand.withValues(alpha: 0.2) : colors.divider),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isPrimary ? AppTheme.brand : colors.iconPrimary, size: 20),
              const SizedBox(width: 8),
              Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isPrimary ? AppTheme.brand : colors.textPrimary)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openCamera() async {
    final files = await Navigator.of(context).push<List<File>>(
      MaterialPageRoute(
        builder: (_) => GradingCameraPage(
          existingImageCount: _images.length,
          maxImages: 10,
        ),
      ),
    );

    if (files == null || files.isEmpty || !mounted) return;

    for (final file in files) {
      if (_images.length >= 10) break;

      final xFile = XFile(file.path);
      final uploadImage = _UploadedImage(localPath: file.path, name: file.uri.pathSegments.last);
      setState(() {
        _images.add(uploadImage);
        _isUploading = true;
      });

      final url = await _gradingService.uploadGradingImage(xFile);
      if (mounted) {
        setState(() {
          if (url != null) {
            uploadImage.remoteUrl = url;
            uploadImage.status = _UploadStatus.success;
          } else {
            uploadImage.status = _UploadStatus.failed;
          }
          _isUploading = _images.any((img) => img.status == _UploadStatus.uploading);
        });
      }
    }
  }

  Widget _buildImageTile(_UploadedImage img, int index, AppColors colors) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(img.localPath),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (_, __, ___) => Container(
              color: colors.surface,
              child: Icon(Icons.image, color: colors.iconSecondary, size: 32),
            ),
          ),
        ),
        // 状态遮罩
        if (img.status == _UploadStatus.uploading)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
            ),
          ),
        if (img.status == _UploadStatus.failed)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Icon(Icons.error_outline, color: Colors.white, size: 28)),
            ),
          ),
        // 删除按钮
        Positioned(
          right: 4,
          top: 4,
          child: GestureDetector(
            onTap: () => _removeImage(index),
            child: Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
              child: const Icon(Icons.close, color: Colors.white, size: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(AppColors colors) {
    final hasImages = _images.any((img) => img.remoteUrl != null);
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: hasImages && !_isUploading ? _startGrading : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.brand,
          disabledBackgroundColor: AppTheme.brand.withValues(alpha: 0.3),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isUploading)
              const Padding(
                padding: EdgeInsets.only(right: 8),
                child: SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
              ),
            Text(
              _isUploading ? '图片上传中...' : '开始智能批改',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistorySection(AppColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildSectionTitle('最近批改', colors, icon: Icons.history_rounded),
            const Spacer(),
            if (_history.isNotEmpty)
              GestureDetector(
                onTap: () {
                  // TODO: 跳转历史列表
                },
                child: Text('查看全部', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.brand)),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (_isLoadingHistory)
          const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator(strokeWidth: 2)))
        else if (_history.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colors.divider),
            ),
            child: Column(
              children: [
                Icon(Icons.inbox_rounded, color: colors.iconSecondary, size: 36),
                const SizedBox(height: 8),
                Text('暂无批改记录', style: TextStyle(color: colors.textTertiary, fontSize: 13)),
              ],
            ),
          )
        else
          ..._history.map((item) => _buildHistoryItem(item, colors)),
      ],
    );
  }

  Widget _buildHistoryItem(GradingHistoryItem item, AppColors colors) {
    final subjectName = item.subject != null ? (subjectNames[item.subject!] ?? item.subject!) : '未知学科';
    return GestureDetector(
      onTap: item.isCompleted ? () => _viewResult(item.submissionId) : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.divider),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: item.isCompleted
                    ? Colors.green.withValues(alpha: 0.1)
                    : item.isFailed
                        ? Colors.red.withValues(alpha: 0.1)
                        : Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                item.isCompleted ? Icons.check_circle_outline : item.isFailed ? Icons.error_outline : Icons.hourglass_top,
                color: item.isCompleted ? Colors.green : item.isFailed ? Colors.red : Colors.orange,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title?.isNotEmpty == true ? item.title! : subjectName,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: colors.textPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.createTime ?? '',
                    style: TextStyle(fontSize: 11, color: colors.textTertiary),
                  ),
                ],
              ),
            ),
            if (item.isCompleted && item.totalScore != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.brand.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${item.totalScore}/${item.maxScore ?? 100}',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.brand),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ==================== 批改进度面板 ====================

  Widget _buildGradingProgress(AppColors colors) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 三阶段指示器
          _buildPhaseIndicator(colors),
          const SizedBox(height: 24),
          // 进度信息
          _buildProgressInfo(colors),
          const SizedBox(height: 20),
          // 逐题结果
          if (_gradedQuestions.isNotEmpty) ...[
            Text('批改结果', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: colors.textPrimary)),
            const SizedBox(height: 12),
            ..._gradedQuestions.asMap().entries.map((entry) => _buildQuestionResult(entry.key, entry.value, colors)),
          ],
          // 总评
          if (_overallComment != null) ...[
            const SizedBox(height: 16),
            _buildOverallComment(colors),
          ],
          // 操作按钮
          if (_currentPhase == 'done' || _currentPhase == 'error') ...[
            const SizedBox(height: 24),
            _buildActionButtons(colors),
          ],
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildPhaseIndicator(AppColors colors) {
    final phases = [
      {'key': 'ocr', 'label': '图像识别', 'icon': Icons.document_scanner_outlined},
      {'key': 'grading', 'label': 'AI 批改', 'icon': Icons.auto_awesome},
      {'key': 'done', 'label': '生成报告', 'icon': Icons.assessment_outlined},
    ];

    int currentIdx = 0;
    if (_currentPhase == 'grading') currentIdx = 1;
    if (_currentPhase == 'done') currentIdx = 2;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: phases.asMap().entries.map((entry) {
          final i = entry.key;
          final phase = entry.value;
          final isActive = i <= currentIdx;
          final isCurrent = i == currentIdx;

          return Expanded(
            child: Row(
              children: [
                if (i > 0)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: isActive ? AppTheme.brand : colors.border,
                    ),
                  ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isActive ? AppTheme.brand.withValues(alpha: isCurrent ? 1 : 0.2) : colors.background,
                    shape: BoxShape.circle,
                    border: Border.all(color: isActive ? AppTheme.brand : colors.border, width: 1.5),
                  ),
                  child: Icon(
                    phase['icon'] as IconData,
                    size: 18,
                    color: isCurrent ? Colors.white : isActive ? AppTheme.brand : colors.textTertiary,
                  ),
                ),
                if (i < phases.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: i < currentIdx ? AppTheme.brand : colors.border,
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProgressInfo(AppColors colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (_currentPhase != 'done' && _currentPhase != 'error')
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
                ),
              if (_currentPhase == 'done')
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.check_circle, color: Colors.green, size: 20),
                ),
              if (_currentPhase == 'error')
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.error, color: Colors.red, size: 20),
                ),
              Expanded(
                child: Text(
                  _progressMessage,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: colors.textPrimary),
                ),
              ),
            ],
          ),
          if (_progressTotal > 0) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: _progressTotal > 0 ? _progressCurrent / _progressTotal : 0,
                backgroundColor: colors.border,
                valueColor: AlwaysStoppedAnimation(AppTheme.brand),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '$_progressCurrent / $_progressTotal',
              style: TextStyle(fontSize: 12, color: colors.textSecondary),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuestionResult(int idx, GradingSseEvent event, AppColors colors) {
    final isCorrect = event.score != null && event.maxScore != null && event.score == event.maxScore;
    final isWrong = event.score == 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: isCorrect
                      ? Colors.green.withValues(alpha: 0.1)
                      : isWrong
                          ? Colors.red.withValues(alpha: 0.1)
                          : Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '${event.index ?? idx + 1}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isCorrect ? Colors.green : isWrong ? Colors.red : Colors.orange,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  event.comment ?? '',
                  style: TextStyle(fontSize: 13, color: colors.textSecondary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${event.score ?? 0}/${event.maxScore ?? 0}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isCorrect ? Colors.green : isWrong ? Colors.red : Colors.orange,
                ),
              ),
            ],
          ),
          if (event.knowledgePoints != null && event.knowledgePoints!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: event.knowledgePoints!.map((kp) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.brand.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(kp, style: TextStyle(fontSize: 10, color: AppTheme.brand, fontWeight: FontWeight.w500)),
              )).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOverallComment(AppColors colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.brand.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.brand.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: AppTheme.brand, size: 18),
              const SizedBox(width: 8),
              Text('AI 总评', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.brand)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            _overallComment!,
            style: TextStyle(fontSize: 13, color: colors.textPrimary, height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(AppColors colors) {
    return Row(
      children: [
        if (_completedSubmissionId != null)
          Expanded(
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () => _viewResult(_completedSubmissionId!),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.brand,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: const Text('查看详细报告', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        if (_completedSubmissionId != null) const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 48,
            child: OutlinedButton(
              onPressed: _resetGrading,
              style: OutlinedButton.styleFrom(
                foregroundColor: colors.textPrimary,
                side: BorderSide(color: colors.border),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(_currentPhase == 'error' ? '重新提交' : '继续批改'),
            ),
          ),
        ),
      ],
    );
  }
}

// ==================== 辅助类 ====================

enum _UploadStatus { uploading, success, failed }

class _UploadedImage {
  final String localPath;
  final String name;
  String? remoteUrl;
  _UploadStatus status;

  _UploadedImage({
    required this.localPath,
    required this.name,
    this.remoteUrl,
    this.status = _UploadStatus.uploading,
  });
}

class _ModeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final AppColors colors;
  final VoidCallback onTap;

  const _ModeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.brand.withValues(alpha: 0.05) : colors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.brand : colors.divider,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: isSelected ? AppTheme.brand : colors.iconSecondary, size: 24),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected ? AppTheme.brand : colors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(fontSize: 11, color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
