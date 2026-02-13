# AiGenerateQuestionsRequest

AI 生成题目请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**subject** | **string** | 学科: MATH/CHINESE/ENGLISH/PHYSICS/CHEMISTRY/BIOLOGY/HISTORY/GEOGRAPHY/POLITICS | [default to undefined]
**type** | **string** | 题型: SINGLE_CHOICE/MULTI_CHOICE/FILL_BLANK/TRUE_FALSE/SHORT_ANSWER/CALCULATION/ESSAY | [default to undefined]
**difficulty** | **number** | 难度: 1-5 | [default to undefined]
**grade** | **string** | 年级 | [optional] [default to undefined]
**count** | **number** | 生成数量 | [default to undefined]
**topic** | **string** | 知识点/主题描述 | [optional] [default to undefined]
**withDiagram** | **boolean** | 是否生成几何图形（Typst cetz 渲染） | [optional] [default to undefined]
**withImage** | **boolean** | 是否生成配图（文生图） | [optional] [default to undefined]
**enableWebSearch** | **boolean** | 是否启用联网搜索热点出题 | [optional] [default to undefined]
**modelId** | **string** | AI 模型ID（可选，如 dashscope/qwen-max） | [optional] [default to undefined]
**userInput** | **string** | 用户自定义补充要求（如出题风格、特殊限制、场景描述等） | [optional] [default to undefined]

## Example

```typescript
import { AiGenerateQuestionsRequest } from './api';

const instance: AiGenerateQuestionsRequest = {
    subject,
    type,
    difficulty,
    grade,
    count,
    topic,
    withDiagram,
    withImage,
    enableWebSearch,
    modelId,
    userInput,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
