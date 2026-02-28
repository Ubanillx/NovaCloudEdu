# CreateKnowledgeBaseCommand


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **string** |  | [default to undefined]
**description** | **string** |  | [optional] [default to undefined]
**embeddingModel** | **string** |  | [optional] [default to undefined]
**embeddingDimension** | **number** |  | [optional] [default to undefined]
**chunkSize** | **number** |  | [optional] [default to undefined]
**chunkOverlap** | **number** |  | [optional] [default to undefined]
**chunkStrategy** | **string** |  | [optional] [default to undefined]
**parentChildMode** | **boolean** |  | [optional] [default to undefined]
**parentChunkSize** | **number** |  | [optional] [default to undefined]
**preserveMetadata** | **boolean** |  | [optional] [default to undefined]
**semanticThreshold** | **number** |  | [optional] [default to undefined]
**retrievalMode** | **string** |  | [optional] [default to undefined]
**enableQueryRewrite** | **boolean** |  | [optional] [default to undefined]
**useDynamicTopK** | **boolean** |  | [optional] [default to undefined]
**defaultTopK** | **number** |  | [optional] [default to undefined]
**queryRewriteModelId** | **string** |  | [optional] [default to undefined]

## Example

```typescript
import { CreateKnowledgeBaseCommand } from './api';

const instance: CreateKnowledgeBaseCommand = {
    name,
    description,
    embeddingModel,
    embeddingDimension,
    chunkSize,
    chunkOverlap,
    chunkStrategy,
    parentChildMode,
    parentChunkSize,
    preserveMetadata,
    semanticThreshold,
    retrievalMode,
    enableQueryRewrite,
    useDynamicTopK,
    defaultTopK,
    queryRewriteModelId,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
