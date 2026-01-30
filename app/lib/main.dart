import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nova_api/nova_api.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

// 主题配置
import 'config/app_theme.dart';
import 'config/theme_provider.dart';

// 导入5个页面
import 'features/home/pages/home_page.dart';
import 'features/course/pages/course_page.dart';
import 'features/circle/pages/circle_page.dart';
import 'features/chat/pages/chat_page.dart';
import 'features/profile/pages/profile_page.dart';
import 'features/auth/pages/login_page.dart';
import 'features/auth/services/auth_service.dart';

// 圈子相关页面
import 'features/circle/pages/post_edit_page.dart';
import 'features/circle/pages/user_posts_page.dart';
import 'features/circle/pages/user_profile_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  /// 全局访问 ThemeProvider 的方法
  static ThemeProvider of(BuildContext context) {
    final state = context.findAncestorStateOfType<_MyAppState>();
    return state!._themeProvider;
  }
}

class _MyAppState extends State<MyApp> {
  final ThemeProvider _themeProvider = ThemeProvider();

  @override
  void initState() {
    super.initState();
    _themeProvider.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    _themeProvider.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // 自定义 TDesign 主题颜色
    final customTDTheme = TDThemeData.defaultData().copyWithTDThemeData(
      'custom',
      colorMap: {
        'brandColor7': AppTheme.brand,
        'brandNormalColor': AppTheme.brand,
        'brandHoverColor': AppTheme.brand,
        'brandFocusColor': AppTheme.brand,
        'brandClickColor': AppTheme.brand,
      },
    );

    return TDTheme(
      data: customTDTheme,
      child: MaterialApp(
        title: '智云星课',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _themeProvider.currentThemeMode,
        home: const SplashPage(),
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/circle/edit':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => PostEditPage(
            postId: args?['postId'] as int?,
            post: args?['post'] as PostDetailResponse?,
          ),
        );
      case '/circle/user-posts':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => UserPostsPage(
            userId: args['userId'] as int,
            userName: args['userName'] as String?,
          ),
        );
      case '/circle/user-profile':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => UserProfilePage(
            userId: args['userId'] as int,
            initialUserInfo: args['userInfo'] as UserPublicResponse?,
          ),
        );
      default:
        return null;
    }
  }
}

/// 启动页 - 检查登录状态
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final authService = AuthService();
    final isLoggedIn = await authService.init();
    
    // 延迟一点时间让动画展示更完整
    await Future.delayed(const Duration(milliseconds: 2000));
    
    if (!mounted) return;
    
    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (context, anim, _) => const MainPage(),
          transitionsBuilder: (context, anim, _, child) => FadeTransition(opacity: anim, child: child),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (context, anim, _) => const LoginPage(),
          transitionsBuilder: (context, anim, _, child) => FadeTransition(opacity: anim, child: child),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    const brand = AppTheme.brand;
    const brand2 = AppTheme.brand2;

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          // 1. 氛围背景
          Positioned.fill(
            child: Container(color: colors.background),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: context.isDarkMode ? 0.2 : 0.4,
              child: CustomPaint(
                painter: _SplashBgPainter(
                  primary: brand.withOpacity(context.isDarkMode ? 0.15 : 0.1),
                  secondary: brand2.withOpacity(context.isDarkMode ? 0.12 : 0.08),
                ),
              ),
            ),
          ),
          // 2. 内容
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'app_logo',
                      child: SvgPicture.asset(
                        'lib/assests/logo/logo.svg',
                        width: 120,
                        height: 120,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      '智云星课',
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '让教育在云端触手可及',
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 3. 底部加载进度
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SizedBox(
                  width: 40,
                  height: 4,
                  child: LinearProgressIndicator(
                    backgroundColor: brand.withOpacity(context.isDarkMode ? 0.2 : 0.1),
                    valueColor: const AlwaysStoppedAnimation<Color>(brand),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashBgPainter extends CustomPainter {
  final Color primary;
  final Color secondary;

  _SplashBgPainter({required this.primary, required this.secondary});

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Paint()
      ..color = primary
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 80);
    final p2 = Paint()
      ..color = secondary
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);

    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.2), size.width * 0.5, p1);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.8), size.width * 0.6, p2);
  }

  @override
  bool shouldRepaint(covariant _SplashBgPainter oldDelegate) => false;
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    CoursePage(),
    CirclePage(),
    ChatPage(),
    ProfilePage(),
  ];

  final List<_TabItem> _tabs = const [
    _TabItem(label: '首页', icon: 'lib/assests/fonts/icons/主页.svg'),
    _TabItem(label: '课程', icon: 'lib/assests/fonts/icons/课程.svg'),
    _TabItem(label: '圈子', icon: 'lib/assests/fonts/icons/圈子.svg'),
    _TabItem(label: '对话', icon: 'lib/assests/fonts/icons/对话.svg'),
    _TabItem(label: '我的', icon: 'lib/assests/fonts/icons/我的.svg'),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: _AnimatedBottomBar(
          currentIndex: _currentIndex,
          tabs: _tabs,
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }
}

class _TabItem {
  final String label;
  final String icon;

  const _TabItem({required this.label, required this.icon});
}

class _AnimatedBottomBar extends StatelessWidget {
  final int currentIndex;
  final List<_TabItem> tabs;
  final ValueChanged<int> onTap;

  const _AnimatedBottomBar({
    required this.currentIndex,
    required this.tabs,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(context.isDarkMode ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 56,
          child: Row(
            children: List.generate(tabs.length, (index) {
              final isSelected = index == currentIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedScale(
                        scale: isSelected ? 1.1 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: SvgPicture.asset(
                          tabs[index].icon,
                          width: 24,
                          height: 24,
                          colorFilter: isSelected
                              ? null
                              : const ColorFilter.mode(
                                  Colors.grey,
                                  BlendMode.srcIn,
                                ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: 10,
                          color: isSelected
                              ? TDTheme.of(context).brandColor7
                              : Colors.grey,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                        child: Text(tabs[index].label),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
