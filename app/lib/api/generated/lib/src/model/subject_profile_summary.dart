//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/knowledge_profile_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'subject_profile_summary.g.dart';

/// 学科知识画像汇总
///
/// Properties:
/// * [subject] - 学科
/// * [subjectName] - 学科名称
/// * [avgMasteryLevel] - 平均掌握度
/// * [totalPoints] - 总知识点数
/// * [weakPointCount] - 薄弱知识点数
/// * [strongPointCount] - 优势知识点数（掌握度>=0.8）
/// * [weakPoints] - 薄弱知识点列表
/// * [strongPoints] - 优势知识点列表
@BuiltValue()
abstract class SubjectProfileSummary
    implements Built<SubjectProfileSummary, SubjectProfileSummaryBuilder> {
  /// 学科
  @BuiltValueField(wireName: r'subject')
  String? get subject;

  /// 学科名称
  @BuiltValueField(wireName: r'subjectName')
  String? get subjectName;

  /// 平均掌握度
  @BuiltValueField(wireName: r'avgMasteryLevel')
  double? get avgMasteryLevel;

  /// 总知识点数
  @BuiltValueField(wireName: r'totalPoints')
  int? get totalPoints;

  /// 薄弱知识点数
  @BuiltValueField(wireName: r'weakPointCount')
  int? get weakPointCount;

  /// 优势知识点数（掌握度>=0.8）
  @BuiltValueField(wireName: r'strongPointCount')
  int? get strongPointCount;

  /// 薄弱知识点列表
  @BuiltValueField(wireName: r'weakPoints')
  BuiltList<KnowledgeProfileResponse>? get weakPoints;

  /// 优势知识点列表
  @BuiltValueField(wireName: r'strongPoints')
  BuiltList<KnowledgeProfileResponse>? get strongPoints;

  SubjectProfileSummary._();

  factory SubjectProfileSummary(
      [void updates(SubjectProfileSummaryBuilder b)]) = _$SubjectProfileSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubjectProfileSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SubjectProfileSummary> get serializer =>
      _$SubjectProfileSummarySerializer();
}

class _$SubjectProfileSummarySerializer
    implements PrimitiveSerializer<SubjectProfileSummary> {
  @override
  final Iterable<Type> types = const [
    SubjectProfileSummary,
    _$SubjectProfileSummary
  ];

  @override
  final String wireName = r'SubjectProfileSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SubjectProfileSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.subject != null) {
      yield r'subject';
      yield serializers.serialize(
        object.subject,
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
    if (object.totalPoints != null) {
      yield r'totalPoints';
      yield serializers.serialize(
        object.totalPoints,
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
    if (object.weakPoints != null) {
      yield r'weakPoints';
      yield serializers.serialize(
        object.weakPoints,
        specifiedType:
            const FullType(BuiltList, [FullType(KnowledgeProfileResponse)]),
      );
    }
    if (object.strongPoints != null) {
      yield r'strongPoints';
      yield serializers.serialize(
        object.strongPoints,
        specifiedType:
            const FullType(BuiltList, [FullType(KnowledgeProfileResponse)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SubjectProfileSummary object, {
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
    required SubjectProfileSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subject = valueDes;
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
        case r'totalPoints':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalPoints = valueDes;
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
        case r'weakPoints':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(KnowledgeProfileResponse)]),
          ) as BuiltList<KnowledgeProfileResponse>;
          result.weakPoints.replace(valueDes);
          break;
        case r'strongPoints':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(KnowledgeProfileResponse)]),
          ) as BuiltList<KnowledgeProfileResponse>;
          result.strongPoints.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SubjectProfileSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubjectProfileSummaryBuilder();
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
