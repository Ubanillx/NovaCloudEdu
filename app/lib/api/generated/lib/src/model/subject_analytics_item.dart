//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'subject_analytics_item.g.dart';

/// SubjectAnalyticsItem
///
/// Properties:
/// * [subjectCode]
/// * [subjectName]
/// * [avgMasteryLevel]
/// * [totalKnowledgePoints]
/// * [weakPointCount]
/// * [strongPointCount]
/// * [totalAttempts]
/// * [correctRate]
@BuiltValue()
abstract class SubjectAnalyticsItem
    implements Built<SubjectAnalyticsItem, SubjectAnalyticsItemBuilder> {
  @BuiltValueField(wireName: r'subjectCode')
  String? get subjectCode;

  @BuiltValueField(wireName: r'subjectName')
  String? get subjectName;

  @BuiltValueField(wireName: r'avgMasteryLevel')
  double? get avgMasteryLevel;

  @BuiltValueField(wireName: r'totalKnowledgePoints')
  int? get totalKnowledgePoints;

  @BuiltValueField(wireName: r'weakPointCount')
  int? get weakPointCount;

  @BuiltValueField(wireName: r'strongPointCount')
  int? get strongPointCount;

  @BuiltValueField(wireName: r'totalAttempts')
  int? get totalAttempts;

  @BuiltValueField(wireName: r'correctRate')
  double? get correctRate;

  SubjectAnalyticsItem._();

  factory SubjectAnalyticsItem([void updates(SubjectAnalyticsItemBuilder b)]) =
      _$SubjectAnalyticsItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubjectAnalyticsItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SubjectAnalyticsItem> get serializer =>
      _$SubjectAnalyticsItemSerializer();
}

class _$SubjectAnalyticsItemSerializer
    implements PrimitiveSerializer<SubjectAnalyticsItem> {
  @override
  final Iterable<Type> types = const [
    SubjectAnalyticsItem,
    _$SubjectAnalyticsItem
  ];

  @override
  final String wireName = r'SubjectAnalyticsItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SubjectAnalyticsItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.subjectCode != null) {
      yield r'subjectCode';
      yield serializers.serialize(
        object.subjectCode,
        specifiedType: const FullType(String),
      );
    }
    if (object.subjectName != null) {
      yield r'subjectName';
      yield serializers.serialize(
        object.subjectName,
        specifiedType: const FullType(String),
      );
    }
    if (object.avgMasteryLevel != null) {
      yield r'avgMasteryLevel';
      yield serializers.serialize(
        object.avgMasteryLevel,
        specifiedType: const FullType(double),
      );
    }
    if (object.totalKnowledgePoints != null) {
      yield r'totalKnowledgePoints';
      yield serializers.serialize(
        object.totalKnowledgePoints,
        specifiedType: const FullType(int),
      );
    }
    if (object.weakPointCount != null) {
      yield r'weakPointCount';
      yield serializers.serialize(
        object.weakPointCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.strongPointCount != null) {
      yield r'strongPointCount';
      yield serializers.serialize(
        object.strongPointCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalAttempts != null) {
      yield r'totalAttempts';
      yield serializers.serialize(
        object.totalAttempts,
        specifiedType: const FullType(int),
      );
    }
    if (object.correctRate != null) {
      yield r'correctRate';
      yield serializers.serialize(
        object.correctRate,
        specifiedType: const FullType(double),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SubjectAnalyticsItem object, {
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
    required SubjectAnalyticsItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'subjectCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subjectCode = valueDes;
          break;
        case r'subjectName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subjectName = valueDes;
          break;
        case r'avgMasteryLevel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.avgMasteryLevel = valueDes;
          break;
        case r'totalKnowledgePoints':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalKnowledgePoints = valueDes;
          break;
        case r'weakPointCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.weakPointCount = valueDes;
          break;
        case r'strongPointCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.strongPointCount = valueDes;
          break;
        case r'totalAttempts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalAttempts = valueDes;
          break;
        case r'correctRate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.correctRate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SubjectAnalyticsItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubjectAnalyticsItemBuilder();
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
