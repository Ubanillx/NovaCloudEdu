//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/failed_item.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'batch_process_result.g.dart';

/// BatchProcessResult
///
/// Properties:
/// * [total]
/// * [successIds]
/// * [failedItems]
/// * [failedCount]
/// * [successCount]
@BuiltValue()
abstract class BatchProcessResult
    implements Built<BatchProcessResult, BatchProcessResultBuilder> {
  @BuiltValueField(wireName: r'total')
  int? get total;

  @BuiltValueField(wireName: r'successIds')
  BuiltList<int>? get successIds;

  @BuiltValueField(wireName: r'failedItems')
  BuiltList<FailedItem>? get failedItems;

  @BuiltValueField(wireName: r'failedCount')
  int? get failedCount;

  @BuiltValueField(wireName: r'successCount')
  int? get successCount;

  BatchProcessResult._();

  factory BatchProcessResult([void updates(BatchProcessResultBuilder b)]) =
      _$BatchProcessResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BatchProcessResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BatchProcessResult> get serializer =>
      _$BatchProcessResultSerializer();
}

class _$BatchProcessResultSerializer
    implements PrimitiveSerializer<BatchProcessResult> {
  @override
  final Iterable<Type> types = const [BatchProcessResult, _$BatchProcessResult];

  @override
  final String wireName = r'BatchProcessResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BatchProcessResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.total != null) {
      yield r'total';
      yield serializers.serialize(
        object.total,
        specifiedType: const FullType(int),
      );
    }
    if (object.successIds != null) {
      yield r'successIds';
      yield serializers.serialize(
        object.successIds,
        specifiedType: const FullType(BuiltList, [FullType(int)]),
      );
    }
    if (object.failedItems != null) {
      yield r'failedItems';
      yield serializers.serialize(
        object.failedItems,
        specifiedType: const FullType(BuiltList, [FullType(FailedItem)]),
      );
    }
    if (object.failedCount != null) {
      yield r'failedCount';
      yield serializers.serialize(
        object.failedCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.successCount != null) {
      yield r'successCount';
      yield serializers.serialize(
        object.successCount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BatchProcessResult object, {
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
    required BatchProcessResultBuilder result,
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
        case r'successIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(int)]),
          ) as BuiltList<int>;
          result.successIds.replace(valueDes);
          break;
        case r'failedItems':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(FailedItem)]),
          ) as BuiltList<FailedItem>;
          result.failedItems.replace(valueDes);
          break;
        case r'failedCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.failedCount = valueDes;
          break;
        case r'successCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.successCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BatchProcessResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BatchProcessResultBuilder();
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
