# CreateBannerRequest

创建轮播图请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**title** | **string** | 标题 | [default to undefined]
**imageUrl** | **string** | 图片URL | [default to undefined]
**linkType** | **number** | 跳转类型: 0-无跳转, 1-内部路由, 2-外部链接 | [optional] [default to undefined]
**linkUrl** | **string** | 跳转URL/路由 | [optional] [default to undefined]
**sort** | **number** | 排序权重，值越大越靠前 | [optional] [default to undefined]
**startTime** | **string** | 开始展示时间 | [optional] [default to undefined]
**endTime** | **string** | 结束展示时间 | [optional] [default to undefined]

## Example

```typescript
import { CreateBannerRequest } from './api';

const instance: CreateBannerRequest = {
    title,
    imageUrl,
    linkType,
    linkUrl,
    sort,
    startTime,
    endTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
