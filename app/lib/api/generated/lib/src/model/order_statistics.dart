//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_statistics.g.dart';

/// OrderStatistics
///
/// Properties:
/// * [unpaidCount]
/// * [paidCount]
/// * [expiredCount]
/// * [refundedCount]
@BuiltValue()
abstract class OrderStatistics
    implements Built<OrderStatistics, OrderStatisticsBuilder> {
  @BuiltValueField(wireName: r'unpaidCount')
  int? get unpaidCount;

  @BuiltValueField(wireName: r'paidCount')
  int? get paidCount;

  @BuiltValueField(wireName: r'expiredCount')
  int? get expiredCount;

  @BuiltValueField(wireName: r'refundedCount')
  int? get refundedCount;

  OrderStatistics._();

  factory OrderStatistics([void updates(OrderStatisticsBuilder b)]) =
      _$OrderStatistics;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderStatisticsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderStatistics> get serializer =>
      _$OrderStatisticsSerializer();
}

class _$OrderStatisticsSerializer
    implements PrimitiveSerializer<OrderStatistics> {
  @override
  final Iterable<Type> types = const [OrderStatistics, _$OrderStatistics];

  @override
  final String wireName = r'OrderStatistics';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderStatistics object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.unpaidCount != null) {
      yield r'unpaidCount';
      yield serializers.serialize(
        object.unpaidCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.paidCount != null) {
      yield r'paidCount';
      yield serializers.serialize(
        object.paidCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.expiredCount != null) {
      yield r'expiredCount';
      yield serializers.serialize(
        object.expiredCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.refundedCount != null) {
      yield r'refundedCount';
      yield serializers.serialize(
        object.refundedCount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderStatistics object, {
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
    required OrderStatisticsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'unpaidCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.unpaidCount = valueDes;
          break;
        case r'paidCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.paidCount = valueDes;
          break;
        case r'expiredCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.expiredCount = valueDes;
          break;
        case r'refundedCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.refundedCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OrderStatistics deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderStatisticsBuilder();
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
