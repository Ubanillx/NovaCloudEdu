import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/common/nova_refresh_header.dart';
import '../../../widgets/common/loading_widget.dart';
import '../services/checkin_service.dart';
import '../../../widgets/toast/nova_message.dart';

/// 打卡排行榜页面
class CheckinRankingPage extends StatefulWidget {
  const CheckinRankingPage({super.key});

  @override
  State<CheckinRankingPage> createState() => _CheckinRankingPageState();
}

class _CheckinRankingPageState extends State<CheckinRankingPage> {
  final CheckinService _checkinService = CheckinService();
  List<CheckinRankingItem> _rankingList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRanking();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadRanking() async {
    try {
      final ranking = await _checkinService.getCheckinRanking(limit: 10);
      if (mounted) {
        setState(() {
          _rankingList = ranking;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        NovaMessage.error(context, '加载失败');
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
          icon: Icon(Icons.arrow_back_ios_rounded, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '打卡排行榜',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const LoadingWidget(message: '加载中...')
          : NovaRefreshableList(
              onRefresh: _loadRanking,
              slivers: [
                _rankingList.isEmpty
                    ? SliverFillRemaining(child: _buildEmptyState())
                    : SliverPadding(
                        padding: const EdgeInsets.all(16),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return _buildRankingItem(_rankingList[index]);
                            },
                            childCount: _rankingList.length,
                          ),
                        ),
                      ),
              ],
            ),
    );
  }

  Widget _buildEmptyState() {
    final colors = context.colors;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.emoji_events_outlined,
            size: 64,
            color: colors.iconSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            '暂无排行榜数据',
            style: TextStyle(
              fontSize: 16,
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankingItem(CheckinRankingItem item) {
    final colors = context.colors;
    final isTop3 = item.rank <= 3;
    
    Color getRankColor() {
      switch (item.rank) {
        case 1:
          return const Color(0xFFFFD700); // 金色
        case 2:
          return const Color(0xFFC0C0C0); // 银色
        case 3:
          return const Color(0xFFCD7F32); // 铜色
        default:
          return colors.textSecondary;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: isTop3
            ? Border.all(color: getRankColor().withOpacity(0.3), width: 2)
            : null,
      ),
      child: Row(
        children: [
          // 排名
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isTop3
                  ? getRankColor().withOpacity(0.1)
                  : colors.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isTop3
                  ? Icon(
                      Icons.emoji_events_rounded,
                      color: getRankColor(),
                      size: 24,
                    )
                  : Text(
                      '${item.rank}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          // 头像
          CircleAvatar(
            radius: 24,
            backgroundColor: colors.surfaceVariant,
            backgroundImage: item.userAvatar != null
                ? NetworkImage(item.userAvatar!)
                : null,
            child: item.userAvatar == null
                ? Icon(Icons.person, color: colors.iconSecondary)
                : null,
          ),
          const SizedBox(width: 12),
          // 用户信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.userName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '连续 ${item.currentStreak} 天',
                  style: TextStyle(
                    fontSize: 13,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // 打卡天数
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.local_fire_department_rounded,
                  color: Color(0xFFEF4444),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '${item.totalCheckinDays}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFEF4444),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
