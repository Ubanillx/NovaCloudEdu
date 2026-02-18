# UpdatePlanQuotaRequest

修改计划AI配额请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**aiChatDailyLimit** | **number** | AI对话每日限额，-1表示无限制 | [optional] [default to undefined]
**aiChatMonthlyLimit** | **number** | AI对话每月限额，-1表示无限制 | [optional] [default to undefined]
**aiPptDailyLimit** | **number** | PPT生成每日限额，-1表示无限制 | [optional] [default to undefined]
**aiPptMonthlyLimit** | **number** | PPT生成每月限额，-1表示无限制 | [optional] [default to undefined]
**aiExamDailyLimit** | **number** | AI出题每日限额，-1表示无限制 | [optional] [default to undefined]
**aiExamMonthlyLimit** | **number** | AI出题每月限额，-1表示无限制 | [optional] [default to undefined]
**aiBookDailyLimit** | **number** | 电子书AI每日限额，-1表示无限制 | [optional] [default to undefined]
**aiBookMonthlyLimit** | **number** | 电子书AI每月限额，-1表示无限制 | [optional] [default to undefined]
**aiGradingDailyLimit** | **number** | 智能批改每日限额，-1表示无限制 | [optional] [default to undefined]
**aiGradingMonthlyLimit** | **number** | 智能批改每月限额，-1表示无限制 | [optional] [default to undefined]

## Example

```typescript
import { UpdatePlanQuotaRequest } from './api';

const instance: UpdatePlanQuotaRequest = {
    aiChatDailyLimit,
    aiChatMonthlyLimit,
    aiPptDailyLimit,
    aiPptMonthlyLimit,
    aiExamDailyLimit,
    aiExamMonthlyLimit,
    aiBookDailyLimit,
    aiBookMonthlyLimit,
    aiGradingDailyLimit,
    aiGradingMonthlyLimit,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
