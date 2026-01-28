//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/friend_request_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'friend_request_page_response.g.dart';

/// 好友申请分页响应
///
/// Properties:
/// * [records] - 好友申请列表
/// * [total] - 总数
/// * [pageNum] - 当前页码
/// * [pageSize] - 每页数量
/// * [totalPages] - 总页数
@BuiltValue()
abstract class FriendRequestPageResponse
    implements
        Built<FriendRequestPageResponse, FriendRequestPageResponseBuilder> {
  /// 好友申请列表
  @BuiltValueField(wireName: r'records')
  BuiltList<FriendRequestResponse>? get records;

  /// 总数
  @BuiltValueField(wireName: r'total')
  int? get total;

  /// 当前页码
  @BuiltValueField(wireName: r'pageNum')
  int? get pageNum;

  /// 每页数量
  @BuiltValueField(wireName: r'pageSize')
  int? get pageSize;

  /// 总页数
  @BuiltValueField(wireName: r'totalPages')
  int? get totalPages;

  FriendRequestPageResponse._();

  factory FriendRequestPageResponse(
          [void updates(FriendRequestPageResponseBuilder b)]) =
      _$FriendRequestPageResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FriendRequestPageResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FriendRequestPageResponse> get serializer =>
      _$FriendRequestPageResponseSerializer();
}

class _$FriendRequestPageResponseSerializer
    implements PrimitiveSerializer<FriendRequestPageResponse> {
  @override
  final Iterable<Type> types = const [
    FriendRequestPageResponse,
    _$FriendRequestPageResponse
  ];

  @override
  final String wireName = r'FriendRequestPageResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FriendRequestPageResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.records != null) {
      yield r'records';
      yield serializers.serialize(
        object.records,
        specifiedType:
            const FullType(BuiltList, [FullType(FriendRequestResponse)]),
      );
    }
    if (object.total != null) {
      yield r'total';
      yield serializers.serialize(
        object.total,
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
    if (object.totalPages != null) {
      yield r'totalPages';
      yield serializers.serialize(
        object.totalPages,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FriendRequestPageResponse object, {
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
    required FriendRequestPageResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'records':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(FriendRequestResponse)]),
          ) as BuiltList<FriendRequestResponse>;
          result.records.replace(valueDes);
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.total = valueDes;
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
        case r'totalPages':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalPages = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FriendRequestPageResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FriendRequestPageResponseBuilder();
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
