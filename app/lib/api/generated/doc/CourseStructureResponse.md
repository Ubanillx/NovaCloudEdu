# nova_api.model.CourseStructureResponse

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**course** | [**CourseResponse**](CourseResponse.md) |  | [optional] 
**chapters** | [**BuiltList&lt;ChapterResponse&gt;**](ChapterResponse.md) | 章节列表（包含小节） | [optional] 
**hasAccess** | **bool** | 当前用户是否有权访问付费内容 | [optional] 
**purchased** | **bool** | 当前用户是否已购买此课程（有有效订单） | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


