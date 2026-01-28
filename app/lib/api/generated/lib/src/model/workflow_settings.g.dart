// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_settings.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WorkflowSettingsLogLevelEnum _$workflowSettingsLogLevelEnum_DEBUG =
    const WorkflowSettingsLogLevelEnum._('DEBUG');
const WorkflowSettingsLogLevelEnum _$workflowSettingsLogLevelEnum_INFO =
    const WorkflowSettingsLogLevelEnum._('INFO');
const WorkflowSettingsLogLevelEnum _$workflowSettingsLogLevelEnum_WARN =
    const WorkflowSettingsLogLevelEnum._('WARN');
const WorkflowSettingsLogLevelEnum _$workflowSettingsLogLevelEnum_ERROR =
    const WorkflowSettingsLogLevelEnum._('ERROR');

WorkflowSettingsLogLevelEnum _$workflowSettingsLogLevelEnumValueOf(
  String name,
) {
  switch (name) {
    case 'DEBUG':
      return _$workflowSettingsLogLevelEnum_DEBUG;
    case 'INFO':
      return _$workflowSettingsLogLevelEnum_INFO;
    case 'WARN':
      return _$workflowSettingsLogLevelEnum_WARN;
    case 'ERROR':
      return _$workflowSettingsLogLevelEnum_ERROR;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<WorkflowSettingsLogLevelEnum>
_$workflowSettingsLogLevelEnumValues =
    BuiltSet<WorkflowSettingsLogLevelEnum>(const <WorkflowSettingsLogLevelEnum>[
      _$workflowSettingsLogLevelEnum_DEBUG,
      _$workflowSettingsLogLevelEnum_INFO,
      _$workflowSettingsLogLevelEnum_WARN,
      _$workflowSettingsLogLevelEnum_ERROR,
    ]);

Serializer<WorkflowSettingsLogLevelEnum>
_$workflowSettingsLogLevelEnumSerializer =
    _$WorkflowSettingsLogLevelEnumSerializer();

class _$WorkflowSettingsLogLevelEnumSerializer
    implements PrimitiveSerializer<WorkflowSettingsLogLevelEnum> {
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
  final Iterable<Type> types = const <Type>[WorkflowSettingsLogLevelEnum];
  @override
  final String wireName = 'WorkflowSettingsLogLevelEnum';

  @override
  Object serialize(
    Serializers serializers,
    WorkflowSettingsLogLevelEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  WorkflowSettingsLogLevelEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => WorkflowSettingsLogLevelEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$WorkflowSettings extends WorkflowSettings {
  @override
  final int? maxExecutionTimeMs;
  @override
  final bool? enableLogging;
  @override
  final WorkflowSettingsLogLevelEnum? logLevel;
  @override
  final bool? enableDebug;

  factory _$WorkflowSettings([
    void Function(WorkflowSettingsBuilder)? updates,
  ]) => (WorkflowSettingsBuilder()..update(updates))._build();

  _$WorkflowSettings._({
    this.maxExecutionTimeMs,
    this.enableLogging,
    this.logLevel,
    this.enableDebug,
  }) : super._();
  @override
  WorkflowSettings rebuild(void Function(WorkflowSettingsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WorkflowSettingsBuilder toBuilder() =>
      WorkflowSettingsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkflowSettings &&
        maxExecutionTimeMs == other.maxExecutionTimeMs &&
        enableLogging == other.enableLogging &&
        logLevel == other.logLevel &&
        enableDebug == other.enableDebug;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, maxExecutionTimeMs.hashCode);
    _$hash = $jc(_$hash, enableLogging.hashCode);
    _$hash = $jc(_$hash, logLevel.hashCode);
    _$hash = $jc(_$hash, enableDebug.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WorkflowSettings')
          ..add('maxExecutionTimeMs', maxExecutionTimeMs)
          ..add('enableLogging', enableLogging)
          ..add('logLevel', logLevel)
          ..add('enableDebug', enableDebug))
        .toString();
  }
}

class WorkflowSettingsBuilder
    implements Builder<WorkflowSettings, WorkflowSettingsBuilder> {
  _$WorkflowSettings? _$v;

  int? _maxExecutionTimeMs;
  int? get maxExecutionTimeMs => _$this._maxExecutionTimeMs;
  set maxExecutionTimeMs(int? maxExecutionTimeMs) =>
      _$this._maxExecutionTimeMs = maxExecutionTimeMs;

  bool? _enableLogging;
  bool? get enableLogging => _$this._enableLogging;
  set enableLogging(bool? enableLogging) =>
      _$this._enableLogging = enableLogging;

  WorkflowSettingsLogLevelEnum? _logLevel;
  WorkflowSettingsLogLevelEnum? get logLevel => _$this._logLevel;
  set logLevel(WorkflowSettingsLogLevelEnum? logLevel) =>
      _$this._logLevel = logLevel;

  bool? _enableDebug;
  bool? get enableDebug => _$this._enableDebug;
  set enableDebug(bool? enableDebug) => _$this._enableDebug = enableDebug;

  WorkflowSettingsBuilder() {
    WorkflowSettings._defaults(this);
  }

  WorkflowSettingsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _maxExecutionTimeMs = $v.maxExecutionTimeMs;
      _enableLogging = $v.enableLogging;
      _logLevel = $v.logLevel;
      _enableDebug = $v.enableDebug;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkflowSettings other) {
    _$v = other as _$WorkflowSettings;
  }

  @override
  void update(void Function(WorkflowSettingsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WorkflowSettings build() => _build();

  _$WorkflowSettings _build() {
    final _$result =
        _$v ??
        _$WorkflowSettings._(
          maxExecutionTimeMs: maxExecutionTimeMs,
          enableLogging: enableLogging,
          logLevel: logLevel,
          enableDebug: enableDebug,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
