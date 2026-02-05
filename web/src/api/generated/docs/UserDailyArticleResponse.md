# UserDailyArticleResponse

用户每日文章响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | ID | [optional] [default to undefined]
**userId** | **number** | 用户ID | [optional] [default to undefined]
**articleId** | **number** | 文章ID | [optional] [default to undefined]
**read** | **boolean** | 是否阅读 | [optional] [default to undefined]
**liked** | **boolean** | 是否点赞 | [optional] [default to undefined]
**collected** | **boolean** | 是否收藏 | [optional] [default to undefined]
**commentContent** | **string** | 评论内容 | [optional] [default to undefined]
**commentTime** | **string** | 评论时间 | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**updateTime** | **string** | 更新时间 | [optional] [default to undefined]
**article** | [**DailyArticleResponse**](DailyArticleResponse.md) |  | [optional] [default to undefined]

## Example

```typescript
import { UserDailyArticleResponse } from './api';

const instance: UserDailyArticleResponse = {
    id,
    userId,
    articleId,
    read,
    liked,
    collected,
    commentContent,
    commentTime,
    createTime,
    updateTime,
    article,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
