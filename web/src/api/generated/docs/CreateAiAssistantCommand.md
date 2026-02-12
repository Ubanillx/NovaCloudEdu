# CreateAiAssistantCommand


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **string** |  | [default to undefined]
**description** | **string** |  | [optional] [default to undefined]
**avatarUrl** | **string** |  | [optional] [default to undefined]
**tags** | **Array&lt;string&gt;** |  | [optional] [default to undefined]
**category** | **string** |  | [optional] [default to undefined]
**systemPrompt** | **string** |  | [optional] [default to undefined]
**openingMessage** | **string** |  | [optional] [default to undefined]
**suggestedQuestions** | **Array&lt;string&gt;** |  | [optional] [default to undefined]
**modelName** | **string** |  | [optional] [default to undefined]
**temperature** | **number** |  | [optional] [default to undefined]
**topP** | **number** |  | [optional] [default to undefined]
**maxTokens** | **number** |  | [optional] [default to undefined]
**knowledgeBaseIds** | **Array&lt;number&gt;** |  | [optional] [default to undefined]
**mcpServerIds** | **Array&lt;number&gt;** |  | [optional] [default to undefined]

## Example

```typescript
import { CreateAiAssistantCommand } from './api';

const instance: CreateAiAssistantCommand = {
    name,
    description,
    avatarUrl,
    tags,
    category,
    systemPrompt,
    openingMessage,
    suggestedQuestions,
    modelName,
    temperature,
    topP,
    maxTokens,
    knowledgeBaseIds,
    mcpServerIds,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
