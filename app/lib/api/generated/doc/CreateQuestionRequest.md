# nova_api.model.CreateQuestionRequest

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | **String** | 题型: SINGLE_CHOICE/MULTI_CHOICE/FILL_BLANK/TRUE_FALSE/SHORT_ANSWER/CALCULATION/ESSAY | 
**subject** | **String** | 学科: MATH/CHINESE/ENGLISH/PHYSICS/CHEMISTRY/BIOLOGY/HISTORY/GEOGRAPHY/POLITICS | 
**difficulty** | **int** | 难度: 1-5 | 
**content** | **String** | 题干内容(支持KaTeX公式) | 
**answer** | **String** | 标准答案 | 
**grade** | **String** | 年级 | [optional] 
**options** | **String** | 选项JSON字符串 | [optional] 
**explanation** | **String** | 解析 | [optional] 
**knowledgeTags** | **BuiltList&lt;String&gt;** | 知识点标签 | [optional] 
**imageUrl** | **String** | 题目图片URL | [optional] 
**source_** | **String** | 来源: MANUAL/AI/IMPORT | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


