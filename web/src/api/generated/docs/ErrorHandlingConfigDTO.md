# ErrorHandlingConfigDTO

错误处理配置

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**onError** | **string** | 错误处理策略 | [optional] [default to undefined]
**retryCount** | **number** | 重试次数 | [optional] [default to undefined]
**retryDelayMs** | **number** | 重试延迟（毫秒） | [optional] [default to undefined]
**fallbackNodeId** | **string** | 回退节点ID | [optional] [default to undefined]
**timeoutMs** | **number** | 超时时间（毫秒） | [optional] [default to undefined]

## Example

```typescript
import { ErrorHandlingConfigDTO } from './api';

const instance: ErrorHandlingConfigDTO = {
    onError,
    retryCount,
    retryDelayMs,
    fallbackNodeId,
    timeoutMs,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
