# ExamTemplateResponse

试卷模板响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 模板ID | [optional] [default to undefined]
**name** | **string** | 模板名称 | [optional] [default to undefined]
**description** | **string** | 模板描述 | [optional] [default to undefined]
**templateUrl** | **string** | 模板文件URL | [optional] [default to undefined]
**coverUrl** | **string** | 预览封面URL | [optional] [default to undefined]
**isSystem** | **boolean** | 是否系统内置 | [optional] [default to undefined]
**isEnabled** | **boolean** | 是否启用 | [optional] [default to undefined]
**creatorId** | **number** | 创建者ID | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**updateTime** | **string** | 更新时间 | [optional] [default to undefined]

## Example

```typescript
import { ExamTemplateResponse } from './api';

const instance: ExamTemplateResponse = {
    id,
    name,
    description,
    templateUrl,
    coverUrl,
    isSystem,
    isEnabled,
    creatorId,
    createTime,
    updateTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
