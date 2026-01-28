# nova_api.model.CreateCourseRequest

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**title** | **String** | 课程标题 | 
**courseType** | **int** | 课程类型：0-公开课，1-付费课，2-会员课 | 
**difficulty** | **int** | 难度等级：1-入门，2-初级，3-中级，4-高级，5-专家 | 
**teacherId** | **int** | 讲师ID | 
**subtitle** | **String** | 课程副标题 | [optional] 
**description** | **String** | 课程描述 | [optional] 
**coverImage** | **String** | 封面图片URL | [optional] 
**price** | **num** | 课程价格 | [optional] 
**tags** | **BuiltList&lt;String&gt;** | 标签列表 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


