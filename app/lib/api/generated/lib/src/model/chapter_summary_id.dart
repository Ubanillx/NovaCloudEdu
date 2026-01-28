//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chapter_summary_id.g.dart';

/// ChapterSummaryId
///
/// Properties:
/// * [value]
@BuiltValue()
abstract class ChapterSummaryId
    implements Built<ChapterSummaryId, ChapterSummaryIdBuilder> {
  @BuiltValueField(wireName: r'value')
  int? get value;

  ChapterSummaryId._();

  factory ChapterSummaryId([void updates(ChapterSummaryIdBuilder b)]) =
      _$ChapterSummaryId;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChapterSummaryIdBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChapterSummaryId> get serializer =>
      _$ChapterSummaryIdSerializer();
}

class _$ChapterSummaryIdSerializer
    implements PrimitiveSerializer<ChapterSummaryId> {
  @override
  final Iterable<Type> types = const [ChapterSummaryId, _$ChapterSummaryId];

  @override
  final String wireName = r'ChapterSummaryId';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChapterSummaryId object, {
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
    ChapterSummaryId object, {
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
    required ChapterSummaryIdBuilder result,
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
  ChapterSummaryId deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChapterSummaryIdBuilder();
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
