//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'membership_plan.g.dart';

/// MembershipPlan
///
/// Properties:
/// * [id]
/// * [name]
/// * [code]
/// * [description]
/// * [price]
/// * [durationDays]
/// * [aiChatDailyLimit]
/// * [aiChatMonthlyLimit]
/// * [aiPptDailyLimit]
/// * [aiPptMonthlyLimit]
/// * [aiExamDailyLimit]
/// * [aiExamMonthlyLimit]
/// * [aiBookDailyLimit]
/// * [aiBookMonthlyLimit]
/// * [aiGradingDailyLimit]
/// * [aiGradingMonthlyLimit]
/// * [courseMemberAccess]
/// * [sortOrder]
/// * [createTime]
/// * [updateTime]
/// * [delete]
/// * [default_]
@BuiltValue()
abstract class MembershipPlan
    implements Built<MembershipPlan, MembershipPlanBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'code')
  MembershipPlanCodeEnum? get code;
  // enum codeEnum {  FREE,  BASIC,  PRO,  TEACHER,  };

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'price')
  num? get price;

  @BuiltValueField(wireName: r'durationDays')
  int? get durationDays;

  @BuiltValueField(wireName: r'aiChatDailyLimit')
  int? get aiChatDailyLimit;

  @BuiltValueField(wireName: r'aiChatMonthlyLimit')
  int? get aiChatMonthlyLimit;

  @BuiltValueField(wireName: r'aiPptDailyLimit')
  int? get aiPptDailyLimit;

  @BuiltValueField(wireName: r'aiPptMonthlyLimit')
  int? get aiPptMonthlyLimit;

  @BuiltValueField(wireName: r'aiExamDailyLimit')
  int? get aiExamDailyLimit;

  @BuiltValueField(wireName: r'aiExamMonthlyLimit')
  int? get aiExamMonthlyLimit;

  @BuiltValueField(wireName: r'aiBookDailyLimit')
  int? get aiBookDailyLimit;

  @BuiltValueField(wireName: r'aiBookMonthlyLimit')
  int? get aiBookMonthlyLimit;

  @BuiltValueField(wireName: r'aiGradingDailyLimit')
  int? get aiGradingDailyLimit;

  @BuiltValueField(wireName: r'aiGradingMonthlyLimit')
  int? get aiGradingMonthlyLimit;

  @BuiltValueField(wireName: r'courseMemberAccess')
  bool? get courseMemberAccess;

  @BuiltValueField(wireName: r'sortOrder')
  int? get sortOrder;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  @BuiltValueField(wireName: r'delete')
  bool? get delete;

  @BuiltValueField(wireName: r'default')
  bool? get default_;

  MembershipPlan._();

  factory MembershipPlan([void updates(MembershipPlanBuilder b)]) =
      _$MembershipPlan;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MembershipPlanBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MembershipPlan> get serializer =>
      _$MembershipPlanSerializer();
}

class _$MembershipPlanSerializer
    implements PrimitiveSerializer<MembershipPlan> {
  @override
  final Iterable<Type> types = const [MembershipPlan, _$MembershipPlan];

  @override
  final String wireName = r'MembershipPlan';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MembershipPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(MembershipPlanCodeEnum),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.price != null) {
      yield r'price';
      yield serializers.serialize(
        object.price,
        specifiedType: const FullType(num),
      );
    }
    if (object.durationDays != null) {
      yield r'durationDays';
      yield serializers.serialize(
        object.durationDays,
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
    if (object.sortOrder != null) {
      yield r'sortOrder';
      yield serializers.serialize(
        object.sortOrder,
        specifiedType: const FullType(int),
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
    if (object.delete != null) {
      yield r'delete';
      yield serializers.serialize(
        object.delete,
        specifiedType: const FullType(bool),
      );
    }
    if (object.default_ != null) {
      yield r'default';
      yield serializers.serialize(
        object.default_,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MembershipPlan object, {
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
    required MembershipPlanBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MembershipPlanCodeEnum),
          ) as MembershipPlanCodeEnum;
          result.code = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.price = valueDes;
          break;
        case r'durationDays':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.durationDays = valueDes;
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
        case r'sortOrder':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sortOrder = valueDes;
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
        case r'delete':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.delete = valueDes;
          break;
        case r'default':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.default_ = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MembershipPlan deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MembershipPlanBuilder();
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

class MembershipPlanCodeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'FREE')
  static const MembershipPlanCodeEnum FREE = _$membershipPlanCodeEnum_FREE;
  @BuiltValueEnumConst(wireName: r'BASIC')
  static const MembershipPlanCodeEnum BASIC = _$membershipPlanCodeEnum_BASIC;
  @BuiltValueEnumConst(wireName: r'PRO')
  static const MembershipPlanCodeEnum PRO = _$membershipPlanCodeEnum_PRO;
  @BuiltValueEnumConst(wireName: r'TEACHER')
  static const MembershipPlanCodeEnum TEACHER =
      _$membershipPlanCodeEnum_TEACHER;

  static Serializer<MembershipPlanCodeEnum> get serializer =>
      _$membershipPlanCodeEnumSerializer;

  const MembershipPlanCodeEnum._(String name) : super(name);

  static BuiltSet<MembershipPlanCodeEnum> get values =>
      _$membershipPlanCodeEnumValues;
  static MembershipPlanCodeEnum valueOf(String name) =>
      _$membershipPlanCodeEnumValueOf(name);
}
