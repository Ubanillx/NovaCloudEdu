//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/course_response.dart';
import 'package:nova_api/src/model/chapter_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'course_structure_response.g.dart';

/// 课程结构响应
///
/// Properties:
/// * [course]
/// * [chapters] - 章节列表（包含小节）
/// * [hasAccess] - 当前用户是否有权访问付费内容
/// * [purchased] - 当前用户是否已购买此课程（有有效订单）
@BuiltValue()
abstract class CourseStructureResponse
    implements Built<CourseStructureResponse, CourseStructureResponseBuilder> {
  @BuiltValueField(wireName: r'course')
  CourseResponse? get course;

  /// 章节列表（包含小节）
  @BuiltValueField(wireName: r'chapters')
  BuiltList<ChapterResponse>? get chapters;

  /// 当前用户是否有权访问付费内容
  @BuiltValueField(wireName: r'hasAccess')
  bool? get hasAccess;

  /// 当前用户是否已购买此课程（有有效订单）
  @BuiltValueField(wireName: r'purchased')
  bool? get purchased;

  CourseStructureResponse._();

  factory CourseStructureResponse(
          [void updates(CourseStructureResponseBuilder b)]) =
      _$CourseStructureResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CourseStructureResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CourseStructureResponse> get serializer =>
      _$CourseStructureResponseSerializer();
}

class _$CourseStructureResponseSerializer
    implements PrimitiveSerializer<CourseStructureResponse> {
  @override
  final Iterable<Type> types = const [
    CourseStructureResponse,
    _$CourseStructureResponse
  ];

  @override
  final String wireName = r'CourseStructureResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CourseStructureResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.course != null) {
      yield r'course';
      yield serializers.serialize(
        object.course,
        specifiedType: const FullType(CourseResponse),
      );
    }
    if (object.chapters != null) {
      yield r'chapters';
      yield serializers.serialize(
        object.chapters,
        specifiedType: const FullType(BuiltList, [FullType(ChapterResponse)]),
      );
    }
    if (object.hasAccess != null) {
      yield r'hasAccess';
      yield serializers.serialize(
        object.hasAccess,
        specifiedType: const FullType(bool),
      );
    }
    if (object.purchased != null) {
      yield r'purchased';
      yield serializers.serialize(
        object.purchased,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CourseStructureResponse object, {
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
    required CourseStructureResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'course':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CourseResponse),
          ) as CourseResponse;
          result.course.replace(valueDes);
          break;
        case r'chapters':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(ChapterResponse)]),
          ) as BuiltList<ChapterResponse>;
          result.chapters.replace(valueDes);
          break;
        case r'hasAccess':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasAccess = valueDes;
          break;
        case r'purchased':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.purchased = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CourseStructureResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CourseStructureResponseBuilder();
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
