/// 应用主题配置
/// 基于 TDesign 设计规范的主题配置
library;

import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

/// TDesign 主题配置
class AppTheme {
  AppTheme._();

  /// 获取 TDesign 主题数据
  static TDThemeData get tdTheme => TDThemeData.defaultData();

  /// 亮色主题
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: TDTheme.of(null).brandColor7,
      scaffoldBackgroundColor: TDTheme.of(null).whiteColor1,
      appBarTheme: AppBarTheme(
        backgroundColor: TDTheme.of(null).whiteColor1,
        foregroundColor: TDTheme.of(null).fontGyColor1,
        elevation: 0,
        centerTitle: true,
      ),
      colorScheme: ColorScheme.light(
        primary: TDTheme.of(null).brandColor7,
        secondary: TDTheme.of(null).brandColor7,
        surface: TDTheme.of(null).whiteColor1,
        error: TDTheme.of(null).errorColor6,
      ),
    );
  }

  /// 暗色主题
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: TDTheme.of(null).brandColor7,
      scaffoldBackgroundColor: TDTheme.of(null).grayColor14,
      appBarTheme: AppBarTheme(
        backgroundColor: TDTheme.of(null).grayColor14,
        foregroundColor: TDTheme.of(null).whiteColor1,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
