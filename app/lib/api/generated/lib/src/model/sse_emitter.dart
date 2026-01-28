//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sse_emitter.g.dart';

/// SseEmitter
///
/// Properties:
/// * [timeout]
@BuiltValue()
abstract class SseEmitter implements Built<SseEmitter, SseEmitterBuilder> {
  @BuiltValueField(wireName: r'timeout')
  int? get timeout;

  SseEmitter._();

  factory SseEmitter([void updates(SseEmitterBuilder b)]) = _$SseEmitter;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SseEmitterBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SseEmitter> get serializer => _$SseEmitterSerializer();
}

class _$SseEmitterSerializer implements PrimitiveSerializer<SseEmitter> {
  @override
  final Iterable<Type> types = const [SseEmitter, _$SseEmitter];

  @override
  final String wireName = r'SseEmitter';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SseEmitter object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.timeout != null) {
      yield r'timeout';
      yield serializers.serialize(
        object.timeout,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SseEmitter object, {
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
    required SseEmitterBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'timeout':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.timeout = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SseEmitter deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SseEmitterBuilder();
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
