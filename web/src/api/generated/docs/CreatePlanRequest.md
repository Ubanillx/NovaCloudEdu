# CreatePlanRequest

创建会员计划请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **string** | 计划名称 | [default to undefined]
**code** | **string** | 计划编码：FREE/BASIC/PRO/TEACHER | [default to undefined]
**description** | **string** | 计划描述 | [optional] [default to undefined]
**price** | **number** | 价格 | [default to undefined]
**durationDays** | **number** | 有效期天数，0表示永久 | [optional] [default to undefined]

## Example

```typescript
import { CreatePlanRequest } from './api';

const instance: CreatePlanRequest = {
    name,
    code,
    description,
    price,
    durationDays,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
