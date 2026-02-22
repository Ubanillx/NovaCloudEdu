# nova_api.model.PptGenerationRequest

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**action** | **String** | 操作类型: detect_intent / generate_outline / revise_outline / confirm_outline / select_template / generate_ppt | 
**sessionId** | **int** | 会话ID（首次操作时为空，后续步骤必填） | [optional] 
**message** | **String** | 用户消息（detect_intent 时使用，AI判断是否要生成PPT） | [optional] 
**topic** | **String** | PPT主题（generate_outline 时使用） | [optional] 
**requirements** | **String** | 额外要求（generate_outline 时可选） | [optional] 
**feedback** | **String** | 修改反馈（revise_outline 时使用） | [optional] 
**templateId** | **int** | 系统模板ID（select_template 时使用） | [optional] 
**templateUrl** | **String** | 自定义模板URL（select_template 时使用，与 templateId 二选一） | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


