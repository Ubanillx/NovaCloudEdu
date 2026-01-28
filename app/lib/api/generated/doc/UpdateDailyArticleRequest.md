# nova_api.model.UpdateDailyArticleRequest

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**title** | **String** | 文章标题 | 
**content** | **String** | 文章内容 | 
**difficulty** | **int** | 难度等级：1-简单，2-中等，3-困难 | 
**publishDate** | [**Date**](Date.md) | 发布日期 | 
**summary** | **String** | 文章摘要 | [optional] 
**coverImage** | **String** | 封面图片URL | [optional] 
**author** | **String** | 作者 | [optional] 
**source_** | **String** | 来源 | [optional] 
**sourceUrl** | **String** | 原文链接 | [optional] 
**category** | **String** | 文章分类 | [optional] 
**tags** | **BuiltList&lt;String&gt;** | 标签列表 | [optional] 
**readTime** | **int** | 预计阅读时间(分钟) | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


