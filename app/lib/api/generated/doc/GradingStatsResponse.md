# nova_api.model.GradingStatsResponse

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**totalSubmissions** | **int** | 总批改次数 | [optional] 
**avgScoreRate** | **double** | 平均得分率（0.0~1.0） | [optional] 
**scoreTrend** | [**BuiltList&lt;ScoreTrendItem&gt;**](ScoreTrendItem.md) | 最近10次得分趋势 [{submissionId, score, maxScore, subject, createTime}] | [optional] 
**subjectScoreRates** | **BuiltMap&lt;String, double&gt;** | 学科得分分布 {subject: avgScoreRate} | [optional] 
**errorDistribution** | [**BuiltList&lt;ErrorCategoryCount&gt;**](ErrorCategoryCount.md) | 错因分布（Top 错误类型及次数） | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


