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
[**bindKnowledgeBase**](AIApi.md#bindknowledgebase) | **POST** /api/ai/assistants/{id}/knowledge-bases/{kbId} | 绑定知识库
[**bindWorkflow**](AIApi.md#bindworkflow) | **POST** /api/ai/assistants/{id}/workflows/{workflowId} | 绑定工作流到AI助手
[**continueConversation**](AIApi.md#continueconversation) | **POST** /api/books/{bookId}/ai/chat/{conversationId} | 继续对话
[**create2**](AIApi.md#create2) | **POST** /api/ai/assistants | 创建AI助手
[**delete2**](AIApi.md#delete2) | **DELETE** /api/ai/assistants/{id} | 删除AI助手
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
[**getSummary**](AIApi.md#getsummary) | **GET** /api/books/{bookId}/ai/chapters/{chapterId}/summary | 获取章节总结
[**getUserConversations**](AIApi.md#getuserconversations) | **GET** /api/books/{bookId}/ai/conversations | 获取用户对话列表
[**getWorkflows**](AIApi.md#getworkflows) | **GET** /api/ai/assistants/{id}/workflows | 获取AI助手绑定的工作流列表
[**listByCreator1**](AIApi.md#listbycreator1) | **GET** /api/ai/assistants | 获取用户的AI助手列表
[**listPublic1**](AIApi.md#listpublic1) | **GET** /api/ai/assistants/public | 获取公开的AI助手列表
[**publish**](AIApi.md#publish) | **PUT** /api/ai/assistants/{id}/publish | 发布AI助手
[**regenerateKnowledgePoints**](AIApi.md#regenerateknowledgepoints) | **POST** /api/books/{bookId}/ai/chapters/{chapterId}/knowledge-points/regenerate | 重新提取知识点
[**regenerateSummary**](AIApi.md#regeneratesummary) | **POST** /api/books/{bookId}/ai/chapters/{chapterId}/summary/regenerate | 重新生成总结
[**search1**](AIApi.md#search1) | **GET** /api/ai/assistants/search | 搜索AI助手
[**searchKnowledgePoints**](AIApi.md#searchknowledgepoints) | **GET** /api/books/{bookId}/ai/knowledge-points/search | 搜索知识点
[**streamChat**](AIApi.md#streamchat) | **POST** /api/ai/chat/stream | 流式对话
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

# **streamChat**
> SseEmitter streamChat(chatRequest)

流式对话

使用SSE推送方式进行AI对话

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getAIApi();
final ChatRequest chatRequest = ; // ChatRequest | 

try {
    final response = api.streamChat(chatRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AIApi->streamChat: $e\n');
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

