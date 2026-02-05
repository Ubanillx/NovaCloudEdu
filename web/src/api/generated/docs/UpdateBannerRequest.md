# UpdateBannerRequest

更新轮播图请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 轮播图ID | [default to undefined]
**title** | **string** | 标题 | [default to undefined]
**imageUrl** | **string** | 图片URL | [default to undefined]
**linkType** | **number** | 跳转类型: 0-无跳转, 1-内部路由, 2-外部链接 | [optional] [default to undefined]
**linkUrl** | **string** | 跳转URL/路由 | [optional] [default to undefined]
**sort** | **number** | 排序权重，值越大越靠前 | [optional] [default to undefined]
**startTime** | **string** | 开始展示时间 | [optional] [default to undefined]
**endTime** | **string** | 结束展示时间 | [optional] [default to undefined]
**status** | **number** | 状态: 0-草稿, 1-已发布, 2-已下线 | [optional] [default to undefined]

## Example

```typescript
import { UpdateBannerRequest } from './api';

const instance: UpdateBannerRequest = {
    id,
    title,
    imageUrl,
    linkType,
    linkUrl,
    sort,
    startTime,
    endTime,
    status,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
