# nova_api.model.FriendRequestResponse

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** | 申请ID | [optional] 
**senderId** | **int** | 发送者ID | [optional] 
**senderName** | **String** | 发送者用户名 | [optional] 
**senderAvatar** | **String** | 发送者头像 | [optional] 
**receiverId** | **int** | 接收者ID | [optional] 
**receiverName** | **String** | 接收者用户名 | [optional] 
**receiverAvatar** | **String** | 接收者头像 | [optional] 
**status** | **String** | 申请状态：pending/accepted/rejected | [optional] 
**message** | **String** | 申请消息 | [optional] 
**createTime** | [**DateTime**](DateTime.md) | 创建时间 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


