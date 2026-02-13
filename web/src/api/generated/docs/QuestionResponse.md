# QuestionResponse

题目响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 题目ID | [optional] [default to undefined]
**type** | **string** | 题型 | [optional] [default to undefined]
**typeDesc** | **string** | 题型描述 | [optional] [default to undefined]
**subject** | **string** | 学科 | [optional] [default to undefined]
**subjectDesc** | **string** | 学科描述 | [optional] [default to undefined]
**grade** | **string** | 年级 | [optional] [default to undefined]
**difficulty** | **number** | 难度 | [optional] [default to undefined]
**difficultyDesc** | **string** | 难度描述 | [optional] [default to undefined]
**content** | **string** | 题干内容 | [optional] [default to undefined]
**_options** | **string** | 选项JSON | [optional] [default to undefined]
**answer** | **string** | 标准答案 | [optional] [default to undefined]
**explanation** | **string** | 解析 | [optional] [default to undefined]
**knowledgeTags** | **Array&lt;string&gt;** | 知识点标签 | [optional] [default to undefined]
**imageUrl** | **string** | 题目图片URL | [optional] [default to undefined]
**source** | **string** | 来源 | [optional] [default to undefined]
**creatorId** | **number** | 创建者ID | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**updateTime** | **string** | 更新时间 | [optional] [default to undefined]

## Example

```typescript
import { QuestionResponse } from './api';

const instance: QuestionResponse = {
    id,
    type,
    typeDesc,
    subject,
    subjectDesc,
    grade,
    difficulty,
    difficultyDesc,
    content,
    _options,
    answer,
    explanation,
    knowledgeTags,
    imageUrl,
    source,
    creatorId,
    createTime,
    updateTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
