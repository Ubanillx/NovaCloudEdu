# GeneratePptRequest

生成PPT请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**templateId** | **number** | 模板ID | [optional] [default to undefined]
**title** | **string** | PPT标题 | [optional] [default to undefined]
**author** | **string** | 作者 | [optional] [default to undefined]
**slides** | **Array&lt;{ [key: string]: object; }&gt;** | 每页幻灯片的克隆来源和填充内容 | [optional] [default to undefined]

## Example

```typescript
import { GeneratePptRequest } from './api';

const instance: GeneratePptRequest = {
    templateId,
    title,
    author,
    slides,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
