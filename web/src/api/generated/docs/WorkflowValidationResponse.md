# WorkflowValidationResponse

工作流验证响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**valid** | **boolean** | 是否验证通过 | [optional] [default to undefined]
**errors** | [**Array&lt;ValidationErrorDTO&gt;**](ValidationErrorDTO.md) | 错误列表 | [optional] [default to undefined]
**warnings** | [**Array&lt;ValidationWarningDTO&gt;**](ValidationWarningDTO.md) | 警告列表 | [optional] [default to undefined]

## Example

```typescript
import { WorkflowValidationResponse } from './api';

const instance: WorkflowValidationResponse = {
    valid,
    errors,
    warnings,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
