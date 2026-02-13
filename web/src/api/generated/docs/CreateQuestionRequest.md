# CreateQuestionRequest

创建题目请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | **string** | 题型: SINGLE_CHOICE/MULTI_CHOICE/FILL_BLANK/TRUE_FALSE/SHORT_ANSWER/CALCULATION/ESSAY | [default to undefined]
**subject** | **string** | 学科: MATH/CHINESE/ENGLISH/PHYSICS/CHEMISTRY/BIOLOGY/HISTORY/GEOGRAPHY/POLITICS | [default to undefined]
**grade** | **string** | 年级 | [optional] [default to undefined]
**difficulty** | **number** | 难度: 1-5 | [default to undefined]
**content** | **string** | 题干内容(支持KaTeX公式) | [default to undefined]
**_options** | **string** | 选项JSON字符串 | [optional] [default to undefined]
**answer** | **string** | 标准答案 | [default to undefined]
**explanation** | **string** | 解析 | [optional] [default to undefined]
**knowledgeTags** | **Array&lt;string&gt;** | 知识点标签 | [optional] [default to undefined]
**imageUrl** | **string** | 题目图片URL | [optional] [default to undefined]
**source** | **string** | 来源: MANUAL/AI/IMPORT | [optional] [default to undefined]

## Example

```typescript
import { CreateQuestionRequest } from './api';

const instance: CreateQuestionRequest = {
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
    source,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
