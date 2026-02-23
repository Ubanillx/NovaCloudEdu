import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/toast/nova_message.dart';
import '../../../widgets/common/skeleton_widgets.dart';
import '../../../widgets/common/empty_widget.dart';
import '../services/feedback_service.dart';

/// 反馈详情页面
class FeedbackDetailPage extends StatefulWidget {
  final int feedbackId;

  const FeedbackDetailPage({super.key, required this.feedbackId});

  @override
  State<FeedbackDetailPage> createState() => _FeedbackDetailPageState();
}

class _FeedbackDetailPageState extends State<FeedbackDetailPage> {
  final FeedbackService _feedbackService = FeedbackService();
  
  FeedbackDetailResponse? _feedback;
  List<FeedbackReplyResponse>? _replies;
  bool _isLoading = true;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _loadFeedbackDetail();
  }

  Future<void> _loadFeedbackDetail() async {
    setState(() => _isLoading = true);

    try {
      final response = await _feedbackService.getFeedbackDetail(widget.feedbackId);
      final repliesResponse = await _feedbackService.getFeedbackReplies(widget.feedbackId);

      if (mounted) {
        setState(() {
          _feedback = response.data;
          _replies = repliesResponse.data?.toList();
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

  Future<void> _deleteFeedback() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => _DeleteConfirmDialog(),
    );

    if (confirmed != true) return;

    setState(() => _isDeleting = true);

    try {
      final response = await _feedbackService.deleteFeedback(widget.feedbackId);
      if (mounted) {
        if (response.data == true) {
          NovaMessage.success(context, '删除成功');
          Navigator.of(context).pop(true);
        } else {
          NovaMessage.error(context, response.message ?? '删除失败');
          setState(() => _isDeleting = false);
        }
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '删除失败: ${e.toString()}');
        setState(() => _isDeleting = false);
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
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios_rounded, color: colors.textPrimary, size: 20),
        ),
        title: Text(
          '反馈详情',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          if (_feedback != null && _feedback!.status == 0)
            IconButton(
              onPressed: _isDeleting ? null : _deleteFeedback,
              icon: _isDeleting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(Icons.delete_outline_rounded, color: colors.error, size: 24),
            ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const DetailPageSkeleton()
            : _feedback == null
                ? NetworkErrorWidget(onRetry: _loadFeedbackDetail, message: '加载失败')
                : _buildContent(colors),
      ),
    );
  }

  Widget _buildContent(AppColors colors) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFeedbackCard(colors),
          if (_replies != null && _replies!.isNotEmpty) ...[
            const SizedBox(height: 24),
            _buildRepliesSection(colors),
          ],
        ],
      ),
    );
  }

  Widget _buildFeedbackCard(AppColors colors) {
    final statusColor = _getStatusColor(_feedback!.status);
    final typeInfo = _getFeedbackTypeInfo(_feedback!.feedbackType);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: typeInfo['color'].withOpacity(context.isDarkMode ? 0.2 : 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(typeInfo['icon'], size: 16, color: typeInfo['color']),
                    const SizedBox(width: 4),
                    Text(
                      typeInfo['label'],
                      style: TextStyle(
                        fontSize: 12,
                        color: typeInfo['color'],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(context.isDarkMode ? 0.2 : 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _feedback!.statusDesc ?? _getStatusText(_feedback!.status),
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_feedback!.title != null && _feedback!.title!.isNotEmpty) ...[
            Text(
              _feedback!.title!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
          ],
          Text(
            _feedback!.content ?? '',
            style: TextStyle(
              fontSize: 15,
              color: colors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Divider(color: colors.divider),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.access_time_rounded, size: 16, color: colors.textTertiary),
              const SizedBox(width: 6),
              Text(
                '提交时间: ${_formatDateTime(_feedback!.createTime)}',
                style: TextStyle(
                  fontSize: 13,
                  color: colors.textTertiary,
                ),
              ),
            ],
          ),
          if (_feedback!.processTime != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.check_circle_outline_rounded, size: 16, color: colors.textTertiary),
                const SizedBox(width: 6),
                Text(
                  '处理时间: ${_formatDateTime(_feedback!.processTime)}',
                  style: TextStyle(
                    fontSize: 13,
                    color: colors.textTertiary,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRepliesSection(AppColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '回复记录',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: colors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ...(_replies ?? []).map((reply) => _buildReplyItem(reply, colors)),
      ],
    );
  }

  Widget _buildReplyItem(FeedbackReplyResponse reply, AppColors colors) {
    final isAdmin = reply.senderRole == 'ADMIN';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isAdmin
            ? colors.info.withOpacity(context.isDarkMode ? 0.15 : 0.08)
            : colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: isAdmin
            ? Border.all(color: colors.info.withOpacity(0.3))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isAdmin
                      ? colors.info.withOpacity(context.isDarkMode ? 0.3 : 0.15)
                      : colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  isAdmin ? '官方回复' : '我',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isAdmin ? colors.info : colors.textSecondary,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                _formatDateTime(reply.createTime),
                style: TextStyle(
                  fontSize: 12,
                  color: colors.textTertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            reply.content ?? '',
            style: TextStyle(
              fontSize: 14,
              color: colors.textPrimary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(int? status) {
    switch (status) {
      case 0:
        return const Color(0xFFF59E0B);
      case 1:
        return context.colors.info;
      case 2:
        return const Color(0xFF10B981);
      case 3:
        return const Color(0xFF94A3B8);
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
        return {'label': 'Bug反馈', 'icon': Icons.bug_report_rounded, 'color': const Color(0xFFEF4444)};
      case 'FEATURE':
        return {'label': '功能建议', 'icon': Icons.lightbulb_rounded, 'color': const Color(0xFF8B5CF6)};
      case 'CONTENT':
        return {'label': '内容问题', 'icon': Icons.article_rounded, 'color': context.colors.info};
      case 'OTHER':
        return {'label': '其他', 'icon': Icons.more_horiz_rounded, 'color': const Color(0xFF94A3B8)};
      default:
        return {'label': type ?? '反馈', 'icon': Icons.feedback_rounded, 'color': const Color(0xFF94A3B8)};
    }
  }

  String _formatDateTime(DateTime? time) {
    if (time == null) return '';
    return '${time.year}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')} '
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}

class _DeleteConfirmDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AlertDialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        '确认删除',
        style: TextStyle(
          color: colors.textPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Text(
        '确定要删除这条反馈吗？此操作不可撤销。',
        style: TextStyle(color: colors.textSecondary),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            '取消',
            style: TextStyle(color: colors.textSecondary),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            '删除',
            style: TextStyle(color: colors.error, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
