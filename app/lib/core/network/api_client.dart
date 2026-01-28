import 'package:dio/dio.dart';
import 'package:nova_api/nova_api.dart';
import '../../config/env_config.dart';

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

    if (EnvConfig.isDev) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }

    api = NovaApi(dio: dio, basePathOverride: EnvConfig.apiBaseUrl);
  }

  static ApiClient get instance {
    _instance ??= ApiClient._internal();
    return _instance!;
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

  /// 获取 AI API
  AIApi get aiApi => api.getAIApi();

  /// 获取 Webhook API
  WebhookApi get webhookApi => api.getWebhookApi();
}
