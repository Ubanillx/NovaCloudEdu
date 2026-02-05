# AiConversation


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | [**AiConversationId**](AiConversationId.md) |  | [optional] [default to undefined]
**userId** | [**UserId**](UserId.md) |  | [optional] [default to undefined]
**bookId** | [**BookId**](BookId.md) |  | [optional] [default to undefined]
**chapterId** | [**ChapterId**](ChapterId.md) |  | [optional] [default to undefined]
**conversationType** | **string** |  | [optional] [default to undefined]
**messages** | [**Array&lt;ConversationMessage&gt;**](ConversationMessage.md) |  | [optional] [default to undefined]
**createTime** | **string** |  | [optional] [default to undefined]
**updateTime** | **string** |  | [optional] [default to undefined]
**messageCount** | **number** |  | [optional] [default to undefined]

## Example

```typescript
import { AiConversation } from './api';

const instance: AiConversation = {
    id,
    userId,
    bookId,
    chapterId,
    conversationType,
    messages,
    createTime,
    updateTime,
    messageCount,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
