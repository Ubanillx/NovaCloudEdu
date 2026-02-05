# SearchUserPageResponse

搜索用户分页响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**records** | [**Array&lt;SearchUserResponse&gt;**](SearchUserResponse.md) | 用户列表 | [optional] [default to undefined]
**total** | **number** | 总数 | [optional] [default to undefined]
**pageNum** | **number** | 当前页码 | [optional] [default to undefined]
**pageSize** | **number** | 每页数量 | [optional] [default to undefined]
**totalPages** | **number** | 总页数 | [optional] [default to undefined]

## Example

```typescript
import { SearchUserPageResponse } from './api';

const instance: SearchUserPageResponse = {
    records,
    total,
    pageNum,
    pageSize,
    totalPages,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
