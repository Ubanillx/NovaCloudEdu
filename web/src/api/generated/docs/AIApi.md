# AIApi

All URIs are relative to *http://localhost:8080*

|Method | HTTP request | Description|
|------------- | ------------- | -------------|
|[**archive**](#archive) | **PUT** /api/ai/assistants/{id}/archive | 归档AI助手|
|[**askQuestion**](#askquestion) | **POST** /api/books/{bookId}/ai/chat | 提问（新对话）|
|[**batchProcessArticles**](#batchprocessarticles) | **POST** /api/admin/articles/ai/batch-process | 批量AI处理文章|
|[**bindKnowledgeBase**](#bindknowledgebase) | **POST** /api/ai/assistants/{id}/knowledge-bases/{kbId} | 绑定知识库|
|[**bindWorkflow**](#bindworkflow) | **POST** /api/ai/assistants/{id}/workflows/{workflowId} | 绑定工作流到AI助手|
|[**chat**](#chat) | **POST** /api/articles/chat | 非流式对话|
|[**continueConversation**](#continueconversation) | **POST** /api/books/{bookId}/ai/chat/{conversationId} | 继续对话|
|[**create2**](#create2) | **POST** /api/ai/assistants | 创建AI助手|
|[**delete2**](#delete2) | **DELETE** /api/ai/assistants/{id} | 删除AI助手|
|[**executeWorkflow**](#executeworkflow) | **POST** /api/ai/assistants/{id}/workflows/{workflowId}/execute | 执行AI助手绑定的工作流|
|[**extractKnowledgePoints**](#extractknowledgepoints) | **POST** /api/books/{bookId}/ai/chapters/{chapterId}/knowledge-points | 提取章节知识点|
|[**generateQuiz**](#generatequiz) | **POST** /api/books/{bookId}/ai/chapters/{chapterId}/quiz | 生成阅读测试|
|[**generateSummary**](#generatesummary) | **POST** /api/books/{bookId}/ai/chapters/{chapterId}/summary | 生成章节总结|
|[**getAllSummaries**](#getallsummaries) | **GET** /api/books/{bookId}/ai/chapters/{chapterId}/summaries | 获取章节所有总结|
|[**getById2**](#getbyid2) | **GET** /api/ai/assistants/{id} | 获取AI助手详情|
|[**getConversation**](#getconversation) | **GET** /api/books/{bookId}/ai/chat/{conversationId} | 获取对话历史|
|[**getKnowledgePoints**](#getknowledgepoints) | **GET** /api/books/{bookId}/ai/chapters/{chapterId}/knowledge-points | 获取章节知识点|
|[**getLatestQuiz**](#getlatestquiz) | **GET** /api/books/{bookId}/ai/chapters/{chapterId}/quiz/latest | 获取章节最新测试|
|[**getQuiz**](#getquiz) | **GET** /api/books/{bookId}/ai/quiz/{quizId} | 获取测试|
|[**getSummary**](#getsummary) | **GET** /api/books/{bookId}/ai/chapters/{chapterId}/summary | 获取章节总结|
|[**getUserConversations**](#getuserconversations) | **GET** /api/books/{bookId}/ai/conversations | 获取用户对话列表|
|[**getWorkflows**](#getworkflows) | **GET** /api/ai/assistants/{id}/workflows | 获取AI助手绑定的工作流列表|
|[**listByCreator1**](#listbycreator1) | **GET** /api/ai/assistants | 获取用户的AI助手列表|
|[**listPublic1**](#listpublic1) | **GET** /api/ai/assistants/public | 获取公开的AI助手列表|
|[**previewAiProcess**](#previewaiprocess) | **POST** /api/admin/articles/ai/preview | 预览AI处理结果|
|[**processArticle**](#processarticle) | **POST** /api/admin/articles/ai/process | AI处理单篇文章|
|[**publish**](#publish) | **PUT** /api/ai/assistants/{id}/publish | 发布AI助手|
|[**regenerateKnowledgePoints**](#regenerateknowledgepoints) | **POST** /api/books/{bookId}/ai/chapters/{chapterId}/knowledge-points/regenerate | 重新提取知识点|
|[**regenerateSummary**](#regeneratesummary) | **POST** /api/books/{bookId}/ai/chapters/{chapterId}/summary/regenerate | 重新生成总结|
|[**search1**](#search1) | **GET** /api/ai/assistants/search | 搜索AI助手|
|[**searchKnowledgePoints**](#searchknowledgepoints) | **GET** /api/books/{bookId}/ai/knowledge-points/search | 搜索知识点|
|[**streamChat**](#streamchat) | **POST** /api/articles/chat/stream | 流式对话|
|[**streamChat1**](#streamchat1) | **POST** /api/ai/chat/stream | 流式对话|
|[**streamChatGet**](#streamchatget) | **GET** /api/articles/{articleId}/chat/stream | GET流式对话|
|[**submitAnswers**](#submitanswers) | **POST** /api/books/{bookId}/ai/quiz/{quizId}/submit | 提交答案并评分|
|[**unbindKnowledgeBase**](#unbindknowledgebase) | **DELETE** /api/ai/assistants/{id}/knowledge-bases/{kbId} | 解绑知识库|
|[**unbindWorkflow**](#unbindworkflow) | **DELETE** /api/ai/assistants/{id}/workflows/{workflowId} | 解绑工作流|
|[**update2**](#update2) | **PUT** /api/ai/assistants/{id} | 更新AI助手|

# **archive**
> BaseResponseAiAssistantVO archive()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.archive(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseAiAssistantVO**

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

# **askQuestion**
> BaseResponseMapStringObject askQuestion(requestBody)


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let bookId: number; // (default to undefined)
let requestBody: { [key: string]: object; }; //

const { status, data } = await apiInstance.askQuestion(
    bookId,
    requestBody
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **requestBody** | **{ [key: string]: object; }**|  | |
| **bookId** | [**number**] |  | defaults to undefined|


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

# **batchProcessArticles**
> BaseResponseMapStringObject batchProcessArticles(batchAiProcessRequest)

批量对多篇文章进行AI处理

### Example

```typescript
import {
    AIApi,
    Configuration,
    BatchAiProcessRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let batchAiProcessRequest: BatchAiProcessRequest; //

const { status, data } = await apiInstance.batchProcessArticles(
    batchAiProcessRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **batchAiProcessRequest** | **BatchAiProcessRequest**|  | |


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

# **bindKnowledgeBase**
> BaseResponseVoid bindKnowledgeBase()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let id: number; // (default to undefined)
let kbId: number; // (default to undefined)

const { status, data } = await apiInstance.bindKnowledgeBase(
    id,
    kbId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|
| **kbId** | [**number**] |  | defaults to undefined|


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

# **bindWorkflow**
> BaseResponseVoid bindWorkflow()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let id: number; // (default to undefined)
let workflowId: number; // (default to undefined)

const { status, data } = await apiInstance.bindWorkflow(
    id,
    workflowId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|
| **workflowId** | [**number**] |  | defaults to undefined|


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

# **chat**
> BaseResponseMapStringString chat(articleChatRequest)

与文章内容进行AI对话，返回完整回复

### Example

```typescript
import {
    AIApi,
    Configuration,
    ArticleChatRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let articleChatRequest: ArticleChatRequest; //

const { status, data } = await apiInstance.chat(
    articleChatRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **articleChatRequest** | **ArticleChatRequest**|  | |


### Return type

**BaseResponseMapStringString**

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

# **continueConversation**
> BaseResponseMapStringObject continueConversation(requestBody)


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let bookId: number; // (default to undefined)
let conversationId: number; // (default to undefined)
let requestBody: { [key: string]: string; }; //

const { status, data } = await apiInstance.continueConversation(
    bookId,
    conversationId,
    requestBody
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **requestBody** | **{ [key: string]: string; }**|  | |
| **bookId** | [**number**] |  | defaults to undefined|
| **conversationId** | [**number**] |  | defaults to undefined|


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

# **create2**
> BaseResponseAiAssistantVO create2(createAiAssistantCommand)


### Example

```typescript
import {
    AIApi,
    Configuration,
    CreateAiAssistantCommand
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let userId: number; // (default to undefined)
let createAiAssistantCommand: CreateAiAssistantCommand; //

const { status, data } = await apiInstance.create2(
    userId,
    createAiAssistantCommand
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **createAiAssistantCommand** | **CreateAiAssistantCommand**|  | |
| **userId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseAiAssistantVO**

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

# **delete2**
> BaseResponseVoid delete2()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.delete2(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


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

# **executeWorkflow**
> BaseResponseMapStringObject executeWorkflow()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let id: number; // (default to undefined)
let workflowId: number; // (default to undefined)
let userId: number; // (default to undefined)
let requestBody: { [key: string]: object; }; // (optional)

const { status, data } = await apiInstance.executeWorkflow(
    id,
    workflowId,
    userId,
    requestBody
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **requestBody** | **{ [key: string]: object; }**|  | |
| **id** | [**number**] |  | defaults to undefined|
| **workflowId** | [**number**] |  | defaults to undefined|
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

# **extractKnowledgePoints**
> BaseResponseListKnowledgePoint extractKnowledgePoints()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let bookId: number; // (default to undefined)
let chapterId: number; // (default to undefined)

const { status, data } = await apiInstance.extractKnowledgePoints(
    bookId,
    chapterId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **bookId** | [**number**] |  | defaults to undefined|
| **chapterId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseListKnowledgePoint**

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

# **generateQuiz**
> BaseResponseReadingQuiz generateQuiz()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let bookId: number; // (default to undefined)
let chapterId: number; // (default to undefined)
let questionCount: number; // (optional) (default to undefined)
let difficulty: string; // (optional) (default to undefined)

const { status, data } = await apiInstance.generateQuiz(
    bookId,
    chapterId,
    questionCount,
    difficulty
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **bookId** | [**number**] |  | defaults to undefined|
| **chapterId** | [**number**] |  | defaults to undefined|
| **questionCount** | [**number**] |  | (optional) defaults to undefined|
| **difficulty** | [**string**] |  | (optional) defaults to undefined|


### Return type

**BaseResponseReadingQuiz**

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

# **generateSummary**
> BaseResponseChapterSummary generateSummary()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let bookId: number; // (default to undefined)
let chapterId: number; // (default to undefined)
let summaryType: string; // (optional) (default to 'DETAILED')

const { status, data } = await apiInstance.generateSummary(
    bookId,
    chapterId,
    summaryType
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **bookId** | [**number**] |  | defaults to undefined|
| **chapterId** | [**number**] |  | defaults to undefined|
| **summaryType** | [**string**] |  | (optional) defaults to 'DETAILED'|


### Return type

**BaseResponseChapterSummary**

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

# **getAllSummaries**
> BaseResponseListChapterSummary getAllSummaries()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let bookId: number; // (default to undefined)
let chapterId: number; // (default to undefined)

const { status, data } = await apiInstance.getAllSummaries(
    bookId,
    chapterId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **bookId** | [**number**] |  | defaults to undefined|
| **chapterId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseListChapterSummary**

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

# **getById2**
> BaseResponseAiAssistantVO getById2()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.getById2(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseAiAssistantVO**

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

# **getConversation**
> BaseResponseAiConversation getConversation()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let bookId: number; // (default to undefined)
let conversationId: number; // (default to undefined)

const { status, data } = await apiInstance.getConversation(
    bookId,
    conversationId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **bookId** | [**number**] |  | defaults to undefined|
| **conversationId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseAiConversation**

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

# **getKnowledgePoints**
> BaseResponseListKnowledgePoint getKnowledgePoints()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let bookId: number; // (default to undefined)
let chapterId: number; // (default to undefined)
let type: string; // (optional) (default to undefined)

const { status, data } = await apiInstance.getKnowledgePoints(
    bookId,
    chapterId,
    type
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **bookId** | [**number**] |  | defaults to undefined|
| **chapterId** | [**number**] |  | defaults to undefined|
| **type** | [**string**] |  | (optional) defaults to undefined|


### Return type

**BaseResponseListKnowledgePoint**

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

# **getLatestQuiz**
> BaseResponseReadingQuiz getLatestQuiz()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let bookId: number; // (default to undefined)
let chapterId: number; // (default to undefined)

const { status, data } = await apiInstance.getLatestQuiz(
    bookId,
    chapterId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **bookId** | [**number**] |  | defaults to undefined|
| **chapterId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseReadingQuiz**

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

# **getQuiz**
> BaseResponseReadingQuiz getQuiz()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let bookId: number; // (default to undefined)
let quizId: number; // (default to undefined)

const { status, data } = await apiInstance.getQuiz(
    bookId,
    quizId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **bookId** | [**number**] |  | defaults to undefined|
| **quizId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseReadingQuiz**

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

# **getSummary**
> BaseResponseChapterSummary getSummary()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let bookId: number; // (default to undefined)
let chapterId: number; // (default to undefined)
let summaryType: string; // (optional) (default to 'DETAILED')

const { status, data } = await apiInstance.getSummary(
    bookId,
    chapterId,
    summaryType
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **bookId** | [**number**] |  | defaults to undefined|
| **chapterId** | [**number**] |  | defaults to undefined|
| **summaryType** | [**string**] |  | (optional) defaults to 'DETAILED'|


### Return type

**BaseResponseChapterSummary**

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

# **getUserConversations**
> BaseResponseListAiConversation getUserConversations()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let bookId: number; // (default to undefined)
let userId: number; // (default to undefined)
let page: number; // (optional) (default to 0)
let size: number; // (optional) (default to 20)

const { status, data } = await apiInstance.getUserConversations(
    bookId,
    userId,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **bookId** | [**number**] |  | defaults to undefined|
| **userId** | [**number**] |  | defaults to undefined|
| **page** | [**number**] |  | (optional) defaults to 0|
| **size** | [**number**] |  | (optional) defaults to 20|


### Return type

**BaseResponseListAiConversation**

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

# **getWorkflows**
> BaseResponseListLong getWorkflows()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.getWorkflows(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseListLong**

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

# **listByCreator1**
> BaseResponseListAiAssistantVO listByCreator1()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let userId: number; // (default to undefined)
let page: number; // (optional) (default to 0)
let size: number; // (optional) (default to 20)

const { status, data } = await apiInstance.listByCreator1(
    userId,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **userId** | [**number**] |  | defaults to undefined|
| **page** | [**number**] |  | (optional) defaults to 0|
| **size** | [**number**] |  | (optional) defaults to 20|


### Return type

**BaseResponseListAiAssistantVO**

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

# **listPublic1**
> BaseResponseListAiAssistantVO listPublic1()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let page: number; // (optional) (default to 0)
let size: number; // (optional) (default to 20)

const { status, data } = await apiInstance.listPublic1(
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **page** | [**number**] |  | (optional) defaults to 0|
| **size** | [**number**] |  | (optional) defaults to 20|


### Return type

**BaseResponseListAiAssistantVO**

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

# **previewAiProcess**
> BaseResponseAiProcessResultResponse previewAiProcess(previewAiProcessRequest)

预览AI处理结果，不保存到数据库

### Example

```typescript
import {
    AIApi,
    Configuration,
    PreviewAiProcessRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let previewAiProcessRequest: PreviewAiProcessRequest; //

const { status, data } = await apiInstance.previewAiProcess(
    previewAiProcessRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **previewAiProcessRequest** | **PreviewAiProcessRequest**|  | |


### Return type

**BaseResponseAiProcessResultResponse**

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

# **processArticle**
> BaseResponseDailyArticleResponse processArticle(aiProcessArticleRequest)

对指定文章进行AI内容排版和摘要生成

### Example

```typescript
import {
    AIApi,
    Configuration,
    AiProcessArticleRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let aiProcessArticleRequest: AiProcessArticleRequest; //

const { status, data } = await apiInstance.processArticle(
    aiProcessArticleRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **aiProcessArticleRequest** | **AiProcessArticleRequest**|  | |


### Return type

**BaseResponseDailyArticleResponse**

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

# **publish**
> BaseResponseAiAssistantVO publish()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.publish(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseAiAssistantVO**

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

# **regenerateKnowledgePoints**
> BaseResponseListKnowledgePoint regenerateKnowledgePoints()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let bookId: number; // (default to undefined)
let chapterId: number; // (default to undefined)

const { status, data } = await apiInstance.regenerateKnowledgePoints(
    bookId,
    chapterId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **bookId** | [**number**] |  | defaults to undefined|
| **chapterId** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseListKnowledgePoint**

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

# **regenerateSummary**
> BaseResponseChapterSummary regenerateSummary()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let bookId: number; // (default to undefined)
let chapterId: number; // (default to undefined)
let summaryType: string; // (optional) (default to 'DETAILED')

const { status, data } = await apiInstance.regenerateSummary(
    bookId,
    chapterId,
    summaryType
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **bookId** | [**number**] |  | defaults to undefined|
| **chapterId** | [**number**] |  | defaults to undefined|
| **summaryType** | [**string**] |  | (optional) defaults to 'DETAILED'|


### Return type

**BaseResponseChapterSummary**

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

# **search1**
> BaseResponseListAiAssistantVO search1()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let keyword: string; // (default to undefined)
let page: number; // (optional) (default to 0)
let size: number; // (optional) (default to 20)

const { status, data } = await apiInstance.search1(
    keyword,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **keyword** | [**string**] |  | defaults to undefined|
| **page** | [**number**] |  | (optional) defaults to 0|
| **size** | [**number**] |  | (optional) defaults to 20|


### Return type

**BaseResponseListAiAssistantVO**

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

# **searchKnowledgePoints**
> BaseResponseListKnowledgePoint searchKnowledgePoints()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let bookId: number; // (default to undefined)
let keyword: string; // (default to undefined)
let page: number; // (optional) (default to 0)
let size: number; // (optional) (default to 20)

const { status, data } = await apiInstance.searchKnowledgePoints(
    bookId,
    keyword,
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **bookId** | [**number**] |  | defaults to undefined|
| **keyword** | [**string**] |  | defaults to undefined|
| **page** | [**number**] |  | (optional) defaults to 0|
| **size** | [**number**] |  | (optional) defaults to 20|


### Return type

**BaseResponseListKnowledgePoint**

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

# **streamChat**
> SseEmitter streamChat(articleChatRequest)

与文章内容进行AI流式对话，返回SSE事件流

### Example

```typescript
import {
    AIApi,
    Configuration,
    ArticleChatRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let articleChatRequest: ArticleChatRequest; //

const { status, data } = await apiInstance.streamChat(
    articleChatRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **articleChatRequest** | **ArticleChatRequest**|  | |


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

# **streamChat1**
> SseEmitter streamChat1(chatRequest)

使用SSE推送方式进行AI对话

### Example

```typescript
import {
    AIApi,
    Configuration,
    ChatRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let chatRequest: ChatRequest; //

const { status, data } = await apiInstance.streamChat1(
    chatRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **chatRequest** | **ChatRequest**|  | |


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

# **streamChatGet**
> SseEmitter streamChatGet()

使用GET方式进行流式对话，便于EventSource使用

### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let articleId: number; // (default to undefined)
let message: string; // (default to undefined)
let historyJson: string; // (optional) (default to undefined)

const { status, data } = await apiInstance.streamChatGet(
    articleId,
    message,
    historyJson
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **articleId** | [**number**] |  | defaults to undefined|
| **message** | [**string**] |  | defaults to undefined|
| **historyJson** | [**string**] |  | (optional) defaults to undefined|


### Return type

**SseEmitter**

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/event-stream


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**400** | Bad Request |  -  |
|**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **submitAnswers**
> BaseResponseMapStringObject submitAnswers(requestBody)


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let bookId: number; // (default to undefined)
let quizId: number; // (default to undefined)
let requestBody: { [key: string]: Array<string>; }; //

const { status, data } = await apiInstance.submitAnswers(
    bookId,
    quizId,
    requestBody
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **requestBody** | **{ [key: string]: Array<string>; }**|  | |
| **bookId** | [**number**] |  | defaults to undefined|
| **quizId** | [**number**] |  | defaults to undefined|


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

# **unbindKnowledgeBase**
> BaseResponseVoid unbindKnowledgeBase()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let id: number; // (default to undefined)
let kbId: number; // (default to undefined)

const { status, data } = await apiInstance.unbindKnowledgeBase(
    id,
    kbId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|
| **kbId** | [**number**] |  | defaults to undefined|


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

# **unbindWorkflow**
> BaseResponseVoid unbindWorkflow()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let id: number; // (default to undefined)
let workflowId: number; // (default to undefined)

const { status, data } = await apiInstance.unbindWorkflow(
    id,
    workflowId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|
| **workflowId** | [**number**] |  | defaults to undefined|


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

# **update2**
> BaseResponseAiAssistantVO update2(updateAiAssistantCommand)


### Example

```typescript
import {
    AIApi,
    Configuration,
    UpdateAiAssistantCommand
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let id: number; // (default to undefined)
let updateAiAssistantCommand: UpdateAiAssistantCommand; //

const { status, data } = await apiInstance.update2(
    id,
    updateAiAssistantCommand
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **updateAiAssistantCommand** | **UpdateAiAssistantCommand**|  | |
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseAiAssistantVO**

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

