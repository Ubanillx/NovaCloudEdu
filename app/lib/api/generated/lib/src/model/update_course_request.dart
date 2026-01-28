//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_course_request.g.dart';

/// 更新课程请求
///
/// Properties:
/// * [title] - 课程标题
/// * [courseType] - 课程类型：0-公开课，1-付费课，2-会员课
/// * [difficulty] - 难度等级：1-入门，2-初级，3-中级，4-高级，5-专家
/// * [subtitle] - 课程副标题
/// * [description] - 课程描述
/// * [coverImage] - 封面图片URL
/// * [price] - 课程价格
/// * [tags] - 标签列表
@BuiltValue()
abstract class UpdateCourseRequest
    implements Built<UpdateCourseRequest, UpdateCourseRequestBuilder> {
  /// 课程标题
  @BuiltValueField(wireName: r'title')
  String get title;

  /// 课程类型：0-公开课，1-付费课，2-会员课
  @BuiltValueField(wireName: r'courseType')
  int get courseType;

  /// 难度等级：1-入门，2-初级，3-中级，4-高级，5-专家
  @BuiltValueField(wireName: r'difficulty')
  int get difficulty;

  /// 课程副标题
  @BuiltValueField(wireName: r'subtitle')
  String? get subtitle;

  /// 课程描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  /// 封面图片URL
  @BuiltValueField(wireName: r'coverImage')
  String? get coverImage;

  /// 课程价格
  @BuiltValueField(wireName: r'price')
  num? get price;

  /// 标签列表
  @BuiltValueField(wireName: r'tags')
  BuiltList<String>? get tags;

  UpdateCourseRequest._();

  factory UpdateCourseRequest([void updates(UpdateCourseRequestBuilder b)]) =
      _$UpdateCourseRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateCourseRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateCourseRequest> get serializer =>
      _$UpdateCourseRequestSerializer();
}

class _$UpdateCourseRequestSerializer
    implements PrimitiveSerializer<UpdateCourseRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateCourseRequest,
    _$UpdateCourseRequest
  ];

  @override
  final String wireName = r'UpdateCourseRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateCourseRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'courseType';
    yield serializers.serialize(
      object.courseType,
      specifiedType: const FullType(int),
    );
    yield r'difficulty';
    yield serializers.serialize(
      object.difficulty,
      specifiedType: const FullType(int),
    );
    if (object.subtitle != null) {
      yield r'subtitle';
      yield serializers.serialize(
        object.subtitle,
        specifiedType: const FullType(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.coverImage != null) {
      yield r'coverImage';
      yield serializers.serialize(
        object.coverImage,
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
    if (object.tags != null) {
      yield r'tags';
      yield serializers.serialize(
        object.tags,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateCourseRequest object, {
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
    required UpdateCourseRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'courseType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.courseType = valueDes;
          break;
        case r'difficulty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.difficulty = valueDes;
          break;
        case r'subtitle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subtitle = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'coverImage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.coverImage = valueDes;
          break;
        case r'price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.price = valueDes;
          break;
        case r'tags':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.tags.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateCourseRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateCourseRequestBuilder();
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
