# RtcInternalControllerApi

All URIs are relative to *http://localhost:8080*

|Method | HTTP request | Description|
|------------- | ------------- | -------------|
|[**checkPermission**](#checkpermission) | **POST** /api/internal/rtc/check-permission | |
|[**saveCallRecord**](#savecallrecord) | **POST** /api/internal/rtc/call-record | |

# **checkPermission**
> { [key: string]: object; } checkPermission(checkPermissionRequest)


### Example

```typescript
import {
    RtcInternalControllerApi,
    Configuration,
    CheckPermissionRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new RtcInternalControllerApi(configuration);

let checkPermissionRequest: CheckPermissionRequest; //

const { status, data } = await apiInstance.checkPermission(
    checkPermissionRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **checkPermissionRequest** | **CheckPermissionRequest**|  | |


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

# **saveCallRecord**
> { [key: string]: object; } saveCallRecord(saveCallRecordRequest)


### Example

```typescript
import {
    RtcInternalControllerApi,
    Configuration,
    SaveCallRecordRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new RtcInternalControllerApi(configuration);

let saveCallRecordRequest: SaveCallRecordRequest; //

const { status, data } = await apiInstance.saveCallRecord(
    saveCallRecordRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **saveCallRecordRequest** | **SaveCallRecordRequest**|  | |


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

