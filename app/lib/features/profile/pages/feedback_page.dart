import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/toast/nova_message.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../../widgets/common/empty_widget.dart';
import '../../../widgets/common/nova_refresh_header.dart';
import '../services/feedback_service.dart';
import 'feedback_create_page.dart';
import 'feedback_detail_page.dart';

/// 用户反馈页面
class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final FeedbackService _feedbackService = FeedbackService();
  final ScrollController _scrollController = ScrollController();
  
  List<FeedbackResponse> _feedbacks = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  int _currentPage = 1;
  static const int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _loadFeedbacks();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreFeedbacks();
    }
  }

  Future<void> _loadFeedbacks() async {
    setState(() {
      _isLoading = true;
      _currentPage = 1;
    });

    try {
      final response = await _feedbackService.getMyFeedbacks(
        pageNum: _currentPage,
        pageSize: _pageSize,
      );

      if (mounted) {
        setState(() {
          _feedbacks = response.data?.list?.toList() ?? [];
          _hasMore = (_feedbacks.length >= _pageSize) &&
              (_currentPage < (response.data?.totalPages ?? 1));
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        NovaMessage.error(context, '加载失败: ${e.toString()}');
      }
    }
  }

  Future<void> _loadMoreFeedbacks() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() => _isLoadingMore = true);

    try {
      final response = await _feedbackService.getMyFeedbacks(
        pageNum: _currentPage + 1,
        pageSize: _pageSize,
      );

      if (mounted) {
        final newList = response.data?.list?.toList() ?? [];
        setState(() {
          _currentPage++;
          _feedbacks.addAll(newList);
          _hasMore = (newList.length >= _pageSize) &&
              (_currentPage < (response.data?.totalPages ?? 1));
          _isLoadingMore = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingMore = false);
      }
    }
  }

  Future<void> _navigateToCreate() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const FeedbackCreatePage()),
    );
    if (result == true) {
      _loadFeedbacks();
    }
  }

  void _navigateToDetail(FeedbackResponse feedback) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FeedbackDetailPage(feedbackId: feedback.id!),
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
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios_rounded, color: colors.textPrimary, size: 20),
        ),
        title: Text(
          '意见反馈',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _navigateToCreate,
            icon: Icon(Icons.add_rounded, color: colors.textPrimary, size: 24),
          ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const LoadingWidget(message: '加载中...')
            : _feedbacks.isEmpty
                ? const EmptyWidget(message: '暂无反馈记录')
                : _buildFeedbackList(colors),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreate,
        backgroundColor: const Color(0xFF3B82F6),
        child: const Icon(Icons.edit_rounded, color: Colors.white),
      ),
    );
  }

  Widget _buildFeedbackList(AppColors colors) {
    return NovaRefreshHeader(
      onRefresh: _loadFeedbacks,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: _feedbacks.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _feedbacks.length) {
            return _buildLoadingMore(colors);
          }
          return _buildFeedbackItem(_feedbacks[index], colors);
        },
      ),
    );
  }

  Widget _buildFeedbackItem(FeedbackResponse feedback, AppColors colors) {
    final statusColor = _getStatusColor(feedback.status);
    final typeInfo = _getFeedbackTypeInfo(feedback.feedbackType);

    return GestureDetector(
      onTap: () => _navigateToDetail(feedback),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: typeInfo['color'].withOpacity(context.isDarkMode ? 0.2 : 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    typeInfo['label'],
                    style: TextStyle(
                      fontSize: 12,
                      color: typeInfo['color'],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(context.isDarkMode ? 0.2 : 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    feedback.statusDesc ?? _getStatusText(feedback.status),
                    style: TextStyle(
                      fontSize: 12,
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (feedback.title != null && feedback.title!.isNotEmpty) ...[
              Text(
                feedback.title!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
            ],
            Text(
              feedback.content ?? '',
              style: TextStyle(
                fontSize: 14,
                color: colors.textSecondary,
                height: 1.5,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.access_time_rounded, size: 14, color: colors.textTertiary),
                const SizedBox(width: 4),
                Text(
                  _formatTime(feedback.createTime),
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.textTertiary,
                  ),
                ),
                const Spacer(),
                Icon(Icons.chevron_right_rounded, size: 20, color: colors.border),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingMore(AppColors colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: _isLoadingMore
          ? const LoadingWidget(size: 24)
          : Text(
              '加载更多...',
              style: TextStyle(color: colors.textTertiary, fontSize: 14),
            ),
    );
  }

  Color _getStatusColor(int? status) {
    switch (status) {
      case 0:
        return const Color(0xFFF59E0B); // 待处理 - 橙色
      case 1:
        return const Color(0xFF3B82F6); // 处理中 - 蓝色
      case 2:
        return const Color(0xFF10B981); // 已完成 - 绿色
      case 3:
        return const Color(0xFF94A3B8); // 已关闭 - 灰色
      default:
        return const Color(0xFF94A3B8);
    }
  }

  String _getStatusText(int? status) {
    switch (status) {
      case 0:
        return '待处理';
      case 1:
        return '处理中';
      case 2:
        return '已完成';
      case 3:
        return '已关闭';
      default:
        return '未知';
    }
  }

  Map<String, dynamic> _getFeedbackTypeInfo(String? type) {
    switch (type) {
      case 'BUG':
        return {'label': 'Bug反馈', 'color': const Color(0xFFEF4444)};
      case 'FEATURE':
        return {'label': '功能建议', 'color': const Color(0xFF8B5CF6)};
      case 'CONTENT':
        return {'label': '内容问题', 'color': const Color(0xFF3B82F6)};
      case 'OTHER':
        return {'label': '其他', 'color': const Color(0xFF94A3B8)};
      default:
        return {'label': type ?? '反馈', 'color': const Color(0xFF94A3B8)};
    }
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '';
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inDays > 0) {
      return '${time.month}月${time.day}日';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}小时前';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }
}
