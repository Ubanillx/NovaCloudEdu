# nova_api.model.NodeExecutionDTO

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**nodeId** | **String** | 节点ID | [optional] 
**nodeName** | **String** | 节点名称 | [optional] 
**nodeType** | **String** | 节点类型 | [optional] 
**status** | **String** | 执行状态 | [optional] 
**input** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md) | 节点输入数据 | [optional] 
**output** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md) | 节点输出数据 | [optional] 
**errorMessage** | **String** | 错误信息 | [optional] 
**startTime** | [**DateTime**](DateTime.md) | 开始时间 | [optional] 
**endTime** | [**DateTime**](DateTime.md) | 结束时间 | [optional] 
**durationMs** | **int** | 耗时（毫秒） | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


