//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'course_review_response.g.dart';

/// 课程评价响应
///
/// Properties:
/// * [id] - 评价ID
/// * [userId] - 用户ID
/// * [courseId] - 课程ID
/// * [rating] - 评分(1-5分)
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
@BuiltValue()
abstract class CourseReviewResponse
    implements Built<CourseReviewResponse, CourseReviewResponseBuilder> {
  /// 评价ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 用户ID
  @BuiltValueField(wireName: r'userId')
  int? get userId;

  /// 课程ID
  @BuiltValueField(wireName: r'courseId')
  int? get courseId;

  /// 评分(1-5分)
  @BuiltValueField(wireName: r'rating')
  int? get rating;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  CourseReviewResponse._();

  factory CourseReviewResponse([void updates(CourseReviewResponseBuilder b)]) =
      _$CourseReviewResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CourseReviewResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CourseReviewResponse> get serializer =>
      _$CourseReviewResponseSerializer();
}

class _$CourseReviewResponseSerializer
    implements PrimitiveSerializer<CourseReviewResponse> {
  @override
  final Iterable<Type> types = const [
    CourseReviewResponse,
    _$CourseReviewResponse
  ];

  @override
  final String wireName = r'CourseReviewResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CourseReviewResponse object, {
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
    if (object.courseId != null) {
      yield r'courseId';
      yield serializers.serialize(
        object.courseId,
        specifiedType: const FullType(int),
      );
    }
    if (object.rating != null) {
      yield r'rating';
      yield serializers.serialize(
        object.rating,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    CourseReviewResponse object, {
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
    required CourseReviewResponseBuilder result,
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
        case r'courseId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.courseId = valueDes;
          break;
        case r'rating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.rating = valueDes;
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
  CourseReviewResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CourseReviewResponseBuilder();
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
