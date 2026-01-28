//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_chapter_request.g.dart';

/// 更新章节请求
///
/// Properties:
/// * [title] - 章节标题
/// * [sort] - 排序，数字越小排序越靠前
/// * [description] - 章节描述
@BuiltValue()
abstract class UpdateChapterRequest
    implements Built<UpdateChapterRequest, UpdateChapterRequestBuilder> {
  /// 章节标题
  @BuiltValueField(wireName: r'title')
  String get title;

  /// 排序，数字越小排序越靠前
  @BuiltValueField(wireName: r'sort')
  int get sort;

  /// 章节描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  UpdateChapterRequest._();

  factory UpdateChapterRequest([void updates(UpdateChapterRequestBuilder b)]) =
      _$UpdateChapterRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateChapterRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateChapterRequest> get serializer =>
      _$UpdateChapterRequestSerializer();
}

class _$UpdateChapterRequestSerializer
    implements PrimitiveSerializer<UpdateChapterRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateChapterRequest,
    _$UpdateChapterRequest
  ];

  @override
  final String wireName = r'UpdateChapterRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateChapterRequest object, {
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
    UpdateChapterRequest object, {
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
    required UpdateChapterRequestBuilder result,
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
  UpdateChapterRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateChapterRequestBuilder();
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
