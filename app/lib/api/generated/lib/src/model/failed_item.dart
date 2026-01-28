//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'failed_item.g.dart';

/// FailedItem
///
/// Properties:
/// * [documentId]
/// * [reason]
@BuiltValue()
abstract class FailedItem implements Built<FailedItem, FailedItemBuilder> {
  @BuiltValueField(wireName: r'documentId')
  int? get documentId;

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  FailedItem._();

  factory FailedItem([void updates(FailedItemBuilder b)]) = _$FailedItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FailedItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FailedItem> get serializer => _$FailedItemSerializer();
}

class _$FailedItemSerializer implements PrimitiveSerializer<FailedItem> {
  @override
  final Iterable<Type> types = const [FailedItem, _$FailedItem];

  @override
  final String wireName = r'FailedItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FailedItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.documentId != null) {
      yield r'documentId';
      yield serializers.serialize(
        object.documentId,
        specifiedType: const FullType(int),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FailedItem object, {
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
    required FailedItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'documentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.documentId = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FailedItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FailedItemBuilder();
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
