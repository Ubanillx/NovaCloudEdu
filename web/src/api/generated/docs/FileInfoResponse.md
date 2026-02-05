# FileInfoResponse

文件信息响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 文件ID | [optional] [default to undefined]
**fileName** | **string** | 文件名 | [optional] [default to undefined]
**originalName** | **string** | 原始文件名 | [optional] [default to undefined]
**fileUrl** | **string** | 文件URL | [optional] [default to undefined]
**fileSize** | **number** | 文件大小（字节） | [optional] [default to undefined]
**contentType** | **string** | 文件类型 | [optional] [default to undefined]
**businessType** | **string** | 业务类型 | [optional] [default to undefined]
**businessTypeDesc** | **string** | 业务类型描述 | [optional] [default to undefined]
**uploaderId** | **number** | 上传者ID | [optional] [default to undefined]
**createTime** | **string** | 上传时间 | [optional] [default to undefined]

## Example

```typescript
import { FileInfoResponse } from './api';

const instance: FileInfoResponse = {
    id,
    fileName,
    originalName,
    fileUrl,
    fileSize,
    contentType,
    businessType,
    businessTypeDesc,
    uploaderId,
    createTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
