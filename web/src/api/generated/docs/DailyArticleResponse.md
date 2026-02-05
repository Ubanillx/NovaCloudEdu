# DailyArticleResponse

每日文章响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | ID | [optional] [default to undefined]
**title** | **string** | 文章标题 | [optional] [default to undefined]
**content** | **string** | 文章内容 | [optional] [default to undefined]
**summary** | **string** | 文章摘要 | [optional] [default to undefined]
**coverImage** | **string** | 封面图片URL | [optional] [default to undefined]
**author** | **string** | 作者 | [optional] [default to undefined]
**source** | **string** | 来源 | [optional] [default to undefined]
**sourceUrl** | **string** | 原文链接 | [optional] [default to undefined]
**category** | **string** | 文章分类 | [optional] [default to undefined]
**tags** | **Array&lt;string&gt;** | 标签列表 | [optional] [default to undefined]
**difficulty** | **number** | 难度等级 | [optional] [default to undefined]
**difficultyDesc** | **string** | 难度描述 | [optional] [default to undefined]
**readTime** | **number** | 预计阅读时间(分钟) | [optional] [default to undefined]
**publishDate** | **string** | 发布日期 | [optional] [default to undefined]
**viewCount** | **number** | 查看次数 | [optional] [default to undefined]
**likeCount** | **number** | 点赞次数 | [optional] [default to undefined]
**collectCount** | **number** | 收藏次数 | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**updateTime** | **string** | 更新时间 | [optional] [default to undefined]

## Example

```typescript
import { DailyArticleResponse } from './api';

const instance: DailyArticleResponse = {
    id,
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
    difficultyDesc,
    readTime,
    publishDate,
    viewCount,
    likeCount,
    collectCount,
    createTime,
    updateTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
