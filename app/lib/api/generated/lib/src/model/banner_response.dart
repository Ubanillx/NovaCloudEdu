//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'banner_response.g.dart';

/// 轮播图响应
///
/// Properties:
/// * [id] - 轮播图ID
/// * [title] - 标题
/// * [imageUrl] - 图片URL
/// * [linkType] - 跳转类型: 0-无跳转, 1-内部路由, 2-外部链接
/// * [linkTypeDesc] - 跳转类型描述
/// * [linkUrl] - 跳转URL/路由
/// * [sort] - 排序权重
/// * [status] - 状态: 0-草稿, 1-已发布, 2-已下线
/// * [statusDesc] - 状态描述
/// * [startTime] - 开始展示时间
/// * [endTime] - 结束展示时间
/// * [adminId] - 创建者ID
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
@BuiltValue()
abstract class BannerResponse
    implements Built<BannerResponse, BannerResponseBuilder> {
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

  /// 跳转类型描述
  @BuiltValueField(wireName: r'linkTypeDesc')
  String? get linkTypeDesc;

  /// 跳转URL/路由
  @BuiltValueField(wireName: r'linkUrl')
  String? get linkUrl;

  /// 排序权重
  @BuiltValueField(wireName: r'sort')
  int? get sort;

  /// 状态: 0-草稿, 1-已发布, 2-已下线
  @BuiltValueField(wireName: r'status')
  int? get status;

  /// 状态描述
  @BuiltValueField(wireName: r'statusDesc')
  String? get statusDesc;

  /// 开始展示时间
  @BuiltValueField(wireName: r'startTime')
  DateTime? get startTime;

  /// 结束展示时间
  @BuiltValueField(wireName: r'endTime')
  DateTime? get endTime;

  /// 创建者ID
  @BuiltValueField(wireName: r'adminId')
  int? get adminId;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  BannerResponse._();

  factory BannerResponse([void updates(BannerResponseBuilder b)]) =
      _$BannerResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BannerResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BannerResponse> get serializer =>
      _$BannerResponseSerializer();
}

class _$BannerResponseSerializer
    implements PrimitiveSerializer<BannerResponse> {
  @override
  final Iterable<Type> types = const [BannerResponse, _$BannerResponse];

  @override
  final String wireName = r'BannerResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BannerResponse object, {
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
    if (object.linkTypeDesc != null) {
      yield r'linkTypeDesc';
      yield serializers.serialize(
        object.linkTypeDesc,
        specifiedType: const FullType(String),
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
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(int),
      );
    }
    if (object.statusDesc != null) {
      yield r'statusDesc';
      yield serializers.serialize(
        object.statusDesc,
        specifiedType: const FullType(String),
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
    if (object.adminId != null) {
      yield r'adminId';
      yield serializers.serialize(
        object.adminId,
        specifiedType: const FullType(int),
      );
    }
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.updateTime != null) {
      yield r'updateTime';
      yield serializers.serialize(
        object.updateTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BannerResponse object, {
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
    required BannerResponseBuilder result,
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
        case r'linkTypeDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.linkTypeDesc = valueDes;
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
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.status = valueDes;
          break;
        case r'statusDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.statusDesc = valueDes;
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
        case r'adminId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.adminId = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        case r'updateTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updateTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BannerResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BannerResponseBuilder();
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
