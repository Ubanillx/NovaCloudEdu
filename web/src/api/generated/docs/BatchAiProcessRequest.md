# BatchAiProcessRequest

批量 AI 处理文章请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**articleIds** | **Array&lt;number&gt;** | 文章ID列表 | [default to undefined]
**formatContent** | **boolean** | 是否格式化内容为 Markdown | [optional] [default to true]
**generateSummary** | **boolean** | 是否生成摘要 | [optional] [default to true]

## Example

```typescript
import { BatchAiProcessRequest } from './api';

const instance: BatchAiProcessRequest = {
    articleIds,
    formatContent,
    generateSummary,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
