# TeacherResponse

讲师信息响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 讲师ID | [optional] [default to undefined]
**name** | **string** | 讲师姓名 | [optional] [default to undefined]
**introduction** | **string** | 讲师简介 | [optional] [default to undefined]
**expertise** | **Array&lt;string&gt;** | 专业领域 | [optional] [default to undefined]
**userId** | **number** | 关联用户ID | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**updateTime** | **string** | 更新时间 | [optional] [default to undefined]

## Example

```typescript
import { TeacherResponse } from './api';

const instance: TeacherResponse = {
    id,
    name,
    introduction,
    expertise,
    userId,
    createTime,
    updateTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
