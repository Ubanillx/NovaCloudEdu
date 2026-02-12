# PptGenerationRequest

PPT生成助手请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**action** | **string** | 操作类型: detect_intent / generate_outline / revise_outline / confirm_outline / select_template / generate_ppt | [default to undefined]
**sessionId** | **number** | 会话ID（首次操作时为空，后续步骤必填） | [optional] [default to undefined]
**message** | **string** | 用户消息（detect_intent 时使用，AI判断是否要生成PPT） | [optional] [default to undefined]
**topic** | **string** | PPT主题（generate_outline 时使用） | [optional] [default to undefined]
**requirements** | **string** | 额外要求（generate_outline 时可选） | [optional] [default to undefined]
**feedback** | **string** | 修改反馈（revise_outline 时使用） | [optional] [default to undefined]
**templateId** | **number** | 系统模板ID（select_template 时使用） | [optional] [default to undefined]
**templateUrl** | **string** | 自定义模板URL（select_template 时使用，与 templateId 二选一） | [optional] [default to undefined]

## Example

```typescript
import { PptGenerationRequest } from './api';

const instance: PptGenerationRequest = {
    action,
    sessionId,
    message,
    topic,
    requirements,
    feedback,
    templateId,
    templateUrl,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
