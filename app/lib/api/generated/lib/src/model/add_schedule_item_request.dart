//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'add_schedule_item_request.g.dart';

/// AddScheduleItemRequest
///
/// Properties:
/// * [settingId]
/// * [courseType]
/// * [dayOfWeek]
/// * [startSection]
/// * [endSection]
/// * [courseName]
/// * [teacherName]
/// * [courseId]
/// * [teacherId]
/// * [location]
/// * [startWeek]
/// * [endWeek]
/// * [weekType]
/// * [color]
/// * [remark]
@BuiltValue()
abstract class AddScheduleItemRequest
    implements Built<AddScheduleItemRequest, AddScheduleItemRequestBuilder> {
  @BuiltValueField(wireName: r'settingId')
  int get settingId;

  @BuiltValueField(wireName: r'courseType')
  int get courseType;

  @BuiltValueField(wireName: r'dayOfWeek')
  int get dayOfWeek;

  @BuiltValueField(wireName: r'startSection')
  int get startSection;

  @BuiltValueField(wireName: r'endSection')
  int get endSection;

  @BuiltValueField(wireName: r'courseName')
  String? get courseName;

  @BuiltValueField(wireName: r'teacherName')
  String? get teacherName;

  @BuiltValueField(wireName: r'courseId')
  int? get courseId;

  @BuiltValueField(wireName: r'teacherId')
  int? get teacherId;

  @BuiltValueField(wireName: r'location')
  String? get location;

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

  AddScheduleItemRequest._();

  factory AddScheduleItemRequest(
          [void updates(AddScheduleItemRequestBuilder b)]) =
      _$AddScheduleItemRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AddScheduleItemRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AddScheduleItemRequest> get serializer =>
      _$AddScheduleItemRequestSerializer();
}

class _$AddScheduleItemRequestSerializer
    implements PrimitiveSerializer<AddScheduleItemRequest> {
  @override
  final Iterable<Type> types = const [
    AddScheduleItemRequest,
    _$AddScheduleItemRequest
  ];

  @override
  final String wireName = r'AddScheduleItemRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AddScheduleItemRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'settingId';
    yield serializers.serialize(
      object.settingId,
      specifiedType: const FullType(int),
    );
    yield r'courseType';
    yield serializers.serialize(
      object.courseType,
      specifiedType: const FullType(int),
    );
    yield r'dayOfWeek';
    yield serializers.serialize(
      object.dayOfWeek,
      specifiedType: const FullType(int),
    );
    yield r'startSection';
    yield serializers.serialize(
      object.startSection,
      specifiedType: const FullType(int),
    );
    yield r'endSection';
    yield serializers.serialize(
      object.endSection,
      specifiedType: const FullType(int),
    );
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
    if (object.courseId != null) {
      yield r'courseId';
      yield serializers.serialize(
        object.courseId,
        specifiedType: const FullType(int),
      );
    }
    if (object.teacherId != null) {
      yield r'teacherId';
      yield serializers.serialize(
        object.teacherId,
        specifiedType: const FullType(int),
      );
    }
    if (object.location != null) {
      yield r'location';
      yield serializers.serialize(
        object.location,
        specifiedType: const FullType(String),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    AddScheduleItemRequest object, {
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
    required AddScheduleItemRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'settingId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.settingId = valueDes;
          break;
        case r'courseType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.courseType = valueDes;
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
        case r'courseId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.courseId = valueDes;
          break;
        case r'teacherId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.teacherId = valueDes;
          break;
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.location = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AddScheduleItemRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AddScheduleItemRequestBuilder();
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
