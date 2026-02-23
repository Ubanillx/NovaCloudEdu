import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import '../../../config/app_theme.dart';
import '../../../core/network/api_client.dart';
import '../../../widgets/common/skeleton_widgets.dart';
import '../../../widgets/common/empty_widget.dart';

/// 公告详情页面
class AnnouncementDetailPage extends StatefulWidget {
  final int announcementId;

  const AnnouncementDetailPage({
    super.key,
    required this.announcementId,
  });

  @override
  State<AnnouncementDetailPage> createState() => _AnnouncementDetailPageState();
}

class _AnnouncementDetailPageState extends State<AnnouncementDetailPage> {
  AnnouncementDetailResponse? _announcement;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadAnnouncementDetail();
  }

  Future<void> _loadAnnouncementDetail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await ApiClient.instance.defaultApi.getAnnouncementDetail(
        id: widget.announcementId,
      );
      if (mounted) {
        setState(() {
          _announcement = response.data?.data;
          _isLoading = false;
        });
        // 标记已读
        _markAsRead();
      }
    } catch (e) {
      debugPrint('加载公告详情失败: $e');
      if (mounted) {
        setState(() {
          _errorMessage = '加载失败，请重试';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _markAsRead() async {
    try {
      await ApiClient.instance.defaultApi.markAsRead3(
        id: widget.announcementId,
      );
    } catch (e) {
      debugPrint('标记已读失败: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('公告详情'),
        backgroundColor: colors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const DetailPageSkeleton();
    }

    if (_errorMessage != null) {
      return NetworkErrorWidget(
        message: _errorMessage!,
        onRetry: _loadAnnouncementDetail,
      );
    }

    if (_announcement == null) {
      return const EmptyWidget(message: '公告不存在');
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 封面图片
          if (_announcement!.coverImage != null &&
              _announcement!.coverImage!.isNotEmpty)
            Image.network(
              _announcement!.coverImage!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 200,
                color: Colors.grey[200],
                child: const Icon(Icons.image, color: Colors.grey, size: 48),
              ),
            ),
          // 内容区域
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 标题
                Text(
                  _announcement!.title ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                // 元信息
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatTime(_announcement!.createTime),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.visibility_outlined,
                      size: 14,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${_announcement!.viewCount ?? 0} 次浏览',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                // 内容
                Text(
                  _announcement!.content ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '';
    return '${time.year}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')} '
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
