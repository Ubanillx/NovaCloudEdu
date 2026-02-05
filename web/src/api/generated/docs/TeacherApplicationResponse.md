# TeacherApplicationResponse

讲师申请响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 申请ID | [optional] [default to undefined]
**userId** | **number** | 用户ID | [optional] [default to undefined]
**name** | **string** | 讲师姓名 | [optional] [default to undefined]
**introduction** | **string** | 讲师简介 | [optional] [default to undefined]
**expertise** | **Array&lt;string&gt;** | 专业领域 | [optional] [default to undefined]
**certificateUrl** | **string** | 资质证书URL | [optional] [default to undefined]
**status** | **number** | 状态：0-待审核，1-已通过，2-已拒绝 | [optional] [default to undefined]
**statusDesc** | **string** | 状态描述 | [optional] [default to undefined]
**rejectReason** | **string** | 拒绝原因 | [optional] [default to undefined]
**reviewerId** | **number** | 审核人ID | [optional] [default to undefined]
**reviewTime** | **string** | 审核时间 | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**updateTime** | **string** | 更新时间 | [optional] [default to undefined]

## Example

```typescript
import { TeacherApplicationResponse } from './api';

const instance: TeacherApplicationResponse = {
    id,
    userId,
    name,
    introduction,
    expertise,
    certificateUrl,
    status,
    statusDesc,
    rejectReason,
    reviewerId,
    reviewTime,
    createTime,
    updateTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
