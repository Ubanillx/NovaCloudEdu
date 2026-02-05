# UserDailyWordResponse

用户每日单词响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | ID | [optional] [default to undefined]
**userId** | **number** | 用户ID | [optional] [default to undefined]
**wordId** | **number** | 单词ID | [optional] [default to undefined]
**studied** | **boolean** | 是否学习 | [optional] [default to undefined]
**collected** | **boolean** | 是否收藏 | [optional] [default to undefined]
**masteryLevel** | **number** | 掌握程度 | [optional] [default to undefined]
**masteryLevelDesc** | **string** | 掌握程度描述 | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**updateTime** | **string** | 更新时间 | [optional] [default to undefined]
**word** | [**DailyWordResponse**](DailyWordResponse.md) |  | [optional] [default to undefined]

## Example

```typescript
import { UserDailyWordResponse } from './api';

const instance: UserDailyWordResponse = {
    id,
    userId,
    wordId,
    studied,
    collected,
    masteryLevel,
    masteryLevelDesc,
    createTime,
    updateTime,
    word,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
