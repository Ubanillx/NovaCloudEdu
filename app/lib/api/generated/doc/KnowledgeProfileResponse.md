# nova_api.model.KnowledgeProfileResponse

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**knowledgePoint** | **String** | 知识点名称 | [optional] 
**subject** | **String** | 学科 | [optional] 
**masteryLevel** | **double** | 掌握度 0.0~1.0 | [optional] 
**masteryGrade** | **String** | 掌握度等级: EXCELLENT/GOOD/MEDIUM/WEAK/VERY_WEAK | [optional] 
**totalAttempts** | **int** | 总答题次数 | [optional] 
**correctCount** | **int** | 正确次数 | [optional] 
**correctRate** | **double** | 正确率 | [optional] 
**recentErrorCategories** | **BuiltList&lt;String&gt;** | 近期错误类型 | [optional] 
**weakPoint** | **bool** | 是否薄弱知识点 | [optional] 
**lastUpdated** | [**DateTime**](DateTime.md) | 最近更新时间 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


