//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chat_request.g.dart';

/// ChatRequest
///
/// Properties:
/// * [message]
/// * [history]
/// * [systemPrompt]
@BuiltValue()
abstract class ChatRequest implements Built<ChatRequest, ChatRequestBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'history')
  BuiltList<BuiltMap<String, String>>? get history;

  @BuiltValueField(wireName: r'systemPrompt')
  String? get systemPrompt;

  ChatRequest._();

  factory ChatRequest([void updates(ChatRequestBuilder b)]) = _$ChatRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChatRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChatRequest> get serializer => _$ChatRequestSerializer();
}

class _$ChatRequestSerializer implements PrimitiveSerializer<ChatRequest> {
  @override
  final Iterable<Type> types = const [ChatRequest, _$ChatRequest];

  @override
  final String wireName = r'ChatRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChatRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    if (object.history != null) {
      yield r'history';
      yield serializers.serialize(
        object.history,
        specifiedType: const FullType(BuiltList, [
          FullType(BuiltMap, [FullType(String), FullType(String)])
        ]),
      );
    }
    if (object.systemPrompt != null) {
      yield r'systemPrompt';
      yield serializers.serialize(
        object.systemPrompt,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ChatRequest object, {
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
    required ChatRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'history':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltMap, [FullType(String), FullType(String)])
            ]),
          ) as BuiltList<BuiltMap<String, String>>;
          result.history.replace(valueDes);
          break;
        case r'systemPrompt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.systemPrompt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChatRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChatRequestBuilder();
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
