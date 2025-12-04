import 'package:flutter/material.dart';
import '../../data/mock_data.dart';

/// 聊天页面 - 参考smartclass ChatContainer.vue
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['历史对话', '好友', '智慧体中心'];

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
                  _buildHistoryTab(),
                  _buildFriendsTab(),
                  _buildIntelligenceTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF1989FA),
        child: const Icon(Icons.add, color: Colors.white),
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
              Icon(
                Icons.chat_bubble_outline,
                color: Color(0xFF1989FA),
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                '聊天',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.person_add_outlined, size: 22),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, size: 22),
              ),
            ],
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
        unselectedLabelColor: const Color(0xFF969799),
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        indicatorColor: const Color(0xFF1989FA),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
      ),
    );
  }

  // 历史对话
  Widget _buildHistoryTab() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: MockData.chatSessions.length,
        itemBuilder: (context, index) {
          final session = MockData.chatSessions[index];
          return _buildChatItem(session);
        },
      ),
    );
  }

  // 好友列表
  Widget _buildFriendsTab() {
    final friends = MockData.chatSessions.where((s) => !s.isAi).toList();
    if (friends.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('暂无好友', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: friends.length,
      itemBuilder: (context, index) => _buildChatItem(friends[index]),
    );
  }

  // 智慧体中心
  Widget _buildIntelligenceTab() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.9,
        ),
        itemCount: MockData.aiAssistants.length,
        itemBuilder: (context, index) {
          final assistant = MockData.aiAssistants[index];
          return _buildAssistantCard(assistant);
        },
      ),
    );
  }

  // 聊天列表项
  Widget _buildChatItem(ChatSession session) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
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
        child: Row(
          children: [
            // 头像
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: session.isAi
                      ? const Color(0xFF1989FA).withOpacity(0.1)
                      : Colors.grey[200],
                  child: session.isAi
                      ? const Icon(Icons.smart_toy, color: Color(0xFF1989FA))
                      : const Icon(Icons.person, color: Colors.grey),
                ),
                if (session.unreadCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        session.unreadCount > 99
                            ? '99+'
                            : '${session.unreadCount}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            // 内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            session.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (session.isAi) ...[
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 1,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1989FA),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'AI',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        session.time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    session.lastMessage,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 智慧体卡片
  Widget _buildAssistantCard(AiAssistant assistant) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: const Color(0xFF1989FA).withOpacity(0.1),
              child: const Icon(
                Icons.smart_toy,
                size: 32,
                color: Color(0xFF1989FA),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              assistant.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              assistant.description,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 32,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF1989FA)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  '开始对话',
                  style: TextStyle(fontSize: 12, color: Color(0xFF1989FA)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
