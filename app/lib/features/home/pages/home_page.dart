import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:dio/dio.dart';
import 'package:nova_api/nova_api.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import '../../../config/app_theme.dart';
import '../../../core/network/api_client.dart';
import '../../../widgets/common/nova_refresh_header.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../../widgets/common/skeleton_widgets.dart';
import '../../../widgets/toast/nova_message.dart';
import '../../data/mock_data.dart';
import '../../chat/services/notification_service.dart';
import '../../chat/services/chat_websocket_service.dart';
import '../../course/services/course_service.dart';
import '../../course/pages/course_detail_page.dart';
import '../../course/pages/course_page.dart';
import '../daily_word/services/daily_word_service.dart';
import '../daily_word/services/daily_word_storage_service.dart';
import '../../chat/pages/ai_chat_page.dart';
import '../../chat/pages/ai_session_list_page.dart';
import 'announcement_list_page.dart';
import 'search_page.dart';
import '../daily_word/pages/daily_word_page.dart';
import '../daily_article/daily_article.dart';

/// 首页 - 参考smartclass Home.vue
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  final CourseService _courseService = CourseService();
  final AudioPlayer _audioPlayer = AudioPlayer();
  DailyWordResponse? _dailyWord;
  DailyArticleResponse? _latestArticle;
  bool _isDailyWordLoading = true;
  bool _isDailyArticleLoading = true;
  bool _hasSettings = false;

  // 课程数据
  List<CourseResponse> _courses = [];
  bool _isCourseLoading = true;

  // AI助手数据
  List<AiAssistantVO> _aiAssistants = [];
  bool _isAiAssistantsLoading = true;

  @override
  void initState() {
    super.initState();
    _initNotifications();
    _loadBanners();
    _loadLatestAnnouncement();
    _loadDailyWord();
    _loadLatestArticle();
    _loadCourses();
    _loadAiAssistants();
  }

  /// 加载AI助手数据
  Future<void> _loadAiAssistants() async {
    try {
      final response = await ApiClient.instance.aiApi.assistantListPublic(
        page: 0,
        size: 5,
      );
      if (mounted && response.data?.data != null) {
        setState(() {
          _aiAssistants = response.data!.data!.toList();
          _isAiAssistantsLoading = false;
        });
      } else if (mounted) {
        setState(() => _isAiAssistantsLoading = false);
      }
    } catch (e) {
      debugPrint('加载AI助手失败: $e');
      if (mounted) {
        setState(() => _isAiAssistantsLoading = false);
      }
    }
  }

  /// 加载课程数据
  Future<void> _loadCourses() async {
    try {
      final courses = await _courseService.getCourses(page: 1, size: 3);
      if (mounted) {
        setState(() {
          _courses = courses.toList();
          _isCourseLoading = false;
        });
      }
    } catch (e) {
      debugPrint('加载课程失败: $e');
      if (mounted) {
        setState(() => _isCourseLoading = false);
      }
    }
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
            Icon(PhosphorIcons.bell(), color: Colors.white, size: 20),
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
              _loadCourses(),
              _loadAiAssistants(),
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

  // 搜索栏 - 点击跳转到搜索页面
  Widget _buildSearchBar() {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SearchPage()),
                );
              },
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
                child: Row(
                  children: [
                    const SizedBox(width: 14),
                    Icon(PhosphorIcons.magnifyingGlass(), color: colors.textTertiary, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '搜索页面、课程、图书...',
                      style: TextStyle(color: colors.textTertiary, fontSize: 14),
                    ),
                  ],
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
              PhosphorIcons.bell(),
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
          child: const ShimmerLoading(
            child: SkeletonBox(height: 140, borderRadius: 12),
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
          AspectRatio(
            aspectRatio: 16 / 9,
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
                                  PhosphorIcons.image(),
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
              Icon(PhosphorIcons.megaphone(), color: Color(0xFFFA8C16), size: 20),
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
              Icon(PhosphorIcons.caretRight(), color: Color(0xFFFA8C16), size: 20),
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

  // AI助手列表 - 第一个通用助手+真实API数据
  Widget _buildAiAssistants() {
    // 通用助手（固定展示）
    final genericAssistant = AiAssistantVO((b) => b
      ..id = 0
      ..name = 'AI 学习助手'
      ..description = '智能问答、知识讲解、学习规划'
      ..avatarUrl = null
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('智慧体', onMore: _navigateToAiSessionList),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 1 + (_isAiAssistantsLoading ? 0 : _aiAssistants.length),
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                if (index == 0) {
                  // 第一个：通用助手
                  return _buildAssistantCard(
                    id: genericAssistant.id ?? 0,
                    name: genericAssistant.name ?? 'AI 学习助手',
                    description: genericAssistant.description ?? '智能问答、知识讲解',
                    avatarUrl: genericAssistant.avatarUrl,
                    isGeneric: true,
                  );
                }
                // 其余：真实API数据
                final assistant = _aiAssistants[index - 1];
                return _buildAssistantCard(
                  id: assistant.id ?? 0,
                  name: assistant.name ?? 'AI 助手',
                  description: assistant.description ?? '',
                  avatarUrl: assistant.avatarUrl,
                  isGeneric: false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssistantCard({
    required int id,
    required String name,
    required String description,
    String? avatarUrl,
    bool isGeneric = false,
  }) {
    final colors = context.colors;
    return GestureDetector(
      onTap: () => _navigateToAiChat(
        assistantId: id,
        assistantName: name,
        assistantAvatar: avatarUrl,
      ),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: isGeneric
              ? Border.all(color: AppTheme.brand.withOpacity(0.3), width: 1.5)
              : null,
          boxShadow: [
            BoxShadow(
              color: isGeneric
                  ? AppTheme.brand.withOpacity(context.isDarkMode ? 0.2 : 0.15)
                  : Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.05),
              blurRadius: isGeneric ? 12 : 8,
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
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isGeneric
                        ? AppTheme.brand.withOpacity(0.1)
                        : AppTheme.brand.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: isGeneric
                      ? Icon(
                          PhosphorIcons.sparkle(),
                          size: 18,
                          color: AppTheme.brand,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: avatarUrl != null && avatarUrl.isNotEmpty
                              ? Image.network(
                                  avatarUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Icon(
                                    PhosphorIcons.robot(),
                                    size: 18,
                                    color: AppTheme.brand,
                                  ),
                                )
                              : Icon(
                                  PhosphorIcons.robot(),
                                  size: 18,
                                  color: AppTheme.brand,
                                ),
                        ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isGeneric ? AppTheme.brand : colors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 11,
                color: colors.textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// 跳转到AI对话页面
  void _navigateToAiChat({
    required int assistantId,
    required String assistantName,
    String? assistantAvatar,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AiChatPage(
          assistantId: assistantId > 0 ? assistantId : null,
          title: assistantName,
          assistantName: assistantName,
          assistantAvatar: assistantAvatar,
        ),
      ),
    );
  }

  /// 跳转到AI助手列表页面
  void _navigateToAiSessionList() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AiSessionListPage(),
      ),
    );
  }

  // 热门课程 - 使用真实数据
  Widget _buildPopularCourses() {
    // 加载中显示骨架屏
    if (_isCourseLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('热门课程', onMore: _navigateToCoursePage),
            const SizedBox(height: 12),
            ...List.generate(3, (index) => _buildCourseSkeleton()),
          ],
        ),
      );
    }

    // 无数据时不显示
    if (_courses.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('热门课程', onMore: _navigateToCoursePage),
          const SizedBox(height: 12),
          ..._courses.take(3).map((course) => _buildCourseCard(course)),
        ],
      ),
    );
  }

  // 课程骨架屏
  Widget _buildCourseSkeleton() {
    final colors = context.colors;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              color: colors.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16,
                  decoration: BoxDecoration(
                    color: colors.surfaceVariant,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 120,
                  decoration: BoxDecoration(
                    color: colors.surfaceVariant,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(CourseResponse course) {
    final colors = context.colors;
    final chaptersCount = course.totalChapters ?? 0;
    final sectionsCount = course.totalSections ?? 0;
    final totalDuration = course.totalDuration ?? 0;

    return GestureDetector(
      onTap: () => _navigateToCourseDetail(course.id ?? 0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 封面图片 - 占满宽度
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    course.coverImage ?? '',
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: double.infinity,
                      height: 160,
                      color: colors.surfaceVariant,
                      child: Icon(PhosphorIcons.image(), color: colors.textTertiary, size: 48),
                    ),
                  ),
                ),
                // 标签叠加在图片上
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      course.courseTypeDesc ?? '课程',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                // 价格/免费标签
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: (course.courseType == 0 ? Colors.green : Colors.amber).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      course.courseType == 0 ? '免费' : '¥${course.price ?? 0}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // 课程信息
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题
                  Text(
                    course.title ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  // 副标题
                  Text(
                    course.subtitle ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      color: colors.textSecondary,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // 统计信息行
                  Row(
                    children: [
                      // 章节数
                      _buildCourseStat(
                        PhosphorIcons.bookBookmark(),
                        '$chaptersCount章${sectionsCount > 0 ? ' $sectionsCount节' : ''}',
                        colors,
                      ),
                      const SizedBox(width: 12),
                      // 课时
                      if (totalDuration > 0)
                        _buildCourseStat(
                          PhosphorIcons.clock(),
                          _formatCourseDuration(totalDuration),
                          colors,
                        ),
                      const Spacer(),
                      // 难度
                      if (course.difficultyDesc != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: _getDifficultyColor(course.difficulty).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            course.difficultyDesc!,
                            style: TextStyle(
                              fontSize: 10,
                              color: _getDifficultyColor(course.difficulty),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // 底部信息行
                  Row(
                    children: [
                      // 学习人数
                      Row(
                        children: [
                          Icon(
                            PhosphorIcons.users(),
                            size: 14,
                            color: colors.textTertiary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${course.studentCount ?? 0}人学习',
                            style: TextStyle(
                              fontSize: 12,
                              color: colors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // 评分
                      if (course.ratingScore != null && course.ratingScore! > 0)
                        Row(
                          children: [
                            Icon(
                              PhosphorIcons.star(),
                              size: 14,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              course.ratingScore!.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 12,
                                color: colors.textTertiary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
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

  // 课程统计项
  Widget _buildCourseStat(IconData icon, String text, AppColors colors) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: colors.textTertiary),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: colors.textTertiary,
          ),
        ),
      ],
    );
  }

  // 难度颜色
  Color _getDifficultyColor(int? difficulty) {
    switch (difficulty) {
      case 1: return Colors.green;
      case 2: return Colors.blue;
      case 3: return Colors.orange;
      case 4: return Colors.deepOrange;
      case 5: return Colors.red;
      default: return Colors.grey;
    }
  }

  // 格式化课程时长
  String _formatCourseDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    if (hours > 0) {
      return '${hours}h${minutes > 0 ? '${minutes}m' : ''}';
    }
    return '${minutes}m';
  }

  /// 跳转到课程中心页面
  void _navigateToCoursePage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CoursePage(),
      ),
    );
  }

  /// 跳转到课程详情页
  void _navigateToCourseDetail(int courseId) {
    if (courseId <= 0) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CourseDetailPage(courseId: courseId),
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
              child: const ShimmerLoading(
                child: SkeletonBox(height: 160, borderRadius: 12),
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
    final colors = context.colors;
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
                color: colors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.border, width: 0.5),
                boxShadow: [
                  BoxShadow(
                    color: colors.border.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
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
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: colors.textPrimary,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.brand.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(PhosphorIcons.gear(), color: AppTheme.brand, size: 14),
                            const SizedBox(width: 4),
                            Text('设置', style: TextStyle(fontSize: 11, color: AppTheme.brand)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (phonetic.isNotEmpty) ...[
                    Text(
                      phonetic,
                      style: TextStyle(fontSize: 14, color: colors.textSecondary),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    translation,
                    style: TextStyle(fontSize: 14, color: colors.textPrimary),
                  ),
                  if (example.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      example,
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.textSecondary,
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
                      color: AppTheme.brand.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          PhosphorIcons.info(),
                          color: AppTheme.brand,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '首次使用，请设置单词数量和类型以获取个性化推荐',
                            style: TextStyle(
                              fontSize: 12,
                              color: colors.textSecondary,
                            ),
                          ),
                        ),
                      ],
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
    final colors = context.colors;

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
                color: colors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.border, width: 0.5),
                boxShadow: [
                  BoxShadow(
                    color: colors.border.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
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
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: colors.textPrimary,
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
                                  color: AppTheme.brand.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(PhosphorIcons.speakerHigh(), color: AppTheme.brand, size: 14),
                                    const SizedBox(width: 4),
                                    Text('美', style: TextStyle(fontSize: 11, color: AppTheme.brand)),
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
                                  color: AppTheme.brand.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(PhosphorIcons.speakerHigh(), color: AppTheme.brand, size: 14),
                                    const SizedBox(width: 4),
                                    Text('英', style: TextStyle(fontSize: 11, color: AppTheme.brand)),
                                  ],
                                ),
                              ),
                            ),
                          Icon(
                            PhosphorIcons.caretRight(),
                            color: colors.iconSecondary,
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (phonetic.isNotEmpty) ...[
                    Text(
                      phonetic,
                      style: TextStyle(fontSize: 14, color: colors.textSecondary),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    translation,
                    style: TextStyle(fontSize: 14, color: colors.textPrimary),
                  ),
                  if (example.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      example,
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.textSecondary,
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
                          color: colors.textTertiary,
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
    
    if (_isDailyArticleLoading) {
      return Container(
        height: 120,
        decoration: BoxDecoration(
          color: colors.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const ShimmerLoading(
          child: SkeletonBox(height: 120, borderRadius: 16),
        ),
      );
    }

    return GestureDetector(
      onTap: () => _navigateToDailyArticle(),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.border, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: colors.border.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(0, 2),
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
                  PhosphorIcons.bookOpen(),
                  size: 120,
                  color: AppTheme.brand.withOpacity(0.05),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_latestArticle != null) ...[
                      Text(
                        _latestArticle!.title ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: colors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _latestArticle!.summary ?? _latestArticle!.content ?? '精选优质文章，开启心灵之旅',
                        style: TextStyle(
                          fontSize: 13,
                          color: colors.textSecondary,
                          height: 1.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ] else ...[
                      Text(
                        '精选优质文章，开启心灵之旅',
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildArticleTag('海量文章', colors),
                        const SizedBox(width: 8),
                        _buildArticleTag('AI讨论', colors),
                        const SizedBox(width: 8),
                        _buildArticleTag('收藏阅读', colors),
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

  Widget _buildArticleTag(String label, AppColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.brand.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: AppTheme.brand,
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
                Icon(PhosphorIcons.caretRight(), size: 16, color: colors.textTertiary),
              ],
            ),
          ),
      ],
    );
  }
}
