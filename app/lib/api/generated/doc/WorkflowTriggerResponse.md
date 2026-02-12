# nova_api.model.WorkflowTriggerResponse

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** | 触发器ID | [optional] 
**workflowId** | **int** | 工作流ID | [optional] 
**type** | **String** | 触发器类型：SCHEDULE/WEBHOOK/EVENT | [optional] 
**name** | **String** | 触发器名称 | [optional] 
**enabled** | **bool** | 是否启用 | [optional] 
**config** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md) | 配置JSON | [optional] 
**lastTriggeredAt** | [**DateTime**](DateTime.md) | 最后触发时间 | [optional] 
**triggerCount** | **int** | 触发次数 | [optional] 
**createTime** | [**DateTime**](DateTime.md) | 创建时间 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


