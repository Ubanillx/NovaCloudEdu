# PaperQuestionResponse

试卷题目关联响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 关联ID | [optional] [default to undefined]
**sectionId** | **number** | 大题ID | [optional] [default to undefined]
**questionId** | **number** | 题目ID | [optional] [default to undefined]
**score** | **number** | 分值 | [optional] [default to undefined]
**sortOrder** | **number** | 排序 | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**updateTime** | **string** | 更新时间 | [optional] [default to undefined]

## Example

```typescript
import { PaperQuestionResponse } from './api';

const instance: PaperQuestionResponse = {
    id,
    sectionId,
    questionId,
    score,
    sortOrder,
    createTime,
    updateTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
