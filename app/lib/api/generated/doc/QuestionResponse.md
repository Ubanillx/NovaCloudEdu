# nova_api.model.QuestionResponse

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** | 题目ID | [optional] 
**type** | **String** | 题型 | [optional] 
**typeDesc** | **String** | 题型描述 | [optional] 
**subject** | **String** | 学科 | [optional] 
**subjectDesc** | **String** | 学科描述 | [optional] 
**grade** | **String** | 年级 | [optional] 
**difficulty** | **int** | 难度 | [optional] 
**difficultyDesc** | **String** | 难度描述 | [optional] 
**content** | **String** | 题干内容 | [optional] 
**options** | **String** | 选项JSON | [optional] 
**answer** | **String** | 标准答案 | [optional] 
**explanation** | **String** | 解析 | [optional] 
**knowledgeTags** | **BuiltList&lt;String&gt;** | 知识点标签 | [optional] 
**imageUrl** | **String** | 题目图片URL | [optional] 
**source_** | **String** | 来源 | [optional] 
**creatorId** | **int** | 创建者ID | [optional] 
**createTime** | [**DateTime**](DateTime.md) | 创建时间 | [optional] 
**updateTime** | [**DateTime**](DateTime.md) | 更新时间 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


