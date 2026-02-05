//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'banner_list_response.g.dart';

/// 轮播图列表响应
///
/// Properties:
/// * [id] - 轮播图ID
/// * [title] - 标题
/// * [imageUrl] - 图片URL
/// * [linkType] - 跳转类型: 0-无跳转, 1-内部路由, 2-外部链接
/// * [linkUrl] - 跳转URL/路由
@BuiltValue()
abstract class BannerListResponse
    implements Built<BannerListResponse, BannerListResponseBuilder> {
  /// 轮播图ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 标题
  @BuiltValueField(wireName: r'title')
  String? get title;

  /// 图片URL
  @BuiltValueField(wireName: r'imageUrl')
  String? get imageUrl;

  /// 跳转类型: 0-无跳转, 1-内部路由, 2-外部链接
  @BuiltValueField(wireName: r'linkType')
  int? get linkType;

  /// 跳转URL/路由
  @BuiltValueField(wireName: r'linkUrl')
  String? get linkUrl;

  BannerListResponse._();

  factory BannerListResponse([void updates(BannerListResponseBuilder b)]) =
      _$BannerListResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BannerListResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BannerListResponse> get serializer =>
      _$BannerListResponseSerializer();
}

class _$BannerListResponseSerializer
    implements PrimitiveSerializer<BannerListResponse> {
  @override
  final Iterable<Type> types = const [BannerListResponse, _$BannerListResponse];

  @override
  final String wireName = r'BannerListResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BannerListResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
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
    if (object.imageUrl != null) {
      yield r'imageUrl';
      yield serializers.serialize(
        object.imageUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.linkType != null) {
      yield r'linkType';
      yield serializers.serialize(
        object.linkType,
        specifiedType: const FullType(int),
      );
    }
    if (object.linkUrl != null) {
      yield r'linkUrl';
      yield serializers.serialize(
        object.linkUrl,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BannerListResponse object, {
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
    required BannerListResponseBuilder result,
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
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'imageUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.imageUrl = valueDes;
          break;
        case r'linkType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.linkType = valueDes;
          break;
        case r'linkUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.linkUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BannerListResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BannerListResponseBuilder();
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
