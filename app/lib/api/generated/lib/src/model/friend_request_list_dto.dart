//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'friend_request_list_dto.g.dart';

/// 好友申请列表请求
///
/// Properties:
/// * [status] - 状态过滤：pending/accepted/rejected，不传则查询全部
/// * [pageNum] - 页码
/// * [pageSize] - 每页数量
@BuiltValue()
abstract class FriendRequestListDTO
    implements Built<FriendRequestListDTO, FriendRequestListDTOBuilder> {
  /// 状态过滤：pending/accepted/rejected，不传则查询全部
  @BuiltValueField(wireName: r'status')
  String? get status;

  /// 页码
  @BuiltValueField(wireName: r'pageNum')
  int? get pageNum;

  /// 每页数量
  @BuiltValueField(wireName: r'pageSize')
  int? get pageSize;

  FriendRequestListDTO._();

  factory FriendRequestListDTO([void updates(FriendRequestListDTOBuilder b)]) =
      _$FriendRequestListDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FriendRequestListDTOBuilder b) => b
    ..pageNum = 1
    ..pageSize = 20;

  @BuiltValueSerializer(custom: true)
  static Serializer<FriendRequestListDTO> get serializer =>
      _$FriendRequestListDTOSerializer();
}

class _$FriendRequestListDTOSerializer
    implements PrimitiveSerializer<FriendRequestListDTO> {
  @override
  final Iterable<Type> types = const [
    FriendRequestListDTO,
    _$FriendRequestListDTO
  ];

  @override
  final String wireName = r'FriendRequestListDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FriendRequestListDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
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
    FriendRequestListDTO object, {
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
    required FriendRequestListDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
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
  FriendRequestListDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FriendRequestListDTOBuilder();
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
