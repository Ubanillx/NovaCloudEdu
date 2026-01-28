//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'add_class_course_request.g.dart';

/// 添加班级课程请求
///
/// Properties:
/// * [courseId] - 课程ID
@BuiltValue()
abstract class AddClassCourseRequest
    implements Built<AddClassCourseRequest, AddClassCourseRequestBuilder> {
  /// 课程ID
  @BuiltValueField(wireName: r'courseId')
  int get courseId;

  AddClassCourseRequest._();

  factory AddClassCourseRequest(
      [void updates(AddClassCourseRequestBuilder b)]) = _$AddClassCourseRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AddClassCourseRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AddClassCourseRequest> get serializer =>
      _$AddClassCourseRequestSerializer();
}

class _$AddClassCourseRequestSerializer
    implements PrimitiveSerializer<AddClassCourseRequest> {
  @override
  final Iterable<Type> types = const [
    AddClassCourseRequest,
    _$AddClassCourseRequest
  ];

  @override
  final String wireName = r'AddClassCourseRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AddClassCourseRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'courseId';
    yield serializers.serialize(
      object.courseId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AddClassCourseRequest object, {
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
    required AddClassCourseRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'courseId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.courseId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AddClassCourseRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AddClassCourseRequestBuilder();
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
