# nova_api.model.SubjectProfileSummary

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**subject** | **String** | 学科 | [optional] 
**subjectName** | **String** | 学科名称 | [optional] 
**avgMasteryLevel** | **double** | 平均掌握度 | [optional] 
**totalPoints** | **int** | 总知识点数 | [optional] 
**weakPointCount** | **int** | 薄弱知识点数 | [optional] 
**strongPointCount** | **int** | 优势知识点数（掌握度>=0.8） | [optional] 
**weakPoints** | [**BuiltList&lt;KnowledgeProfileResponse&gt;**](KnowledgeProfileResponse.md) | 薄弱知识点列表 | [optional] 
**strongPoints** | [**BuiltList&lt;KnowledgeProfileResponse&gt;**](KnowledgeProfileResponse.md) | 优势知识点列表 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


