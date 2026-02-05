# UserWordBookResponse

用户生词本响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | ID | [optional] [default to undefined]
**userId** | **number** | 用户ID | [optional] [default to undefined]
**wordId** | **number** | 单词ID | [optional] [default to undefined]
**learningStatus** | **number** | 学习状态 | [optional] [default to undefined]
**learningStatusDesc** | **string** | 学习状态描述 | [optional] [default to undefined]
**collectedTime** | **string** | 收藏时间 | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**updateTime** | **string** | 更新时间 | [optional] [default to undefined]
**word** | [**DailyWordResponse**](DailyWordResponse.md) |  | [optional] [default to undefined]

## Example

```typescript
import { UserWordBookResponse } from './api';

const instance: UserWordBookResponse = {
    id,
    userId,
    wordId,
    learningStatus,
    learningStatusDesc,
    collectedTime,
    createTime,
    updateTime,
    word,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
