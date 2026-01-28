//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/chapter_summary_id.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/chapter_id.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chapter_summary.g.dart';

/// ChapterSummary
///
/// Properties:
/// * [id]
/// * [chapterId]
/// * [summaryType]
/// * [content]
/// * [keyPoints]
/// * [aiModel]
/// * [cached]
/// * [createTime]
@BuiltValue()
abstract class ChapterSummary
    implements Built<ChapterSummary, ChapterSummaryBuilder> {
  @BuiltValueField(wireName: r'id')
  ChapterSummaryId? get id;

  @BuiltValueField(wireName: r'chapterId')
  ChapterId? get chapterId;

  @BuiltValueField(wireName: r'summaryType')
  ChapterSummarySummaryTypeEnum? get summaryType;
  // enum summaryTypeEnum {  BRIEF,  DETAILED,  KEYPOINTS,  };

  @BuiltValueField(wireName: r'content')
  String? get content;

  @BuiltValueField(wireName: r'keyPoints')
  BuiltList<String>? get keyPoints;

  @BuiltValueField(wireName: r'aiModel')
  String? get aiModel;

  @BuiltValueField(wireName: r'cached')
  bool? get cached;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  ChapterSummary._();

  factory ChapterSummary([void updates(ChapterSummaryBuilder b)]) =
      _$ChapterSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChapterSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChapterSummary> get serializer =>
      _$ChapterSummarySerializer();
}

class _$ChapterSummarySerializer
    implements PrimitiveSerializer<ChapterSummary> {
  @override
  final Iterable<Type> types = const [ChapterSummary, _$ChapterSummary];

  @override
  final String wireName = r'ChapterSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChapterSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(ChapterSummaryId),
      );
    }
    if (object.chapterId != null) {
      yield r'chapterId';
      yield serializers.serialize(
        object.chapterId,
        specifiedType: const FullType(ChapterId),
      );
    }
    if (object.summaryType != null) {
      yield r'summaryType';
      yield serializers.serialize(
        object.summaryType,
        specifiedType: const FullType(ChapterSummarySummaryTypeEnum),
      );
    }
    if (object.content != null) {
      yield r'content';
      yield serializers.serialize(
        object.content,
        specifiedType: const FullType(String),
      );
    }
    if (object.keyPoints != null) {
      yield r'keyPoints';
      yield serializers.serialize(
        object.keyPoints,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.aiModel != null) {
      yield r'aiModel';
      yield serializers.serialize(
        object.aiModel,
        specifiedType: const FullType(String),
      );
    }
    if (object.cached != null) {
      yield r'cached';
      yield serializers.serialize(
        object.cached,
        specifiedType: const FullType(bool),
      );
    }
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ChapterSummary object, {
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
    required ChapterSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChapterSummaryId),
          ) as ChapterSummaryId;
          result.id.replace(valueDes);
          break;
        case r'chapterId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChapterId),
          ) as ChapterId;
          result.chapterId.replace(valueDes);
          break;
        case r'summaryType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChapterSummarySummaryTypeEnum),
          ) as ChapterSummarySummaryTypeEnum;
          result.summaryType = valueDes;
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        case r'keyPoints':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.keyPoints.replace(valueDes);
          break;
        case r'aiModel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.aiModel = valueDes;
          break;
        case r'cached':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.cached = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
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
  ChapterSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChapterSummaryBuilder();
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

class ChapterSummarySummaryTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'BRIEF')
  static const ChapterSummarySummaryTypeEnum BRIEF =
      _$chapterSummarySummaryTypeEnum_BRIEF;
  @BuiltValueEnumConst(wireName: r'DETAILED')
  static const ChapterSummarySummaryTypeEnum DETAILED =
      _$chapterSummarySummaryTypeEnum_DETAILED;
  @BuiltValueEnumConst(wireName: r'KEYPOINTS')
  static const ChapterSummarySummaryTypeEnum KEYPOINTS =
      _$chapterSummarySummaryTypeEnum_KEYPOINTS;

  static Serializer<ChapterSummarySummaryTypeEnum> get serializer =>
      _$chapterSummarySummaryTypeEnumSerializer;

  const ChapterSummarySummaryTypeEnum._(String name) : super(name);

  static BuiltSet<ChapterSummarySummaryTypeEnum> get values =>
      _$chapterSummarySummaryTypeEnumValues;
  static ChapterSummarySummaryTypeEnum valueOf(String name) =>
      _$chapterSummarySummaryTypeEnumValueOf(name);
}
