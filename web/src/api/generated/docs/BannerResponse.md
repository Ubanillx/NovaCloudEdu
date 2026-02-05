# BannerResponse

轮播图响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 轮播图ID | [optional] [default to undefined]
**title** | **string** | 标题 | [optional] [default to undefined]
**imageUrl** | **string** | 图片URL | [optional] [default to undefined]
**linkType** | **number** | 跳转类型: 0-无跳转, 1-内部路由, 2-外部链接 | [optional] [default to undefined]
**linkTypeDesc** | **string** | 跳转类型描述 | [optional] [default to undefined]
**linkUrl** | **string** | 跳转URL/路由 | [optional] [default to undefined]
**sort** | **number** | 排序权重 | [optional] [default to undefined]
**status** | **number** | 状态: 0-草稿, 1-已发布, 2-已下线 | [optional] [default to undefined]
**statusDesc** | **string** | 状态描述 | [optional] [default to undefined]
**startTime** | **string** | 开始展示时间 | [optional] [default to undefined]
**endTime** | **string** | 结束展示时间 | [optional] [default to undefined]
**adminId** | **number** | 创建者ID | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**updateTime** | **string** | 更新时间 | [optional] [default to undefined]

## Example

```typescript
import { BannerResponse } from './api';

const instance: BannerResponse = {
    id,
    title,
    imageUrl,
    linkType,
    linkTypeDesc,
    linkUrl,
    sort,
    status,
    statusDesc,
    startTime,
    endTime,
    adminId,
    createTime,
    updateTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
