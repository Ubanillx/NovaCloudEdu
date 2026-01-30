import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../../config/app_theme.dart';
import '../../../core/database/models/study_plan.dart';
import '../../../core/database/repositories/study_plan_repository.dart';
import '../../../widgets/toast/nova_message.dart';
import '../../../widgets/common/nova_refresh_header.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../auth/services/auth_service.dart';
import '../widgets/add_plan_dialog.dart';
import '../services/checkin_service.dart';
import 'settings_page.dart';
import 'profile_detail_page.dart';
import 'study_plan_page.dart';
import 'checkin_ranking_page.dart';
import '../../circle/pages/my_favourites_page.dart';

/// 个人中心页面 - 参考smartclass Profile.vue
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  final StudyPlanRepository _planRepository = StudyPlanRepository();
  final CheckinService _checkinService = CheckinService();
  Map<String, dynamic>? _userInfo;
  bool _isLoading = true;
  List<StudyPlan> _todayPlans = [];
  bool _isLoadingPlans = true;
  UserStats? _userStats;
  bool _isLoadingStats = true;
  bool _isChecking = false;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadTodayPlans();
    _loadUserStats();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadTodayPlans() async {
    try {
      final plans = await _planRepository.getTodayPlans();
      if (mounted) {
        setState(() {
          _todayPlans = plans;
          _isLoadingPlans = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingPlans = false);
      }
    }
  }

  Future<void> _addPlan() async {
    final result = await showDialog<StudyPlan>(
      context: context,
      builder: (context) => const AddPlanDialog(),
    );
    if (result != null) {
      try {
        await _planRepository.insert(result);
        await _loadTodayPlans();
        if (mounted) {
          NovaMessage.success(context, '添加成功');
        }
      } catch (e) {
        if (mounted) {
          NovaMessage.error(context, '添加失败');
        }
      }
    }
  }

  Future<void> _togglePlanComplete(StudyPlan plan) async {
    try {
      await _planRepository.toggleComplete(plan.id!, !plan.isCompleted);
      await _loadTodayPlans();
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '操作失败');
      }
    }
  }

  Future<void> _deletePlan(StudyPlan plan) async {
    try {
      await _planRepository.delete(plan.id!);
      await _loadTodayPlans();
      if (mounted) {
        NovaMessage.success(context, '已删除');
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '删除失败');
      }
    }
  }

  Future<void> _loadUserStats({bool forceRefresh = false}) async {
    try {
      final stats = await _checkinService.getUserStats(forceRefresh: forceRefresh);
      if (mounted) {
        setState(() {
          _userStats = stats;
          _isLoadingStats = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingStats = false);
      }
    }
  }

  Future<void> _handleCheckin() async {
    if (_isChecking) return;
    
    setState(() => _isChecking = true);
    try {
      final result = await _checkinService.checkin();
      if (mounted) {
        NovaMessage.success(context, '打卡成功！连续 ${result.streakDays} 天');
        // 打卡成功后更新缓存并刷新UI
        _checkinService.updateCacheAfterCheckin(result);
        await _loadUserStats();
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '打卡失败，请稍后重试');
      }
    } finally {
      if (mounted) {
        setState(() => _isChecking = false);
      }
    }
  }

  void _navigateToRanking() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CheckinRankingPage()),
    );
  }

  Future<void> _loadUserInfo() async {
    // 先加载本地缓存的用户信息
    final userInfo = await _authService.getUserInfo();
    if (mounted) {
      setState(() {
        _userInfo = userInfo;
        _isLoading = false;
      });
    }
    // 然后调用接口刷新最新的公开资料
    final updatedInfo = await _authService.refreshUserPublicInfo();
    if (mounted && updatedInfo != null) {
      setState(() {
        _userInfo = updatedInfo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: NovaRefreshableList(
          onRefresh: () async {
            await _loadUserInfo();
            await _loadUserStats(forceRefresh: true);
          },
          slivers: [
            // 用户信息卡片
            SliverToBoxAdapter(child: _buildUserInfoCard()),
            // 学习数据
            SliverToBoxAdapter(child: _buildStudyStats()),
            // 今日学习目标
            SliverToBoxAdapter(child: _buildTodayGoals()),
            // 功能菜单
            SliverToBoxAdapter(child: _buildMenuList()),
            // 底部间距
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  // 用户信息卡片
  Widget _buildUserInfoCard() {
    final colors = context.colors;
    final user = MockData.userProfile;
    
    // 优先使用真实用户信息
    final displayName = _userInfo?['userName'] ?? _userInfo?['userAccount'] ?? user.username;
    final userRole = _userInfo?['userRole'] ?? 'user';
    final roleLabel = userRole == 'admin' ? '管理员' : '学霸';
    
    // 性别处理
    final genderValue = _userInfo?['userGender'];
    IconData? genderIcon;
    Color? genderColor;
    String? genderLabel;
    
    if (genderValue != null) {
      final g = int.tryParse(genderValue.toString()) ?? 2;
      if (g == 0) {
        genderIcon = Icons.male_rounded;
        genderColor = const Color(0xFF3B82F6);
        genderLabel = '男';
      } else if (g == 1) {
        genderIcon = Icons.female_rounded;
        genderColor = const Color(0xFFEC4899);
        genderLabel = '女';
      } else {
        genderIcon = Icons.help_outline_rounded;
        genderColor = const Color(0xFF94A3B8);
        genderLabel = '保密';
      }
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(24, 32, 24, 16),
      child: Row(
        children: [
          // 头像
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProfileDetailPage()),
              );
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: colors.surface,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: _userInfo?['userAvatar'] != null && _userInfo!['userAvatar'].toString().isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        _userInfo!['userAvatar'].toString(),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Center(
                          child: Icon(
                            Icons.person_rounded,
                            size: 48,
                            color: colors.border,
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Icon(
                        Icons.person_rounded,
                        size: 48,
                        color: colors.border,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 20),
          // 用户信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        _isLoading ? '加载中...' : displayName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: colors.textPrimary,
                          letterSpacing: -0.5,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (genderIcon != null) ...[
                      const SizedBox(width: 8),
                      Icon(genderIcon, size: 20, color: genderColor),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildUserTag('Lv.${_userInfo?['level'] ?? user.level}', const Color(0xFF3B82F6)),
                    const SizedBox(width: 8),
                    _buildUserTag(roleLabel, const Color(0xFFF59E0B)),
                    if (genderLabel != null) ...[
                      const SizedBox(width: 8),
                      _buildUserTag(genderLabel, genderColor!),
                    ],
                  ],
                ),
              ],
            ),
          ),
          // 设置按钮
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
            icon: Icon(Icons.settings_outlined, color: colors.iconPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildUserTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // 学习数据
  Widget _buildStudyStats() {
    final colors = context.colors;

    if (_isLoadingStats) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 40),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(24),
        ),
        child: const LoadingWidget(),
      );
    }

    final stats = _userStats;
    final registerDays = stats?.registerDays ?? 0;
    final checkinDays = stats?.totalCheckinDays ?? 0;
    final likes = stats?.totalLikes ?? 0;
    final checkedIn = stats?.checkedInToday ?? false;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // 顶部统计行
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 28, 12, 24),
            child: Row(
              children: [
                _buildStatItem('学习天数', '$registerDays', Icons.calendar_today_rounded, const Color(0xFF3B82F6)),
                _buildStatLine(),
                _buildStatItem('打卡天数', '$checkinDays', Icons.local_fire_department_rounded, const Color(0xFFEF4444)),
                _buildStatLine(),
                _buildStatItem('获得心心', '$likes', Icons.favorite_rounded, const Color(0xFFEC4899)),
              ],
            ),
          ),
          
          // 操作区域
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Row(
              children: [
                // 打卡按钮
                Expanded(
                  child: GestureDetector(
                    onTap: checkedIn ? null : _handleCheckin,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: checkedIn
                            ? null
                            : const LinearGradient(
                                colors: [Color(0xFFFF4B2B), Color(0xFFFF416C)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                        color: checkedIn ? colors.surfaceVariant : null,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: checkedIn
                            ? null
                            : [
                                BoxShadow(
                                  color: const Color(0xFFFF4B2B).withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                      ),
                      child: Center(
                        child: _isChecking
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    checkedIn ? Icons.check_circle_rounded : Icons.bolt_rounded,
                                    color: checkedIn ? colors.textTertiary : Colors.white,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    checkedIn ? '今日任务已达成' : '开启今日打卡',
                                    style: TextStyle(
                                      color: checkedIn ? colors.textTertiary : Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // 排行榜入口
                GestureDetector(
                  onTap: _navigateToRanking,
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: colors.surfaceVariant.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: colors.divider.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.emoji_events_rounded,
                          color: const Color(0xFFFFD700),
                          size: 26,
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEF4444),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatLine() {
    return Container(
      width: 1,
      height: 32,
      color: context.colors.divider.withOpacity(0.5),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    final colors = context.colors;
    return Expanded(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
              Icon(icon, color: color, size: 22),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: colors.textPrimary,
              fontFamily: 'Inter', // 假设有这个字体，或者使用默认
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: colors.textTertiary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayGoals() {
    final colors = context.colors;
    final completedCount = _todayPlans.where((p) => p.isCompleted).length;
    final progress = _todayPlans.isEmpty ? 0.0 : completedCount / _todayPlans.length;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '今日学习计划',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: colors.textPrimary,
                ),
              ),
              Row(
                children: [
                  // 查看历史
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const StudyPlanPage()),
                      ).then((_) => _loadTodayPlans());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          Icon(Icons.history_rounded, size: 16, color: colors.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            '历史',
                            style: TextStyle(
                              fontSize: 12,
                              color: colors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // 进度百分比
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.brand.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      '${(progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.brand,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // 进度条
          Container(
            height: 10,
            decoration: BoxDecoration(
              color: colors.surfaceVariant,
              borderRadius: BorderRadius.circular(100),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.brand, AppTheme.brand2],
                  ),
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.brand.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // 计划列表
          if (_isLoadingPlans)
            const LoadingWidget(size: 24)
          else if (_todayPlans.isEmpty)
            _buildEmptyPlanState()
          else
            ..._todayPlans.map((plan) => _buildPlanItem(plan)),
          const SizedBox(height: 12),
          // 添加计划按钮
          GestureDetector(
            onTap: _addPlan,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: colors.border, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_rounded, size: 20, color: colors.textSecondary),
                  const SizedBox(width: 8),
                  Text(
                    '添加学习计划',
                    style: TextStyle(
                      fontSize: 14,
                      color: colors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyPlanState() {
    final colors = context.colors;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.event_note_outlined,
            size: 48,
            color: colors.iconSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: 12),
          Text(
            '今天还没有学习计划',
            style: TextStyle(
              fontSize: 14,
              color: colors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanItem(StudyPlan plan) {
    final colors = context.colors;
    final priorityColor = _getPriorityColor(plan.priority);
    
    return Dismissible(
      key: Key('plan_${plan.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: colors.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      onDismissed: (direction) => _deletePlan(plan),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: GestureDetector(
          onTap: () => _togglePlanComplete(plan),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: plan.isCompleted ? colors.surfaceVariant : colors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: plan.isCompleted ? Colors.transparent : colors.divider,
              ),
            ),
            child: Row(
              children: [
                // 完成状态
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: plan.isCompleted ? colors.success : Colors.transparent,
                    border: Border.all(
                      color: plan.isCompleted ? colors.success : colors.border,
                      width: 2,
                    ),
                  ),
                  child: plan.isCompleted
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 12),
                // 优先级标识
                if (plan.priority > 0)
                  Container(
                    width: 4,
                    height: 24,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: priorityColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                // 内容
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: plan.isCompleted ? FontWeight.w500 : FontWeight.w600,
                          color: plan.isCompleted ? colors.textTertiary : colors.textPrimary,
                          decoration: plan.isCompleted ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      if (plan.description != null && plan.description!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          plan.description!,
                          style: TextStyle(
                            fontSize: 12,
                            color: colors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                // 优先级标签
                if (plan.priority > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: priorityColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      plan.priorityText,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: priorityColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 2:
        return const Color(0xFFEF4444); // 紧急 - 红色
      case 1:
        return const Color(0xFFF59E0B); // 重要 - 橙色
      default:
        return const Color(0xFF3B82F6); // 普通 - 蓝色
    }
  }

  // 功能菜单
  Widget _buildMenuList() {
    final colors = context.colors;
    final menuItems = [
      {'icon': Icons.person_outline_rounded, 'title': '个人资料', 'color': const Color(0xFF8B5CF6), 'action': 'profile'},
      {'icon': Icons.history_rounded, 'title': '学习历史', 'color': const Color(0xFF6366F1), 'action': 'history'},
      {'icon': Icons.bookmark_rounded, 'title': '我的收藏', 'color': const Color(0xFFEC4899), 'action': 'bookmark'},
      {'icon': Icons.download_rounded, 'title': '离线下载', 'color': const Color(0xFF10B981), 'action': 'download'},
      {'icon': Icons.help_outline_rounded, 'title': '帮助中心', 'color': const Color(0xFF3B82F6), 'action': 'help'},
      {'icon': Icons.info_outline_rounded, 'title': '关于我们', 'color': const Color(0xFF94A3B8), 'action': 'about'},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
            child: Text(
              '更多服务',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: colors.textPrimary,
              ),
            ),
          ),
          ...menuItems.map((item) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (item['color'] as Color).withOpacity(context.isDarkMode ? 0.2 : 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item['icon'] as IconData,
                  color: item['color'] as Color,
                  size: 22,
                ),
              ),
              title: Text(
                item['title'] as String,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colors.textPrimary,
                ),
              ),
              trailing: Icon(Icons.chevron_right_rounded, color: colors.border, size: 24),
              onTap: () => _handleMenuTap(item['action'] as String),
            );
          }).toList(),
        ],
      ),
    );
  }

  void _handleMenuTap(String action) {
    switch (action) {
      case 'profile':
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ProfileDetailPage()),
        );
        break;
      case 'history':
        // TODO: 实现学习历史页面
        break;
      case 'bookmark':
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const MyFavouritesPage()),
        );
        break;
      case 'download':
        // TODO: 实现离线下载页面
        break;
      case 'help':
        // TODO: 实现帮助中心页面
        break;
      case 'about':
        // TODO: 实现关于我们页面
        break;
    }
  }
}
