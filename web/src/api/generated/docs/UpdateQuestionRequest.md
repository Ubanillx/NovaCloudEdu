# UpdateQuestionRequest

更新题目请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 题目ID | [default to undefined]
**type** | **string** | 题型 | [default to undefined]
**subject** | **string** | 学科 | [default to undefined]
**grade** | **string** | 年级 | [optional] [default to undefined]
**difficulty** | **number** | 难度: 1-5 | [default to undefined]
**content** | **string** | 题干内容 | [default to undefined]
**_options** | **string** | 选项JSON字符串 | [optional] [default to undefined]
**answer** | **string** | 标准答案 | [default to undefined]
**explanation** | **string** | 解析 | [optional] [default to undefined]
**knowledgeTags** | **Array&lt;string&gt;** | 知识点标签 | [optional] [default to undefined]
**imageUrl** | **string** | 题目图片URL | [optional] [default to undefined]

## Example

```typescript
import { UpdateQuestionRequest } from './api';

const instance: UpdateQuestionRequest = {
    id,
    type,
    subject,
    grade,
    difficulty,
    content,
    _options,
    answer,
    explanation,
    knowledgeTags,
    imageUrl,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
