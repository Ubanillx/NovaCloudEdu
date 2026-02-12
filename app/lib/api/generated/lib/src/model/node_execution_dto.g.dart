// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_execution_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NodeExecutionDTO extends NodeExecutionDTO {
  @override
  final String? nodeId;
  @override
  final String? nodeName;
  @override
  final String? nodeType;
  @override
  final String? status;
  @override
  final BuiltMap<String, JsonObject>? input;
  @override
  final BuiltMap<String, JsonObject>? output;
  @override
  final String? errorMessage;
  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;
  @override
  final int? durationMs;

  factory _$NodeExecutionDTO([
    void Function(NodeExecutionDTOBuilder)? updates,
  ]) => (NodeExecutionDTOBuilder()..update(updates))._build();

  _$NodeExecutionDTO._({
    this.nodeId,
    this.nodeName,
    this.nodeType,
    this.status,
    this.input,
    this.output,
    this.errorMessage,
    this.startTime,
    this.endTime,
    this.durationMs,
  }) : super._();
  @override
  NodeExecutionDTO rebuild(void Function(NodeExecutionDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NodeExecutionDTOBuilder toBuilder() =>
      NodeExecutionDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NodeExecutionDTO &&
        nodeId == other.nodeId &&
        nodeName == other.nodeName &&
        nodeType == other.nodeType &&
        status == other.status &&
        input == other.input &&
        output == other.output &&
        errorMessage == other.errorMessage &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        durationMs == other.durationMs;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, nodeId.hashCode);
    _$hash = $jc(_$hash, nodeName.hashCode);
    _$hash = $jc(_$hash, nodeType.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, input.hashCode);
    _$hash = $jc(_$hash, output.hashCode);
    _$hash = $jc(_$hash, errorMessage.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, durationMs.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NodeExecutionDTO')
          ..add('nodeId', nodeId)
          ..add('nodeName', nodeName)
          ..add('nodeType', nodeType)
          ..add('status', status)
          ..add('input', input)
          ..add('output', output)
          ..add('errorMessage', errorMessage)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('durationMs', durationMs))
        .toString();
  }
}

class NodeExecutionDTOBuilder
    implements Builder<NodeExecutionDTO, NodeExecutionDTOBuilder> {
  _$NodeExecutionDTO? _$v;

  String? _nodeId;
  String? get nodeId => _$this._nodeId;
  set nodeId(String? nodeId) => _$this._nodeId = nodeId;

  String? _nodeName;
  String? get nodeName => _$this._nodeName;
  set nodeName(String? nodeName) => _$this._nodeName = nodeName;

  String? _nodeType;
  String? get nodeType => _$this._nodeType;
  set nodeType(String? nodeType) => _$this._nodeType = nodeType;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  MapBuilder<String, JsonObject>? _input;
  MapBuilder<String, JsonObject> get input =>
      _$this._input ??= MapBuilder<String, JsonObject>();
  set input(MapBuilder<String, JsonObject>? input) => _$this._input = input;

  MapBuilder<String, JsonObject>? _output;
  MapBuilder<String, JsonObject> get output =>
      _$this._output ??= MapBuilder<String, JsonObject>();
  set output(MapBuilder<String, JsonObject>? output) => _$this._output = output;

  String? _errorMessage;
  String? get errorMessage => _$this._errorMessage;
  set errorMessage(String? errorMessage) => _$this._errorMessage = errorMessage;

  DateTime? _startTime;
  DateTime? get startTime => _$this._startTime;
  set startTime(DateTime? startTime) => _$this._startTime = startTime;

  DateTime? _endTime;
  DateTime? get endTime => _$this._endTime;
  set endTime(DateTime? endTime) => _$this._endTime = endTime;

  int? _durationMs;
  int? get durationMs => _$this._durationMs;
  set durationMs(int? durationMs) => _$this._durationMs = durationMs;

  NodeExecutionDTOBuilder() {
    NodeExecutionDTO._defaults(this);
  }

  NodeExecutionDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _nodeId = $v.nodeId;
      _nodeName = $v.nodeName;
      _nodeType = $v.nodeType;
      _status = $v.status;
      _input = $v.input?.toBuilder();
      _output = $v.output?.toBuilder();
      _errorMessage = $v.errorMessage;
      _startTime = $v.startTime;
      _endTime = $v.endTime;
      _durationMs = $v.durationMs;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NodeExecutionDTO other) {
    _$v = other as _$NodeExecutionDTO;
  }

  @override
  void update(void Function(NodeExecutionDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NodeExecutionDTO build() => _build();

  _$NodeExecutionDTO _build() {
    _$NodeExecutionDTO _$result;
    try {
      _$result =
          _$v ??
          _$NodeExecutionDTO._(
            nodeId: nodeId,
            nodeName: nodeName,
            nodeType: nodeType,
            status: status,
            input: _input?.build(),
            output: _output?.build(),
            errorMessage: errorMessage,
            startTime: startTime,
            endTime: endTime,
            durationMs: durationMs,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        _input?.build();
        _$failedField = 'output';
        _output?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'NodeExecutionDTO',
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
