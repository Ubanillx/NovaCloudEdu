# CreateDailyWordRequest

创建每日单词请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**word** | **string** | 单词 | [default to undefined]
**pronunciationUs** | **string** | 美式音标 | [optional] [default to undefined]
**pronunciationUk** | **string** | 英式音标 | [optional] [default to undefined]
**audioUrlUs** | **string** | 美式发音音频URL | [optional] [default to undefined]
**audioUrlUk** | **string** | 英式发音音频URL | [optional] [default to undefined]
**translation** | **string** | 翻译 | [default to undefined]
**example** | **string** | 例句 | [optional] [default to undefined]
**exampleTranslation** | **string** | 例句翻译 | [optional] [default to undefined]
**difficulty** | **number** | 难度等级：1-简单，2-中等，3-困难 | [default to undefined]
**category** | **string** | 单词分类 | [optional] [default to undefined]
**notes** | **string** | 单词笔记 | [optional] [default to undefined]
**publishDate** | **string** | 发布日期 | [default to undefined]

## Example

```typescript
import { CreateDailyWordRequest } from './api';

const instance: CreateDailyWordRequest = {
    word,
    pronunciationUs,
    pronunciationUk,
    audioUrlUs,
    audioUrlUk,
    translation,
    example,
    exampleTranslation,
    difficulty,
    category,
    notes,
    publishDate,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
