# WorkflowDefinitionResponse

工作流定义详情响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**workflowId** | **number** | 工作流ID | [optional] [default to undefined]
**workflowName** | **string** | 工作流名称 | [optional] [default to undefined]
**version** | **string** | 定义版本 | [optional] [default to undefined]
**nodes** | [**Array&lt;WorkflowNodeResponse&gt;**](WorkflowNodeResponse.md) | 节点列表 | [optional] [default to undefined]
**edges** | [**Array&lt;WorkflowEdgeResponse&gt;**](WorkflowEdgeResponse.md) | 连接线列表 | [optional] [default to undefined]
**variables** | [**{ [key: string]: WorkflowVariableResponse; }**](WorkflowVariableResponse.md) | 变量定义 | [optional] [default to undefined]
**settings** | [**WorkflowSettingsDTO**](WorkflowSettingsDTO.md) |  | [optional] [default to undefined]

## Example

```typescript
import { WorkflowDefinitionResponse } from './api';

const instance: WorkflowDefinitionResponse = {
    workflowId,
    workflowName,
    version,
    nodes,
    edges,
    variables,
    settings,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
