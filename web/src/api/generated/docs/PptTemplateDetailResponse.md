# PptTemplateDetailResponse

PPT模板详情

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 模板ID | [optional] [default to undefined]
**name** | **string** | 模板名称 | [optional] [default to undefined]
**description** | **string** | 模板描述 | [optional] [default to undefined]
**coverUrl** | **string** | 封面图URL | [optional] [default to undefined]
**templateUrl** | **string** | 模板文件URL | [optional] [default to undefined]
**slideCount** | **number** | 页数 | [optional] [default to undefined]
**structureJson** | **string** | 模板结构JSON（含每页槽位信息） | [optional] [default to undefined]
**enabled** | **boolean** | 是否启用 | [optional] [default to undefined]

## Example

```typescript
import { PptTemplateDetailResponse } from './api';

const instance: PptTemplateDetailResponse = {
    id,
    name,
    description,
    coverUrl,
    templateUrl,
    slideCount,
    structureJson,
    enabled,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
