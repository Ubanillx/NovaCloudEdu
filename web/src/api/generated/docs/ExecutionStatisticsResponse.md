# ExecutionStatisticsResponse

工作流执行统计响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**totalCount** | **number** | 总执行次数 | [optional] [default to undefined]
**successCount** | **number** | 成功次数 | [optional] [default to undefined]
**failedCount** | **number** | 失败次数 | [optional] [default to undefined]
**cancelledCount** | **number** | 取消次数 | [optional] [default to undefined]
**avgDurationMs** | **number** | 平均耗时（毫秒） | [optional] [default to undefined]
**successRate** | **number** | 成功率（0~1） | [optional] [default to undefined]

## Example

```typescript
import { ExecutionStatisticsResponse } from './api';

const instance: ExecutionStatisticsResponse = {
    totalCount,
    successCount,
    failedCount,
    cancelledCount,
    avgDurationMs,
    successRate,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
