import 'package:flutter/material.dart';
import '../../data/mock_data.dart';

/// 圈子页面 - 参考smartclass Circle.vue
class CirclePage extends StatefulWidget {
  const CirclePage({super.key});

  @override
  State<CirclePage> createState() => _CirclePageState();
}

class _CirclePageState extends State<CirclePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['推荐', '关注', '热榜', '问答'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FD),
      body: SafeArea(
        child: Column(
          children: [
            // 头部
            _buildHeader(),
            // 导航标签
            _buildTabBar(),
            // 内容区域
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPostList(),
                  _buildEmptyState('关注更多用户，获取精彩内容'),
                  _buildEmptyState('热榜内容筹备中'),
                  _buildEmptyState('问答功能开发中'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFF1989FA),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('发布', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  // 头部
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(Icons.people_outline, color: Color(0xFF1989FA), size: 24),
              SizedBox(width: 8),
              Text(
                '圈子',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, size: 22),
          ),
        ],
      ),
    );
  }

  // 导航标签
  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEBEDF0), width: 1)),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: const Color(0xFF1989FA),
        unselectedLabelColor: const Color(0xFF646566),
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        indicatorColor: const Color(0xFF1989FA),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
      ),
    );
  }

  // 帖子列表
  Widget _buildPostList() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: MockData.posts.length,
        itemBuilder: (context, index) {
          return _buildPostCard(MockData.posts[index]);
        },
      ),
    );
  }

  // 帖子卡片
  Widget _buildPostCard(Post post) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 用户信息
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.person, size: 20, color: Colors.grey),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.authorName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        post.createTime,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 标题
            Text(
              post.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // 内容
            Text(
              post.content,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF323233),
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            // 图片
            if (post.images.isNotEmpty) ...[
              const SizedBox(height: 12),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: post.images.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      post.images[index],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 12),
            // 底部操作栏
            Container(
              padding: const EdgeInsets.only(top: 12),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFF2F3F5), width: 1),
                ),
              ),
              child: Row(
                children: [
                  _buildActionButton(
                    icon: post.hasThumb
                        ? Icons.thumb_up
                        : Icons.thumb_up_outlined,
                    count: post.thumbNum,
                    isActive: post.hasThumb,
                    activeColor: Colors.red,
                    onTap: () {
                      setState(() {
                        post.hasThumb = !post.hasThumb;
                      });
                    },
                  ),
                  const SizedBox(width: 20),
                  _buildActionButton(
                    icon: Icons.chat_bubble_outline,
                    count: post.commentNum,
                    onTap: () => _showCommentSheet(post),
                  ),
                  const SizedBox(width: 20),
                  _buildActionButton(
                    icon: post.hasFavour ? Icons.star : Icons.star_outline,
                    count: post.favourNum,
                    isActive: post.hasFavour,
                    activeColor: Colors.amber,
                    onTap: () {
                      setState(() {
                        post.hasFavour = !post.hasFavour;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 操作按钮
  Widget _buildActionButton({
    required IconData icon,
    required int count,
    bool isActive = false,
    Color? activeColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isActive ? activeColor : const Color(0xFF969799),
          ),
          const SizedBox(width: 4),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 12,
              color: isActive ? activeColor : const Color(0xFF969799),
            ),
          ),
        ],
      ),
    );
  }

  // 评论弹窗
  void _showCommentSheet(Post post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            // 头部
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '评论',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, size: 20),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // 评论列表
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 48,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 16),
                    const Text('暂无评论', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
            // 输入框
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey[200]!)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: '发表评论...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1989FA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      '发送',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 空状态
  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
