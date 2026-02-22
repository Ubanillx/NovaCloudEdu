//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_membership_detail_response.g.dart';

/// 用户会员详情响应
///
/// Properties:
/// * [id] - 会员ID
/// * [userId] - 用户ID
/// * [planId] - 计划ID
/// * [orderNo] - 订单号
/// * [startTime] - 开始时间
/// * [expireTime] - 过期时间
/// * [status] - 会员状态
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
/// * [planName] - 计划名称
/// * [planCode] - 计划编码
/// * [planDescription] - 计划描述
/// * [planPrice] - 计划价格
/// * [planDurationDays] - 计划时长（天）
/// * [aiChatDailyLimit] - AI聊天每日限额
/// * [aiChatMonthlyLimit] - AI聊天每月限额
/// * [aiPptDailyLimit] - AI PPT每日限额
/// * [aiPptMonthlyLimit] - AI PPT每月限额
/// * [aiExamDailyLimit] - AI组卷每日限额
/// * [aiExamMonthlyLimit] - AI组卷每月限额
/// * [aiBookDailyLimit] - AI电子书每日限额
/// * [aiBookMonthlyLimit] - AI电子书每月限额
/// * [aiGradingDailyLimit] - AI智能批改每日限额
/// * [aiGradingMonthlyLimit] - AI智能批改每月限额
/// * [courseMemberAccess] - 是否有课程会员访问权限
/// * [aiChatDailyRemaining] - AI聊天今日剩余
/// * [aiChatMonthlyRemaining] - AI聊天本月剩余
/// * [aiPptDailyRemaining] - AI PPT今日剩余
/// * [aiPptMonthlyRemaining] - AI PPT本月剩余
/// * [aiExamDailyRemaining] - AI组卷今日剩余
/// * [aiExamMonthlyRemaining] - AI组卷本月剩余
/// * [aiBookDailyRemaining] - AI电子书今日剩余
/// * [aiBookMonthlyRemaining] - AI电子书本月剩余
/// * [aiGradingDailyRemaining] - AI智能批改今日剩余
/// * [aiGradingMonthlyRemaining] - AI智能批改本月剩余
@BuiltValue()
abstract class UserMembershipDetailResponse
    implements
        Built<UserMembershipDetailResponse,
            UserMembershipDetailResponseBuilder> {
  /// 会员ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 用户ID
  @BuiltValueField(wireName: r'userId')
  int? get userId;

  /// 计划ID
  @BuiltValueField(wireName: r'planId')
  int? get planId;

  /// 订单号
  @BuiltValueField(wireName: r'orderNo')
  String? get orderNo;

  /// 开始时间
  @BuiltValueField(wireName: r'startTime')
  DateTime? get startTime;

  /// 过期时间
  @BuiltValueField(wireName: r'expireTime')
  DateTime? get expireTime;

  /// 会员状态
  @BuiltValueField(wireName: r'status')
  String? get status;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  /// 计划名称
  @BuiltValueField(wireName: r'planName')
  String? get planName;

  /// 计划编码
  @BuiltValueField(wireName: r'planCode')
  String? get planCode;

  /// 计划描述
  @BuiltValueField(wireName: r'planDescription')
  String? get planDescription;

  /// 计划价格
  @BuiltValueField(wireName: r'planPrice')
  num? get planPrice;

  /// 计划时长（天）
  @BuiltValueField(wireName: r'planDurationDays')
  int? get planDurationDays;

  /// AI聊天每日限额
  @BuiltValueField(wireName: r'aiChatDailyLimit')
  int? get aiChatDailyLimit;

  /// AI聊天每月限额
  @BuiltValueField(wireName: r'aiChatMonthlyLimit')
  int? get aiChatMonthlyLimit;

  /// AI PPT每日限额
  @BuiltValueField(wireName: r'aiPptDailyLimit')
  int? get aiPptDailyLimit;

  /// AI PPT每月限额
  @BuiltValueField(wireName: r'aiPptMonthlyLimit')
  int? get aiPptMonthlyLimit;

  /// AI组卷每日限额
  @BuiltValueField(wireName: r'aiExamDailyLimit')
  int? get aiExamDailyLimit;

  /// AI组卷每月限额
  @BuiltValueField(wireName: r'aiExamMonthlyLimit')
  int? get aiExamMonthlyLimit;

  /// AI电子书每日限额
  @BuiltValueField(wireName: r'aiBookDailyLimit')
  int? get aiBookDailyLimit;

  /// AI电子书每月限额
  @BuiltValueField(wireName: r'aiBookMonthlyLimit')
  int? get aiBookMonthlyLimit;

  /// AI智能批改每日限额
  @BuiltValueField(wireName: r'aiGradingDailyLimit')
  int? get aiGradingDailyLimit;

  /// AI智能批改每月限额
  @BuiltValueField(wireName: r'aiGradingMonthlyLimit')
  int? get aiGradingMonthlyLimit;

  /// 是否有课程会员访问权限
  @BuiltValueField(wireName: r'courseMemberAccess')
  bool? get courseMemberAccess;

  /// AI聊天今日剩余
  @BuiltValueField(wireName: r'aiChatDailyRemaining')
  int? get aiChatDailyRemaining;

  /// AI聊天本月剩余
  @BuiltValueField(wireName: r'aiChatMonthlyRemaining')
  int? get aiChatMonthlyRemaining;

  /// AI PPT今日剩余
  @BuiltValueField(wireName: r'aiPptDailyRemaining')
  int? get aiPptDailyRemaining;

  /// AI PPT本月剩余
  @BuiltValueField(wireName: r'aiPptMonthlyRemaining')
  int? get aiPptMonthlyRemaining;

  /// AI组卷今日剩余
  @BuiltValueField(wireName: r'aiExamDailyRemaining')
  int? get aiExamDailyRemaining;

  /// AI组卷本月剩余
  @BuiltValueField(wireName: r'aiExamMonthlyRemaining')
  int? get aiExamMonthlyRemaining;

  /// AI电子书今日剩余
  @BuiltValueField(wireName: r'aiBookDailyRemaining')
  int? get aiBookDailyRemaining;

  /// AI电子书本月剩余
  @BuiltValueField(wireName: r'aiBookMonthlyRemaining')
  int? get aiBookMonthlyRemaining;

  /// AI智能批改今日剩余
  @BuiltValueField(wireName: r'aiGradingDailyRemaining')
  int? get aiGradingDailyRemaining;

  /// AI智能批改本月剩余
  @BuiltValueField(wireName: r'aiGradingMonthlyRemaining')
  int? get aiGradingMonthlyRemaining;

  UserMembershipDetailResponse._();

  factory UserMembershipDetailResponse(
          [void updates(UserMembershipDetailResponseBuilder b)]) =
      _$UserMembershipDetailResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserMembershipDetailResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserMembershipDetailResponse> get serializer =>
      _$UserMembershipDetailResponseSerializer();
}

class _$UserMembershipDetailResponseSerializer
    implements PrimitiveSerializer<UserMembershipDetailResponse> {
  @override
  final Iterable<Type> types = const [
    UserMembershipDetailResponse,
    _$UserMembershipDetailResponse
  ];

  @override
  final String wireName = r'UserMembershipDetailResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserMembershipDetailResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(int),
      );
    }
    if (object.planId != null) {
      yield r'planId';
      yield serializers.serialize(
        object.planId,
        specifiedType: const FullType(int),
      );
    }
    if (object.orderNo != null) {
      yield r'orderNo';
      yield serializers.serialize(
        object.orderNo,
        specifiedType: const FullType(String),
      );
    }
    if (object.startTime != null) {
      yield r'startTime';
      yield serializers.serialize(
        object.startTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.expireTime != null) {
      yield r'expireTime';
      yield serializers.serialize(
        object.expireTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.updateTime != null) {
      yield r'updateTime';
      yield serializers.serialize(
        object.updateTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.planName != null) {
      yield r'planName';
      yield serializers.serialize(
        object.planName,
        specifiedType: const FullType(String),
      );
    }
    if (object.planCode != null) {
      yield r'planCode';
      yield serializers.serialize(
        object.planCode,
        specifiedType: const FullType(String),
      );
    }
    if (object.planDescription != null) {
      yield r'planDescription';
      yield serializers.serialize(
        object.planDescription,
        specifiedType: const FullType(String),
      );
    }
    if (object.planPrice != null) {
      yield r'planPrice';
      yield serializers.serialize(
        object.planPrice,
        specifiedType: const FullType(num),
      );
    }
    if (object.planDurationDays != null) {
      yield r'planDurationDays';
      yield serializers.serialize(
        object.planDurationDays,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiChatDailyLimit != null) {
      yield r'aiChatDailyLimit';
      yield serializers.serialize(
        object.aiChatDailyLimit,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiChatMonthlyLimit != null) {
      yield r'aiChatMonthlyLimit';
      yield serializers.serialize(
        object.aiChatMonthlyLimit,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiPptDailyLimit != null) {
      yield r'aiPptDailyLimit';
      yield serializers.serialize(
        object.aiPptDailyLimit,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiPptMonthlyLimit != null) {
      yield r'aiPptMonthlyLimit';
      yield serializers.serialize(
        object.aiPptMonthlyLimit,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiExamDailyLimit != null) {
      yield r'aiExamDailyLimit';
      yield serializers.serialize(
        object.aiExamDailyLimit,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiExamMonthlyLimit != null) {
      yield r'aiExamMonthlyLimit';
      yield serializers.serialize(
        object.aiExamMonthlyLimit,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiBookDailyLimit != null) {
      yield r'aiBookDailyLimit';
      yield serializers.serialize(
        object.aiBookDailyLimit,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiBookMonthlyLimit != null) {
      yield r'aiBookMonthlyLimit';
      yield serializers.serialize(
        object.aiBookMonthlyLimit,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiGradingDailyLimit != null) {
      yield r'aiGradingDailyLimit';
      yield serializers.serialize(
        object.aiGradingDailyLimit,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiGradingMonthlyLimit != null) {
      yield r'aiGradingMonthlyLimit';
      yield serializers.serialize(
        object.aiGradingMonthlyLimit,
        specifiedType: const FullType(int),
      );
    }
    if (object.courseMemberAccess != null) {
      yield r'courseMemberAccess';
      yield serializers.serialize(
        object.courseMemberAccess,
        specifiedType: const FullType(bool),
      );
    }
    if (object.aiChatDailyRemaining != null) {
      yield r'aiChatDailyRemaining';
      yield serializers.serialize(
        object.aiChatDailyRemaining,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiChatMonthlyRemaining != null) {
      yield r'aiChatMonthlyRemaining';
      yield serializers.serialize(
        object.aiChatMonthlyRemaining,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiPptDailyRemaining != null) {
      yield r'aiPptDailyRemaining';
      yield serializers.serialize(
        object.aiPptDailyRemaining,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiPptMonthlyRemaining != null) {
      yield r'aiPptMonthlyRemaining';
      yield serializers.serialize(
        object.aiPptMonthlyRemaining,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiExamDailyRemaining != null) {
      yield r'aiExamDailyRemaining';
      yield serializers.serialize(
        object.aiExamDailyRemaining,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiExamMonthlyRemaining != null) {
      yield r'aiExamMonthlyRemaining';
      yield serializers.serialize(
        object.aiExamMonthlyRemaining,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiBookDailyRemaining != null) {
      yield r'aiBookDailyRemaining';
      yield serializers.serialize(
        object.aiBookDailyRemaining,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiBookMonthlyRemaining != null) {
      yield r'aiBookMonthlyRemaining';
      yield serializers.serialize(
        object.aiBookMonthlyRemaining,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiGradingDailyRemaining != null) {
      yield r'aiGradingDailyRemaining';
      yield serializers.serialize(
        object.aiGradingDailyRemaining,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiGradingMonthlyRemaining != null) {
      yield r'aiGradingMonthlyRemaining';
      yield serializers.serialize(
        object.aiGradingMonthlyRemaining,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UserMembershipDetailResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserMembershipDetailResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'planId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.planId = valueDes;
          break;
        case r'orderNo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderNo = valueDes;
          break;
        case r'startTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startTime = valueDes;
          break;
        case r'expireTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expireTime = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        case r'updateTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updateTime = valueDes;
          break;
        case r'planName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.planName = valueDes;
          break;
        case r'planCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.planCode = valueDes;
          break;
        case r'planDescription':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.planDescription = valueDes;
          break;
        case r'planPrice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.planPrice = valueDes;
          break;
        case r'planDurationDays':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.planDurationDays = valueDes;
          break;
        case r'aiChatDailyLimit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiChatDailyLimit = valueDes;
          break;
        case r'aiChatMonthlyLimit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiChatMonthlyLimit = valueDes;
          break;
        case r'aiPptDailyLimit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiPptDailyLimit = valueDes;
          break;
        case r'aiPptMonthlyLimit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiPptMonthlyLimit = valueDes;
          break;
        case r'aiExamDailyLimit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiExamDailyLimit = valueDes;
          break;
        case r'aiExamMonthlyLimit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiExamMonthlyLimit = valueDes;
          break;
        case r'aiBookDailyLimit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiBookDailyLimit = valueDes;
          break;
        case r'aiBookMonthlyLimit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiBookMonthlyLimit = valueDes;
          break;
        case r'aiGradingDailyLimit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiGradingDailyLimit = valueDes;
          break;
        case r'aiGradingMonthlyLimit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiGradingMonthlyLimit = valueDes;
          break;
        case r'courseMemberAccess':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.courseMemberAccess = valueDes;
          break;
        case r'aiChatDailyRemaining':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiChatDailyRemaining = valueDes;
          break;
        case r'aiChatMonthlyRemaining':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiChatMonthlyRemaining = valueDes;
          break;
        case r'aiPptDailyRemaining':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiPptDailyRemaining = valueDes;
          break;
        case r'aiPptMonthlyRemaining':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiPptMonthlyRemaining = valueDes;
          break;
        case r'aiExamDailyRemaining':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiExamDailyRemaining = valueDes;
          break;
        case r'aiExamMonthlyRemaining':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiExamMonthlyRemaining = valueDes;
          break;
        case r'aiBookDailyRemaining':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiBookDailyRemaining = valueDes;
          break;
        case r'aiBookMonthlyRemaining':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiBookMonthlyRemaining = valueDes;
          break;
        case r'aiGradingDailyRemaining':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiGradingDailyRemaining = valueDes;
          break;
        case r'aiGradingMonthlyRemaining':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiGradingMonthlyRemaining = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserMembershipDetailResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserMembershipDetailResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
