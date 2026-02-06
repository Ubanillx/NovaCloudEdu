# AiProcessArticleRequest

AI 处理文章请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**articleId** | **number** | 文章ID | [default to undefined]
**formatContent** | **boolean** | 是否格式化内容为 Markdown | [optional] [default to true]
**generateSummary** | **boolean** | 是否生成摘要 | [optional] [default to true]
**summaryMaxLength** | **number** | 摘要最大长度 | [optional] [default to 150]

## Example

```typescript
import { AiProcessArticleRequest } from './api';

const instance: AiProcessArticleRequest = {
    articleId,
    formatContent,
    generateSummary,
    summaryMaxLength,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
