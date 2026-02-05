# QueryBannerRequest

查询轮播图请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**title** | **string** | 标题关键词 | [optional] [default to undefined]
**status** | **number** | 状态: 0-草稿, 1-已发布, 2-已下线 | [optional] [default to undefined]
**adminId** | **number** | 创建者ID | [optional] [default to undefined]
**pageNum** | **number** | 页码 | [optional] [default to undefined]
**pageSize** | **number** | 每页数量 | [optional] [default to undefined]

## Example

```typescript
import { QueryBannerRequest } from './api';

const instance: QueryBannerRequest = {
    title,
    status,
    adminId,
    pageNum,
    pageSize,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
