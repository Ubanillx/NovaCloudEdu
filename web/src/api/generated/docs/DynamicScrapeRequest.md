# DynamicScrapeRequest


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**url** | **string** |  | [default to undefined]
**config** | [**ScrapeConfigRequest**](ScrapeConfigRequest.md) |  | [optional] [default to undefined]
**recursive** | **boolean** |  | [optional] [default to undefined]
**maxArticles** | **number** |  | [optional] [default to undefined]
**waitForJsMs** | **number** |  | [optional] [default to undefined]
**waitForSelector** | **string** |  | [optional] [default to undefined]
**timeoutSeconds** | **number** |  | [optional] [default to undefined]

## Example

```typescript
import { DynamicScrapeRequest } from './api';

const instance: DynamicScrapeRequest = {
    url,
    config,
    recursive,
    maxArticles,
    waitForJsMs,
    waitForSelector,
    timeoutSeconds,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
