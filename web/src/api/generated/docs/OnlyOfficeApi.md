# OnlyOfficeApi

All URIs are relative to *http://localhost:8080*

|Method | HTTP request | Description|
|------------- | ------------- | -------------|
|[**getEditorConfig**](#geteditorconfig) | **GET** /api/onlyoffice/config | 获取OnlyOffice编辑器配置|
|[**handleCallback**](#handlecallback) | **POST** /api/onlyoffice/callback | OnlyOffice保存回调|

# **getEditorConfig**
> { [key: string]: object; } getEditorConfig()


### Example

```typescript
import {
    OnlyOfficeApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new OnlyOfficeApi(configuration);

let fileUrl: string; // (default to undefined)
let fileName: string; // (optional) (default to '演示文稿.pptx')

const { status, data } = await apiInstance.getEditorConfig(
    fileUrl,
    fileName
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **fileUrl** | [**string**] |  | defaults to undefined|
| **fileName** | [**string**] |  | (optional) defaults to '演示文稿.pptx'|


### Return type

**{ [key: string]: object; }**

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

# **handleCallback**
> { [key: string]: object; } handleCallback(requestBody)

无需认证，由OnlyOffice服务器调用

### Example

```typescript
import {
    OnlyOfficeApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new OnlyOfficeApi(configuration);

let requestBody: { [key: string]: object; }; //

const { status, data } = await apiInstance.handleCallback(
    requestBody
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **requestBody** | **{ [key: string]: object; }**|  | |


### Return type

**{ [key: string]: object; }**

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

