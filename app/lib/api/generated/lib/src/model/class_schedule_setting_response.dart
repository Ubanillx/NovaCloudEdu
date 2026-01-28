//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/date.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/time_config_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'class_schedule_setting_response.g.dart';

/// ClassScheduleSettingResponse
///
/// Properties:
/// * [id]
/// * [classId]
/// * [semester]
/// * [startDate]
/// * [totalWeeks]
/// * [daysPerWeek]
/// * [sectionsPerDay]
/// * [timeConfig]
/// * [isActive]
/// * [createTime]
/// * [updateTime]
@BuiltValue()
abstract class ClassScheduleSettingResponse
    implements
        Built<ClassScheduleSettingResponse,
            ClassScheduleSettingResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'classId')
  String? get classId;

  @BuiltValueField(wireName: r'semester')
  String? get semester;

  @BuiltValueField(wireName: r'startDate')
  Date? get startDate;

  @BuiltValueField(wireName: r'totalWeeks')
  int? get totalWeeks;

  @BuiltValueField(wireName: r'daysPerWeek')
  int? get daysPerWeek;

  @BuiltValueField(wireName: r'sectionsPerDay')
  int? get sectionsPerDay;

  @BuiltValueField(wireName: r'timeConfig')
  BuiltList<TimeConfigItem>? get timeConfig;

  @BuiltValueField(wireName: r'isActive')
  bool? get isActive;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  ClassScheduleSettingResponse._();

  factory ClassScheduleSettingResponse(
          [void updates(ClassScheduleSettingResponseBuilder b)]) =
      _$ClassScheduleSettingResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ClassScheduleSettingResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ClassScheduleSettingResponse> get serializer =>
      _$ClassScheduleSettingResponseSerializer();
}

class _$ClassScheduleSettingResponseSerializer
    implements PrimitiveSerializer<ClassScheduleSettingResponse> {
  @override
  final Iterable<Type> types = const [
    ClassScheduleSettingResponse,
    _$ClassScheduleSettingResponse
  ];

  @override
  final String wireName = r'ClassScheduleSettingResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ClassScheduleSettingResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.classId != null) {
      yield r'classId';
      yield serializers.serialize(
        object.classId,
        specifiedType: const FullType(String),
      );
    }
    if (object.semester != null) {
      yield r'semester';
      yield serializers.serialize(
        object.semester,
        specifiedType: const FullType(String),
      );
    }
    if (object.startDate != null) {
      yield r'startDate';
      yield serializers.serialize(
        object.startDate,
        specifiedType: const FullType(Date),
      );
    }
    if (object.totalWeeks != null) {
      yield r'totalWeeks';
      yield serializers.serialize(
        object.totalWeeks,
        specifiedType: const FullType(int),
      );
    }
    if (object.daysPerWeek != null) {
      yield r'daysPerWeek';
      yield serializers.serialize(
        object.daysPerWeek,
        specifiedType: const FullType(int),
      );
    }
    if (object.sectionsPerDay != null) {
      yield r'sectionsPerDay';
      yield serializers.serialize(
        object.sectionsPerDay,
        specifiedType: const FullType(int),
      );
    }
    if (object.timeConfig != null) {
      yield r'timeConfig';
      yield serializers.serialize(
        object.timeConfig,
        specifiedType: const FullType(BuiltList, [FullType(TimeConfigItem)]),
      );
    }
    if (object.isActive != null) {
      yield r'isActive';
      yield serializers.serialize(
        object.isActive,
        specifiedType: const FullType(bool),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    ClassScheduleSettingResponse object, {
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
    required ClassScheduleSettingResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'classId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.classId = valueDes;
          break;
        case r'semester':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.semester = valueDes;
          break;
        case r'startDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.startDate = valueDes;
          break;
        case r'totalWeeks':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalWeeks = valueDes;
          break;
        case r'daysPerWeek':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.daysPerWeek = valueDes;
          break;
        case r'sectionsPerDay':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sectionsPerDay = valueDes;
          break;
        case r'timeConfig':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(TimeConfigItem)]),
          ) as BuiltList<TimeConfigItem>;
          result.timeConfig.replace(valueDes);
          break;
        case r'isActive':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ClassScheduleSettingResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ClassScheduleSettingResponseBuilder();
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
