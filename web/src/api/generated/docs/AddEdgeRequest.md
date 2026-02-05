# AddEdgeRequest

添加工作流连接线请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**edgeId** | **string** | 连接线唯一标识 | [default to undefined]
**sourceNodeId** | **string** | 源节点ID | [default to undefined]
**targetNodeId** | **string** | 目标节点ID | [default to undefined]
**sourceHandle** | **string** | 源节点输出句柄 | [optional] [default to undefined]
**targetHandle** | **string** | 目标节点输入句柄 | [optional] [default to undefined]
**condition** | **string** | 条件表达式（用于条件分支） | [optional] [default to undefined]
**label** | **string** | 连接线标签 | [optional] [default to undefined]

## Example

```typescript
import { AddEdgeRequest } from './api';

const instance: AddEdgeRequest = {
    edgeId,
    sourceNodeId,
    targetNodeId,
    sourceHandle,
    targetHandle,
    condition,
    label,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
