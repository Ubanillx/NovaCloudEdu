# WorkflowResponse

工作流响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 工作流ID | [optional] [default to undefined]
**name** | **string** | 工作流名称 | [optional] [default to undefined]
**description** | **string** | 工作流描述 | [optional] [default to undefined]
**definition** | **string** | 工作流定义JSON字符串 | [optional] [default to undefined]
**status** | **string** | 工作流状态 | [optional] [default to undefined]
**version** | **number** | 版本号 | [optional] [default to undefined]
**creatorId** | **number** | 创建者ID | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**updateTime** | **string** | 更新时间 | [optional] [default to undefined]
**_public** | **boolean** |  | [optional] [default to undefined]

## Example

```typescript
import { WorkflowResponse } from './api';

const instance: WorkflowResponse = {
    id,
    name,
    description,
    definition,
    status,
    version,
    creatorId,
    createTime,
    updateTime,
    _public,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
