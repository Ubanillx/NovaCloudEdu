# UpdatePlanRequest

更新会员计划请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 计划ID | [default to undefined]
**name** | **string** | 计划名称 | [optional] [default to undefined]
**description** | **string** | 计划描述 | [optional] [default to undefined]
**price** | **number** | 价格 | [optional] [default to undefined]
**durationDays** | **number** | 有效期天数 | [optional] [default to undefined]

## Example

```typescript
import { UpdatePlanRequest } from './api';

const instance: UpdatePlanRequest = {
    id,
    name,
    description,
    price,
    durationDays,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
