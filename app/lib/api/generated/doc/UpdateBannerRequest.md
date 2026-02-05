# nova_api.model.UpdateBannerRequest

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** | 轮播图ID | 
**title** | **String** | 标题 | 
**imageUrl** | **String** | 图片URL | 
**linkType** | **int** | 跳转类型: 0-无跳转, 1-内部路由, 2-外部链接 | [optional] 
**linkUrl** | **String** | 跳转URL/路由 | [optional] 
**sort** | **int** | 排序权重，值越大越靠前 | [optional] 
**startTime** | [**DateTime**](DateTime.md) | 开始展示时间 | [optional] 
**endTime** | [**DateTime**](DateTime.md) | 结束展示时间 | [optional] 
**status** | **int** | 状态: 0-草稿, 1-已发布, 2-已下线 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


