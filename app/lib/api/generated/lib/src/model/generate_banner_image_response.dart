//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'generate_banner_image_response.g.dart';

/// AI生成轮播图图片响应
///
/// Properties:
/// * [imageUrl] - 生成的图片URL
/// * [success] - 是否成功
/// * [errorMessage] - 错误信息（失败时）
@BuiltValue()
abstract class GenerateBannerImageResponse
    implements
        Built<GenerateBannerImageResponse, GenerateBannerImageResponseBuilder> {
  /// 生成的图片URL
  @BuiltValueField(wireName: r'imageUrl')
  String? get imageUrl;

  /// 是否成功
  @BuiltValueField(wireName: r'success')
  bool? get success;

  /// 错误信息（失败时）
  @BuiltValueField(wireName: r'errorMessage')
  String? get errorMessage;

  GenerateBannerImageResponse._();

  factory GenerateBannerImageResponse(
          [void updates(GenerateBannerImageResponseBuilder b)]) =
      _$GenerateBannerImageResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GenerateBannerImageResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GenerateBannerImageResponse> get serializer =>
      _$GenerateBannerImageResponseSerializer();
}

class _$GenerateBannerImageResponseSerializer
    implements PrimitiveSerializer<GenerateBannerImageResponse> {
  @override
  final Iterable<Type> types = const [
    GenerateBannerImageResponse,
    _$GenerateBannerImageResponse
  ];

  @override
  final String wireName = r'GenerateBannerImageResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GenerateBannerImageResponse object, {
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
    GenerateBannerImageResponse object, {
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
    required GenerateBannerImageResponseBuilder result,
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
  GenerateBannerImageResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GenerateBannerImageResponseBuilder();
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
