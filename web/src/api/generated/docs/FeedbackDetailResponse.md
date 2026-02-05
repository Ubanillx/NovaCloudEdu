# FeedbackDetailResponse


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** |  | [optional] [default to undefined]
**userId** | **number** |  | [optional] [default to undefined]
**feedbackType** | **string** |  | [optional] [default to undefined]
**title** | **string** |  | [optional] [default to undefined]
**content** | **string** |  | [optional] [default to undefined]
**attachment** | **string** |  | [optional] [default to undefined]
**status** | **number** |  | [optional] [default to undefined]
**statusDesc** | **string** |  | [optional] [default to undefined]
**adminId** | **number** |  | [optional] [default to undefined]
**processTime** | **string** |  | [optional] [default to undefined]
**createTime** | **string** |  | [optional] [default to undefined]
**updateTime** | **string** |  | [optional] [default to undefined]
**replies** | [**Array&lt;FeedbackReplyResponse&gt;**](FeedbackReplyResponse.md) |  | [optional] [default to undefined]

## Example

```typescript
import { FeedbackDetailResponse } from './api';

const instance: FeedbackDetailResponse = {
    id,
    userId,
    feedbackType,
    title,
    content,
    attachment,
    status,
    statusDesc,
    adminId,
    processTime,
    createTime,
    updateTime,
    replies,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
