# ConfigFieldDTO

配置字段定义

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **string** | 字段名 | [optional] [default to undefined]
**label** | **string** | 字段标签 | [optional] [default to undefined]
**fieldType** | **string** | 字段类型 | [optional] [default to undefined]
**required** | **boolean** | 是否必填 | [optional] [default to undefined]
**defaultValue** | **object** | 默认值 | [optional] [default to undefined]
**description** | **string** | 字段描述 | [optional] [default to undefined]
**_options** | [**Array&lt;OptionDTO&gt;**](OptionDTO.md) | 选项列表（select类型时使用） | [optional] [default to undefined]
**validation** | **{ [key: string]: object; }** | 验证规则 | [optional] [default to undefined]

## Example

```typescript
import { ConfigFieldDTO } from './api';

const instance: ConfigFieldDTO = {
    name,
    label,
    fieldType,
    required,
    defaultValue,
    description,
    _options,
    validation,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
