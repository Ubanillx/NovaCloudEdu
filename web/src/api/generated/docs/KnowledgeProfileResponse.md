# KnowledgeProfileResponse

知识画像响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**knowledgePoint** | **string** | 知识点名称 | [optional] [default to undefined]
**subject** | **string** | 学科 | [optional] [default to undefined]
**masteryLevel** | **number** | 掌握度 0.0~1.0 | [optional] [default to undefined]
**masteryGrade** | **string** | 掌握度等级: EXCELLENT/GOOD/MEDIUM/WEAK/VERY_WEAK | [optional] [default to undefined]
**totalAttempts** | **number** | 总答题次数 | [optional] [default to undefined]
**correctCount** | **number** | 正确次数 | [optional] [default to undefined]
**correctRate** | **number** | 正确率 | [optional] [default to undefined]
**recentErrorCategories** | **Array&lt;string&gt;** | 近期错误类型 | [optional] [default to undefined]
**weakPoint** | **boolean** | 是否薄弱知识点 | [optional] [default to undefined]
**lastUpdated** | **string** | 最近更新时间 | [optional] [default to undefined]

## Example

```typescript
import { KnowledgeProfileResponse } from './api';

const instance: KnowledgeProfileResponse = {
    knowledgePoint,
    subject,
    masteryLevel,
    masteryGrade,
    totalAttempts,
    correctCount,
    correctRate,
    recentErrorCategories,
    weakPoint,
    lastUpdated,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
