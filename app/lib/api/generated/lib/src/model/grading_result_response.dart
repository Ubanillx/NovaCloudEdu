//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/question_grading_item.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'grading_result_response.g.dart';

/// 批改结果响应
///
/// Properties:
/// * [submissionId] - 提交ID
/// * [totalScore] - 总得分
/// * [maxScore] - 满分
/// * [overallComment] - 总评语
/// * [modelId] - 使用的AI模型
/// * [gradingTime] - 批改完成时间
/// * [questions] - 逐题批改详情
@BuiltValue()
abstract class GradingResultResponse
    implements Built<GradingResultResponse, GradingResultResponseBuilder> {
  /// 提交ID
  @BuiltValueField(wireName: r'submissionId')
  String? get submissionId;

  /// 总得分
  @BuiltValueField(wireName: r'totalScore')
  int? get totalScore;

  /// 满分
  @BuiltValueField(wireName: r'maxScore')
  int? get maxScore;

  /// 总评语
  @BuiltValueField(wireName: r'overallComment')
  String? get overallComment;

  /// 使用的AI模型
  @BuiltValueField(wireName: r'modelId')
  String? get modelId;

  /// 批改完成时间
  @BuiltValueField(wireName: r'gradingTime')
  DateTime? get gradingTime;

  /// 逐题批改详情
  @BuiltValueField(wireName: r'questions')
  BuiltList<QuestionGradingItem>? get questions;

  GradingResultResponse._();

  factory GradingResultResponse(
      [void updates(GradingResultResponseBuilder b)]) = _$GradingResultResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GradingResultResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GradingResultResponse> get serializer =>
      _$GradingResultResponseSerializer();
}

class _$GradingResultResponseSerializer
    implements PrimitiveSerializer<GradingResultResponse> {
  @override
  final Iterable<Type> types = const [
    GradingResultResponse,
    _$GradingResultResponse
  ];

  @override
  final String wireName = r'GradingResultResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GradingResultResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.submissionId != null) {
      yield r'submissionId';
      yield serializers.serialize(
        object.submissionId,
        specifiedType: const FullType(String),
      );
    }
    if (object.totalScore != null) {
      yield r'totalScore';
      yield serializers.serialize(
        object.totalScore,
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
    if (object.overallComment != null) {
      yield r'overallComment';
      yield serializers.serialize(
        object.overallComment,
        specifiedType: const FullType(String),
      );
    }
    if (object.modelId != null) {
      yield r'modelId';
      yield serializers.serialize(
        object.modelId,
        specifiedType: const FullType(String),
      );
    }
    if (object.gradingTime != null) {
      yield r'gradingTime';
      yield serializers.serialize(
        object.gradingTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.questions != null) {
      yield r'questions';
      yield serializers.serialize(
        object.questions,
        specifiedType:
            const FullType(BuiltList, [FullType(QuestionGradingItem)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GradingResultResponse object, {
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
    required GradingResultResponseBuilder result,
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
        case r'totalScore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalScore = valueDes;
          break;
        case r'maxScore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.maxScore = valueDes;
          break;
        case r'overallComment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.overallComment = valueDes;
          break;
        case r'modelId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.modelId = valueDes;
          break;
        case r'gradingTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.gradingTime = valueDes;
          break;
        case r'questions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(QuestionGradingItem)]),
          ) as BuiltList<QuestionGradingItem>;
          result.questions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GradingResultResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GradingResultResponseBuilder();
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
