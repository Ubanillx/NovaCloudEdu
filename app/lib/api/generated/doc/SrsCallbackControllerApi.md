# nova_api.api.SrsCallbackControllerApi

## Load the API package
```dart
import 'package:nova_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**onPlay**](SrsCallbackControllerApi.md#onplay) | **POST** /api/internal/srs/on_play | 
[**onPublish**](SrsCallbackControllerApi.md#onpublish) | **POST** /api/internal/srs/on_publish | 
[**onStop**](SrsCallbackControllerApi.md#onstop) | **POST** /api/internal/srs/on_stop | 
[**onUnpublish**](SrsCallbackControllerApi.md#onunpublish) | **POST** /api/internal/srs/on_unpublish | 


# **onPlay**
> int onPlay(srsCallbackRequest)



### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getSrsCallbackControllerApi();
final SrsCallbackRequest srsCallbackRequest = ; // SrsCallbackRequest | 

try {
    final response = api.onPlay(srsCallbackRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SrsCallbackControllerApi->onPlay: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **srsCallbackRequest** | [**SrsCallbackRequest**](SrsCallbackRequest.md)|  | 

### Return type

**int**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **onPublish**
> int onPublish(srsCallbackRequest)



### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getSrsCallbackControllerApi();
final SrsCallbackRequest srsCallbackRequest = ; // SrsCallbackRequest | 

try {
    final response = api.onPublish(srsCallbackRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SrsCallbackControllerApi->onPublish: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **srsCallbackRequest** | [**SrsCallbackRequest**](SrsCallbackRequest.md)|  | 

### Return type

**int**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **onStop**
> int onStop(srsCallbackRequest)



### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getSrsCallbackControllerApi();
final SrsCallbackRequest srsCallbackRequest = ; // SrsCallbackRequest | 

try {
    final response = api.onStop(srsCallbackRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SrsCallbackControllerApi->onStop: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **srsCallbackRequest** | [**SrsCallbackRequest**](SrsCallbackRequest.md)|  | 

### Return type

**int**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **onUnpublish**
> int onUnpublish(srsCallbackRequest)



### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getSrsCallbackControllerApi();
final SrsCallbackRequest srsCallbackRequest = ; // SrsCallbackRequest | 

try {
    final response = api.onUnpublish(srsCallbackRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SrsCallbackControllerApi->onUnpublish: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **srsCallbackRequest** | [**SrsCallbackRequest**](SrsCallbackRequest.md)|  | 

### Return type

**int**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

