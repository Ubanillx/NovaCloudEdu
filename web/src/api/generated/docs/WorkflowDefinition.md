# WorkflowDefinition

工作流定义

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**version** | **string** |  | [optional] [default to undefined]
**nodes** | [**Array&lt;WorkflowNode&gt;**](WorkflowNode.md) |  | [optional] [default to undefined]
**edges** | [**Array&lt;WorkflowEdge&gt;**](WorkflowEdge.md) |  | [optional] [default to undefined]
**variables** | [**{ [key: string]: VariableDefinition; }**](VariableDefinition.md) |  | [optional] [default to undefined]
**settings** | [**WorkflowSettings**](WorkflowSettings.md) |  | [optional] [default to undefined]

## Example

```typescript
import { WorkflowDefinition } from './api';

const instance: WorkflowDefinition = {
    version,
    nodes,
    edges,
    variables,
    settings,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
