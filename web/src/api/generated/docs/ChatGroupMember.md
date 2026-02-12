# ChatGroupMember


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** |  | [optional] [default to undefined]
**groupId** | [**GroupId**](GroupId.md) |  | [optional] [default to undefined]
**memberType** | **string** |  | [optional] [default to undefined]
**userId** | [**UserId**](UserId.md) |  | [optional] [default to undefined]
**aiRoleId** | **number** |  | [optional] [default to undefined]
**role** | **string** |  | [optional] [default to undefined]
**nickname** | **string** |  | [optional] [default to undefined]
**muteUntil** | **string** |  | [optional] [default to undefined]
**joinTime** | **string** |  | [optional] [default to undefined]
**updateTime** | **string** |  | [optional] [default to undefined]
**mute** | **boolean** |  | [optional] [default to undefined]
**owner** | **boolean** |  | [optional] [default to undefined]
**_delete** | **boolean** |  | [optional] [default to undefined]
**muted** | **boolean** |  | [optional] [default to undefined]
**adminOrOwner** | **boolean** |  | [optional] [default to undefined]

## Example

```typescript
import { ChatGroupMember } from './api';

const instance: ChatGroupMember = {
    id,
    groupId,
    memberType,
    userId,
    aiRoleId,
    role,
    nickname,
    muteUntil,
    joinTime,
    updateTime,
    mute,
    owner,
    _delete,
    muted,
    adminOrOwner,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
