# ReviewApplicationRequest

审核讲师申请请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**applicationId** | **number** | 申请ID | [default to undefined]
**approved** | **boolean** | 是否通过：true-通过，false-拒绝 | [default to undefined]
**rejectReason** | **string** | 拒绝原因（拒绝时必填） | [optional] [default to undefined]

## Example

```typescript
import { ReviewApplicationRequest } from './api';

const instance: ReviewApplicationRequest = {
    applicationId,
    approved,
    rejectReason,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
