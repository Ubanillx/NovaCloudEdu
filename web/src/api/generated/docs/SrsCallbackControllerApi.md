# SrsCallbackControllerApi

All URIs are relative to *http://localhost:8080*

|Method | HTTP request | Description|
|------------- | ------------- | -------------|
|[**onPlay**](#onplay) | **POST** /api/internal/srs/on_play | |
|[**onPublish**](#onpublish) | **POST** /api/internal/srs/on_publish | |
|[**onStop**](#onstop) | **POST** /api/internal/srs/on_stop | |
|[**onUnpublish**](#onunpublish) | **POST** /api/internal/srs/on_unpublish | |

# **onPlay**
> number onPlay(srsCallbackRequest)


### Example

```typescript
import {
    SrsCallbackControllerApi,
    Configuration,
    SrsCallbackRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new SrsCallbackControllerApi(configuration);

let srsCallbackRequest: SrsCallbackRequest; //

const { status, data } = await apiInstance.onPlay(
    srsCallbackRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **srsCallbackRequest** | **SrsCallbackRequest**|  | |


### Return type

**number**

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

# **onPublish**
> number onPublish(srsCallbackRequest)


### Example

```typescript
import {
    SrsCallbackControllerApi,
    Configuration,
    SrsCallbackRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new SrsCallbackControllerApi(configuration);

let srsCallbackRequest: SrsCallbackRequest; //

const { status, data } = await apiInstance.onPublish(
    srsCallbackRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **srsCallbackRequest** | **SrsCallbackRequest**|  | |


### Return type

**number**

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

# **onStop**
> number onStop(srsCallbackRequest)


### Example

```typescript
import {
    SrsCallbackControllerApi,
    Configuration,
    SrsCallbackRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new SrsCallbackControllerApi(configuration);

let srsCallbackRequest: SrsCallbackRequest; //

const { status, data } = await apiInstance.onStop(
    srsCallbackRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **srsCallbackRequest** | **SrsCallbackRequest**|  | |


### Return type

**number**

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

# **onUnpublish**
> number onUnpublish(srsCallbackRequest)


### Example

```typescript
import {
    SrsCallbackControllerApi,
    Configuration,
    SrsCallbackRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new SrsCallbackControllerApi(configuration);

let srsCallbackRequest: SrsCallbackRequest; //

const { status, data } = await apiInstance.onUnpublish(
    srsCallbackRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **srsCallbackRequest** | **SrsCallbackRequest**|  | |


### Return type

**number**

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

