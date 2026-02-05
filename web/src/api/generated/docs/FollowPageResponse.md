# FollowPageResponse

关注分页响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**users** | [**Array&lt;FollowUserResponse&gt;**](FollowUserResponse.md) | 用户列表 | [optional] [default to undefined]
**total** | **number** | 总数 | [optional] [default to undefined]
**pageNum** | **number** | 当前页码 | [optional] [default to undefined]
**pageSize** | **number** | 每页数量 | [optional] [default to undefined]
**totalPages** | **number** | 总页数 | [optional] [default to undefined]

## Example

```typescript
import { FollowPageResponse } from './api';

const instance: FollowPageResponse = {
    users,
    total,
    pageNum,
    pageSize,
    totalPages,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
