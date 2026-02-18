# QuestionGradingItem

单题批改详情

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**questionIndex** | **number** | 题号 | [optional] [default to undefined]
**questionContent** | **string** | 题干 | [optional] [default to undefined]
**questionType** | **string** | 题型 | [optional] [default to undefined]
**studentAnswer** | **string** | 学生答案 | [optional] [default to undefined]
**standardAnswer** | **string** | 标准答案 | [optional] [default to undefined]
**score** | **number** | 得分 | [optional] [default to undefined]
**maxScore** | **number** | 满分 | [optional] [default to undefined]
**errorCategories** | **Array&lt;string&gt;** | 错误分类 | [optional] [default to undefined]
**errorDetail** | **string** | 错误详情 | [optional] [default to undefined]
**knowledgePoints** | **Array&lt;string&gt;** | 关联知识点 | [optional] [default to undefined]
**comment** | **string** | 评语 | [optional] [default to undefined]

## Example

```typescript
import { QuestionGradingItem } from './api';

const instance: QuestionGradingItem = {
    questionIndex,
    questionContent,
    questionType,
    studentAnswer,
    standardAnswer,
    score,
    maxScore,
    errorCategories,
    errorDetail,
    knowledgePoints,
    comment,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
