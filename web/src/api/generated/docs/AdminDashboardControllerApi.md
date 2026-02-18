# AdminDashboardControllerApi

All URIs are relative to *http://localhost:8080*

|Method | HTTP request | Description|
|------------- | ------------- | -------------|
|[**getAiSystem**](#getaisystem) | **GET** /api/admin/dashboard/ai-system | |
|[**getAlerts**](#getalerts) | **GET** /api/admin/dashboard/alerts | |
|[**getContent**](#getcontent) | **GET** /api/admin/dashboard/content | |
|[**getFull**](#getfull) | **GET** /api/admin/dashboard/full | |
|[**getLearning**](#getlearning) | **GET** /api/admin/dashboard/learning | |
|[**getOverview**](#getoverview) | **GET** /api/admin/dashboard/overview | |
|[**getTrends**](#gettrends) | **GET** /api/admin/dashboard/trends | |

# **getAiSystem**
> BaseResponseDashboardAiSystemResponse getAiSystem()


### Example

```typescript
import {
    AdminDashboardControllerApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AdminDashboardControllerApi(configuration);

const { status, data } = await apiInstance.getAiSystem();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseDashboardAiSystemResponse**

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

# **getAlerts**
> BaseResponseDashboardAlertsResponse getAlerts()


### Example

```typescript
import {
    AdminDashboardControllerApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AdminDashboardControllerApi(configuration);

const { status, data } = await apiInstance.getAlerts();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseDashboardAlertsResponse**

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

# **getContent**
> BaseResponseDashboardContentResponse getContent()


### Example

```typescript
import {
    AdminDashboardControllerApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AdminDashboardControllerApi(configuration);

const { status, data } = await apiInstance.getContent();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseDashboardContentResponse**

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

# **getFull**
> BaseResponseDashboardFullResponse getFull()


### Example

```typescript
import {
    AdminDashboardControllerApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AdminDashboardControllerApi(configuration);

let startDate: string; // (optional) (default to undefined)
let endDate: string; // (optional) (default to undefined)

const { status, data } = await apiInstance.getFull(
    startDate,
    endDate
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **startDate** | [**string**] |  | (optional) defaults to undefined|
| **endDate** | [**string**] |  | (optional) defaults to undefined|


### Return type

**BaseResponseDashboardFullResponse**

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

# **getLearning**
> BaseResponseDashboardLearningResponse getLearning()


### Example

```typescript
import {
    AdminDashboardControllerApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AdminDashboardControllerApi(configuration);

let startDate: string; // (optional) (default to undefined)
let endDate: string; // (optional) (default to undefined)

const { status, data } = await apiInstance.getLearning(
    startDate,
    endDate
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **startDate** | [**string**] |  | (optional) defaults to undefined|
| **endDate** | [**string**] |  | (optional) defaults to undefined|


### Return type

**BaseResponseDashboardLearningResponse**

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

# **getOverview**
> BaseResponseDashboardOverviewResponse getOverview()


### Example

```typescript
import {
    AdminDashboardControllerApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AdminDashboardControllerApi(configuration);

const { status, data } = await apiInstance.getOverview();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseDashboardOverviewResponse**

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

# **getTrends**
> BaseResponseDashboardTrendsResponse getTrends()


### Example

```typescript
import {
    AdminDashboardControllerApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AdminDashboardControllerApi(configuration);

let startDate: string; // (optional) (default to undefined)
let endDate: string; // (optional) (default to undefined)

const { status, data } = await apiInstance.getTrends(
    startDate,
    endDate
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **startDate** | [**string**] |  | (optional) defaults to undefined|
| **endDate** | [**string**] |  | (optional) defaults to undefined|


### Return type

**BaseResponseDashboardTrendsResponse**

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

