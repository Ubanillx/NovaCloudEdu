# nova_api.model.TtsRequest

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**text** | **String** | 要合成的文本 | 
**voice** | **String** | 发音人，可选值: xiaoyun, xiaogang, ruoxi 等 | [optional] 
**volume** | **int** | 音量 (0-100) | [optional] 
**speechRate** | **int** | 语速 (-500 到 500) | [optional] 
**pitchRate** | **int** | 语调 (-500 到 500) | [optional] 
**format** | **String** | 音频格式: pcm, wav, mp3 | [optional] [default to 'mp3']

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


