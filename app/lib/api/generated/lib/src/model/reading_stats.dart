//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reading_stats.g.dart';

/// ReadingStats
///
/// Properties:
/// * [total]
/// * [read]
@BuiltValue()
abstract class ReadingStats
    implements Built<ReadingStats, ReadingStatsBuilder> {
  @BuiltValueField(wireName: r'total')
  int? get total;

  @BuiltValueField(wireName: r'read')
  int? get read;

  ReadingStats._();

  factory ReadingStats([void updates(ReadingStatsBuilder b)]) = _$ReadingStats;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReadingStatsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReadingStats> get serializer => _$ReadingStatsSerializer();
}

class _$ReadingStatsSerializer implements PrimitiveSerializer<ReadingStats> {
  @override
  final Iterable<Type> types = const [ReadingStats, _$ReadingStats];

  @override
  final String wireName = r'ReadingStats';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReadingStats object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.total != null) {
      yield r'total';
      yield serializers.serialize(
        object.total,
        specifiedType: const FullType(int),
      );
    }
    if (object.read != null) {
      yield r'read';
      yield serializers.serialize(
        object.read,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ReadingStats object, {
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
    required ReadingStatsBuilder result,
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
        case r'read':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.read = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReadingStats deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReadingStatsBuilder();
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
