# SubmitHomeworkRequest

提交作业请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**gradingMode** | **string** | 批改模式: EXAM_PAPER(试卷批改) / GENERAL(通用作业助手)，默认 GENERAL | [optional] [default to undefined]
**title** | **string** | 作业标题（通用模式可自定义，如\&#39;人教版三年级数学第五章练习\&#39;） | [optional] [default to undefined]
**subject** | **string** | 学科: MATH/CHINESE/ENGLISH/...（可选，通用模式AI自动推断） | [optional] [default to undefined]
**grade** | **string** | 年级 | [optional] [default to undefined]
**imageUrls** | **Array&lt;string&gt;** | 作业图片 OSS URL 列表 | [default to undefined]
**classId** | **number** | 班级ID（可选） | [optional] [default to undefined]
**examPaperId** | **number** | 关联试卷ID（试卷批改模式时传入） | [optional] [default to undefined]

## Example

```typescript
import { SubmitHomeworkRequest } from './api';

const instance: SubmitHomeworkRequest = {
    gradingMode,
    title,
    subject,
    grade,
    imageUrls,
    classId,
    examPaperId,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
