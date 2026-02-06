//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'preview_ai_process_request.g.dart';

/// 预览 AI 处理结果请求
///
/// Properties:
/// * [content] - 文章内容
/// * [title] - 文章标题（可选，用于上下文）
@BuiltValue()
abstract class PreviewAiProcessRequest
    implements Built<PreviewAiProcessRequest, PreviewAiProcessRequestBuilder> {
  /// 文章内容
  @BuiltValueField(wireName: r'content')
  String get content;

  /// 文章标题（可选，用于上下文）
  @BuiltValueField(wireName: r'title')
  String? get title;

  PreviewAiProcessRequest._();

  factory PreviewAiProcessRequest(
          [void updates(PreviewAiProcessRequestBuilder b)]) =
      _$PreviewAiProcessRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PreviewAiProcessRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PreviewAiProcessRequest> get serializer =>
      _$PreviewAiProcessRequestSerializer();
}

class _$PreviewAiProcessRequestSerializer
    implements PrimitiveSerializer<PreviewAiProcessRequest> {
  @override
  final Iterable<Type> types = const [
    PreviewAiProcessRequest,
    _$PreviewAiProcessRequest
  ];

  @override
  final String wireName = r'PreviewAiProcessRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PreviewAiProcessRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'content';
    yield serializers.serialize(
      object.content,
      specifiedType: const FullType(String),
    );
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PreviewAiProcessRequest object, {
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
    required PreviewAiProcessRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PreviewAiProcessRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PreviewAiProcessRequestBuilder();
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
