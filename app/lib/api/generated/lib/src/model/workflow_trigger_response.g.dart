// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_trigger_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WorkflowTriggerResponse extends WorkflowTriggerResponse {
  @override
  final int? id;
  @override
  final int? workflowId;
  @override
  final String? type;
  @override
  final String? name;
  @override
  final bool? enabled;
  @override
  final BuiltMap<String, JsonObject>? config;
  @override
  final DateTime? lastTriggeredAt;
  @override
  final int? triggerCount;
  @override
  final DateTime? createTime;

  factory _$WorkflowTriggerResponse([
    void Function(WorkflowTriggerResponseBuilder)? updates,
  ]) => (WorkflowTriggerResponseBuilder()..update(updates))._build();

  _$WorkflowTriggerResponse._({
    this.id,
    this.workflowId,
    this.type,
    this.name,
    this.enabled,
    this.config,
    this.lastTriggeredAt,
    this.triggerCount,
    this.createTime,
  }) : super._();
  @override
  WorkflowTriggerResponse rebuild(
    void Function(WorkflowTriggerResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WorkflowTriggerResponseBuilder toBuilder() =>
      WorkflowTriggerResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkflowTriggerResponse &&
        id == other.id &&
        workflowId == other.workflowId &&
        type == other.type &&
        name == other.name &&
        enabled == other.enabled &&
        config == other.config &&
        lastTriggeredAt == other.lastTriggeredAt &&
        triggerCount == other.triggerCount &&
        createTime == other.createTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, workflowId.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, enabled.hashCode);
    _$hash = $jc(_$hash, config.hashCode);
    _$hash = $jc(_$hash, lastTriggeredAt.hashCode);
    _$hash = $jc(_$hash, triggerCount.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WorkflowTriggerResponse')
          ..add('id', id)
          ..add('workflowId', workflowId)
          ..add('type', type)
          ..add('name', name)
          ..add('enabled', enabled)
          ..add('config', config)
          ..add('lastTriggeredAt', lastTriggeredAt)
          ..add('triggerCount', triggerCount)
          ..add('createTime', createTime))
        .toString();
  }
}

class WorkflowTriggerResponseBuilder
    implements
        Builder<WorkflowTriggerResponse, WorkflowTriggerResponseBuilder> {
  _$WorkflowTriggerResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _workflowId;
  int? get workflowId => _$this._workflowId;
  set workflowId(int? workflowId) => _$this._workflowId = workflowId;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  bool? _enabled;
  bool? get enabled => _$this._enabled;
  set enabled(bool? enabled) => _$this._enabled = enabled;

  MapBuilder<String, JsonObject>? _config;
  MapBuilder<String, JsonObject> get config =>
      _$this._config ??= MapBuilder<String, JsonObject>();
  set config(MapBuilder<String, JsonObject>? config) => _$this._config = config;

  DateTime? _lastTriggeredAt;
  DateTime? get lastTriggeredAt => _$this._lastTriggeredAt;
  set lastTriggeredAt(DateTime? lastTriggeredAt) =>
      _$this._lastTriggeredAt = lastTriggeredAt;

  int? _triggerCount;
  int? get triggerCount => _$this._triggerCount;
  set triggerCount(int? triggerCount) => _$this._triggerCount = triggerCount;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  WorkflowTriggerResponseBuilder() {
    WorkflowTriggerResponse._defaults(this);
  }

  WorkflowTriggerResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _workflowId = $v.workflowId;
      _type = $v.type;
      _name = $v.name;
      _enabled = $v.enabled;
      _config = $v.config?.toBuilder();
      _lastTriggeredAt = $v.lastTriggeredAt;
      _triggerCount = $v.triggerCount;
      _createTime = $v.createTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkflowTriggerResponse other) {
    _$v = other as _$WorkflowTriggerResponse;
  }

  @override
  void update(void Function(WorkflowTriggerResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WorkflowTriggerResponse build() => _build();

  _$WorkflowTriggerResponse _build() {
    _$WorkflowTriggerResponse _$result;
    try {
      _$result =
          _$v ??
          _$WorkflowTriggerResponse._(
            id: id,
            workflowId: workflowId,
            type: type,
            name: name,
            enabled: enabled,
            config: _config?.build(),
            lastTriggeredAt: lastTriggeredAt,
            triggerCount: triggerCount,
            createTime: createTime,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'config';
        _config?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'WorkflowTriggerResponse',
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
