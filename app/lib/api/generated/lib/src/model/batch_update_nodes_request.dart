//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/add_edge_request.dart';
import 'package:nova_api/src/model/add_node_request.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'batch_update_nodes_request.g.dart';

/// 批量更新节点请求
///
/// Properties:
/// * [nodes] - 要添加或更新的节点列表
/// * [deleteNodeIds] - 要删除的节点ID列表
/// * [edges] - 要添加或更新的连接线列表
/// * [deleteEdgeIds] - 要删除的连接线ID列表
@BuiltValue()
abstract class BatchUpdateNodesRequest
    implements Built<BatchUpdateNodesRequest, BatchUpdateNodesRequestBuilder> {
  /// 要添加或更新的节点列表
  @BuiltValueField(wireName: r'nodes')
  BuiltList<AddNodeRequest> get nodes;

  /// 要删除的节点ID列表
  @BuiltValueField(wireName: r'deleteNodeIds')
  BuiltList<String>? get deleteNodeIds;

  /// 要添加或更新的连接线列表
  @BuiltValueField(wireName: r'edges')
  BuiltList<AddEdgeRequest>? get edges;

  /// 要删除的连接线ID列表
  @BuiltValueField(wireName: r'deleteEdgeIds')
  BuiltList<String>? get deleteEdgeIds;

  BatchUpdateNodesRequest._();

  factory BatchUpdateNodesRequest(
          [void updates(BatchUpdateNodesRequestBuilder b)]) =
      _$BatchUpdateNodesRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BatchUpdateNodesRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BatchUpdateNodesRequest> get serializer =>
      _$BatchUpdateNodesRequestSerializer();
}

class _$BatchUpdateNodesRequestSerializer
    implements PrimitiveSerializer<BatchUpdateNodesRequest> {
  @override
  final Iterable<Type> types = const [
    BatchUpdateNodesRequest,
    _$BatchUpdateNodesRequest
  ];

  @override
  final String wireName = r'BatchUpdateNodesRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BatchUpdateNodesRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'nodes';
    yield serializers.serialize(
      object.nodes,
      specifiedType: const FullType(BuiltList, [FullType(AddNodeRequest)]),
    );
    if (object.deleteNodeIds != null) {
      yield r'deleteNodeIds';
      yield serializers.serialize(
        object.deleteNodeIds,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.edges != null) {
      yield r'edges';
      yield serializers.serialize(
        object.edges,
        specifiedType: const FullType(BuiltList, [FullType(AddEdgeRequest)]),
      );
    }
    if (object.deleteEdgeIds != null) {
      yield r'deleteEdgeIds';
      yield serializers.serialize(
        object.deleteEdgeIds,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BatchUpdateNodesRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BatchUpdateNodesRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'nodes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(AddNodeRequest)]),
          ) as BuiltList<AddNodeRequest>;
          result.nodes.replace(valueDes);
          break;
        case r'deleteNodeIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.deleteNodeIds.replace(valueDes);
          break;
        case r'edges':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(AddEdgeRequest)]),
          ) as BuiltList<AddEdgeRequest>;
          result.edges.replace(valueDes);
          break;
        case r'deleteEdgeIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.deleteEdgeIds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BatchUpdateNodesRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BatchUpdateNodesRequestBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
