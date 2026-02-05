import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:nova_api/nova_api.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../config/app_theme.dart';
import '../../../../widgets/toast/nova_message.dart';
import '../../../../widgets/dialogs/app_dialog.dart';
import '../services/daily_word_service.dart';
import '../models/word_notes_model.dart';

/// 单词详情页面
class WordDetailPage extends StatefulWidget {
  final DailyWordResponse word;

  const WordDetailPage({super.key, required this.word});

  @override
  State<WordDetailPage> createState() => _WordDetailPageState();
}

class _WordDetailPageState extends State<WordDetailPage> {
  final DailyWordService _service = DailyWordService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _isInWordBook = false;
  int? _wordBookId;
  int _learningStatus = 0; // 0=未学习, 1=学习中, 2=已掌握
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkWordBookStatus();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  /// 检查单词是否在生词本中，并获取学习状态
  Future<void> _checkWordBookStatus() async {
    if (widget.word.id == null) return;
    try {
      final list = await _service.getWordBookList(size: 100);
      for (final item in list) {
        if (item.word?.id == widget.word.id) {
          setState(() {
            _isInWordBook = true;
            _wordBookId = item.id;
            _learningStatus = item.learningStatus ?? 0;
          });
          break;
        }
      }
    } catch (e) {
      debugPrint('检查生词本状态失败: $e');
    }
  }

  Future<void> _playAudio(String? url) async {
    if (url == null || url.isEmpty) return;
    try {
      var finalUrl = url;
      final uri0 = Uri.tryParse(finalUrl);
      if (uri0 != null && Platform.isIOS && uri0.host == '10.0.2.2') {
        finalUrl = uri0.replace(host: '127.0.0.1').toString();
      }

      final uri = Uri.tryParse(finalUrl);
      if (uri == null || !(uri.hasScheme && uri.host.isNotEmpty)) {
        debugPrint('播放失败: 非法音频URL: $finalUrl');
        if (mounted) {
          NovaMessage.error(context, '音频地址无效');
        }
        return;
      }
      await _audioPlayer.stop();
      
      // iOS上有道词典等URL需要先下载为mp3文件再播放
      if (Platform.isIOS && finalUrl.contains('dict.youdao.com')) {
        final dio = Dio();
        dio.options.headers['User-Agent'] = 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X)';
        final tempDir = await getTemporaryDirectory();
        final audioFile = File('${tempDir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.mp3');
        await dio.download(finalUrl, audioFile.path);
        await _audioPlayer.play(DeviceFileSource(audioFile.path));
      } else {
        await _audioPlayer.play(UrlSource(finalUrl));
      }
    } catch (e) {
      debugPrint('播放失败: $e, url=$url');
      if (mounted) {
        NovaMessage.error(context, '播放失败');
      }
    }
  }

  Future<void> _toggleWordBook() async {
    if (widget.word.id == null) return;

    setState(() => _isLoading = true);

    try {
      if (_isInWordBook) {
        // 从生词本移除 - 需要先获取wordBookId
        // 这里简化处理，实际应该有wordBookId
        NovaMessage.warning(context, '请在生词本中移除');
      } else {
        await _service.addToWordBook(widget.word.id!);
        setState(() => _isInWordBook = true);
        if (mounted) {
          NovaMessage.success(context, '已添加到生词本');
        }
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '操作失败，请重试');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _updateLearningStatus() async {
    if (_wordBookId == null) {
      // 如果不在生词本中，先添加到生词本
      if (widget.word.id == null) return;
      setState(() => _isLoading = true);
      try {
        await _service.addToWordBook(widget.word.id!);
        await _checkWordBookStatus();
        if (mounted) {
          NovaMessage.success(context, '已添加到生词本');
        }
      } catch (e) {
        if (mounted) {
          NovaMessage.error(context, '添加失败');
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
      return;
    }

    // 更新学习状态: 0->学习中(1), 1->已掌握(2)
    final newStatus = _learningStatus < 2 ? _learningStatus + 1 : 2;
    setState(() => _isLoading = true);

    try {
      await _service.updateLearningStatus(_wordBookId!, newStatus);
      setState(() => _learningStatus = newStatus);
      if (mounted) {
        final statusText = newStatus == 1 ? '学习中' : '已掌握';
        NovaMessage.success(context, '已标记为$statusText');
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '操作失败，请重试');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showMasteryDialog() {
    showAppActionSheet(
      context,
      items: ['不认识', '模糊', '认识', '熟练掌握'],
      onSelected: (item, index) async {
        if (widget.word.id == null) return;
        try {
          await _service.updateMastery(widget.word.id!, index);
          if (mounted) {
            NovaMessage.success(context, '已更新掌握程度');
          }
        } catch (e) {
          if (mounted) {
            NovaMessage.error(context, '更新失败');
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: colors.background,
      body: CustomScrollView(
        slivers: [
          // 顶部AppBar
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppTheme.brand,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  _isInWordBook ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.white,
                ),
                onPressed: _isLoading ? null : _toggleWordBook,
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: _showMasteryDialog,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF2D3748), const Color(0xFF1A202C)]
                        : [AppTheme.brand, const Color(0xFF36D1DC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // 单词
                        Text(
                          widget.word.word ?? '',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // 音标和发音
                        _buildPhoneticRow(),
                        const SizedBox(height: 16),
                        // 翻译
                        Text(
                          widget.word.translation ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // 内容区域
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 例句卡片
                  if (widget.word.example != null &&
                      widget.word.example!.isNotEmpty)
                    _buildExampleCard(colors),
                  const SizedBox(height: 20),
                  // 单词信息
                  _buildInfoCard(colors),
                  const SizedBox(height: 20),
                  // 解析notes JSON展示更多信息
                  ..._buildNotesContent(colors),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      // 底部操作栏
      bottomNavigationBar: _buildBottomBar(colors),
    );
  }

  Widget _buildPhoneticRow() {
    final hasUs = widget.word.pronunciationUs != null &&
        widget.word.pronunciationUs!.isNotEmpty;
    final hasUk = widget.word.pronunciationUk != null &&
        widget.word.pronunciationUk!.isNotEmpty;
    final hasUsAudio =
        widget.word.audioUrlUs != null && widget.word.audioUrlUs!.isNotEmpty;
    final hasUkAudio =
        widget.word.audioUrlUk != null && widget.word.audioUrlUk!.isNotEmpty;

    return Wrap(
      spacing: 20,
      runSpacing: 8,
      children: [
        if (hasUs || hasUsAudio)
          _PhoneticItem(
            label: '美',
            phonetic: widget.word.pronunciationUs,
            hasAudio: hasUsAudio,
            onPlayAudio: () => _playAudio(widget.word.audioUrlUs),
          ),
        if (hasUk || hasUkAudio)
          _PhoneticItem(
            label: '英',
            phonetic: widget.word.pronunciationUk,
            hasAudio: hasUkAudio,
            onPlayAudio: () => _playAudio(widget.word.audioUrlUk),
          ),
      ],
    );
  }

  Widget _buildExampleCard(AppColors colors) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.brand.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.format_quote,
                  color: AppTheme.brand,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '例句',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.word.example!,
            style: TextStyle(
              fontSize: 15,
              color: colors.textPrimary,
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
          if (widget.word.exampleTranslation != null &&
              widget.word.exampleTranslation!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              widget.word.exampleTranslation!,
              style: TextStyle(
                fontSize: 14,
                color: colors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoCard(AppColors colors) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colors.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.info_outline,
                  color: colors.info,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '单词信息',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _InfoRow(
            label: '分类',
            value: widget.word.category ?? '未分类',
            colors: colors,
          ),
          const SizedBox(height: 12),
          _InfoRow(
            label: '难度',
            value: widget.word.difficultyDesc ?? '未知',
            colors: colors,
          ),
        ],
      ),
    );
  }

  /// 构建notes内容（解析JSON）
  List<Widget> _buildNotesContent(AppColors colors) {
    final notes = WordNotes.fromJsonString(widget.word.notes);
    if (!notes.hasContent) return [];

    final widgets = <Widget>[];

    // 英文释义
    if (notes.englishDefinitions != null && notes.englishDefinitions!.isNotEmpty) {
      widgets.add(_buildNotesSection(
        colors: colors,
        title: '英文释义',
        icon: Icons.translate,
        iconColor: colors.info,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: notes.englishDefinitions!.map((def) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• ', style: TextStyle(color: colors.textSecondary, fontSize: 14)),
                Expanded(
                  child: Text(
                    def,
                    style: TextStyle(
                      fontSize: 14,
                      color: colors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ),
      ));
      widgets.add(const SizedBox(height: 20));
    }

    // 同义词
    if (notes.synonyms != null && notes.synonyms!.isNotEmpty) {
      widgets.add(_buildNotesSection(
        colors: colors,
        title: '同义词',
        icon: Icons.compare_arrows,
        iconColor: colors.success,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: notes.synonyms!.map((syn) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: colors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              syn,
              style: TextStyle(
                fontSize: 13,
                color: colors.success,
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
        ),
      ));
      widgets.add(const SizedBox(height: 20));
    }

    // 短语
    if (notes.phrases != null && notes.phrases!.isNotEmpty) {
      widgets.add(_buildNotesSection(
        colors: colors,
        title: '常用短语',
        icon: Icons.format_list_bulleted,
        iconColor: AppTheme.brand,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: notes.phrases!.map((phrase) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  phrase.phrase,
                  style: TextStyle(
                    fontSize: 14,
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (phrase.meaning != null && phrase.meaning!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    phrase.meaning!,
                    style: TextStyle(
                      fontSize: 13,
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          )).toList(),
        ),
      ));
      widgets.add(const SizedBox(height: 20));
    }

    // 相关词
    if (notes.relatedWords != null && notes.relatedWords!.isNotEmpty) {
      widgets.add(_buildNotesSection(
        colors: colors,
        title: '相关词汇',
        icon: Icons.link,
        iconColor: colors.warning,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: notes.relatedWords!.map((rw) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: colors.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    rw.word,
                    style: TextStyle(
                      fontSize: 13,
                      color: colors.warning,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (rw.meaning != null && rw.meaning!.isNotEmpty) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      rw.meaning!,
                      style: TextStyle(
                        fontSize: 13,
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          )).toList(),
        ),
      ));
      widgets.add(const SizedBox(height: 20));
    }

    return widgets;
  }

  /// 构建notes区块
  Widget _buildNotesSection({
    required AppColors colors,
    required String title,
    required IconData icon,
    required Color iconColor,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildBottomBar(AppColors colors) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 添加到生词本
          Expanded(
            child: _ActionButton(
              icon: _isInWordBook ? Icons.bookmark : Icons.bookmark_border,
              label: _isInWordBook ? '已收藏' : '加入生词本',
              onTap: _isLoading ? null : _toggleWordBook,
              isActive: _isInWordBook,
              colors: colors,
            ),
          ),
          const SizedBox(width: 16),
          // 学习状态按钮
          Expanded(
            child: _ActionButton(
              icon: _learningStatus == 2 
                  ? Icons.verified 
                  : (_learningStatus == 1 ? Icons.school : Icons.play_circle_outline),
              label: _learningStatus == 2 
                  ? '已掌握' 
                  : (_learningStatus == 1 ? '标记掌握' : '开始学习'),
              onTap: (_isLoading || _learningStatus == 2) ? null : _updateLearningStatus,
              isActive: _learningStatus > 0,
              colors: colors,
              isPrimary: true,
            ),
          ),
        ],
      ),
    );
  }
}

/// 音标项
class _PhoneticItem extends StatelessWidget {
  final String label;
  final String? phonetic;
  final bool hasAudio;
  final VoidCallback onPlayAudio;

  const _PhoneticItem({
    required this.label,
    this.phonetic,
    required this.hasAudio,
    required this.onPlayAudio,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hasAudio ? onPlayAudio : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasAudio) ...[
              const Icon(Icons.volume_up, color: Colors.white, size: 16),
              const SizedBox(width: 6),
            ],
            Text(
              '$label ${phonetic ?? ''}',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 信息行
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final AppColors colors;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: colors.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: colors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

/// 操作按钮
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isActive;
  final AppColors colors;
  final bool isPrimary;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.onTap,
    this.isActive = false,
    required this.colors,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isPrimary
              ? (isActive ? colors.success : AppTheme.brand)
              : (isActive
                  ? AppTheme.brand.withOpacity(0.1)
                  : colors.surfaceVariant),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isPrimary
                  ? Colors.white
                  : (isActive ? AppTheme.brand : colors.textSecondary),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isPrimary
                    ? Colors.white
                    : (isActive ? AppTheme.brand : colors.textPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
