# nova_api.api.MCPApi

## Load the API package
```dart
import 'package:nova_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**mcpServerCreate**](MCPApi.md#mcpservercreate) | **POST** /api/ai/mcp-servers | 创建MCP服务器
[**mcpServerDelete**](MCPApi.md#mcpserverdelete) | **DELETE** /api/ai/mcp-servers/{id} | 删除MCP服务器
[**mcpServerGetById**](MCPApi.md#mcpservergetbyid) | **GET** /api/ai/mcp-servers/{id} | 获取MCP服务器详情
[**mcpServerListByCreator**](MCPApi.md#mcpserverlistbycreator) | **GET** /api/ai/mcp-servers | 获取用户的MCP服务器列表
[**mcpServerListTools**](MCPApi.md#mcpserverlisttools) | **GET** /api/ai/mcp-servers/{id}/tools | 获取MCP服务器提供的工具列表
[**mcpServerSetEnabled**](MCPApi.md#mcpserversetenabled) | **PATCH** /api/ai/mcp-servers/{id}/enabled | 启用/禁用MCP服务器
[**mcpServerTestConnection**](MCPApi.md#mcpservertestconnection) | **POST** /api/ai/mcp-servers/{id}/test | 测试MCP服务器连接
[**mcpServerUpdate**](MCPApi.md#mcpserverupdate) | **PUT** /api/ai/mcp-servers/{id} | 更新MCP服务器


# **mcpServerCreate**
> BaseResponseMapStringObject mcpServerCreate(userId, requestBody)

创建MCP服务器

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getMCPApi();
final int userId = 789; // int | 
final BuiltMap<String, JsonObject> requestBody = Object; // BuiltMap<String, JsonObject> | 

try {
    final response = api.mcpServerCreate(userId, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MCPApi->mcpServerCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**|  | 
 **requestBody** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)|  | 

### Return type

[**BaseResponseMapStringObject**](BaseResponseMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mcpServerDelete**
> BaseResponseVoid mcpServerDelete(id, userId)

删除MCP服务器

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getMCPApi();
final int id = 789; // int | 
final int userId = 789; // int | 

try {
    final response = api.mcpServerDelete(id, userId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MCPApi->mcpServerDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **userId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mcpServerGetById**
> BaseResponseMapStringObject mcpServerGetById(id)

获取MCP服务器详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getMCPApi();
final int id = 789; // int | 

try {
    final response = api.mcpServerGetById(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MCPApi->mcpServerGetById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseMapStringObject**](BaseResponseMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mcpServerListByCreator**
> BaseResponseListMapStringObject mcpServerListByCreator(userId)

获取用户的MCP服务器列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getMCPApi();
final int userId = 789; // int | 

try {
    final response = api.mcpServerListByCreator(userId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MCPApi->mcpServerListByCreator: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**|  | 

### Return type

[**BaseResponseListMapStringObject**](BaseResponseListMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mcpServerListTools**
> BaseResponseListMapStringObject mcpServerListTools(id)

获取MCP服务器提供的工具列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getMCPApi();
final int id = 789; // int | 

try {
    final response = api.mcpServerListTools(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MCPApi->mcpServerListTools: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseListMapStringObject**](BaseResponseListMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mcpServerSetEnabled**
> BaseResponseVoid mcpServerSetEnabled(id, userId, enabled)

启用/禁用MCP服务器

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getMCPApi();
final int id = 789; // int | 
final int userId = 789; // int | 
final bool enabled = true; // bool | 

try {
    final response = api.mcpServerSetEnabled(id, userId, enabled);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MCPApi->mcpServerSetEnabled: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **userId** | **int**|  | 
 **enabled** | **bool**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mcpServerTestConnection**
> BaseResponseMapStringString mcpServerTestConnection(id)

测试MCP服务器连接

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getMCPApi();
final int id = 789; // int | 

try {
    final response = api.mcpServerTestConnection(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MCPApi->mcpServerTestConnection: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseMapStringString**](BaseResponseMapStringString.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mcpServerUpdate**
> BaseResponseVoid mcpServerUpdate(id, userId, requestBody)

更新MCP服务器

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getMCPApi();
final int id = 789; // int | 
final int userId = 789; // int | 
final BuiltMap<String, JsonObject> requestBody = Object; // BuiltMap<String, JsonObject> | 

try {
    final response = api.mcpServerUpdate(id, userId, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MCPApi->mcpServerUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **userId** | **int**|  | 
 **requestBody** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

