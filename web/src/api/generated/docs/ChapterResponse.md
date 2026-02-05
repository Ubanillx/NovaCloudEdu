# ChapterResponse

章节信息响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 章节ID | [optional] [default to undefined]
**courseId** | **number** | 课程ID | [optional] [default to undefined]
**title** | **string** | 章节标题 | [optional] [default to undefined]
**description** | **string** | 章节描述 | [optional] [default to undefined]
**sort** | **number** | 排序 | [optional] [default to undefined]
**sections** | [**Array&lt;SectionResponse&gt;**](SectionResponse.md) | 小节列表 | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**updateTime** | **string** | 更新时间 | [optional] [default to undefined]

## Example

```typescript
import { ChapterResponse } from './api';

const instance: ChapterResponse = {
    id,
    courseId,
    title,
    description,
    sort,
    sections,
    createTime,
    updateTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
