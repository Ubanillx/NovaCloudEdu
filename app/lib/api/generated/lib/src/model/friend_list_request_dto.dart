//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'friend_list_request_dto.g.dart';

/// 好友列表请求
///
/// Properties:
/// * [pageNum] - 页码
/// * [pageSize] - 每页数量
@BuiltValue()
abstract class FriendListRequestDTO
    implements Built<FriendListRequestDTO, FriendListRequestDTOBuilder> {
  /// 页码
  @BuiltValueField(wireName: r'pageNum')
  int? get pageNum;

  /// 每页数量
  @BuiltValueField(wireName: r'pageSize')
  int? get pageSize;

  FriendListRequestDTO._();

  factory FriendListRequestDTO([void updates(FriendListRequestDTOBuilder b)]) =
      _$FriendListRequestDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FriendListRequestDTOBuilder b) => b
    ..pageNum = 1
    ..pageSize = 20;

  @BuiltValueSerializer(custom: true)
  static Serializer<FriendListRequestDTO> get serializer =>
      _$FriendListRequestDTOSerializer();
}

class _$FriendListRequestDTOSerializer
    implements PrimitiveSerializer<FriendListRequestDTO> {
  @override
  final Iterable<Type> types = const [
    FriendListRequestDTO,
    _$FriendListRequestDTO
  ];

  @override
  final String wireName = r'FriendListRequestDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FriendListRequestDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    FriendListRequestDTO object, {
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
    required FriendListRequestDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  FriendListRequestDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FriendListRequestDTOBuilder();
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
