# WorkflowTriggerResponse

工作流触发器响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 触发器ID | [optional] [default to undefined]
**workflowId** | **number** | 工作流ID | [optional] [default to undefined]
**type** | **string** | 触发器类型：SCHEDULE/WEBHOOK/EVENT | [optional] [default to undefined]
**name** | **string** | 触发器名称 | [optional] [default to undefined]
**enabled** | **boolean** | 是否启用 | [optional] [default to undefined]
**config** | **{ [key: string]: object; }** | 配置JSON | [optional] [default to undefined]
**lastTriggeredAt** | **string** | 最后触发时间 | [optional] [default to undefined]
**triggerCount** | **number** | 触发次数 | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]

## Example

```typescript
import { WorkflowTriggerResponse } from './api';

const instance: WorkflowTriggerResponse = {
    id,
    workflowId,
    type,
    name,
    enabled,
    config,
    lastTriggeredAt,
    triggerCount,
    createTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
