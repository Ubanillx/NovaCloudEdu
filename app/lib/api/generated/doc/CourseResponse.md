# nova_api.model.CourseResponse

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** | 课程ID | [optional] 
**title** | **String** | 课程标题 | [optional] 
**subtitle** | **String** | 课程副标题 | [optional] 
**description** | **String** | 课程描述 | [optional] 
**coverImage** | **String** | 封面图片URL | [optional] 
**price** | **num** | 课程价格 | [optional] 
**courseType** | **int** | 课程类型：0-公开课，1-付费课，2-会员课 | [optional] 
**courseTypeDesc** | **String** | 课程类型描述 | [optional] 
**difficulty** | **int** | 难度等级：1-入门，2-初级，3-中级，4-高级，5-专家 | [optional] 
**difficultyDesc** | **String** | 难度等级描述 | [optional] 
**status** | **int** | 状态：0-未发布，1-已发布，2-已下架 | [optional] 
**statusDesc** | **String** | 状态描述 | [optional] 
**teacherId** | **int** | 讲师ID | [optional] 
**totalDuration** | **int** | 总时长(分钟) | [optional] 
**totalChapters** | **int** | 总章节数 | [optional] 
**totalSections** | **int** | 总小节数 | [optional] 
**studentCount** | **int** | 学习人数 | [optional] 
**ratingScore** | **num** | 评分 | [optional] 
**tags** | **BuiltList&lt;String&gt;** | 标签列表 | [optional] 
**createTime** | [**DateTime**](DateTime.md) | 创建时间 | [optional] 
**updateTime** | [**DateTime**](DateTime.md) | 更新时间 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


