# nova_api.api.OnlyOfficeApi

## Load the API package
```dart
import 'package:nova_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getEditorConfig**](OnlyOfficeApi.md#geteditorconfig) | **GET** /api/onlyoffice/config | 获取OnlyOffice编辑器配置
[**handleCallback**](OnlyOfficeApi.md#handlecallback) | **POST** /api/onlyoffice/callback | OnlyOffice保存回调


# **getEditorConfig**
> BuiltMap<String, JsonObject> getEditorConfig(fileUrl, fileName)

获取OnlyOffice编辑器配置

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getOnlyOfficeApi();
final String fileUrl = fileUrl_example; // String | 
final String fileName = fileName_example; // String | 

try {
    final response = api.getEditorConfig(fileUrl, fileName);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OnlyOfficeApi->getEditorConfig: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **fileUrl** | **String**|  | 
 **fileName** | **String**|  | [optional] [default to '演示文稿.pptx']

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **handleCallback**
> BuiltMap<String, JsonObject> handleCallback(requestBody)

OnlyOffice保存回调

无需认证，由OnlyOffice服务器调用

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getOnlyOfficeApi();
final BuiltMap<String, JsonObject> requestBody = Object; // BuiltMap<String, JsonObject> | 

try {
    final response = api.handleCallback(requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OnlyOfficeApi->handleCallback: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestBody** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)|  | 

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

