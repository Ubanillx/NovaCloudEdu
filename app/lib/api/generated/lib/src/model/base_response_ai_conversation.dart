//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/ai_conversation.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_ai_conversation.g.dart';

/// BaseResponseAiConversation
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseAiConversation
    implements
        Built<BaseResponseAiConversation, BaseResponseAiConversationBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  AiConversation? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseAiConversation._();

  factory BaseResponseAiConversation(
          [void updates(BaseResponseAiConversationBuilder b)]) =
      _$BaseResponseAiConversation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseAiConversationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseAiConversation> get serializer =>
      _$BaseResponseAiConversationSerializer();
}

class _$BaseResponseAiConversationSerializer
    implements PrimitiveSerializer<BaseResponseAiConversation> {
  @override
  final Iterable<Type> types = const [
    BaseResponseAiConversation,
    _$BaseResponseAiConversation
  ];

  @override
  final String wireName = r'BaseResponseAiConversation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseAiConversation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(int),
      );
    }
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(AiConversation),
      );
    }
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
    BaseResponseAiConversation object, {
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
    required BaseResponseAiConversationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.code = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AiConversation),
          ) as AiConversation;
          result.data.replace(valueDes);
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
  BaseResponseAiConversation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseAiConversationBuilder();
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
