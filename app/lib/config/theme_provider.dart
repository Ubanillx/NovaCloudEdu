import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// 主题模式枚举
enum AppThemeMode {
  system, // 跟随系统
  light,  // 亮色模式
  dark,   // 暗色模式
}

/// 主题状态管理
class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'app_theme_mode';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AppThemeMode _themeMode = AppThemeMode.system;
  AppThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadThemeMode();
  }

  /// 获取当前应该使用的 ThemeMode
  ThemeMode get currentThemeMode {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  /// 判断当前实际是否为暗色模式
  bool get isDarkMode {
    if (_themeMode == AppThemeMode.system) {
      final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    }
    return _themeMode == AppThemeMode.dark;
  }

  /// 加载保存的主题设置
  Future<void> _loadThemeMode() async {
    try {
      final savedMode = await _storage.read(key: _themeKey);
      if (savedMode != null) {
        _themeMode = AppThemeMode.values.firstWhere(
          (e) => e.name == savedMode,
          orElse: () => AppThemeMode.system,
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed to load theme mode: $e');
    }
  }

  /// 设置主题模式
  Future<void> setThemeMode(AppThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();

    try {
      await _storage.write(key: _themeKey, value: mode.name);
    } catch (e) {
      debugPrint('Failed to save theme mode: $e');
    }
  }

  /// 切换主题（在亮色和暗色之间切换）
  Future<void> toggleTheme() async {
    final newMode = isDarkMode ? AppThemeMode.light : AppThemeMode.dark;
    await setThemeMode(newMode);
  }

  /// 重置为跟随系统
  Future<void> resetToSystem() async {
    await setThemeMode(AppThemeMode.system);
  }
}
