//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'trend_item.g.dart';

/// TrendItem
///
/// Properties:
/// * [period]
/// * [activityCount]
/// * [totalDurationSec]
/// * [durationText]
@BuiltValue()
abstract class TrendItem implements Built<TrendItem, TrendItemBuilder> {
  @BuiltValueField(wireName: r'period')
  String? get period;

  @BuiltValueField(wireName: r'activityCount')
  int? get activityCount;

  @BuiltValueField(wireName: r'totalDurationSec')
  int? get totalDurationSec;

  @BuiltValueField(wireName: r'durationText')
  String? get durationText;

  TrendItem._();

  factory TrendItem([void updates(TrendItemBuilder b)]) = _$TrendItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TrendItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TrendItem> get serializer => _$TrendItemSerializer();
}

class _$TrendItemSerializer implements PrimitiveSerializer<TrendItem> {
  @override
  final Iterable<Type> types = const [TrendItem, _$TrendItem];

  @override
  final String wireName = r'TrendItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TrendItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.period != null) {
      yield r'period';
      yield serializers.serialize(
        object.period,
        specifiedType: const FullType(String),
      );
    }
    if (object.activityCount != null) {
      yield r'activityCount';
      yield serializers.serialize(
        object.activityCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalDurationSec != null) {
      yield r'totalDurationSec';
      yield serializers.serialize(
        object.totalDurationSec,
        specifiedType: const FullType(int),
      );
    }
    if (object.durationText != null) {
      yield r'durationText';
      yield serializers.serialize(
        object.durationText,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TrendItem object, {
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
    required TrendItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'period':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.period = valueDes;
          break;
        case r'activityCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.activityCount = valueDes;
          break;
        case r'totalDurationSec':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalDurationSec = valueDes;
          break;
        case r'durationText':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.durationText = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TrendItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TrendItemBuilder();
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
