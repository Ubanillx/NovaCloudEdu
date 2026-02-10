# WorkflowVersionResponse

工作流版本历史响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 版本记录ID | [optional] [default to undefined]
**workflowId** | **number** | 工作流ID | [optional] [default to undefined]
**version** | **number** | 版本号 | [optional] [default to undefined]
**name** | **string** | 名称快照 | [optional] [default to undefined]
**description** | **string** | 描述快照 | [optional] [default to undefined]
**definition** | **string** | 工作流定义快照JSON | [optional] [default to undefined]
**publishNote** | **string** | 发布说明 | [optional] [default to undefined]
**publishedBy** | **number** | 发布者ID | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]

## Example

```typescript
import { WorkflowVersionResponse } from './api';

const instance: WorkflowVersionResponse = {
    id,
    workflowId,
    version,
    name,
    description,
    definition,
    publishNote,
    publishedBy,
    createTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
