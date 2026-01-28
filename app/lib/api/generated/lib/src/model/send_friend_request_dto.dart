//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_friend_request_dto.g.dart';

/// 发送好友申请请求
///
/// Properties:
/// * [receiverId] - 接收者用户ID
/// * [message] - 申请消息
@BuiltValue()
abstract class SendFriendRequestDTO
    implements Built<SendFriendRequestDTO, SendFriendRequestDTOBuilder> {
  /// 接收者用户ID
  @BuiltValueField(wireName: r'receiverId')
  int get receiverId;

  /// 申请消息
  @BuiltValueField(wireName: r'message')
  String? get message;

  SendFriendRequestDTO._();

  factory SendFriendRequestDTO([void updates(SendFriendRequestDTOBuilder b)]) =
      _$SendFriendRequestDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SendFriendRequestDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SendFriendRequestDTO> get serializer =>
      _$SendFriendRequestDTOSerializer();
}

class _$SendFriendRequestDTOSerializer
    implements PrimitiveSerializer<SendFriendRequestDTO> {
  @override
  final Iterable<Type> types = const [
    SendFriendRequestDTO,
    _$SendFriendRequestDTO
  ];

  @override
  final String wireName = r'SendFriendRequestDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SendFriendRequestDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'receiverId';
    yield serializers.serialize(
      object.receiverId,
      specifiedType: const FullType(int),
    );
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SendFriendRequestDTO object, {
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
    required SendFriendRequestDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'receiverId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.receiverId = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SendFriendRequestDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SendFriendRequestDTOBuilder();
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
