# nova_api.api.RtcInternalControllerApi

## Load the API package
```dart
import 'package:nova_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**checkPermission**](RtcInternalControllerApi.md#checkpermission) | **POST** /api/internal/rtc/check-permission | 
[**saveCallRecord**](RtcInternalControllerApi.md#savecallrecord) | **POST** /api/internal/rtc/call-record | 


# **checkPermission**
> BuiltMap<String, JsonObject> checkPermission(checkPermissionRequest)



### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getRtcInternalControllerApi();
final CheckPermissionRequest checkPermissionRequest = ; // CheckPermissionRequest | 

try {
    final response = api.checkPermission(checkPermissionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling RtcInternalControllerApi->checkPermission: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **checkPermissionRequest** | [**CheckPermissionRequest**](CheckPermissionRequest.md)|  | 

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **saveCallRecord**
> BuiltMap<String, JsonObject> saveCallRecord(saveCallRecordRequest)



### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getRtcInternalControllerApi();
final SaveCallRecordRequest saveCallRecordRequest = ; // SaveCallRecordRequest | 

try {
    final response = api.saveCallRecord(saveCallRecordRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling RtcInternalControllerApi->saveCallRecord: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **saveCallRecordRequest** | [**SaveCallRecordRequest**](SaveCallRecordRequest.md)|  | 

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

