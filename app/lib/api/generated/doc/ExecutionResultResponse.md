# nova_api.model.ExecutionResultResponse

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**executionId** | **String** | 执行ID | [optional] 
**workflowId** | **int** | 工作流ID | [optional] 
**workflowName** | **String** | 工作流名称 | [optional] 
**workflowVersion** | **int** | 工作流版本 | [optional] 
**status** | **String** | 执行状态 | [optional] 
**input** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md) | 输入参数 | [optional] 
**output** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md) | 输出结果 | [optional] 
**variables** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md) | 执行过程中的变量 | [optional] 
**currentNodeId** | **String** | 当前执行节点ID | [optional] 
**errorMessage** | **String** | 错误信息 | [optional] 
**startTime** | [**DateTime**](DateTime.md) | 开始时间 | [optional] 
**endTime** | [**DateTime**](DateTime.md) | 结束时间 | [optional] 
**durationMs** | **int** | 执行耗时（毫秒） | [optional] 
**nodeExecutions** | [**BuiltList&lt;NodeExecutionDTO&gt;**](NodeExecutionDTO.md) | 各节点执行详情（调试数据） | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


