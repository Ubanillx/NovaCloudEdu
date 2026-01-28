// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_edge_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateEdgeRequest extends UpdateEdgeRequest {
  @override
  final String? sourceNodeId;
  @override
  final String? targetNodeId;
  @override
  final String? sourceHandle;
  @override
  final String? targetHandle;
  @override
  final String? condition;
  @override
  final String? label;

  factory _$UpdateEdgeRequest([
    void Function(UpdateEdgeRequestBuilder)? updates,
  ]) => (UpdateEdgeRequestBuilder()..update(updates))._build();

  _$UpdateEdgeRequest._({
    this.sourceNodeId,
    this.targetNodeId,
    this.sourceHandle,
    this.targetHandle,
    this.condition,
    this.label,
  }) : super._();
  @override
  UpdateEdgeRequest rebuild(void Function(UpdateEdgeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateEdgeRequestBuilder toBuilder() =>
      UpdateEdgeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateEdgeRequest &&
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
    return (newBuiltValueToStringHelper(r'UpdateEdgeRequest')
          ..add('sourceNodeId', sourceNodeId)
          ..add('targetNodeId', targetNodeId)
          ..add('sourceHandle', sourceHandle)
          ..add('targetHandle', targetHandle)
          ..add('condition', condition)
          ..add('label', label))
        .toString();
  }
}

class UpdateEdgeRequestBuilder
    implements Builder<UpdateEdgeRequest, UpdateEdgeRequestBuilder> {
  _$UpdateEdgeRequest? _$v;

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

  UpdateEdgeRequestBuilder() {
    UpdateEdgeRequest._defaults(this);
  }

  UpdateEdgeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
  void replace(UpdateEdgeRequest other) {
    _$v = other as _$UpdateEdgeRequest;
  }

  @override
  void update(void Function(UpdateEdgeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateEdgeRequest build() => _build();

  _$UpdateEdgeRequest _build() {
    final _$result =
        _$v ??
        _$UpdateEdgeRequest._(
          sourceNodeId: sourceNodeId,
          targetNodeId: targetNodeId,
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
