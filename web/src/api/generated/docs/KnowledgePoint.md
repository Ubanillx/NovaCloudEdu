# KnowledgePoint


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | [**KnowledgePointId**](KnowledgePointId.md) |  | [optional] [default to undefined]
**chapterId** | [**ChapterId**](ChapterId.md) |  | [optional] [default to undefined]
**pointType** | **string** |  | [optional] [default to undefined]
**name** | **string** |  | [optional] [default to undefined]
**description** | **string** |  | [optional] [default to undefined]
**position** | **number** |  | [optional] [default to undefined]
**relatedChapterIds** | **Array&lt;number&gt;** |  | [optional] [default to undefined]
**relatedPointIds** | **Array&lt;number&gt;** |  | [optional] [default to undefined]
**createTime** | **string** |  | [optional] [default to undefined]

## Example

```typescript
import { KnowledgePoint } from './api';

const instance: KnowledgePoint = {
    id,
    chapterId,
    pointType,
    name,
    description,
    position,
    relatedChapterIds,
    relatedPointIds,
    createTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
