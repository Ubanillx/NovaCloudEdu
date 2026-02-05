//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_banner_request.g.dart';

/// 创建轮播图请求
///
/// Properties:
/// * [title] - 标题
/// * [imageUrl] - 图片URL
/// * [linkType] - 跳转类型: 0-无跳转, 1-内部路由, 2-外部链接
/// * [linkUrl] - 跳转URL/路由
/// * [sort] - 排序权重，值越大越靠前
/// * [startTime] - 开始展示时间
/// * [endTime] - 结束展示时间
@BuiltValue()
abstract class CreateBannerRequest
    implements Built<CreateBannerRequest, CreateBannerRequestBuilder> {
  /// 标题
  @BuiltValueField(wireName: r'title')
  String get title;

  /// 图片URL
  @BuiltValueField(wireName: r'imageUrl')
  String get imageUrl;

  /// 跳转类型: 0-无跳转, 1-内部路由, 2-外部链接
  @BuiltValueField(wireName: r'linkType')
  int? get linkType;

  /// 跳转URL/路由
  @BuiltValueField(wireName: r'linkUrl')
  String? get linkUrl;

  /// 排序权重，值越大越靠前
  @BuiltValueField(wireName: r'sort')
  int? get sort;

  /// 开始展示时间
  @BuiltValueField(wireName: r'startTime')
  DateTime? get startTime;

  /// 结束展示时间
  @BuiltValueField(wireName: r'endTime')
  DateTime? get endTime;

  CreateBannerRequest._();

  factory CreateBannerRequest([void updates(CreateBannerRequestBuilder b)]) =
      _$CreateBannerRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateBannerRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateBannerRequest> get serializer =>
      _$CreateBannerRequestSerializer();
}

class _$CreateBannerRequestSerializer
    implements PrimitiveSerializer<CreateBannerRequest> {
  @override
  final Iterable<Type> types = const [
    CreateBannerRequest,
    _$CreateBannerRequest
  ];

  @override
  final String wireName = r'CreateBannerRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateBannerRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'imageUrl';
    yield serializers.serialize(
      object.imageUrl,
      specifiedType: const FullType(String),
    );
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
    if (object.sort != null) {
      yield r'sort';
      yield serializers.serialize(
        object.sort,
        specifiedType: const FullType(int),
      );
    }
    if (object.startTime != null) {
      yield r'startTime';
      yield serializers.serialize(
        object.startTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.endTime != null) {
      yield r'endTime';
      yield serializers.serialize(
        object.endTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateBannerRequest object, {
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
    required CreateBannerRequestBuilder result,
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
        case r'sort':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sort = valueDes;
          break;
        case r'startTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startTime = valueDes;
          break;
        case r'endTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.endTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateBannerRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateBannerRequestBuilder();
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
