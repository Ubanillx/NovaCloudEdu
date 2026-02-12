# MCPApi

All URIs are relative to *http://localhost:8080*

|Method | HTTP request | Description|
|------------- | ------------- | -------------|
|[**mcpServerCreate**](#mcpservercreate) | **POST** /api/ai/mcp-servers | 创建MCP服务器|
|[**mcpServerDelete**](#mcpserverdelete) | **DELETE** /api/ai/mcp-servers/{id} | 删除MCP服务器|
|[**mcpServerGetById**](#mcpservergetbyid) | **GET** /api/ai/mcp-servers/{id} | 获取MCP服务器详情|
|[**mcpServerListByCreator**](#mcpserverlistbycreator) | **GET** /api/ai/mcp-servers | 获取用户的MCP服务器列表|
|[**mcpServerListTools**](#mcpserverlisttools) | **GET** /api/ai/mcp-servers/{id}/tools | 获取MCP服务器提供的工具列表|
|[**mcpServerSetEnabled**](#mcpserversetenabled) | **PATCH** /api/ai/mcp-servers/{id}/enabled | 启用/禁用MCP服务器|
|[**mcpServerTestConnection**](#mcpservertestconnection) | **POST** /api/ai/mcp-servers/{id}/test | 测试MCP服务器连接|
|[**mcpServerUpdate**](#mcpserverupdate) | **PUT** /api/ai/mcp-servers/{id} | 更新MCP服务器|

# **mcpServerCreate**
> BaseResponseMapStringObject mcpServerCreate(requestBody)


### Example

```typescript
import {
    MCPApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new MCPApi(configuration);

let userId: number; // (default to undefined)
let requestBody: { [key: string]: object; }; //

const { status, data } = await apiInstance.mcpServerCreate(
    userId,
    requestBody
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **requestBody** | **{ [key: string]: object; }**|  | |
| **userId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseMapStringObject**

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

# **mcpServerDelete**
> BaseResponseVoid mcpServerDelete()


### Example

```typescript
import {
    MCPApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new MCPApi(configuration);

let id: number; // (default to undefined)
let userId: number; // (default to undefined)

const { status, data } = await apiInstance.mcpServerDelete(
    id,
    userId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|
| **userId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

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

# **mcpServerGetById**
> BaseResponseMapStringObject mcpServerGetById()


### Example

```typescript
import {
    MCPApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new MCPApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.mcpServerGetById(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseMapStringObject**

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

# **mcpServerListByCreator**
> BaseResponseListMapStringObject mcpServerListByCreator()


### Example

```typescript
import {
    MCPApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new MCPApi(configuration);

let userId: number; // (default to undefined)

const { status, data } = await apiInstance.mcpServerListByCreator(
    userId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **userId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseListMapStringObject**

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

# **mcpServerListTools**
> BaseResponseListMapStringObject mcpServerListTools()


### Example

```typescript
import {
    MCPApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new MCPApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.mcpServerListTools(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseListMapStringObject**

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

# **mcpServerSetEnabled**
> BaseResponseVoid mcpServerSetEnabled()


### Example

```typescript
import {
    MCPApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new MCPApi(configuration);

let id: number; // (default to undefined)
let userId: number; // (default to undefined)
let enabled: boolean; // (default to undefined)

const { status, data } = await apiInstance.mcpServerSetEnabled(
    id,
    userId,
    enabled
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|
| **userId** | [**number**] |  | defaults to undefined|
| **enabled** | [**boolean**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

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

# **mcpServerTestConnection**
> BaseResponseMapStringString mcpServerTestConnection()


### Example

```typescript
import {
    MCPApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new MCPApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.mcpServerTestConnection(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseMapStringString**

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

# **mcpServerUpdate**
> BaseResponseVoid mcpServerUpdate(requestBody)


### Example

```typescript
import {
    MCPApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new MCPApi(configuration);

let id: number; // (default to undefined)
let userId: number; // (default to undefined)
let requestBody: { [key: string]: object; }; //

const { status, data } = await apiInstance.mcpServerUpdate(
    id,
    userId,
    requestBody
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **requestBody** | **{ [key: string]: object; }**|  | |
| **id** | [**number**] |  | defaults to undefined|
| **userId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseVoid**

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

