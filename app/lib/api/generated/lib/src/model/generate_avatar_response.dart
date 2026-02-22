//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'generate_avatar_response.g.dart';

/// AI生成头像响应
///
/// Properties:
/// * [imageUrl] - 生成的图片URL
/// * [success] - 是否成功
/// * [errorMessage] - 错误信息（失败时）
@BuiltValue()
abstract class GenerateAvatarResponse
    implements Built<GenerateAvatarResponse, GenerateAvatarResponseBuilder> {
  /// 生成的图片URL
  @BuiltValueField(wireName: r'imageUrl')
  String? get imageUrl;

  /// 是否成功
  @BuiltValueField(wireName: r'success')
  bool? get success;

  /// 错误信息（失败时）
  @BuiltValueField(wireName: r'errorMessage')
  String? get errorMessage;

  GenerateAvatarResponse._();

  factory GenerateAvatarResponse(
          [void updates(GenerateAvatarResponseBuilder b)]) =
      _$GenerateAvatarResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GenerateAvatarResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GenerateAvatarResponse> get serializer =>
      _$GenerateAvatarResponseSerializer();
}

class _$GenerateAvatarResponseSerializer
    implements PrimitiveSerializer<GenerateAvatarResponse> {
  @override
  final Iterable<Type> types = const [
    GenerateAvatarResponse,
    _$GenerateAvatarResponse
  ];

  @override
  final String wireName = r'GenerateAvatarResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GenerateAvatarResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.imageUrl != null) {
      yield r'imageUrl';
      yield serializers.serialize(
        object.imageUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.success != null) {
      yield r'success';
      yield serializers.serialize(
        object.success,
        specifiedType: const FullType(bool),
      );
    }
    if (object.errorMessage != null) {
      yield r'errorMessage';
      yield serializers.serialize(
        object.errorMessage,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GenerateAvatarResponse object, {
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
    required GenerateAvatarResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'imageUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.imageUrl = valueDes;
          break;
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.success = valueDes;
          break;
        case r'errorMessage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.errorMessage = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GenerateAvatarResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GenerateAvatarResponseBuilder();
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
