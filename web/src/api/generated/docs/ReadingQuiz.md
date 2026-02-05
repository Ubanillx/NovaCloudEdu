# ReadingQuiz


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | [**ReadingQuizId**](ReadingQuizId.md) |  | [optional] [default to undefined]
**chapterId** | [**ChapterId**](ChapterId.md) |  | [optional] [default to undefined]
**questions** | [**Array&lt;QuizQuestion&gt;**](QuizQuestion.md) |  | [optional] [default to undefined]
**aiModel** | **string** |  | [optional] [default to undefined]
**createTime** | **string** |  | [optional] [default to undefined]
**questionCount** | **number** |  | [optional] [default to undefined]

## Example

```typescript
import { ReadingQuiz } from './api';

const instance: ReadingQuiz = {
    id,
    chapterId,
    questions,
    aiModel,
    createTime,
    questionCount,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
