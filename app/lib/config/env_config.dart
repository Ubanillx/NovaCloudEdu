import 'dart:io';

/// 应用环境配置
enum Environment { dev, prod }

class EnvConfig {
  static Environment _current = Environment.dev;

  /// 当前环境
  static Environment get current => _current;

  /// 设置当前环境
  static void setEnvironment(Environment env) {
    _current = env;
  }

  /// 是否为开发环境
  static bool get isDev => _current == Environment.dev;

  /// 是否为生产环境
  static bool get isProd => _current == Environment.prod;

  /// API 基础地址
  static String get apiBaseUrl {
    switch (_current) {
      case Environment.dev:
        // Android 模拟器使用 10.0.2.2 访问宿主机，iOS 模拟器和其他平台使用 localhost
        final host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
        return 'http://$host:8080';
      case Environment.prod:
        return 'https://api.novacloudedu.com'; // TODO: 替换为生产环境地址
    }
  }

  /// OpenAPI 文档地址
  static String get openApiDocsUrl => '$apiBaseUrl/v3/api-docs';

  /// RTC 信令 WebSocket 地址
  static String get rtcWsUrl {
    switch (_current) {
      case Environment.dev:
        final host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
        return 'ws://$host:8300';
      case Environment.prod:
        return 'wss://rtc.novacloudedu.com'; // TODO: 替换为生产环境地址
    }
  }
}
