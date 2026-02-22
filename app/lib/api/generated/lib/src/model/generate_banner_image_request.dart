//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'generate_banner_image_request.g.dart';

/// AI生成轮播图图片请求
///
/// Properties:
/// * [title] - 轮播图标题
/// * [imageDescription] - 图片描述（英文效果更好）
@BuiltValue()
abstract class GenerateBannerImageRequest
    implements
        Built<GenerateBannerImageRequest, GenerateBannerImageRequestBuilder> {
  /// 轮播图标题
  @BuiltValueField(wireName: r'title')
  String get title;

  /// 图片描述（英文效果更好）
  @BuiltValueField(wireName: r'imageDescription')
  String get imageDescription;

  GenerateBannerImageRequest._();

  factory GenerateBannerImageRequest(
          [void updates(GenerateBannerImageRequestBuilder b)]) =
      _$GenerateBannerImageRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GenerateBannerImageRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GenerateBannerImageRequest> get serializer =>
      _$GenerateBannerImageRequestSerializer();
}

class _$GenerateBannerImageRequestSerializer
    implements PrimitiveSerializer<GenerateBannerImageRequest> {
  @override
  final Iterable<Type> types = const [
    GenerateBannerImageRequest,
    _$GenerateBannerImageRequest
  ];

  @override
  final String wireName = r'GenerateBannerImageRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GenerateBannerImageRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'imageDescription';
    yield serializers.serialize(
      object.imageDescription,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GenerateBannerImageRequest object, {
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
    required GenerateBannerImageRequestBuilder result,
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
        case r'imageDescription':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.imageDescription = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GenerateBannerImageRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GenerateBannerImageRequestBuilder();
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
