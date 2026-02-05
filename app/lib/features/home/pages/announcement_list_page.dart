import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import '../../../config/app_theme.dart';
import '../../../core/network/api_client.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../../widgets/common/empty_widget.dart';
import '../../../widgets/common/nova_refresh_header.dart';
import 'announcement_detail_page.dart';

/// 公告列表页面
class AnnouncementListPage extends StatefulWidget {
  const AnnouncementListPage({super.key});

  @override
  State<AnnouncementListPage> createState() => _AnnouncementListPageState();
}

class _AnnouncementListPageState extends State<AnnouncementListPage> {
  List<AnnouncementListResponse> _announcements = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  int _currentPage = 1;
  static const int _pageSize = 10;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadAnnouncements();
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
      _loadMore();
    }
  }

  Future<void> _loadAnnouncements() async {
    setState(() {
      _isLoading = true;
      _currentPage = 1;
    });

    try {
      final response = await ApiClient.instance.defaultApi.getAnnouncementList(
        pageNum: 1,
        pageSize: _pageSize,
      );
      if (mounted) {
        final records = response.data?.data?.records?.toList() ?? [];
        final total = response.data?.data?.total ?? 0;
        setState(() {
          _announcements = records;
          _hasMore = records.length < total;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('加载公告列表失败: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() => _isLoadingMore = true);

    try {
      final response = await ApiClient.instance.defaultApi.getAnnouncementList(
        pageNum: _currentPage + 1,
        pageSize: _pageSize,
      );
      if (mounted) {
        final records = response.data?.data?.records?.toList() ?? [];
        final total = response.data?.data?.total ?? 0;
        setState(() {
          _announcements.addAll(records);
          _currentPage++;
          _hasMore = _announcements.length < total;
          _isLoadingMore = false;
        });
      }
    } catch (e) {
      debugPrint('加载更多公告失败: $e');
      if (mounted) {
        setState(() => _isLoadingMore = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('系统公告'),
        backgroundColor: colors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: LoadingWidget());
    }

    if (_announcements.isEmpty) {
      return const EmptyWidget(message: '暂无公告');
    }

    return NovaRefreshHeader(
      onRefresh: _loadAnnouncements,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: _announcements.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _announcements.length) {
            return _buildLoadMoreIndicator();
          }
          return _buildAnnouncementCard(_announcements[index]);
        },
      ),
    );
  }

  Widget _buildAnnouncementCard(AnnouncementListResponse announcement) {
    final hasImage = announcement.coverImage != null &&
        announcement.coverImage!.isNotEmpty;

    return GestureDetector(
      onTap: () => _navigateToDetail(announcement),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 封面图片
            if (hasImage)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  announcement.coverImage!,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 140,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image, color: Colors.grey, size: 48),
                  ),
                ),
              ),
            // 内容区域
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // 未读标记
                      if (announcement.isRead == false)
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          announcement.title ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatTime(announcement.createTime),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.visibility_outlined,
                        size: 14,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${announcement.viewCount ?? 0}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
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

  Widget _buildLoadMoreIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '';
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inDays > 0) {
      return '${diff.inDays}天前';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}小时前';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }

  void _navigateToDetail(AnnouncementListResponse announcement) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AnnouncementDetailPage(
          announcementId: announcement.id!,
        ),
      ),
    ).then((_) {
      // 返回时刷新列表（更新已读状态）
      _loadAnnouncements();
    });
  }
}
