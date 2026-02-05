# SearchUserRequestDTO

搜索用户请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**keyword** | **string** | 搜索关键词（用户名或账号） | [optional] [default to undefined]
**pageNum** | **number** | 页码 | [optional] [default to 1]
**pageSize** | **number** | 每页数量 | [optional] [default to 10]

## Example

```typescript
import { SearchUserRequestDTO } from './api';

const instance: SearchUserRequestDTO = {
    keyword,
    pageNum,
    pageSize,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
