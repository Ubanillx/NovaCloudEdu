//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'handle_friend_request_dto.g.dart';

/// 处理好友申请请求
///
/// Properties:
/// * [requestId] - 好友申请ID
/// * [accept] - 是否接受：true-接受，false-拒绝
@BuiltValue()
abstract class HandleFriendRequestDTO
    implements Built<HandleFriendRequestDTO, HandleFriendRequestDTOBuilder> {
  /// 好友申请ID
  @BuiltValueField(wireName: r'requestId')
  int get requestId;

  /// 是否接受：true-接受，false-拒绝
  @BuiltValueField(wireName: r'accept')
  bool get accept;

  HandleFriendRequestDTO._();

  factory HandleFriendRequestDTO(
          [void updates(HandleFriendRequestDTOBuilder b)]) =
      _$HandleFriendRequestDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HandleFriendRequestDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HandleFriendRequestDTO> get serializer =>
      _$HandleFriendRequestDTOSerializer();
}

class _$HandleFriendRequestDTOSerializer
    implements PrimitiveSerializer<HandleFriendRequestDTO> {
  @override
  final Iterable<Type> types = const [
    HandleFriendRequestDTO,
    _$HandleFriendRequestDTO
  ];

  @override
  final String wireName = r'HandleFriendRequestDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HandleFriendRequestDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'requestId';
    yield serializers.serialize(
      object.requestId,
      specifiedType: const FullType(int),
    );
    yield r'accept';
    yield serializers.serialize(
      object.accept,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HandleFriendRequestDTO object, {
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
    required HandleFriendRequestDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'requestId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.requestId = valueDes;
          break;
        case r'accept':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.accept = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HandleFriendRequestDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HandleFriendRequestDTOBuilder();
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
