# AIApi

All URIs are relative to *http://localhost:8080*

|Method | HTTP request | Description|
|------------- | ------------- | -------------|
|[**askQuestion**](#askquestion) | **POST** /api/books/{bookId}/ai/chat | 提问（新对话）|
|[**assistantArchive**](#assistantarchive) | **PUT** /api/ai/assistants/{id}/archive | 归档AI助手|
|[**assistantBindKnowledgeBase**](#assistantbindknowledgebase) | **POST** /api/ai/assistants/{id}/knowledge-bases/{kbId} | 绑定知识库|
|[**assistantBindWorkflow**](#assistantbindworkflow) | **POST** /api/ai/assistants/{id}/workflows/{workflowId} | 绑定工作流到AI助手|
|[**assistantChat**](#assistantchat) | **POST** /api/ai/assistants/{id}/chat/stream | AI助手流式对话|
|[**assistantCreate**](#assistantcreate) | **POST** /api/ai/assistants | 创建AI助手|
|[**assistantDelete**](#assistantdelete) | **DELETE** /api/ai/assistants/{id} | 删除AI助手|
|[**assistantExecuteWorkflow**](#assistantexecuteworkflow) | **POST** /api/ai/assistants/{id}/workflows/{workflowId}/execute | 执行AI助手绑定的工作流|
|[**assistantGenerateAvatar**](#assistantgenerateavatar) | **POST** /api/ai/assistants/generate-avatar | AI生成助手头像|
|[**assistantGetById**](#assistantgetbyid) | **GET** /api/ai/assistants/{id} | 获取AI助手详情|
|[**assistantGetWorkflowSkills**](#assistantgetworkflowskills) | **GET** /api/ai/assistants/{id}/workflow-skills | 获取AI助手的工作流技能列表|
|[**assistantGetWorkflows**](#assistantgetworkflows) | **GET** /api/ai/assistants/{id}/workflows | 获取AI助手绑定的工作流列表|
|[**assistantListByCreator**](#assistantlistbycreator) | **GET** /api/ai/assistants | 获取用户的AI助手列表|
|[**assistantListPublic**](#assistantlistpublic) | **GET** /api/ai/assistants/public | 获取公开的AI助手列表|
|[**assistantPublish**](#assistantpublish) | **PUT** /api/ai/assistants/{id}/publish | 发布AI助手|
|[**assistantSearch**](#assistantsearch) | **GET** /api/ai/assistants/search | 搜索AI助手|
|[**assistantUnbindKnowledgeBase**](#assistantunbindknowledgebase) | **DELETE** /api/ai/assistants/{id}/knowledge-bases/{kbId} | 解绑知识库|
|[**assistantUnbindWorkflow**](#assistantunbindworkflow) | **DELETE** /api/ai/assistants/{id}/workflows/{workflowId} | 解绑工作流|
|[**assistantUpdate**](#assistantupdate) | **PUT** /api/ai/assistants/{id} | 更新AI助手|
|[**batchProcessArticles**](#batchprocessarticles) | **POST** /api/admin/articles/ai/batch-process | 批量AI处理文章|
|[**chat**](#chat) | **POST** /api/articles/chat | 非流式对话|
|[**continueConversation**](#continueconversation) | **POST** /api/books/{bookId}/ai/chat/{conversationId} | 继续对话|
|[**createSession**](#createsession) | **POST** /api/ai/chat/sessions | 创建新会话|
|[**deleteSession1**](#deletesession1) | **DELETE** /api/ai/chat/sessions/{sessionId} | 删除会话|
|[**extractKnowledgePoints**](#extractknowledgepoints) | **POST** /api/books/{bookId}/ai/chapters/{chapterId}/knowledge-points | 提取章节知识点|
|[**generateQuiz**](#generatequiz) | **POST** /api/books/{bookId}/ai/chapters/{chapterId}/quiz | 生成阅读测试|
|[**generateSummary**](#generatesummary) | **POST** /api/books/{bookId}/ai/chapters/{chapterId}/summary | 生成章节总结|
|[**getAllSummaries**](#getallsummaries) | **GET** /api/books/{bookId}/ai/chapters/{chapterId}/summaries | 获取章节所有总结|
|[**getConversation**](#getconversation) | **GET** /api/books/{bookId}/ai/chat/{conversationId} | 获取对话历史|
|[**getKnowledgePoints**](#getknowledgepoints) | **GET** /api/books/{bookId}/ai/chapters/{chapterId}/knowledge-points | 获取章节知识点|
|[**getLatestQuiz**](#getlatestquiz) | **GET** /api/books/{bookId}/ai/chapters/{chapterId}/quiz/latest | 获取章节最新测试|
|[**getQuiz**](#getquiz) | **GET** /api/books/{bookId}/ai/quiz/{quizId} | 获取测试|
|[**getSessionDetail1**](#getsessiondetail1) | **GET** /api/ai/chat/sessions/{sessionId} | 获取会话详情（含消息列表）|
|[**getSummary**](#getsummary) | **GET** /api/books/{bookId}/ai/chapters/{chapterId}/summary | 获取章节总结|
|[**getUserConversations**](#getuserconversations) | **GET** /api/books/{bookId}/ai/conversations | 获取用户对话列表|
|[**listAllModels**](#listallmodels) | **GET** /api/ai/chat/models/all | 获取全量模型配置|
|[**listModels**](#listmodels) | **GET** /api/ai/chat/models | 获取可用模型列表|
|[**listSessions**](#listsessions) | **GET** /api/ai/chat/sessions | 获取会话列表|
|[**previewAiProcess**](#previewaiprocess) | **POST** /api/admin/articles/ai/preview | 预览AI处理结果|
|[**processArticle**](#processarticle) | **POST** /api/admin/articles/ai/process | AI处理单篇文章|
|[**regenerateKnowledgePoints**](#regenerateknowledgepoints) | **POST** /api/books/{bookId}/ai/chapters/{chapterId}/knowledge-points/regenerate | 重新提取知识点|
|[**regenerateSummary**](#regeneratesummary) | **POST** /api/books/{bookId}/ai/chapters/{chapterId}/summary/regenerate | 重新生成总结|
|[**searchKnowledgePoints**](#searchknowledgepoints) | **GET** /api/books/{bookId}/ai/knowledge-points/search | 搜索知识点|
|[**sessionStreamChat**](#sessionstreamchat) | **POST** /api/ai/chat/sessions/{sessionId}/stream | 会话级流式对话|
|[**streamChat**](#streamchat) | **POST** /api/articles/chat/stream | 流式对话|
|[**streamChat1**](#streamchat1) | **POST** /api/ai/chat/stream | 无状态流式对话|
|[**streamChatGet**](#streamchatget) | **GET** /api/articles/{articleId}/chat/stream | GET流式对话|
|[**submitAnswers**](#submitanswers) | **POST** /api/books/{bookId}/ai/quiz/{quizId}/submit | 提交答案并评分|

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

# **assistantArchive**
> BaseResponseAiAssistantVO assistantArchive()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.assistantArchive(
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

# **assistantBindKnowledgeBase**
> BaseResponseVoid assistantBindKnowledgeBase()


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

const { status, data } = await apiInstance.assistantBindKnowledgeBase(
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

# **assistantBindWorkflow**
> BaseResponseVoid assistantBindWorkflow()


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

const { status, data } = await apiInstance.assistantBindWorkflow(
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

# **assistantChat**
> SseEmitter assistantChat(assistantChatRequest)

通过助手ID与配置好的AI助手进行SSE流式对话。自动使用助手的systemPrompt和modelConfig，自动从绑定的知识库进行RAG检索，支持文档解析、多模态图片理解、文生图、图参生图、文生视频等全部外部技能。如不传sessionId则自动创建新会话，支持会话级记忆管理。

### Example

```typescript
import {
    AIApi,
    Configuration,
    AssistantChatRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let id: number; //AI助手ID (default to undefined)
let assistantChatRequest: AssistantChatRequest; //

const { status, data } = await apiInstance.assistantChat(
    id,
    assistantChatRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **assistantChatRequest** | **AssistantChatRequest**|  | |
| **id** | [**number**] | AI助手ID | defaults to undefined|


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

# **assistantCreate**
> BaseResponseAiAssistantVO assistantCreate(createAiAssistantCommand)


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

const { status, data } = await apiInstance.assistantCreate(
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

# **assistantDelete**
> BaseResponseVoid assistantDelete()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.assistantDelete(
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

# **assistantExecuteWorkflow**
> BaseResponseMapStringObject assistantExecuteWorkflow()


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

const { status, data } = await apiInstance.assistantExecuteWorkflow(
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

# **assistantGenerateAvatar**
> BaseResponseGenerateAvatarResponse assistantGenerateAvatar(generateAvatarRequest)

根据提示词使用AI生成助手头像图片，图片会自动上传到OSS持久化存储，返回OSS图片URL

### Example

```typescript
import {
    AIApi,
    Configuration,
    GenerateAvatarRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let generateAvatarRequest: GenerateAvatarRequest; //

const { status, data } = await apiInstance.assistantGenerateAvatar(
    generateAvatarRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **generateAvatarRequest** | **GenerateAvatarRequest**|  | |


### Return type

**BaseResponseGenerateAvatarResponse**

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

# **assistantGetById**
> BaseResponseAiAssistantVO assistantGetById()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.assistantGetById(
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

# **assistantGetWorkflowSkills**
> BaseResponseListWorkflowSkillVO assistantGetWorkflowSkills()

返回绑定的工作流详情，包含描述、输入参数、输出参数，供前端展示或 AI 助手对话时使用

### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.assistantGetWorkflowSkills(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**number**] |  | defaults to undefined|


### Return type

**BaseResponseListWorkflowSkillVO**

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

# **assistantGetWorkflows**
> BaseResponseListLong assistantGetWorkflows()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.assistantGetWorkflows(
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

# **assistantListByCreator**
> BaseResponseListAiAssistantVO assistantListByCreator()


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

const { status, data } = await apiInstance.assistantListByCreator(
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

# **assistantListPublic**
> BaseResponseListAiAssistantVO assistantListPublic()


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

const { status, data } = await apiInstance.assistantListPublic(
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

# **assistantPublish**
> BaseResponseAiAssistantVO assistantPublish()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let id: number; // (default to undefined)

const { status, data } = await apiInstance.assistantPublish(
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

# **assistantSearch**
> BaseResponseListAiAssistantVO assistantSearch()


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

const { status, data } = await apiInstance.assistantSearch(
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

# **assistantUnbindKnowledgeBase**
> BaseResponseVoid assistantUnbindKnowledgeBase()


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

const { status, data } = await apiInstance.assistantUnbindKnowledgeBase(
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

# **assistantUnbindWorkflow**
> BaseResponseVoid assistantUnbindWorkflow()


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

const { status, data } = await apiInstance.assistantUnbindWorkflow(
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

# **assistantUpdate**
> BaseResponseAiAssistantVO assistantUpdate(updateAiAssistantCommand)


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

const { status, data } = await apiInstance.assistantUpdate(
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

# **createSession**
> BaseResponseMapStringObject createSession()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

const { status, data } = await apiInstance.createSession();
```

### Parameters
This endpoint does not have any parameters.


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

# **deleteSession1**
> BaseResponseVoid deleteSession1()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let sessionId: number; //会话ID (default to undefined)

const { status, data } = await apiInstance.deleteSession1(
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

# **getSessionDetail1**
> BaseResponseMapStringObject getSessionDetail1()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let sessionId: number; //会话ID (default to undefined)

const { status, data } = await apiInstance.getSessionDetail1(
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

# **listAllModels**
> BaseResponseListMapStringObject listAllModels()

返回所有供应商的所有模型（含未启用的），标注 enabled/isDefault 状态

### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

const { status, data } = await apiInstance.listAllModels();
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

# **listModels**
> BaseResponseListMapStringObject listModels()

仅返回已启用的模型，前端用于模型选择下拉框

### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

const { status, data } = await apiInstance.listModels();
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

# **listSessions**
> BaseResponseListMapStringObject listSessions()


### Example

```typescript
import {
    AIApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let page: number; //页码 (optional) (default to 0)
let size: number; //每页大小 (optional) (default to 20)

const { status, data } = await apiInstance.listSessions(
    page,
    size
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **page** | [**number**] | 页码 | (optional) defaults to 0|
| **size** | [**number**] | 每页大小 | (optional) defaults to 20|


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

# **sessionStreamChat**
> SseEmitter sessionStreamChat(sessionChatRequest)

基于会话的SSE对话，服务端自动管理记忆（滑动窗口+摘要压缩）

### Example

```typescript
import {
    AIApi,
    Configuration,
    SessionChatRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new AIApi(configuration);

let sessionId: number; //会话ID (default to undefined)
let sessionChatRequest: SessionChatRequest; //

const { status, data } = await apiInstance.sessionStreamChat(
    sessionId,
    sessionChatRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **sessionChatRequest** | **SessionChatRequest**|  | |
| **sessionId** | [**number**] | 会话ID | defaults to undefined|


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

前端自行管理历史的SSE对话，支持图片URL

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

