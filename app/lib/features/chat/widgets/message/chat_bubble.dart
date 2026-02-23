import 'package:flutter/material.dart';
import '../../../../config/app_theme.dart';

class ChatBubble extends StatelessWidget {
  final Widget child;
  final bool isMe;
  final AppColors colors;
  final String? time;
  final Widget? statusIcon;
  final String? senderName;
  final String? senderAvatarUrl;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;
  final bool isDarkMode;
  final bool hasBubbleArea;

  const ChatBubble({
    super.key,
    required this.child,
    required this.isMe,
    required this.colors,
    required this.isDarkMode,
    this.hasBubbleArea = true,
    this.time,
    this.statusIcon,
    this.senderName,
    this.senderAvatarUrl,
    this.onAvatarTap,
    this.onLongPress,
    this.onDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            _buildAvatar(),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isMe && senderName != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 14, bottom: 6),
                    child: Text(
                      senderName!,
                      style: TextStyle(
                        color: colors.textTertiary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                GestureDetector(
                  onLongPress: onLongPress,
                  onDoubleTap: onDoubleTap,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.72,
                    ),
                    padding: hasBubbleArea
                        ? const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          )
                        : EdgeInsets.zero,
                    decoration: hasBubbleArea
                        ? BoxDecoration(
                            color: isMe ? null : colors.surface,
                            gradient: isMe
                                ? const LinearGradient(
                                    colors: [AppTheme.brand, AppTheme.brand2],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(20),
                              topRight: const Radius.circular(20),
                              bottomLeft: Radius.circular(isMe ? 20 : 4),
                              bottomRight: Radius.circular(isMe ? 4 : 20),
                            ),
                            boxShadow: [
                              if (isMe)
                                BoxShadow(
                                  color: AppTheme.brand.withOpacity(0.3),
                                  blurRadius: 14,
                                  offset: const Offset(0, 6),
                                )
                              else
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      isDarkMode ? 0.2 : 0.04),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                            ],
                          )
                        : null,
                    // 使用 Theme 配置局部文字颜色，以适应自定义气泡颜色
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: hasBubbleArea
                            ? (isMe ? Colors.white : colors.textPrimary)
                            : colors.textPrimary,
                        fontSize: 16,
                        height: 1.5,
                      ),
                      child: child,
                    ),
                  ),
                ),
                if (time != null || statusIcon != null)
                  Padding(
                    padding: EdgeInsets.only(
                      top: 4,
                      left: isMe ? 0 : 12,
                      right: isMe ? 8 : 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (time != null)
                          Text(
                            time!,
                            style: TextStyle(
                              fontSize: 11,
                              color: colors.textTertiary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        if (time != null && statusIcon != null)
                          const SizedBox(width: 4),
                        if (statusIcon != null) statusIcon!,
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return GestureDetector(
      onTap: onAvatarTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors.surfaceVariant,
          border: Border.all(
            color: colors.border.withOpacity(0.5),
            width: 1,
          ),
          image: senderAvatarUrl != null && senderAvatarUrl!.isNotEmpty
              ? DecorationImage(
                  image: NetworkImage(senderAvatarUrl!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: senderAvatarUrl == null || senderAvatarUrl!.isEmpty
            ? Icon(
                Icons.person_rounded,
                color: colors.iconSecondary,
                size: 20,
              )
            : null,
      ),
    );
  }
}
