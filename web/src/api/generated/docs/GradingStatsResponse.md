# GradingStatsResponse

批改历史统计响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**totalSubmissions** | **number** | 总批改次数 | [optional] [default to undefined]
**avgScoreRate** | **number** | 平均得分率（0.0~1.0） | [optional] [default to undefined]
**scoreTrend** | [**Array&lt;ScoreTrendItem&gt;**](ScoreTrendItem.md) | 最近10次得分趋势 [{submissionId, score, maxScore, subject, createTime}] | [optional] [default to undefined]
**subjectScoreRates** | **{ [key: string]: number; }** | 学科得分分布 {subject: avgScoreRate} | [optional] [default to undefined]
**errorDistribution** | [**Array&lt;ErrorCategoryCount&gt;**](ErrorCategoryCount.md) | 错因分布（Top 错误类型及次数） | [optional] [default to undefined]

## Example

```typescript
import { GradingStatsResponse } from './api';

const instance: GradingStatsResponse = {
    totalSubmissions,
    avgScoreRate,
    scoreTrend,
    subjectScoreRates,
    errorDistribution,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
