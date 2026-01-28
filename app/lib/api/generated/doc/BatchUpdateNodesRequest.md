# nova_api.model.BatchUpdateNodesRequest

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**nodes** | [**BuiltList&lt;AddNodeRequest&gt;**](AddNodeRequest.md) | 要添加或更新的节点列表 | 
**deleteNodeIds** | **BuiltList&lt;String&gt;** | 要删除的节点ID列表 | [optional] 
**edges** | [**BuiltList&lt;AddEdgeRequest&gt;**](AddEdgeRequest.md) | 要添加或更新的连接线列表 | [optional] 
**deleteEdgeIds** | **BuiltList&lt;String&gt;** | 要删除的连接线ID列表 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


