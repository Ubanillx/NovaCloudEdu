# WorkflowNode


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **string** |  | [optional] [default to undefined]
**type** | **string** |  | [optional] [default to undefined]
**name** | **string** |  | [optional] [default to undefined]
**position** | [**Position**](Position.md) |  | [optional] [default to undefined]
**config** | **{ [key: string]: object; }** |  | [optional] [default to undefined]
**errorHandling** | [**ErrorHandlingConfig**](ErrorHandlingConfig.md) |  | [optional] [default to undefined]
**children** | [**ChildrenDefinition**](ChildrenDefinition.md) |  | [optional] [default to undefined]
**width** | **number** |  | [optional] [default to undefined]
**height** | **number** |  | [optional] [default to undefined]

## Example

```typescript
import { WorkflowNode } from './api';

const instance: WorkflowNode = {
    id,
    type,
    name,
    position,
    config,
    errorHandling,
    children,
    width,
    height,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
