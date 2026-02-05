# UserRegisterRequest

用户注册请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**userAccount** | **string** | 用户账号 | [default to undefined]
**userPassword** | **string** | 用户密码 | [default to undefined]
**checkPassword** | **string** | 确认密码 | [default to undefined]
**phone** | **string** | 手机号 | [default to undefined]
**smsCode** | **string** | 短信验证码 | [default to undefined]

## Example

```typescript
import { UserRegisterRequest } from './api';

const instance: UserRegisterRequest = {
    userAccount,
    userPassword,
    checkPassword,
    phone,
    smsCode,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
