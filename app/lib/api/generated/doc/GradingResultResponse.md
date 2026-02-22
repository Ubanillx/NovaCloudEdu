# nova_api.model.GradingResultResponse

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**submissionId** | **String** | 提交ID | [optional] 
**totalScore** | **int** | 总得分 | [optional] 
**maxScore** | **int** | 满分 | [optional] 
**overallComment** | **String** | 总评语 | [optional] 
**modelId** | **String** | 使用的AI模型 | [optional] 
**gradingTime** | [**DateTime**](DateTime.md) | 批改完成时间 | [optional] 
**questions** | [**BuiltList&lt;QuestionGradingItem&gt;**](QuestionGradingItem.md) | 逐题批改详情 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


