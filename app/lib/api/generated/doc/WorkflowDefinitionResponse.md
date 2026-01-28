# nova_api.model.WorkflowDefinitionResponse

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**workflowId** | **int** | 工作流ID | [optional] 
**workflowName** | **String** | 工作流名称 | [optional] 
**version** | **String** | 定义版本 | [optional] 
**nodes** | [**BuiltList&lt;WorkflowNodeResponse&gt;**](WorkflowNodeResponse.md) | 节点列表 | [optional] 
**edges** | [**BuiltList&lt;WorkflowEdgeResponse&gt;**](WorkflowEdgeResponse.md) | 连接线列表 | [optional] 
**variables** | [**BuiltMap&lt;String, WorkflowVariableResponse&gt;**](WorkflowVariableResponse.md) | 变量定义 | [optional] 
**settings** | [**WorkflowSettingsDTO**](WorkflowSettingsDTO.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


