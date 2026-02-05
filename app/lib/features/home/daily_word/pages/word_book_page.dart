import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import '../../../../config/app_theme.dart';
import '../../../../widgets/common/loading_widget.dart';
import '../../../../widgets/common/empty_widget.dart';
import '../../../../widgets/common/nova_refresh_header.dart';
import '../../../../widgets/toast/nova_message.dart';
import '../../../../widgets/dialogs/app_dialog.dart';
import '../services/daily_word_service.dart';
import 'word_detail_page.dart';

/// 生词本页面
class WordBookPage extends StatefulWidget {
  const WordBookPage({super.key});

  @override
  State<WordBookPage> createState() => _WordBookPageState();
}

class _WordBookPageState extends State<WordBookPage>
    with SingleTickerProviderStateMixin {
  final DailyWordService _service = DailyWordService();
  late TabController _tabController;

  List<UserWordBookResponse> _wordBookList = [];
  WordBookStats? _stats;
  bool _isLoading = true;
  bool _hasError = false;

  // 筛选状态: null=全部, 0=未学习, 1=学习中, 2=已掌握
  int? _filterStatus;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_onTabChanged);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    setState(() {
      switch (_tabController.index) {
        case 0:
          _filterStatus = null;
          break;
        case 1:
          _filterStatus = 0;
          break;
        case 2:
          _filterStatus = 1;
          break;
        case 3:
          _filterStatus = 2;
          break;
      }
    });
    _loadWordBook();
  }

  Future<void> _loadData() async {
    await Future.wait([
      _loadWordBook(),
      _loadStats(),
    ]);
  }

  Future<void> _loadWordBook() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final list = await _service.getWordBookList(
        status: _filterStatus,
        size: 100,
      );
      if (mounted) {
        setState(() {
          _wordBookList = list;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  Future<void> _loadStats() async {
    try {
      final stats = await _service.getWordBookStats();
      if (mounted) {
        setState(() => _stats = stats);
      }
    } catch (e) {
      debugPrint('加载统计失败: $e');
    }
  }

  Future<void> _removeFromWordBook(UserWordBookResponse item) async {
    if (item.id == null) return;

    final confirmed = await showConfirmDialog(
      context,
      title: '移除单词',
      content: '确定要从生词本中移除"${item.word?.word ?? ''}"吗？',
      confirmText: '移除',
      isDanger: true,
    );

    if (confirmed != true) return;

    try {
      await _service.removeFromWordBook(item.id!);
      if (mounted) {
        NovaMessage.success(context, '已移除');
        _loadData();
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '移除失败');
      }
    }
  }

  Future<void> _updateLearningStatus(
      UserWordBookResponse item, int status) async {
    if (item.id == null) return;

    try {
      await _service.updateLearningStatus(item.id!, status);
      if (mounted) {
        NovaMessage.success(context, '状态已更新');
        _loadData();
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '更新失败');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          '生词本',
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
      ),
      body: Column(
        children: [
          // Tab栏
          _buildTabBar(colors),
          // 统计卡片
          if (_stats != null) _buildStatsCard(colors),
          // 单词列表
          Expanded(child: _buildBody(colors)),
        ],
      ),
    );
  }

  Widget _buildTabBar(AppColors colors) {
    return Container(
      color: colors.background,
      child: TabBar(
        controller: _tabController,
        labelColor: AppTheme.brand,
        unselectedLabelColor: colors.textSecondary,
        indicatorColor: AppTheme.brand,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 2,
        dividerColor: Colors.transparent,
        dividerHeight: 0,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        tabs: [
          Tab(text: '全部${_stats?.total != null ? "(${_stats!.total})" : ""}'),
          Tab(
              text:
                  '未学${_stats?.notLearned != null ? "(${_stats!.notLearned})" : ""}'),
          Tab(
              text:
                  '在学${_stats?.learned != null ? "(${_stats!.learned})" : ""}'),
          Tab(
              text:
                  '掌握${_stats?.mastered != null ? "(${_stats!.mastered})" : ""}'),
        ],
      ),
    );
  }

  Widget _buildStatsCard(AppColors colors) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.border.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            label: '总计',
            value: '${_stats?.total ?? 0}',
            icon: Icons.library_books_outlined,
            color: AppTheme.brand,
          ),
          _StatItem(
            label: '未学习',
            value: '${_stats?.notLearned ?? 0}',
            icon: Icons.pending_outlined,
            color: Colors.grey,
          ),
          _StatItem(
            label: '学习中',
            value: '${_stats?.learned ?? 0}',
            icon: Icons.school_outlined,
            color: Colors.orange,
          ),
          _StatItem(
            label: '已掌握',
            value: '${_stats?.mastered ?? 0}',
            icon: Icons.check_circle_outline,
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildBody(AppColors colors) {
    if (_isLoading) {
      return const PageLoading(message: '加载中...');
    }

    if (_hasError) {
      return NetworkErrorWidget(
        message: '加载失败',
        onRetry: _loadData,
      );
    }

    if (_wordBookList.isEmpty) {
      return const EmptyWidget(
        message: '暂无单词',
      );
    }

    return NovaRefreshHeader(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _wordBookList.length,
        itemBuilder: (context, index) {
          return _buildWordItem(_wordBookList[index], colors);
        },
      ),
    );
  }

  Widget _buildWordItem(UserWordBookResponse item, AppColors colors) {
    final word = item.word;
    if (word == null) return const SizedBox.shrink();

    return Dismissible(
      key: Key('word_${item.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: colors.error.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(Icons.delete_outline, color: colors.error),
      ),
      confirmDismiss: (direction) async {
        return await showConfirmDialog(
          context,
          title: '移除单词',
          content: '确定要从生词本中移除"${word.word ?? ''}"吗？',
          confirmText: '移除',
          isDanger: true,
        );
      },
      onDismissed: (direction) {
        _service.removeFromWordBook(item.id!);
        setState(() {
          _wordBookList.remove(item);
        });
        NovaMessage.success(context, '已从生词本移除');
        _loadStats();
      },
      child: GestureDetector(
        onTap: () => _navigateToDetail(word),
        onLongPress: () => _showStatusMenu(item),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colors.border.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // 单词首字母
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getStatusColor(item.learningStatus).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    (word.word?.isNotEmpty == true
                            ? word.word![0].toUpperCase()
                            : '?'),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(item.learningStatus),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // 单词信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      word.word ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colors.textPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (word.pronunciationUs != null) ...[
                          Icon(Icons.volume_up_outlined, 
                            size: 14, color: colors.textTertiary),
                          const SizedBox(width: 4),
                          Text(
                            word.pronunciationUs!,
                            style: TextStyle(
                              fontSize: 12,
                              color: colors.textTertiary,
                              fontFamily: 'monospace',
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Expanded(
                          child: Text(
                            word.translation ?? '',
                            style: TextStyle(
                              fontSize: 13,
                              color: colors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // 状态标识
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(item.learningStatus).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item.learningStatusDesc ?? '未学',
                      style: TextStyle(
                        fontSize: 11,
                        color: _getStatusColor(item.learningStatus),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: colors.textTertiary.withOpacity(0.5),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(int? status) {
    switch (status) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showStatusMenu(UserWordBookResponse item) {
    showAppActionSheet(
      context,
      items: ['标记为未学习', '标记为学习中', '标记为已掌握', '从生词本移除'],
      onSelected: (_, index) {
        if (index == 3) {
          _removeFromWordBook(item);
        } else {
          _updateLearningStatus(item, index);
        }
      },
    );
  }

  void _navigateToDetail(DailyWordResponse word) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WordDetailPage(word: word),
      ),
    ).then((_) => _loadData());
  }
}

/// 统计项
class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
