//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/error_category_count.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/score_trend_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'grading_stats_response.g.dart';

/// 批改历史统计响应
///
/// Properties:
/// * [totalSubmissions] - 总批改次数
/// * [avgScoreRate] - 平均得分率（0.0~1.0）
/// * [scoreTrend] - 最近10次得分趋势 [{submissionId, score, maxScore, subject, createTime}]
/// * [subjectScoreRates] - 学科得分分布 {subject: avgScoreRate}
/// * [errorDistribution] - 错因分布（Top 错误类型及次数）
@BuiltValue()
abstract class GradingStatsResponse
    implements Built<GradingStatsResponse, GradingStatsResponseBuilder> {
  /// 总批改次数
  @BuiltValueField(wireName: r'totalSubmissions')
  int? get totalSubmissions;

  /// 平均得分率（0.0~1.0）
  @BuiltValueField(wireName: r'avgScoreRate')
  double? get avgScoreRate;

  /// 最近10次得分趋势 [{submissionId, score, maxScore, subject, createTime}]
  @BuiltValueField(wireName: r'scoreTrend')
  BuiltList<ScoreTrendItem>? get scoreTrend;

  /// 学科得分分布 {subject: avgScoreRate}
  @BuiltValueField(wireName: r'subjectScoreRates')
  BuiltMap<String, double>? get subjectScoreRates;

  /// 错因分布（Top 错误类型及次数）
  @BuiltValueField(wireName: r'errorDistribution')
  BuiltList<ErrorCategoryCount>? get errorDistribution;

  GradingStatsResponse._();

  factory GradingStatsResponse([void updates(GradingStatsResponseBuilder b)]) =
      _$GradingStatsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GradingStatsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GradingStatsResponse> get serializer =>
      _$GradingStatsResponseSerializer();
}

class _$GradingStatsResponseSerializer
    implements PrimitiveSerializer<GradingStatsResponse> {
  @override
  final Iterable<Type> types = const [
    GradingStatsResponse,
    _$GradingStatsResponse
  ];

  @override
  final String wireName = r'GradingStatsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GradingStatsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.totalSubmissions != null) {
      yield r'totalSubmissions';
      yield serializers.serialize(
        object.totalSubmissions,
        specifiedType: const FullType(int),
      );
    }
    if (object.avgScoreRate != null) {
      yield r'avgScoreRate';
      yield serializers.serialize(
        object.avgScoreRate,
        specifiedType: const FullType(double),
      );
    }
    if (object.scoreTrend != null) {
      yield r'scoreTrend';
      yield serializers.serialize(
        object.scoreTrend,
        specifiedType: const FullType(BuiltList, [FullType(ScoreTrendItem)]),
      );
    }
    if (object.subjectScoreRates != null) {
      yield r'subjectScoreRates';
      yield serializers.serialize(
        object.subjectScoreRates,
        specifiedType:
            const FullType(BuiltMap, [FullType(String), FullType(double)]),
      );
    }
    if (object.errorDistribution != null) {
      yield r'errorDistribution';
      yield serializers.serialize(
        object.errorDistribution,
        specifiedType:
            const FullType(BuiltList, [FullType(ErrorCategoryCount)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GradingStatsResponse object, {
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
    required GradingStatsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'totalSubmissions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalSubmissions = valueDes;
          break;
        case r'avgScoreRate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.avgScoreRate = valueDes;
          break;
        case r'scoreTrend':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(ScoreTrendItem)]),
          ) as BuiltList<ScoreTrendItem>;
          result.scoreTrend.replace(valueDes);
          break;
        case r'subjectScoreRates':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltMap, [FullType(String), FullType(double)]),
          ) as BuiltMap<String, double>;
          result.subjectScoreRates.replace(valueDes);
          break;
        case r'errorDistribution':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(ErrorCategoryCount)]),
          ) as BuiltList<ErrorCategoryCount>;
          result.errorDistribution.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GradingStatsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GradingStatsResponseBuilder();
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
