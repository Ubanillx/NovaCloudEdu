# SectionResponse

小节信息响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 小节ID | [optional] [default to undefined]
**courseId** | **number** | 课程ID | [optional] [default to undefined]
**chapterId** | **number** | 章节ID | [optional] [default to undefined]
**title** | **string** | 小节标题 | [optional] [default to undefined]
**description** | **string** | 小节描述 | [optional] [default to undefined]
**videoUrl** | **string** | 视频URL | [optional] [default to undefined]
**duration** | **number** | 时长(秒) | [optional] [default to undefined]
**sort** | **number** | 排序 | [optional] [default to undefined]
**isFree** | **boolean** | 是否免费 | [optional] [default to undefined]
**resourceUrl** | **string** | 资源URL | [optional] [default to undefined]
**hlsUrl** | **string** | HLS播放地址(m3u8) | [optional] [default to undefined]
**accessible** | **boolean** | 当前用户是否可访问此小节 | [optional] [default to undefined]
**transcodeStatus** | **number** | 转码状态: 0-未转码, 1-转码中, 2-已完成, 3-失败 | [optional] [default to undefined]
**thumbnailUrl** | **string** | 缩略图雪碧图URL | [optional] [default to undefined]
**thumbnailCount** | **number** | 缩略图数量 | [optional] [default to undefined]
**encryptionKeyId** | **string** | 加密密钥ID（用于HLS解密） | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**updateTime** | **string** | 更新时间 | [optional] [default to undefined]

## Example

```typescript
import { SectionResponse } from './api';

const instance: SectionResponse = {
    id,
    courseId,
    chapterId,
    title,
    description,
    videoUrl,
    duration,
    sort,
    isFree,
    resourceUrl,
    hlsUrl,
    accessible,
    transcodeStatus,
    thumbnailUrl,
    thumbnailCount,
    encryptionKeyId,
    createTime,
    updateTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
