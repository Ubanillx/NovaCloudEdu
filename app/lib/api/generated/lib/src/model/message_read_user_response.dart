//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'message_read_user_response.g.dart';

/// MessageReadUserResponse
///
/// Properties:
/// * [userId]
/// * [userName]
/// * [userAvatar]
/// * [readTime]
@BuiltValue()
abstract class MessageReadUserResponse
    implements Built<MessageReadUserResponse, MessageReadUserResponseBuilder> {
  @BuiltValueField(wireName: r'userId')
  int? get userId;

  @BuiltValueField(wireName: r'userName')
  String? get userName;

  @BuiltValueField(wireName: r'userAvatar')
  String? get userAvatar;

  @BuiltValueField(wireName: r'readTime')
  DateTime? get readTime;

  MessageReadUserResponse._();

  factory MessageReadUserResponse(
          [void updates(MessageReadUserResponseBuilder b)]) =
      _$MessageReadUserResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MessageReadUserResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MessageReadUserResponse> get serializer =>
      _$MessageReadUserResponseSerializer();
}

class _$MessageReadUserResponseSerializer
    implements PrimitiveSerializer<MessageReadUserResponse> {
  @override
  final Iterable<Type> types = const [
    MessageReadUserResponse,
    _$MessageReadUserResponse
  ];

  @override
  final String wireName = r'MessageReadUserResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MessageReadUserResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(int),
      );
    }
    if (object.userName != null) {
      yield r'userName';
      yield serializers.serialize(
        object.userName,
        specifiedType: const FullType(String),
      );
    }
    if (object.userAvatar != null) {
      yield r'userAvatar';
      yield serializers.serialize(
        object.userAvatar,
        specifiedType: const FullType(String),
      );
    }
    if (object.readTime != null) {
      yield r'readTime';
      yield serializers.serialize(
        object.readTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MessageReadUserResponse object, {
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
    required MessageReadUserResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'userName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userName = valueDes;
          break;
        case r'userAvatar':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userAvatar = valueDes;
          break;
        case r'readTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.readTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MessageReadUserResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MessageReadUserResponseBuilder();
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
