# LinkPreviewControllerApi

All URIs are relative to *http://localhost:8080*

|Method | HTTP request | Description|
|------------- | ------------- | -------------|
|[**preview**](#preview) | **POST** /api/link-preview | |

# **preview**
> BaseResponseLinkPreview preview(linkPreviewRequest)


### Example

```typescript
import {
    LinkPreviewControllerApi,
    Configuration,
    LinkPreviewRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new LinkPreviewControllerApi(configuration);

let linkPreviewRequest: LinkPreviewRequest; //

const { status, data } = await apiInstance.preview(
    linkPreviewRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **linkPreviewRequest** | **LinkPreviewRequest**|  | |


### Return type

**BaseResponseLinkPreview**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

