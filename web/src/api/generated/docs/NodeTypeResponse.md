# NodeTypeResponse

节点类型响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | **string** | 节点类型枚举值 | [optional] [default to undefined]
**description** | **string** | 节点类型描述 | [optional] [default to undefined]
**category** | **string** | 节点分类 | [optional] [default to undefined]
**icon** | **string** | 节点图标 | [optional] [default to undefined]
**configFields** | [**Array&lt;ConfigFieldDTO&gt;**](ConfigFieldDTO.md) | 配置参数模板 | [optional] [default to undefined]

## Example

```typescript
import { NodeTypeResponse } from './api';

const instance: NodeTypeResponse = {
    type,
    description,
    category,
    icon,
    configFields,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
