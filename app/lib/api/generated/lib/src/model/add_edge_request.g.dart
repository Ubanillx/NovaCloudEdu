// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_edge_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AddEdgeRequest extends AddEdgeRequest {
  @override
  final String edgeId;
  @override
  final String sourceNodeId;
  @override
  final String targetNodeId;
  @override
  final String? sourceHandle;
  @override
  final String? targetHandle;
  @override
  final String? condition;
  @override
  final String? label;

  factory _$AddEdgeRequest([void Function(AddEdgeRequestBuilder)? updates]) =>
      (AddEdgeRequestBuilder()..update(updates))._build();

  _$AddEdgeRequest._({
    required this.edgeId,
    required this.sourceNodeId,
    required this.targetNodeId,
    this.sourceHandle,
    this.targetHandle,
    this.condition,
    this.label,
  }) : super._();
  @override
  AddEdgeRequest rebuild(void Function(AddEdgeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddEdgeRequestBuilder toBuilder() => AddEdgeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddEdgeRequest &&
        edgeId == other.edgeId &&
        sourceNodeId == other.sourceNodeId &&
        targetNodeId == other.targetNodeId &&
        sourceHandle == other.sourceHandle &&
        targetHandle == other.targetHandle &&
        condition == other.condition &&
        label == other.label;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, edgeId.hashCode);
    _$hash = $jc(_$hash, sourceNodeId.hashCode);
    _$hash = $jc(_$hash, targetNodeId.hashCode);
    _$hash = $jc(_$hash, sourceHandle.hashCode);
    _$hash = $jc(_$hash, targetHandle.hashCode);
    _$hash = $jc(_$hash, condition.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AddEdgeRequest')
          ..add('edgeId', edgeId)
          ..add('sourceNodeId', sourceNodeId)
          ..add('targetNodeId', targetNodeId)
          ..add('sourceHandle', sourceHandle)
          ..add('targetHandle', targetHandle)
          ..add('condition', condition)
          ..add('label', label))
        .toString();
  }
}

class AddEdgeRequestBuilder
    implements Builder<AddEdgeRequest, AddEdgeRequestBuilder> {
  _$AddEdgeRequest? _$v;

  String? _edgeId;
  String? get edgeId => _$this._edgeId;
  set edgeId(String? edgeId) => _$this._edgeId = edgeId;

  String? _sourceNodeId;
  String? get sourceNodeId => _$this._sourceNodeId;
  set sourceNodeId(String? sourceNodeId) => _$this._sourceNodeId = sourceNodeId;

  String? _targetNodeId;
  String? get targetNodeId => _$this._targetNodeId;
  set targetNodeId(String? targetNodeId) => _$this._targetNodeId = targetNodeId;

  String? _sourceHandle;
  String? get sourceHandle => _$this._sourceHandle;
  set sourceHandle(String? sourceHandle) => _$this._sourceHandle = sourceHandle;

  String? _targetHandle;
  String? get targetHandle => _$this._targetHandle;
  set targetHandle(String? targetHandle) => _$this._targetHandle = targetHandle;

  String? _condition;
  String? get condition => _$this._condition;
  set condition(String? condition) => _$this._condition = condition;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  AddEdgeRequestBuilder() {
    AddEdgeRequest._defaults(this);
  }

  AddEdgeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _edgeId = $v.edgeId;
      _sourceNodeId = $v.sourceNodeId;
      _targetNodeId = $v.targetNodeId;
      _sourceHandle = $v.sourceHandle;
      _targetHandle = $v.targetHandle;
      _condition = $v.condition;
      _label = $v.label;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddEdgeRequest other) {
    _$v = other as _$AddEdgeRequest;
  }

  @override
  void update(void Function(AddEdgeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddEdgeRequest build() => _build();

  _$AddEdgeRequest _build() {
    final _$result =
        _$v ??
        _$AddEdgeRequest._(
          edgeId: BuiltValueNullFieldError.checkNotNull(
            edgeId,
            r'AddEdgeRequest',
            'edgeId',
          ),
          sourceNodeId: BuiltValueNullFieldError.checkNotNull(
            sourceNodeId,
            r'AddEdgeRequest',
            'sourceNodeId',
          ),
          targetNodeId: BuiltValueNullFieldError.checkNotNull(
            targetNodeId,
            r'AddEdgeRequest',
            'targetNodeId',
          ),
          sourceHandle: sourceHandle,
          targetHandle: targetHandle,
          condition: condition,
          label: label,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
