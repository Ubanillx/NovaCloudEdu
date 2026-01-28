# nova_api.api.WebhookApi

## Load the API package
```dart
import 'package:nova_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getWebhookInfo**](WebhookApi.md#getwebhookinfo) | **GET** /api/v1/webhook/workflow/{webhookId}/info | 获取Webhook信息
[**triggerWorkflow**](WebhookApi.md#triggerworkflow) | **POST** /api/v1/webhook/workflow/{webhookId} | Webhook触发工作流


# **getWebhookInfo**
> BaseResponseWebhookInfo getWebhookInfo(webhookId)

获取Webhook信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getWebhookApi();
final String webhookId = webhookId_example; // String | 

try {
    final response = api.getWebhookInfo(webhookId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WebhookApi->getWebhookInfo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **webhookId** | **String**|  | 

### Return type

[**BaseResponseWebhookInfo**](BaseResponseWebhookInfo.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **triggerWorkflow**
> BaseResponseWebhookResponse triggerWorkflow(webhookId, xWebhookSignature, requestBody)

Webhook触发工作流

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getWebhookApi();
final String webhookId = webhookId_example; // String | 
final String xWebhookSignature = xWebhookSignature_example; // String | 
final BuiltMap<String, JsonObject> requestBody = Object; // BuiltMap<String, JsonObject> | 

try {
    final response = api.triggerWorkflow(webhookId, xWebhookSignature, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WebhookApi->triggerWorkflow: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **webhookId** | **String**|  | 
 **xWebhookSignature** | **String**|  | [optional] 
 **requestBody** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)|  | [optional] 

### Return type

[**BaseResponseWebhookResponse**](BaseResponseWebhookResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

