# CreateSectionRequest

创建小节请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**chapterId** | **number** | 章节ID | [default to undefined]
**title** | **string** | 小节标题 | [default to undefined]
**description** | **string** | 小节描述 | [optional] [default to undefined]
**videoUrl** | **string** | 视频URL | [optional] [default to undefined]
**duration** | **number** | 时长(秒) | [default to undefined]
**sort** | **number** | 排序，数字越小排序越靠前 | [default to undefined]
**isFree** | **boolean** | 是否免费：false-否，true-是 | [default to undefined]
**resourceUrl** | **string** | 资源URL | [optional] [default to undefined]

## Example

```typescript
import { CreateSectionRequest } from './api';

const instance: CreateSectionRequest = {
    chapterId,
    title,
    description,
    videoUrl,
    duration,
    sort,
    isFree,
    resourceUrl,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
