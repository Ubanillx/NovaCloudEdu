//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'knowledge_point_id.g.dart';

/// KnowledgePointId
///
/// Properties:
/// * [value]
@BuiltValue()
abstract class KnowledgePointId
    implements Built<KnowledgePointId, KnowledgePointIdBuilder> {
  @BuiltValueField(wireName: r'value')
  int? get value;

  KnowledgePointId._();

  factory KnowledgePointId([void updates(KnowledgePointIdBuilder b)]) =
      _$KnowledgePointId;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KnowledgePointIdBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KnowledgePointId> get serializer =>
      _$KnowledgePointIdSerializer();
}

class _$KnowledgePointIdSerializer
    implements PrimitiveSerializer<KnowledgePointId> {
  @override
  final Iterable<Type> types = const [KnowledgePointId, _$KnowledgePointId];

  @override
  final String wireName = r'KnowledgePointId';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KnowledgePointId object, {
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
    KnowledgePointId object, {
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
    required KnowledgePointIdBuilder result,
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
  KnowledgePointId deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KnowledgePointIdBuilder();
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
