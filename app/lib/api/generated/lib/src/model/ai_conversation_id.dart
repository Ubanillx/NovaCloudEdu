//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ai_conversation_id.g.dart';

/// AiConversationId
///
/// Properties:
/// * [value]
@BuiltValue()
abstract class AiConversationId
    implements Built<AiConversationId, AiConversationIdBuilder> {
  @BuiltValueField(wireName: r'value')
  int? get value;

  AiConversationId._();

  factory AiConversationId([void updates(AiConversationIdBuilder b)]) =
      _$AiConversationId;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AiConversationIdBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AiConversationId> get serializer =>
      _$AiConversationIdSerializer();
}

class _$AiConversationIdSerializer
    implements PrimitiveSerializer<AiConversationId> {
  @override
  final Iterable<Type> types = const [AiConversationId, _$AiConversationId];

  @override
  final String wireName = r'AiConversationId';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AiConversationId object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.value != null) {
      yield r'value';
      yield serializers.serialize(
        object.value,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AiConversationId object, {
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
    required AiConversationIdBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.value = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AiConversationId deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AiConversationIdBuilder();
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
