# DailyWordResponse

每日单词响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | ID | [optional] [default to undefined]
**word** | **string** | 单词 | [optional] [default to undefined]
**pronunciationUs** | **string** | 美式音标 | [optional] [default to undefined]
**pronunciationUk** | **string** | 英式音标 | [optional] [default to undefined]
**audioUrlUs** | **string** | 美式发音音频URL | [optional] [default to undefined]
**audioUrlUk** | **string** | 英式发音音频URL | [optional] [default to undefined]
**translation** | **string** | 翻译 | [optional] [default to undefined]
**example** | **string** | 例句 | [optional] [default to undefined]
**exampleTranslation** | **string** | 例句翻译 | [optional] [default to undefined]
**difficulty** | **number** | 难度等级 | [optional] [default to undefined]
**difficultyDesc** | **string** | 难度描述 | [optional] [default to undefined]
**category** | **string** | 单词分类 | [optional] [default to undefined]
**notes** | **string** | 单词笔记 | [optional] [default to undefined]
**publishDate** | **string** | 发布日期 | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**updateTime** | **string** | 更新时间 | [optional] [default to undefined]

## Example

```typescript
import { DailyWordResponse } from './api';

const instance: DailyWordResponse = {
    id,
    word,
    pronunciationUs,
    pronunciationUk,
    audioUrlUs,
    audioUrlUk,
    translation,
    example,
    exampleTranslation,
    difficulty,
    difficultyDesc,
    category,
    notes,
    publishDate,
    createTime,
    updateTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
