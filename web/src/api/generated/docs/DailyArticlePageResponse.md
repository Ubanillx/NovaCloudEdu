# DailyArticlePageResponse

每日文章分页响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**records** | [**Array&lt;DailyArticleResponse&gt;**](DailyArticleResponse.md) | 文章列表 | [optional] [default to undefined]
**total** | **number** | 总记录数 | [optional] [default to undefined]
**pageNum** | **number** | 当前页码 | [optional] [default to undefined]
**pageSize** | **number** | 每页大小 | [optional] [default to undefined]
**totalPages** | **number** | 总页数 | [optional] [default to undefined]

## Example

```typescript
import { DailyArticlePageResponse } from './api';

const instance: DailyArticlePageResponse = {
    records,
    total,
    pageNum,
    pageSize,
    totalPages,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
