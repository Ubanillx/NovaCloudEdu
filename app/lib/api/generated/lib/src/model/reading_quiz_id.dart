//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reading_quiz_id.g.dart';

/// ReadingQuizId
///
/// Properties:
/// * [value]
@BuiltValue()
abstract class ReadingQuizId
    implements Built<ReadingQuizId, ReadingQuizIdBuilder> {
  @BuiltValueField(wireName: r'value')
  int? get value;

  ReadingQuizId._();

  factory ReadingQuizId([void updates(ReadingQuizIdBuilder b)]) =
      _$ReadingQuizId;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReadingQuizIdBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReadingQuizId> get serializer =>
      _$ReadingQuizIdSerializer();
}

class _$ReadingQuizIdSerializer implements PrimitiveSerializer<ReadingQuizId> {
  @override
  final Iterable<Type> types = const [ReadingQuizId, _$ReadingQuizId];

  @override
  final String wireName = r'ReadingQuizId';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReadingQuizId object, {
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
    ReadingQuizId object, {
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
    required ReadingQuizIdBuilder result,
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
  ReadingQuizId deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReadingQuizIdBuilder();
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
