//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'query_banner_request.g.dart';

/// 查询轮播图请求
///
/// Properties:
/// * [title] - 标题关键词
/// * [status] - 状态: 0-草稿, 1-已发布, 2-已下线
/// * [adminId] - 创建者ID
/// * [pageNum] - 页码
/// * [pageSize] - 每页数量
@BuiltValue()
abstract class QueryBannerRequest
    implements Built<QueryBannerRequest, QueryBannerRequestBuilder> {
  /// 标题关键词
  @BuiltValueField(wireName: r'title')
  String? get title;

  /// 状态: 0-草稿, 1-已发布, 2-已下线
  @BuiltValueField(wireName: r'status')
  int? get status;

  /// 创建者ID
  @BuiltValueField(wireName: r'adminId')
  int? get adminId;

  /// 页码
  @BuiltValueField(wireName: r'pageNum')
  int? get pageNum;

  /// 每页数量
  @BuiltValueField(wireName: r'pageSize')
  int? get pageSize;

  QueryBannerRequest._();

  factory QueryBannerRequest([void updates(QueryBannerRequestBuilder b)]) =
      _$QueryBannerRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(QueryBannerRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<QueryBannerRequest> get serializer =>
      _$QueryBannerRequestSerializer();
}

class _$QueryBannerRequestSerializer
    implements PrimitiveSerializer<QueryBannerRequest> {
  @override
  final Iterable<Type> types = const [QueryBannerRequest, _$QueryBannerRequest];

  @override
  final String wireName = r'QueryBannerRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    QueryBannerRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(int),
      );
    }
    if (object.adminId != null) {
      yield r'adminId';
      yield serializers.serialize(
        object.adminId,
        specifiedType: const FullType(int),
      );
    }
    if (object.pageNum != null) {
      yield r'pageNum';
      yield serializers.serialize(
        object.pageNum,
        specifiedType: const FullType(int),
      );
    }
    if (object.pageSize != null) {
      yield r'pageSize';
      yield serializers.serialize(
        object.pageSize,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    QueryBannerRequest object, {
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
    required QueryBannerRequestBuilder result,
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
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.status = valueDes;
          break;
        case r'adminId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.adminId = valueDes;
          break;
        case r'pageNum':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pageNum = valueDes;
          break;
        case r'pageSize':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pageSize = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  QueryBannerRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = QueryBannerRequestBuilder();
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
