# AddVariableRequest

添加工作流变量请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **string** | 变量名称 | [default to undefined]
**type** | **string** | 变量类型 | [default to undefined]
**defaultValue** | **object** | 默认值 | [optional] [default to undefined]
**description** | **string** | 变量描述 | [optional] [default to undefined]

## Example

```typescript
import { AddVariableRequest } from './api';

const instance: AddVariableRequest = {
    name,
    type,
    defaultValue,
    description,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
