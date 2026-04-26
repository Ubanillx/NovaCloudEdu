# GroupPageResponse

群聊搜索分页响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**groups** | [**Array&lt;GroupResponse&gt;**](GroupResponse.md) | 群聊列表 | [optional] [default to undefined]
**total** | **number** | 总数 | [optional] [default to undefined]
**pageNum** | **number** | 当前页码 | [optional] [default to undefined]
**pageSize** | **number** | 每页数量 | [optional] [default to undefined]
**totalPages** | **number** | 总页数 | [optional] [default to undefined]

## Example

```typescript
import { GroupPageResponse } from './api';

const instance: GroupPageResponse = {
    groups,
    total,
    pageNum,
    pageSize,
    totalPages,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
