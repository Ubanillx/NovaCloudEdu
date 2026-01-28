import 'package:flutter/material.dart';

/// 应用主题配置
/// 统一管理亮色/暗色模式下的所有颜色和样式
class AppTheme {
  AppTheme._();

  // ==================== 品牌色 ====================
  static const Color brand = Color(0xFF2563EB);
  static const Color brand2 = Color(0xFF3B82F6);

  // ==================== 亮色模式颜色 ====================
  static const _LightColors light = _LightColors();

  // ==================== 暗色模式颜色 ====================
  static const _DarkColors dark = _DarkColors();

  // ==================== 主题数据 ====================
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: brand,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: light.background,
        appBarTheme: AppBarTheme(
          backgroundColor: light.surface,
          foregroundColor: light.textPrimary,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        cardTheme: CardThemeData(
          color: light.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        dividerTheme: DividerThemeData(
          color: light.divider,
          thickness: 1,
        ),
        textTheme: _buildTextTheme(light),
        iconTheme: IconThemeData(color: light.iconPrimary),
        extensions: [
          AppColors(
            background: light.background,
            surface: light.surface,
            surfaceVariant: light.surfaceVariant,
            textPrimary: light.textPrimary,
            textSecondary: light.textSecondary,
            textTertiary: light.textTertiary,
            divider: light.divider,
            border: light.border,
            iconPrimary: light.iconPrimary,
            iconSecondary: light.iconSecondary,
            success: light.success,
            warning: light.warning,
            error: light.error,
            info: light.info,
          ),
        ],
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: brand,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: dark.background,
        appBarTheme: AppBarTheme(
          backgroundColor: dark.surface,
          foregroundColor: dark.textPrimary,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        cardTheme: CardThemeData(
          color: dark.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        dividerTheme: DividerThemeData(
          color: dark.divider,
          thickness: 1,
        ),
        textTheme: _buildTextTheme(dark),
        iconTheme: IconThemeData(color: dark.iconPrimary),
        extensions: [
          AppColors(
            background: dark.background,
            surface: dark.surface,
            surfaceVariant: dark.surfaceVariant,
            textPrimary: dark.textPrimary,
            textSecondary: dark.textSecondary,
            textTertiary: dark.textTertiary,
            divider: dark.divider,
            border: dark.border,
            iconPrimary: dark.iconPrimary,
            iconSecondary: dark.iconSecondary,
            success: dark.success,
            warning: dark.warning,
            error: dark.error,
            info: dark.info,
          ),
        ],
      );

  static TextTheme _buildTextTheme(_BaseColors colors) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w900,
        color: colors.textPrimary,
        letterSpacing: -1.5,
      ),
      displayMedium: TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.w900,
        color: colors.textPrimary,
        letterSpacing: -1.5,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w900,
        color: colors.textPrimary,
        letterSpacing: -1.2,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: colors.textPrimary,
        letterSpacing: -0.5,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w900,
        color: colors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: colors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colors.textSecondary,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: colors.textTertiary,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),
    );
  }
}

// ==================== 颜色基类 ====================
abstract class _BaseColors {
  const _BaseColors();

  Color get background;
  Color get surface;
  Color get surfaceVariant;
  Color get textPrimary;
  Color get textSecondary;
  Color get textTertiary;
  Color get divider;
  Color get border;
  Color get iconPrimary;
  Color get iconSecondary;
  Color get success;
  Color get warning;
  Color get error;
  Color get info;
}

// ==================== 亮色模式颜色定义 ====================
class _LightColors extends _BaseColors {
  const _LightColors();

  @override
  Color get background => const Color(0xFFF8FAFC);
  @override
  Color get surface => const Color(0xFFFFFFFF);
  @override
  Color get surfaceVariant => const Color(0xFFF1F5F9);
  @override
  Color get textPrimary => const Color(0xFF1E293B);
  @override
  Color get textSecondary => const Color(0xFF64748B);
  @override
  Color get textTertiary => const Color(0xFF94A3B8);
  @override
  Color get divider => const Color(0xFFE2E8F0);
  @override
  Color get border => const Color(0xFFCBD5E1);
  @override
  Color get iconPrimary => const Color(0xFF64748B);
  @override
  Color get iconSecondary => const Color(0xFF94A3B8);
  @override
  Color get success => const Color(0xFF10B981);
  @override
  Color get warning => const Color(0xFFF59E0B);
  @override
  Color get error => const Color(0xFFEF4444);
  @override
  Color get info => const Color(0xFF3B82F6);
}

// ==================== 暗色模式颜色定义 ====================
class _DarkColors extends _BaseColors {
  const _DarkColors();

  @override
  Color get background => const Color(0xFF0F172A);
  @override
  Color get surface => const Color(0xFF1E293B);
  @override
  Color get surfaceVariant => const Color(0xFF334155);
  @override
  Color get textPrimary => const Color(0xFFF1F5F9);
  @override
  Color get textSecondary => const Color(0xFF94A3B8);
  @override
  Color get textTertiary => const Color(0xFF64748B);
  @override
  Color get divider => const Color(0xFF334155);
  @override
  Color get border => const Color(0xFF475569);
  @override
  Color get iconPrimary => const Color(0xFF94A3B8);
  @override
  Color get iconSecondary => const Color(0xFF64748B);
  @override
  Color get success => const Color(0xFF34D399);
  @override
  Color get warning => const Color(0xFFFBBF24);
  @override
  Color get error => const Color(0xFFF87171);
  @override
  Color get info => const Color(0xFF60A5FA);
}

// ==================== 主题扩展 - 用于在组件中访问颜色 ====================
@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color divider;
  final Color border;
  final Color iconPrimary;
  final Color iconSecondary;
  final Color success;
  final Color warning;
  final Color error;
  final Color info;

  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.divider,
    required this.border,
    required this.iconPrimary,
    required this.iconSecondary,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
  });

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceVariant,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? divider,
    Color? border,
    Color? iconPrimary,
    Color? iconSecondary,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      divider: divider ?? this.divider,
      border: border ?? this.border,
      iconPrimary: iconPrimary ?? this.iconPrimary,
      iconSecondary: iconSecondary ?? this.iconSecondary,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      border: Color.lerp(border, other.border, t)!,
      iconPrimary: Color.lerp(iconPrimary, other.iconPrimary, t)!,
      iconSecondary: Color.lerp(iconSecondary, other.iconSecondary, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }
}

// ==================== 便捷扩展方法 ====================
extension AppColorsExtension on BuildContext {
  /// 获取当前主题的颜色配置
  AppColors get colors => Theme.of(this).extension<AppColors>()!;

  /// 判断当前是否为暗色模式
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
