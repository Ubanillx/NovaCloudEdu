# ExamPaperResponse

试卷响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 试卷ID | [optional] [default to undefined]
**title** | **string** | 标题 | [optional] [default to undefined]
**subtitle** | **string** | 副标题 | [optional] [default to undefined]
**subject** | **string** | 学科 | [optional] [default to undefined]
**subjectDesc** | **string** | 学科描述 | [optional] [default to undefined]
**grade** | **string** | 年级 | [optional] [default to undefined]
**totalScore** | **number** | 总分 | [optional] [default to undefined]
**durationMin** | **number** | 考试时长(分钟) | [optional] [default to undefined]
**layout** | **string** | 排版配置JSON | [optional] [default to undefined]
**status** | **string** | 状态 | [optional] [default to undefined]
**statusDesc** | **string** | 状态描述 | [optional] [default to undefined]
**templateId** | **number** | 模板ID | [optional] [default to undefined]
**creatorId** | **number** | 创建者ID | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**updateTime** | **string** | 更新时间 | [optional] [default to undefined]

## Example

```typescript
import { ExamPaperResponse } from './api';

const instance: ExamPaperResponse = {
    id,
    title,
    subtitle,
    subject,
    subjectDesc,
    grade,
    totalScore,
    durationMin,
    layout,
    status,
    statusDesc,
    templateId,
    creatorId,
    createTime,
    updateTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
