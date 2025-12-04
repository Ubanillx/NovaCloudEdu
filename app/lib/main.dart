import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

// 导入5个页面
import 'features/home/pages/home_page.dart';
import 'features/course/pages/course_page.dart';
import 'features/circle/pages/circle_page.dart';
import 'features/chat/pages/chat_page.dart';
import 'features/profile/pages/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NovaCloudEdu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MainPage(),
    );
  }
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
