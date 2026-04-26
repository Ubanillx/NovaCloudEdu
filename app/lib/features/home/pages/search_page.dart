import 'dart:async';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:nova_api/nova_api.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../../core/network/api_client.dart';
import '../../course/pages/course_page.dart';
import '../../course/pages/course_detail_page.dart';
import '../../course/pages/schedule_page.dart';
import '../../course/pages/task_list_page.dart';
import '../../chat/pages/ai_chat_page.dart';
import '../../chat/pages/ai_session_list_page.dart';
import '../../chat/pages/friends_list_page.dart';
import '../../circle/pages/circle_page.dart';
import '../../profile/pages/profile_page.dart';
import '../../profile/pages/profile_detail_page.dart';
import '../../profile/pages/settings_page.dart';
import '../../profile/pages/feedback_page.dart';
import '../../profile/pages/study_plan_page.dart';
import '../../profile/pages/checkin_ranking_page.dart';
import '../../circle/constants/post_types.dart';
import '../daily_word/pages/daily_word_page.dart';
import '../daily_word/pages/word_book_page.dart';
import '../daily_article/pages/daily_article_page.dart';
import 'announcement_list_page.dart';

/// 本地页面注册项
class _LocalPageEntry {
  final String name;
  final String description;
  final PhosphorIconData icon;
  final List<String> keywords;
  final Widget Function() builder;

  const _LocalPageEntry({
    required this.name,
    required this.description,
    required this.icon,
    required this.keywords,
    required this.builder,
  });
}

/// 全局搜索页面
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;

  // 本地页面注册表
  late final List<_LocalPageEntry> _localPages;

  // 搜索状态
  String _query = '';
  List<_LocalPageEntry> _localResults = [];
  List<SearchResultDTO> _apiResults = [];
  List<SearchSuggestionDTO> _suggestions = [];
  bool _isApiLoading = false;
  bool _hasSearched = false;
  String? _selectedType;

  // 搜索类型筛选（与web端一致）
  final List<_TypeFilter> _typeFilters = const [
    _TypeFilter('all', '全部'),
    _TypeFilter('book', '书籍'),
    _TypeFilter('chapter', '章节'),
    _TypeFilter('post', '帖子'),
  ];

  @override
  void initState() {
    super.initState();
    _selectedType = 'all';
    _initLocalPages();
    // 自动聚焦搜索框
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  void _initLocalPages() {
    _localPages = [
      _LocalPageEntry(
        name: '课程中心',
        description: '浏览全部课程',
        icon: PhosphorIcons.graduationCap(),
        keywords: ['课程', '学习', '课堂', 'course', '选课'],
        builder: () => const CoursePage(),
      ),
      _LocalPageEntry(
        name: '每日单词',
        description: '背单词、词汇学习',
        icon: PhosphorIcons.translate(),
        keywords: ['单词', '词汇', '英语', '背单词', 'word', 'vocabulary'],
        builder: () => const DailyWordPage(),
      ),
      _LocalPageEntry(
        name: '生词本',
        description: '收藏的生词',
        icon: PhosphorIcons.bookmarkSimple(),
        keywords: ['生词', '收藏', '词汇', '单词本', 'wordbook'],
        builder: () => const WordBookPage(),
      ),
      _LocalPageEntry(
        name: '每日美文',
        description: '精选文章阅读',
        icon: PhosphorIcons.bookOpen(),
        keywords: ['文章', '美文', '阅读', '每日', 'article', 'reading'],
        builder: () => const DailyArticlePage(),
      ),
      _LocalPageEntry(
        name: 'AI 学习助手',
        description: '智能问答、知识讲解',
        icon: PhosphorIcons.sparkle(),
        keywords: ['AI', '助手', '智能', '问答', '聊天', 'chat', 'assistant'],
        builder: () =>
            const AiChatPage(title: 'AI 学习助手', assistantName: 'AI 学习助手'),
      ),
      _LocalPageEntry(
        name: '智慧体列表',
        description: '查看全部 AI 助手',
        icon: PhosphorIcons.robot(),
        keywords: ['智慧体', 'AI', '助手', '列表'],
        builder: () => const AiSessionListPage(),
      ),
      _LocalPageEntry(
        name: '学习圈',
        description: '社区帖子、分享交流',
        icon: PhosphorIcons.usersThree(),
        keywords: ['社区', '圈子', '帖子', '分享', '交流', 'circle', 'post'],
        builder: () => const CirclePage(),
      ),
      _LocalPageEntry(
        name: '好友列表',
        description: '查看和管理好友',
        icon: PhosphorIcons.addressBook(),
        keywords: ['好友', '通讯录', '联系人', 'friend', 'contact'],
        builder: () => const FriendsListPage(),
      ),
      _LocalPageEntry(
        name: '课程表',
        description: '查看课程安排',
        icon: PhosphorIcons.calendarBlank(),
        keywords: ['课程表', '课表', '日程', '安排', 'schedule'],
        builder: () => const SchedulePage(),
      ),
      _LocalPageEntry(
        name: '作业任务',
        description: '查看待完成的任务',
        icon: PhosphorIcons.clipboardText(),
        keywords: ['作业', '任务', '待办', 'task', 'homework'],
        builder: () => const TaskListPage(),
      ),
      _LocalPageEntry(
        name: '个人中心',
        description: '查看和编辑个人信息',
        icon: PhosphorIcons.user(),
        keywords: ['个人', '我的', '信息', '主页', 'profile', 'me'],
        builder: () => const ProfilePage(),
      ),
      _LocalPageEntry(
        name: '编辑资料',
        description: '修改个人信息',
        icon: PhosphorIcons.pencilSimple(),
        keywords: ['编辑', '修改', '资料', '头像', '昵称', 'edit'],
        builder: () => const ProfileDetailPage(),
      ),
      _LocalPageEntry(
        name: '设置',
        description: '应用设置、主题切换',
        icon: PhosphorIcons.gear(),
        keywords: ['设置', '主题', '深色', '浅色', '夜间', 'setting', 'theme'],
        builder: () => const SettingsPage(),
      ),
      _LocalPageEntry(
        name: '意见反馈',
        description: '提交问题和建议',
        icon: PhosphorIcons.chatTeardropText(),
        keywords: ['反馈', '建议', '问题', '意见', 'feedback', 'bug'],
        builder: () => const FeedbackPage(),
      ),
      _LocalPageEntry(
        name: '学习计划',
        description: '管理学习目标和计划',
        icon: PhosphorIcons.target(),
        keywords: ['计划', '学习', '目标', 'plan', 'study'],
        builder: () => const StudyPlanPage(),
      ),
      _LocalPageEntry(
        name: '签到排行',
        description: '查看签到排名',
        icon: PhosphorIcons.trophy(),
        keywords: ['签到', '排行', '打卡', '排名', 'checkin', 'rank'],
        builder: () => const CheckinRankingPage(),
      ),
      _LocalPageEntry(
        name: '公告通知',
        description: '查看系统公告',
        icon: PhosphorIcons.megaphone(),
        keywords: ['公告', '通知', '消息', 'announcement', 'notice'],
        builder: () => const AnnouncementListPage(),
      ),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onQueryChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() {
        _query = value.trim();
        _hasSearched = _query.isNotEmpty;
      });
      if (_query.isNotEmpty) {
        _searchLocal();
        _loadSuggestions();
        _searchApi();
      } else {
        setState(() {
          _localResults = [];
          _apiResults = [];
          _suggestions = [];
          _hasSearched = false;
        });
      }
    });
  }

  /// 本地页面搜索
  void _searchLocal() {
    final q = _query.toLowerCase();
    final results = _localPages.where((page) {
      if (page.name.toLowerCase().contains(q)) return true;
      if (page.description.toLowerCase().contains(q)) return true;
      return page.keywords.any((kw) => kw.toLowerCase().contains(q));
    }).toList();
    setState(() => _localResults = results);
  }

  /// 搜索建议
  Future<void> _loadSuggestions() async {
    try {
      final response = await ApiClient.instance.defaultApi.suggest(
        q: _query,
        type: _selectedType == 'all' ? null : _selectedType,
      );
      if (mounted && response.data?.data != null) {
        setState(() => _suggestions = response.data!.data!.toList());
      }
    } catch (e) {
      debugPrint('搜索建议失败: $e');
    }
  }

  /// API 聚合搜索
  Future<void> _searchApi() async {
    setState(() => _isApiLoading = true);
    try {
      final response = await ApiClient.instance.defaultApi.searchAll(
        q: _query,
        type: _selectedType == 'all' ? null : _selectedType,
        page: 1,
        size: 20,
      );
      if (mounted && response.data?.data != null) {
        final pageResult = response.data!.data!;
        setState(() {
          _apiResults = pageResult.items?.toList() ?? [];
          _isApiLoading = false;
        });
      } else if (mounted) {
        setState(() => _isApiLoading = false);
      }
    } catch (e) {
      debugPrint('聚合搜索失败: $e');
      if (mounted) {
        setState(() => _isApiLoading = false);
      }
    }
  }

  void _onSuggestionTap(SearchSuggestionDTO suggestion) {
    _controller.text = suggestion.text ?? '';
    _onQueryChanged(suggestion.text ?? '');
  }

  void _onTypeFilterChanged(String type) {
    setState(() => _selectedType = type);
    if (_query.isNotEmpty) {
      _searchApi();
    }
  }

  void _navigateToLocalPage(_LocalPageEntry page) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => page.builder()));
  }

  void _navigateToSearchResult(SearchResultDTO result) {
    final type = result.type;
    final id = result.id ?? 0;

    switch (type) {
      case 'course':
        if (id > 0) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => CourseDetailPage(courseId: id)),
          );
        }
        break;
      case 'book':
      case 'chapter':
        // 跳转到课程中心（可后续扩展为图书详情页）
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const CoursePage()));
        break;
      case 'post':
        // 跳转到学习圈
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const CirclePage()));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchHeader(colors),
            if (_query.isNotEmpty) _buildTypeFilters(colors),
            Expanded(child: _buildContent(colors)),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHeader(AppColors colors) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 16, 8),
      child: Row(
        children: [
          // 返回按钮
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                PhosphorIcons.arrowLeft(),
                size: 22,
                color: colors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: _focusNode.hasFocus ? AppTheme.brand : colors.border,
                  width: _focusNode.hasFocus ? 1.5 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      context.isDarkMode ? 0.2 : 0.05,
                    ),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  onChanged: _onQueryChanged,
                  onSubmitted: (_) {
                    if (_query.isNotEmpty) _searchApi();
                  },
                  decoration: InputDecoration(
                    hintText: '搜索页面、课程、图书、帖子...',
                    hintStyle: TextStyle(
                      color: colors.textTertiary,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: Icon(
                      PhosphorIcons.magnifyingGlass(),
                      color: colors.textTertiary,
                      size: 20,
                    ),
                    suffixIcon: _query.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              _controller.clear();
                              _onQueryChanged('');
                            },
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: colors.surfaceVariant,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                PhosphorIcons.x(),
                                color: colors.textTertiary,
                                size: 16,
                              ),
                            ),
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isCollapsed: true,
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 48,
                      minHeight: 48,
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Text(
              '取消',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeFilters(AppColors colors) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        itemCount: _typeFilters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final filter = _typeFilters[index];
          final isSelected = filter.value == _selectedType;
          return GestureDetector(
            onTap: () => _onTypeFilterChanged(filter.value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.brand : colors.surfaceVariant,
                borderRadius: BorderRadius.circular(20),
                border: isSelected
                    ? null
                    : Border.all(color: colors.border, width: 1),
              ),
              child: Text(
                filter.label,
                style: TextStyle(
                  fontSize: 13,
                  color: isSelected ? Colors.white : colors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(AppColors colors) {
    if (!_hasSearched) {
      return _buildHotPages(colors);
    }

    final hasLocal = _localResults.isNotEmpty;
    final hasApi = _apiResults.isNotEmpty;
    final hasSuggestion = _suggestions.isNotEmpty;

    if (!hasLocal && !hasApi && !_isApiLoading && !hasSuggestion) {
      return _buildEmpty(colors);
    }

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        // 搜索建议
        if (hasSuggestion) ...[
          _buildSectionTitle('搜索建议', PhosphorIcons.lightbulb(), colors),
          ...List.generate(
            _suggestions.length > 5 ? 5 : _suggestions.length,
            (index) => _buildSuggestionItem(_suggestions[index], colors),
          ),
          const SizedBox(height: 8),
        ],
        // 本地页面
        if (hasLocal) ...[
          _buildSectionTitle('应用页面', PhosphorIcons.squaresFour(), colors),
          ...List.generate(
            _localResults.length,
            (index) => _buildLocalPageItem(_localResults[index], colors),
          ),
          const SizedBox(height: 8),
        ],
        // API 搜索结果
        _buildSectionTitle('搜索结果', PhosphorIcons.magnifyingGlass(), colors),
        if (_isApiLoading)
          const Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: LoadingWidget(size: 24)),
          )
        else if (hasApi)
          ...List.generate(
            _apiResults.length,
            (index) => _buildApiResultItem(_apiResults[index], colors),
          )
        else
          Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Text(
                '暂无在线搜索结果',
                style: TextStyle(fontSize: 13, color: colors.textTertiary),
              ),
            ),
          ),
      ],
    );
  }

  /// 未搜索时 - 展示常用页面快捷入口
  Widget _buildHotPages(AppColors colors) {
    final hotPages = _localPages.take(8).toList();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                PhosphorIcons.squaresFour(),
                size: 20,
                color: AppTheme.brand,
              ),
              const SizedBox(width: 8),
              Text(
                '快捷入口',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: hotPages.length,
            itemBuilder: (context, index) {
              final page = hotPages[index];
              return GestureDetector(
                onTap: () => _navigateToLocalPage(page),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppTheme.brand.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppTheme.brand.withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      child: Icon(page.icon, color: AppTheme.brand, size: 26),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      page.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: colors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty(AppColors colors) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: colors.surfaceVariant,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(
              PhosphorIcons.magnifyingGlass(),
              size: 36,
              color: colors.textTertiary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '没有找到相关内容',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '换个关键词试试，或浏览下方快捷入口',
            style: TextStyle(fontSize: 14, color: colors.textTertiary),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    String title,
    PhosphorIconData icon,
    AppColors colors,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppTheme.brand),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionItem(
    SearchSuggestionDTO suggestion,
    AppColors colors,
  ) {
    return GestureDetector(
      onTap: () => _onSuggestionTap(suggestion),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.border, width: 0.5),
        ),
        child: Row(
          children: [
            Icon(
              PhosphorIcons.clockCounterClockwise(),
              size: 18,
              color: colors.textTertiary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                suggestion.text ?? '',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colors.textPrimary,
                ),
              ),
            ),
            Icon(
              PhosphorIcons.caretRight(),
              size: 16,
              color: colors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocalPageItem(_LocalPageEntry page, AppColors colors) {
    return GestureDetector(
      onTap: () => _navigateToLocalPage(page),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.border, width: 0.5),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colors.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(page.icon, size: 22, color: AppTheme.brand),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    page.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    page.description,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: colors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              PhosphorIcons.caretRight(),
              size: 18,
              color: colors.iconSecondary,
            ),
          ],
        ),
      ),
    );
  }

  /// 根据类型分发不同卡片（参考web端设计）
  Widget _buildApiResultItem(SearchResultDTO result, AppColors colors) {
    switch (result.type) {
      case 'book':
        return _buildBookCard(result, colors);
      case 'chapter':
        return _buildChapterCard(result, colors);
      case 'post':
        return _buildPostCard(result, colors);
      default:
        return _buildGenericCard(result, colors);
    }
  }

  /// 书籍结果卡片 - 参考web BookResultCard
  Widget _buildBookCard(SearchResultDTO result, AppColors colors) {
    final fileType = (result.fileType ?? 'TXT').toUpperCase();
    final fileTypeColor = _getFileTypeColor(fileType);

    return GestureDetector(
      onTap: () => _navigateToSearchResult(result),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(colors),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 封面（竖版）
            Container(
              width: 64,
              height: 88,
              decoration: BoxDecoration(
                color: colors.surfaceVariant,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: colors.border, width: 0.5),
              ),
              clipBehavior: Clip.antiAlias,
              child: result.coverUrl != null && result.coverUrl!.isNotEmpty
                  ? Image.network(
                      result.coverUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Center(
                        child: Icon(
                          PhosphorIcons.fileText(),
                          size: 28,
                          color: colors.textTertiary,
                        ),
                      ),
                    )
                  : Center(
                      child: Icon(
                        PhosphorIcons.fileText(),
                        size: 28,
                        color: colors.textTertiary,
                      ),
                    ),
            ),
            const SizedBox(width: 14),
            // 信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标签行
                  Row(
                    children: [
                      _buildChip(fileType, fileTypeColor.$1, fileTypeColor.$2),
                      const SizedBox(width: 6),
                      _buildChip(
                        '书籍',
                        AppTheme.brand.withOpacity(0.1),
                        AppTheme.brand,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // 标题
                  Text(
                    result.title ?? '未知书名',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // 作者
                  if (result.author != null && result.author!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      result.author!,
                      style: TextStyle(
                        fontSize: 13,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                  // 章节数
                  if (result.totalChapters != null &&
                      result.totalChapters! > 0) ...[
                    const SizedBox(height: 6),
                    Text(
                      '${result.totalChapters} 章',
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.textTertiary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 章节结果卡片 - 参考web ChapterResultCard
  Widget _buildChapterCard(SearchResultDTO result, AppColors colors) {
    return GestureDetector(
      onTap: () => _navigateToSearchResult(result),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(colors),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标签 + 来源
            Row(
              children: [
                _buildChip(
                  '章节',
                  const Color(0xFFFFF8E1),
                  const Color(0xFFFF8F00),
                ),
                if (result.bookTitle != null &&
                    result.bookTitle!.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '来自《${result.bookTitle!}》${result.chapterIndex != null ? ' · 第${result.chapterIndex}章' : ''}',
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.textTertiary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 10),
            // 标题
            Text(
              result.title ?? '未知章节',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // 内容摘要
            if (result.content != null && result.content!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                result.content!,
                style: TextStyle(
                  fontSize: 13,
                  color: colors.textSecondary,
                  height: 1.5,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// 帖子结果卡片 - 参考web PostResultCard
  Widget _buildPostCard(SearchResultDTO result, AppColors colors) {
    return GestureDetector(
      onTap: () => _navigateToSearchResult(result),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(colors),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标签 + 帖子类型
            Row(
              children: [
                _buildChip(
                  '帖子',
                  const Color(0xFFE8F5E9),
                  const Color(0xFF43A047),
                ),
                if (result.postType != null && result.postType!.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Text(
                    getPostTypeLabel(result.postType),
                    style: TextStyle(fontSize: 12, color: colors.textTertiary),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 10),
            // 标题
            Text(
              result.title ?? '未知帖子',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // 内容摘要
            if (result.content != null && result.content!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                result.content!,
                style: TextStyle(
                  fontSize: 13,
                  color: colors.textSecondary,
                  height: 1.5,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            // 标签 + 互动数据
            const SizedBox(height: 10),
            Row(
              children: [
                // 标签
                if (result.tags != null && result.tags!.isNotEmpty)
                  ...result.tags!
                      .take(3)
                      .map(
                        (tag) => Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: colors.surfaceVariant,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontSize: 11,
                                color: colors.textTertiary,
                              ),
                            ),
                          ),
                        ),
                      ),
                const Spacer(),
                // 互动数据
                if (result.thumbNum != null)
                  _buildStatItem(
                    PhosphorIcons.thumbsUp(),
                    '${result.thumbNum}',
                    colors,
                  ),
                if (result.commentNum != null) ...[
                  const SizedBox(width: 12),
                  _buildStatItem(
                    PhosphorIcons.chatCircle(),
                    '${result.commentNum}',
                    colors,
                  ),
                ],
                if (result.favourNum != null) ...[
                  const SizedBox(width: 12),
                  _buildStatItem(
                    PhosphorIcons.bookmarkSimple(),
                    '${result.favourNum}',
                    colors,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 通用结果卡片（兜底）
  Widget _buildGenericCard(SearchResultDTO result, AppColors colors) {
    return GestureDetector(
      onTap: () => _navigateToSearchResult(result),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(colors),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.title ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (result.content != null && result.content!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      result.content!,
                      style: TextStyle(
                        fontSize: 13,
                        color: colors.textSecondary,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              PhosphorIcons.caretRight(),
              size: 18,
              color: colors.iconSecondary,
            ),
          ],
        ),
      ),
    );
  }

  /// 卡片通用装饰
  BoxDecoration _cardDecoration(AppColors colors) {
    return BoxDecoration(
      color: colors.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: colors.border, width: 0.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(context.isDarkMode ? 0.15 : 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  /// 小标签 chip
  Widget _buildChip(String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }

  /// 互动数据项
  Widget _buildStatItem(PhosphorIconData icon, String count, AppColors colors) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: colors.textTertiary),
        const SizedBox(width: 3),
        Text(count, style: TextStyle(fontSize: 11, color: colors.textTertiary)),
      ],
    );
  }

  /// 文件类型颜色映射（参考web FILE_TYPE_COLORS）
  (Color, Color) _getFileTypeColor(String fileType) {
    switch (fileType) {
      case 'PDF':
        return (const Color(0xFFFFE0E0), const Color(0xFFE53935));
      case 'EPUB':
        return (const Color(0xFFEDE7F6), const Color(0xFF7E57C2));
      case 'TXT':
        return (const Color(0xFFE1F5FE), const Color(0xFF039BE5));
      case 'DOCX':
        return (const Color(0xFFE3F2FD), const Color(0xFF1E88E5));
      default:
        return (const Color(0xFFE1F5FE), const Color(0xFF039BE5));
    }
  }
}

class _TypeFilter {
  final String value;
  final String label;
  const _TypeFilter(this.value, this.label);
}
