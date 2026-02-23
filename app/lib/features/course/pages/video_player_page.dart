import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nova_api/nova_api.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/toast/nova_message.dart';
import '../services/course_service.dart';
import '../services/course_progress_service.dart';
import '../services/video_service.dart';

/// 视频播放页 - 参考 web CourseLessonPage.tsx
class VideoPlayerPage extends StatefulWidget {
  final int courseId;
  final int initialSectionId;

  const VideoPlayerPage({
    super.key,
    required this.courseId,
    required this.initialSectionId,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  final CourseService _courseService = CourseService();
  final CourseProgressService _progressService = CourseProgressService();
  final VideoService _videoService = VideoService();

  CourseStructureResponse? _structure;
  bool _loading = true;
  bool _sidebarOpen = false;

  // 扁平化的小节列表
  List<_FlatSection> _flatSections = [];
  int _currentIndex = -1;
  int _currentSectionId = 0;

  // 已完成的小节集合
  final Set<int> _completedSections = {};

  // 视频播放器
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  // 进度上报计时器
  Timer? _progressTimer;
  int _lastSaveTime = 0;

  // 断点续播位置
  int _initialSeek = 0;

  @override
  void initState() {
    super.initState();
    _currentSectionId = widget.initialSectionId;
    _fetchData();
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    _saveProgressNow();
    _chewieController?.dispose();
    _videoController?.dispose();
    // 恢复竖屏
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  Future<void> _fetchData() async {
    setState(() => _loading = true);
    try {
      final structure = await _courseService.getCourseStructure(widget.courseId);
      if (!mounted) return;

      // 构建扁平列表
      final chapters = (structure.chapters ?? BuiltList<ChapterResponse>()).toList()
        ..sort((a, b) => (a.sort ?? 0).compareTo(b.sort ?? 0));
      final flat = <_FlatSection>[];
      for (final ch in chapters) {
        final sections = (ch.sections ?? BuiltList<SectionResponse>()).toList()
          ..sort((a, b) => (a.sort ?? 0).compareTo(b.sort ?? 0));
        for (final sec in sections) {
          flat.add(_FlatSection(section: sec, chapter: ch));
        }
      }

      final currentIdx = flat.indexWhere((f) => f.section.id == _currentSectionId);

      setState(() {
        _structure = structure;
        _flatSections = flat;
        _currentIndex = currentIdx >= 0 ? currentIdx : 0;
        if (_currentIndex >= 0 && _currentIndex < flat.length) {
          _currentSectionId = flat[_currentIndex].section.id!;
        }
      });

      // 加载进度
      await _loadProgress();
      // 初始化播放器
      await _initPlayer();

      setState(() => _loading = false);
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        NovaMessage.error(context, '加载课程失败');
      }
    }
  }

  Future<void> _loadProgress() async {
    try {
      final progressList = await _progressService.getCourseProgress(widget.courseId);
      int seekPos = 0;
      for (final p in progressList) {
        if (p.isCompleted == true && p.sectionId != null) {
          _completedSections.add(p.sectionId!);
        }
        if (p.sectionId == _currentSectionId && p.lastPosition != null) {
          seekPos = p.lastPosition!;
        }
      }
      _initialSeek = seekPos;
    } catch (_) {}
  }

  Future<void> _initPlayer() async {
    final section = _currentSection;
    if (section == null) return;

    _chewieController?.dispose();
    _videoController?.dispose();
    _progressTimer?.cancel();

    // 异步获取带 stream token 的 HLS URL
    final videoUrl = await _videoService.getHlsStreamUrl(_currentSectionId);
    if (!mounted) return;

    if (videoUrl == null || videoUrl.isEmpty) {
      NovaMessage.error(context, '获取视频地址失败');
      return;
    }

    final uri = Uri.parse(videoUrl);
    _videoController = VideoPlayerController.networkUrl(uri);

    _videoController!.initialize().then((_) {
      if (!mounted) return;

      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControlsOnInitialize: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppTheme.brand,
          handleColor: AppTheme.brand,
          bufferedColor: AppTheme.brand.withOpacity(0.3),
          backgroundColor: Colors.white24,
        ),
      );

      // 断点续播
      if (_initialSeek > 0) {
        _videoController!.seekTo(Duration(seconds: _initialSeek));
      }

      // 监听播放完成
      _videoController!.addListener(_onVideoStateChanged);

      // 启动进度上报计时器
      _progressTimer = Timer.periodic(const Duration(seconds: 10), (_) {
        _saveProgressNow();
      });

      setState(() {});
    }).catchError((e) {
      if (mounted) {
        NovaMessage.error(context, '视频加载失败');
      }
    });
  }

  void _onVideoStateChanged() {
    if (_videoController == null) return;
    final value = _videoController!.value;

    // 播放完毕
    if (value.position >= value.duration && value.duration > Duration.zero) {
      _handleVideoCompleted();
    }
  }

  void _handleVideoCompleted() {
    // 标记完成
    if (!_completedSections.contains(_currentSectionId)) {
      _markComplete();
    }
    // 1.5秒后自动下一节
    if (_currentIndex < _flatSections.length - 1) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) _goNext();
      });
    }
  }

  void _saveProgressNow() {
    if (_videoController == null || !_videoController!.value.isInitialized) return;

    final position = _videoController!.value.position.inSeconds;
    final duration = _videoController!.value.duration.inSeconds;
    if (duration <= 0) return;

    // 防重
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastSaveTime < 5000) return;
    _lastSaveTime = now;

    final progress = ((position / duration) * 100).round().clamp(0, 100);

    _progressService.updateProgress(
      courseId: widget.courseId,
      sectionId: _currentSectionId,
      lastPosition: position,
      watchDuration: position,
      progress: progress,
    );

    // 自动标记完成 (>=90%)
    if (progress >= 90 && !_completedSections.contains(_currentSectionId)) {
      _markComplete();
    }
  }

  Future<void> _markComplete() async {
    try {
      await _progressService.completeSection(
        sectionId: _currentSectionId,
        courseId: widget.courseId,
      );
      if (mounted) {
        setState(() => _completedSections.add(_currentSectionId));
      }
    } catch (_) {}
  }

  Future<void> _handleMarkComplete() async {
    if (_completedSections.contains(_currentSectionId)) return;
    try {
      await _progressService.completeSection(
        sectionId: _currentSectionId,
        courseId: widget.courseId,
      );
      if (mounted) {
        setState(() => _completedSections.add(_currentSectionId));
        NovaMessage.success(context, '已标记完成');
      }
    } catch (e) {
      if (mounted) NovaMessage.error(context, '操作失败');
    }
  }

  Future<void> _goToSection(int index) async {
    if (index < 0 || index >= _flatSections.length) return;
    final section = _flatSections[index].section;

    if (section.accessible != true) {
      NovaMessage.warning(context, '此小节需要购买课程后观看');
      return;
    }

    _saveProgressNow();
    setState(() {
      _currentIndex = index;
      _currentSectionId = section.id!;
      _initialSeek = 0;
      _sidebarOpen = false;
    });
    await _initPlayer();
  }

  void _goPrev() {
    if (_currentIndex > 0) _goToSection(_currentIndex - 1);
  }

  void _goNext() {
    if (_currentIndex < _flatSections.length - 1) _goToSection(_currentIndex + 1);
  }

  SectionResponse? get _currentSection =>
      _currentIndex >= 0 && _currentIndex < _flatSections.length
          ? _flatSections[_currentIndex].section
          : null;

  ChapterResponse? get _currentChapter =>
      _currentIndex >= 0 && _currentIndex < _flatSections.length
          ? _flatSections[_currentIndex].chapter
          : null;

  int get _completionPercent =>
      _flatSections.isNotEmpty
          ? ((_completedSections.length / _flatSections.length) * 100).round()
          : 0;

  // ==================== UI ====================

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: Colors.black,
      body: _loading
          ? _buildLoading()
          : Column(
              children: [
                // 顶栏
                _buildTopBar(colors),
                // 播放器
                Expanded(child: _buildPlayer(colors)),
                // 底部信息栏
                _buildBottomBar(colors),
              ],
            ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.brand),
            ),
          ),
          SizedBox(height: 12),
          Text('加载课程中...', style: TextStyle(color: Colors.white54, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildTopBar(AppColors colors) {
    return Container(
      padding: EdgeInsets.fromLTRB(4, MediaQuery.of(context).padding.top, 8, 0),
      color: Colors.black,
      child: Row(
        children: [
          // 返回
          IconButton(
            icon: Icon(PhosphorIcons.arrowLeft(), color: Colors.white70, size: 22),
            onPressed: () => Navigator.pop(context),
          ),
          // 面包屑
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    _structure?.course?.title ?? '',
                    style: const TextStyle(color: Colors.white54, fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                if (_currentChapter != null) ...[
                  Icon(PhosphorIcons.caretRight(), size: 16, color: Colors.white30),
                  Flexible(
                    child: Text(
                      _currentSection?.title ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ],
            ),
          ),
          // 进度指示器
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$_completionPercent%',
              style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 4),
          // 目录按钮
          IconButton(
            icon: Icon(PhosphorIcons.list(), color: Colors.white70, size: 22),
            onPressed: () => setState(() => _sidebarOpen = !_sidebarOpen),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayer(AppColors colors) {
    final videoUrl = _currentSection?.hlsUrl ?? _currentSection?.videoUrl;

    return Stack(
      children: [
        // 播放器
        if (_chewieController != null && _videoController!.value.isInitialized)
          Center(
            child: AspectRatio(
              aspectRatio: _videoController!.value.aspectRatio,
              child: Chewie(controller: _chewieController!),
            ),
          )
        else if (videoUrl != null && videoUrl.isNotEmpty)
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.brand),
            ),
          )
        else
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(PhosphorIcons.videoCameraSlash(), size: 48, color: Colors.white.withOpacity(0.3)),
                const SizedBox(height: 12),
                const Text('该小节暂无视频', style: TextStyle(color: Colors.white38, fontSize: 14)),
              ],
            ),
          ),

        // 目录侧边栏
        if (_sidebarOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: () => setState(() => _sidebarOpen = false),
              child: Container(color: Colors.black54),
            ),
          ),
        if (_sidebarOpen)
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            width: 300,
            child: _buildSidebar(colors),
          ),
      ],
    );
  }

  Widget _buildBottomBar(AppColors colors) {
    final section = _currentSection;
    final isCompleted = _completedSections.contains(_currentSectionId);

    return Container(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10 + MediaQuery.of(context).padding.bottom),
      color: const Color(0xFF1A1A1A),
      child: Row(
        children: [
          // 小节信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        section?.title ?? '请选择小节',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (section?.duration != null && section!.duration! > 0) ...[
                      const SizedBox(width: 8),
                      Text(
                        _formatDuration(section.duration!),
                        style: const TextStyle(color: Colors.white38, fontSize: 12),
                      ),
                    ],
                  ],
                ),
                if (section?.description != null && section!.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      section.description!,
                      style: const TextStyle(color: Colors.white30, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),
          // 操作按钮
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 上一节
              IconButton(
                icon: Icon(PhosphorIcons.skipBack(PhosphorIconsStyle.fill),
                    size: 24,
                    color: _currentIndex > 0 ? Colors.white70 : Colors.white.withOpacity(0.2)),
                onPressed: _currentIndex > 0 ? _goPrev : null,
              ),
              // 下一节
              IconButton(
                icon: Icon(PhosphorIcons.skipForward(PhosphorIconsStyle.fill),
                    size: 24,
                    color: _currentIndex < _flatSections.length - 1
                        ? Colors.white70
                        : Colors.white.withOpacity(0.2)),
                onPressed: _currentIndex < _flatSections.length - 1 ? _goNext : null,
              ),
              Container(width: 1, height: 20, color: Colors.white12),
              const SizedBox(width: 4),
              // 标记完成
              GestureDetector(
                onTap: isCompleted ? null : _handleMarkComplete,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? Colors.green.withOpacity(0.15)
                        : Colors.white10,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        PhosphorIcons.checkCircle(),
                        size: 14,
                        color: isCompleted ? Colors.green : Colors.white54,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isCompleted ? '已完成' : '完成',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isCompleted ? Colors.green : Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(AppColors colors) {
    final chapters = (_structure?.chapters ?? BuiltList<ChapterResponse>()).toList()
      ..sort((a, b) => (a.sort ?? 0).compareTo(b.sort ?? 0));

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(-4, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // 标题栏 - 优化样式
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 12, 12),
            decoration: BoxDecoration(
              color: const Color(0xFF252525),
              border: Border(
                bottom: BorderSide(color: Colors.white.withOpacity(0.06)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '课程目录',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '进度与章节',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.95),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppTheme.brand.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.brand.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '${_completedSections.length}/${_flatSections.length}',
                    style: const TextStyle(
                      color: AppTheme.brand,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 进度条 - 优化样式
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '学习进度',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      '$_completionPercent%',
                      style: const TextStyle(
                        color: AppTheme.brand,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: _completionPercent / 100.0,
                    backgroundColor: Colors.white.withOpacity(0.08),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.brand.withOpacity(0.9),
                    ),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
          // 章节列表
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: chapters.length,
              itemBuilder: (context, ci) {
                final chapter = chapters[ci];
                final sections = (chapter.sections ?? BuiltList<SectionResponse>()).toList()
                  ..sort((a, b) => (a.sort ?? 0).compareTo(b.sort ?? 0));
                final chapterCompleted =
                    sections.where((s) => _completedSections.contains(s.id)).length;

                return _buildSidebarChapter(chapter, sections, ci, chapterCompleted);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarChapter(
    ChapterResponse chapter,
    List<SectionResponse> sections,
    int index,
    int completedCount,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF252525),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 章节标题 - 卡片头部
          Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
            decoration: BoxDecoration(
              color: AppTheme.brand.withOpacity(0.06),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                // 章节序号
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: AppTheme.brand.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: AppTheme.brand,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // 章节标题
                Expanded(
                  child: Text(
                    chapter.title ?? '',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // 完成进度标签
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: completedCount == sections.length
                        ? Colors.green.withOpacity(0.12)
                        : Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '$completedCount/${sections.length}',
                    style: TextStyle(
                      color: completedCount == sections.length
                          ? Colors.green
                          : Colors.white.withOpacity(0.5),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 小节列表 - 分割线
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.05),
          ),
          // 小节列表
          ...sections.asMap().entries.map((entry) {
            final si = entry.key;
            final section = entry.value;
            final isCurrent = section.id == _currentSectionId;
            final isCompleted = _completedSections.contains(section.id);
            final flatIdx = _flatSections.indexWhere((f) => f.section.id == section.id);
            final isLast = si == sections.length - 1;

            return Column(
              children: [
                InkWell(
                  onTap: () => _goToSection(flatIdx),
                  borderRadius: BorderRadius.vertical(
                    bottom: isLast ? const Radius.circular(12) : Radius.zero,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isCurrent
                          ? AppTheme.brand.withOpacity(0.12)
                          : null,
                      borderRadius: BorderRadius.vertical(
                        bottom: isLast ? const Radius.circular(12) : Radius.zero,
                      ),
                      border: isCurrent
                          ? Border(
                              left: BorderSide(
                                color: AppTheme.brand,
                                width: 3,
                              ),
                            )
                          : null,
                    ),
                    child: Row(
                      children: [
                        // 状态图标 - 优化样式
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? Colors.green.withOpacity(0.15)
                                : isCurrent
                                    ? AppTheme.brand.withOpacity(0.2)
                                    : Colors.white.withOpacity(0.06),
                            shape: BoxShape.circle,
                            border: isCurrent
                                ? Border.all(
                                    color: AppTheme.brand.withOpacity(0.5),
                                    width: 1.5,
                                  )
                                : null,
                          ),
                          child: Center(
                            child: isCompleted
                                ? Icon(
                                    PhosphorIcons.check(),
                                    size: 14,
                                    color: Colors.green,
                                  )
                                : isCurrent
                                    ? Icon(
                                        PhosphorIcons.play(PhosphorIconsStyle.fill),
                                        size: 16,
                                        color: AppTheme.brand,
                                      )
                                    : Text(
                                        '${si + 1}',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.4),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // 标题
                        Expanded(
                          child: Text(
                            section.title ?? '',
                            style: TextStyle(
                              fontSize: 13,
                              color: isCurrent
                                  ? AppTheme.brand
                                  : isCompleted
                                      ? Colors.white.withOpacity(0.5)
                                      : Colors.white.withOpacity(0.75),
                              fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // 时长
                        if (section.duration != null && section.duration! > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: isCurrent
                                  ? AppTheme.brand.withOpacity(0.15)
                                  : Colors.white.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _formatDuration(section.duration!),
                              style: TextStyle(
                                color: isCurrent
                                    ? AppTheme.brand.withOpacity(0.9)
                                    : Colors.white.withOpacity(0.4),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                // 小节分隔线（不是最后一个）
                if (!isLast)
                  Container(
                    margin: const EdgeInsets.only(left: 50),
                    height: 1,
                    color: Colors.white.withOpacity(0.05),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  String _formatDuration(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    if (m > 0) {
      return '$m:${s.toString().padLeft(2, '0')}';
    }
    return '0:${s.toString().padLeft(2, '0')}';
  }
}

/// 扁平化的小节数据
class _FlatSection {
  final SectionResponse section;
  final ChapterResponse chapter;

  const _FlatSection({required this.section, required this.chapter});
}
