//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/section_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chapter_response.g.dart';

/// 章节信息响应
///
/// Properties:
/// * [id] - 章节ID
/// * [courseId] - 课程ID
/// * [title] - 章节标题
/// * [description] - 章节描述
/// * [sort] - 排序
/// * [sections] - 小节列表
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
@BuiltValue()
abstract class ChapterResponse
    implements Built<ChapterResponse, ChapterResponseBuilder> {
  /// 章节ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 课程ID
  @BuiltValueField(wireName: r'courseId')
  int? get courseId;

  /// 章节标题
  @BuiltValueField(wireName: r'title')
  String? get title;

  /// 章节描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  /// 排序
  @BuiltValueField(wireName: r'sort')
  int? get sort;

  /// 小节列表
  @BuiltValueField(wireName: r'sections')
  BuiltList<SectionResponse>? get sections;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  ChapterResponse._();

  factory ChapterResponse([void updates(ChapterResponseBuilder b)]) =
      _$ChapterResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChapterResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChapterResponse> get serializer =>
      _$ChapterResponseSerializer();
}

class _$ChapterResponseSerializer
    implements PrimitiveSerializer<ChapterResponse> {
  @override
  final Iterable<Type> types = const [ChapterResponse, _$ChapterResponse];

  @override
  final String wireName = r'ChapterResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChapterResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
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
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
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
    if (object.sort != null) {
      yield r'sort';
      yield serializers.serialize(
        object.sort,
        specifiedType: const FullType(int),
      );
    }
    if (object.sections != null) {
      yield r'sections';
      yield serializers.serialize(
        object.sections,
        specifiedType: const FullType(BuiltList, [FullType(SectionResponse)]),
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
    ChapterResponse object, {
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
    required ChapterResponseBuilder result,
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
        case r'courseId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.courseId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'sort':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sort = valueDes;
          break;
        case r'sections':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(SectionResponse)]),
          ) as BuiltList<SectionResponse>;
          result.sections.replace(valueDes);
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
  ChapterResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChapterResponseBuilder();
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
