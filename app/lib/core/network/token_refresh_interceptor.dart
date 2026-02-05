import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../config/env_config.dart';

/// Token 刷新拦截器
/// 当收到401错误时，自动使用refresh token刷新access token
class TokenRefreshInterceptor extends Interceptor {
  final Dio dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  
  // 是否正在刷新Token
  bool _isRefreshing = false;
  // 等待刷新完成的请求队列
  final List<_RequestRetryInfo> _pendingRequests = [];
  
  // 登出回调
  final Future<void> Function()? onLogout;
  
  TokenRefreshInterceptor({
    required this.dio,
    this.onLogout,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 只处理401未授权错误
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }
    
    // 如果是刷新Token的请求本身失败，不再重试
    if (err.requestOptions.path.contains('/api/auth/refresh')) {
      await _handleRefreshFailed();
      return handler.next(err);
    }
    
    // 如果正在刷新，将请求加入队列等待
    if (_isRefreshing) {
      final completer = Completer<Response>();
      _pendingRequests.add(_RequestRetryInfo(
        requestOptions: err.requestOptions,
        completer: completer,
      ));
      
      try {
        final response = await completer.future;
        return handler.resolve(response);
      } catch (e) {
        return handler.next(err);
      }
    }
    
    // 开始刷新Token
    _isRefreshing = true;
    
    try {
      final refreshToken = await _storage.read(key: _refreshTokenKey);
      
      if (refreshToken == null || refreshToken.isEmpty) {
        await _handleRefreshFailed();
        return handler.next(err);
      }
      
      // 调用刷新Token接口
      final refreshDio = Dio(BaseOptions(
        baseUrl: EnvConfig.apiBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ));
      
      final response = await refreshDio.post(
        '/api/auth/refresh',
        data: {'refreshToken': refreshToken},
      );
      
      if (response.statusCode == 200 && response.data['code'] == 0) {
        final data = response.data['data'];
        final newToken = data['token'] as String?;
        final newRefreshToken = data['refreshToken'] as String?;
        
        if (newToken != null && newRefreshToken != null) {
          // 保存新的Token
          await _saveTokens(newToken, newRefreshToken);
          
          // 更新Dio的Authorization头
          dio.options.headers['Authorization'] = 'Bearer $newToken';
          
          // 重试原始请求
          final retryResponse = await _retryRequest(err.requestOptions, newToken);
          
          // 处理等待队列中的请求
          _processPendingRequests(newToken);
          
          _isRefreshing = false;
          return handler.resolve(retryResponse);
        }
      }
      
      // 刷新失败
      await _handleRefreshFailed();
      _isRefreshing = false;
      return handler.next(err);
      
    } catch (e) {
      await _handleRefreshFailed();
      _isRefreshing = false;
      return handler.next(err);
    }
  }
  
  /// 保存Token到安全存储
  Future<void> _saveTokens(String token, String refreshToken) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }
  
  /// 重试请求
  Future<Response> _retryRequest(RequestOptions requestOptions, String newToken) async {
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $newToken',
      },
    );
    
    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
  
  /// 处理等待队列中的请求
  void _processPendingRequests(String newToken) {
    for (final info in _pendingRequests) {
      _retryRequest(info.requestOptions, newToken)
          .then((response) => info.completer.complete(response))
          .catchError((e) => info.completer.completeError(e));
    }
    _pendingRequests.clear();
  }
  
  /// 处理刷新失败
  Future<void> _handleRefreshFailed() async {
    // 清除所有Token
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _refreshTokenKey);
    dio.options.headers.remove('Authorization');
    
    // 拒绝所有等待的请求
    for (final info in _pendingRequests) {
      info.completer.completeError(DioException(
        requestOptions: info.requestOptions,
        error: 'Token refresh failed',
      ));
    }
    _pendingRequests.clear();
    
    // 调用登出回调
    if (onLogout != null) {
      await onLogout!();
    }
  }
}

/// 等待重试的请求信息
class _RequestRetryInfo {
  final RequestOptions requestOptions;
  final Completer<Response> completer;
  
  _RequestRetryInfo({
    required this.requestOptions,
    required this.completer,
  });
}
