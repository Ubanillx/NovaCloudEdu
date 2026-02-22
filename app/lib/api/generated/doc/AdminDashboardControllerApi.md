# nova_api.api.AdminDashboardControllerApi

## Load the API package
```dart
import 'package:nova_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getAiSystem**](AdminDashboardControllerApi.md#getaisystem) | **GET** /api/admin/dashboard/ai-system | 
[**getAlerts**](AdminDashboardControllerApi.md#getalerts) | **GET** /api/admin/dashboard/alerts | 
[**getContent**](AdminDashboardControllerApi.md#getcontent) | **GET** /api/admin/dashboard/content | 
[**getFull**](AdminDashboardControllerApi.md#getfull) | **GET** /api/admin/dashboard/full | 
[**getLearning**](AdminDashboardControllerApi.md#getlearning) | **GET** /api/admin/dashboard/learning | 
[**getOverview**](AdminDashboardControllerApi.md#getoverview) | **GET** /api/admin/dashboard/overview | 
[**getTrends**](AdminDashboardControllerApi.md#gettrends) | **GET** /api/admin/dashboard/trends | 


# **getAiSystem**
> BaseResponseDashboardAiSystemResponse getAiSystem()



### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAdminDashboardControllerApi();

try {
    final response = api.getAiSystem();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminDashboardControllerApi->getAiSystem: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseDashboardAiSystemResponse**](BaseResponseDashboardAiSystemResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAlerts**
> BaseResponseDashboardAlertsResponse getAlerts()



### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAdminDashboardControllerApi();

try {
    final response = api.getAlerts();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminDashboardControllerApi->getAlerts: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseDashboardAlertsResponse**](BaseResponseDashboardAlertsResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getContent**
> BaseResponseDashboardContentResponse getContent()



### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAdminDashboardControllerApi();

try {
    final response = api.getContent();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminDashboardControllerApi->getContent: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseDashboardContentResponse**](BaseResponseDashboardContentResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFull**
> BaseResponseDashboardFullResponse getFull(startDate, endDate)



### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAdminDashboardControllerApi();
final Date startDate = 2013-10-20; // Date | 
final Date endDate = 2013-10-20; // Date | 

try {
    final response = api.getFull(startDate, endDate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminDashboardControllerApi->getFull: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **startDate** | **Date**|  | [optional] 
 **endDate** | **Date**|  | [optional] 

### Return type

[**BaseResponseDashboardFullResponse**](BaseResponseDashboardFullResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getLearning**
> BaseResponseDashboardLearningResponse getLearning(startDate, endDate)



### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAdminDashboardControllerApi();
final Date startDate = 2013-10-20; // Date | 
final Date endDate = 2013-10-20; // Date | 

try {
    final response = api.getLearning(startDate, endDate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminDashboardControllerApi->getLearning: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **startDate** | **Date**|  | [optional] 
 **endDate** | **Date**|  | [optional] 

### Return type

[**BaseResponseDashboardLearningResponse**](BaseResponseDashboardLearningResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getOverview**
> BaseResponseDashboardOverviewResponse getOverview()



### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAdminDashboardControllerApi();

try {
    final response = api.getOverview();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminDashboardControllerApi->getOverview: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseDashboardOverviewResponse**](BaseResponseDashboardOverviewResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTrends**
> BaseResponseDashboardTrendsResponse getTrends(startDate, endDate)



### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAdminDashboardControllerApi();
final Date startDate = 2013-10-20; // Date | 
final Date endDate = 2013-10-20; // Date | 

try {
    final response = api.getTrends(startDate, endDate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminDashboardControllerApi->getTrends: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **startDate** | **Date**|  | [optional] 
 **endDate** | **Date**|  | [optional] 

### Return type

[**BaseResponseDashboardTrendsResponse**](BaseResponseDashboardTrendsResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

