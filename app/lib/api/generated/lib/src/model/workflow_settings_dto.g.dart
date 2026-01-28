// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_settings_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WorkflowSettingsDTO extends WorkflowSettingsDTO {
  @override
  final int? maxExecutionTimeMs;
  @override
  final bool? enableLogging;
  @override
  final String? logLevel;
  @override
  final bool? enableDebug;

  factory _$WorkflowSettingsDTO([
    void Function(WorkflowSettingsDTOBuilder)? updates,
  ]) => (WorkflowSettingsDTOBuilder()..update(updates))._build();

  _$WorkflowSettingsDTO._({
    this.maxExecutionTimeMs,
    this.enableLogging,
    this.logLevel,
    this.enableDebug,
  }) : super._();
  @override
  WorkflowSettingsDTO rebuild(
    void Function(WorkflowSettingsDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WorkflowSettingsDTOBuilder toBuilder() =>
      WorkflowSettingsDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkflowSettingsDTO &&
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
    return (newBuiltValueToStringHelper(r'WorkflowSettingsDTO')
          ..add('maxExecutionTimeMs', maxExecutionTimeMs)
          ..add('enableLogging', enableLogging)
          ..add('logLevel', logLevel)
          ..add('enableDebug', enableDebug))
        .toString();
  }
}

class WorkflowSettingsDTOBuilder
    implements Builder<WorkflowSettingsDTO, WorkflowSettingsDTOBuilder> {
  _$WorkflowSettingsDTO? _$v;

  int? _maxExecutionTimeMs;
  int? get maxExecutionTimeMs => _$this._maxExecutionTimeMs;
  set maxExecutionTimeMs(int? maxExecutionTimeMs) =>
      _$this._maxExecutionTimeMs = maxExecutionTimeMs;

  bool? _enableLogging;
  bool? get enableLogging => _$this._enableLogging;
  set enableLogging(bool? enableLogging) =>
      _$this._enableLogging = enableLogging;

  String? _logLevel;
  String? get logLevel => _$this._logLevel;
  set logLevel(String? logLevel) => _$this._logLevel = logLevel;

  bool? _enableDebug;
  bool? get enableDebug => _$this._enableDebug;
  set enableDebug(bool? enableDebug) => _$this._enableDebug = enableDebug;

  WorkflowSettingsDTOBuilder() {
    WorkflowSettingsDTO._defaults(this);
  }

  WorkflowSettingsDTOBuilder get _$this {
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
  void replace(WorkflowSettingsDTO other) {
    _$v = other as _$WorkflowSettingsDTO;
  }

  @override
  void update(void Function(WorkflowSettingsDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WorkflowSettingsDTO build() => _build();

  _$WorkflowSettingsDTO _build() {
    final _$result =
        _$v ??
        _$WorkflowSettingsDTO._(
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
