// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_update_nodes_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BatchUpdateNodesRequest extends BatchUpdateNodesRequest {
  @override
  final BuiltList<AddNodeRequest> nodes;
  @override
  final BuiltList<String>? deleteNodeIds;
  @override
  final BuiltList<AddEdgeRequest>? edges;
  @override
  final BuiltList<String>? deleteEdgeIds;

  factory _$BatchUpdateNodesRequest([
    void Function(BatchUpdateNodesRequestBuilder)? updates,
  ]) => (BatchUpdateNodesRequestBuilder()..update(updates))._build();

  _$BatchUpdateNodesRequest._({
    required this.nodes,
    this.deleteNodeIds,
    this.edges,
    this.deleteEdgeIds,
  }) : super._();
  @override
  BatchUpdateNodesRequest rebuild(
    void Function(BatchUpdateNodesRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BatchUpdateNodesRequestBuilder toBuilder() =>
      BatchUpdateNodesRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BatchUpdateNodesRequest &&
        nodes == other.nodes &&
        deleteNodeIds == other.deleteNodeIds &&
        edges == other.edges &&
        deleteEdgeIds == other.deleteEdgeIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, nodes.hashCode);
    _$hash = $jc(_$hash, deleteNodeIds.hashCode);
    _$hash = $jc(_$hash, edges.hashCode);
    _$hash = $jc(_$hash, deleteEdgeIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BatchUpdateNodesRequest')
          ..add('nodes', nodes)
          ..add('deleteNodeIds', deleteNodeIds)
          ..add('edges', edges)
          ..add('deleteEdgeIds', deleteEdgeIds))
        .toString();
  }
}

class BatchUpdateNodesRequestBuilder
    implements
        Builder<BatchUpdateNodesRequest, BatchUpdateNodesRequestBuilder> {
  _$BatchUpdateNodesRequest? _$v;

  ListBuilder<AddNodeRequest>? _nodes;
  ListBuilder<AddNodeRequest> get nodes =>
      _$this._nodes ??= ListBuilder<AddNodeRequest>();
  set nodes(ListBuilder<AddNodeRequest>? nodes) => _$this._nodes = nodes;

  ListBuilder<String>? _deleteNodeIds;
  ListBuilder<String> get deleteNodeIds =>
      _$this._deleteNodeIds ??= ListBuilder<String>();
  set deleteNodeIds(ListBuilder<String>? deleteNodeIds) =>
      _$this._deleteNodeIds = deleteNodeIds;

  ListBuilder<AddEdgeRequest>? _edges;
  ListBuilder<AddEdgeRequest> get edges =>
      _$this._edges ??= ListBuilder<AddEdgeRequest>();
  set edges(ListBuilder<AddEdgeRequest>? edges) => _$this._edges = edges;

  ListBuilder<String>? _deleteEdgeIds;
  ListBuilder<String> get deleteEdgeIds =>
      _$this._deleteEdgeIds ??= ListBuilder<String>();
  set deleteEdgeIds(ListBuilder<String>? deleteEdgeIds) =>
      _$this._deleteEdgeIds = deleteEdgeIds;

  BatchUpdateNodesRequestBuilder() {
    BatchUpdateNodesRequest._defaults(this);
  }

  BatchUpdateNodesRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _nodes = $v.nodes.toBuilder();
      _deleteNodeIds = $v.deleteNodeIds?.toBuilder();
      _edges = $v.edges?.toBuilder();
      _deleteEdgeIds = $v.deleteEdgeIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BatchUpdateNodesRequest other) {
    _$v = other as _$BatchUpdateNodesRequest;
  }

  @override
  void update(void Function(BatchUpdateNodesRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BatchUpdateNodesRequest build() => _build();

  _$BatchUpdateNodesRequest _build() {
    _$BatchUpdateNodesRequest _$result;
    try {
      _$result =
          _$v ??
          _$BatchUpdateNodesRequest._(
            nodes: nodes.build(),
            deleteNodeIds: _deleteNodeIds?.build(),
            edges: _edges?.build(),
            deleteEdgeIds: _deleteEdgeIds?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'nodes';
        nodes.build();
        _$failedField = 'deleteNodeIds';
        _deleteNodeIds?.build();
        _$failedField = 'edges';
        _edges?.build();
        _$failedField = 'deleteEdgeIds';
        _deleteEdgeIds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'BatchUpdateNodesRequest',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
