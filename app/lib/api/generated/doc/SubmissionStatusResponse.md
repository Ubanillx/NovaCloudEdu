# nova_api.model.SubmissionStatusResponse

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**submissionId** | **String** | 提交ID | [optional] 
**gradingMode** | **String** | 批改模式: EXAM_PAPER/GENERAL | [optional] 
**title** | **String** | 作业标题 | [optional] 
**subject** | **String** | 学科（可能为null，通用模式下AI推断后回填） | [optional] 
**grade** | **String** | 年级 | [optional] 
**imageUrls** | **BuiltList&lt;String&gt;** | 作业图片URL列表 | [optional] 
**status** | **String** | 批改状态: PENDING/OCR_PROCESSING/GRADING/COMPLETED/FAILED | [optional] 
**examPaperId** | **String** | 关联试卷ID | [optional] 
**totalScore** | **int** | 总得分（已完成时有值） | [optional] 
**maxScore** | **int** | 满分（已完成时有值） | [optional] 
**createTime** | [**DateTime**](DateTime.md) | 提交时间 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


