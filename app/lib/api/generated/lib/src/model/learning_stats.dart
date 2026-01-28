//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'learning_stats.g.dart';

/// LearningStats
///
/// Properties:
/// * [total]
/// * [studied]
@BuiltValue()
abstract class LearningStats
    implements Built<LearningStats, LearningStatsBuilder> {
  @BuiltValueField(wireName: r'total')
  int? get total;

  @BuiltValueField(wireName: r'studied')
  int? get studied;

  LearningStats._();

  factory LearningStats([void updates(LearningStatsBuilder b)]) =
      _$LearningStats;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LearningStatsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LearningStats> get serializer =>
      _$LearningStatsSerializer();
}

class _$LearningStatsSerializer implements PrimitiveSerializer<LearningStats> {
  @override
  final Iterable<Type> types = const [LearningStats, _$LearningStats];

  @override
  final String wireName = r'LearningStats';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LearningStats object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.total != null) {
      yield r'total';
      yield serializers.serialize(
        object.total,
        specifiedType: const FullType(int),
      );
    }
    if (object.studied != null) {
      yield r'studied';
      yield serializers.serialize(
        object.studied,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LearningStats object, {
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
    required LearningStatsBuilder result,
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
        case r'studied':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.studied = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LearningStats deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LearningStatsBuilder();
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
