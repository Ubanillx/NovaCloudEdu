import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';
import 'package:nova_api/nova_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../core/network/api_client.dart';

/// AI 阅读服务 - 封装章节总结、知识点、问答、测验相关 API
class BookAiService {
  final _api = ApiClient.instance;
  final _storage = const FlutterSecureStorage();

  // AI 生成类接口的超时时间：2 分钟
  static const _aiGenTimeout = Duration(minutes: 2);
  
  // 缓存键前缀
  static const String _cachePrefix = 'book_ai_';
  
  // 重试次数
  static const int _maxRetries = 3;
  
  // 并发请求控制器
  final Map<String, CancelToken> _activeRequests = {};

  // ==================== 章节总结 ====================

  /// 获取章节总结（已有则返回，否则返回 null）
  Future<ChapterSummary?> getSummary(int bookId, int chapterId, {String type = 'DETAILED', bool forceRefresh = false}) async {
    final cacheKey = '${_cachePrefix}summary_${bookId}_${chapterId}_$type';
    
    // 检查缓存
    if (!forceRefresh) {
      final cached = await _storage.read(key: cacheKey);
      if (cached != null) {
        try {
          // 反序列化 JSON 字符串
          final jsonData = jsonDecode(cached);
          final data = _deserialize<BaseResponseChapterSummary>(jsonData, const FullType(BaseResponseChapterSummary));
          return data?.data;
        } catch (e) {
          // 缓存解析失败，删除缓存
          await _storage.delete(key: cacheKey);
        }
      }
    }
    
    try {
      final response = await _api.aiApi.getSummary(
        bookId: bookId,
        chapterId: chapterId,
        summaryType: type,
      );
      if (response.data?.code == 0 && response.data?.data != null) {
        // 缓存结果（序列化为 JSON 字符串）
        await _storage.write(key: cacheKey, value: jsonEncode(response.data));
        return response.data!.data!;
      }
      return null;
    } catch (e) {
      _logError('获取总结失败', e);
      return null;
    }
  }

  /// 生成章节总结（使用 2 分钟超时）
  Future<ChapterSummary> generateSummary(int bookId, int chapterId, {String type = 'DETAILED'}) async {
    final requestKey = 'generate_summary_${bookId}_${chapterId}_$type';
    
    // 取消之前的相同请求
    _activeRequests[requestKey]?.cancel('重复请求被取消');
    final cancelToken = CancelToken();
    _activeRequests[requestKey] = cancelToken;
    
    try {
      final response = await _executeWithRetry(() => _api.dio.post(
        '/api/books/$bookId/ai/chapters/$chapterId/summary',
        queryParameters: {'summaryType': type},
        options: Options(
          extra: {
            'secure': <Map<String, String>>[
              {'type': 'http', 'scheme': 'bearer', 'name': 'Bearer Token'},
            ],
          },
          receiveTimeout: _aiGenTimeout,
        ),
      ), cancelToken: cancelToken);
      
      final baseResponse = _deserialize<BaseResponseChapterSummary>(
        response.data,
        const FullType(BaseResponseChapterSummary),
      );
      if (baseResponse?.code == 0 && baseResponse?.data != null) {
        // 缓存生成的结果（序列化为 JSON 字符串）
        final cacheKey = '${_cachePrefix}summary_${bookId}_${chapterId}_$type';
        await _storage.write(key: cacheKey, value: jsonEncode(baseResponse));
        return baseResponse!.data!;
      }
      throw Exception(baseResponse?.message ?? '生成总结失败');
    } catch (e) {
      _logError('生成总结失败', e);
      rethrow;
    } finally {
      _activeRequests.remove(requestKey);
    }
  }

  /// 获取或生成总结（先尝试获取，没有则生成）
  Future<ChapterSummary> getOrGenerateSummary(int bookId, int chapterId, {String type = 'DETAILED'}) async {
    final existing = await getSummary(bookId, chapterId, type: type);
    if (existing != null) return existing;
    return generateSummary(bookId, chapterId, type: type);
  }

  // ==================== 知识点 ====================

  /// 获取章节知识点（已有则返回）
  Future<BuiltList<KnowledgePoint>?> getKnowledgePoints(int bookId, int chapterId, {bool forceRefresh = false}) async {
    final cacheKey = '${_cachePrefix}kp_$bookId$chapterId';
    
    // 检查缓存
    if (!forceRefresh) {
      final cached = await _storage.read(key: cacheKey);
      if (cached != null) {
        try {
          // 反序列化 JSON 字符串
          final jsonData = jsonDecode(cached);
          final data = _deserialize<BaseResponseListKnowledgePoint>(jsonData, const FullType(BaseResponseListKnowledgePoint));
          return data?.data;
        } catch (e) {
          // 缓存解析失败，删除缓存
          await _storage.delete(key: cacheKey);
        }
      }
    }
    
    try {
      final response = await _api.aiApi.getKnowledgePoints(
        bookId: bookId,
        chapterId: chapterId,
      );
      if (response.data?.code == 0 && response.data?.data != null && response.data!.data!.isNotEmpty) {
        // 缓存结果（序列化为 JSON 字符串）
        await _storage.write(key: cacheKey, value: jsonEncode(response.data));
        return response.data!.data!;
      }
      return null;
    } catch (e) {
      _logError('获取知识点失败', e);
      return null;
    }
  }

  /// 提取章节知识点（使用 2 分钟超时）
  Future<BuiltList<KnowledgePoint>> extractKnowledgePoints(int bookId, int chapterId) async {
    final requestKey = 'extract_kp_$bookId$chapterId';
    
    // 取消之前的相同请求
    _activeRequests[requestKey]?.cancel('重复请求被取消');
    final cancelToken = CancelToken();
    _activeRequests[requestKey] = cancelToken;
    
    try {
      final response = await _executeWithRetry(() => _api.dio.post(
        '/api/books/$bookId/ai/chapters/$chapterId/knowledge-points',
        options: Options(
          extra: {
            'secure': <Map<String, String>>[
              {'type': 'http', 'scheme': 'bearer', 'name': 'Bearer Token'},
            ],
          },
          receiveTimeout: _aiGenTimeout,
        ),
      ), cancelToken: cancelToken);
      
      final baseResponse = _deserialize<BaseResponseListKnowledgePoint>(
        response.data,
        const FullType(BaseResponseListKnowledgePoint),
      );
      if (baseResponse?.code == 0 && baseResponse?.data != null) {
        // 缓存提取的结果（序列化为 JSON 字符串）
        final cacheKey = '${_cachePrefix}kp_$bookId$chapterId';
        await _storage.write(key: cacheKey, value: jsonEncode(baseResponse));
        return baseResponse!.data!;
      }
      throw Exception(baseResponse?.message ?? '提取知识点失败');
    } catch (e) {
      _logError('提取知识点失败', e);
      rethrow;
    } finally {
      _activeRequests.remove(requestKey);
    }
  }

  /// 获取或提取知识点
  Future<BuiltList<KnowledgePoint>> getOrExtractKnowledgePoints(int bookId, int chapterId) async {
    final existing = await getKnowledgePoints(bookId, chapterId);
    if (existing != null) return existing;
    return extractKnowledgePoints(bookId, chapterId);
  }

  // ==================== 智能问答 ====================

  /// 提问（新对话）
  Future<Map<String, dynamic>> askQuestion({
    required int bookId,
    required int userId,
    required String question,
    int? chapterId,
  }) async {
    try {
      final map = <String, JsonObject>{
        'userId': JsonObject(userId),
        'question': JsonObject(question),
      };
      if (chapterId != null) map['chapterId'] = JsonObject(chapterId);
      final requestBody = BuiltMap<String, JsonObject>(map);
      final response = await _api.aiApi.askQuestion(
        bookId: bookId,
        requestBody: requestBody,
      );
      if (response.data?.code == 0 && response.data?.data != null) {
        final data = response.data!.data!;
        final result = <String, dynamic>{};
        for (final entry in data.entries) {
          result[entry.key] = entry.value.value;
        }
        return result;
      }
      throw Exception(response.data?.message ?? '问答失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 继续对话
  Future<Map<String, dynamic>> continueConversation({
    required int bookId,
    required int conversationId,
    required String question,
  }) async {
    try {
      final requestBody = BuiltMap<String, String>({'question': question});
      final response = await _api.aiApi.continueConversation(
        bookId: bookId,
        conversationId: conversationId,
        requestBody: requestBody,
      );
      if (response.data?.code == 0 && response.data?.data != null) {
        final data = response.data!.data!;
        final result = <String, dynamic>{};
        for (final entry in data.entries) {
          result[entry.key] = entry.value.value;
        }
        return result;
      }
      throw Exception(response.data?.message ?? '对话失败');
    } catch (e) {
      rethrow;
    }
  }

  // ==================== 阅读测试 ====================

  /// 生成阅读测试（使用 2 分钟超时）
  Future<ReadingQuiz> generateQuiz(int bookId, int chapterId, {int questionCount = 5}) async {
    final requestKey = 'generate_quiz_${bookId}_${chapterId}_$questionCount';
    
    // 取消之前的相同请求
    _activeRequests[requestKey]?.cancel('重复请求被取消');
    final cancelToken = CancelToken();
    _activeRequests[requestKey] = cancelToken;
    
    try {
      final response = await _executeWithRetry(() => _api.dio.post(
        '/api/books/$bookId/ai/chapters/$chapterId/quiz',
        queryParameters: {'questionCount': questionCount},
        options: Options(
          extra: {
            'secure': <Map<String, String>>[
              {'type': 'http', 'scheme': 'bearer', 'name': 'Bearer Token'},
            ],
          },
          receiveTimeout: _aiGenTimeout,
        ),
      ), cancelToken: cancelToken);
      
      final baseResponse = _deserialize<BaseResponseReadingQuiz>(
        response.data,
        const FullType(BaseResponseReadingQuiz),
      );
      if (baseResponse?.code == 0 && baseResponse?.data != null) {
        return baseResponse!.data!;
      }
      throw Exception(baseResponse?.message ?? '生成测试失败');
    } catch (e) {
      _logError('生成测试失败', e);
      rethrow;
    } finally {
      _activeRequests.remove(requestKey);
    }
  }

  /// 提交答案
  Future<int> submitAnswers(int bookId, int quizId, List<String> answers) async {
    try {
      final response = await _executeWithRetry(() => _api.dio.post(
        '/api/books/$bookId/ai/quizzes/$quizId/submit',
        data: {'answers': answers},
        options: Options(
          extra: {
            'secure': <Map<String, String>>[
              {'type': 'http', 'scheme': 'bearer', 'name': 'Bearer Token'},
            ],
          },
        ),
      ));
      
      final baseResponse = _deserialize<BaseResponseMapStringObject>(
        response.data,
        const FullType(BaseResponseMapStringObject),
      );
      if (baseResponse?.code == 0 && baseResponse?.data != null) {
        final data = baseResponse!.data!;
        final scoreObj = data['score'];
        if (scoreObj != null) {
          final val = scoreObj.value;
          if (val is num) return val.toInt();
        }
        return 0;
      }
      throw Exception(baseResponse?.message ?? '提交答案失败');
    } catch (e) {
      _logError('提交答案失败', e);
      rethrow;
    }
  }

  /// 辅助方法：反序列化响应
  T? _deserialize<T>(dynamic data, FullType specifiedType) {
    if (data == null) return null;
    try {
      final serializers = ApiClient.instance.api.serializers;
      return serializers.deserialize(data, specifiedType: specifiedType) as T;
    } catch (_) {
      return null;
    }
  }
  
  /// 执行带重试的请求
  Future<Response> _executeWithRetry(Future<Response> Function() requestFunction, {CancelToken? cancelToken}) async {
    for (int attempt = 0; attempt < _maxRetries; attempt++) {
      try {
        return await requestFunction();
      } catch (e) {
        if (cancelToken?.isCancelled == true) {
          rethrow;
        }
        
        // 最后一次尝试失败，抛出异常
        if (attempt == _maxRetries - 1) {
          rethrow;
        }
        
        // 判断是否为可重试的错误
        if (!_isRetryableError(e)) {
          rethrow;
        }
        
        // 等待一段时间后重试
        await Future.delayed(Duration(seconds: (attempt + 1) * 2));
      }
    }
    
    throw Exception('请求失败，已达到最大重试次数');
  }
  
  /// 判断错误是否可重试
  bool _isRetryableError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionError:
          return true;
        case DioExceptionType.badResponse:
          // 5xx 服务器错误可以重试
          final statusCode = error.response?.statusCode;
          return statusCode != null && statusCode >= 500;
        default:
          return false;
      }
    }
    return false;
  }
  
  /// 记录错误日志
  void _logError(String message, dynamic error) {
    if (error is DioException) {
      debugPrint('$message: ${error.message} - ${error.type}');
      if (error.response != null) {
        debugPrint('Response status: ${error.response?.statusCode}');
        debugPrint('Response data: ${error.response?.data}');
      }
    } else {
      debugPrint('$message: $error');
    }
  }
  
  /// 清除指定书籍的所有缓存
  Future<void> clearBookCache(int bookId) async {
    // 由于 FlutterSecureStorage 没有 getAllKeys 方法，我们使用已知的键模式
    final types = ['DETAILED', 'BRIEF', 'KEYPOINTS'];
    for (final type in types) {
      await _storage.delete(key: '${_cachePrefix}summary_${bookId}_1_$type');
      await _storage.delete(key: '${_cachePrefix}kp_${bookId}_1');
    }
  }
  
  /// 清除所有 AI 服务缓存
  Future<void> clearAllCache() async {
    // 由于 FlutterSecureStorage 没有 getAllKeys 方法，这里提供一个基本的清理方法
    // 在实际应用中，可能需要维护一个缓存键的列表
    try {
      await _storage.deleteAll();
    } catch (e) {
      // 如果 deleteAll 不支持，可以忽略错误或使用其他方法
      debugPrint('清除缓存时出错: $e');
    }
  }
  
  /// 取消所有进行中的请求
  void cancelAllRequests() {
    for (final cancelToken in _activeRequests.values) {
      cancelToken.cancel('应用关闭，取消请求');
    }
    _activeRequests.clear();
  }
}
