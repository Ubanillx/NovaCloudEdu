//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/trend_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'learning_trend_response.g.dart';

/// LearningTrendResponse
///
/// Properties:
/// * [granularity]
/// * [items]
@BuiltValue()
abstract class LearningTrendResponse
    implements Built<LearningTrendResponse, LearningTrendResponseBuilder> {
  @BuiltValueField(wireName: r'granularity')
  String? get granularity;

  @BuiltValueField(wireName: r'items')
  BuiltList<TrendItem>? get items;

  LearningTrendResponse._();

  factory LearningTrendResponse(
      [void updates(LearningTrendResponseBuilder b)]) = _$LearningTrendResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LearningTrendResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LearningTrendResponse> get serializer =>
      _$LearningTrendResponseSerializer();
}

class _$LearningTrendResponseSerializer
    implements PrimitiveSerializer<LearningTrendResponse> {
  @override
  final Iterable<Type> types = const [
    LearningTrendResponse,
    _$LearningTrendResponse
  ];

  @override
  final String wireName = r'LearningTrendResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LearningTrendResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.granularity != null) {
      yield r'granularity';
      yield serializers.serialize(
        object.granularity,
        specifiedType: const FullType(String),
      );
    }
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, [FullType(TrendItem)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LearningTrendResponse object, {
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
    required LearningTrendResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'granularity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.granularity = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TrendItem)]),
          ) as BuiltList<TrendItem>;
          result.items.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LearningTrendResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LearningTrendResponseBuilder();
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
