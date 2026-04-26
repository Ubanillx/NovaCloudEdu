# IPApi

All URIs are relative to *http://localhost:8080*

|Method | HTTP request | Description|
|------------- | ------------- | -------------|
|[**lookup**](#lookup) | **GET** /api/ip-location | 查询单个 IP 归属地|
|[**lookupBatch**](#lookupbatch) | **POST** /api/ip-location/batch | 批量查询 IP 归属地|

# **lookup**
> BaseResponseIpLocationResponse lookup()


### Example

```typescript
import {
    IPApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new IPApi(configuration);

let ip: string; // (default to undefined)

const { status, data } = await apiInstance.lookup(
    ip
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **ip** | [**string**] |  | defaults to undefined|


### Return type

**BaseResponseIpLocationResponse**

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

# **lookupBatch**
> BaseResponseMapStringIpLocationResponse lookupBatch(batchIpLocationRequest)


### Example

```typescript
import {
    IPApi,
    Configuration,
    BatchIpLocationRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new IPApi(configuration);

let batchIpLocationRequest: BatchIpLocationRequest; //

const { status, data } = await apiInstance.lookupBatch(
    batchIpLocationRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **batchIpLocationRequest** | **BatchIpLocationRequest**|  | |


### Return type

**BaseResponseMapStringIpLocationResponse**

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

