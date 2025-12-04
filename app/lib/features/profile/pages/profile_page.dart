import 'package:flutter/material.dart';
import '../../data/mock_data.dart';

/// 个人中心页面 - 参考smartclass Profile.vue
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FD),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
          },
          child: CustomScrollView(
            slivers: [
              // 用户信息卡片
              SliverToBoxAdapter(child: _buildUserInfoCard()),
              // 学习数据
              SliverToBoxAdapter(child: _buildStudyStats()),
              // 今日学习目标
              SliverToBoxAdapter(child: _buildTodayGoals()),
              // 成就徽章
              SliverToBoxAdapter(child: _buildAchievements()),
              // 功能菜单
              SliverToBoxAdapter(child: _buildMenuList()),
              // 底部间距
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ),
      ),
    );
  }

  // 用户信息卡片
  Widget _buildUserInfoCard() {
    final user = MockData.userProfile;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1989FA), Color(0xFF36D1DC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1989FA).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // 头像
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: const Icon(
                  Icons.person,
                  size: 36,
                  color: Color(0xFF1989FA),
                ),
              ),
              const SizedBox(width: 16),
              // 用户信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          user.username,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Lv.${user.level}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // 经验条
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.6,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 设置按钮
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 学习数据
  Widget _buildStudyStats() {
    final user = MockData.userProfile;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('学习天数', '${user.daysLearned}', Icons.calendar_today),
          _buildDivider(),
          _buildStatItem(
            '连续打卡',
            '${user.streakDays}天',
            Icons.local_fire_department,
          ),
          _buildDivider(),
          _buildStatItem('获得星星', '${user.stars}', Icons.star),
          _buildDivider(),
          _buildStatItem('徽章数', '${user.badges}', Icons.military_tech),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF1989FA), size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(width: 1, height: 40, color: Colors.grey[200]);
  }

  // 今日学习目标
  Widget _buildTodayGoals() {
    final goals = MockData.learningGoals;
    final completedCount = goals.where((g) => g.completed).length;
    final progress = goals.isEmpty ? 0.0 : completedCount / goals.length;

    return Container(
      margin: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '今日学习目标',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1989FA),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 进度条
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1989FA), Color(0xFF36D1DC)],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // 目标列表
          ...goals.map((goal) => _buildGoalItem(goal)),
        ],
      ),
    );
  }

  Widget _buildGoalItem(LearningGoal goal) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            goal.completed = !goal.completed;
          });
        },
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: goal.completed
                    ? const Color(0xFF07C160)
                    : Colors.transparent,
                border: Border.all(
                  color: goal.completed ? const Color(0xFF07C160) : Colors.grey,
                  width: 2,
                ),
              ),
              child: goal.completed
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              goal.text,
              style: TextStyle(
                fontSize: 14,
                color: goal.completed ? Colors.grey : Colors.black87,
                decoration: goal.completed ? TextDecoration.lineThrough : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 成就徽章
  Widget _buildAchievements() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '我的成就',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {},
                child: const Row(
                  children: [
                    Text(
                      '查看全部',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Icon(Icons.chevron_right, size: 16, color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: MockData.badges
                .map((badge) => _buildBadgeItem(badge))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeItem(AchievementBadge badge) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Color(badge.color).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getBadgeIcon(badge.icon),
            color: Color(badge.color),
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          badge.name,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }

  IconData _getBadgeIcon(String icon) {
    switch (icon) {
      case 'star':
        return Icons.star;
      case 'fire':
        return Icons.local_fire_department;
      case 'headphones':
        return Icons.headphones;
      case 'trophy':
        return Icons.emoji_events;
      default:
        return Icons.emoji_events;
    }
  }

  // 功能菜单
  Widget _buildMenuList() {
    final menuItems = [
      {'icon': Icons.history, 'title': '学习历史', 'subtitle': '查看学习记录'},
      {'icon': Icons.bookmark_outline, 'title': '我的收藏', 'subtitle': '收藏的内容'},
      {'icon': Icons.download_outlined, 'title': '离线下载', 'subtitle': '管理下载内容'},
      {'icon': Icons.help_outline, 'title': '帮助中心', 'subtitle': '常见问题解答'},
      {'icon': Icons.info_outline, 'title': '关于我们', 'subtitle': '版本信息'},
    ];

    return Container(
      margin: const EdgeInsets.all(16),
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
        children: menuItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Column(
            children: [
              ListTile(
                leading: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1989FA).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: const Color(0xFF1989FA),
                    size: 20,
                  ),
                ),
                title: Text(
                  item['title'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  item['subtitle'] as String,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {},
              ),
              if (index < menuItems.length - 1)
                Divider(height: 1, indent: 60, color: Colors.grey[100]),
            ],
          );
        }).toList(),
      ),
    );
  }
}
