# AddNodeRequest

添加工作流节点请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**nodeId** | **string** | 节点唯一标识 | [default to undefined]
**type** | **string** | 节点类型 | [default to undefined]
**name** | **string** | 节点名称 | [default to undefined]
**positionX** | **number** | 节点位置X坐标 | [optional] [default to undefined]
**positionY** | **number** | 节点位置Y坐标 | [optional] [default to undefined]
**config** | **{ [key: string]: object; }** | 节点配置参数 | [optional] [default to undefined]
**errorHandling** | [**ErrorHandlingConfigDTO**](ErrorHandlingConfigDTO.md) |  | [optional] [default to undefined]

## Example

```typescript
import { AddNodeRequest } from './api';

const instance: AddNodeRequest = {
    nodeId,
    type,
    name,
    positionX,
    positionY,
    config,
    errorHandling,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
