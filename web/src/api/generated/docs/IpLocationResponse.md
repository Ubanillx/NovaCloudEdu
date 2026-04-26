# IpLocationResponse

IP 归属地响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**ip** | **string** | IP 地址 | [optional] [default to undefined]
**success** | **boolean** | 是否查询成功 | [optional] [default to undefined]
**display** | **string** | 展示用归属地文本 | [optional] [default to undefined]
**country** | **string** | 国家/地区 | [optional] [default to undefined]
**province** | **string** | 省/州 | [optional] [default to undefined]
**city** | **string** | 城市 | [optional] [default to undefined]
**message** | **string** | 错误原因或状态说明 | [optional] [default to undefined]

## Example

```typescript
import { IpLocationResponse } from './api';

const instance: IpLocationResponse = {
    ip,
    success,
    display,
    country,
    province,
    city,
    message,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
