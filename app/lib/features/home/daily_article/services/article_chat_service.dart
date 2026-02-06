import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import '../../../../config/env_config.dart';
import '../../../../core/network/api_client.dart';

/// 文章AI聊天消息
class ArticleChatMessage {
  final String role; // 'user' 或 'assistant'
  final String content;
  final DateTime timestamp;
  final bool isStreaming;

  ArticleChatMessage({
    required this.role,
    required this.content,
    DateTime? timestamp,
    this.isStreaming = false,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, String> toHistoryMap() {
    return {
      'role': role,
      'content': content,
    };
  }

  ArticleChatMessage copyWith({
    String? role,
    String? content,
    DateTime? timestamp,
    bool? isStreaming,
  }) {
    return ArticleChatMessage(
      role: role ?? this.role,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isStreaming: isStreaming ?? this.isStreaming,
    );
  }
}

/// 文章AI聊天服务 - 使用SSE流式对话
class ArticleChatService {
  StreamSubscription<SSEModel>? _sseSubscription;
  bool _isStreaming = false;

  /// 是否正在流式传输
  bool get isStreaming => _isStreaming;

  /// 发送消息并获取SSE流式响应
  /// 
  /// [articleId] - 文章ID
  /// [message] - 用户消息
  /// [history] - 对话历史
  /// [onData] - 接收流式数据的回调
  /// [onDone] - 完成回调
  /// [onError] - 错误回调
  Future<void> sendMessageStream({
    required int articleId,
    required String message,
    List<ArticleChatMessage>? history,
    required Function(String) onData,
    required VoidCallback onDone,
    required Function(dynamic) onError,
  }) async {
    if (_isStreaming) {
      onError('正在等待上一条消息的回复');
      return;
    }

    _isStreaming = true;

    try {
      // 获取认证token
      final token = ApiClient.instance.dio.options.headers['Authorization'];
      
      // 构建历史记录JSON
      String? historyJson;
      if (history != null && history.isNotEmpty) {
        final historyList = history.map((m) => m.toHistoryMap()).toList();
        historyJson = jsonEncode(historyList);
      }

      // 构建SSE URL (使用GET方式)
      final uri = Uri.parse('${EnvConfig.apiBaseUrl}/api/articles/$articleId/chat/stream').replace(
        queryParameters: {
          'message': message,
          if (historyJson != null) 'historyJson': historyJson,
        },
      );

      debugPrint('SSE URL: $uri');

      // 使用SSE客户端连接
      _sseSubscription = SSEClient.subscribeToSSE(
        method: SSERequestType.GET,
        url: uri.toString(),
        header: {
          'Authorization': token ?? '',
          'Accept': 'text/event-stream',
          'Cache-Control': 'no-cache',
        },
      ).listen(
        (event) {
          debugPrint('SSE Event: ${event.event}, Data: ${event.data}');
          
          // 检查是否是结束事件 (event类型为done或数据为[DONE])
          if (event.event == 'done' || event.data == '[DONE]') {
            _isStreaming = false;
            onDone();
            return;
          }
          
          if (event.data != null && event.data!.isNotEmpty) {
            // 处理SSE数据
            final data = event.data!;

            // 尝试解析JSON格式的数据
            try {
              final jsonData = jsonDecode(data);
              if (jsonData is Map) {
                // 如果是JSON对象，提取content字段
                final content = jsonData['content'] ?? jsonData['text'] ?? data;
                onData(content.toString());
              } else {
                onData(data);
              }
            } catch (e) {
              // 如果不是JSON，直接使用原始数据
              onData(data);
            }
          }
        },
        onError: (error) {
          debugPrint('SSE Error: $error');
          _isStreaming = false;
          onError(error);
        },
        onDone: () {
          debugPrint('SSE Done');
          _isStreaming = false;
          onDone();
        },
      );
    } catch (e) {
      debugPrint('SSE Connection Error: $e');
      _isStreaming = false;
      onError(e);
    }
  }

  /// 取消当前的SSE连接
  void cancelStream() {
    _sseSubscription?.cancel();
    _sseSubscription = null;
    _isStreaming = false;
  }

  /// 释放资源
  void dispose() {
    cancelStream();
  }
}
