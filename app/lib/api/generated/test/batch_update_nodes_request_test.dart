import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

// tests for BatchUpdateNodesRequest
void main() {
  final instance = BatchUpdateNodesRequestBuilder();
  // TODO add properties to the builder and call build()

  group(BatchUpdateNodesRequest, () {
    // 要添加或更新的节点列表
    // BuiltList<AddNodeRequest> nodes
    test('to test the property `nodes`', () async {
      // TODO
    });

    // 要删除的节点ID列表
    // BuiltList<String> deleteNodeIds
    test('to test the property `deleteNodeIds`', () async {
      // TODO
    });

    // 要添加或更新的连接线列表
    // BuiltList<AddEdgeRequest> edges
    test('to test the property `edges`', () async {
      // TODO
    });

    // 要删除的连接线ID列表
    // BuiltList<String> deleteEdgeIds
    test('to test the property `deleteEdgeIds`', () async {
      // TODO
    });
  });
}
