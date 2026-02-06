import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:nova_api/nova_api.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../config/app_theme.dart';
import '../../../../widgets/common/loading_widget.dart';
import '../../../../widgets/common/empty_widget.dart';
import '../../../../widgets/toast/nova_message.dart';
import '../services/daily_word_service.dart';
import '../services/daily_word_storage_service.dart';
import 'word_detail_page.dart';

/// 每日单词页面
class DailyWordPage extends StatefulWidget {
  const DailyWordPage({super.key});

  @override
  State<DailyWordPage> createState() => _DailyWordPageState();
}

class _DailyWordPageState extends State<DailyWordPage> {
  final DailyWordService _service = DailyWordService();
  final DailyWordStorageService _storageService = DailyWordStorageService();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final PageController _pageController = PageController();

  List<DailyWordResponse> _words = [];
  bool _isLoading = true;
  bool _hasError = false;
  int _currentIndex = 0;

  // 设置选项
  int _selectedSize = 10;
  String? _selectedType;

  @override
  void initState() {
    super.initState();
    _initializeAndLoad();
  }

  /// 初始化设置并加载单词
  Future<void> _initializeAndLoad() async {
    // 先从本地加载设置
    final settings = await _storageService.getSettings();
    setState(() {
      _selectedSize = settings.wordSize;
      _selectedType = settings.wordType;
    });

    // 尝试从缓存加载
    final cachedWords = await _storageService.getCachedWords();
    if (cachedWords.isNotEmpty) {
      setState(() {
        _words = cachedWords.map((e) => e.toDailyWordResponse()).toList();
        _isLoading = false;
      });
    } else {
      // 没有缓存，从API加载
      await _loadWords();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadWords({bool forceRefresh = false}) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final words = await _service.getTodayWords(
        size: _selectedSize,
        type: _selectedType,
      );
      if (mounted) {
        setState(() {
          _words = words;
          _isLoading = false;
          _currentIndex = 0;
        });
        if (_pageController.hasClients) {
          _pageController.jumpToPage(0);
        }
        // 缓存单词到本地
        await _storageService.cacheWords(words);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
        NovaMessage.error(context, '加载失败，请重试');
      }
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

  void _showSettingsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _SettingsSheet(
        selectedSize: _selectedSize,
        selectedType: _selectedType,
        onApply: (size, type) async {
          setState(() {
            _selectedSize = size;
            _selectedType = type;
          });
          // 保存设置到本地
          await _storageService.saveSettings(size, type);
          // 清除缓存并重新加载
          await _storageService.clearCache();
          _loadWords();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text(
          '每日单词',
          style: TextStyle(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.tune_rounded, color: colors.textPrimary),
            onPressed: _showSettingsSheet,
            tooltip: '设置',
          ),
        ],
      ),
      body: _buildBody(colors),
    );
  }

  Widget _buildBody(AppColors colors) {
    if (_isLoading) {
      return const PageLoading(message: '正在加载单词...');
    }

    if (_hasError) {
      return NetworkErrorWidget(
        message: '加载失败，请重试',
        onRetry: _loadWords,
      );
    }

    if (_words.isEmpty) {
      return const EmptyWidget(
        message: '暂无单词数据',
      );
    }

    return Column(
      children: [
        // 进度指示器
        _buildProgressIndicator(colors),
        // 单词卡片
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: _words.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return _buildWordCard(_words[index], colors);
            },
          ),
        ),
        // 底部操作栏
        _buildBottomBar(colors),
      ],
    );
  }

  Widget _buildProgressIndicator(AppColors colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_currentIndex + 1} / ${_words.length}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colors.textSecondary,
                ),
              ),
              if (_selectedType != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.brand.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _selectedType!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.brand,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (_currentIndex + 1) / _words.length,
              backgroundColor: colors.surfaceVariant,
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.brand),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWordCard(DailyWordResponse word, AppColors colors) {
    final isDark = context.isDarkMode;

    return GestureDetector(
      onTap: () => _navigateToDetail(word),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                : [AppTheme.brand, AppTheme.brand2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppTheme.brand.withOpacity(isDark ? 0.2 : 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 单词和发音按钮
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      word.word ?? '',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // 发音按钮
                  _buildAudioButtons(word),
                ],
              ),
              const SizedBox(height: 8),
              // 音标
              _buildPhonetics(word),
              const SizedBox(height: 16),
              // 翻译
              Text(
                word.translation ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              // 例句
              if (word.example != null && word.example!.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        word.example!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                      ),
                      if (word.exampleTranslation != null &&
                          word.exampleTranslation!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          word.exampleTranslation!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.8),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
              const Spacer(),
              // 底部信息
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (word.category != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        word.category!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  Row(
                    children: [
                      Icon(
                        Icons.touch_app_outlined,
                        color: Colors.white.withOpacity(0.6),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '点击查看详情',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAudioButtons(DailyWordResponse word) {
    final hasUs = word.audioUrlUs != null && word.audioUrlUs!.isNotEmpty;
    final hasUk = word.audioUrlUk != null && word.audioUrlUk!.isNotEmpty;

    if (!hasUs && !hasUk) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasUs)
          _AudioButton(
            label: '美',
            onTap: () => _playAudio(word.audioUrlUs),
          ),
        if (hasUs && hasUk) const SizedBox(width: 8),
        if (hasUk)
          _AudioButton(
            label: '英',
            onTap: () => _playAudio(word.audioUrlUk),
          ),
      ],
    );
  }

  Widget _buildPhonetics(DailyWordResponse word) {
    final hasUs = word.pronunciationUs != null && word.pronunciationUs!.isNotEmpty;
    final hasUk = word.pronunciationUk != null && word.pronunciationUk!.isNotEmpty;

    if (!hasUs && !hasUk) return const SizedBox.shrink();

    return Wrap(
      spacing: 16,
      children: [
        if (hasUs)
          Text(
            '美 ${word.pronunciationUs}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        if (hasUk)
          Text(
            '英 ${word.pronunciationUk}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
      ],
    );
  }

  Widget _buildBottomBar(AppColors colors) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 上一个
          _BottomButton(
            icon: Icons.arrow_back_ios_rounded,
            label: '上一个',
            onTap: _currentIndex > 0
                ? () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                : null,
            colors: colors,
          ),
          // 添加到生词本
          _BottomButton(
            icon: Icons.bookmark_add_outlined,
            label: '生词本',
            onTap: () => _addToWordBook(_words[_currentIndex]),
            colors: colors,
            isPrimary: true,
          ),
          // 下一个
          _BottomButton(
            icon: Icons.arrow_forward_ios_rounded,
            label: '下一个',
            onTap: _currentIndex < _words.length - 1
                ? () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                : null,
            colors: colors,
          ),
        ],
      ),
    );
  }

  Future<void> _addToWordBook(DailyWordResponse word) async {
    if (word.id == null) return;

    try {
      await _service.addToWordBook(word.id!);
      if (mounted) {
        NovaMessage.success(context, '已添加到生词本');
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '添加失败，请重试');
      }
    }
  }

  void _navigateToDetail(DailyWordResponse word) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WordDetailPage(word: word),
      ),
    );
  }
}

/// 发音按钮
class _AudioButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _AudioButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.volume_up, color: Colors.white, size: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 底部按钮
class _BottomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final AppColors colors;
  final bool isPrimary;

  const _BottomButton({
    required this.icon,
    required this.label,
    this.onTap,
    required this.colors,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onTap == null;
    final color = isDisabled
        ? colors.textTertiary
        : isPrimary
            ? AppTheme.brand
            : colors.textPrimary;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isPrimary
                  ? AppTheme.brand.withOpacity(isDisabled ? 0.3 : 1)
                  : colors.surface,
              shape: BoxShape.circle,
              boxShadow: isPrimary && !isDisabled
                  ? [
                      BoxShadow(
                        color: AppTheme.brand.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              icon,
              color: isPrimary ? Colors.white : color,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// 设置底部弹窗
class _SettingsSheet extends StatefulWidget {
  final int selectedSize;
  final String? selectedType;
  final void Function(int size, String? type) onApply;

  const _SettingsSheet({
    required this.selectedSize,
    required this.selectedType,
    required this.onApply,
  });

  @override
  State<_SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<_SettingsSheet> {
  late int _size;
  late String? _type;

  @override
  void initState() {
    super.initState();
    _size = widget.selectedSize;
    _type = widget.selectedType;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 拖动指示器
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: colors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // 标题
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '学习设置',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _size = 10;
                      _type = null;
                    });
                  },
                  child: Text(
                    '重置',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.brand,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 单词数量
                  Text(
                    '每日单词数量',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: DailyWordService.sizeOptions.map((size) {
                      final isSelected = _size == size;
                      return GestureDetector(
                        onTap: () => setState(() => _size = size),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppTheme.brand
                                : colors.surfaceVariant,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '$size个',
                            style: TextStyle(
                              fontSize: 14,
                              color: isSelected
                                  ? Colors.white
                                  : colors.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  // 单词分类
                  Text(
                    '单词分类',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 智能推荐选项
                  GestureDetector(
                    onTap: () => setState(() => _type = null),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: _type == null
                            ? AppTheme.brand.withOpacity(0.1)
                            : colors.surfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _type == null
                              ? AppTheme.brand
                              : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: _type == null
                                ? AppTheme.brand
                                : colors.textSecondary,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '智能推荐',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: _type == null
                                        ? AppTheme.brand
                                        : colors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '根据你的学习情况智能推荐',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_type == null)
                            const Icon(
                              Icons.check_circle,
                              color: AppTheme.brand,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  ),
                  // 分类列表
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: DailyWordService.wordCategories.map((category) {
                      final isSelected = _type == category;
                      return GestureDetector(
                        onTap: () => setState(() => _type = category),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppTheme.brand
                                : colors.surfaceVariant,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 13,
                              color: isSelected
                                  ? Colors.white
                                  : colors.textPrimary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          // 确认按钮
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onApply(_size, _type);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.brand,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    '应用设置',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
