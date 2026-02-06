# nova_api.api.AIApi

## Load the API package
```dart
import 'package:nova_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**archive**](AIApi.md#archive) | **PUT** /api/ai/assistants/{id}/archive | 归档AI助手
[**askQuestion**](AIApi.md#askquestion) | **POST** /api/books/{bookId}/ai/chat | 提问（新对话）
[**batchProcessArticles**](AIApi.md#batchprocessarticles) | **POST** /api/admin/articles/ai/batch-process | 批量AI处理文章
[**bindKnowledgeBase**](AIApi.md#bindknowledgebase) | **POST** /api/ai/assistants/{id}/knowledge-bases/{kbId} | 绑定知识库
[**bindWorkflow**](AIApi.md#bindworkflow) | **POST** /api/ai/assistants/{id}/workflows/{workflowId} | 绑定工作流到AI助手
[**chat**](AIApi.md#chat) | **POST** /api/articles/chat | 非流式对话
[**continueConversation**](AIApi.md#continueconversation) | **POST** /api/books/{bookId}/ai/chat/{conversationId} | 继续对话
[**create2**](AIApi.md#create2) | **POST** /api/ai/assistants | 创建AI助手
[**createSession**](AIApi.md#createsession) | **POST** /api/ai/chat/sessions | 创建新会话
[**delete2**](AIApi.md#delete2) | **DELETE** /api/ai/assistants/{id} | 删除AI助手
[**deleteSession**](AIApi.md#deletesession) | **DELETE** /api/ai/chat/sessions/{sessionId} | 删除会话
[**executeWorkflow**](AIApi.md#executeworkflow) | **POST** /api/ai/assistants/{id}/workflows/{workflowId}/execute | 执行AI助手绑定的工作流
[**extractKnowledgePoints**](AIApi.md#extractknowledgepoints) | **POST** /api/books/{bookId}/ai/chapters/{chapterId}/knowledge-points | 提取章节知识点
[**generateQuiz**](AIApi.md#generatequiz) | **POST** /api/books/{bookId}/ai/chapters/{chapterId}/quiz | 生成阅读测试
[**generateSummary**](AIApi.md#generatesummary) | **POST** /api/books/{bookId}/ai/chapters/{chapterId}/summary | 生成章节总结
[**getAllSummaries**](AIApi.md#getallsummaries) | **GET** /api/books/{bookId}/ai/chapters/{chapterId}/summaries | 获取章节所有总结
[**getById2**](AIApi.md#getbyid2) | **GET** /api/ai/assistants/{id} | 获取AI助手详情
[**getConversation**](AIApi.md#getconversation) | **GET** /api/books/{bookId}/ai/chat/{conversationId} | 获取对话历史
[**getKnowledgePoints**](AIApi.md#getknowledgepoints) | **GET** /api/books/{bookId}/ai/chapters/{chapterId}/knowledge-points | 获取章节知识点
[**getLatestQuiz**](AIApi.md#getlatestquiz) | **GET** /api/books/{bookId}/ai/chapters/{chapterId}/quiz/latest | 获取章节最新测试
[**getQuiz**](AIApi.md#getquiz) | **GET** /api/books/{bookId}/ai/quiz/{quizId} | 获取测试
[**getSessionDetail**](AIApi.md#getsessiondetail) | **GET** /api/ai/chat/sessions/{sessionId} | 获取会话详情（含消息列表）
[**getSummary**](AIApi.md#getsummary) | **GET** /api/books/{bookId}/ai/chapters/{chapterId}/summary | 获取章节总结
[**getUserConversations**](AIApi.md#getuserconversations) | **GET** /api/books/{bookId}/ai/conversations | 获取用户对话列表
[**getWorkflows**](AIApi.md#getworkflows) | **GET** /api/ai/assistants/{id}/workflows | 获取AI助手绑定的工作流列表
[**listAllModels**](AIApi.md#listallmodels) | **GET** /api/ai/chat/models/all | 获取全量模型配置
[**listByCreator1**](AIApi.md#listbycreator1) | **GET** /api/ai/assistants | 获取用户的AI助手列表
[**listModels**](AIApi.md#listmodels) | **GET** /api/ai/chat/models | 获取可用模型列表
[**listPublic1**](AIApi.md#listpublic1) | **GET** /api/ai/assistants/public | 获取公开的AI助手列表
[**listSessions**](AIApi.md#listsessions) | **GET** /api/ai/chat/sessions | 获取会话列表
[**previewAiProcess**](AIApi.md#previewaiprocess) | **POST** /api/admin/articles/ai/preview | 预览AI处理结果
[**processArticle**](AIApi.md#processarticle) | **POST** /api/admin/articles/ai/process | AI处理单篇文章
[**publish**](AIApi.md#publish) | **PUT** /api/ai/assistants/{id}/publish | 发布AI助手
[**regenerateKnowledgePoints**](AIApi.md#regenerateknowledgepoints) | **POST** /api/books/{bookId}/ai/chapters/{chapterId}/knowledge-points/regenerate | 重新提取知识点
[**regenerateSummary**](AIApi.md#regeneratesummary) | **POST** /api/books/{bookId}/ai/chapters/{chapterId}/summary/regenerate | 重新生成总结
[**search1**](AIApi.md#search1) | **GET** /api/ai/assistants/search | 搜索AI助手
[**searchKnowledgePoints**](AIApi.md#searchknowledgepoints) | **GET** /api/books/{bookId}/ai/knowledge-points/search | 搜索知识点
[**sessionStreamChat**](AIApi.md#sessionstreamchat) | **POST** /api/ai/chat/sessions/{sessionId}/stream | 会话级流式对话
[**streamChat**](AIApi.md#streamchat) | **POST** /api/articles/chat/stream | 流式对话
[**streamChat1**](AIApi.md#streamchat1) | **POST** /api/ai/chat/stream | 无状态流式对话
[**streamChatGet**](AIApi.md#streamchatget) | **GET** /api/articles/{articleId}/chat/stream | GET流式对话
[**submitAnswers**](AIApi.md#submitanswers) | **POST** /api/books/{bookId}/ai/quiz/{quizId}/submit | 提交答案并评分
[**unbindKnowledgeBase**](AIApi.md#unbindknowledgebase) | **DELETE** /api/ai/assistants/{id}/knowledge-bases/{kbId} | 解绑知识库
[**unbindWorkflow**](AIApi.md#unbindworkflow) | **DELETE** /api/ai/assistants/{id}/workflows/{workflowId} | 解绑工作流
[**update2**](AIApi.md#update2) | **PUT** /api/ai/assistants/{id} | 更新AI助手


# **archive**
> BaseResponseAiAssistantVO archive(id)

归档AI助手

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int id = 789; // int | 

try {
    final response = api.archive(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->archive: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseAiAssistantVO**](BaseResponseAiAssistantVO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **askQuestion**
> BaseResponseMapStringObject askQuestion(bookId, requestBody)

提问（新对话）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int bookId = 789; // int | 
final BuiltMap<String, JsonObject> requestBody = Object; // BuiltMap<String, JsonObject> | 

try {
    final response = api.askQuestion(bookId, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->askQuestion: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **requestBody** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)|  | 

### Return type

[**BaseResponseMapStringObject**](BaseResponseMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **batchProcessArticles**
> BaseResponseMapStringObject batchProcessArticles(batchAiProcessRequest)

批量AI处理文章

批量对多篇文章进行AI处理

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final BatchAiProcessRequest batchAiProcessRequest = ; // BatchAiProcessRequest | 

try {
    final response = api.batchProcessArticles(batchAiProcessRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->batchProcessArticles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **batchAiProcessRequest** | [**BatchAiProcessRequest**](BatchAiProcessRequest.md)|  | 

### Return type

[**BaseResponseMapStringObject**](BaseResponseMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bindKnowledgeBase**
> BaseResponseVoid bindKnowledgeBase(id, kbId)

绑定知识库

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int id = 789; // int | 
final int kbId = 789; // int | 

try {
    final response = api.bindKnowledgeBase(id, kbId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->bindKnowledgeBase: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **kbId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bindWorkflow**
> BaseResponseVoid bindWorkflow(id, workflowId)

绑定工作流到AI助手

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int id = 789; // int | 
final int workflowId = 789; // int | 

try {
    final response = api.bindWorkflow(id, workflowId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->bindWorkflow: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **workflowId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **chat**
> BaseResponseMapStringString chat(articleChatRequest)

非流式对话

与文章内容进行AI对话，返回完整回复

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final ArticleChatRequest articleChatRequest = ; // ArticleChatRequest | 

try {
    final response = api.chat(articleChatRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->chat: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **articleChatRequest** | [**ArticleChatRequest**](ArticleChatRequest.md)|  | 

### Return type

[**BaseResponseMapStringString**](BaseResponseMapStringString.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **continueConversation**
> BaseResponseMapStringObject continueConversation(bookId, conversationId, requestBody)

继续对话

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int bookId = 789; // int | 
final int conversationId = 789; // int | 
final BuiltMap<String, String> requestBody = ; // BuiltMap<String, String> | 

try {
    final response = api.continueConversation(bookId, conversationId, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->continueConversation: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **conversationId** | **int**|  | 
 **requestBody** | [**BuiltMap&lt;String, String&gt;**](String.md)|  | 

### Return type

[**BaseResponseMapStringObject**](BaseResponseMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **create2**
> BaseResponseAiAssistantVO create2(userId, createAiAssistantCommand)

创建AI助手

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int userId = 789; // int | 
final CreateAiAssistantCommand createAiAssistantCommand = ; // CreateAiAssistantCommand | 

try {
    final response = api.create2(userId, createAiAssistantCommand);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->create2: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**|  | 
 **createAiAssistantCommand** | [**CreateAiAssistantCommand**](CreateAiAssistantCommand.md)|  | 

### Return type

[**BaseResponseAiAssistantVO**](BaseResponseAiAssistantVO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createSession**
> BaseResponseMapStringObject createSession()

创建新会话

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();

try {
    final response = api.createSession();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->createSession: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseMapStringObject**](BaseResponseMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **delete2**
> BaseResponseVoid delete2(id)

删除AI助手

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int id = 789; // int | 

try {
    final response = api.delete2(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->delete2: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteSession**
> BaseResponseVoid deleteSession(sessionId)

删除会话

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int sessionId = 789; // int | 会话ID

try {
    final response = api.deleteSession(sessionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->deleteSession: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sessionId** | **int**| 会话ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **executeWorkflow**
> BaseResponseMapStringObject executeWorkflow(id, workflowId, userId, requestBody)

执行AI助手绑定的工作流

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int id = 789; // int | 
final int workflowId = 789; // int | 
final int userId = 789; // int | 
final BuiltMap<String, JsonObject> requestBody = Object; // BuiltMap<String, JsonObject> | 

try {
    final response = api.executeWorkflow(id, workflowId, userId, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->executeWorkflow: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **workflowId** | **int**|  | 
 **userId** | **int**|  | 
 **requestBody** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)|  | [optional] 

### Return type

[**BaseResponseMapStringObject**](BaseResponseMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **extractKnowledgePoints**
> BaseResponseListKnowledgePoint extractKnowledgePoints(bookId, chapterId)

提取章节知识点

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int bookId = 789; // int | 
final int chapterId = 789; // int | 

try {
    final response = api.extractKnowledgePoints(bookId, chapterId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->extractKnowledgePoints: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **chapterId** | **int**|  | 

### Return type

[**BaseResponseListKnowledgePoint**](BaseResponseListKnowledgePoint.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **generateQuiz**
> BaseResponseReadingQuiz generateQuiz(bookId, chapterId, questionCount, difficulty)

生成阅读测试

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int bookId = 789; // int | 
final int chapterId = 789; // int | 
final int questionCount = 56; // int | 
final String difficulty = difficulty_example; // String | 

try {
    final response = api.generateQuiz(bookId, chapterId, questionCount, difficulty);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->generateQuiz: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **chapterId** | **int**|  | 
 **questionCount** | **int**|  | [optional] 
 **difficulty** | **String**|  | [optional] 

### Return type

[**BaseResponseReadingQuiz**](BaseResponseReadingQuiz.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **generateSummary**
> BaseResponseChapterSummary generateSummary(bookId, chapterId, summaryType)

生成章节总结

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int bookId = 789; // int | 
final int chapterId = 789; // int | 
final String summaryType = summaryType_example; // String | 

try {
    final response = api.generateSummary(bookId, chapterId, summaryType);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->generateSummary: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **chapterId** | **int**|  | 
 **summaryType** | **String**|  | [optional] [default to 'DETAILED']

### Return type

[**BaseResponseChapterSummary**](BaseResponseChapterSummary.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllSummaries**
> BaseResponseListChapterSummary getAllSummaries(bookId, chapterId)

获取章节所有总结

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int bookId = 789; // int | 
final int chapterId = 789; // int | 

try {
    final response = api.getAllSummaries(bookId, chapterId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->getAllSummaries: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **chapterId** | **int**|  | 

### Return type

[**BaseResponseListChapterSummary**](BaseResponseListChapterSummary.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getById2**
> BaseResponseAiAssistantVO getById2(id)

获取AI助手详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int id = 789; // int | 

try {
    final response = api.getById2(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->getById2: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseAiAssistantVO**](BaseResponseAiAssistantVO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getConversation**
> BaseResponseAiConversation getConversation(bookId, conversationId)

获取对话历史

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int bookId = 789; // int | 
final int conversationId = 789; // int | 

try {
    final response = api.getConversation(bookId, conversationId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->getConversation: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **conversationId** | **int**|  | 

### Return type

[**BaseResponseAiConversation**](BaseResponseAiConversation.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getKnowledgePoints**
> BaseResponseListKnowledgePoint getKnowledgePoints(bookId, chapterId, type)

获取章节知识点

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int bookId = 789; // int | 
final int chapterId = 789; // int | 
final String type = type_example; // String | 

try {
    final response = api.getKnowledgePoints(bookId, chapterId, type);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->getKnowledgePoints: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **chapterId** | **int**|  | 
 **type** | **String**|  | [optional] 

### Return type

[**BaseResponseListKnowledgePoint**](BaseResponseListKnowledgePoint.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getLatestQuiz**
> BaseResponseReadingQuiz getLatestQuiz(bookId, chapterId)

获取章节最新测试

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int bookId = 789; // int | 
final int chapterId = 789; // int | 

try {
    final response = api.getLatestQuiz(bookId, chapterId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->getLatestQuiz: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **chapterId** | **int**|  | 

### Return type

[**BaseResponseReadingQuiz**](BaseResponseReadingQuiz.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getQuiz**
> BaseResponseReadingQuiz getQuiz(bookId, quizId)

获取测试

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int bookId = 789; // int | 
final int quizId = 789; // int | 

try {
    final response = api.getQuiz(bookId, quizId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->getQuiz: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **quizId** | **int**|  | 

### Return type

[**BaseResponseReadingQuiz**](BaseResponseReadingQuiz.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSessionDetail**
> BaseResponseMapStringObject getSessionDetail(sessionId)

获取会话详情（含消息列表）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int sessionId = 789; // int | 会话ID

try {
    final response = api.getSessionDetail(sessionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->getSessionDetail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sessionId** | **int**| 会话ID | 

### Return type

[**BaseResponseMapStringObject**](BaseResponseMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSummary**
> BaseResponseChapterSummary getSummary(bookId, chapterId, summaryType)

获取章节总结

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int bookId = 789; // int | 
final int chapterId = 789; // int | 
final String summaryType = summaryType_example; // String | 

try {
    final response = api.getSummary(bookId, chapterId, summaryType);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->getSummary: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **chapterId** | **int**|  | 
 **summaryType** | **String**|  | [optional] [default to 'DETAILED']

### Return type

[**BaseResponseChapterSummary**](BaseResponseChapterSummary.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserConversations**
> BaseResponseListAiConversation getUserConversations(bookId, userId, page, size)

获取用户对话列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int bookId = 789; // int | 
final int userId = 789; // int | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.getUserConversations(bookId, userId, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->getUserConversations: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **userId** | **int**|  | 
 **page** | **int**|  | [optional] [default to 0]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponseListAiConversation**](BaseResponseListAiConversation.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getWorkflows**
> BaseResponseListLong getWorkflows(id)

获取AI助手绑定的工作流列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int id = 789; // int | 

try {
    final response = api.getWorkflows(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->getWorkflows: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseListLong**](BaseResponseListLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAllModels**
> BaseResponseListMapStringObject listAllModels()

获取全量模型配置

返回所有供应商的所有模型（含未启用的），标注 enabled/isDefault 状态

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();

try {
    final response = api.listAllModels();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->listAllModels: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListMapStringObject**](BaseResponseListMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listByCreator1**
> BaseResponseListAiAssistantVO listByCreator1(userId, page, size)

获取用户的AI助手列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int userId = 789; // int | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.listByCreator1(userId, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->listByCreator1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**|  | 
 **page** | **int**|  | [optional] [default to 0]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponseListAiAssistantVO**](BaseResponseListAiAssistantVO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listModels**
> BaseResponseListMapStringObject listModels()

获取可用模型列表

仅返回已启用的模型，前端用于模型选择下拉框

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();

try {
    final response = api.listModels();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->listModels: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListMapStringObject**](BaseResponseListMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listPublic1**
> BaseResponseListAiAssistantVO listPublic1(page, size)

获取公开的AI助手列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.listPublic1(page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->listPublic1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] [default to 0]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponseListAiAssistantVO**](BaseResponseListAiAssistantVO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listSessions**
> BaseResponseListMapStringObject listSessions(page, size)

获取会话列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int page = 56; // int | 页码
final int size = 56; // int | 每页大小

try {
    final response = api.listSessions(page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->listSessions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**| 页码 | [optional] [default to 0]
 **size** | **int**| 每页大小 | [optional] [default to 20]

### Return type

[**BaseResponseListMapStringObject**](BaseResponseListMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **previewAiProcess**
> BaseResponseAiProcessResultResponse previewAiProcess(previewAiProcessRequest)

预览AI处理结果

预览AI处理结果，不保存到数据库

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final PreviewAiProcessRequest previewAiProcessRequest = ; // PreviewAiProcessRequest | 

try {
    final response = api.previewAiProcess(previewAiProcessRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->previewAiProcess: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **previewAiProcessRequest** | [**PreviewAiProcessRequest**](PreviewAiProcessRequest.md)|  | 

### Return type

[**BaseResponseAiProcessResultResponse**](BaseResponseAiProcessResultResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **processArticle**
> BaseResponseDailyArticleResponse processArticle(aiProcessArticleRequest)

AI处理单篇文章

对指定文章进行AI内容排版和摘要生成

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final AiProcessArticleRequest aiProcessArticleRequest = ; // AiProcessArticleRequest | 

try {
    final response = api.processArticle(aiProcessArticleRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->processArticle: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **aiProcessArticleRequest** | [**AiProcessArticleRequest**](AiProcessArticleRequest.md)|  | 

### Return type

[**BaseResponseDailyArticleResponse**](BaseResponseDailyArticleResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publish**
> BaseResponseAiAssistantVO publish(id)

发布AI助手

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int id = 789; // int | 

try {
    final response = api.publish(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->publish: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseAiAssistantVO**](BaseResponseAiAssistantVO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **regenerateKnowledgePoints**
> BaseResponseListKnowledgePoint regenerateKnowledgePoints(bookId, chapterId)

重新提取知识点

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int bookId = 789; // int | 
final int chapterId = 789; // int | 

try {
    final response = api.regenerateKnowledgePoints(bookId, chapterId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->regenerateKnowledgePoints: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **chapterId** | **int**|  | 

### Return type

[**BaseResponseListKnowledgePoint**](BaseResponseListKnowledgePoint.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **regenerateSummary**
> BaseResponseChapterSummary regenerateSummary(bookId, chapterId, summaryType)

重新生成总结

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int bookId = 789; // int | 
final int chapterId = 789; // int | 
final String summaryType = summaryType_example; // String | 

try {
    final response = api.regenerateSummary(bookId, chapterId, summaryType);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->regenerateSummary: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **chapterId** | **int**|  | 
 **summaryType** | **String**|  | [optional] [default to 'DETAILED']

### Return type

[**BaseResponseChapterSummary**](BaseResponseChapterSummary.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **search1**
> BaseResponseListAiAssistantVO search1(keyword, page, size)

搜索AI助手

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final String keyword = keyword_example; // String | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.search1(keyword, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->search1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **keyword** | **String**|  | 
 **page** | **int**|  | [optional] [default to 0]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponseListAiAssistantVO**](BaseResponseListAiAssistantVO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchKnowledgePoints**
> BaseResponseListKnowledgePoint searchKnowledgePoints(bookId, keyword, page, size)

搜索知识点

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int bookId = 789; // int | 
final String keyword = keyword_example; // String | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.searchKnowledgePoints(bookId, keyword, page, size);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->searchKnowledgePoints: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **keyword** | **String**|  | 
 **page** | **int**|  | [optional] [default to 0]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BaseResponseListKnowledgePoint**](BaseResponseListKnowledgePoint.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sessionStreamChat**
> SseEmitter sessionStreamChat(sessionId, sessionChatRequest)

会话级流式对话

基于会话的SSE对话，服务端自动管理记忆（滑动窗口+摘要压缩）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int sessionId = 789; // int | 会话ID
final SessionChatRequest sessionChatRequest = ; // SessionChatRequest | 

try {
    final response = api.sessionStreamChat(sessionId, sessionChatRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->sessionStreamChat: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sessionId** | **int**| 会话ID | 
 **sessionChatRequest** | [**SessionChatRequest**](SessionChatRequest.md)|  | 

### Return type

[**SseEmitter**](SseEmitter.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, text/event-stream

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **streamChat**
> SseEmitter streamChat(articleChatRequest)

流式对话

与文章内容进行AI流式对话，返回SSE事件流

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final ArticleChatRequest articleChatRequest = ; // ArticleChatRequest | 

try {
    final response = api.streamChat(articleChatRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->streamChat: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **articleChatRequest** | [**ArticleChatRequest**](ArticleChatRequest.md)|  | 

### Return type

[**SseEmitter**](SseEmitter.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, text/event-stream

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **streamChat1**
> SseEmitter streamChat1(chatRequest)

无状态流式对话

前端自行管理历史的SSE对话，支持图片URL

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final ChatRequest chatRequest = ; // ChatRequest | 

try {
    final response = api.streamChat1(chatRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->streamChat1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **chatRequest** | [**ChatRequest**](ChatRequest.md)|  | 

### Return type

[**SseEmitter**](SseEmitter.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, text/event-stream

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **streamChatGet**
> SseEmitter streamChatGet(articleId, message, historyJson)

GET流式对话

使用GET方式进行流式对话，便于EventSource使用

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int articleId = 789; // int | 
final String message = message_example; // String | 
final String historyJson = historyJson_example; // String | 

try {
    final response = api.streamChatGet(articleId, message, historyJson);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->streamChatGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **articleId** | **int**|  | 
 **message** | **String**|  | 
 **historyJson** | **String**|  | [optional] 

### Return type

[**SseEmitter**](SseEmitter.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/event-stream

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **submitAnswers**
> BaseResponseMapStringObject submitAnswers(bookId, quizId, requestBody)

提交答案并评分

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int bookId = 789; // int | 
final int quizId = 789; // int | 
final BuiltMap<String, BuiltList<String>> requestBody = ; // BuiltMap<String, BuiltList<String>> | 

try {
    final response = api.submitAnswers(bookId, quizId, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->submitAnswers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookId** | **int**|  | 
 **quizId** | **int**|  | 
 **requestBody** | [**BuiltMap&lt;String, BuiltList&lt;String&gt;&gt;**](BuiltList.md)|  | 

### Return type

[**BaseResponseMapStringObject**](BaseResponseMapStringObject.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unbindKnowledgeBase**
> BaseResponseVoid unbindKnowledgeBase(id, kbId)

解绑知识库

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int id = 789; // int | 
final int kbId = 789; // int | 

try {
    final response = api.unbindKnowledgeBase(id, kbId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->unbindKnowledgeBase: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **kbId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unbindWorkflow**
> BaseResponseVoid unbindWorkflow(id, workflowId)

解绑工作流

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int id = 789; // int | 
final int workflowId = 789; // int | 

try {
    final response = api.unbindWorkflow(id, workflowId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->unbindWorkflow: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **workflowId** | **int**|  | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **update2**
> BaseResponseAiAssistantVO update2(id, updateAiAssistantCommand)

更新AI助手

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final int id = 789; // int | 
final UpdateAiAssistantCommand updateAiAssistantCommand = ; // UpdateAiAssistantCommand | 

try {
    final response = api.update2(id, updateAiAssistantCommand);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->update2: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **updateAiAssistantCommand** | [**UpdateAiAssistantCommand**](UpdateAiAssistantCommand.md)|  | 

### Return type

[**BaseResponseAiAssistantVO**](BaseResponseAiAssistantVO.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

