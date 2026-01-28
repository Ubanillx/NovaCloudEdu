//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chapter_id.g.dart';

/// ChapterId
///
/// Properties:
/// * [value]
@BuiltValue()
abstract class ChapterId implements Built<ChapterId, ChapterIdBuilder> {
  @BuiltValueField(wireName: r'value')
  int? get value;

  ChapterId._();

  factory ChapterId([void updates(ChapterIdBuilder b)]) = _$ChapterId;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChapterIdBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChapterId> get serializer => _$ChapterIdSerializer();
}

class _$ChapterIdSerializer implements PrimitiveSerializer<ChapterId> {
  @override
  final Iterable<Type> types = const [ChapterId, _$ChapterId];

  @override
  final String wireName = r'ChapterId';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChapterId object, {
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
    ChapterId object, {
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
    required ChapterIdBuilder result,
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
  ChapterId deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChapterIdBuilder();
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
