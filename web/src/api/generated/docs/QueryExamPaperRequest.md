# QueryExamPaperRequest

查询试卷请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**keyword** | **string** | 关键词 | [optional] [default to undefined]
**subject** | **string** | 学科 | [optional] [default to undefined]
**grade** | **string** | 年级 | [optional] [default to undefined]
**status** | **string** | 状态: DRAFT/PUBLISHED | [optional] [default to undefined]
**pageNum** | **number** | 页码 | [optional] [default to 1]
**pageSize** | **number** | 每页数量 | [optional] [default to 20]

## Example

```typescript
import { QueryExamPaperRequest } from './api';

const instance: QueryExamPaperRequest = {
    keyword,
    subject,
    grade,
    status,
    pageNum,
    pageSize,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
