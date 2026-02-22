# nova_api.api.PPTApi

## Load the API package
```dart
import 'package:nova_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteSession**](PPTApi.md#deletesession) | **DELETE** /api/ppt/generation/sessions/{sessionId} | 删除PPT会话
[**deleteTemplate1**](PPTApi.md#deletetemplate1) | **DELETE** /api/ppt/templates/{id} | 删除模板
[**generatePpt**](PPTApi.md#generateppt) | **POST** /api/ppt/generate | 基于模板生成PPT
[**getSessionDetail**](PPTApi.md#getsessiondetail) | **GET** /api/ppt/generation/sessions/{sessionId} | 获取PPT会话详情
[**getTemplateDetail**](PPTApi.md#gettemplatedetail) | **GET** /api/ppt/templates/{id} | 查看模板详情
[**listSessions1**](PPTApi.md#listsessions1) | **GET** /api/ppt/generation/sessions | 获取PPT会话列表
[**listTemplates**](PPTApi.md#listtemplates) | **GET** /api/ppt/templates | 列出所有可用模板
[**stream**](PPTApi.md#stream) | **POST** /api/ppt/generation/stream | PPT生成助手（SSE流式）
[**uploadTemplate**](PPTApi.md#uploadtemplate) | **POST** /api/ppt/templates | 上传PPT模板


# **deleteSession**
> BaseResponseVoid deleteSession(sessionId)

删除PPT会话

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getPPTApi();
final int sessionId = 789; // int | 会话ID

try {
    final response = api.deleteSession(sessionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PPTApi->deleteSession: $e\n');
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

# **deleteTemplate1**
> BaseResponseVoid deleteTemplate1(id)

删除模板

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getPPTApi();
final int id = 789; // int | 模板ID

try {
    final response = api.deleteTemplate1(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PPTApi->deleteTemplate1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 模板ID | 

### Return type

[**BaseResponseVoid**](BaseResponseVoid.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **generatePpt**
> BaseResponsePptGenerateResponse generatePpt(generatePptRequest)

基于模板生成PPT

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getPPTApi();
final GeneratePptRequest generatePptRequest = ; // GeneratePptRequest | 

try {
    final response = api.generatePpt(generatePptRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PPTApi->generatePpt: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **generatePptRequest** | [**GeneratePptRequest**](GeneratePptRequest.md)|  | 

### Return type

[**BaseResponsePptGenerateResponse**](BaseResponsePptGenerateResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSessionDetail**
> BaseResponseMapStringObject getSessionDetail(sessionId)

获取PPT会话详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getPPTApi();
final int sessionId = 789; // int | 会话ID

try {
    final response = api.getSessionDetail(sessionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PPTApi->getSessionDetail: $e\n');
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

# **getTemplateDetail**
> BaseResponsePptTemplateDetailResponse getTemplateDetail(id)

查看模板详情

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getPPTApi();
final int id = 789; // int | 模板ID

try {
    final response = api.getTemplateDetail(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PPTApi->getTemplateDetail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| 模板ID | 

### Return type

[**BaseResponsePptTemplateDetailResponse**](BaseResponsePptTemplateDetailResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listSessions1**
> BaseResponseListMapStringObject listSessions1()

获取PPT会话列表

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getPPTApi();

try {
    final response = api.listSessions1();
    print(response);
} catch on DioException (e) {
    print('Exception when calling PPTApi->listSessions1: $e\n');
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

# **listTemplates**
> BaseResponseListPptTemplateListResponse listTemplates()

列出所有可用模板

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getPPTApi();

try {
    final response = api.listTemplates();
    print(response);
} catch on DioException (e) {
    print('Exception when calling PPTApi->listTemplates: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseListPptTemplateListResponse**](BaseResponseListPptTemplateListResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **stream**
> SseEmitter stream(pptGenerationRequest)

PPT生成助手（SSE流式）

多步骤PPT生成流程，通过 action 字段控制： 0. detect_intent - AI判断用户是否要生成PPT，提取主题 1. generate_outline - 输入主题，AI生成Markdown大纲 2. revise_outline - 不满意可修改大纲 3. confirm_outline - 确认大纲 4. select_template - 选择模板（系统模板ID 或 自定义URL） 5. generate_ppt - AI逐页生成内容并生成最终PPT文件  SSE事件：status / message / intent / outline / template_parsed / slide_progress / result / error / done 

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getPPTApi();
final PptGenerationRequest pptGenerationRequest = ; // PptGenerationRequest | 

try {
    final response = api.stream(pptGenerationRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PPTApi->stream: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pptGenerationRequest** | [**PptGenerationRequest**](PptGenerationRequest.md)|  | 

### Return type

[**SseEmitter**](SseEmitter.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, text/event-stream

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadTemplate**
> BaseResponseLong uploadTemplate(name, description, uploadTemplateRequest)

上传PPT模板

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getPPTApi();
final String name = name_example; // String | 模板名称
final String description = description_example; // String | 模板描述
final UploadTemplateRequest uploadTemplateRequest = ; // UploadTemplateRequest | 

try {
    final response = api.uploadTemplate(name, description, uploadTemplateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PPTApi->uploadTemplate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**| 模板名称 | 
 **description** | **String**| 模板描述 | [optional] 
 **uploadTemplateRequest** | [**UploadTemplateRequest**](UploadTemplateRequest.md)|  | [optional] 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

