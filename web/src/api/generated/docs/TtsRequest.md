# TtsRequest

语音合成请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**text** | **string** | 要合成的文本 | [default to undefined]
**voice** | **string** | 发音人，可选值: xiaoyun, xiaogang, ruoxi 等 | [optional] [default to undefined]
**volume** | **number** | 音量 (0-100) | [optional] [default to undefined]
**speechRate** | **number** | 语速 (-500 到 500) | [optional] [default to undefined]
**pitchRate** | **number** | 语调 (-500 到 500) | [optional] [default to undefined]
**format** | **string** | 音频格式: pcm, wav, mp3 | [optional] [default to 'mp3']

## Example

```typescript
import { TtsRequest } from './api';

const instance: TtsRequest = {
    text,
    voice,
    volume,
    speechRate,
    pitchRate,
    format,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
