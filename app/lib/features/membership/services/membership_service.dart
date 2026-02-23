import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/network/api_client.dart';

// ==================== 数据模型 ====================

/// AI功能配额限额
class QuotaLimit {
  final int dailyLimit;
  final int monthlyLimit;

  const QuotaLimit({required this.dailyLimit, required this.monthlyLimit});

  bool get isUnlimited => dailyLimit == -1 && monthlyLimit == -1;

  String formatDaily() => dailyLimit == -1 ? '无限' : '$dailyLimit';
  String formatMonthly() => monthlyLimit == -1 ? '无限' : '$monthlyLimit';

  String format() {
    if (isUnlimited) return '无限';
    return '${formatDaily()}/天 · ${formatMonthly()}/月';
  }
}

/// AI功能剩余额度
class QuotaRemaining {
  final int dailyLimit;
  final int monthlyLimit;
  final int dailyRemaining;
  final int monthlyRemaining;

  const QuotaRemaining({
    required this.dailyLimit,
    required this.monthlyLimit,
    required this.dailyRemaining,
    required this.monthlyRemaining,
  });

  bool get isUnlimited => dailyRemaining == -1 && monthlyRemaining == -1;

  String format() {
    if (isUnlimited) return '无限';
    final d = dailyRemaining == -1 ? '无限' : '$dailyRemaining';
    final m = monthlyRemaining == -1 ? '无限' : '$monthlyRemaining';
    return '今日$d / 本月$m';
  }

  /// 日额度消耗比例 (0.0~1.0)，-1无限返回0
  double get dailyUsageRatio {
    if (dailyLimit <= 0 || dailyRemaining == -1) return 0;
    return 1.0 - (dailyRemaining / dailyLimit).clamp(0.0, 1.0);
  }
}

/// 会员计划展示模型
class MembershipPlanData {
  final String id;
  final String name;
  final String code;
  final String description;
  final double price;
  final int durationDays;
  final bool courseMemberAccess;
  final Map<String, QuotaLimit> quotas;

  const MembershipPlanData({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.price,
    required this.durationDays,
    required this.courseMemberAccess,
    required this.quotas,
  });

  bool get isFree => price == 0 || code == 'FREE';

  String get durationText => durationDays > 0 ? '$durationDays天' : '永久';

  factory MembershipPlanData.fromJson(Map<String, dynamic> json) {
    return MembershipPlanData(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      code: json['code'] as String? ?? 'FREE',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      durationDays: json['durationDays'] as int? ?? 0,
      courseMemberAccess: json['courseMemberAccess'] as bool? ?? false,
      quotas: {
        'AI_CHAT': QuotaLimit(
          dailyLimit: json['aiChatDailyLimit'] as int? ?? -1,
          monthlyLimit: json['aiChatMonthlyLimit'] as int? ?? -1,
        ),
        'AI_PPT': QuotaLimit(
          dailyLimit: json['aiPptDailyLimit'] as int? ?? -1,
          monthlyLimit: json['aiPptMonthlyLimit'] as int? ?? -1,
        ),
        'AI_EXAM': QuotaLimit(
          dailyLimit: json['aiExamDailyLimit'] as int? ?? -1,
          monthlyLimit: json['aiExamMonthlyLimit'] as int? ?? -1,
        ),
        'AI_BOOK': QuotaLimit(
          dailyLimit: json['aiBookDailyLimit'] as int? ?? -1,
          monthlyLimit: json['aiBookMonthlyLimit'] as int? ?? -1,
        ),
        'AI_GRADING': QuotaLimit(
          dailyLimit: json['aiGradingDailyLimit'] as int? ?? -1,
          monthlyLimit: json['aiGradingMonthlyLimit'] as int? ?? -1,
        ),
      },
    );
  }
}

/// 当前会员详情展示模型
class MembershipDetailData {
  final String? id;
  final String? orderNo;
  final String planCode;
  final String planName;
  final String? planDescription;
  final double planPrice;
  final int planDurationDays;
  final String status;
  final DateTime? startTime;
  final DateTime? expireTime;
  final bool courseMemberAccess;
  final Map<String, QuotaRemaining> quotas;

  const MembershipDetailData({
    this.id,
    this.orderNo,
    required this.planCode,
    required this.planName,
    this.planDescription,
    required this.planPrice,
    required this.planDurationDays,
    required this.status,
    this.startTime,
    this.expireTime,
    required this.courseMemberAccess,
    required this.quotas,
  });

  bool get isActive => status == 'ACTIVE';
  bool get isFree => status == 'FREE' || planCode == 'FREE';
  bool get isPending => status == 'PENDING';
  bool get isExpired => status == 'EXPIRED';

  String get statusText {
    switch (status) {
      case 'FREE': return '免费版';
      case 'PENDING': return '待支付';
      case 'ACTIVE': return '生效中';
      case 'EXPIRED': return '已过期';
      case 'CANCELLED': return '已取消';
      default: return status;
    }
  }

  String get expireText {
    if (isActive && expireTime != null) {
      return '到期：${_formatDate(expireTime!)}';
    } else if (isActive) {
      return '永久有效';
    }
    return '未开通会员';
  }

  static String _formatDate(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }

  factory MembershipDetailData.fromJson(Map<String, dynamic> json) {
    return MembershipDetailData(
      id: json['id']?.toString(),
      orderNo: json['orderNo'] as String?,
      planCode: json['planCode'] as String? ?? 'FREE',
      planName: json['planName'] as String? ?? '免费版',
      planDescription: json['planDescription'] as String?,
      planPrice: (json['planPrice'] as num?)?.toDouble() ?? 0,
      planDurationDays: json['planDurationDays'] as int? ?? 0,
      status: json['status'] as String? ?? 'FREE',
      startTime: json['startTime'] != null ? DateTime.tryParse(json['startTime'].toString()) : null,
      expireTime: json['expireTime'] != null ? DateTime.tryParse(json['expireTime'].toString()) : null,
      courseMemberAccess: json['courseMemberAccess'] as bool? ?? false,
      quotas: {
        'AI_CHAT': QuotaRemaining(
          dailyLimit: json['aiChatDailyLimit'] as int? ?? -1,
          monthlyLimit: json['aiChatMonthlyLimit'] as int? ?? -1,
          dailyRemaining: json['aiChatDailyRemaining'] as int? ?? -1,
          monthlyRemaining: json['aiChatMonthlyRemaining'] as int? ?? -1,
        ),
        'AI_PPT': QuotaRemaining(
          dailyLimit: json['aiPptDailyLimit'] as int? ?? -1,
          monthlyLimit: json['aiPptMonthlyLimit'] as int? ?? -1,
          dailyRemaining: json['aiPptDailyRemaining'] as int? ?? -1,
          monthlyRemaining: json['aiPptMonthlyRemaining'] as int? ?? -1,
        ),
        'AI_EXAM': QuotaRemaining(
          dailyLimit: json['aiExamDailyLimit'] as int? ?? -1,
          monthlyLimit: json['aiExamMonthlyLimit'] as int? ?? -1,
          dailyRemaining: json['aiExamDailyRemaining'] as int? ?? -1,
          monthlyRemaining: json['aiExamMonthlyRemaining'] as int? ?? -1,
        ),
        'AI_BOOK': QuotaRemaining(
          dailyLimit: json['aiBookDailyLimit'] as int? ?? -1,
          monthlyLimit: json['aiBookMonthlyLimit'] as int? ?? -1,
          dailyRemaining: json['aiBookDailyRemaining'] as int? ?? -1,
          monthlyRemaining: json['aiBookMonthlyRemaining'] as int? ?? -1,
        ),
        'AI_GRADING': QuotaRemaining(
          dailyLimit: json['aiGradingDailyLimit'] as int? ?? -1,
          monthlyLimit: json['aiGradingMonthlyLimit'] as int? ?? -1,
          dailyRemaining: json['aiGradingDailyRemaining'] as int? ?? -1,
          monthlyRemaining: json['aiGradingMonthlyRemaining'] as int? ?? -1,
        ),
      },
    );
  }
}

/// 会员历史记录
class MembershipHistoryItem {
  final String id;
  final String? planId;
  final String? orderNo;
  final String? status;
  final DateTime? startTime;
  final DateTime? expireTime;
  final DateTime? createTime;

  const MembershipHistoryItem({
    required this.id,
    this.planId,
    this.orderNo,
    this.status,
    this.startTime,
    this.expireTime,
    this.createTime,
  });

  String get statusText {
    switch (status) {
      case 'PENDING': return '待支付';
      case 'ACTIVE': return '生效中';
      case 'EXPIRED': return '已过期';
      case 'CANCELLED': return '已取消';
      default: return status ?? '未知';
    }
  }

  factory MembershipHistoryItem.fromJson(Map<String, dynamic> json) {
    return MembershipHistoryItem(
      id: json['id']?.toString() ?? '',
      planId: json['planId']?.toString(),
      orderNo: json['orderNo'] as String?,
      status: json['status'] as String?,
      startTime: json['startTime'] != null ? DateTime.tryParse(json['startTime'].toString()) : null,
      expireTime: json['expireTime'] != null ? DateTime.tryParse(json['expireTime'].toString()) : null,
      createTime: json['createTime'] != null ? DateTime.tryParse(json['createTime'].toString()) : null,
    );
  }
}

// ==================== 常量映射 ====================

const planLabels = <String, String>{
  'FREE': '免费版',
  'BASIC': '基础版',
  'PRO': '专业版',
  'TEACHER': '教师版',
};

const statusLabels = <String, String>{
  'FREE': '免费版',
  'PENDING': '待支付',
  'ACTIVE': '生效中',
  'EXPIRED': '已过期',
  'CANCELLED': '已取消',
};

/// AI功能信息
class AiFeatureInfo {
  final String key;
  final String label;

  const AiFeatureInfo(this.key, this.label);
}

const aiFeatures = <AiFeatureInfo>[
  AiFeatureInfo('AI_CHAT', 'AI 对话'),
  AiFeatureInfo('AI_PPT', 'PPT 生成'),
  AiFeatureInfo('AI_EXAM', 'AI 出题'),
  AiFeatureInfo('AI_BOOK', '电子书AI'),
  AiFeatureInfo('AI_GRADING', '智能批改'),
];

// ==================== 服务层 ====================

class MembershipService {
  final Dio _dio = ApiClient.instance.dio;

  /// 获取所有会员计划（过滤TEACHER，前端不展示）
  Future<List<MembershipPlanData>> getPlans({bool filterTeacher = true}) async {
    try {
      final response = await _dio.get('/api/membership/plans');
      final data = response.data;
      if (data['code'] == 0 && data['data'] != null) {
        final list = (data['data'] as List)
            .map((e) => MembershipPlanData.fromJson(e as Map<String, dynamic>))
            .toList();
        if (filterTeacher) {
          list.removeWhere((p) => p.code == 'TEACHER');
        }
        return list;
      }
      return [];
    } on DioException catch (e) {
      debugPrint('获取会员计划失败: ${e.message}');
      rethrow;
    }
  }

  /// 获取当前会员详情（含剩余额度）
  Future<MembershipDetailData?> getCurrentMembershipDetail() async {
    try {
      final response = await _dio.get('/api/membership/current');
      final data = response.data;
      if (data['code'] == 0 && data['data'] != null) {
        return MembershipDetailData.fromJson(data['data'] as Map<String, dynamic>);
      }
      return null;
    } on DioException catch (e) {
      debugPrint('获取会员详情失败: ${e.message}');
      rethrow;
    }
  }

  /// 获取AI额度汇总
  Future<Map<String, QuotaRemaining>> getAiQuota() async {
    try {
      final response = await _dio.get('/api/membership/ai-quota');
      final data = response.data;
      if (data['code'] == 0 && data['data'] != null) {
        final map = data['data'] as Map<String, dynamic>;
        final result = <String, QuotaRemaining>{};
        for (final entry in map.entries) {
          final v = entry.value as Map<String, dynamic>;
          result[entry.key] = QuotaRemaining(
            dailyLimit: -1,
            monthlyLimit: -1,
            dailyRemaining: v['dailyRemaining'] as int? ?? -1,
            monthlyRemaining: v['monthlyRemaining'] as int? ?? -1,
          );
        }
        return result;
      }
      return {};
    } on DioException catch (e) {
      debugPrint('获取AI额度失败: ${e.message}');
      rethrow;
    }
  }

  /// 购买会员
  Future<String> purchaseMembership(String planId) async {
    try {
      final response = await _dio.post(
        '/api/membership/purchase',
        data: {'planId': int.parse(planId)},
      );
      final data = response.data;
      if (data['code'] == 0) {
        return data['data']?.toString() ?? '';
      }
      throw DioException(
        requestOptions: response.requestOptions,
        message: data['message'] as String? ?? '购买失败',
      );
    } on DioException catch (e) {
      debugPrint('购买会员失败: ${e.message}');
      rethrow;
    }
  }

  /// 取消会员
  Future<void> cancelMembership() async {
    try {
      final response = await _dio.post('/api/membership/cancel');
      final data = response.data;
      if (data['code'] != 0) {
        throw DioException(
          requestOptions: response.requestOptions,
          message: data['message'] as String? ?? '取消失败',
        );
      }
    } on DioException catch (e) {
      debugPrint('取消会员失败: ${e.message}');
      rethrow;
    }
  }

  /// 获取会员历史记录
  Future<List<MembershipHistoryItem>> getMembershipHistory() async {
    try {
      final response = await _dio.get('/api/membership/history');
      final data = response.data;
      if (data['code'] == 0 && data['data'] != null) {
        return (data['data'] as List)
            .map((e) => MembershipHistoryItem.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    } on DioException catch (e) {
      debugPrint('获取会员历史失败: ${e.message}');
      rethrow;
    }
  }

  /// 提取错误信息（用于统一处理后端错误响应）
  static String extractErrorMessage(dynamic error) {
    if (error is DioException) {
      final data = error.response?.data;
      if (data is Map<String, dynamic>) {
        return data['message'] as String? ?? error.message ?? '网络请求失败';
      }
      return error.message ?? '网络请求失败';
    }
    return error.toString();
  }

  /// 判断是否是额度不足错误
  static bool isQuotaExhaustedError(dynamic error) {
    if (error is DioException) {
      final data = error.response?.data;
      if (data is Map<String, dynamic>) {
        final code = data['code'];
        return code == 42900 || code == 42901;
      }
    }
    return false;
  }
}
