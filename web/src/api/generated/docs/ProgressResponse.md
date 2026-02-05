# ProgressResponse

学习进度响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 进度ID | [optional] [default to undefined]
**userId** | **number** | 用户ID | [optional] [default to undefined]
**courseId** | **number** | 课程ID | [optional] [default to undefined]
**sectionId** | **number** | 小节ID | [optional] [default to undefined]
**progress** | **number** | 学习进度(百分比) | [optional] [default to undefined]
**watchDuration** | **number** | 观看时长(秒) | [optional] [default to undefined]
**lastPosition** | **number** | 上次观看位置(秒) | [optional] [default to undefined]
**isCompleted** | **boolean** | 是否完成 | [optional] [default to undefined]
**completedTime** | **string** | 完成时间 | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**updateTime** | **string** | 更新时间 | [optional] [default to undefined]

## Example

```typescript
import { ProgressResponse } from './api';

const instance: ProgressResponse = {
    id,
    userId,
    courseId,
    sectionId,
    progress,
    watchDuration,
    lastPosition,
    isCompleted,
    completedTime,
    createTime,
    updateTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
