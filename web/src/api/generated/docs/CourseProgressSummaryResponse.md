# CourseProgressSummaryResponse

课程进度汇总响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**courseId** | **number** | 课程ID | [optional] [default to undefined]
**totalSections** | **number** | 总小节数 | [optional] [default to undefined]
**completedSections** | **number** | 已完成小节数 | [optional] [default to undefined]
**overallProgress** | **number** | 课程整体进度(百分比) | [optional] [default to undefined]
**completionRate** | **number** | 完成率(百分比) | [optional] [default to undefined]

## Example

```typescript
import { CourseProgressSummaryResponse } from './api';

const instance: CourseProgressSummaryResponse = {
    courseId,
    totalSections,
    completedSections,
    overallProgress,
    completionRate,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
