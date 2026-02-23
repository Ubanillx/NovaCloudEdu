/// Nova 骨架屏组件库
library;

import 'package:flutter/material.dart';
import '../../config/app_theme.dart';
import 'loading_widget.dart';

// ==================== 基础原子组件 ====================

/// 骨架屏占位条（矩形）
class SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonBox({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[200],
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

/// 骨架屏圆形占位（头像等）
class SkeletonCircle extends StatelessWidget {
  final double size;

  const SkeletonCircle({super.key, this.size = 44});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[200],
        shape: BoxShape.circle,
      ),
    );
  }
}

/// 骨架屏文字行
class SkeletonLine extends StatelessWidget {
  final double width;
  final double height;

  const SkeletonLine({
    super.key,
    this.width = double.infinity,
    this.height = 14,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonBox(width: width, height: height, borderRadius: 4);
  }
}

// ==================== 组合骨架屏 ====================

/// 通用列表项骨架（头像 + 标题 + 副标题）
class ListItemSkeleton extends StatelessWidget {
  final int itemCount;
  final double avatarSize;
  final bool showAvatar;
  final EdgeInsets padding;

  const ListItemSkeleton({
    super.key,
    this.itemCount = 6,
    this.avatarSize = 44,
    this.showAvatar = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: ListView.builder(
        padding: padding,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              if (showAvatar) ...[
                SkeletonCircle(size: avatarSize),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonLine(width: showAvatar ? 140 : 180),
                    const SizedBox(height: 8),
                    SkeletonLine(width: showAvatar ? 200 : 260, height: 12),
                  ],
                ),
              ),
              const SkeletonBox(width: 48, height: 12, borderRadius: 4),
            ],
          ),
        ),
      ),
    );
  }
}

/// 聊天会话列表骨架
class ChatListSkeleton extends StatelessWidget {
  final int itemCount;

  const ChatListSkeleton({super.key, this.itemCount = 8});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              const SkeletonCircle(size: 48),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SkeletonLine(width: 100, height: 14),
                        const Spacer(),
                        SkeletonLine(width: 40, height: 10),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const SkeletonLine(width: 180, height: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 聊天消息列表骨架
class ChatMessageSkeleton extends StatelessWidget {
  final int itemCount;

  const ChatMessageSkeleton({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (_, index) {
          final isLeft = index % 3 != 1;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment:
                  isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isLeft) ...[
                  const SkeletonCircle(size: 36),
                  const SizedBox(width: 8),
                ],
                SkeletonBox(
                  width: isLeft ? 180 : 140,
                  height: index % 4 == 2 ? 56 : 36,
                  borderRadius: 16,
                ),
                if (!isLeft) ...[
                  const SizedBox(width: 8),
                  const SkeletonCircle(size: 36),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

/// 帖子/动态列表骨架
class PostListSkeleton extends StatelessWidget {
  final int itemCount;

  const PostListSkeleton({super.key, this.itemCount = 4});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 用户头像 + 名字
              Row(
                children: [
                  const SkeletonCircle(size: 36),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SkeletonLine(width: 80, height: 13),
                      const SizedBox(height: 4),
                      SkeletonLine(width: 50, height: 10),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // 文字内容
              const SkeletonLine(width: double.infinity, height: 13),
              const SizedBox(height: 6),
              const SkeletonLine(width: 240, height: 13),
              const SizedBox(height: 12),
              // 图片占位
              const SkeletonBox(width: double.infinity, height: 160, borderRadius: 12),
              const SizedBox(height: 12),
              // 操作栏
              Row(
                children: [
                  SkeletonBox(width: 48, height: 16, borderRadius: 4),
                  const SizedBox(width: 24),
                  SkeletonBox(width: 48, height: 16, borderRadius: 4),
                  const SizedBox(width: 24),
                  SkeletonBox(width: 48, height: 16, borderRadius: 4),
                ],
              ),
              const SizedBox(height: 8),
              Divider(color: Colors.grey[300], height: 1),
            ],
          ),
        ),
      ),
    );
  }
}

/// 网格卡片骨架（书架、课程等）
class GridCardSkeleton extends StatelessWidget {
  final int crossAxisCount;
  final double childAspectRatio;
  final int itemCount;
  final EdgeInsets padding;

  const GridCardSkeleton({
    super.key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 0.52,
    this.itemCount = 9,
    this.padding = const EdgeInsets.fromLTRB(20, 12, 20, 20),
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: GridView.builder(
        padding: padding,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 16,
          crossAxisSpacing: 14,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: itemCount,
        itemBuilder: (_, __) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SkeletonBox(
                height: double.infinity,
                borderRadius: 12,
              ),
            ),
            const SizedBox(height: 10),
            const SkeletonLine(width: 80, height: 12),
            const SizedBox(height: 4),
            SkeletonLine(width: 50, height: 10),
          ],
        ),
      ),
    );
  }
}

/// 个人资料骨架
class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // 头像
            const SkeletonCircle(size: 80),
            const SizedBox(height: 16),
            // 名字
            const SkeletonLine(width: 120, height: 18),
            const SizedBox(height: 8),
            SkeletonLine(width: 80, height: 12),
            const SizedBox(height: 32),
            // 统计栏
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                3,
                (_) => Column(
                  children: [
                    SkeletonBox(width: 40, height: 20, borderRadius: 4),
                    const SizedBox(height: 6),
                    SkeletonLine(width: 32, height: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // 信息行
            ...List.generate(
              4,
              (_) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    const SkeletonBox(width: 80, height: 14, borderRadius: 4),
                    const Spacer(),
                    SkeletonBox(width: 120, height: 14, borderRadius: 4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 详情页骨架（文章/公告/帖子详情）
class DetailPageSkeleton extends StatelessWidget {
  const DetailPageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            const SkeletonLine(width: 260, height: 20),
            const SizedBox(height: 12),
            // 元信息
            Row(
              children: [
                const SkeletonCircle(size: 32),
                const SizedBox(width: 8),
                const SkeletonLine(width: 80, height: 12),
                const Spacer(),
                SkeletonLine(width: 60, height: 10),
              ],
            ),
            const SizedBox(height: 24),
            // 内容段落
            const SkeletonLine(width: double.infinity, height: 14),
            const SizedBox(height: 8),
            const SkeletonLine(width: double.infinity, height: 14),
            const SizedBox(height: 8),
            const SkeletonLine(width: 200, height: 14),
            const SizedBox(height: 20),
            // 图片
            const SkeletonBox(width: double.infinity, height: 180, borderRadius: 12),
            const SizedBox(height: 20),
            // 更多段落
            const SkeletonLine(width: double.infinity, height: 14),
            const SizedBox(height: 8),
            const SkeletonLine(width: double.infinity, height: 14),
            const SizedBox(height: 8),
            const SkeletonLine(width: 160, height: 14),
          ],
        ),
      ),
    );
  }
}

/// 首页卡片区域骨架
class HomeSectionSkeleton extends StatelessWidget {
  final double height;

  const HomeSectionSkeleton({super.key, this.height = 120});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: context.isDarkMode ? Colors.grey[800] : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

/// 课程列表骨架（带图片的横向列表项）
class CourseListSkeleton extends StatelessWidget {
  final int itemCount;

  const CourseListSkeleton({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              SkeletonBox(width: 110, height: 72, borderRadius: 10),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SkeletonLine(width: 160, height: 14),
                    const SizedBox(height: 8),
                    const SkeletonLine(width: 100, height: 11),
                    const SizedBox(height: 8),
                    SkeletonLine(width: 60, height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 排行榜骨架
class RankingListSkeleton extends StatelessWidget {
  final int itemCount;

  const RankingListSkeleton({super.key, this.itemCount = 10});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              SkeletonBox(width: 24, height: 16, borderRadius: 4),
              const SizedBox(width: 12),
              const SkeletonCircle(size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SkeletonLine(width: 100, height: 13),
                    const SizedBox(height: 6),
                    SkeletonLine(width: 60, height: 10),
                  ],
                ),
              ),
              SkeletonBox(width: 50, height: 14, borderRadius: 4),
            ],
          ),
        ),
      ),
    );
  }
}
