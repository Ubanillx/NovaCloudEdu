//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_chapter_request.g.dart';

/// 创建章节请求
///
/// Properties:
/// * [title] - 章节标题
/// * [sort] - 排序，数字越小排序越靠前
/// * [description] - 章节描述
@BuiltValue()
abstract class CreateChapterRequest
    implements Built<CreateChapterRequest, CreateChapterRequestBuilder> {
  /// 章节标题
  @BuiltValueField(wireName: r'title')
  String get title;

  /// 排序，数字越小排序越靠前
  @BuiltValueField(wireName: r'sort')
  int get sort;

  /// 章节描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  CreateChapterRequest._();

  factory CreateChapterRequest([void updates(CreateChapterRequestBuilder b)]) =
      _$CreateChapterRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateChapterRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateChapterRequest> get serializer =>
      _$CreateChapterRequestSerializer();
}

class _$CreateChapterRequestSerializer
    implements PrimitiveSerializer<CreateChapterRequest> {
  @override
  final Iterable<Type> types = const [
    CreateChapterRequest,
    _$CreateChapterRequest
  ];

  @override
  final String wireName = r'CreateChapterRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateChapterRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'sort';
    yield serializers.serialize(
      object.sort,
      specifiedType: const FullType(int),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateChapterRequest object, {
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
    required CreateChapterRequestBuilder result,
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
        case r'sort':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sort = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateChapterRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateChapterRequestBuilder();
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
