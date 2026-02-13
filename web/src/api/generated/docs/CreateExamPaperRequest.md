# CreateExamPaperRequest

创建试卷请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**title** | **string** | 试卷标题 | [default to undefined]
**subtitle** | **string** | 副标题 | [optional] [default to undefined]
**subject** | **string** | 学科 | [default to undefined]
**grade** | **string** | 年级 | [optional] [default to undefined]
**durationMin** | **number** | 考试时长(分钟) | [optional] [default to undefined]
**layout** | **string** | 排版配置JSON | [optional] [default to undefined]
**templateId** | **number** | 模板ID | [optional] [default to undefined]

## Example

```typescript
import { CreateExamPaperRequest } from './api';

const instance: CreateExamPaperRequest = {
    title,
    subtitle,
    subject,
    grade,
    durationMin,
    layout,
    templateId,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
