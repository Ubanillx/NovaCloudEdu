# ArticleChatRequest

文章对话请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**articleId** | **number** | 文章ID | [default to undefined]
**message** | **string** | 用户消息 | [default to undefined]
**history** | **Array&lt;{ [key: string]: string; }&gt;** | 对话历史 | [optional] [default to undefined]

## Example

```typescript
import { ArticleChatRequest } from './api';

const instance: ArticleChatRequest = {
    articleId,
    message,
    history,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
