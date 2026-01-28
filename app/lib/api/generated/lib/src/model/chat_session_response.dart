//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chat_session_response.g.dart';

/// ChatSessionResponse
///
/// Properties:
/// * [sessionId]
/// * [partnerId]
/// * [partnerName]
/// * [partnerAvatar]
/// * [lastMessageTime]
/// * [unreadCount]
@BuiltValue()
abstract class ChatSessionResponse
    implements Built<ChatSessionResponse, ChatSessionResponseBuilder> {
  @BuiltValueField(wireName: r'sessionId')
  int? get sessionId;

  @BuiltValueField(wireName: r'partnerId')
  int? get partnerId;

  @BuiltValueField(wireName: r'partnerName')
  String? get partnerName;

  @BuiltValueField(wireName: r'partnerAvatar')
  String? get partnerAvatar;

  @BuiltValueField(wireName: r'lastMessageTime')
  DateTime? get lastMessageTime;

  @BuiltValueField(wireName: r'unreadCount')
  int? get unreadCount;

  ChatSessionResponse._();

  factory ChatSessionResponse([void updates(ChatSessionResponseBuilder b)]) =
      _$ChatSessionResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChatSessionResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChatSessionResponse> get serializer =>
      _$ChatSessionResponseSerializer();
}

class _$ChatSessionResponseSerializer
    implements PrimitiveSerializer<ChatSessionResponse> {
  @override
  final Iterable<Type> types = const [
    ChatSessionResponse,
    _$ChatSessionResponse
  ];

  @override
  final String wireName = r'ChatSessionResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChatSessionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.sessionId != null) {
      yield r'sessionId';
      yield serializers.serialize(
        object.sessionId,
        specifiedType: const FullType(int),
      );
    }
    if (object.partnerId != null) {
      yield r'partnerId';
      yield serializers.serialize(
        object.partnerId,
        specifiedType: const FullType(int),
      );
    }
    if (object.partnerName != null) {
      yield r'partnerName';
      yield serializers.serialize(
        object.partnerName,
        specifiedType: const FullType(String),
      );
    }
    if (object.partnerAvatar != null) {
      yield r'partnerAvatar';
      yield serializers.serialize(
        object.partnerAvatar,
        specifiedType: const FullType(String),
      );
    }
    if (object.lastMessageTime != null) {
      yield r'lastMessageTime';
      yield serializers.serialize(
        object.lastMessageTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.unreadCount != null) {
      yield r'unreadCount';
      yield serializers.serialize(
        object.unreadCount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ChatSessionResponse object, {
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
    required ChatSessionResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'sessionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sessionId = valueDes;
          break;
        case r'partnerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.partnerId = valueDes;
          break;
        case r'partnerName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.partnerName = valueDes;
          break;
        case r'partnerAvatar':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.partnerAvatar = valueDes;
          break;
        case r'lastMessageTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.lastMessageTime = valueDes;
          break;
        case r'unreadCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.unreadCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChatSessionResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChatSessionResponseBuilder();
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
