# BatchUpdateNodesRequest

批量更新节点请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**nodes** | [**Array&lt;AddNodeRequest&gt;**](AddNodeRequest.md) | 要添加或更新的节点列表 | [default to undefined]
**deleteNodeIds** | **Array&lt;string&gt;** | 要删除的节点ID列表 | [optional] [default to undefined]
**edges** | [**Array&lt;AddEdgeRequest&gt;**](AddEdgeRequest.md) | 要添加或更新的连接线列表 | [optional] [default to undefined]
**deleteEdgeIds** | **Array&lt;string&gt;** | 要删除的连接线ID列表 | [optional] [default to undefined]

## Example

```typescript
import { BatchUpdateNodesRequest } from './api';

const instance: BatchUpdateNodesRequest = {
    nodes,
    deleteNodeIds,
    edges,
    deleteEdgeIds,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
