//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'generate_avatar_request.g.dart';

/// AI生成头像请求
///
/// Properties:
/// * [prompt] - 图片描述（英文效果更好）
@BuiltValue()
abstract class GenerateAvatarRequest
    implements Built<GenerateAvatarRequest, GenerateAvatarRequestBuilder> {
  /// 图片描述（英文效果更好）
  @BuiltValueField(wireName: r'prompt')
  String get prompt;

  GenerateAvatarRequest._();

  factory GenerateAvatarRequest(
      [void updates(GenerateAvatarRequestBuilder b)]) = _$GenerateAvatarRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GenerateAvatarRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GenerateAvatarRequest> get serializer =>
      _$GenerateAvatarRequestSerializer();
}

class _$GenerateAvatarRequestSerializer
    implements PrimitiveSerializer<GenerateAvatarRequest> {
  @override
  final Iterable<Type> types = const [
    GenerateAvatarRequest,
    _$GenerateAvatarRequest
  ];

  @override
  final String wireName = r'GenerateAvatarRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GenerateAvatarRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'prompt';
    yield serializers.serialize(
      object.prompt,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GenerateAvatarRequest object, {
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
    required GenerateAvatarRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'prompt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.prompt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GenerateAvatarRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GenerateAvatarRequestBuilder();
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
