//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'class_schedule_item_response.g.dart';

/// ClassScheduleItemResponse
///
/// Properties:
/// * [id]
/// * [settingId]
/// * [classId]
/// * [userId]
/// * [courseType]
/// * [courseTypeDesc]
/// * [courseName]
/// * [teacherName]
/// * [location]
/// * [courseId]
/// * [teacherId]
/// * [dayOfWeek]
/// * [startSection]
/// * [endSection]
/// * [startWeek]
/// * [endWeek]
/// * [weekType]
/// * [weekTypeDesc]
/// * [color]
/// * [remark]
/// * [createTime]
/// * [updateTime]
@BuiltValue()
abstract class ClassScheduleItemResponse
    implements
        Built<ClassScheduleItemResponse, ClassScheduleItemResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'settingId')
  String? get settingId;

  @BuiltValueField(wireName: r'classId')
  String? get classId;

  @BuiltValueField(wireName: r'userId')
  String? get userId;

  @BuiltValueField(wireName: r'courseType')
  int? get courseType;

  @BuiltValueField(wireName: r'courseTypeDesc')
  String? get courseTypeDesc;

  @BuiltValueField(wireName: r'courseName')
  String? get courseName;

  @BuiltValueField(wireName: r'teacherName')
  String? get teacherName;

  @BuiltValueField(wireName: r'location')
  String? get location;

  @BuiltValueField(wireName: r'courseId')
  String? get courseId;

  @BuiltValueField(wireName: r'teacherId')
  String? get teacherId;

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

  @BuiltValueField(wireName: r'weekTypeDesc')
  String? get weekTypeDesc;

  @BuiltValueField(wireName: r'color')
  String? get color;

  @BuiltValueField(wireName: r'remark')
  String? get remark;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  ClassScheduleItemResponse._();

  factory ClassScheduleItemResponse(
          [void updates(ClassScheduleItemResponseBuilder b)]) =
      _$ClassScheduleItemResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ClassScheduleItemResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ClassScheduleItemResponse> get serializer =>
      _$ClassScheduleItemResponseSerializer();
}

class _$ClassScheduleItemResponseSerializer
    implements PrimitiveSerializer<ClassScheduleItemResponse> {
  @override
  final Iterable<Type> types = const [
    ClassScheduleItemResponse,
    _$ClassScheduleItemResponse
  ];

  @override
  final String wireName = r'ClassScheduleItemResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ClassScheduleItemResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.settingId != null) {
      yield r'settingId';
      yield serializers.serialize(
        object.settingId,
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
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(String),
      );
    }
    if (object.courseType != null) {
      yield r'courseType';
      yield serializers.serialize(
        object.courseType,
        specifiedType: const FullType(int),
      );
    }
    if (object.courseTypeDesc != null) {
      yield r'courseTypeDesc';
      yield serializers.serialize(
        object.courseTypeDesc,
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
    if (object.location != null) {
      yield r'location';
      yield serializers.serialize(
        object.location,
        specifiedType: const FullType(String),
      );
    }
    if (object.courseId != null) {
      yield r'courseId';
      yield serializers.serialize(
        object.courseId,
        specifiedType: const FullType(String),
      );
    }
    if (object.teacherId != null) {
      yield r'teacherId';
      yield serializers.serialize(
        object.teacherId,
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
    if (object.weekTypeDesc != null) {
      yield r'weekTypeDesc';
      yield serializers.serialize(
        object.weekTypeDesc,
        specifiedType: const FullType(String),
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
    ClassScheduleItemResponse object, {
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
    required ClassScheduleItemResponseBuilder result,
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
        case r'settingId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.settingId = valueDes;
          break;
        case r'classId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.classId = valueDes;
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        case r'courseType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.courseType = valueDes;
          break;
        case r'courseTypeDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.courseTypeDesc = valueDes;
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
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.location = valueDes;
          break;
        case r'courseId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.courseId = valueDes;
          break;
        case r'teacherId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.teacherId = valueDes;
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
        case r'weekTypeDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.weekTypeDesc = valueDes;
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
  ClassScheduleItemResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ClassScheduleItemResponseBuilder();
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
