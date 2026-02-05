# UpdateTeacherRequest

更新讲师信息请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **string** | 讲师姓名 | [default to undefined]
**introduction** | **string** | 讲师简介 | [optional] [default to undefined]
**expertise** | **Array&lt;string&gt;** | 专业领域 | [default to undefined]

## Example

```typescript
import { UpdateTeacherRequest } from './api';

const instance: UpdateTeacherRequest = {
    name,
    introduction,
    expertise,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
