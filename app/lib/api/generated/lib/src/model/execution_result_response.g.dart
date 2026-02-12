// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'execution_result_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ExecutionResultResponseStatusEnum
_$executionResultResponseStatusEnum_PENDING =
    const ExecutionResultResponseStatusEnum._('PENDING');
const ExecutionResultResponseStatusEnum
_$executionResultResponseStatusEnum_RUNNING =
    const ExecutionResultResponseStatusEnum._('RUNNING');
const ExecutionResultResponseStatusEnum
_$executionResultResponseStatusEnum_COMPLETED =
    const ExecutionResultResponseStatusEnum._('COMPLETED');
const ExecutionResultResponseStatusEnum
_$executionResultResponseStatusEnum_FAILED =
    const ExecutionResultResponseStatusEnum._('FAILED');
const ExecutionResultResponseStatusEnum
_$executionResultResponseStatusEnum_CANCELLED =
    const ExecutionResultResponseStatusEnum._('CANCELLED');

ExecutionResultResponseStatusEnum _$executionResultResponseStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'PENDING':
      return _$executionResultResponseStatusEnum_PENDING;
    case 'RUNNING':
      return _$executionResultResponseStatusEnum_RUNNING;
    case 'COMPLETED':
      return _$executionResultResponseStatusEnum_COMPLETED;
    case 'FAILED':
      return _$executionResultResponseStatusEnum_FAILED;
    case 'CANCELLED':
      return _$executionResultResponseStatusEnum_CANCELLED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ExecutionResultResponseStatusEnum>
_$executionResultResponseStatusEnumValues =
    BuiltSet<ExecutionResultResponseStatusEnum>(
      const <ExecutionResultResponseStatusEnum>[
        _$executionResultResponseStatusEnum_PENDING,
        _$executionResultResponseStatusEnum_RUNNING,
        _$executionResultResponseStatusEnum_COMPLETED,
        _$executionResultResponseStatusEnum_FAILED,
        _$executionResultResponseStatusEnum_CANCELLED,
      ],
    );

Serializer<ExecutionResultResponseStatusEnum>
_$executionResultResponseStatusEnumSerializer =
    _$ExecutionResultResponseStatusEnumSerializer();

class _$ExecutionResultResponseStatusEnumSerializer
    implements PrimitiveSerializer<ExecutionResultResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PENDING': 'PENDING',
    'RUNNING': 'RUNNING',
    'COMPLETED': 'COMPLETED',
    'FAILED': 'FAILED',
    'CANCELLED': 'CANCELLED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PENDING': 'PENDING',
    'RUNNING': 'RUNNING',
    'COMPLETED': 'COMPLETED',
    'FAILED': 'FAILED',
    'CANCELLED': 'CANCELLED',
  };

  @override
  final Iterable<Type> types = const <Type>[ExecutionResultResponseStatusEnum];
  @override
  final String wireName = 'ExecutionResultResponseStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    ExecutionResultResponseStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ExecutionResultResponseStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ExecutionResultResponseStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ExecutionResultResponse extends ExecutionResultResponse {
  @override
  final String? executionId;
  @override
  final int? workflowId;
  @override
  final String? workflowName;
  @override
  final int? workflowVersion;
  @override
  final ExecutionResultResponseStatusEnum? status;
  @override
  final BuiltMap<String, JsonObject>? input;
  @override
  final BuiltMap<String, JsonObject>? output;
  @override
  final BuiltMap<String, JsonObject>? variables;
  @override
  final String? currentNodeId;
  @override
  final String? errorMessage;
  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;
  @override
  final int? durationMs;
  @override
  final BuiltList<NodeExecutionDTO>? nodeExecutions;

  factory _$ExecutionResultResponse([
    void Function(ExecutionResultResponseBuilder)? updates,
  ]) => (ExecutionResultResponseBuilder()..update(updates))._build();

  _$ExecutionResultResponse._({
    this.executionId,
    this.workflowId,
    this.workflowName,
    this.workflowVersion,
    this.status,
    this.input,
    this.output,
    this.variables,
    this.currentNodeId,
    this.errorMessage,
    this.startTime,
    this.endTime,
    this.durationMs,
    this.nodeExecutions,
  }) : super._();
  @override
  ExecutionResultResponse rebuild(
    void Function(ExecutionResultResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExecutionResultResponseBuilder toBuilder() =>
      ExecutionResultResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExecutionResultResponse &&
        executionId == other.executionId &&
        workflowId == other.workflowId &&
        workflowName == other.workflowName &&
        workflowVersion == other.workflowVersion &&
        status == other.status &&
        input == other.input &&
        output == other.output &&
        variables == other.variables &&
        currentNodeId == other.currentNodeId &&
        errorMessage == other.errorMessage &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        durationMs == other.durationMs &&
        nodeExecutions == other.nodeExecutions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, executionId.hashCode);
    _$hash = $jc(_$hash, workflowId.hashCode);
    _$hash = $jc(_$hash, workflowName.hashCode);
    _$hash = $jc(_$hash, workflowVersion.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, input.hashCode);
    _$hash = $jc(_$hash, output.hashCode);
    _$hash = $jc(_$hash, variables.hashCode);
    _$hash = $jc(_$hash, currentNodeId.hashCode);
    _$hash = $jc(_$hash, errorMessage.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, durationMs.hashCode);
    _$hash = $jc(_$hash, nodeExecutions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExecutionResultResponse')
          ..add('executionId', executionId)
          ..add('workflowId', workflowId)
          ..add('workflowName', workflowName)
          ..add('workflowVersion', workflowVersion)
          ..add('status', status)
          ..add('input', input)
          ..add('output', output)
          ..add('variables', variables)
          ..add('currentNodeId', currentNodeId)
          ..add('errorMessage', errorMessage)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('durationMs', durationMs)
          ..add('nodeExecutions', nodeExecutions))
        .toString();
  }
}

class ExecutionResultResponseBuilder
    implements
        Builder<ExecutionResultResponse, ExecutionResultResponseBuilder> {
  _$ExecutionResultResponse? _$v;

  String? _executionId;
  String? get executionId => _$this._executionId;
  set executionId(String? executionId) => _$this._executionId = executionId;

  int? _workflowId;
  int? get workflowId => _$this._workflowId;
  set workflowId(int? workflowId) => _$this._workflowId = workflowId;

  String? _workflowName;
  String? get workflowName => _$this._workflowName;
  set workflowName(String? workflowName) => _$this._workflowName = workflowName;

  int? _workflowVersion;
  int? get workflowVersion => _$this._workflowVersion;
  set workflowVersion(int? workflowVersion) =>
      _$this._workflowVersion = workflowVersion;

  ExecutionResultResponseStatusEnum? _status;
  ExecutionResultResponseStatusEnum? get status => _$this._status;
  set status(ExecutionResultResponseStatusEnum? status) =>
      _$this._status = status;

  MapBuilder<String, JsonObject>? _input;
  MapBuilder<String, JsonObject> get input =>
      _$this._input ??= MapBuilder<String, JsonObject>();
  set input(MapBuilder<String, JsonObject>? input) => _$this._input = input;

  MapBuilder<String, JsonObject>? _output;
  MapBuilder<String, JsonObject> get output =>
      _$this._output ??= MapBuilder<String, JsonObject>();
  set output(MapBuilder<String, JsonObject>? output) => _$this._output = output;

  MapBuilder<String, JsonObject>? _variables;
  MapBuilder<String, JsonObject> get variables =>
      _$this._variables ??= MapBuilder<String, JsonObject>();
  set variables(MapBuilder<String, JsonObject>? variables) =>
      _$this._variables = variables;

  String? _currentNodeId;
  String? get currentNodeId => _$this._currentNodeId;
  set currentNodeId(String? currentNodeId) =>
      _$this._currentNodeId = currentNodeId;

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

  ListBuilder<NodeExecutionDTO>? _nodeExecutions;
  ListBuilder<NodeExecutionDTO> get nodeExecutions =>
      _$this._nodeExecutions ??= ListBuilder<NodeExecutionDTO>();
  set nodeExecutions(ListBuilder<NodeExecutionDTO>? nodeExecutions) =>
      _$this._nodeExecutions = nodeExecutions;

  ExecutionResultResponseBuilder() {
    ExecutionResultResponse._defaults(this);
  }

  ExecutionResultResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _executionId = $v.executionId;
      _workflowId = $v.workflowId;
      _workflowName = $v.workflowName;
      _workflowVersion = $v.workflowVersion;
      _status = $v.status;
      _input = $v.input?.toBuilder();
      _output = $v.output?.toBuilder();
      _variables = $v.variables?.toBuilder();
      _currentNodeId = $v.currentNodeId;
      _errorMessage = $v.errorMessage;
      _startTime = $v.startTime;
      _endTime = $v.endTime;
      _durationMs = $v.durationMs;
      _nodeExecutions = $v.nodeExecutions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExecutionResultResponse other) {
    _$v = other as _$ExecutionResultResponse;
  }

  @override
  void update(void Function(ExecutionResultResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExecutionResultResponse build() => _build();

  _$ExecutionResultResponse _build() {
    _$ExecutionResultResponse _$result;
    try {
      _$result =
          _$v ??
          _$ExecutionResultResponse._(
            executionId: executionId,
            workflowId: workflowId,
            workflowName: workflowName,
            workflowVersion: workflowVersion,
            status: status,
            input: _input?.build(),
            output: _output?.build(),
            variables: _variables?.build(),
            currentNodeId: currentNodeId,
            errorMessage: errorMessage,
            startTime: startTime,
            endTime: endTime,
            durationMs: durationMs,
            nodeExecutions: _nodeExecutions?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        _input?.build();
        _$failedField = 'output';
        _output?.build();
        _$failedField = 'variables';
        _variables?.build();

        _$failedField = 'nodeExecutions';
        _nodeExecutions?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ExecutionResultResponse',
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
