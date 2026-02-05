# ScrapeResultResponse


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**sourceUrl** | **string** |  | [optional] [default to undefined]
**articles** | [**Array&lt;ArticleResponse&gt;**](ArticleResponse.md) |  | [optional] [default to undefined]
**totalPages** | **number** |  | [optional] [default to undefined]
**successCount** | **number** |  | [optional] [default to undefined]
**failCount** | **number** |  | [optional] [default to undefined]
**errors** | **Array&lt;string&gt;** |  | [optional] [default to undefined]
**startTime** | **string** |  | [optional] [default to undefined]
**endTime** | **string** |  | [optional] [default to undefined]
**durationMs** | **number** |  | [optional] [default to undefined]
**hasErrors** | **boolean** |  | [optional] [default to undefined]

## Example

```typescript
import { ScrapeResultResponse } from './api';

const instance: ScrapeResultResponse = {
    sourceUrl,
    articles,
    totalPages,
    successCount,
    failCount,
    errors,
    startTime,
    endTime,
    durationMs,
    hasErrors,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
