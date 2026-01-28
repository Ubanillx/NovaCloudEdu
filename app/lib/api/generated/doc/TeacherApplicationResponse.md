# nova_api.model.TeacherApplicationResponse

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** | 申请ID | [optional] 
**userId** | **int** | 用户ID | [optional] 
**name** | **String** | 讲师姓名 | [optional] 
**introduction** | **String** | 讲师简介 | [optional] 
**expertise** | **BuiltList&lt;String&gt;** | 专业领域 | [optional] 
**certificateUrl** | **String** | 资质证书URL | [optional] 
**status** | **int** | 状态：0-待审核，1-已通过，2-已拒绝 | [optional] 
**statusDesc** | **String** | 状态描述 | [optional] 
**rejectReason** | **String** | 拒绝原因 | [optional] 
**reviewerId** | **int** | 审核人ID | [optional] 
**reviewTime** | [**DateTime**](DateTime.md) | 审核时间 | [optional] 
**createTime** | [**DateTime**](DateTime.md) | 创建时间 | [optional] 
**updateTime** | [**DateTime**](DateTime.md) | 更新时间 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


