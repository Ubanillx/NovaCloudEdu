# ExecutionLogResponse

工作流执行日志响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**executionId** | **string** | 执行ID | [optional] [default to undefined]
**nodeId** | **string** | 节点ID | [optional] [default to undefined]
**nodeName** | **string** | 节点名称 | [optional] [default to undefined]
**nodeType** | **string** | 节点类型 | [optional] [default to undefined]
**level** | **string** | 日志级别 | [optional] [default to undefined]
**message** | **string** | 日志消息 | [optional] [default to undefined]
**durationMs** | **number** | 节点执行耗时（毫秒） | [optional] [default to undefined]
**timestamp** | **string** | 日志时间戳 | [optional] [default to undefined]

## Example

```typescript
import { ExecutionLogResponse } from './api';

const instance: ExecutionLogResponse = {
    executionId,
    nodeId,
    nodeName,
    nodeType,
    level,
    message,
    durationMs,
    timestamp,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
