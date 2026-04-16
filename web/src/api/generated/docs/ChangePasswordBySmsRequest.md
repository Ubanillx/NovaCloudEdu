# ChangePasswordBySmsRequest

用户通过短信验证码修改密码请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**smsCode** | **string** | 短信验证码 | [default to undefined]
**newPassword** | **string** | 新密码 | [default to undefined]
**confirmPassword** | **string** | 确认密码 | [default to undefined]

## Example

```typescript
import { ChangePasswordBySmsRequest } from './api';

const instance: ChangePasswordBySmsRequest = {
    smsCode,
    newPassword,
    confirmPassword,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
