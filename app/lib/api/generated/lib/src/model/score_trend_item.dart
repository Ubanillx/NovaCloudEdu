//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'score_trend_item.g.dart';

/// 得分趋势项
///
/// Properties:
/// * [submissionId]
/// * [score]
/// * [maxScore]
/// * [subject]
/// * [createTime]
@BuiltValue()
abstract class ScoreTrendItem
    implements Built<ScoreTrendItem, ScoreTrendItemBuilder> {
  @BuiltValueField(wireName: r'submissionId')
  String? get submissionId;

  @BuiltValueField(wireName: r'score')
  int? get score;

  @BuiltValueField(wireName: r'maxScore')
  int? get maxScore;

  @BuiltValueField(wireName: r'subject')
  String? get subject;

  @BuiltValueField(wireName: r'createTime')
  String? get createTime;

  ScoreTrendItem._();

  factory ScoreTrendItem([void updates(ScoreTrendItemBuilder b)]) =
      _$ScoreTrendItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScoreTrendItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ScoreTrendItem> get serializer =>
      _$ScoreTrendItemSerializer();
}

class _$ScoreTrendItemSerializer
    implements PrimitiveSerializer<ScoreTrendItem> {
  @override
  final Iterable<Type> types = const [ScoreTrendItem, _$ScoreTrendItem];

  @override
  final String wireName = r'ScoreTrendItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ScoreTrendItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.submissionId != null) {
      yield r'submissionId';
      yield serializers.serialize(
        object.submissionId,
        specifiedType: const FullType(String),
      );
    }
    if (object.score != null) {
      yield r'score';
      yield serializers.serialize(
        object.score,
        specifiedType: const FullType(int),
      );
    }
    if (object.maxScore != null) {
      yield r'maxScore';
      yield serializers.serialize(
        object.maxScore,
        specifiedType: const FullType(int),
      );
    }
    if (object.subject != null) {
      yield r'subject';
      yield serializers.serialize(
        object.subject,
        specifiedType: const FullType(String),
      );
    }
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ScoreTrendItem object, {
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
    required ScoreTrendItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'submissionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.submissionId = valueDes;
          break;
        case r'score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.score = valueDes;
          break;
        case r'maxScore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.maxScore = valueDes;
          break;
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subject = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.createTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ScoreTrendItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScoreTrendItemBuilder();
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
