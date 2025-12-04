import 'package:dio/dio.dart';
import 'package:nova_api/nova_api.dart';
import '../config/env_config.dart';

/// API 客户端单例
class ApiClient {
  static ApiClient? _instance;
  late final Dio dio;
  late final NovaApi api;

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.apiBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // 添加拦截器
    dio.interceptors.add(
      LogInterceptor(
        requestBody: EnvConfig.isDev,
        responseBody: EnvConfig.isDev,
      ),
    );

    // 初始化生成的 API 客户端
    api = NovaApi(dio: dio, basePathOverride: EnvConfig.apiBaseUrl);
  }

  static ApiClient get instance {
    _instance ??= ApiClient._internal();
    return _instance!;
  }

  /// 重新初始化（环境切换时调用）
  static void reinitialize() {
    _instance = ApiClient._internal();
  }

  /// 设置 JWT Token
  void setAuthToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
    api.setBearerAuth('Bearer Token', token);
  }

  /// 清除 JWT Token
  void clearAuthToken() {
    dio.options.headers.remove('Authorization');
  }

  /// 获取默认 API
  DefaultApi get defaultApi => api.getDefaultApi();
}
