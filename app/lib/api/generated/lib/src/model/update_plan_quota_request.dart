//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_plan_quota_request.g.dart';

/// 修改计划AI配额请求
///
/// Properties:
/// * [aiChatDailyLimit] - AI对话每日限额，-1表示无限制
/// * [aiChatMonthlyLimit] - AI对话每月限额，-1表示无限制
/// * [aiPptDailyLimit] - PPT生成每日限额，-1表示无限制
/// * [aiPptMonthlyLimit] - PPT生成每月限额，-1表示无限制
/// * [aiExamDailyLimit] - AI出题每日限额，-1表示无限制
/// * [aiExamMonthlyLimit] - AI出题每月限额，-1表示无限制
/// * [aiBookDailyLimit] - 电子书AI每日限额，-1表示无限制
/// * [aiBookMonthlyLimit] - 电子书AI每月限额，-1表示无限制
/// * [aiGradingDailyLimit] - 智能批改每日限额，-1表示无限制
/// * [aiGradingMonthlyLimit] - 智能批改每月限额，-1表示无限制
@BuiltValue()
abstract class UpdatePlanQuotaRequest
    implements Built<UpdatePlanQuotaRequest, UpdatePlanQuotaRequestBuilder> {
  /// AI对话每日限额，-1表示无限制
  @BuiltValueField(wireName: r'aiChatDailyLimit')
  int? get aiChatDailyLimit;

  /// AI对话每月限额，-1表示无限制
  @BuiltValueField(wireName: r'aiChatMonthlyLimit')
  int? get aiChatMonthlyLimit;

  /// PPT生成每日限额，-1表示无限制
  @BuiltValueField(wireName: r'aiPptDailyLimit')
  int? get aiPptDailyLimit;

  /// PPT生成每月限额，-1表示无限制
  @BuiltValueField(wireName: r'aiPptMonthlyLimit')
  int? get aiPptMonthlyLimit;

  /// AI出题每日限额，-1表示无限制
  @BuiltValueField(wireName: r'aiExamDailyLimit')
  int? get aiExamDailyLimit;

  /// AI出题每月限额，-1表示无限制
  @BuiltValueField(wireName: r'aiExamMonthlyLimit')
  int? get aiExamMonthlyLimit;

  /// 电子书AI每日限额，-1表示无限制
  @BuiltValueField(wireName: r'aiBookDailyLimit')
  int? get aiBookDailyLimit;

  /// 电子书AI每月限额，-1表示无限制
  @BuiltValueField(wireName: r'aiBookMonthlyLimit')
  int? get aiBookMonthlyLimit;

  /// 智能批改每日限额，-1表示无限制
  @BuiltValueField(wireName: r'aiGradingDailyLimit')
  int? get aiGradingDailyLimit;

  /// 智能批改每月限额，-1表示无限制
  @BuiltValueField(wireName: r'aiGradingMonthlyLimit')
  int? get aiGradingMonthlyLimit;

  UpdatePlanQuotaRequest._();

  factory UpdatePlanQuotaRequest(
          [void updates(UpdatePlanQuotaRequestBuilder b)]) =
      _$UpdatePlanQuotaRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdatePlanQuotaRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdatePlanQuotaRequest> get serializer =>
      _$UpdatePlanQuotaRequestSerializer();
}

class _$UpdatePlanQuotaRequestSerializer
    implements PrimitiveSerializer<UpdatePlanQuotaRequest> {
  @override
  final Iterable<Type> types = const [
    UpdatePlanQuotaRequest,
    _$UpdatePlanQuotaRequest
  ];

  @override
  final String wireName = r'UpdatePlanQuotaRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdatePlanQuotaRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdatePlanQuotaRequest object, {
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
    required UpdatePlanQuotaRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdatePlanQuotaRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdatePlanQuotaRequestBuilder();
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
