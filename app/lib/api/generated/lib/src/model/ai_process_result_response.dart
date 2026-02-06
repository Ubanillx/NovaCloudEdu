//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ai_process_result_response.g.dart';

/// AI 处理结果响应
///
/// Properties:
/// * [formattedContent] - 格式化后的内容（Markdown）
/// * [summary] - AI 生成的摘要
@BuiltValue()
abstract class AiProcessResultResponse
    implements Built<AiProcessResultResponse, AiProcessResultResponseBuilder> {
  /// 格式化后的内容（Markdown）
  @BuiltValueField(wireName: r'formattedContent')
  String? get formattedContent;

  /// AI 生成的摘要
  @BuiltValueField(wireName: r'summary')
  String? get summary;

  AiProcessResultResponse._();

  factory AiProcessResultResponse(
          [void updates(AiProcessResultResponseBuilder b)]) =
      _$AiProcessResultResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AiProcessResultResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AiProcessResultResponse> get serializer =>
      _$AiProcessResultResponseSerializer();
}

class _$AiProcessResultResponseSerializer
    implements PrimitiveSerializer<AiProcessResultResponse> {
  @override
  final Iterable<Type> types = const [
    AiProcessResultResponse,
    _$AiProcessResultResponse
  ];

  @override
  final String wireName = r'AiProcessResultResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AiProcessResultResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.formattedContent != null) {
      yield r'formattedContent';
      yield serializers.serialize(
        object.formattedContent,
        specifiedType: const FullType(String),
      );
    }
    if (object.summary != null) {
      yield r'summary';
      yield serializers.serialize(
        object.summary,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AiProcessResultResponse object, {
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
    required AiProcessResultResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'formattedContent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.formattedContent = valueDes;
          break;
        case r'summary':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.summary = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AiProcessResultResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AiProcessResultResponseBuilder();
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
