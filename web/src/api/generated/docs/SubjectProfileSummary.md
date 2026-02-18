# SubjectProfileSummary

学科知识画像汇总

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**subject** | **string** | 学科 | [optional] [default to undefined]
**subjectName** | **string** | 学科名称 | [optional] [default to undefined]
**avgMasteryLevel** | **number** | 平均掌握度 | [optional] [default to undefined]
**totalPoints** | **number** | 总知识点数 | [optional] [default to undefined]
**weakPointCount** | **number** | 薄弱知识点数 | [optional] [default to undefined]
**strongPointCount** | **number** | 优势知识点数（掌握度&gt;&#x3D;0.8） | [optional] [default to undefined]
**weakPoints** | [**Array&lt;KnowledgeProfileResponse&gt;**](KnowledgeProfileResponse.md) | 薄弱知识点列表 | [optional] [default to undefined]
**strongPoints** | [**Array&lt;KnowledgeProfileResponse&gt;**](KnowledgeProfileResponse.md) | 优势知识点列表 | [optional] [default to undefined]

## Example

```typescript
import { SubjectProfileSummary } from './api';

const instance: SubjectProfileSummary = {
    subject,
    subjectName,
    avgMasteryLevel,
    totalPoints,
    weakPointCount,
    strongPointCount,
    weakPoints,
    strongPoints,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
