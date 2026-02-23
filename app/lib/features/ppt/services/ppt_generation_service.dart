import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/network/api_client.dart';

// ==================== SSE 事件 ====================

class PptSseEvent {
  final String type;
  final String rawData;
  final Map<String, dynamic>? jsonData;

  PptSseEvent({required this.type, required this.rawData, this.jsonData});

  factory PptSseEvent.parse(String eventType, String data) {
    Map<String, dynamic>? json;
    try {
      json = jsonDecode(data) as Map<String, dynamic>;
    } catch (_) {}
    return PptSseEvent(type: eventType, rawData: data, jsonData: json);
  }
}

// ==================== 会话状态枚举 ====================

enum PptPhase {
  idle,
  detecting,
  generatingOutline,
  outlineReady,
  awaitingTemplate,
  parsingTemplate,
  templateReady,
  generatingSlides,
  assembling,
  completed,
  error,
}

// ==================== 消息类型 ====================

enum PptMessageType {
  user,
  aiText,
  outlineCard,
  progressCard,
  downloadCard,
  templateSelector,
  slidePreview,
  status,
  error,
}

// ==================== 聊天消息 ====================

class PptChatMessage {
  final String id;
  final PptMessageType type;
  String content;
  final DateTime timestamp;
  bool isStreaming;

  // 大纲
  String? outlineMarkdown;
  bool outlineConfirmed;

  // 进度
  int? progressCurrent;
  int? progressTotal;

  // 下载
  String? downloadUrl;
  String? downloadFileName;

  PptChatMessage({
    required this.id,
    required this.type,
    this.content = '',
    DateTime? timestamp,
    this.isStreaming = false,
    this.outlineMarkdown,
    this.outlineConfirmed = false,
    this.progressCurrent,
    this.progressTotal,
    this.downloadUrl,
    this.downloadFileName,
  }) : timestamp = timestamp ?? DateTime.now();
}

// ==================== 会话摘要 ====================

class PptSessionSummary {
  final String id;
  final String topic;
  final String state;
  final String? resultUrl;
  final String? createTime;
  final String? updateTime;

  PptSessionSummary({
    required this.id,
    required this.topic,
    required this.state,
    this.resultUrl,
    this.createTime,
    this.updateTime,
  });

  factory PptSessionSummary.fromJson(Map<String, dynamic> json) {
    return PptSessionSummary(
      id: json['id']?.toString() ?? '',
      topic: json['topic'] as String? ?? '',
      state: json['state'] as String? ?? '',
      resultUrl: json['resultUrl'] as String?,
      createTime: json['createTime'] as String?,
      updateTime: json['updateTime'] as String?,
    );
  }

  bool get isCompleted => state.toLowerCase() == 'completed';
}

// ==================== 会话详情 ====================

class PptSessionDetail {
  final String id;
  final String topic;
  final String state;
  final String? outlineMarkdown;
  final String? templateUrl;
  final String? templateJson;
  final String? slidesJson;
  final String? resultUrl;
  final String? createTime;
  final String? updateTime;

  PptSessionDetail({
    required this.id,
    required this.topic,
    required this.state,
    this.outlineMarkdown,
    this.templateUrl,
    this.templateJson,
    this.slidesJson,
    this.resultUrl,
    this.createTime,
    this.updateTime,
  });

  factory PptSessionDetail.fromJson(Map<String, dynamic> json) {
    return PptSessionDetail(
      id: json['id']?.toString() ?? '',
      topic: json['topic'] as String? ?? '',
      state: json['state'] as String? ?? '',
      outlineMarkdown: json['outlineMarkdown'] as String?,
      templateUrl: json['templateUrl'] as String?,
      templateJson: json['templateJson'] as String?,
      slidesJson: json['slidesJson'] as String?,
      resultUrl: json['resultUrl'] as String?,
      createTime: json['createTime'] as String?,
      updateTime: json['updateTime'] as String?,
    );
  }
}

// ==================== 模板 ====================

class PptTemplate {
  final String id;
  final String name;
  final String? coverUrl;
  final int slideCount;
  final String? fileUrl;

  PptTemplate({
    required this.id,
    required this.name,
    this.coverUrl,
    this.slideCount = 0,
    this.fileUrl,
  });

  factory PptTemplate.fromJson(Map<String, dynamic> json) {
    return PptTemplate(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '未命名模板',
      coverUrl: json['coverUrl'] as String?,
      slideCount: json['slideCount'] as int? ?? 0,
      fileUrl: json['fileUrl'] as String?,
    );
  }
}

// ==================== 生成的幻灯片 ====================

class GeneratedSlide {
  final String? previewImageUrl;
  bool isNew;

  GeneratedSlide({this.previewImageUrl, this.isNew = false});
}

// ==================== 服务层 ====================

class PptGenerationService {
  final Dio _dio = ApiClient.instance.dio;
  CancelToken? _cancelToken;

  // ==================== REST API ====================

  /// 获取会话列表
  Future<List<PptSessionSummary>> getSessions() async {
    try {
      final response = await _dio.get('/api/ppt/generation/sessions');
      final data = response.data;
      if (data is Map && data['code'] == 0 && data['data'] != null) {
        return (data['data'] as List)
            .map((e) => PptSessionSummary.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('获取PPT会话列表失败: $e');
    }
    return [];
  }

  /// 获取会话详情
  Future<PptSessionDetail?> getSessionDetail(String sessionId) async {
    try {
      final response = await _dio.get('/api/ppt/generation/sessions/$sessionId');
      final data = response.data;
      if (data is Map && data['code'] == 0 && data['data'] != null) {
        return PptSessionDetail.fromJson(data['data'] as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint('获取PPT会话详情失败: $e');
    }
    return null;
  }

  /// 删除会话
  Future<bool> deleteSession(String sessionId) async {
    try {
      await _dio.delete('/api/ppt/generation/sessions/$sessionId');
      return true;
    } catch (e) {
      debugPrint('删除PPT会话失败: $e');
      return false;
    }
  }

  /// 获取模板列表
  Future<List<PptTemplate>> getTemplates() async {
    try {
      final response = await _dio.get('/api/ppt/templates');
      final data = response.data;
      if (data is Map && data['code'] == 0 && data['data'] != null) {
        return (data['data'] as List)
            .map((e) => PptTemplate.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('获取PPT模板列表失败: $e');
    }
    return [];
  }

  /// 上传自定义模板（multipart）
  Future<String?> uploadTemplate(String filePath, String name, {String? description}) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath, filename: name.endsWith('.pptx') ? name : '$name.pptx'),
        'name': name,
        if (description != null) 'description': description,
      });
      final response = await _dio.post('/api/ppt/templates', data: formData);
      final data = response.data;
      if (data is Map && data['code'] == 0 && data['data'] != null) {
        return data['data'].toString();
      }
    } catch (e) {
      debugPrint('上传PPT模板失败: $e');
    }
    return null;
  }

  // ==================== SSE 流式通信 ====================

  /// 通用 SSE action — 返回 `Stream<PptSseEvent>`
  Stream<PptSseEvent> sendAction({
    required String action,
    String? sessionId,
    String? message,
    String? topic,
    String? requirements,
    String? feedback,
    String? templateId,
    String? templateUrl,
  }) async* {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    try {
      final body = <String, dynamic>{'action': action};
      if (sessionId != null) body['sessionId'] = sessionId;
      if (message != null) body['message'] = message;
      if (topic != null) body['topic'] = topic;
      if (requirements != null) body['requirements'] = requirements;
      if (feedback != null) body['feedback'] = feedback;
      if (templateId != null) body['templateId'] = templateId;
      if (templateUrl != null) body['templateUrl'] = templateUrl;

      final response = await _dio.post<ResponseBody>(
        '/api/ppt/generation/stream',
        data: body,
        options: Options(
          responseType: ResponseType.stream,
          headers: {'Accept': 'text/event-stream'},
          // 延长超时，PPT生成可能很久
          receiveTimeout: const Duration(minutes: 10),
        ),
        cancelToken: _cancelToken,
      );

      final stream = response.data!.stream;
      String buffer = '';
      String currentEventType = 'message';
      List<int> pendingBytes = []; // 累积未完成的 UTF-8 字节

      await for (final chunk in stream) {
        pendingBytes.addAll(chunk);
        // 安全解码：多字节 UTF-8 字符可能跨 chunk 拆分
        try {
          buffer += utf8.decode(pendingBytes);
          pendingBytes = [];
        } on FormatException {
          // 末尾有不完整的 UTF-8 序列，等下一个 chunk 补齐
          continue;
        }

        // 按 \n\n 分隔 SSE 事件块
        while (buffer.contains('\n\n')) {
          final idx = buffer.indexOf('\n\n');
          final block = buffer.substring(0, idx).trim();
          buffer = buffer.substring(idx + 2);

          if (block.isEmpty) continue;

          String dataContent = '';
          for (final line in block.split('\n')) {
            if (line.startsWith('event:')) {
              currentEventType = line.substring(6).trim();
            } else if (line.startsWith('data:')) {
              final val = line.substring(5);
              dataContent += val.startsWith(' ') ? val.substring(1) : val;
            }
          }

          if (dataContent.isEmpty) {
            currentEventType = 'message';
            continue;
          }
          if (dataContent == '[DONE]') {
            // 先把 done 事件推给监听方，再跳过
            if (currentEventType == 'done') {
              yield PptSseEvent(type: 'done', rawData: '');
            }
            currentEventType = 'message';
            continue;
          }

          yield PptSseEvent.parse(currentEventType, dataContent);
          currentEventType = 'message';
        }
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) return;
      debugPrint('PPT SSE 请求失败: $e');
      yield PptSseEvent(type: 'error', rawData: e.message ?? '网络请求失败');
    } catch (e) {
      debugPrint('PPT SSE 请求失败: $e');
      yield PptSseEvent(type: 'error', rawData: e.toString());
    }
  }

  /// 中止当前 SSE 流
  void abort() {
    _cancelToken?.cancel();
    _cancelToken = null;
  }

  /// 释放资源
  void dispose() {
    abort();
  }
}
