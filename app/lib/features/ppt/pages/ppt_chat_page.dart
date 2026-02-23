import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../config/app_theme.dart';
import '../services/ppt_generation_service.dart';
import '../services/ppt_cache_service.dart';
import '../widgets/ppt_message_bubble.dart';
import '../widgets/ppt_template_selector.dart';
import '../widgets/ppt_outline_card.dart';
import '../widgets/ppt_progress_card.dart';
import '../widgets/ppt_download_card.dart';
import '../widgets/ppt_slide_preview.dart';

class PptChatPage extends StatefulWidget {
  const PptChatPage({super.key});

  @override
  State<PptChatPage> createState() => _PptChatPageState();
}

class _PptChatPageState extends State<PptChatPage> {
  final _service = PptGenerationService();
  final _cacheService = PptCacheService();
  final _messages = <PptChatMessage>[];
  final _scrollController = ScrollController();
  final _inputController = TextEditingController();
  final _inputFocusNode = FocusNode();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // 会话管理
  List<PptSessionSummary> _sessions = [];
  bool _isLoadingSessions = false;

  // 会话状态
  String? _currentSessionId;
  PptPhase _phase = PptPhase.idle;
  String _statusMessage = '';

  // 意图
  String _intentTopic = '';

  // 大纲 tracked in messages

  // 模板
  List<PptTemplate> _templates = [];
  bool _isLoadingTemplates = false;

  // 生成进度
  List<GeneratedSlide> _generatedSlides = [];
  int _currentSlide = 0;
  int _totalSlides = 0;

  // 结果
  String _resultUrl = '';

  // UI 状态
  bool _isGenerating = false;
  StreamSubscription<PptSseEvent>? _sseSubscription;
  int _msgIdCounter = 0;

  // 快捷提示
  static const _quickPrompts = [
    '帮我做一个关于人工智能的PPT',
    '生成一份项目汇报演示文稿',
    '制作一个教学课件',
    '做一份产品介绍PPT',
  ];

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_onInputChanged);
    _loadSessions();
  }

  @override
  void dispose() {
    _sseSubscription?.cancel();
    _service.dispose();
    _scrollController.dispose();
    _inputController.removeListener(_onInputChanged);
    _inputController.dispose();
    _inputFocusNode.dispose();
    super.dispose();
  }

  void _onInputChanged() {
    setState(() {}); // refresh send button state
  }

  String _nextMsgId() => 'ppt_msg_${++_msgIdCounter}';

  void _addMessage(PptChatMessage msg) {
    setState(() => _messages.add(msg));
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ==================== 发送消息 ====================

  void _sendMessage(String content) {
    if (content.trim().isEmpty || _isGenerating) return;
    _inputController.clear();

    // 用户消息
    _addMessage(PptChatMessage(
      id: _nextMsgId(),
      type: PptMessageType.user,
      content: content.trim(),
    ));

    // AI 思考中
    final aiMsgId = _nextMsgId();
    _addMessage(PptChatMessage(
      id: aiMsgId,
      type: PptMessageType.aiText,
      isStreaming: true,
    ));

    setState(() {
      _isGenerating = true;
      _phase = PptPhase.detecting;
    });

    _sseSubscription?.cancel();
    _sseSubscription = _service.sendAction(
      action: 'detect_intent',
      sessionId: _currentSessionId,
      message: content.trim(),
    ).listen(
      (event) => _handleDetectIntentEvent(event, aiMsgId),
      onDone: () => setState(() => _isGenerating = false),
      onError: (e) {
        setState(() => _isGenerating = false);
        _addMessage(PptChatMessage(
          id: _nextMsgId(),
          type: PptMessageType.error,
          content: e.toString(),
        ));
      },
    );
  }

  void _handleDetectIntentEvent(PptSseEvent event, String aiMsgId) {
    switch (event.type) {
      case 'message':
        // 流式追加 AI 文本
        setState(() {
          final idx = _messages.indexWhere((m) => m.id == aiMsgId);
          if (idx >= 0) {
            _messages[idx].content += event.rawData;
          }
        });
        _scrollToBottom();
        break;

      case 'status':
        setState(() => _statusMessage = event.jsonData?['message'] as String? ?? '');
        break;

      case 'intent':
        final detected = event.jsonData?['detected'] == true;
        final topic = event.jsonData?['topic'] as String? ?? '';
        final sessionId = event.jsonData?['sessionId']?.toString();

        // 结束 AI 流式消息，清理 PPT_INTENT 标记
        setState(() {
          final idx = _messages.indexWhere((m) => m.id == aiMsgId);
          if (idx >= 0) {
            _messages[idx].isStreaming = false;
            _messages[idx].content = _messages[idx].content
                .replaceAll(RegExp(r'<<PPT_INTENT:.*?>>\s*'), '')
                .trim();
          }
        });

        if (detected) {
          setState(() {
            _intentTopic = topic.isNotEmpty ? topic : '';
            if (sessionId != null) _currentSessionId = sessionId;
            _phase = PptPhase.awaitingTemplate;
            _isGenerating = false;
          });

          _addMessage(PptChatMessage(
            id: _nextMsgId(),
            type: PptMessageType.status,
            content: '已识别 PPT 主题，请选择模板',
          ));

          // 自动加载模板并弹出选择
          _loadAndShowTemplates();
        } else {
          setState(() {
            _phase = PptPhase.idle;
            _isGenerating = false;
          });
        }
        break;

      case 'error':
        setState(() {
          _phase = PptPhase.error;
          _isGenerating = false;
          final idx = _messages.indexWhere((m) => m.id == aiMsgId);
          if (idx >= 0) _messages[idx].isStreaming = false;
        });
        _addMessage(PptChatMessage(
          id: _nextMsgId(),
          type: PptMessageType.error,
          content: event.rawData,
        ));
        break;
    }
  }

  // ==================== 模板选择 ====================

  Future<void> _loadAndShowTemplates() async {
    setState(() => _isLoadingTemplates = true);
    _templates = await _service.getTemplates();
    setState(() => _isLoadingTemplates = false);

    if (!mounted) return;
    _showTemplateSelector();
  }

  void _showTemplateSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PptTemplateSelector(
        templates: _templates,
        isLoading: _isLoadingTemplates,
        onSelect: (template) {
          Navigator.pop(context);
          _selectTemplate(template);
        },
        onUploadTemplate: (filePath, name) async {
          final id = await _service.uploadTemplate(filePath, name);
          if (id != null) {
            // 刷新模板列表
            final updated = await _service.getTemplates();
            setState(() => _templates = updated);
            return true;
          }
          return false;
        },
      ),
    );
  }

  void _selectTemplate(PptTemplate template) {
    _addMessage(PptChatMessage(
      id: _nextMsgId(),
      type: PptMessageType.status,
      content: '正在解析模板「${template.name}」...',
    ));

    setState(() {
      _phase = PptPhase.parsingTemplate;
      _isGenerating = true;
    });

    _sseSubscription?.cancel();
    _sseSubscription = _service.sendAction(
      action: 'select_template',
      sessionId: _currentSessionId,
      templateId: template.id,
    ).listen(
      _handleSelectTemplateEvent,
      onDone: () {},
      onError: (e) {
        setState(() {
          _isGenerating = false;
          _phase = PptPhase.error;
        });
      },
    );
  }

  void _handleSelectTemplateEvent(PptSseEvent event) {
    switch (event.type) {
      case 'status':
        setState(() => _statusMessage = event.jsonData?['message'] as String? ?? '');
        break;

      case 'template_parsed':
        setState(() => _phase = PptPhase.templateReady);

        _addMessage(PptChatMessage(
          id: _nextMsgId(),
          type: PptMessageType.status,
          content: '模板就绪，正在生成大纲...',
        ));

        // 自动开始生成大纲
        Future.delayed(const Duration(milliseconds: 300), _generateOutline);
        break;

      case 'error':
        setState(() {
          _phase = PptPhase.error;
          _isGenerating = false;
        });
        _addMessage(PptChatMessage(
          id: _nextMsgId(),
          type: PptMessageType.error,
          content: event.rawData,
        ));
        break;
    }
  }

  // ==================== 大纲生成 ====================

  void _generateOutline() {
    final aiMsgId = _nextMsgId();
    _addMessage(PptChatMessage(
      id: aiMsgId,
      type: PptMessageType.aiText,
      isStreaming: true,
    ));

    setState(() {
      _phase = PptPhase.generatingOutline;
      _isGenerating = true;
    });

    _sseSubscription?.cancel();
    _sseSubscription = _service.sendAction(
      action: 'generate_outline',
      sessionId: _currentSessionId,
      topic: _intentTopic,
    ).listen(
      (event) => _handleOutlineEvent(event, aiMsgId),
      onDone: () {},
      onError: (e) {
        setState(() {
          _isGenerating = false;
          _phase = PptPhase.error;
        });
      },
    );
  }

  void _handleOutlineEvent(PptSseEvent event, String aiMsgId) {
    switch (event.type) {
      case 'message':
        setState(() {
          final idx = _messages.indexWhere((m) => m.id == aiMsgId);
          if (idx >= 0) {
            _messages[idx].content += event.rawData;
          }
        });
        _scrollToBottom();
        break;

      case 'status':
        setState(() => _statusMessage = event.jsonData?['message'] as String? ?? '');
        break;

      case 'outline':
        final markdown = event.jsonData?['outline'] as String?
            ?? event.jsonData?['markdown'] as String?
            ?? event.rawData;
        final sessionId = event.jsonData?['sessionId']?.toString();

        setState(() {
          _phase = PptPhase.outlineReady;
          _isGenerating = false;
          if (sessionId != null) _currentSessionId = sessionId;

          // 结束流式消息
          final idx = _messages.indexWhere((m) => m.id == aiMsgId);
          if (idx >= 0) {
            _messages[idx].isStreaming = false;
            _messages[idx].content = '大纲已生成，请查看下方内容。';
          }
        });

        // 添加大纲卡片
        _addMessage(PptChatMessage(
          id: _nextMsgId(),
          type: PptMessageType.outlineCard,
          outlineMarkdown: markdown,
        ));
        break;

      case 'error':
        setState(() {
          _phase = PptPhase.error;
          _isGenerating = false;
          final idx = _messages.indexWhere((m) => m.id == aiMsgId);
          if (idx >= 0) _messages[idx].isStreaming = false;
        });
        _addMessage(PptChatMessage(
          id: _nextMsgId(),
          type: PptMessageType.error,
          content: event.rawData,
        ));
        break;
    }
  }

  // ==================== 大纲确认/修改 ====================

  void _confirmOutline() {
    // 标记大纲已确认
    setState(() {
      for (final msg in _messages) {
        if (msg.type == PptMessageType.outlineCard && !msg.outlineConfirmed) {
          msg.outlineConfirmed = true;
        }
      }
      _isGenerating = true;
    });

    _addMessage(PptChatMessage(
      id: _nextMsgId(),
      type: PptMessageType.status,
      content: '大纲已确认，开始生成幻灯片...',
    ));

    _sseSubscription?.cancel();
    _sseSubscription = _service.sendAction(
      action: 'confirm_outline',
      sessionId: _currentSessionId,
    ).listen(
      _handleConfirmOutlineEvent,
      onDone: () {},
      onError: (e) {
        setState(() {
          _isGenerating = false;
          _phase = PptPhase.error;
        });
      },
    );
  }

  void _handleConfirmOutlineEvent(PptSseEvent event) {
    switch (event.type) {
      case 'status':
        setState(() => _statusMessage = event.jsonData?['message'] as String? ?? '');
        break;
      case 'outline_confirmed':
        final sessionId = event.jsonData?['sessionId']?.toString();
        if (sessionId != null) setState(() => _currentSessionId = sessionId);
        break;
      case 'done':
        // 确认后自动生成 slides
        Future.delayed(const Duration(milliseconds: 300), _generatePpt);
        break;
      case 'error':
        setState(() {
          _phase = PptPhase.error;
          _isGenerating = false;
        });
        _addMessage(PptChatMessage(
          id: _nextMsgId(),
          type: PptMessageType.error,
          content: event.rawData,
        ));
        break;
    }
  }

  void _reviseOutline(String feedback) {
    _addMessage(PptChatMessage(
      id: _nextMsgId(),
      type: PptMessageType.user,
      content: feedback,
    ));

    final aiMsgId = _nextMsgId();
    _addMessage(PptChatMessage(
      id: aiMsgId,
      type: PptMessageType.aiText,
      isStreaming: true,
    ));

    setState(() {
      _phase = PptPhase.generatingOutline;
      _isGenerating = true;
    });

    _sseSubscription?.cancel();
    _sseSubscription = _service.sendAction(
      action: 'revise_outline',
      sessionId: _currentSessionId,
      feedback: feedback,
    ).listen(
      (event) => _handleOutlineEvent(event, aiMsgId),
      onDone: () {},
      onError: (e) {
        setState(() {
          _isGenerating = false;
          _phase = PptPhase.error;
        });
      },
    );
  }

  // ==================== 生成 PPT ====================

  void _generatePpt() {
    // 添加进度卡片
    final progressMsgId = _nextMsgId();
    _addMessage(PptChatMessage(
      id: progressMsgId,
      type: PptMessageType.progressCard,
      progressCurrent: 0,
      progressTotal: 0,
    ));

    setState(() {
      _phase = PptPhase.generatingSlides;
      _generatedSlides = [];
      _currentSlide = 0;
      _totalSlides = 0;
      _isGenerating = true;
    });

    _sseSubscription?.cancel();
    _sseSubscription = _service.sendAction(
      action: 'generate_ppt',
      sessionId: _currentSessionId,
    ).listen(
      (event) => _handleGeneratePptEvent(event, progressMsgId),
      onDone: () {},
      onError: (e) {
        setState(() {
          _isGenerating = false;
          _phase = PptPhase.error;
        });
      },
    );
  }

  void _handleGeneratePptEvent(PptSseEvent event, String progressMsgId) {
    switch (event.type) {
      case 'status':
        final phase = event.jsonData?['phase'] as String?;
        setState(() {
          _statusMessage = event.jsonData?['message'] as String? ?? '';
          if (phase == 'assembling') _phase = PptPhase.assembling;
        });
        break;

      case 'slide_progress':
        final current = event.jsonData?['current'] as int? ?? 0;
        final total = event.jsonData?['total'] as int? ?? 0;
        final previewUrl = event.jsonData?['previewImageUrl'] as String?;

        setState(() {
          _generatedSlides.add(GeneratedSlide(
            previewImageUrl: previewUrl,
            isNew: true,
          ));
          _currentSlide = current;
          _totalSlides = total;

          // 更新进度卡片
          final idx = _messages.indexWhere((m) => m.id == progressMsgId);
          if (idx >= 0) {
            _messages[idx].progressCurrent = current;
            _messages[idx].progressTotal = total;
          }
        });
        _scrollToBottom();

        // 清除 isNew 动画标记
        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted) {
            setState(() {
              if (_generatedSlides.isNotEmpty) {
                _generatedSlides.last.isNew = false;
              }
            });
          }
        });
        break;

      case 'result':
        final url = event.jsonData?['fileUrl'] as String?
            ?? event.jsonData?['file_url'] as String?
            ?? '';
        final name = event.jsonData?['fileName'] as String?
            ?? event.jsonData?['file_name'] as String?
            ?? '';

        setState(() {
          _phase = PptPhase.completed;
          _resultUrl = url;
          _isGenerating = false;
        });

        _addMessage(PptChatMessage(
          id: _nextMsgId(),
          type: PptMessageType.downloadCard,
          downloadUrl: url,
          downloadFileName: name,
        ));

        // 缓存幻灯片预览图
        if (_currentSessionId != null && _generatedSlides.isNotEmpty) {
          _cacheService.cacheSlideImages(
            _currentSessionId!,
            _generatedSlides.map((s) => s.previewImageUrl).toList(),
          );
        }
        break;

      case 'done':
        setState(() {
          if (_resultUrl.isNotEmpty) {
            _phase = PptPhase.completed;
            _isGenerating = false;
          }
        });
        break;

      case 'error':
        setState(() {
          _phase = PptPhase.error;
          _isGenerating = false;
        });
        _addMessage(PptChatMessage(
          id: _nextMsgId(),
          type: PptMessageType.error,
          content: event.rawData,
        ));
        break;
    }
  }

  // ==================== 中止 ====================

  void _abort() {
    _sseSubscription?.cancel();
    _service.abort();
    setState(() {
      _isGenerating = false;
      // 结束所有流式消息
      for (final msg in _messages) {
        if (msg.isStreaming) msg.isStreaming = false;
      }
    });
  }

  // ==================== 会话管理 ====================

  Future<void> _loadSessions() async {
    setState(() => _isLoadingSessions = true);
    // 先从缓存加载，快速显示
    final cached = await _cacheService.getCachedSessions();
    if (cached.isNotEmpty && _sessions.isEmpty) {
      _sessions = cached.map((e) => PptSessionSummary.fromJson(e)).toList();
      setState(() {});
    }
    // 再从网络刷新
    final fresh = await _service.getSessions();
    _sessions = fresh;
    // 缓存到本地
    if (fresh.isNotEmpty) {
      _cacheService.cacheSessions(fresh.map((s) => {
        'id': s.id,
        'topic': s.topic,
        'state': s.state,
        'resultUrl': s.resultUrl,
        'createTime': s.createTime,
        'updateTime': s.updateTime,
      }).toList());
    }
    setState(() => _isLoadingSessions = false);
  }

  void _startNewSession() {
    _abort();
    setState(() {
      _messages.clear();
      _currentSessionId = null;
      _phase = PptPhase.idle;
      _statusMessage = '';
      _intentTopic = '';
      _generatedSlides.clear();
      _currentSlide = 0;
      _totalSlides = 0;
      _resultUrl = '';
    });
  }

  Future<void> _openSession(PptSessionSummary session) async {
    _abort();
    setState(() {
      _messages.clear();
      _currentSessionId = session.id;
      _generatedSlides.clear();
      _currentSlide = 0;
      _totalSlides = 0;
      _resultUrl = '';
      _statusMessage = '正在加载会话...';
    });

    final detail = await _service.getSessionDetail(session.id);
    if (detail == null || !mounted) {
      setState(() => _statusMessage = '');
      return;
    }

    // Reconstruct messages from session detail
    final msgs = <PptChatMessage>[];

    // 1. User topic
    msgs.add(PptChatMessage(
      id: _nextMsgId(),
      type: PptMessageType.user,
      content: detail.topic,
    ));

    // 2. Outline
    if (detail.outlineMarkdown != null && detail.outlineMarkdown!.isNotEmpty) {
      msgs.add(PptChatMessage(
        id: _nextMsgId(),
        type: PptMessageType.aiText,
        content: '大纲已生成，请查看下方内容。',
      ));
      msgs.add(PptChatMessage(
        id: _nextMsgId(),
        type: PptMessageType.outlineCard,
        outlineMarkdown: detail.outlineMarkdown,
        outlineConfirmed: true,
      ));
    }

    // 3. Slides preview from slidesJson (fallback to local cache)
    List<GeneratedSlide> slides = [];
    if (detail.slidesJson != null && detail.slidesJson!.isNotEmpty) {
      try {
        final parsed = jsonDecode(detail.slidesJson!) as List;
        slides = parsed.map((item) {
          final map = item as Map<String, dynamic>;
          return GeneratedSlide(
            previewImageUrl: map['previewImageUrl'] as String? ?? '',
          );
        }).toList();
      } catch (_) {}
    }
    if (slides.isEmpty) {
      final cachedUrls = await _cacheService.getCachedSlideImages(session.id);
      if (cachedUrls.isNotEmpty) {
        slides = cachedUrls.map((url) => GeneratedSlide(previewImageUrl: url)).toList();
      }
    }

    // 4. Result
    if (detail.resultUrl != null && detail.resultUrl!.isNotEmpty) {
      msgs.add(PptChatMessage(
        id: _nextMsgId(),
        type: PptMessageType.downloadCard,
        downloadUrl: detail.resultUrl,
        downloadFileName: '${detail.topic}.pptx',
      ));
    }

    // Determine phase
    PptPhase phase = PptPhase.idle;
    final stateStr = detail.state.toLowerCase();
    if (stateStr == 'completed') {
      phase = PptPhase.completed;
    } else if (stateStr == 'outline_ready') {
      phase = PptPhase.outlineReady;
    } else if (stateStr == 'failed') {
      phase = PptPhase.error;
    }

    setState(() {
      _messages.addAll(msgs);
      _phase = phase;
      _intentTopic = detail.topic;
      _resultUrl = detail.resultUrl ?? '';
      _generatedSlides = slides;
      _currentSlide = slides.length;
      _totalSlides = slides.length;
      _statusMessage = '';
    });
    _scrollToBottom();
  }

  Future<void> _deleteSession(String sessionId) async {
    final ok = await _service.deleteSession(sessionId);
    if (ok) {
      setState(() => _sessions.removeWhere((s) => s.id == sessionId));
      if (_currentSessionId == sessionId) _startNewSession();
    }
  }

  void _showHistoryDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  // ==================== Build ====================

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colors.background,
      appBar: _buildAppBar(colors),
      endDrawer: _buildHistoryDrawer(colors),
      body: Column(
        children: [
          Expanded(child: _buildMessageList(colors)),
          // 幻灯片预览条（生成中或已完成时显示）
          if (_generatedSlides.isNotEmpty)
            PptSlidePreview(
              slides: _generatedSlides,
              currentSlide: _currentSlide,
              totalSlides: _totalSlides,
              colors: colors,
              onReorder: _phase == PptPhase.completed ? (reordered) {
                setState(() => _generatedSlides = reordered);
              } : null,
            ),
          _buildInputBar(colors),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(AppColors colors) {
    return AppBar(
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 0,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppTheme.brand.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(PhosphorIcons.presentation(PhosphorIconsStyle.fill), size: 17, color: AppTheme.brand),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI PPT 助手',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
                if (_statusMessage.isNotEmpty)
                  Text(
                    _statusMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11, color: colors.textTertiary, height: 1.3),
                  ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(PhosphorIcons.clockCounterClockwise(), color: colors.iconPrimary, size: 22),
          tooltip: '历史会话',
          onPressed: () {
            _loadSessions();
            _showHistoryDrawer();
          },
        ),
        if (_currentSessionId != null)
          IconButton(
            icon: Icon(PhosphorIcons.plusCircle(), color: AppTheme.brand, size: 22),
            tooltip: '新建会话',
            onPressed: _startNewSession,
          ),
        const SizedBox(width: 4),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 0.5, color: colors.divider.withValues(alpha: 0.5)),
      ),
    );
  }

  Widget _buildHistoryDrawer(AppColors colors) {
    return Drawer(
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 16, 10),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppTheme.brand.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Icon(PhosphorIcons.clockCounterClockwise(), size: 15, color: AppTheme.brand),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '历史会话',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(PhosphorIcons.plusCircle(), size: 22, color: AppTheme.brand),
                    tooltip: '新建会话',
                    onPressed: () {
                      Navigator.pop(context);
                      _startNewSession();
                    },
                  ),
                ],
              ),
            ),
            Container(height: 0.5, color: colors.divider.withValues(alpha: 0.5)),
            Expanded(
              child: _isLoadingSessions
                  ? Center(child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.brand.withValues(alpha: 0.6)))
                  : _sessions.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: colors.surfaceVariant.withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(PhosphorIcons.tray(), size: 26, color: colors.iconSecondary),
                              ),
                              const SizedBox(height: 12),
                              Text('暂无历史会话', style: TextStyle(fontSize: 14, color: colors.textTertiary)),
                              const SizedBox(height: 4),
                              Text('开始对话即可创建', style: TextStyle(fontSize: 12, color: colors.textTertiary.withValues(alpha: 0.6))),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: _sessions.length,
                          itemBuilder: (context, index) {
                            final session = _sessions[index];
                            final isCurrent = session.id == _currentSessionId;
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    _openSession(session);
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: isCurrent ? AppTheme.brand.withValues(alpha: 0.06) : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 38,
                                          height: 38,
                                          decoration: BoxDecoration(
                                            color: session.isCompleted
                                                ? AppTheme.green.withValues(alpha: 0.1)
                                                : AppTheme.brand.withValues(alpha: 0.08),
                                            borderRadius: BorderRadius.circular(11),
                                          ),
                                          child: Icon(
                                            session.isCompleted ? PhosphorIcons.checkCircle(PhosphorIconsStyle.fill) : PhosphorIcons.presentation(),
                                            size: 18,
                                            color: session.isCompleted ? AppTheme.green : AppTheme.brand,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                session.topic.isNotEmpty ? session.topic : '未命名',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w500,
                                                  color: isCurrent ? AppTheme.brand : colors.textPrimary,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                session.createTime ?? '',
                                                style: TextStyle(fontSize: 11, color: colors.textTertiary),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(PhosphorIcons.trash(), size: 18, color: colors.textTertiary.withValues(alpha: 0.6)),
                                          onPressed: () => _deleteSession(session.id),
                                          splashRadius: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList(AppColors colors) {
    if (_messages.isEmpty) {
      return _buildEmptyState(colors);
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final msg = _messages[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildMessageWidget(msg, colors),
        );
      },
    );
  }

  Widget _buildMessageWidget(PptChatMessage msg, AppColors colors) {
    switch (msg.type) {
      case PptMessageType.user:
      case PptMessageType.aiText:
      case PptMessageType.status:
      case PptMessageType.error:
        return PptMessageBubble(message: msg, colors: colors);

      case PptMessageType.outlineCard:
        return PptOutlineCard(
          markdown: msg.outlineMarkdown ?? '',
          isConfirmed: msg.outlineConfirmed,
          colors: colors,
          onConfirm: msg.outlineConfirmed ? null : _confirmOutline,
          onRevise: msg.outlineConfirmed ? null : _reviseOutline,
          onOutlineEdited: msg.outlineConfirmed ? null : (edited) {
            setState(() => msg.outlineMarkdown = edited);
          },
        );

      case PptMessageType.progressCard:
        return PptProgressCard(
          current: msg.progressCurrent ?? 0,
          total: msg.progressTotal ?? 0,
          colors: colors,
        );

      case PptMessageType.downloadCard:
        return PptDownloadCard(
          url: msg.downloadUrl ?? '',
          fileName: msg.downloadFileName,
          colors: colors,
        );

      case PptMessageType.templateSelector:
      case PptMessageType.slidePreview:
        return const SizedBox.shrink();
    }
  }

  Widget _buildEmptyState(AppColors colors) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.brand.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(PhosphorIcons.presentation(PhosphorIconsStyle.duotone), size: 40, color: AppTheme.brand),
            ),
            const SizedBox(height: 24),
            Text(
              'AI PPT 助手',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: colors.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '描述你的需求，AI 自动生成精美演示文稿',
              style: TextStyle(fontSize: 14, color: colors.textSecondary, height: 1.4),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 8,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: _quickPrompts.map((text) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _sendMessage(text),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: colors.divider),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(PhosphorIcons.lightning(), size: 14, color: AppTheme.brand.withValues(alpha: 0.6)),
                          const SizedBox(width: 6),
                          Text(
                            text,
                            style: TextStyle(fontSize: 13, color: colors.textPrimary, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBar(AppColors colors) {
    final showQuickTemplateButton = _phase == PptPhase.awaitingTemplate && !_isGenerating;

    return Container(
      padding: EdgeInsets.only(
        left: 14,
        right: 14,
        top: 10,
        bottom: MediaQuery.of(context).padding.bottom + 10,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showQuickTemplateButton)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _showTemplateSelector,
                  icon: Icon(PhosphorIcons.swatches(), size: 18),
                  label: const Text('重新选择模板'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.brand,
                    side: BorderSide(color: AppTheme.brand.withValues(alpha: 0.3)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 120),
                  decoration: BoxDecoration(
                    color: colors.surfaceVariant.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    controller: _inputController,
                    focusNode: _inputFocusNode,
                    maxLines: 5,
                    minLines: 1,
                    enabled: !_isGenerating,
                    style: TextStyle(fontSize: 15, color: colors.textPrimary, height: 1.4),
                    decoration: InputDecoration(
                      hintText: _phase == PptPhase.idle
                          ? '输入 PPT 主题或需求...'
                          : '输入补充说明...',
                      hintStyle: TextStyle(color: colors.textTertiary, fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    ),
                    onSubmitted: (val) => _sendMessage(val),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              _buildSendButton(colors),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton(AppColors colors) {
    if (_isGenerating) {
      return GestureDetector(
        onTap: _abort,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: AppTheme.red.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(PhosphorIcons.stop(PhosphorIconsStyle.fill), color: Colors.white, size: 22),
        ),
      );
    }

    final hasInput = _inputController.text.trim().isNotEmpty;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        gradient: hasInput
            ? const LinearGradient(
                colors: [Color(0xFF007BFF), Color(0xFF0069D9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: hasInput ? null : colors.surfaceVariant,
        borderRadius: BorderRadius.circular(22),
        boxShadow: hasInput
            ? [
                BoxShadow(
                  color: AppTheme.brand.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: hasInput ? () => _sendMessage(_inputController.text) : null,
          borderRadius: BorderRadius.circular(22),
          child: Icon(
            PhosphorIcons.arrowUp(),
            color: hasInput ? Colors.white : colors.textTertiary,
            size: 22,
          ),
        ),
      ),
    );
  }
}
