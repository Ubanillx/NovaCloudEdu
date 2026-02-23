import 'package:flutter/material.dart';
import '../../../../config/app_theme.dart';

class ChatListItem extends StatelessWidget {
  final String title;
  final Widget? subtitleWidget;
  final String? time;
  final String? avatarUrl;
  final bool isGroup;
  final int unreadCount;
  final VoidCallback onTap;
  final Widget? actionIcon;
  final AppColors colors;
  final bool isDarkMode;
  final VoidCallback? onLongPress;

  const ChatListItem({
    super.key,
    required this.title,
    this.subtitleWidget,
    this.time,
    this.avatarUrl,
    this.isGroup = false,
    this.unreadCount = 0,
    required this.onTap,
    this.actionIcon,
    required this.colors,
    required this.isDarkMode,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      // 按压态涟漪效果被替换为缩放效果（如果您需要，可以再包装一层Animation）
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.04),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 创意头像框
            _buildAvatar(),
            const SizedBox(width: 14),
            // 中间内容区
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                            color: colors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (time != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          time!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: colors.textTertiary,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 6),
                  if (subtitleWidget != null)
                    subtitleWidget!
                ],
              ),
            ),
            // 右侧操作区 (群组箭头/联系人发消息按钮)
            if (actionIcon != null) ...[
              const SizedBox(width: 12),
              actionIcon!,
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 外部光环与内部头像
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppTheme.brand.withOpacity(0.08),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.brand.withOpacity(0.12),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: AppTheme.brand.withOpacity(0.1),
              backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
                  ? NetworkImage(avatarUrl!)
                  : null,
              child: avatarUrl == null || avatarUrl!.isEmpty
                  ? Icon(
                      isGroup
                          ? Icons.group_rounded
                          : Icons.person_rounded,
                      color: AppTheme.brand,
                      size: 26,
                    )
                  : null,
            ),
          ),
        ),
        // 动态化未读红点
        if (unreadCount > 0)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF4B4B), Color(0xFFFF2A2A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white, width: 1.5), // 隔离背景
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF2A2A).withOpacity(0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              child: Center(
                child: Text(
                  unreadCount > 99 ? '99+' : '$unreadCount',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.0,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
