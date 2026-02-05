# FriendRequestResponse

好友申请响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 申请ID | [optional] [default to undefined]
**senderId** | **number** | 发送者ID | [optional] [default to undefined]
**senderName** | **string** | 发送者用户名 | [optional] [default to undefined]
**senderAvatar** | **string** | 发送者头像 | [optional] [default to undefined]
**receiverId** | **number** | 接收者ID | [optional] [default to undefined]
**receiverName** | **string** | 接收者用户名 | [optional] [default to undefined]
**receiverAvatar** | **string** | 接收者头像 | [optional] [default to undefined]
**status** | **string** | 申请状态：pending/accepted/rejected | [optional] [default to undefined]
**message** | **string** | 申请消息 | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]

## Example

```typescript
import { FriendRequestResponse } from './api';

const instance: FriendRequestResponse = {
    id,
    senderId,
    senderName,
    senderAvatar,
    receiverId,
    receiverName,
    receiverAvatar,
    status,
    message,
    createTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
