# WorkflowNodeResponse

工作流节点响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **string** | 节点ID | [optional] [default to undefined]
**type** | **string** | 节点类型 | [optional] [default to undefined]
**typeDescription** | **string** | 节点类型描述 | [optional] [default to undefined]
**name** | **string** | 节点名称 | [optional] [default to undefined]
**position** | [**PositionDTO**](PositionDTO.md) |  | [optional] [default to undefined]
**config** | **{ [key: string]: object; }** | 节点配置参数 | [optional] [default to undefined]
**errorHandling** | [**ErrorHandlingConfigDTO**](ErrorHandlingConfigDTO.md) |  | [optional] [default to undefined]

## Example

```typescript
import { WorkflowNodeResponse } from './api';

const instance: WorkflowNodeResponse = {
    id,
    type,
    typeDescription,
    name,
    position,
    config,
    errorHandling,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
