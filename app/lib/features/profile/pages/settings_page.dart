import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';
import '../../../main.dart';
import '../../../core/database/database_service.dart';
import '../../auth/services/auth_service.dart';
import '../../auth/pages/login_page.dart';
import '../../../widgets/toast/nova_message.dart';
import 'feedback_page.dart';

/// 设置页面
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AuthService _authService = AuthService();
  bool _isLoggingOut = false;
  bool _isClearingCache = false;

  Future<void> _handleLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => _LogoutConfirmDialog(),
    );

    if (confirmed == true && mounted) {
      setState(() => _isLoggingOut = true);
      
      try {
        await _authService.logout();
        
        if (!mounted) return;
        
        NovaMessage.success(context, '已退出登录');
        
        // 跳转到登录页并清除所有路由
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
        );
      } catch (e) {
        if (mounted) {
          setState(() => _isLoggingOut = false);
          NovaMessage.error(context, '退出失败，请重试');
        }
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
          '设置',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 外观设置区域
              _buildSectionTitle('外观设置'),
              const SizedBox(height: 12),
              _buildSettingsCard([
                _buildThemeSwitch(),
              ]),
              
              const SizedBox(height: 32),
              
              // 存储管理区域
              _buildSectionTitle('存储管理'),
              const SizedBox(height: 12),
              _buildSettingsCard([
                _buildClearCacheItem(),
              ]),
              
              const SizedBox(height: 32),
              
              // 账号安全区域
              _buildSectionTitle('账号安全'),
              const SizedBox(height: 12),
              _buildSettingsCard([
                _buildSettingsItem(
                  icon: Icons.lock_outline_rounded,
                  iconColor: const Color(0xFF3B82F6),
                  title: '修改密码',
                  onTap: () {
                    NovaMessage.show(context, '请联系管理员重置密码');
                  },
                ),
              ]),
              
              const SizedBox(height: 32),
              
              // 帮助与反馈区域
              _buildSectionTitle('帮助与反馈'),
              const SizedBox(height: 12),
              _buildSettingsCard([
                _buildSettingsItem(
                  icon: Icons.feedback_outlined,
                  iconColor: const Color(0xFF8B5CF6),
                  title: '意见反馈',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const FeedbackPage()),
                    );
                  },
                  showDivider: false,
                ),
              ]),
              
              const SizedBox(height: 32),
              
              // 关于区域
              _buildSectionTitle('关于'),
              const SizedBox(height: 12),
              _buildSettingsCard([
                _buildSettingsItem(
                  icon: Icons.info_outline_rounded,
                  iconColor: const Color(0xFF10B981),
                  title: '版本信息',
                  trailing: Text(
                    'v1.0.0',
                    style: TextStyle(
                      color: colors.textTertiary,
                      fontSize: 14,
                    ),
                  ),
                ),
                _buildSettingsItem(
                  icon: Icons.description_outlined,
                  iconColor: const Color(0xFF6366F1),
                  title: '用户协议',
                  onTap: () {},
                ),
                _buildSettingsItem(
                  icon: Icons.privacy_tip_outlined,
                  iconColor: const Color(0xFFEC4899),
                  title: '隐私政策',
                  onTap: () {},
                  showDivider: false,
                ),
              ]),
              
              const SizedBox(height: 48),
              
              // 退出登录按钮
              _buildLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    final colors = context.colors;
    return Text(
      title,
      style: TextStyle(
        color: colors.textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
    bool showDivider = true,
  }) {
    final colors = context.colors;
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(context.isDarkMode ? 0.2 : 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (trailing != null) trailing,
                if (onTap != null && trailing == null)
                  Icon(Icons.chevron_right_rounded, color: colors.border, size: 24),
              ],
            ),
          ),
        ),
        if (showDivider)
          Padding(
            padding: const EdgeInsets.only(left: 76),
            child: Divider(height: 1, color: colors.divider),
          ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    final colors = context.colors;
    return GestureDetector(
      onTap: _isLoggingOut ? null : _handleLogout,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: colors.error.withOpacity(context.isDarkMode ? 0.2 : 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colors.error.withOpacity(0.2),
          ),
        ),
        child: Center(
          child: _isLoggingOut
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(colors.error),
                  ),
                )
              : Text(
                  '退出登录',
                  style: TextStyle(
                    color: colors.error,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildThemeSwitch() {
    final colors = context.colors;
    final themeProvider = MyApp.of(context);
    
    return InkWell(
      onTap: () {
        themeProvider.toggleTheme();
        NovaMessage.success(context, themeProvider.isDarkMode ? '已切换到深色模式' : '已切换到浅色模式');
      },
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B).withOpacity(context.isDarkMode ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                themeProvider.isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                color: const Color(0xFFF59E0B),
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                '深色模式',
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
                NovaMessage.success(context, value ? '已切换到深色模式' : '已切换到浅色模式');
              },
              activeThumbColor: const Color(0xFF3B82F6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClearCacheItem() {
    final colors = context.colors;
    
    return InkWell(
      onTap: _isClearingCache ? null : _handleClearCache,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withOpacity(context.isDarkMode ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.cleaning_services_rounded,
                color: Color(0xFFEF4444),
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                '清除缓存',
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (_isClearingCache)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              Icon(Icons.chevron_right_rounded, color: colors.border, size: 24),
          ],
        ),
      ),
    );
  }

  Future<void> _handleClearCache() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => _ClearCacheConfirmDialog(),
    );

    if (confirmed == true && mounted) {
      setState(() => _isClearingCache = true);
      
      try {
        await DatabaseService().close();
        await Future.delayed(const Duration(milliseconds: 500));
        
        if (!mounted) return;
        
        setState(() => _isClearingCache = false);
        NovaMessage.success(context, '缓存已清除');
      } catch (e) {
        if (mounted) {
          setState(() => _isClearingCache = false);
          NovaMessage.error(context, '清除失败，请重试');
        }
      }
    }
  }
}

class _ClearCacheConfirmDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Dialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withOpacity(context.isDarkMode ? 0.2 : 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.cleaning_services_rounded,
                color: Color(0xFFEF4444),
                size: 32,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '确认清除缓存？',
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '将清除应用缓存数据，不会影响已登录状态',
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: colors.surfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '取消',
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(true),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          '确认清除',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoutConfirmDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Dialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: colors.error.withOpacity(context.isDarkMode ? 0.2 : 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.logout_rounded,
                color: colors.error,
                size: 32,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '确认退出登录？',
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '退出后需要重新登录才能使用',
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: colors.surfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '取消',
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(true),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: colors.error,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          '确认退出',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
