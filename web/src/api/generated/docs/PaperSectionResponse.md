# PaperSectionResponse

试卷大题响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 大题ID | [optional] [default to undefined]
**paperId** | **number** | 试卷ID | [optional] [default to undefined]
**title** | **string** | 标题 | [optional] [default to undefined]
**description** | **string** | 描述 | [optional] [default to undefined]
**questionType** | **string** | 题型 | [optional] [default to undefined]
**questionTypeDesc** | **string** | 题型描述 | [optional] [default to undefined]
**sortOrder** | **number** | 排序 | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**updateTime** | **string** | 更新时间 | [optional] [default to undefined]

## Example

```typescript
import { PaperSectionResponse } from './api';

const instance: PaperSectionResponse = {
    id,
    paperId,
    title,
    description,
    questionType,
    questionTypeDesc,
    sortOrder,
    createTime,
    updateTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
