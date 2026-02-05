# FriendRequestPageResponse

好友申请分页响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**records** | [**Array&lt;FriendRequestResponse&gt;**](FriendRequestResponse.md) | 好友申请列表 | [optional] [default to undefined]
**total** | **number** | 总数 | [optional] [default to undefined]
**pageNum** | **number** | 当前页码 | [optional] [default to undefined]
**pageSize** | **number** | 每页数量 | [optional] [default to undefined]
**totalPages** | **number** | 总页数 | [optional] [default to undefined]

## Example

```typescript
import { FriendRequestPageResponse } from './api';

const instance: FriendRequestPageResponse = {
    records,
    total,
    pageNum,
    pageSize,
    totalPages,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
