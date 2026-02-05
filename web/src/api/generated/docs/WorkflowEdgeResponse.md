# WorkflowEdgeResponse

工作流连接线响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **string** | 连接线ID | [optional] [default to undefined]
**sourceNodeId** | **string** | 源节点ID | [optional] [default to undefined]
**targetNodeId** | **string** | 目标节点ID | [optional] [default to undefined]
**sourceHandle** | **string** | 源节点输出句柄 | [optional] [default to undefined]
**targetHandle** | **string** | 目标节点输入句柄 | [optional] [default to undefined]
**condition** | **string** | 条件表达式 | [optional] [default to undefined]
**label** | **string** | 连接线标签 | [optional] [default to undefined]

## Example

```typescript
import { WorkflowEdgeResponse } from './api';

const instance: WorkflowEdgeResponse = {
    id,
    sourceNodeId,
    targetNodeId,
    sourceHandle,
    targetHandle,
    condition,
    label,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
