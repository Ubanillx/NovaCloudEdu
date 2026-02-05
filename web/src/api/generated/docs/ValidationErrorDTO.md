# ValidationErrorDTO

验证错误

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**code** | **string** | 错误代码 | [optional] [default to undefined]
**message** | **string** | 错误消息 | [optional] [default to undefined]
**nodeId** | **string** | 相关节点ID | [optional] [default to undefined]
**edgeId** | **string** | 相关连接线ID | [optional] [default to undefined]

## Example

```typescript
import { ValidationErrorDTO } from './api';

const instance: ValidationErrorDTO = {
    code,
    message,
    nodeId,
    edgeId,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
