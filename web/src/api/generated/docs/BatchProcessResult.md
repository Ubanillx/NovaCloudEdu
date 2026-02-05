# BatchProcessResult


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**total** | **number** |  | [optional] [default to undefined]
**successIds** | **Array&lt;number&gt;** |  | [optional] [default to undefined]
**failedItems** | [**Array&lt;FailedItem&gt;**](FailedItem.md) |  | [optional] [default to undefined]
**successCount** | **number** |  | [optional] [default to undefined]
**failedCount** | **number** |  | [optional] [default to undefined]

## Example

```typescript
import { BatchProcessResult } from './api';

const instance: BatchProcessResult = {
    total,
    successIds,
    failedItems,
    successCount,
    failedCount,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
