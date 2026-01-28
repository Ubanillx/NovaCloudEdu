//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'friend_request_response.g.dart';

/// 好友申请响应
///
/// Properties:
/// * [id] - 申请ID
/// * [senderId] - 发送者ID
/// * [senderName] - 发送者用户名
/// * [senderAvatar] - 发送者头像
/// * [receiverId] - 接收者ID
/// * [receiverName] - 接收者用户名
/// * [receiverAvatar] - 接收者头像
/// * [status] - 申请状态：pending/accepted/rejected
/// * [message] - 申请消息
/// * [createTime] - 创建时间
@BuiltValue()
abstract class FriendRequestResponse
    implements Built<FriendRequestResponse, FriendRequestResponseBuilder> {
  /// 申请ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 发送者ID
  @BuiltValueField(wireName: r'senderId')
  int? get senderId;

  /// 发送者用户名
  @BuiltValueField(wireName: r'senderName')
  String? get senderName;

  /// 发送者头像
  @BuiltValueField(wireName: r'senderAvatar')
  String? get senderAvatar;

  /// 接收者ID
  @BuiltValueField(wireName: r'receiverId')
  int? get receiverId;

  /// 接收者用户名
  @BuiltValueField(wireName: r'receiverName')
  String? get receiverName;

  /// 接收者头像
  @BuiltValueField(wireName: r'receiverAvatar')
  String? get receiverAvatar;

  /// 申请状态：pending/accepted/rejected
  @BuiltValueField(wireName: r'status')
  String? get status;

  /// 申请消息
  @BuiltValueField(wireName: r'message')
  String? get message;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  FriendRequestResponse._();

  factory FriendRequestResponse(
      [void updates(FriendRequestResponseBuilder b)]) = _$FriendRequestResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FriendRequestResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FriendRequestResponse> get serializer =>
      _$FriendRequestResponseSerializer();
}

class _$FriendRequestResponseSerializer
    implements PrimitiveSerializer<FriendRequestResponse> {
  @override
  final Iterable<Type> types = const [
    FriendRequestResponse,
    _$FriendRequestResponse
  ];

  @override
  final String wireName = r'FriendRequestResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FriendRequestResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.senderId != null) {
      yield r'senderId';
      yield serializers.serialize(
        object.senderId,
        specifiedType: const FullType(int),
      );
    }
    if (object.senderName != null) {
      yield r'senderName';
      yield serializers.serialize(
        object.senderName,
        specifiedType: const FullType(String),
      );
    }
    if (object.senderAvatar != null) {
      yield r'senderAvatar';
      yield serializers.serialize(
        object.senderAvatar,
        specifiedType: const FullType(String),
      );
    }
    if (object.receiverId != null) {
      yield r'receiverId';
      yield serializers.serialize(
        object.receiverId,
        specifiedType: const FullType(int),
      );
    }
    if (object.receiverName != null) {
      yield r'receiverName';
      yield serializers.serialize(
        object.receiverName,
        specifiedType: const FullType(String),
      );
    }
    if (object.receiverAvatar != null) {
      yield r'receiverAvatar';
      yield serializers.serialize(
        object.receiverAvatar,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FriendRequestResponse object, {
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
    required FriendRequestResponseBuilder result,
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
        case r'senderId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.senderId = valueDes;
          break;
        case r'senderName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.senderName = valueDes;
          break;
        case r'senderAvatar':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.senderAvatar = valueDes;
          break;
        case r'receiverId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.receiverId = valueDes;
          break;
        case r'receiverName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.receiverName = valueDes;
          break;
        case r'receiverAvatar':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.receiverAvatar = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FriendRequestResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FriendRequestResponseBuilder();
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
