import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:nova_api/nova_api.dart';
import 'package:markdown_widget/markdown_widget.dart';
import '../services/book_ai_service.dart';
import 'reader_settings_sheet.dart';

/// AI 助手面板 - 底部弹出，包含总结/知识点/问答/测验 4 个 Tab
class ReaderAiPanel extends StatefulWidget {
  final int bookId;
  final int? chapterId;
  final int chapterIndex;
  final int userId;
  final ReaderThemeColors themeColors;

  const ReaderAiPanel({
    super.key,
    required this.bookId,
    this.chapterId,
    required this.chapterIndex,
    required this.userId,
    required this.themeColors,
  });

  @override
  State<ReaderAiPanel> createState() => _ReaderAiPanelState();
}

class _ReaderAiPanelState extends State<ReaderAiPanel> with SingleTickerProviderStateMixin {
  final BookAiService _aiService = BookAiService();
  late TabController _tabController;

  // 总结
  ChapterSummary? _summary;
  bool _summaryLoading = false;
  String _summaryType = 'DETAILED';

  // 知识点
  List<KnowledgePoint> _knowledgePoints = [];
  bool _kpLoading = false;

  // 问答
  final List<_ChatMessage> _chatMessages = [];
  final TextEditingController _chatController = TextEditingController();
  bool _chatLoading = false;
  int? _conversationId;
  final ScrollController _chatScrollController = ScrollController();

  // 测验
  ReadingQuiz? _quiz;
  bool _quizLoading = false;
  List<String> _userAnswers = [];
  int? _quizScore;
  bool _quizSubmitting = false;

  ReaderThemeColors get tc => widget.themeColors;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _chatController.dispose();
    _chatScrollController.dispose();
    super.dispose();
  }

  // ==================== 总结 ====================

  Future<void> _loadSummary() async {
    if (widget.chapterId == null) return;
    setState(() => _summaryLoading = true);
    try {
      final summary = await _aiService.getOrGenerateSummary(
        widget.bookId, widget.chapterId!, type: _summaryType,
      );
      if (mounted) setState(() { _summary = summary; _summaryLoading = false; });
    } catch (e) {
      if (mounted) {
        setState(() => _summaryLoading = false);
        _showError('生成总结失败: $e');
      }
    }
  }

  // ==================== 知识点 ====================

  Future<void> _loadKnowledgePoints() async {
    if (widget.chapterId == null) return;
    setState(() => _kpLoading = true);
    try {
      final kps = await _aiService.getOrExtractKnowledgePoints(widget.bookId, widget.chapterId!);
      if (mounted) setState(() { _knowledgePoints = kps.toList(); _kpLoading = false; });
    } catch (e) {
      if (mounted) {
        setState(() => _kpLoading = false);
        _showError('提取知识点失败: $e');
      }
    }
  }

  // ==================== 问答 ====================

  Future<void> _sendChat() async {
    final text = _chatController.text.trim();
    if (text.isEmpty || _chatLoading) return;
    _chatController.clear();
    setState(() {
      _chatMessages.add(_ChatMessage(role: 'user', content: text));
      _chatLoading = true;
    });
    _scrollToBottom();

    try {
      Map<String, dynamic> result;
      if (_conversationId != null) {
        result = await _aiService.continueConversation(
          bookId: widget.bookId,
          conversationId: _conversationId!,
          question: text,
        );
      } else {
        result = await _aiService.askQuestion(
          bookId: widget.bookId,
          userId: widget.userId,
          question: text,
          chapterId: widget.chapterId,
        );
        if (result['conversationId'] != null) {
          _conversationId = (result['conversationId'] as num).toInt();
        }
      }
      final answer = result['answer']?.toString() ?? '暂无回答';
      if (mounted) {
        setState(() {
          _chatMessages.add(_ChatMessage(role: 'assistant', content: answer));
          _chatLoading = false;
        });
        _scrollToBottom();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _chatMessages.add(_ChatMessage(role: 'assistant', content: '抱歉，回答失败，请重试'));
          _chatLoading = false;
        });
      }
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_chatScrollController.hasClients) {
        _chatScrollController.animateTo(
          _chatScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ==================== 测验 ====================

  Future<void> _generateQuiz() async {
    if (widget.chapterId == null) return;
    setState(() { _quizLoading = true; _quiz = null; _quizScore = null; _userAnswers = []; });
    try {
      final quiz = await _aiService.generateQuiz(widget.bookId, widget.chapterId!);
      if (mounted) {
        setState(() {
          _quiz = quiz;
          _userAnswers = List.filled(quiz.questions?.length ?? 0, '');
          _quizLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _quizLoading = false);
        _showError('生成测试失败: $e');
      }
    }
  }

  Future<void> _submitQuiz() async {
    if (_quiz?.id?.value == null || _quizSubmitting) return;
    setState(() => _quizSubmitting = true);
    try {
      final score = await _aiService.submitAnswers(widget.bookId, _quiz!.id!.value!, _userAnswers);
      if (mounted) setState(() { _quizScore = score; _quizSubmitting = false; });
    } catch (e) {
      if (mounted) {
        setState(() => _quizSubmitting = false);
        _showError('提交答案失败: $e');
      }
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red[400]),
    );
  }

  // ==================== Build ====================

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: tc.bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // 拖拽条
          Center(
            child: Container(
              width: 36, height: 4,
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: tc.muted.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // 标题
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(PhosphorIcons.sparkle(), size: 18, color: tc.accent),
                const SizedBox(width: 8),
                Text('AI 智能助手', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: tc.text)),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(PhosphorIcons.x(), size: 20, color: tc.muted),
                ),
              ],
            ),
          ),
          // Tab Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: tc.card,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: tc.bg,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 4)],
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: tc.accent,
              unselectedLabelColor: tc.muted,
              labelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
              unselectedLabelStyle: const TextStyle(fontSize: 11),
              dividerHeight: 0,
              tabs: const [
                Tab(text: '总结', height: 32),
                Tab(text: '知识点', height: 32),
                Tab(text: '问答', height: 32),
                Tab(text: '测验', height: 32),
              ],
            ),
          ),
          // Tab 内容
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSummaryTab(),
                _buildKnowledgeTab(),
                _buildChatTab(),
                _buildQuizTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== Tab: 总结 ====================

  Widget _buildSummaryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // 类型选择
          Row(
            children: [
              _buildTypeChip('简要', 'BRIEF'),
              const SizedBox(width: 8),
              _buildTypeChip('详细', 'DETAILED'),
              const SizedBox(width: 8),
              _buildTypeChip('要点', 'KEYPOINTS'),
            ],
          ),
          const SizedBox(height: 16),
          if (_summary == null && !_summaryLoading)
            _buildActionButton('生成本章总结', PhosphorIcons.sparkle(), tc.accent, _loadSummary),
          if (_summaryLoading)
            _buildLoading('AI 正在深度研读本章内容...'),
          if (_summary != null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: tc.card, borderRadius: BorderRadius.circular(12)),
              child: MarkdownBlock(data: _summary!.content ?? ''),
            ),
            if (_summary!.keyPoints != null && _summary!.keyPoints!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text('核心知识要点', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: tc.muted)),
              const SizedBox(height: 8),
              ...(_summary!.keyPoints!.toList()).asMap().entries.map((e) => _buildKeyPointItem(e.key, e.value.toString())),
            ],
            const SizedBox(height: 16),
            _buildSecondaryButton('重新生成', PhosphorIcons.arrowCounterClockwise(), () {
              setState(() => _summary = null);
              _loadSummary();
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildTypeChip(String label, String type) {
    final isActive = _summaryType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() { _summaryType = type; _summary = null; });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? tc.bg : tc.card,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isActive ? [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 4)] : null,
          ),
          child: Center(
            child: Text(label, style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w600,
              color: isActive ? tc.accent : tc.muted,
            )),
          ),
        ),
      ),
    );
  }

  Widget _buildKeyPointItem(int index, String point) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22, height: 22,
            margin: const EdgeInsets.only(right: 8, top: 2),
            decoration: BoxDecoration(
              color: tc.accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(child: Text('${index + 1}', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: tc.accent))),
          ),
          Expanded(child: Text(point, style: TextStyle(fontSize: 13, color: tc.text, height: 1.5))),
        ],
      ),
    );
  }

  // ==================== Tab: 知识点 ====================

  Widget _buildKnowledgeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (_knowledgePoints.isEmpty && !_kpLoading)
            _buildActionButton('开始提取知识点', PhosphorIcons.lightbulb(), Colors.amber[600]!, _loadKnowledgePoints),
          if (_kpLoading)
            _buildLoading('AI 正在捕捉知识点...'),
          if (_knowledgePoints.isNotEmpty) ...[
            ..._knowledgePoints.map((kp) => _buildKpCard(kp)),
            const SizedBox(height: 16),
            _buildSecondaryButton('重新提取', PhosphorIcons.arrowCounterClockwise(), () {
              setState(() => _knowledgePoints = []);
              _loadKnowledgePoints();
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildKpCard(KnowledgePoint kp) {
    final typeStr = kp.pointType?.name ?? 'CONCEPT';
    final typeColor = _getKpColor(typeStr);
    final typeLabel = _getKpLabel(typeStr);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: tc.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tc.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: typeColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4)),
                child: Text(typeLabel, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: typeColor)),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(kp.name ?? '', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: tc.text))),
            ],
          ),
          if (kp.description != null && kp.description!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(kp.description!, style: TextStyle(fontSize: 12, color: tc.muted, height: 1.5)),
          ],
        ],
      ),
    );
  }

  Color _getKpColor(String type) {
    switch (type) {
      case 'CONCEPT': return Colors.blue;
      case 'TERM': return Colors.purple;
      case 'FORMULA': return Colors.orange;
      case 'PRINCIPLE': return Colors.green;
      case 'METHOD': return Colors.teal;
      default: return Colors.blue;
    }
  }

  String _getKpLabel(String type) {
    switch (type) {
      case 'CONCEPT': return '概念';
      case 'TERM': return '术语';
      case 'FORMULA': return '公式';
      case 'PRINCIPLE': return '原理';
      case 'METHOD': return '方法';
      default: return type;
    }
  }

  // ==================== Tab: 问答 ====================

  Widget _buildChatTab() {
    return Column(
      children: [
        // 消息列表
        Expanded(
          child: _chatMessages.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(PhosphorIcons.chatTeardrop(), size: 48, color: tc.muted.withValues(alpha: 0.3)),
                      const SizedBox(height: 8),
                      Text('AI 知识问答', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: tc.muted.withValues(alpha: 0.5))),
                      Text('询问关于本章节的任何问题', style: TextStyle(fontSize: 12, color: tc.muted.withValues(alpha: 0.4))),
                    ],
                  ),
                )
              : ListView.builder(
                  controller: _chatScrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: _chatMessages.length + (_chatLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _chatMessages.length) return _buildTypingIndicator();
                    return _buildChatBubble(_chatMessages[index]);
                  },
                ),
        ),
        // 输入框
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          decoration: BoxDecoration(
            color: tc.bg,
            border: Border(top: BorderSide(color: tc.border)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: tc.card,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _chatController,
                    style: TextStyle(fontSize: 13, color: tc.text),
                    decoration: InputDecoration(
                      hintText: '有什么可以帮您？',
                      hintStyle: TextStyle(color: tc.muted, fontSize: 13),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onSubmitted: (_) => _sendChat(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _sendChat,
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: tc.accent, borderRadius: BorderRadius.circular(18)),
                  child: Icon(PhosphorIcons.paperPlaneTilt(), size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChatBubble(_ChatMessage msg) {
    final isUser = msg.role == 'user';
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser)
            Container(
              width: 28, height: 28,
              margin: const EdgeInsets.only(right: 8, top: 2),
              decoration: BoxDecoration(
                color: tc.accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(PhosphorIcons.sparkle(), size: 14, color: tc.accent),
            ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isUser ? tc.accent : tc.card,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isUser ? 16 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 16),
                ),
              ),
              child: isUser
                  ? Text(msg.content, style: const TextStyle(fontSize: 13, color: Colors.white))
                  : MarkdownBlock(data: msg.content),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 28, height: 28,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: tc.accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(PhosphorIcons.sparkle(), size: 14, color: tc.accent),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(color: tc.card, borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) => _buildDot(i)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 600 + index * 200),
      builder: (_, value, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Container(
          width: 6, height: 6,
          decoration: BoxDecoration(
            color: tc.accent.withValues(alpha: 0.4 + value * 0.3),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  // ==================== Tab: 测验 ====================

  Widget _buildQuizTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (_quiz == null && !_quizLoading)
            _buildActionButton('开始智能出题', PhosphorIcons.exam(), Colors.green[600]!, _generateQuiz),
          if (_quizLoading)
            _buildLoading('AI 正在精心设计题目...'),
          if (_quiz != null && _quiz!.questions != null) ...[
            // 得分
            if (_quizScore != null)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: tc.accent.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: tc.accent.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    Text('$_quizScore', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: tc.accent)),
                    Text('本次测试得分', style: TextStyle(fontSize: 11, color: tc.muted)),
                  ],
                ),
              ),
            // 题目列表
            ...(_quiz!.questions!.toList()).asMap().entries.map((e) => _buildQuizQuestion(e.key, e.value)),
            const SizedBox(height: 16),
            // 提交/重做
            if (_quizScore == null)
              _buildActionButton(
                _quizSubmitting ? '正在阅卷...' : '提交测试答案',
                _quizSubmitting ? PhosphorIcons.hourglass() : PhosphorIcons.check(),
                tc.accent,
                _userAnswers.any((a) => a.isEmpty) || _quizSubmitting ? null : _submitQuiz,
              )
            else
              _buildActionButton('再战一组题目', PhosphorIcons.arrowCounterClockwise(), Colors.green[600]!, _generateQuiz),
          ],
        ],
      ),
    );
  }

  Widget _buildQuizQuestion(int qi, QuizQuestion q) {
    final showResult = _quizScore != null;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: tc.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tc.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 题号 + 题目
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24, height: 24,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(color: tc.card, borderRadius: BorderRadius.circular(6)),
                child: Center(child: Text('${qi + 1}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: tc.accent))),
              ),
              Expanded(child: Text(q.question ?? '', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: tc.text, height: 1.5))),
            ],
          ),
          const SizedBox(height: 10),
          // 选项
          if (q.type == QuizQuestionTypeEnum.CHOICE && q.options != null)
            ...q.options!.toList().asMap().entries.map((e) {
              final letter = String.fromCharCode(65 + e.key);
              final optText = e.value.toString();
              final selected = _userAnswers.length > qi && _userAnswers[qi] == letter;
              final isCorrect = q.correctAnswer == letter;
              Color bgColor = Colors.transparent;
              Color borderColor = tc.border;
              if (showResult && isCorrect) { bgColor = Colors.green.withValues(alpha: 0.08); borderColor = Colors.green; }
              else if (showResult && selected && !isCorrect) { bgColor = Colors.red.withValues(alpha: 0.08); borderColor = Colors.red; }
              else if (selected) { bgColor = tc.accent.withValues(alpha: 0.08); borderColor = tc.accent; }
              return GestureDetector(
                onTap: showResult ? null : () { setState(() => _userAnswers[qi] = letter); },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: borderColor),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 22, height: 22,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: selected ? tc.accent : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: selected ? tc.accent : tc.border),
                        ),
                        child: Center(child: Text(letter, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: selected ? Colors.white : tc.muted))),
                      ),
                      Expanded(child: Text(optText, style: TextStyle(fontSize: 12, color: tc.text))),
                      if (showResult && isCorrect) Icon(PhosphorIcons.check(), size: 16, color: Colors.green),
                      if (showResult && selected && !isCorrect) Icon(PhosphorIcons.x(), size: 16, color: Colors.red),
                    ],
                  ),
                ),
              );
            }),
          // 判断题
          if (q.type == QuizQuestionTypeEnum.TRUE_FALSE)
            Row(
              children: ['TRUE', 'FALSE'].map((v) {
                final selected = _userAnswers.length > qi && _userAnswers[qi] == v;
                final isCorrect = q.correctAnswer == v;
                Color bgColor = Colors.transparent;
                if (showResult && isCorrect) bgColor = Colors.green.withValues(alpha: 0.08);
                else if (showResult && selected && !isCorrect) bgColor = Colors.red.withValues(alpha: 0.08);
                else if (selected) bgColor = tc.accent.withValues(alpha: 0.08);
                return Expanded(
                  child: GestureDetector(
                    onTap: showResult ? null : () { setState(() => _userAnswers[qi] = v); },
                    child: Container(
                      margin: EdgeInsets.only(right: v == 'TRUE' ? 6 : 0, left: v == 'FALSE' ? 6 : 0),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: selected ? tc.accent : tc.border),
                      ),
                      child: Center(child: Text(v == 'TRUE' ? '正确' : '错误', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: tc.text))),
                    ),
                  ),
                );
              }).toList(),
            ),
          // 填空/简答
          if (q.type == QuizQuestionTypeEnum.FILL || q.type == QuizQuestionTypeEnum.SHORT_ANSWER) ...[
            TextField(
              enabled: !showResult,
              style: TextStyle(fontSize: 12, color: tc.text),
              decoration: InputDecoration(
                hintText: q.type == QuizQuestionTypeEnum.FILL ? '在此填写答案...' : '在此输入简答...',
                hintStyle: TextStyle(color: tc.muted, fontSize: 12),
                filled: true,
                fillColor: tc.card,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: tc.border)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: tc.border)),
              ),
              onChanged: (v) { if (_userAnswers.length > qi) setState(() => _userAnswers[qi] = v); },
            ),
            if (showResult && q.correctAnswer != null) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(8)),
                child: Text('参考答案: ${q.correctAnswer}', style: TextStyle(fontSize: 11, color: Colors.green[700])),
              ),
            ],
          ],
          // 解析
          if (showResult && q.explanation != null && q.explanation!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: tc.accent.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(8)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(PhosphorIcons.lightbulb(), size: 14, color: tc.accent),
                  const SizedBox(width: 6),
                  Expanded(child: Text(q.explanation!, style: TextStyle(fontSize: 11, color: tc.accent, height: 1.4))),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ==================== 公用组件 ====================

  Widget _buildActionButton(String label, IconData icon, Color color, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: onTap != null ? color : color.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(14),
          boxShadow: onTap != null ? [BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 12, offset: const Offset(0, 4))] : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: Colors.white),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: tc.border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: tc.muted),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: tc.muted)),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          SizedBox(
            width: 32, height: 32,
            child: CircularProgressIndicator(strokeWidth: 3, valueColor: AlwaysStoppedAnimation(tc.accent)),
          ),
          const SizedBox(height: 12),
          Text(message, style: TextStyle(fontSize: 13, color: tc.accent)),
        ],
      ),
    );
  }
}

/// 聊天消息模型
class _ChatMessage {
  final String role;
  final String content;
  _ChatMessage({required this.role, required this.content});
}
