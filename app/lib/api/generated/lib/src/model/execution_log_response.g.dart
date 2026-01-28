// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'execution_log_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ExecutionLogResponseNodeTypeEnum
_$executionLogResponseNodeTypeEnum_START =
    const ExecutionLogResponseNodeTypeEnum._('START');
const ExecutionLogResponseNodeTypeEnum _$executionLogResponseNodeTypeEnum_END =
    const ExecutionLogResponseNodeTypeEnum._('END');
const ExecutionLogResponseNodeTypeEnum _$executionLogResponseNodeTypeEnum_LLM =
    const ExecutionLogResponseNodeTypeEnum._('LLM');
const ExecutionLogResponseNodeTypeEnum
_$executionLogResponseNodeTypeEnum_KNOWLEDGE_RETRIEVAL =
    const ExecutionLogResponseNodeTypeEnum._('KNOWLEDGE_RETRIEVAL');
const ExecutionLogResponseNodeTypeEnum _$executionLogResponseNodeTypeEnum_CODE =
    const ExecutionLogResponseNodeTypeEnum._('CODE');
const ExecutionLogResponseNodeTypeEnum
_$executionLogResponseNodeTypeEnum_CONDITION =
    const ExecutionLogResponseNodeTypeEnum._('CONDITION');
const ExecutionLogResponseNodeTypeEnum _$executionLogResponseNodeTypeEnum_LOOP =
    const ExecutionLogResponseNodeTypeEnum._('LOOP');
const ExecutionLogResponseNodeTypeEnum _$executionLogResponseNodeTypeEnum_HTTP =
    const ExecutionLogResponseNodeTypeEnum._('HTTP');
const ExecutionLogResponseNodeTypeEnum
_$executionLogResponseNodeTypeEnum_VARIABLE =
    const ExecutionLogResponseNodeTypeEnum._('VARIABLE');

ExecutionLogResponseNodeTypeEnum _$executionLogResponseNodeTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'START':
      return _$executionLogResponseNodeTypeEnum_START;
    case 'END':
      return _$executionLogResponseNodeTypeEnum_END;
    case 'LLM':
      return _$executionLogResponseNodeTypeEnum_LLM;
    case 'KNOWLEDGE_RETRIEVAL':
      return _$executionLogResponseNodeTypeEnum_KNOWLEDGE_RETRIEVAL;
    case 'CODE':
      return _$executionLogResponseNodeTypeEnum_CODE;
    case 'CONDITION':
      return _$executionLogResponseNodeTypeEnum_CONDITION;
    case 'LOOP':
      return _$executionLogResponseNodeTypeEnum_LOOP;
    case 'HTTP':
      return _$executionLogResponseNodeTypeEnum_HTTP;
    case 'VARIABLE':
      return _$executionLogResponseNodeTypeEnum_VARIABLE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ExecutionLogResponseNodeTypeEnum>
_$executionLogResponseNodeTypeEnumValues =
    BuiltSet<ExecutionLogResponseNodeTypeEnum>(
      const <ExecutionLogResponseNodeTypeEnum>[
        _$executionLogResponseNodeTypeEnum_START,
        _$executionLogResponseNodeTypeEnum_END,
        _$executionLogResponseNodeTypeEnum_LLM,
        _$executionLogResponseNodeTypeEnum_KNOWLEDGE_RETRIEVAL,
        _$executionLogResponseNodeTypeEnum_CODE,
        _$executionLogResponseNodeTypeEnum_CONDITION,
        _$executionLogResponseNodeTypeEnum_LOOP,
        _$executionLogResponseNodeTypeEnum_HTTP,
        _$executionLogResponseNodeTypeEnum_VARIABLE,
      ],
    );

const ExecutionLogResponseLevelEnum _$executionLogResponseLevelEnum_DEBUG =
    const ExecutionLogResponseLevelEnum._('DEBUG');
const ExecutionLogResponseLevelEnum _$executionLogResponseLevelEnum_INFO =
    const ExecutionLogResponseLevelEnum._('INFO');
const ExecutionLogResponseLevelEnum _$executionLogResponseLevelEnum_WARN =
    const ExecutionLogResponseLevelEnum._('WARN');
const ExecutionLogResponseLevelEnum _$executionLogResponseLevelEnum_ERROR =
    const ExecutionLogResponseLevelEnum._('ERROR');

ExecutionLogResponseLevelEnum _$executionLogResponseLevelEnumValueOf(
  String name,
) {
  switch (name) {
    case 'DEBUG':
      return _$executionLogResponseLevelEnum_DEBUG;
    case 'INFO':
      return _$executionLogResponseLevelEnum_INFO;
    case 'WARN':
      return _$executionLogResponseLevelEnum_WARN;
    case 'ERROR':
      return _$executionLogResponseLevelEnum_ERROR;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ExecutionLogResponseLevelEnum>
_$executionLogResponseLevelEnumValues = BuiltSet<ExecutionLogResponseLevelEnum>(
  const <ExecutionLogResponseLevelEnum>[
    _$executionLogResponseLevelEnum_DEBUG,
    _$executionLogResponseLevelEnum_INFO,
    _$executionLogResponseLevelEnum_WARN,
    _$executionLogResponseLevelEnum_ERROR,
  ],
);

Serializer<ExecutionLogResponseNodeTypeEnum>
_$executionLogResponseNodeTypeEnumSerializer =
    _$ExecutionLogResponseNodeTypeEnumSerializer();
Serializer<ExecutionLogResponseLevelEnum>
_$executionLogResponseLevelEnumSerializer =
    _$ExecutionLogResponseLevelEnumSerializer();

class _$ExecutionLogResponseNodeTypeEnumSerializer
    implements PrimitiveSerializer<ExecutionLogResponseNodeTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'START': 'START',
    'END': 'END',
    'LLM': 'LLM',
    'KNOWLEDGE_RETRIEVAL': 'KNOWLEDGE_RETRIEVAL',
    'CODE': 'CODE',
    'CONDITION': 'CONDITION',
    'LOOP': 'LOOP',
    'HTTP': 'HTTP',
    'VARIABLE': 'VARIABLE',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'START': 'START',
    'END': 'END',
    'LLM': 'LLM',
    'KNOWLEDGE_RETRIEVAL': 'KNOWLEDGE_RETRIEVAL',
    'CODE': 'CODE',
    'CONDITION': 'CONDITION',
    'LOOP': 'LOOP',
    'HTTP': 'HTTP',
    'VARIABLE': 'VARIABLE',
  };

  @override
  final Iterable<Type> types = const <Type>[ExecutionLogResponseNodeTypeEnum];
  @override
  final String wireName = 'ExecutionLogResponseNodeTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    ExecutionLogResponseNodeTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ExecutionLogResponseNodeTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ExecutionLogResponseNodeTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ExecutionLogResponseLevelEnumSerializer
    implements PrimitiveSerializer<ExecutionLogResponseLevelEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'DEBUG': 'DEBUG',
    'INFO': 'INFO',
    'WARN': 'WARN',
    'ERROR': 'ERROR',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'DEBUG': 'DEBUG',
    'INFO': 'INFO',
    'WARN': 'WARN',
    'ERROR': 'ERROR',
  };

  @override
  final Iterable<Type> types = const <Type>[ExecutionLogResponseLevelEnum];
  @override
  final String wireName = 'ExecutionLogResponseLevelEnum';

  @override
  Object serialize(
    Serializers serializers,
    ExecutionLogResponseLevelEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ExecutionLogResponseLevelEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ExecutionLogResponseLevelEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ExecutionLogResponse extends ExecutionLogResponse {
  @override
  final String? executionId;
  @override
  final String? nodeId;
  @override
  final String? nodeName;
  @override
  final ExecutionLogResponseNodeTypeEnum? nodeType;
  @override
  final ExecutionLogResponseLevelEnum? level;
  @override
  final String? message;
  @override
  final int? durationMs;
  @override
  final DateTime? timestamp;

  factory _$ExecutionLogResponse([
    void Function(ExecutionLogResponseBuilder)? updates,
  ]) => (ExecutionLogResponseBuilder()..update(updates))._build();

  _$ExecutionLogResponse._({
    this.executionId,
    this.nodeId,
    this.nodeName,
    this.nodeType,
    this.level,
    this.message,
    this.durationMs,
    this.timestamp,
  }) : super._();
  @override
  ExecutionLogResponse rebuild(
    void Function(ExecutionLogResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExecutionLogResponseBuilder toBuilder() =>
      ExecutionLogResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExecutionLogResponse &&
        executionId == other.executionId &&
        nodeId == other.nodeId &&
        nodeName == other.nodeName &&
        nodeType == other.nodeType &&
        level == other.level &&
        message == other.message &&
        durationMs == other.durationMs &&
        timestamp == other.timestamp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, executionId.hashCode);
    _$hash = $jc(_$hash, nodeId.hashCode);
    _$hash = $jc(_$hash, nodeName.hashCode);
    _$hash = $jc(_$hash, nodeType.hashCode);
    _$hash = $jc(_$hash, level.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, durationMs.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExecutionLogResponse')
          ..add('executionId', executionId)
          ..add('nodeId', nodeId)
          ..add('nodeName', nodeName)
          ..add('nodeType', nodeType)
          ..add('level', level)
          ..add('message', message)
          ..add('durationMs', durationMs)
          ..add('timestamp', timestamp))
        .toString();
  }
}

class ExecutionLogResponseBuilder
    implements Builder<ExecutionLogResponse, ExecutionLogResponseBuilder> {
  _$ExecutionLogResponse? _$v;

  String? _executionId;
  String? get executionId => _$this._executionId;
  set executionId(String? executionId) => _$this._executionId = executionId;

  String? _nodeId;
  String? get nodeId => _$this._nodeId;
  set nodeId(String? nodeId) => _$this._nodeId = nodeId;

  String? _nodeName;
  String? get nodeName => _$this._nodeName;
  set nodeName(String? nodeName) => _$this._nodeName = nodeName;

  ExecutionLogResponseNodeTypeEnum? _nodeType;
  ExecutionLogResponseNodeTypeEnum? get nodeType => _$this._nodeType;
  set nodeType(ExecutionLogResponseNodeTypeEnum? nodeType) =>
      _$this._nodeType = nodeType;

  ExecutionLogResponseLevelEnum? _level;
  ExecutionLogResponseLevelEnum? get level => _$this._level;
  set level(ExecutionLogResponseLevelEnum? level) => _$this._level = level;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  int? _durationMs;
  int? get durationMs => _$this._durationMs;
  set durationMs(int? durationMs) => _$this._durationMs = durationMs;

  DateTime? _timestamp;
  DateTime? get timestamp => _$this._timestamp;
  set timestamp(DateTime? timestamp) => _$this._timestamp = timestamp;

  ExecutionLogResponseBuilder() {
    ExecutionLogResponse._defaults(this);
  }

  ExecutionLogResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _executionId = $v.executionId;
      _nodeId = $v.nodeId;
      _nodeName = $v.nodeName;
      _nodeType = $v.nodeType;
      _level = $v.level;
      _message = $v.message;
      _durationMs = $v.durationMs;
      _timestamp = $v.timestamp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExecutionLogResponse other) {
    _$v = other as _$ExecutionLogResponse;
  }

  @override
  void update(void Function(ExecutionLogResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExecutionLogResponse build() => _build();

  _$ExecutionLogResponse _build() {
    final _$result =
        _$v ??
        _$ExecutionLogResponse._(
          executionId: executionId,
          nodeId: nodeId,
          nodeName: nodeName,
          nodeType: nodeType,
          level: level,
          message: message,
          durationMs: durationMs,
          timestamp: timestamp,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
