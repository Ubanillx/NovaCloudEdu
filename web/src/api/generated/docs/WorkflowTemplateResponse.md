# WorkflowTemplateResponse

工作流模板响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 模板ID | [optional] [default to undefined]
**name** | **string** | 模板名称 | [optional] [default to undefined]
**description** | **string** | 模板描述 | [optional] [default to undefined]
**category** | **string** | 分类 | [optional] [default to undefined]
**icon** | **string** | 图标URL | [optional] [default to undefined]
**definition** | **string** | 工作流定义JSON | [optional] [default to undefined]
**tags** | **Array&lt;string&gt;** | 标签 | [optional] [default to undefined]
**creatorId** | **number** | 创建者ID | [optional] [default to undefined]
**usageCount** | **number** | 使用次数 | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**_public** | **boolean** |  | [optional] [default to undefined]
**system** | **boolean** |  | [optional] [default to undefined]

## Example

```typescript
import { WorkflowTemplateResponse } from './api';

const instance: WorkflowTemplateResponse = {
    id,
    name,
    description,
    category,
    icon,
    definition,
    tags,
    creatorId,
    usageCount,
    createTime,
    _public,
    system,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
