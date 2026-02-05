# UpdateDailyArticleRequest

更新每日文章请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**title** | **string** | 文章标题 | [default to undefined]
**content** | **string** | 文章内容 | [default to undefined]
**summary** | **string** | 文章摘要 | [optional] [default to undefined]
**coverImage** | **string** | 封面图片URL | [optional] [default to undefined]
**author** | **string** | 作者 | [optional] [default to undefined]
**source** | **string** | 来源 | [optional] [default to undefined]
**sourceUrl** | **string** | 原文链接 | [optional] [default to undefined]
**category** | **string** | 文章分类 | [optional] [default to undefined]
**tags** | **Array&lt;string&gt;** | 标签列表 | [optional] [default to undefined]
**difficulty** | **number** | 难度等级：1-简单，2-中等，3-困难 | [default to undefined]
**readTime** | **number** | 预计阅读时间(分钟) | [optional] [default to undefined]
**publishDate** | **string** | 发布日期 | [default to undefined]

## Example

```typescript
import { UpdateDailyArticleRequest } from './api';

const instance: UpdateDailyArticleRequest = {
    title,
    content,
    summary,
    coverImage,
    author,
    source,
    sourceUrl,
    category,
    tags,
    difficulty,
    readTime,
    publishDate,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
