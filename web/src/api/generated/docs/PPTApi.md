# PPTApi

All URIs are relative to *http://localhost:8080*

|Method | HTTP request | Description|
|------------- | ------------- | -------------|
|[**deleteSession**](#deletesession) | **DELETE** /api/ppt/generation/sessions/{sessionId} | 删除PPT会话|
|[**deleteTemplate1**](#deletetemplate1) | **DELETE** /api/ppt/templates/{id} | 删除模板|
|[**generatePpt**](#generateppt) | **POST** /api/ppt/generate | 基于模板生成PPT|
|[**getSessionDetail**](#getsessiondetail) | **GET** /api/ppt/generation/sessions/{sessionId} | 获取PPT会话详情|
|[**getTemplateDetail**](#gettemplatedetail) | **GET** /api/ppt/templates/{id} | 查看模板详情|
|[**listSessions1**](#listsessions1) | **GET** /api/ppt/generation/sessions | 获取PPT会话列表|
|[**listTemplates**](#listtemplates) | **GET** /api/ppt/templates | 列出所有可用模板|
|[**proxyFile**](#proxyfile) | **GET** /api/ppt/proxy-file | 代理下载文件|
|[**stream**](#stream) | **POST** /api/ppt/generation/stream | PPT生成助手（SSE流式）|
|[**uploadTemplate**](#uploadtemplate) | **POST** /api/ppt/templates | 上传PPT模板|

# **deleteSession**
> BaseResponseVoid deleteSession()


### Example

```typescript
import {
    PPTApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new PPTApi(configuration);

let sessionId: number; //会话ID (default to undefined)

const { status, data } = await apiInstance.deleteSession(
    sessionId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **sessionId** | [**number**] | 会话ID | defaults to undefined|


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

# **deleteTemplate1**
> BaseResponseVoid deleteTemplate1()


### Example

```typescript
import {
    PPTApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new PPTApi(configuration);

let id: number; //模板ID (default to undefined)

const { status, data } = await apiInstance.deleteTemplate1(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 模板ID | defaults to undefined|


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

# **generatePpt**
> BaseResponsePptGenerateResponse generatePpt(generatePptRequest)


### Example

```typescript
import {
    PPTApi,
    Configuration,
    GeneratePptRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new PPTApi(configuration);

let generatePptRequest: GeneratePptRequest; //

const { status, data } = await apiInstance.generatePpt(
    generatePptRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **generatePptRequest** | **GeneratePptRequest**|  | |


### Return type

**BaseResponsePptGenerateResponse**

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

# **getSessionDetail**
> BaseResponseMapStringObject getSessionDetail()


### Example

```typescript
import {
    PPTApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new PPTApi(configuration);

let sessionId: number; //会话ID (default to undefined)

const { status, data } = await apiInstance.getSessionDetail(
    sessionId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **sessionId** | [**number**] | 会话ID | defaults to undefined|


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

# **getTemplateDetail**
> BaseResponsePptTemplateDetailResponse getTemplateDetail()


### Example

```typescript
import {
    PPTApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new PPTApi(configuration);

let id: number; //模板ID (default to undefined)

const { status, data } = await apiInstance.getTemplateDetail(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] | 模板ID | defaults to undefined|


### Return type

**BaseResponsePptTemplateDetailResponse**

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

# **listSessions1**
> BaseResponseListMapStringObject listSessions1()


### Example

```typescript
import {
    PPTApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new PPTApi(configuration);

const { status, data } = await apiInstance.listSessions1();
```

### Parameters
This endpoint does not have any parameters.


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

# **listTemplates**
> BaseResponseListPptTemplateListResponse listTemplates()


### Example

```typescript
import {
    PPTApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new PPTApi(configuration);

const { status, data } = await apiInstance.listTemplates();
```

### Parameters
This endpoint does not have any parameters.


### Return type

**BaseResponseListPptTemplateListResponse**

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

# **proxyFile**
> string proxyFile()

通过后端代理下载 OSS 上的 PPTX 文件，返回二进制内容

### Example

```typescript
import {
    PPTApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new PPTApi(configuration);

let url: string; // (default to undefined)

const { status, data } = await apiInstance.proxyFile(
    url
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **url** | [**string**] |  | defaults to undefined|


### Return type

**string**

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

# **stream**
> SseEmitter stream(pptGenerationRequest)

多步骤PPT生成流程，通过 action 字段控制： 0. detect_intent - AI判断用户是否要生成PPT，提取主题 1. generate_outline - 输入主题，AI生成Markdown大纲 2. revise_outline - 不满意可修改大纲 3. confirm_outline - 确认大纲 4. select_template - 选择模板（系统模板ID 或 自定义URL） 5. generate_ppt - AI逐页生成内容并生成最终PPT文件  SSE事件：status / message / intent / outline / template_parsed / slide_progress / result / error / done 

### Example

```typescript
import {
    PPTApi,
    Configuration,
    PptGenerationRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new PPTApi(configuration);

let pptGenerationRequest: PptGenerationRequest; //

const { status, data } = await apiInstance.stream(
    pptGenerationRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **pptGenerationRequest** | **PptGenerationRequest**|  | |


### Return type

**SseEmitter**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, text/event-stream


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadTemplate**
> BaseResponseLong uploadTemplate()


### Example

```typescript
import {
    PPTApi,
    Configuration,
    UploadTemplateRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new PPTApi(configuration);

let name: string; //模板名称 (default to undefined)
let description: string; //模板描述 (optional) (default to undefined)
let uploadTemplateRequest: UploadTemplateRequest; // (optional)

const { status, data } = await apiInstance.uploadTemplate(
    name,
    description,
    uploadTemplateRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **uploadTemplateRequest** | **UploadTemplateRequest**|  | |
| **name** | [**string**] | 模板名称 | defaults to undefined|
| **description** | [**string**] | 模板描述 | (optional) defaults to undefined|


### Return type

**BaseResponseLong**

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

