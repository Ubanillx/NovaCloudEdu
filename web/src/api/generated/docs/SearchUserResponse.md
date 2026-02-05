# SearchUserResponse

搜索用户响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**userId** | **number** | 用户ID | [optional] [default to undefined]
**userAccount** | **string** | 用户账号 | [optional] [default to undefined]
**userName** | **string** | 用户名 | [optional] [default to undefined]
**userAvatar** | **string** | 用户头像 | [optional] [default to undefined]
**userProfile** | **string** | 个人简介 | [optional] [default to undefined]
**isFriend** | **boolean** | 是否已是好友 | [optional] [default to undefined]
**hasPendingRequest** | **boolean** | 是否有待处理的申请 | [optional] [default to undefined]

## Example

```typescript
import { SearchUserResponse } from './api';

const instance: SearchUserResponse = {
    userId,
    userAccount,
    userName,
    userAvatar,
    userProfile,
    isFriend,
    hasPendingRequest,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
