import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:nova_api/nova_api.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import '../../../config/app_theme.dart';
import '../../../core/network/api_client.dart';
import '../../../widgets/common/nova_refresh_header.dart';
import '../../../widgets/toast/nova_message.dart';
import '../../data/mock_data.dart';
import '../../chat/services/notification_service.dart';
import '../../chat/services/chat_websocket_service.dart';
import '../daily_word/services/daily_word_service.dart';
import '../daily_word/services/daily_word_storage_service.dart';
import 'announcement_list_page.dart';
import '../daily_word/pages/daily_word_page.dart';
import '../daily_article/daily_article.dart';

/// 首页 - 参考smartclass Home.vue
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final _notificationService = NotificationService();
  int _currentBannerIndex = 0;
  
  UnreadCount _unreadCount = UnreadCount();
  StreamSubscription<UnreadCount>? _unreadSubscription;
  StreamSubscription<NotificationEvent>? _notificationSubscription;

  // 轮播图数据
  List<BannerListResponse> _banners = [];
  bool _isBannerLoading = true;

  // 公告数据
  AnnouncementListResponse? _latestAnnouncement;
  bool _isAnnouncementLoading = true;

  // 每日单词数据
  final DailyWordService _dailyWordService = DailyWordService();
  final DailyWordStorageService _dailyWordStorageService = DailyWordStorageService();
  final DailyArticleService _dailyArticleService = DailyArticleService();
  final AudioPlayer _audioPlayer = AudioPlayer();
  DailyWordResponse? _dailyWord;
  DailyArticleResponse? _latestArticle;
  bool _isDailyWordLoading = true;
  bool _isDailyArticleLoading = true;
  bool _hasSettings = false;

  @override
  void initState() {
    super.initState();
    _initNotifications();
    _loadBanners();
    _loadLatestAnnouncement();
    _loadDailyWord();
    _loadLatestArticle();
  }

  /// 加载最新美文
  Future<void> _loadLatestArticle() async {
    try {
      final articles = await _dailyArticleService.getTodayArticles(size: 1);
      if (mounted && articles.isNotEmpty) {
        setState(() {
          _latestArticle = articles.first;
          _isDailyArticleLoading = false;
        });
      } else if (mounted) {
        setState(() => _isDailyArticleLoading = false);
      }
    } catch (e) {
      debugPrint('加载最新文章失败: $e');
      if (mounted) {
        setState(() => _isDailyArticleLoading = false);
      }
    }
  }

  /// 加载每日单词数据
  Future<void> _loadDailyWord() async {
    try {
      // 先检查是否有设置
      final settings = await _dailyWordStorageService.getSettings();
      final hasSettings = settings.wordType != null && settings.wordType!.isNotEmpty;
      
      // 先从缓存加载
      final cachedWords = await _dailyWordStorageService.getCachedWords();
      if (cachedWords.isNotEmpty) {
        if (mounted) {
          setState(() {
            _dailyWord = cachedWords.first.toDailyWordResponse();
            _isDailyWordLoading = false;
            _hasSettings = hasSettings;
          });
        }
        return;
      }

      // 没有缓存，从API加载
      final words = await _dailyWordService.getTodayWords(
        size: settings.wordSize,
        type: settings.wordType,
      );
      
      if (words.isNotEmpty && mounted) {
        // 缓存单词
        await _dailyWordStorageService.cacheWords(words);
        setState(() {
          _dailyWord = words.first;
          _isDailyWordLoading = false;
          _hasSettings = hasSettings;
        });
      } else if (mounted) {
        setState(() {
          _isDailyWordLoading = false;
          _hasSettings = hasSettings;
        });
      }
    } catch (e) {
      debugPrint('加载每日单词失败: $e');
      if (mounted) {
        setState(() {
          _isDailyWordLoading = false;
          _hasSettings = false;
        });
      }
    }
  }

  /// 播放单词发音
  Future<void> _playWordAudio(String? url) async {
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

  /// 加载轮播图数据
  Future<void> _loadBanners() async {
    try {
      final response = await ApiClient.instance.defaultApi.getBannerList();
      if (response.data?.data != null && mounted) {
        setState(() {
          _banners = response.data!.data!.toList();
          _isBannerLoading = false;
        });
      }
    } catch (e) {
      debugPrint('加载轮播图失败: $e');
      if (mounted) {
        setState(() => _isBannerLoading = false);
      }
    }
  }

  /// 加载最新公告
  Future<void> _loadLatestAnnouncement() async {
    try {
      final response = await ApiClient.instance.defaultApi.getAnnouncementList(
        pageNum: 1,
        pageSize: 1,
      );
      if (mounted) {
        final records = response.data?.data?.records;
        setState(() {
          _latestAnnouncement = (records != null && records.isNotEmpty) 
              ? records.first 
              : null;
          _isAnnouncementLoading = false;
        });
      }
    } catch (e) {
      debugPrint('加载公告失败: $e');
      if (mounted) {
        setState(() => _isAnnouncementLoading = false);
      }
    }
  }

  void _initNotifications() {
    _notificationService.init();
    _unreadSubscription = _notificationService.unreadCountStream.listen((count) {
      if (mounted) {
        setState(() => _unreadCount = count);
      }
    });
    _notificationSubscription = _notificationService.newNotifications.listen(_handleNewNotification);
  }

  void _handleNewNotification(NotificationEvent event) {
    // 显示新消息通知
    if (!mounted) return;
    
    String? message;
    switch (event.type) {
      case 'NEW_PRIVATE_MESSAGE':
        final senderName = event.data['senderName'] as String? ?? '某人';
        message = '$senderName 给你发来了一条消息';
        break;
      case 'NEW_GROUP_MESSAGE':
        final groupName = event.data['groupName'] as String? ?? '群聊';
        message = '$groupName 有新消息';
        break;
      case 'FRIEND_REQUEST_RECEIVED':
        message = '收到一条好友申请';
        break;
      case 'GROUP_INVITED':
        final groupName = event.data['groupName'] as String? ?? '群聊';
        message = '你被邀请加入 $groupName';
        break;
      case 'SYSTEM_NOTIFICATION':
        message = event.data['content'] as String? ?? '系统通知';
        break;
    }
    
    if (message != null) {
      _showNotificationSnackBar(message);
    }
  }

  void _showNotificationSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.notifications, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppTheme.brand,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _unreadSubscription?.cancel();
    _notificationSubscription?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: NovaRefreshableList(
          onRefresh: () async {
            await Future.wait([
              _loadBanners(),
              _loadLatestAnnouncement(),
              _loadDailyWord(),
              _loadLatestArticle(),
            ]);
          },
          slivers: [
            // 搜索栏
            SliverToBoxAdapter(child: _buildSearchBar()),
            // 轮播图
            SliverToBoxAdapter(child: _buildBannerCarousel()),
            // 间距
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            // 公告卡片
            SliverToBoxAdapter(child: _buildNoticeCard()),
            // AI助手列表
            SliverToBoxAdapter(child: _buildAiAssistants()),
            // 热门课程
            SliverToBoxAdapter(child: _buildPopularCourses()),
            // 每日单词
            SliverToBoxAdapter(child: _buildDailyWord()),
            // 文章列表
            SliverToBoxAdapter(child: _buildArticles()),
            // 底部间距
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  // 搜索栏
  Widget _buildSearchBar() {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: TextField(
                  controller: _searchController,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(color: colors.textPrimary, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: '搜索你想要的',
                    hintStyle: TextStyle(color: colors.textTertiary, fontSize: 14),
                    prefixIcon: Icon(Icons.search, color: colors.textTertiary),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isCollapsed: true,
                    prefixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 44),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // 消息通知图标
          _buildNotificationIcon(),
        ],
      ),
    );
  }

  Widget _buildNotificationIcon() {
    final colors = context.colors;
    final totalUnread = _unreadCount.totalCount;
    
    return GestureDetector(
      onTap: () {
        // 跳转到聊天页面
        // 这里可以通过底部导航切换到聊天Tab
      },
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: colors.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.notifications_outlined,
              color: totalUnread > 0 ? AppTheme.brand : colors.textTertiary,
              size: 24,
            ),
            if (totalUnread > 0)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Text(
                    totalUnread > 99 ? '99+' : '$totalUnread',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerCarousel() {
    final colors = context.colors;
    // 加载中显示骨架屏
    if (_isBannerLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    // 无数据时不显示
    if (_banners.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 140,
            child: PageView.builder(
              itemCount: _banners.length,
              onPageChanged: (index) {
                setState(() {
                  _currentBannerIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final banner = _banners[index];
                return GestureDetector(
                  onTap: () => _handleBannerTap(banner),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              banner.imageUrl ?? '',
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: colors.surfaceVariant,
                                child: Icon(
                                  Icons.image,
                                  color: colors.textTertiary,
                                  size: 48,
                                ),
                              ),
                            ),
                            // 标题渐变遮罩
                            if (banner.title != null && banner.title!.isNotEmpty)
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.6),
                                      ],
                                    ),
                                  ),
                                  child: Text(
                                    banner.title!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
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
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_banners.length, (index) {
              final isActive = index == _currentBannerIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 4,
                width: isActive ? 18 : 10,
                decoration: BoxDecoration(
                  color: isActive
                      ? AppTheme.brand
                      : const Color(0xFFE5E5E5),
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  /// 处理轮播图点击
  void _handleBannerTap(BannerListResponse banner) {
    final linkType = banner.linkType ?? 0;
    final linkUrl = banner.linkUrl;

    if (linkType == 0 || linkUrl == null || linkUrl.isEmpty) {
      return; // 无跳转
    }

    if (linkType == 1) {
      // 内部路由
      Navigator.of(context).pushNamed(linkUrl);
    } else if (linkType == 2) {
      // 外部链接 - 可以使用 url_launcher 打开
      debugPrint('打开外部链接: $linkUrl');
    }
  }

  // 公告卡片
  Widget _buildNoticeCard() {
    final colors = context.colors;
    // 加载中
    if (_isAnnouncementLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }

    // 无公告
    if (_latestAnnouncement == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () => _navigateToAnnouncementList(),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7E6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFFFD591)),
          ),
          child: Row(
            children: [
              const Icon(Icons.campaign, color: Color(0xFFFA8C16), size: 20),
              const SizedBox(width: 8),
              // 未读标记
              if (_latestAnnouncement!.isRead == false)
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              Expanded(
                child: Text(
                  _latestAnnouncement!.title ?? '',
                  style: const TextStyle(fontSize: 14, color: Color(0xFF873800)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFFFA8C16), size: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// 跳转到公告列表
  void _navigateToAnnouncementList() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AnnouncementListPage(),
      ),
    );
  }

  // AI助手列表
  Widget _buildAiAssistants() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('AI智慧体', onMore: () {}),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: MockData.aiAssistants.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final assistant = MockData.aiAssistants[index];
                return _buildAssistantCard(assistant);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssistantCard(AiAssistant assistant) {
    final colors = context.colors;
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppTheme.brand.withOpacity(0.1),
                  child: const Icon(
                    Icons.smart_toy,
                    size: 18,
                    color: AppTheme.brand,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    assistant.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              assistant.description,
              style: TextStyle(fontSize: 11, color: colors.textSecondary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // 热门课程
  Widget _buildPopularCourses() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('热门课程', onMore: () {}),
          const SizedBox(height: 12),
          ...MockData.courses.take(3).map((course) => _buildCourseCard(course)),
        ],
      ),
    );
  }

  Widget _buildCourseCard(Course course) {
    final colors = context.colors;
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                course.cover,
                width: 80,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 80,
                  height: 60,
                  color: colors.surfaceVariant,
                  child: Icon(Icons.image, color: colors.textTertiary),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    course.brief,
                    style: TextStyle(fontSize: 12, color: colors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.brand.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          course.tag,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppTheme.brand,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${course.studentsCount}人学习',
                        style: TextStyle(
                          fontSize: 10,
                          color: colors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 每日单词
  Widget _buildDailyWord() {
    // 加载中状态
    if (_isDailyWordLoading) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('每日单词', onMore: () => _navigateToDailyWord()),
            const SizedBox(height: 12),
            Container(
              height: 160,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.brand, AppTheme.brand2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    // 没有设置时显示提示卡片
    if (!_hasSettings) {
      final mockWord = MockData.dailyWord;
      return _buildDailyWordSetupCard(
        word: mockWord.word,
        phonetic: mockWord.phonetic,
        translation: mockWord.translation,
        example: mockWord.example,
      );
    }

    // 没有数据时使用Mock数据
    final word = _dailyWord;
    if (word == null) {
      final mockWord = MockData.dailyWord;
      return _buildDailyWordCard(
        word: mockWord.word,
        phonetic: mockWord.phonetic,
        translation: mockWord.translation,
        example: mockWord.example,
        audioUrlUs: null,
        audioUrlUk: null,
      );
    }

    // 使用真实数据
    return _buildDailyWordCard(
      word: word.word ?? '',
      phonetic: word.pronunciationUs ?? word.pronunciationUk ?? '',
      translation: word.translation ?? '',
      example: word.example ?? '',
      audioUrlUs: word.audioUrlUs,
      audioUrlUk: word.audioUrlUk,
    );
  }

  /// 构建首次设置提示卡片
  Widget _buildDailyWordSetupCard({
    required String word,
    required String phonetic,
    required String translation,
    required String example,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('每日单词', onMore: () => _navigateToDailyWord()),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => _navigateToDailyWord(),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.brand.withOpacity(0.8),
                    AppTheme.brand2.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              word,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.settings, color: Colors.white, size: 14),
                                SizedBox(width: 4),
                                Text('设置', style: TextStyle(fontSize: 11, color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (phonetic.isNotEmpty) ...[
                        Text(
                          phonetic,
                          style: const TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Text(
                        translation,
                        style: const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      if (example.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          example,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '首次使用，请设置单词数量和类型以获取个性化推荐',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // 右上角箭头
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white.withOpacity(0.7),
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建每日单词卡片
  Widget _buildDailyWordCard({
    required String word,
    required String phonetic,
    required String translation,
    required String example,
    String? audioUrlUs,
    String? audioUrlUk,
  }) {
    final hasUsAudio = audioUrlUs != null && audioUrlUs.isNotEmpty;
    final hasUkAudio = audioUrlUk != null && audioUrlUk.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('每日单词', onMore: () => _navigateToDailyWord()),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => _navigateToDailyWord(),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.brand, AppTheme.brand2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          word,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (hasUsAudio)
                            GestureDetector(
                              onTap: () => _playWordAudio(audioUrlUs),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.volume_up, color: Colors.white, size: 14),
                                    SizedBox(width: 4),
                                    Text('美', style: TextStyle(fontSize: 11, color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          if (hasUkAudio)
                            GestureDetector(
                              onTap: () => _playWordAudio(audioUrlUk),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.volume_up, color: Colors.white, size: 14),
                                    SizedBox(width: 4),
                                    Text('英', style: TextStyle(fontSize: 11, color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white.withOpacity(0.7),
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (phonetic.isNotEmpty) ...[
                    Text(
                      phonetic,
                      style: const TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    translation,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  if (example.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      example,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '点击开始学习',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 跳转到每日单词页面
  void _navigateToDailyWord() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DailyWordPage(),
      ),
    ).then((_) {
      // 返回时刷新每日单词数据，确保与每日单词页面一致
      _loadDailyWord();
    });
  }

  // 每日美文入口
  Widget _buildArticles() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('每日美文', onMore: () => _navigateToDailyArticle()),
          const SizedBox(height: 12),
          _buildDailyArticleCard(),
        ],
      ),
    );
  }

  /// 每日美文卡片
  Widget _buildDailyArticleCard() {
    final colors = context.colors;
    final isDark = context.isDarkMode;
    
    if (_isDailyArticleLoading) {
      return Container(
        height: 120,
        decoration: BoxDecoration(
          color: colors.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    return GestureDetector(
      onTap: () => _navigateToDailyArticle(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                : [AppTheme.brand, AppTheme.brand2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.brand.withOpacity(isDark ? 0.2 : 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // 背景装饰
              Positioned(
                right: -20,
                top: -20,
                child: Icon(
                  Icons.auto_stories_rounded,
                  size: 120,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.auto_stories_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          '每日美文',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white.withOpacity(0.7),
                          size: 16,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_latestArticle != null) ...[
                      Text(
                        _latestArticle!.title ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _latestArticle!.summary ?? _latestArticle!.content ?? '精选优质文章，开启心灵之旅',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.8),
                          height: 1.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ] else ...[
                      const Text(
                        '精选优质文章，开启心灵之旅',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildArticleTag('海量文章'),
                        const SizedBox(width: 8),
                        _buildArticleTag('AI讨论'),
                        const SizedBox(width: 8),
                        _buildArticleTag('收藏阅读'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticleTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: Colors.white,
        ),
      ),
    );
  }

  /// 跳转到每日美文页面
  void _navigateToDailyArticle() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DailyArticlePage(),
      ),
    );
  }

  // 分区标题
  Widget _buildSectionHeader(String title, {VoidCallback? onMore}) {
    final colors = context.colors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colors.textPrimary),
        ),
        if (onMore != null)
          GestureDetector(
            onTap: onMore,
            child: Row(
              children: [
                Text('更多', style: TextStyle(fontSize: 12, color: colors.textTertiary)),
                Icon(Icons.chevron_right, size: 16, color: colors.textTertiary),
              ],
            ),
          ),
      ],
    );
  }
}
