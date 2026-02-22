import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

// tests for GradingStatsResponse
void main() {
  final instance = GradingStatsResponseBuilder();
  // TODO add properties to the builder and call build()

  group(GradingStatsResponse, () {
    // 总批改次数
    // int totalSubmissions
    test('to test the property `totalSubmissions`', () async {
      // TODO
    });

    // 平均得分率（0.0~1.0）
    // double avgScoreRate
    test('to test the property `avgScoreRate`', () async {
      // TODO
    });

    // 最近10次得分趋势 [{submissionId, score, maxScore, subject, createTime}]
    // BuiltList<ScoreTrendItem> scoreTrend
    test('to test the property `scoreTrend`', () async {
      // TODO
    });

    // 学科得分分布 {subject: avgScoreRate}
    // BuiltMap<String, double> subjectScoreRates
    test('to test the property `subjectScoreRates`', () async {
      // TODO
    });

    // 错因分布（Top 错误类型及次数）
    // BuiltList<ErrorCategoryCount> errorDistribution
    test('to test the property `errorDistribution`', () async {
      // TODO
    });
  });
}
