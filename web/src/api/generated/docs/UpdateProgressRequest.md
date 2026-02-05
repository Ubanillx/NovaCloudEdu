# UpdateProgressRequest

更新学习进度请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**courseId** | **number** | 课程ID | [default to undefined]
**sectionId** | **number** | 小节ID | [default to undefined]
**lastPosition** | **number** | 上次观看位置(秒) | [default to undefined]
**watchDuration** | **number** | 观看时长(秒) | [default to undefined]
**progress** | **number** | 学习进度(百分比) | [default to undefined]

## Example

```typescript
import { UpdateProgressRequest } from './api';

const instance: UpdateProgressRequest = {
    courseId,
    sectionId,
    lastPosition,
    watchDuration,
    progress,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
