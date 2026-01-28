//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'review_course_request.g.dart';

/// 评价课程请求
///
/// Properties:
/// * [rating] - 评分(1-5分)
@BuiltValue()
abstract class ReviewCourseRequest
    implements Built<ReviewCourseRequest, ReviewCourseRequestBuilder> {
  /// 评分(1-5分)
  @BuiltValueField(wireName: r'rating')
  int get rating;

  ReviewCourseRequest._();

  factory ReviewCourseRequest([void updates(ReviewCourseRequestBuilder b)]) =
      _$ReviewCourseRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReviewCourseRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReviewCourseRequest> get serializer =>
      _$ReviewCourseRequestSerializer();
}

class _$ReviewCourseRequestSerializer
    implements PrimitiveSerializer<ReviewCourseRequest> {
  @override
  final Iterable<Type> types = const [
    ReviewCourseRequest,
    _$ReviewCourseRequest
  ];

  @override
  final String wireName = r'ReviewCourseRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReviewCourseRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rating';
    yield serializers.serialize(
      object.rating,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ReviewCourseRequest object, {
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
    required ReviewCourseRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.rating = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReviewCourseRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReviewCourseRequestBuilder();
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
