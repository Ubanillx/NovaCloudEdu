import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import '../../../config/env_config.dart';
import '../../../core/network/api_client.dart';

/// AI聊天消息
class AiChatMessage {
  final int? id;
  final String role; // 'user' 或 'assistant'
  final String content;
  final DateTime timestamp;
  final bool isStreaming;
  final List<String>? attachments;

  AiChatMessage({
    this.id,
    required this.role,
    required this.content,
    DateTime? timestamp,
    this.isStreaming = false,
    this.attachments,
  }) : timestamp = timestamp ?? DateTime.now();

  AiChatMessage copyWith({
    int? id,
    String? role,
    String? content,
    DateTime? timestamp,
    bool? isStreaming,
    List<String>? attachments,
  }) {
    return AiChatMessage(
      id: id ?? this.id,
      role: role ?? this.role,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isStreaming: isStreaming ?? this.isStreaming,
      attachments: attachments ?? this.attachments,
    );
  }
}

/// AI聊天会话
class AiChatSession {
  final int sessionId;
  final int? assistantId;
  final String? title;
  final int messageCount;
  final DateTime? createTime;
  final DateTime? updateTime;
  final String? assistantName;
  final String? assistantAvatar;

  AiChatSession({
    required this.sessionId,
    this.assistantId,
    this.title,
    this.messageCount = 0,
    this.createTime,
    this.updateTime,
    this.assistantName,
    this.assistantAvatar,
  });

  factory AiChatSession.fromJson(Map<String, dynamic> json) {
    return AiChatSession(
      sessionId: json['sessionId'] as int,
      assistantId: json['assistantId'] as int?,
      title: json['title'] as String?,
      messageCount: (json['messageCount'] as num?)?.toInt() ?? 0,
      createTime: json['createTime'] != null
          ? DateTime.tryParse(json['createTime'].toString())
          : null,
      updateTime: json['updateTime'] != null
          ? DateTime.tryParse(json['updateTime'].toString())
          : null,
      assistantName: json['assistantName'] as String?,
      assistantAvatar: json['assistantAvatar'] as String?,
    );
  }
}

/// 文生图任务状态
class ImageGeneration {
  final int index;
  final String prompt;
  String status; // 'generating' | 'done' | 'error'
  String? url;
  String? error;

  ImageGeneration({
    required this.index,
    required this.prompt,
    this.status = 'generating',
    this.url,
    this.error,
  });
}

/// 文生视频任务状态
class VideoGeneration {
  final int index;
  final String prompt;
  String status; // 'generating' | 'done' | 'error'
  String? url;
  String? error;

  VideoGeneration({
    required this.index,
    required this.prompt,
    this.status = 'generating',
    this.url,
    this.error,
  });
}

/// AI聊天服务 - 会话管理 + SSE流式对话
class AiChatApiService {
  final _dio = ApiClient.instance.dio;
  StreamSubscription<SSEModel>? _sseSubscription;
  bool _isStreaming = false;

  bool get isStreaming => _isStreaming;

  // ==================== 会话管理 ====================

  /// 创建新会话
  Future<int?> createSession() async {
    try {
      final response = await _dio.post('/api/ai/chat/sessions');
      final data = response.data;
      if (data['code'] == 0 && data['data'] != null) {
        return data['data']['sessionId'] as int;
      }
    } catch (e) {
      debugPrint('创建会话失败: $e');
    }
    return null;
  }

  /// 获取会话列表
  Future<List<AiChatSession>> listSessions({int page = 0, int size = 20}) async {
    try {
      final response = await _dio.get(
        '/api/ai/chat/sessions',
        queryParameters: {'page': page, 'size': size},
      );
      final data = response.data;
      if (data['code'] == 0 && data['data'] != null) {
        return (data['data'] as List)
            .map((e) => AiChatSession.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('获取会话列表失败: $e');
    }
    return [];
  }

  /// 获取会话详情（含消息列表）
  Future<Map<String, dynamic>?> getSessionDetail(int sessionId) async {
    try {
      final response = await _dio.get('/api/ai/chat/sessions/$sessionId');
      final data = response.data;
      if (data['code'] == 0 && data['data'] != null) {
        final detail = data['data'];
        final messages = (detail['messages'] as List?)
                ?.map((m) => AiChatMessage(
                      id: m['id'] as int?,
                      role: m['role'] as String,
                      content: m['content'] as String,
                      timestamp: m['createTime'] != null
                          ? DateTime.tryParse(m['createTime'].toString())
                          : null,
                      attachments: (m['attachments'] as List?)
                          ?.map((a) => a.toString())
                          .toList(),
                    ))
                .toList() ??
            [];
        return {
          'session': AiChatSession.fromJson(detail['session']),
          'messages': messages,
        };
      }
    } catch (e) {
      debugPrint('获取会话详情失败: $e');
    }
    return null;
  }

  /// 删除会话
  Future<bool> deleteSession(int sessionId) async {
    try {
      final response = await _dio.delete('/api/ai/chat/sessions/$sessionId');
      return response.data['code'] == 0;
    } catch (e) {
      debugPrint('删除会话失败: $e');
    }
    return false;
  }

  // ==================== SSE 流式对话 ====================

  /// 会话级流式对话
  Future<void> sessionStreamChat({
    required int sessionId,
    required String message,
    String? systemPrompt,
    List<String>? imageUrls,
    List<String>? documentUrls,
    String? modelId,
    required Function(String) onData,
    required VoidCallback onDone,
    required Function(dynamic) onError,
    Function(ImageGeneration)? onImageGenerating,
    Function(ImageGeneration)? onImageGenerated,
    Function(ImageGeneration)? onImageError,
    Function(VideoGeneration)? onVideoGenerating,
    Function(VideoGeneration)? onVideoGenerated,
    Function(VideoGeneration)? onVideoError,
  }) async {
    if (_isStreaming) {
      onError('正在等待上一条消息的回复');
      return;
    }

    _isStreaming = true;

    try {
      final token = _dio.options.headers['Authorization'];

      final body = <String, dynamic>{
        'message': message,
        if (systemPrompt != null) 'systemPrompt': systemPrompt,
        if (imageUrls != null && imageUrls.isNotEmpty) 'imageUrls': imageUrls,
        if (documentUrls != null && documentUrls.isNotEmpty) 'documentUrls': documentUrls,
        if (modelId != null) 'modelId': modelId,
      };

      final url = '${EnvConfig.apiBaseUrl}/api/ai/chat/sessions/$sessionId/stream';
      debugPrint('SSE POST URL: $url');

      _sseSubscription = SSEClient.subscribeToSSE(
        method: SSERequestType.POST,
        url: url,
        header: {
          'Authorization': token ?? '',
          'Accept': 'text/event-stream',
          'Content-Type': 'application/json',
          'Cache-Control': 'no-cache',
        },
        body: body,
      ).listen(
        (event) {
          if (event.event == 'done' || event.data == '[DONE]') {
            _isStreaming = false;
            onDone();
            return;
          }

          if (event.event == 'error') {
            _isStreaming = false;
            onError(event.data ?? '对话失败');
            return;
          }

          // 文生图事件
          if (event.event == 'image_generating' && event.data != null) {
            try {
              final payload = jsonDecode(event.data!) as Map<String, dynamic>;
              onImageGenerating?.call(ImageGeneration(
                index: payload['index'] as int,
                prompt: payload['prompt'] as String,
              ));
            } catch (e) {
              debugPrint('解析 image_generating 事件失败: $e');
            }
            return;
          }

          if (event.event == 'image_generated' && event.data != null) {
            try {
              final payload = jsonDecode(event.data!) as Map<String, dynamic>;
              onImageGenerated?.call(ImageGeneration(
                index: payload['index'] as int,
                prompt: payload['prompt'] as String,
                status: 'done',
                url: payload['url'] as String?,
              ));
            } catch (e) {
              debugPrint('解析 image_generated 事件失败: $e');
            }
            return;
          }

          if (event.event == 'image_error' && event.data != null) {
            try {
              final payload = jsonDecode(event.data!) as Map<String, dynamic>;
              onImageError?.call(ImageGeneration(
                index: payload['index'] as int,
                prompt: payload['prompt'] as String,
                status: 'error',
                error: payload['error'] as String?,
              ));
            } catch (e) {
              debugPrint('解析 image_error 事件失败: $e');
            }
            return;
          }

          // 文生视频事件
          if (event.event == 'video_generating' && event.data != null) {
            try {
              final payload = jsonDecode(event.data!) as Map<String, dynamic>;
              onVideoGenerating?.call(VideoGeneration(
                index: payload['index'] as int,
                prompt: payload['prompt'] as String,
              ));
            } catch (e) {
              debugPrint('解析 video_generating 事件失败: $e');
            }
            return;
          }

          if (event.event == 'video_generated' && event.data != null) {
            try {
              final payload = jsonDecode(event.data!) as Map<String, dynamic>;
              onVideoGenerated?.call(VideoGeneration(
                index: payload['index'] as int,
                prompt: payload['prompt'] as String,
                status: 'done',
                url: payload['url'] as String?,
              ));
            } catch (e) {
              debugPrint('解析 video_generated 事件失败: $e');
            }
            return;
          }

          if (event.event == 'video_error' && event.data != null) {
            try {
              final payload = jsonDecode(event.data!) as Map<String, dynamic>;
              onVideoError?.call(VideoGeneration(
                index: payload['index'] as int,
                prompt: payload['prompt'] as String,
                status: 'error',
                error: payload['error'] as String?,
              ));
            } catch (e) {
              debugPrint('解析 video_error 事件失败: $e');
            }
            return;
          }

          if (event.data != null && event.data!.isNotEmpty) {
            final data = event.data!;
            try {
              final jsonData = jsonDecode(data);
              if (jsonData is Map) {
                final content = jsonData['content'] ?? jsonData['text'] ?? data;
                onData(content.toString());
              } else {
                // 非 Map JSON（如纯字符串），去掉 SSE 协议可能附带的尾部换行
                final cleaned = jsonData.toString().replaceAll(RegExp(r'\n$'), '');
                if (cleaned.isNotEmpty) onData(cleaned);
              }
            } catch (e) {
              // 纯文本 token，去掉 SSE 协议附带的尾部换行
              final cleaned = data.replaceAll(RegExp(r'\n$'), '');
              if (cleaned.isNotEmpty) onData(cleaned);
            }
          }
        },
        onError: (error) {
          debugPrint('SSE Error: $error');
          _isStreaming = false;
          onError(error);
        },
        onDone: () {
          debugPrint('SSE Connection Done');
          if (_isStreaming) {
            _isStreaming = false;
            onDone();
          }
        },
      );
    } catch (e) {
      debugPrint('SSE Connection Error: $e');
      _isStreaming = false;
      onError(e);
    }
  }

  /// 获取可用模型列表
  Future<List<Map<String, dynamic>>> listModels() async {
    try {
      final response = await _dio.get('/api/ai/chat/models');
      final data = response.data;
      if (data['code'] == 0 && data['data'] != null) {
        return (data['data'] as List)
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
      }
    } catch (e) {
      debugPrint('获取模型列表失败: $e');
    }
    return [];
  }

  /// 智慧体流式对话
  Future<void> assistantStreamChat({
    required int assistantId,
    required String message,
    int? sessionId,
    List<String>? imageUrls,
    List<String>? documentUrls,
    required Function(String) onData,
    required VoidCallback onDone,
    required Function(dynamic) onError,
    Function(int sessionId)? onSessionCreated,
    Function(ImageGeneration)? onImageGenerating,
    Function(ImageGeneration)? onImageGenerated,
    Function(ImageGeneration)? onImageError,
    Function(VideoGeneration)? onVideoGenerating,
    Function(VideoGeneration)? onVideoGenerated,
    Function(VideoGeneration)? onVideoError,
  }) async {
    if (_isStreaming) {
      onError('正在等待上一条消息的回复');
      return;
    }

    _isStreaming = true;

    try {
      final token = _dio.options.headers['Authorization'];

      final body = <String, dynamic>{
        'message': message,
        if (sessionId != null) 'sessionId': sessionId,
        if (imageUrls != null && imageUrls.isNotEmpty) 'imageUrls': imageUrls,
        if (documentUrls != null && documentUrls.isNotEmpty) 'documentUrls': documentUrls,
      };

      final url = '${EnvConfig.apiBaseUrl}/api/ai/assistants/$assistantId/chat/stream';
      debugPrint('智慧体SSE POST URL: $url');

      _sseSubscription = SSEClient.subscribeToSSE(
        method: SSERequestType.POST,
        url: url,
        header: {
          'Authorization': token ?? '',
          'Accept': 'text/event-stream',
          'Content-Type': 'application/json',
          'Cache-Control': 'no-cache',
        },
        body: body,
      ).listen(
        (event) {
          if (event.event == 'done' || event.data == '[DONE]') {
            _isStreaming = false;
            onDone();
            return;
          }

          if (event.event == 'error') {
            _isStreaming = false;
            onError(event.data ?? '对话失败');
            return;
          }

          // 后端自动创建会话后返回sessionId
          if (event.event == 'session' && event.data != null) {
            try {
              final payload = jsonDecode(event.data!) as Map<String, dynamic>;
              final newSessionId = payload['sessionId'];
              if (newSessionId != null && onSessionCreated != null) {
                onSessionCreated(newSessionId is int ? newSessionId : int.parse(newSessionId.toString()));
              }
            } catch (e) {
              debugPrint('解析 session 事件失败: $e');
            }
            return;
          }

          // RAG检索事件（忽略）
          if (event.event == 'rag_searching' || event.event == 'rag_completed') {
            return;
          }

          // 文生图事件
          if (event.event == 'image_generating' && event.data != null) {
            try {
              final payload = jsonDecode(event.data!) as Map<String, dynamic>;
              onImageGenerating?.call(ImageGeneration(
                index: payload['index'] as int,
                prompt: payload['prompt'] as String,
              ));
            } catch (e) {
              debugPrint('解析 image_generating 事件失败: $e');
            }
            return;
          }

          if (event.event == 'image_generated' && event.data != null) {
            try {
              final payload = jsonDecode(event.data!) as Map<String, dynamic>;
              onImageGenerated?.call(ImageGeneration(
                index: payload['index'] as int,
                prompt: payload['prompt'] as String,
                status: 'done',
                url: payload['url'] as String?,
              ));
            } catch (e) {
              debugPrint('解析 image_generated 事件失败: $e');
            }
            return;
          }

          if (event.event == 'image_error' && event.data != null) {
            try {
              final payload = jsonDecode(event.data!) as Map<String, dynamic>;
              onImageError?.call(ImageGeneration(
                index: payload['index'] as int,
                prompt: payload['prompt'] as String,
                status: 'error',
                error: payload['error'] as String?,
              ));
            } catch (e) {
              debugPrint('解析 image_error 事件失败: $e');
            }
            return;
          }

          // 文生视频事件
          if (event.event == 'video_generating' && event.data != null) {
            try {
              final payload = jsonDecode(event.data!) as Map<String, dynamic>;
              onVideoGenerating?.call(VideoGeneration(
                index: payload['index'] as int,
                prompt: payload['prompt'] as String,
              ));
            } catch (e) {
              debugPrint('解析 video_generating 事件失败: $e');
            }
            return;
          }

          if (event.event == 'video_generated' && event.data != null) {
            try {
              final payload = jsonDecode(event.data!) as Map<String, dynamic>;
              onVideoGenerated?.call(VideoGeneration(
                index: payload['index'] as int,
                prompt: payload['prompt'] as String,
                status: 'done',
                url: payload['url'] as String?,
              ));
            } catch (e) {
              debugPrint('解析 video_generated 事件失败: $e');
            }
            return;
          }

          if (event.event == 'video_error' && event.data != null) {
            try {
              final payload = jsonDecode(event.data!) as Map<String, dynamic>;
              onVideoError?.call(VideoGeneration(
                index: payload['index'] as int,
                prompt: payload['prompt'] as String,
                status: 'error',
                error: payload['error'] as String?,
              ));
            } catch (e) {
              debugPrint('解析 video_error 事件失败: $e');
            }
            return;
          }

          if (event.data != null && event.data!.isNotEmpty) {
            final data = event.data!;
            try {
              final jsonData = jsonDecode(data);
              if (jsonData is Map) {
                final content = jsonData['content'] ?? jsonData['text'] ?? data;
                onData(content.toString());
              } else {
                final cleaned = jsonData.toString().replaceAll(RegExp(r'\n$'), '');
                if (cleaned.isNotEmpty) onData(cleaned);
              }
            } catch (e) {
              final cleaned = data.replaceAll(RegExp(r'\n$'), '');
              if (cleaned.isNotEmpty) onData(cleaned);
            }
          }
        },
        onError: (error) {
          debugPrint('智慧体SSE Error: $error');
          _isStreaming = false;
          onError(error);
        },
        onDone: () {
          debugPrint('智慧体SSE Connection Done');
          if (_isStreaming) {
            _isStreaming = false;
            onDone();
          }
        },
      );
    } catch (e) {
      debugPrint('智慧体SSE Connection Error: $e');
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
