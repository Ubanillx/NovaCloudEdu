# SubmissionStatusResponse

作业提交状态响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**submissionId** | **string** | 提交ID | [optional] [default to undefined]
**gradingMode** | **string** | 批改模式: EXAM_PAPER/GENERAL | [optional] [default to undefined]
**title** | **string** | 作业标题 | [optional] [default to undefined]
**subject** | **string** | 学科（可能为null，通用模式下AI推断后回填） | [optional] [default to undefined]
**grade** | **string** | 年级 | [optional] [default to undefined]
**imageUrls** | **Array&lt;string&gt;** | 作业图片URL列表 | [optional] [default to undefined]
**status** | **string** | 批改状态: PENDING/OCR_PROCESSING/GRADING/COMPLETED/FAILED | [optional] [default to undefined]
**examPaperId** | **string** | 关联试卷ID | [optional] [default to undefined]
**totalScore** | **number** | 总得分（已完成时有值） | [optional] [default to undefined]
**maxScore** | **number** | 满分（已完成时有值） | [optional] [default to undefined]
**createTime** | **string** | 提交时间 | [optional] [default to undefined]

## Example

```typescript
import { SubmissionStatusResponse } from './api';

const instance: SubmissionStatusResponse = {
    submissionId,
    gradingMode,
    title,
    subject,
    grade,
    imageUrls,
    status,
    examPaperId,
    totalScore,
    maxScore,
    createTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
