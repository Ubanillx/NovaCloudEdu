# UpdateWorkflowSettingsRequest

更新工作流设置请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**maxExecutionTimeMs** | **number** | 最大执行时间（毫秒） | [optional] [default to undefined]
**enableLogging** | **boolean** | 是否启用日志 | [optional] [default to undefined]
**logLevel** | **string** | 日志级别 | [optional] [default to undefined]
**enableDebug** | **boolean** | 是否启用调试模式 | [optional] [default to undefined]

## Example

```typescript
import { UpdateWorkflowSettingsRequest } from './api';

const instance: UpdateWorkflowSettingsRequest = {
    maxExecutionTimeMs,
    enableLogging,
    logLevel,
    enableDebug,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
