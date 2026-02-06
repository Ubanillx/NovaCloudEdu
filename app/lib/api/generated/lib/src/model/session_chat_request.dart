//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'session_chat_request.g.dart';

/// SessionChatRequest
///
/// Properties:
/// * [message]
/// * [systemPrompt]
/// * [imageUrls]
/// * [documentUrls]
/// * [modelId]
@BuiltValue()
abstract class SessionChatRequest
    implements Built<SessionChatRequest, SessionChatRequestBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'systemPrompt')
  String? get systemPrompt;

  @BuiltValueField(wireName: r'imageUrls')
  BuiltList<String>? get imageUrls;

  @BuiltValueField(wireName: r'documentUrls')
  BuiltList<String>? get documentUrls;

  @BuiltValueField(wireName: r'modelId')
  String? get modelId;

  SessionChatRequest._();

  factory SessionChatRequest([void updates(SessionChatRequestBuilder b)]) =
      _$SessionChatRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SessionChatRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SessionChatRequest> get serializer =>
      _$SessionChatRequestSerializer();
}

class _$SessionChatRequestSerializer
    implements PrimitiveSerializer<SessionChatRequest> {
  @override
  final Iterable<Type> types = const [SessionChatRequest, _$SessionChatRequest];

  @override
  final String wireName = r'SessionChatRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SessionChatRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    if (object.systemPrompt != null) {
      yield r'systemPrompt';
      yield serializers.serialize(
        object.systemPrompt,
        specifiedType: const FullType(String),
      );
    }
    if (object.imageUrls != null) {
      yield r'imageUrls';
      yield serializers.serialize(
        object.imageUrls,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.documentUrls != null) {
      yield r'documentUrls';
      yield serializers.serialize(
        object.documentUrls,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.modelId != null) {
      yield r'modelId';
      yield serializers.serialize(
        object.modelId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SessionChatRequest object, {
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
    required SessionChatRequestBuilder result,
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
        case r'systemPrompt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.systemPrompt = valueDes;
          break;
        case r'imageUrls':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.imageUrls.replace(valueDes);
          break;
        case r'documentUrls':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.documentUrls.replace(valueDes);
          break;
        case r'modelId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.modelId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SessionChatRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SessionChatRequestBuilder();
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
