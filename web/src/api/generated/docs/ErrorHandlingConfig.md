# ErrorHandlingConfig


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**onError** | **string** |  | [optional] [default to undefined]
**retryCount** | **number** |  | [optional] [default to undefined]
**retryDelayMs** | **number** |  | [optional] [default to undefined]
**fallbackNodeId** | **string** |  | [optional] [default to undefined]
**timeoutMs** | **number** |  | [optional] [default to undefined]

## Example

```typescript
import { ErrorHandlingConfig } from './api';

const instance: ErrorHandlingConfig = {
    onError,
    retryCount,
    retryDelayMs,
    fallbackNodeId,
    timeoutMs,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
