# TtsResponse

语音合成响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**audioBase64** | **string** | Base64 编码的音频数据 | [optional] [default to undefined]
**format** | **string** | 音频格式 | [optional] [default to undefined]
**size** | **number** | 音频数据大小（字节） | [optional] [default to undefined]
**durationMs** | **number** | 音频时长（毫秒），如果可用 | [optional] [default to undefined]

## Example

```typescript
import { TtsResponse } from './api';

const instance: TtsResponse = {
    audioBase64,
    format,
    size,
    durationMs,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
