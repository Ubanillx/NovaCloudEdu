/// 应用常量定义
/// 存放 API 地址、Key、默认值等常量
library;

class AppConstants {
  AppConstants._();

  /// 应用名称
  static const String appName = 'NovaCloudEdu';

  /// API 基础地址
  static const String baseUrl = 'https://api.example.com';

  /// 连接超时时间（毫秒）
  static const int connectTimeout = 30000;

  /// 接收超时时间（毫秒）
  static const int receiveTimeout = 30000;
}
