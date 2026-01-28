//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_schedule_item_request.g.dart';

/// UpdateScheduleItemRequest
///
/// Properties:
/// * [location]
/// * [dayOfWeek]
/// * [startSection]
/// * [endSection]
/// * [startWeek]
/// * [endWeek]
/// * [weekType]
/// * [color]
/// * [remark]
/// * [courseName]
/// * [teacherName]
@BuiltValue()
abstract class UpdateScheduleItemRequest
    implements
        Built<UpdateScheduleItemRequest, UpdateScheduleItemRequestBuilder> {
  @BuiltValueField(wireName: r'location')
  String? get location;

  @BuiltValueField(wireName: r'dayOfWeek')
  int? get dayOfWeek;

  @BuiltValueField(wireName: r'startSection')
  int? get startSection;

  @BuiltValueField(wireName: r'endSection')
  int? get endSection;

  @BuiltValueField(wireName: r'startWeek')
  int? get startWeek;

  @BuiltValueField(wireName: r'endWeek')
  int? get endWeek;

  @BuiltValueField(wireName: r'weekType')
  int? get weekType;

  @BuiltValueField(wireName: r'color')
  String? get color;

  @BuiltValueField(wireName: r'remark')
  String? get remark;

  @BuiltValueField(wireName: r'courseName')
  String? get courseName;

  @BuiltValueField(wireName: r'teacherName')
  String? get teacherName;

  UpdateScheduleItemRequest._();

  factory UpdateScheduleItemRequest(
          [void updates(UpdateScheduleItemRequestBuilder b)]) =
      _$UpdateScheduleItemRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateScheduleItemRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateScheduleItemRequest> get serializer =>
      _$UpdateScheduleItemRequestSerializer();
}

class _$UpdateScheduleItemRequestSerializer
    implements PrimitiveSerializer<UpdateScheduleItemRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateScheduleItemRequest,
    _$UpdateScheduleItemRequest
  ];

  @override
  final String wireName = r'UpdateScheduleItemRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateScheduleItemRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.location != null) {
      yield r'location';
      yield serializers.serialize(
        object.location,
        specifiedType: const FullType(String),
      );
    }
    if (object.dayOfWeek != null) {
      yield r'dayOfWeek';
      yield serializers.serialize(
        object.dayOfWeek,
        specifiedType: const FullType(int),
      );
    }
    if (object.startSection != null) {
      yield r'startSection';
      yield serializers.serialize(
        object.startSection,
        specifiedType: const FullType(int),
      );
    }
    if (object.endSection != null) {
      yield r'endSection';
      yield serializers.serialize(
        object.endSection,
        specifiedType: const FullType(int),
      );
    }
    if (object.startWeek != null) {
      yield r'startWeek';
      yield serializers.serialize(
        object.startWeek,
        specifiedType: const FullType(int),
      );
    }
    if (object.endWeek != null) {
      yield r'endWeek';
      yield serializers.serialize(
        object.endWeek,
        specifiedType: const FullType(int),
      );
    }
    if (object.weekType != null) {
      yield r'weekType';
      yield serializers.serialize(
        object.weekType,
        specifiedType: const FullType(int),
      );
    }
    if (object.color != null) {
      yield r'color';
      yield serializers.serialize(
        object.color,
        specifiedType: const FullType(String),
      );
    }
    if (object.remark != null) {
      yield r'remark';
      yield serializers.serialize(
        object.remark,
        specifiedType: const FullType(String),
      );
    }
    if (object.courseName != null) {
      yield r'courseName';
      yield serializers.serialize(
        object.courseName,
        specifiedType: const FullType(String),
      );
    }
    if (object.teacherName != null) {
      yield r'teacherName';
      yield serializers.serialize(
        object.teacherName,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateScheduleItemRequest object, {
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
    required UpdateScheduleItemRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.location = valueDes;
          break;
        case r'dayOfWeek':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.dayOfWeek = valueDes;
          break;
        case r'startSection':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.startSection = valueDes;
          break;
        case r'endSection':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.endSection = valueDes;
          break;
        case r'startWeek':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.startWeek = valueDes;
          break;
        case r'endWeek':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.endWeek = valueDes;
          break;
        case r'weekType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.weekType = valueDes;
          break;
        case r'color':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.color = valueDes;
          break;
        case r'remark':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.remark = valueDes;
          break;
        case r'courseName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.courseName = valueDes;
          break;
        case r'teacherName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.teacherName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateScheduleItemRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateScheduleItemRequestBuilder();
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
