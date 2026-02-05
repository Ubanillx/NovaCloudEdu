# WebhookApi

All URIs are relative to *http://localhost:8080*

|Method | HTTP request | Description|
|------------- | ------------- | -------------|
|[**getWebhookInfo**](#getwebhookinfo) | **GET** /api/v1/webhook/workflow/{webhookId}/info | 获取Webhook信息|
|[**triggerWorkflow**](#triggerworkflow) | **POST** /api/v1/webhook/workflow/{webhookId} | Webhook触发工作流|

# **getWebhookInfo**
> BaseResponseWebhookInfo getWebhookInfo()


### Example

```typescript
import {
    WebhookApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new WebhookApi(configuration);

let webhookId: string; // (default to undefined)

const { status, data } = await apiInstance.getWebhookInfo(
    webhookId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **webhookId** | [**string**] |  | defaults to undefined|


### Return type

**BaseResponseWebhookInfo**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **triggerWorkflow**
> BaseResponseWebhookResponse triggerWorkflow()


### Example

```typescript
import {
    WebhookApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new WebhookApi(configuration);

let webhookId: string; // (default to undefined)
let xWebhookSignature: string; // (optional) (default to undefined)
let requestBody: { [key: string]: object; }; // (optional)

const { status, data } = await apiInstance.triggerWorkflow(
    webhookId,
    xWebhookSignature,
    requestBody
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **requestBody** | **{ [key: string]: object; }**|  | |
| **webhookId** | [**string**] |  | defaults to undefined|
| **xWebhookSignature** | [**string**] |  | (optional) defaults to undefined|


### Return type

**BaseResponseWebhookResponse**

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

