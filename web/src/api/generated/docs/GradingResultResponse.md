# GradingResultResponse

批改结果响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**submissionId** | **string** | 提交ID | [optional] [default to undefined]
**totalScore** | **number** | 总得分 | [optional] [default to undefined]
**maxScore** | **number** | 满分 | [optional] [default to undefined]
**overallComment** | **string** | 总评语 | [optional] [default to undefined]
**modelId** | **string** | 使用的AI模型 | [optional] [default to undefined]
**gradingTime** | **string** | 批改完成时间 | [optional] [default to undefined]
**questions** | [**Array&lt;QuestionGradingItem&gt;**](QuestionGradingItem.md) | 逐题批改详情 | [optional] [default to undefined]

## Example

```typescript
import { GradingResultResponse } from './api';

const instance: GradingResultResponse = {
    submissionId,
    totalScore,
    maxScore,
    overallComment,
    modelId,
    gradingTime,
    questions,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
