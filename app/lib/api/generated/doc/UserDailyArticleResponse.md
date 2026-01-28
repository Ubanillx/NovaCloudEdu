# nova_api.model.UserDailyArticleResponse

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** | ID | [optional] 
**userId** | **int** | 用户ID | [optional] 
**articleId** | **int** | 文章ID | [optional] 
**read** | **bool** | 是否阅读 | [optional] 
**liked** | **bool** | 是否点赞 | [optional] 
**collected** | **bool** | 是否收藏 | [optional] 
**commentContent** | **String** | 评论内容 | [optional] 
**commentTime** | [**DateTime**](DateTime.md) | 评论时间 | [optional] 
**createTime** | [**DateTime**](DateTime.md) | 创建时间 | [optional] 
**updateTime** | [**DateTime**](DateTime.md) | 更新时间 | [optional] 
**article** | [**DailyArticleResponse**](DailyArticleResponse.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


