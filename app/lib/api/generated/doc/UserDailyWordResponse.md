# nova_api.model.UserDailyWordResponse

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** | ID | [optional] 
**userId** | **int** | 用户ID | [optional] 
**wordId** | **int** | 单词ID | [optional] 
**studied** | **bool** | 是否学习 | [optional] 
**collected** | **bool** | 是否收藏 | [optional] 
**masteryLevel** | **int** | 掌握程度 | [optional] 
**masteryLevelDesc** | **String** | 掌握程度描述 | [optional] 
**createTime** | [**DateTime**](DateTime.md) | 创建时间 | [optional] 
**updateTime** | [**DateTime**](DateTime.md) | 更新时间 | [optional] 
**word** | [**DailyWordResponse**](DailyWordResponse.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


