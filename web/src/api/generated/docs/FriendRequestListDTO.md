# FriendRequestListDTO

好友申请列表请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**status** | **string** | 状态过滤：pending/accepted/rejected，不传则查询全部 | [optional] [default to undefined]
**pageNum** | **number** | 页码 | [optional] [default to 1]
**pageSize** | **number** | 每页数量 | [optional] [default to 20]

## Example

```typescript
import { FriendRequestListDTO } from './api';

const instance: FriendRequestListDTO = {
    status,
    pageNum,
    pageSize,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
