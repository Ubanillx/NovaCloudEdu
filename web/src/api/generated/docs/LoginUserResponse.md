# LoginUserResponse

登录用户信息

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 用户ID | [optional] [default to undefined]
**userAccount** | **string** | 用户账号 | [optional] [default to undefined]
**userName** | **string** | 用户昵称 | [optional] [default to undefined]
**userAvatar** | **string** | 用户头像 | [optional] [default to undefined]
**userProfile** | **string** | 用户简介 | [optional] [default to undefined]
**userRole** | **string** | 用户角色 | [optional] [default to undefined]
**userGender** | **number** | 用户性别 | [optional] [default to undefined]
**userPhone** | **string** | 用户手机 | [optional] [default to undefined]
**userEmail** | **string** | 用户邮箱 | [optional] [default to undefined]
**level** | **number** | 等级 | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**token** | **string** | JWT Token (Access Token) | [optional] [default to undefined]
**refreshToken** | **string** | Refresh Token (用于刷新Access Token) | [optional] [default to undefined]

## Example

```typescript
import { LoginUserResponse } from './api';

const instance: LoginUserResponse = {
    id,
    userAccount,
    userName,
    userAvatar,
    userProfile,
    userRole,
    userGender,
    userPhone,
    userEmail,
    level,
    createTime,
    token,
    refreshToken,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
