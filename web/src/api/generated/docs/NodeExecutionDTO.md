# NodeExecutionDTO

节点执行详情

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**nodeId** | **string** | 节点ID | [optional] [default to undefined]
**nodeName** | **string** | 节点名称 | [optional] [default to undefined]
**nodeType** | **string** | 节点类型 | [optional] [default to undefined]
**status** | **string** | 执行状态 | [optional] [default to undefined]
**input** | **{ [key: string]: object; }** | 节点输入数据 | [optional] [default to undefined]
**output** | **{ [key: string]: object; }** | 节点输出数据 | [optional] [default to undefined]
**errorMessage** | **string** | 错误信息 | [optional] [default to undefined]
**startTime** | **string** | 开始时间 | [optional] [default to undefined]
**endTime** | **string** | 结束时间 | [optional] [default to undefined]
**durationMs** | **number** | 耗时（毫秒） | [optional] [default to undefined]

## Example

```typescript
import { NodeExecutionDTO } from './api';

const instance: NodeExecutionDTO = {
    nodeId,
    nodeName,
    nodeType,
    status,
    input,
    output,
    errorMessage,
    startTime,
    endTime,
    durationMs,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
