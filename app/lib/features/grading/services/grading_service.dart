import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/network/api_client.dart';
import '../../../services/file_upload_service.dart';

/// SSE 事件数据模型
class GradingSseEvent {
  final String? step;
  final String? message;
  final int? questionCount;
  final int? index;
  final int? total;
  final int? score;
  final int? maxScore;
  final String? comment;
  final List<String>? errorCategories;
  final List<String>? knowledgePoints;
  final String? submissionId;
  final String? overallComment;
  final String? error;

  GradingSseEvent({
    this.step,
    this.message,
    this.questionCount,
    this.index,
    this.total,
    this.score,
    this.maxScore,
    this.comment,
    this.errorCategories,
    this.knowledgePoints,
    this.submissionId,
    this.overallComment,
    this.error,
  });

  factory GradingSseEvent.fromJson(Map<String, dynamic> json) {
    return GradingSseEvent(
      step: json['step'] as String?,
      message: json['message'] as String?,
      questionCount: json['questionCount'] as int?,
      index: json['index'] as int?,
      total: json['total'] as int?,
      score: json['score'] as int?,
      maxScore: json['maxScore'] as int?,
      comment: json['comment'] as String?,
      errorCategories: (json['errorCategories'] as List?)?.cast<String>(),
      knowledgePoints: (json['knowledgePoints'] as List?)?.cast<String>(),
      submissionId: json['submissionId']?.toString(),
      overallComment: json['overallComment'] as String?,
      error: json['error'] as String?,
    );
  }

  bool get isOcr => step == 'ocr';
  bool get isOcrDone => step == 'ocr_done';
  bool get isGradingProgress => index != null && total != null && step == null && submissionId == null;
  bool get isQuestionGraded => step == 'question_graded';
  bool get isDone => step == 'done' || submissionId != null && overallComment != null;
  bool get isError => error != null;
}

/// 批改历史记录
class GradingHistoryItem {
  final String submissionId;
  final String? gradingMode;
  final String? title;
  final String? subject;
  final String? grade;
  final String? status;
  final int? totalScore;
  final int? maxScore;
  final List<String>? imageUrls;
  final String? createTime;

  GradingHistoryItem({
    required this.submissionId,
    this.gradingMode,
    this.title,
    this.subject,
    this.grade,
    this.status,
    this.totalScore,
    this.maxScore,
    this.imageUrls,
    this.createTime,
  });

  factory GradingHistoryItem.fromJson(Map<String, dynamic> json) {
    return GradingHistoryItem(
      submissionId: json['submissionId']?.toString() ?? '',
      gradingMode: json['gradingMode'] as String?,
      title: json['title'] as String?,
      subject: json['subject'] as String?,
      grade: json['grade'] as String?,
      status: json['status'] as String?,
      totalScore: json['totalScore'] as int?,
      maxScore: json['maxScore'] as int?,
      imageUrls: (json['imageUrls'] as List?)?.cast<String>(),
      createTime: json['createTime'] as String?,
    );
  }

  bool get isCompleted => status == 'COMPLETED';
  bool get isFailed => status == 'FAILED';
  bool get isProcessing => status == 'PROCESSING' || status == 'OCR_PROCESSING' || status == 'GRADING';
}

/// 批改结果
class GradingResultData {
  final String submissionId;
  final int totalScore;
  final int maxScore;
  final String? overallComment;
  final String? modelId;
  final String? gradingTime;
  final List<QuestionGradingData> questions;

  GradingResultData({
    required this.submissionId,
    required this.totalScore,
    required this.maxScore,
    this.overallComment,
    this.modelId,
    this.gradingTime,
    required this.questions,
  });

  factory GradingResultData.fromJson(Map<String, dynamic> json) {
    return GradingResultData(
      submissionId: json['submissionId']?.toString() ?? '',
      totalScore: json['totalScore'] as int? ?? 0,
      maxScore: json['maxScore'] as int? ?? 0,
      overallComment: json['overallComment'] as String?,
      modelId: json['modelId'] as String?,
      gradingTime: json['gradingTime'] as String?,
      questions: (json['questions'] as List?)
              ?.map((q) => QuestionGradingData.fromJson(q as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  double get scoreRate => maxScore > 0 ? totalScore / maxScore : 0;
  int get correctCount => questions.where((q) => q.score == q.maxScore).length;
  int get wrongCount => questions.where((q) => q.score == 0).length;
  int get partialCount => questions.where((q) => q.score > 0 && q.score < q.maxScore).length;
}

/// 单题批改数据
class QuestionGradingData {
  final int questionIndex;
  final String? questionContent;
  final String? questionType;
  final String? studentAnswer;
  final String? standardAnswer;
  final int score;
  final int maxScore;
  final List<String> errorCategories;
  final String? errorDetail;
  final List<String> knowledgePoints;
  final String? comment;

  QuestionGradingData({
    required this.questionIndex,
    this.questionContent,
    this.questionType,
    this.studentAnswer,
    this.standardAnswer,
    required this.score,
    required this.maxScore,
    required this.errorCategories,
    this.errorDetail,
    required this.knowledgePoints,
    this.comment,
  });

  factory QuestionGradingData.fromJson(Map<String, dynamic> json) {
    return QuestionGradingData(
      questionIndex: json['questionIndex'] as int? ?? 0,
      questionContent: json['questionContent'] as String?,
      questionType: json['questionType'] as String?,
      studentAnswer: json['studentAnswer'] as String?,
      standardAnswer: json['standardAnswer'] as String?,
      score: json['score'] as int? ?? 0,
      maxScore: json['maxScore'] as int? ?? 0,
      errorCategories: (json['errorCategories'] as List?)?.cast<String>() ?? [],
      errorDetail: json['errorDetail'] as String?,
      knowledgePoints: (json['knowledgePoints'] as List?)?.cast<String>() ?? [],
      comment: json['comment'] as String?,
    );
  }

  bool get isCorrect => score == maxScore;
  bool get isWrong => score == 0;
  bool get isPartial => score > 0 && score < maxScore;
}

/// 统计数据
class GradingStatsData {
  final int totalSubmissions;
  final double avgScoreRate;
  final List<ScoreTrendData> scoreTrend;
  final Map<String, double> subjectScoreRates;
  final List<ErrorCategoryData> errorDistribution;

  GradingStatsData({
    required this.totalSubmissions,
    required this.avgScoreRate,
    required this.scoreTrend,
    required this.subjectScoreRates,
    required this.errorDistribution,
  });

  factory GradingStatsData.fromJson(Map<String, dynamic> json) {
    return GradingStatsData(
      totalSubmissions: json['totalSubmissions'] as int? ?? 0,
      avgScoreRate: (json['avgScoreRate'] as num?)?.toDouble() ?? 0,
      scoreTrend: (json['scoreTrend'] as List?)
              ?.map((e) => ScoreTrendData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      subjectScoreRates: (json['subjectScoreRates'] as Map?)
              ?.map((k, v) => MapEntry(k.toString(), (v as num).toDouble())) ??
          {},
      errorDistribution: (json['errorDistribution'] as List?)
              ?.map((e) => ErrorCategoryData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class ScoreTrendData {
  final String? submissionId;
  final String? subject;
  final String? createTime;
  final int? score;
  final int? maxScore;

  ScoreTrendData({this.submissionId, this.subject, this.createTime, this.score, this.maxScore});

  factory ScoreTrendData.fromJson(Map<String, dynamic> json) {
    return ScoreTrendData(
      submissionId: json['submissionId']?.toString(),
      subject: json['subject'] as String?,
      createTime: json['createTime'] as String?,
      score: json['score'] as int?,
      maxScore: json['maxScore'] as int?,
    );
  }
}

class ErrorCategoryData {
  final String? category;
  final String? categoryName;
  final int count;

  ErrorCategoryData({this.category, this.categoryName, required this.count});

  factory ErrorCategoryData.fromJson(Map<String, dynamic> json) {
    return ErrorCategoryData(
      category: json['category'] as String?,
      categoryName: json['categoryName'] as String?,
      count: (json['count'] as num?)?.toInt() ?? 0,
    );
  }
}

/// 知识画像
class SubjectProfileData {
  final String? subject;
  final String? subjectName;
  final int totalPoints;
  final double avgMasteryLevel;
  final int weakPointCount;
  final int strongPointCount;
  final List<KnowledgePointData> weakPoints;
  final List<KnowledgePointData> strongPoints;

  SubjectProfileData({
    this.subject,
    this.subjectName,
    required this.totalPoints,
    required this.avgMasteryLevel,
    required this.weakPointCount,
    required this.strongPointCount,
    required this.weakPoints,
    required this.strongPoints,
  });

  factory SubjectProfileData.fromJson(Map<String, dynamic> json) {
    return SubjectProfileData(
      subject: json['subject'] as String?,
      subjectName: json['subjectName'] as String?,
      totalPoints: json['totalPoints'] as int? ?? 0,
      avgMasteryLevel: (json['avgMasteryLevel'] as num?)?.toDouble() ?? 0,
      weakPointCount: json['weakPointCount'] as int? ?? 0,
      strongPointCount: json['strongPointCount'] as int? ?? 0,
      weakPoints: (json['weakPoints'] as List?)
              ?.map((e) => KnowledgePointData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      strongPoints: (json['strongPoints'] as List?)
              ?.map((e) => KnowledgePointData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class KnowledgePointData {
  final String? knowledgePoint;
  final String? subject;
  final double masteryLevel;
  final int totalAttempts;
  final int correctCount;
  final bool isWeakPoint;

  KnowledgePointData({
    this.knowledgePoint,
    this.subject,
    required this.masteryLevel,
    required this.totalAttempts,
    required this.correctCount,
    required this.isWeakPoint,
  });

  factory KnowledgePointData.fromJson(Map<String, dynamic> json) {
    return KnowledgePointData(
      knowledgePoint: json['knowledgePoint'] as String?,
      subject: json['subject'] as String?,
      masteryLevel: (json['masteryLevel'] as num?)?.toDouble() ?? 0,
      totalAttempts: json['totalAttempts'] as int? ?? 0,
      correctCount: json['correctCount'] as int? ?? 0,
      isWeakPoint: json['weakPoint'] as bool? ?? false,
    );
  }
}

/// 试卷信息
class ExamPaperItem {
  final String id;
  final String? title;
  final String? subtitle;
  final String? subject;
  final String? subjectName;
  final String? grade;
  final int? totalScore;
  final int? durationMin;

  ExamPaperItem({
    required this.id,
    this.title,
    this.subtitle,
    this.subject,
    this.subjectName,
    this.grade,
    this.totalScore,
    this.durationMin,
  });

  factory ExamPaperItem.fromJson(Map<String, dynamic> json) {
    return ExamPaperItem(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      subject: json['subject'] as String?,
      subjectName: json['subjectName'] as String?,
      grade: json['grade'] as String?,
      totalScore: json['totalScore'] as int?,
      durationMin: json['durationMin'] as int?,
    );
  }
}

/// 智能批改服务
class GradingService {
  static final GradingService _instance = GradingService._internal();
  factory GradingService() => _instance;
  GradingService._internal();

  final Dio _dio = ApiClient.instance.dio;
  final _fileUploadService = FileUploadService();

  // ==================== 图片操作 ====================

  /// 从相册选择图片
  Future<XFile?> pickImageFromGallery() async {
    return _fileUploadService.pickImageFromGallery();
  }

  /// 从相机拍照
  Future<XFile?> pickImageFromCamera() async {
    return _fileUploadService.pickImageFromCamera();
  }

  /// 上传批改图片
  Future<String?> uploadGradingImage(XFile file) async {
    final result = await _fileUploadService.uploadFile(file, 'grading/homework');
    return result?.fileUrl;
  }

  // ==================== SSE 提交批改 ====================

  /// 提交批改并返回 SSE 事件流
  Stream<GradingSseEvent> submitAndGrade({
    required String gradingMode,
    String? title,
    String? subject,
    String? grade,
    required List<String> imageUrls,
    String? examPaperId,
  }) async* {
    try {
      final body = <String, dynamic>{
        'gradingMode': gradingMode,
        'imageUrls': imageUrls,
      };
      if (title != null && title.isNotEmpty) body['title'] = title;
      if (subject != null && subject.isNotEmpty) body['subject'] = subject;
      if (grade != null && grade.isNotEmpty) body['grade'] = grade;
      if (examPaperId != null && examPaperId.isNotEmpty) body['examPaperId'] = int.tryParse(examPaperId);

      final response = await _dio.post<ResponseBody>(
        '/api/grading/submit',
        data: body,
        options: Options(
          responseType: ResponseType.stream,
          headers: {'Accept': 'text/event-stream'},
        ),
      );

      final stream = response.data!.stream;
      String buffer = '';
      List<int> pendingBytes = []; // 累积未完成的 UTF-8 字节

      await for (final chunk in stream) {
        pendingBytes.addAll(chunk);
        // 安全解码：多字节 UTF-8 字符可能跨 chunk 拆分
        try {
          buffer += utf8.decode(pendingBytes);
          pendingBytes = [];
        } on FormatException {
          continue;
        }

        // 解析 SSE 格式: "data: {...}\n\n"
        while (buffer.contains('\n\n')) {
          final idx = buffer.indexOf('\n\n');
          final block = buffer.substring(0, idx).trim();
          buffer = buffer.substring(idx + 2);

          if (block.isEmpty) continue;

          for (final line in block.split('\n')) {
            if (line.startsWith('data:')) {
              final jsonStr = line.substring(5).trim();
              if (jsonStr.isEmpty) continue;
              try {
                final json = jsonDecode(jsonStr) as Map<String, dynamic>;
                yield GradingSseEvent.fromJson(json);
              } catch (e) {
                debugPrint('SSE JSON解析失败: $e, data: $jsonStr');
              }
            }
          }
        }
      }
    } catch (e) {
      debugPrint('SSE 批改请求失败: $e');
      yield GradingSseEvent(error: e.toString());
    }
  }

  // ==================== 查询 API ====================

  /// 获取批改结果
  Future<GradingResultData?> getGradingResult(String submissionId) async {
    try {
      final response = await _dio.get('/api/grading/$submissionId/result');
      final data = response.data;
      if (data is Map && data['code'] == 0 && data['data'] != null) {
        return GradingResultData.fromJson(data['data'] as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint('获取批改结果失败: $e');
    }
    return null;
  }

  /// 获取批改历史
  Future<List<GradingHistoryItem>> getHistory({int page = 1, int size = 20}) async {
    try {
      final response = await _dio.get('/api/grading/history', queryParameters: {
        'page': page,
        'size': size,
      });
      final data = response.data;
      if (data is Map && data['code'] == 0 && data['data'] != null) {
        return (data['data'] as List)
            .map((e) => GradingHistoryItem.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('获取批改历史失败: $e');
    }
    return [];
  }

  /// 获取统计数据
  Future<GradingStatsData?> getStats() async {
    try {
      final response = await _dio.get('/api/grading/stats');
      final data = response.data;
      if (data is Map && data['code'] == 0 && data['data'] != null) {
        return GradingStatsData.fromJson(data['data'] as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint('获取统计数据失败: $e');
    }
    return null;
  }

  /// 获取全部知识画像
  Future<List<SubjectProfileData>> getAllProfiles() async {
    try {
      final response = await _dio.get('/api/grading/profile');
      final data = response.data;
      if (data is Map && data['code'] == 0 && data['data'] != null) {
        return (data['data'] as List)
            .map((e) => SubjectProfileData.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('获取知识画像失败: $e');
    }
    return [];
  }

  /// 查询已发布试卷
  Future<List<ExamPaperItem>> getPublishedPapers({
    String? keyword,
    String? subject,
    int page = 1,
    int size = 50,
  }) async {
    try {
      final params = <String, dynamic>{'page': page, 'size': size};
      if (keyword != null && keyword.isNotEmpty) params['keyword'] = keyword;
      if (subject != null && subject.isNotEmpty) params['subject'] = subject;

      final response = await _dio.get('/api/grading/papers', queryParameters: params);
      final data = response.data;
      if (data is Map && data['code'] == 0 && data['data'] != null) {
        final records = data['data']['records'] as List?;
        if (records != null) {
          return records.map((e) => ExamPaperItem.fromJson(e as Map<String, dynamic>)).toList();
        }
      }
    } catch (e) {
      debugPrint('查询试卷列表失败: $e');
    }
    return [];
  }
}

/// 学科名称映射
const Map<String, String> subjectNames = {
  'MATH': '数学',
  'CHINESE': '语文',
  'ENGLISH': '英语',
  'PHYSICS': '物理',
  'CHEMISTRY': '化学',
  'BIOLOGY': '生物',
  'HISTORY': '历史',
  'GEOGRAPHY': '地理',
  'POLITICS': '政治',
};

/// 错误类型名称映射
const Map<String, String> errorCategoryNames = {
  'CONCEPT_ERROR': '概念错误',
  'CALCULATION_ERROR': '计算错误',
  'READING_ERROR': '审题错误',
  'UNIT_ERROR': '单位错误',
  'STEP_MISSING': '步骤缺失',
  'LOGIC_INCOMPLETE': '逻辑不完整',
  'EXPRESSION_UNCLEAR': '表达不清',
  'GRAMMAR_ERROR': '语法错误',
  'SPELLING_ERROR': '拼写错误',
  'FORMAT_ERROR': '格式错误',
  'KNOWLEDGE_GAP': '知识盲区',
  'CARELESS_MISTAKE': '粗心大意',
};

/// 学科列表（含自动识别）
const List<Map<String, String>> subjectOptions = [
  {'code': '', 'name': '自动识别（AI推断）'},
  {'code': 'MATH', 'name': '数学'},
  {'code': 'CHINESE', 'name': '语文'},
  {'code': 'ENGLISH', 'name': '英语'},
  {'code': 'PHYSICS', 'name': '物理'},
  {'code': 'CHEMISTRY', 'name': '化学'},
  {'code': 'BIOLOGY', 'name': '生物'},
  {'code': 'HISTORY', 'name': '历史'},
  {'code': 'GEOGRAPHY', 'name': '地理'},
  {'code': 'POLITICS', 'name': '政治'},
];

/// 年级列表
const List<Map<String, String>> gradeOptions = [
  {'code': '', 'name': '不指定'},
  {'code': '一年级', 'name': '一年级'},
  {'code': '二年级', 'name': '二年级'},
  {'code': '三年级', 'name': '三年级'},
  {'code': '四年级', 'name': '四年级'},
  {'code': '五年级', 'name': '五年级'},
  {'code': '六年级', 'name': '六年级'},
  {'code': '初一', 'name': '初一'},
  {'code': '初二', 'name': '初二'},
  {'code': '初三', 'name': '初三'},
  {'code': '高一', 'name': '高一'},
  {'code': '高二', 'name': '高二'},
  {'code': '高三', 'name': '高三'},
];
