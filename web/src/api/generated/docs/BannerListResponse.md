# BannerListResponse

轮播图列表响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 轮播图ID | [optional] [default to undefined]
**title** | **string** | 标题 | [optional] [default to undefined]
**imageUrl** | **string** | 图片URL | [optional] [default to undefined]
**linkType** | **number** | 跳转类型: 0-无跳转, 1-内部路由, 2-外部链接 | [optional] [default to undefined]
**linkUrl** | **string** | 跳转URL/路由 | [optional] [default to undefined]

## Example

```typescript
import { BannerListResponse } from './api';

const instance: BannerListResponse = {
    id,
    title,
    imageUrl,
    linkType,
    linkUrl,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
