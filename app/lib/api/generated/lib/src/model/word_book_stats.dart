//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'word_book_stats.g.dart';

/// WordBookStats
///
/// Properties:
/// * [total]
/// * [notLearned]
/// * [learned]
/// * [mastered]
@BuiltValue()
abstract class WordBookStats
    implements Built<WordBookStats, WordBookStatsBuilder> {
  @BuiltValueField(wireName: r'total')
  int? get total;

  @BuiltValueField(wireName: r'notLearned')
  int? get notLearned;

  @BuiltValueField(wireName: r'learned')
  int? get learned;

  @BuiltValueField(wireName: r'mastered')
  int? get mastered;

  WordBookStats._();

  factory WordBookStats([void updates(WordBookStatsBuilder b)]) =
      _$WordBookStats;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WordBookStatsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WordBookStats> get serializer =>
      _$WordBookStatsSerializer();
}

class _$WordBookStatsSerializer implements PrimitiveSerializer<WordBookStats> {
  @override
  final Iterable<Type> types = const [WordBookStats, _$WordBookStats];

  @override
  final String wireName = r'WordBookStats';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WordBookStats object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.total != null) {
      yield r'total';
      yield serializers.serialize(
        object.total,
        specifiedType: const FullType(int),
      );
    }
    if (object.notLearned != null) {
      yield r'notLearned';
      yield serializers.serialize(
        object.notLearned,
        specifiedType: const FullType(int),
      );
    }
    if (object.learned != null) {
      yield r'learned';
      yield serializers.serialize(
        object.learned,
        specifiedType: const FullType(int),
      );
    }
    if (object.mastered != null) {
      yield r'mastered';
      yield serializers.serialize(
        object.mastered,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WordBookStats object, {
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
    required WordBookStatsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.total = valueDes;
          break;
        case r'notLearned':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.notLearned = valueDes;
          break;
        case r'learned':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.learned = valueDes;
          break;
        case r'mastered':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.mastered = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WordBookStats deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WordBookStatsBuilder();
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
