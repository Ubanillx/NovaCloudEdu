import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/common/empty_widget.dart';
import '../../../widgets/common/skeleton_widgets.dart';
import '../../../widgets/common/nova_refresh_header.dart';
import '../../../widgets/toast/nova_message.dart';
import '../../../widgets/dialogs/app_dialog.dart';
import '../../../widgets/tabs/nova_tab_bar.dart';
import '../services/friend_service.dart';

/// 好友申请列表页面
class FriendRequestsPage extends StatefulWidget {
  const FriendRequestsPage({super.key});

  @override
  State<FriendRequestsPage> createState() => _FriendRequestsPageState();
}

class _FriendRequestsPageState extends State<FriendRequestsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _friendService = FriendService();

  List<FriendRequestResponse> _receivedRequests = [];
  List<FriendRequestResponse> _sentRequests = [];
  bool _isLoadingReceived = true;
  bool _isLoadingSent = true;
  final Set<int> _processingRequests = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadReceivedRequests();
    _loadSentRequests();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadReceivedRequests() async {
    setState(() => _isLoadingReceived = true);
    try {
      final requests = await _friendService.getReceivedRequests();
      if (mounted) {
        setState(() {
          _receivedRequests = requests;
          _isLoadingReceived = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingReceived = false);
        NovaMessage.error(context, '加载失败: ${e.toString()}');
      }
    }
  }

  Future<void> _loadSentRequests() async {
    setState(() => _isLoadingSent = true);
    try {
      final requests = await _friendService.getSentRequests();
      if (mounted) {
        setState(() {
          _sentRequests = requests;
          _isLoadingSent = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingSent = false);
        NovaMessage.error(context, '加载失败: ${e.toString()}');
      }
    }
  }

  Future<void> _handleRequest(FriendRequestResponse request, bool accept) async {
    if (request.id == null) return;

    final confirmed = await showConfirmDialog(
      context,
      title: accept ? '接受好友申请' : '拒绝好友申请',
      content: accept
          ? '确定要接受 ${request.senderName ?? '该用户'} 的好友申请吗？'
          : '确定要拒绝 ${request.senderName ?? '该用户'} 的好友申请吗？',
      confirmText: accept ? '接受' : '拒绝',
      isDanger: !accept,
    );

    if (confirmed != true) return;

    setState(() => _processingRequests.add(request.id!));

    try {
      await _friendService.handleFriendRequest(
        requestId: request.id!,
        accept: accept,
      );
      if (mounted) {
        NovaMessage.success(context, accept ? '已接受好友申请' : '已拒绝好友申请');
        _loadReceivedRequests();
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '操作失败: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _processingRequests.remove(request.id!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '好友申请',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Tab栏 - 使用自定义 NovaTabBar
          NovaTabBar(
            controller: _tabController,
            tabWidgets: [
              // 收到的（带徽章）
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('收到的'),
                  if (_receivedRequests.where((r) => r.status == 'pending').isNotEmpty) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_receivedRequests.where((r) => r.status == 'pending').length}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              // 发送的
              const Text('发送的'),
            ],
          ),
          // Tab内容
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildReceivedTab(colors),
                _buildSentTab(colors),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceivedTab(AppColors colors) {
    if (_isLoadingReceived) {
      return const ListItemSkeleton();
    }

    if (_receivedRequests.isEmpty) {
      return const EmptyWidget(message: '暂无收到的好友申请');
    }

    return NovaRefreshHeader(
      onRefresh: _loadReceivedRequests,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _receivedRequests.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) =>
            _buildReceivedRequestItem(_receivedRequests[index], colors),
      ),
    );
  }

  Widget _buildSentTab(AppColors colors) {
    if (_isLoadingSent) {
      return const ListItemSkeleton();
    }

    if (_sentRequests.isEmpty) {
      return const EmptyWidget(message: '暂无发送的好友申请');
    }

    return NovaRefreshHeader(
      onRefresh: _loadSentRequests,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _sentRequests.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) =>
            _buildSentRequestItem(_sentRequests[index], colors),
      ),
    );
  }

  Widget _buildReceivedRequestItem(FriendRequestResponse request, AppColors colors) {
    final isProcessing = _processingRequests.contains(request.id);
    final isPending = request.status == 'pending';

    return Container(
      padding: const EdgeInsets.all(16),
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
              // 头像
              CircleAvatar(
                radius: 24,
                backgroundColor: AppTheme.brand.withOpacity(0.1),
                backgroundImage: request.senderAvatar != null &&
                        request.senderAvatar!.isNotEmpty
                    ? NetworkImage(request.senderAvatar!)
                    : null,
                child: request.senderAvatar == null || request.senderAvatar!.isEmpty
                    ? Icon(Icons.person, color: AppTheme.brand, size: 24)
                    : null,
              ),
              const SizedBox(width: 12),
              // 用户信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.senderName ?? '未知用户',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatTime(request.createTime),
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              // 状态标签
              _buildStatusBadge(request.status, colors),
            ],
          ),
          // 申请消息
          if (request.message != null && request.message!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                request.message!,
                style: TextStyle(
                  fontSize: 14,
                  color: colors.textSecondary,
                ),
              ),
            ),
          ],
          // 操作按钮
          if (isPending) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    text: '拒绝',
                    onTap: isProcessing ? null : () => _handleRequest(request, false),
                    isLoading: isProcessing,
                    isPrimary: false,
                    colors: colors,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    text: '接受',
                    onTap: isProcessing ? null : () => _handleRequest(request, true),
                    isLoading: isProcessing,
                    isPrimary: true,
                    colors: colors,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSentRequestItem(FriendRequestResponse request, AppColors colors) {
    return Container(
      padding: const EdgeInsets.all(16),
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
              // 头像
              CircleAvatar(
                radius: 24,
                backgroundColor: AppTheme.brand.withOpacity(0.1),
                backgroundImage: request.receiverAvatar != null &&
                        request.receiverAvatar!.isNotEmpty
                    ? NetworkImage(request.receiverAvatar!)
                    : null,
                child: request.receiverAvatar == null || request.receiverAvatar!.isEmpty
                    ? Icon(Icons.person, color: AppTheme.brand, size: 24)
                    : null,
              ),
              const SizedBox(width: 12),
              // 用户信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.receiverName ?? '未知用户',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatTime(request.createTime),
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              // 状态标签
              _buildStatusBadge(request.status, colors),
            ],
          ),
          // 申请消息
          if (request.message != null && request.message!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                request.message!,
                style: TextStyle(
                  fontSize: 14,
                  color: colors.textSecondary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String? status, AppColors colors) {
    Color bgColor;
    Color textColor;
    String text;

    switch (status) {
      case 'pending':
        bgColor = colors.warning.withOpacity(0.1);
        textColor = colors.warning;
        text = '待处理';
        break;
      case 'accepted':
        bgColor = colors.success.withOpacity(0.1);
        textColor = colors.success;
        text = '已接受';
        break;
      case 'rejected':
        bgColor = colors.error.withOpacity(0.1);
        textColor = colors.error;
        text = '已拒绝';
        break;
      default:
        bgColor = colors.textTertiary.withOpacity(0.1);
        textColor = colors.textTertiary;
        text = '未知';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback? onTap,
    required bool isLoading,
    required bool isPrimary,
    required AppColors colors,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: isPrimary ? AppTheme.brand : colors.background,
          borderRadius: BorderRadius.circular(18),
          border: isPrimary ? null : Border.all(color: colors.border),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isPrimary ? Colors.white : colors.textSecondary,
                    ),
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    color: isPrimary ? Colors.white : colors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
}
