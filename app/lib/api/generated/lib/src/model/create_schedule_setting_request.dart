//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/date.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/time_config_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_schedule_setting_request.g.dart';

/// CreateScheduleSettingRequest
///
/// Properties:
/// * [classId]
/// * [semester]
/// * [startDate]
/// * [totalWeeks]
/// * [daysPerWeek]
/// * [sectionsPerDay]
/// * [timeConfig]
@BuiltValue()
abstract class CreateScheduleSettingRequest
    implements
        Built<CreateScheduleSettingRequest,
            CreateScheduleSettingRequestBuilder> {
  @BuiltValueField(wireName: r'classId')
  int get classId;

  @BuiltValueField(wireName: r'semester')
  String get semester;

  @BuiltValueField(wireName: r'startDate')
  Date get startDate;

  @BuiltValueField(wireName: r'totalWeeks')
  int? get totalWeeks;

  @BuiltValueField(wireName: r'daysPerWeek')
  int? get daysPerWeek;

  @BuiltValueField(wireName: r'sectionsPerDay')
  int? get sectionsPerDay;

  @BuiltValueField(wireName: r'timeConfig')
  BuiltList<TimeConfigItem>? get timeConfig;

  CreateScheduleSettingRequest._();

  factory CreateScheduleSettingRequest(
          [void updates(CreateScheduleSettingRequestBuilder b)]) =
      _$CreateScheduleSettingRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateScheduleSettingRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateScheduleSettingRequest> get serializer =>
      _$CreateScheduleSettingRequestSerializer();
}

class _$CreateScheduleSettingRequestSerializer
    implements PrimitiveSerializer<CreateScheduleSettingRequest> {
  @override
  final Iterable<Type> types = const [
    CreateScheduleSettingRequest,
    _$CreateScheduleSettingRequest
  ];

  @override
  final String wireName = r'CreateScheduleSettingRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateScheduleSettingRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'classId';
    yield serializers.serialize(
      object.classId,
      specifiedType: const FullType(int),
    );
    yield r'semester';
    yield serializers.serialize(
      object.semester,
      specifiedType: const FullType(String),
    );
    yield r'startDate';
    yield serializers.serialize(
      object.startDate,
      specifiedType: const FullType(Date),
    );
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
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateScheduleSettingRequest object, {
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
    required CreateScheduleSettingRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'classId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateScheduleSettingRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateScheduleSettingRequestBuilder();
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
