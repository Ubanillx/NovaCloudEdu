# ApplyTeacherRequest

讲师申请请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **string** | 讲师姓名 | [default to undefined]
**introduction** | **string** | 讲师简介 | [optional] [default to undefined]
**expertise** | **Array&lt;string&gt;** | 专业领域 | [default to undefined]
**certificateUrl** | **string** | 资质证书URL | [optional] [default to undefined]

## Example

```typescript
import { ApplyTeacherRequest } from './api';

const instance: ApplyTeacherRequest = {
    name,
    introduction,
    expertise,
    certificateUrl,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
