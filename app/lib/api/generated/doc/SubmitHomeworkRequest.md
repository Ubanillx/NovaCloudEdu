# nova_api.model.SubmitHomeworkRequest

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**imageUrls** | **BuiltList&lt;String&gt;** | 作业图片 OSS URL 列表 | 
**gradingMode** | **String** | 批改模式: EXAM_PAPER(试卷批改) / GENERAL(通用作业助手)，默认 GENERAL | [optional] 
**title** | **String** | 作业标题（通用模式可自定义，如'人教版三年级数学第五章练习'） | [optional] 
**subject** | **String** | 学科: MATH/CHINESE/ENGLISH/...（可选，通用模式AI自动推断） | [optional] 
**grade** | **String** | 年级 | [optional] 
**classId** | **int** | 班级ID（可选） | [optional] 
**examPaperId** | **int** | 关联试卷ID（试卷批改模式时传入） | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


