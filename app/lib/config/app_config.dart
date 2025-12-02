/// 应用配置
/// 环境配置、初始化配置等
library;

enum Environment { dev, staging, prod }

class AppConfig {
  static Environment environment = Environment.dev;

  static bool get isDev => environment == Environment.dev;
  static bool get isStaging => environment == Environment.staging;
  static bool get isProd => environment == Environment.prod;
}
