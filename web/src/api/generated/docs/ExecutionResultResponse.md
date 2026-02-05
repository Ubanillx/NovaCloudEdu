# ExecutionResultResponse

工作流执行结果响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**executionId** | **string** | 执行ID | [optional] [default to undefined]
**workflowId** | **number** | 工作流ID | [optional] [default to undefined]
**workflowName** | **string** | 工作流名称 | [optional] [default to undefined]
**status** | **string** | 执行状态 | [optional] [default to undefined]
**input** | **{ [key: string]: object; }** | 输入参数 | [optional] [default to undefined]
**output** | **{ [key: string]: object; }** | 输出结果 | [optional] [default to undefined]
**variables** | **{ [key: string]: object; }** | 执行过程中的变量 | [optional] [default to undefined]
**currentNodeId** | **string** | 当前执行节点ID | [optional] [default to undefined]
**errorMessage** | **string** | 错误信息 | [optional] [default to undefined]
**startTime** | **string** | 开始时间 | [optional] [default to undefined]
**endTime** | **string** | 结束时间 | [optional] [default to undefined]
**durationMs** | **number** | 执行耗时（毫秒） | [optional] [default to undefined]

## Example

```typescript
import { ExecutionResultResponse } from './api';

const instance: ExecutionResultResponse = {
    executionId,
    workflowId,
    workflowName,
    status,
    input,
    output,
    variables,
    currentNodeId,
    errorMessage,
    startTime,
    endTime,
    durationMs,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
