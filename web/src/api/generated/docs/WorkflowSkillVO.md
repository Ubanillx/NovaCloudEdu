# WorkflowSkillVO


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**workflowId** | **number** |  | [optional] [default to undefined]
**name** | **string** |  | [optional] [default to undefined]
**description** | **string** |  | [optional] [default to undefined]
**status** | **string** |  | [optional] [default to undefined]
**inputParameters** | [**Array&lt;SkillParamVO&gt;**](SkillParamVO.md) |  | [optional] [default to undefined]
**outputVariables** | [**Array&lt;SkillOutputVO&gt;**](SkillOutputVO.md) |  | [optional] [default to undefined]

## Example

```typescript
import { WorkflowSkillVO } from './api';

const instance: WorkflowSkillVO = {
    workflowId,
    name,
    description,
    status,
    inputParameters,
    outputVariables,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
