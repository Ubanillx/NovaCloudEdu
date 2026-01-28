// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_definition_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WorkflowDefinitionResponse extends WorkflowDefinitionResponse {
  @override
  final int? workflowId;
  @override
  final String? workflowName;
  @override
  final String? version;
  @override
  final BuiltList<WorkflowNodeResponse>? nodes;
  @override
  final BuiltList<WorkflowEdgeResponse>? edges;
  @override
  final BuiltMap<String, WorkflowVariableResponse>? variables;
  @override
  final WorkflowSettingsDTO? settings;

  factory _$WorkflowDefinitionResponse([
    void Function(WorkflowDefinitionResponseBuilder)? updates,
  ]) => (WorkflowDefinitionResponseBuilder()..update(updates))._build();

  _$WorkflowDefinitionResponse._({
    this.workflowId,
    this.workflowName,
    this.version,
    this.nodes,
    this.edges,
    this.variables,
    this.settings,
  }) : super._();
  @override
  WorkflowDefinitionResponse rebuild(
    void Function(WorkflowDefinitionResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WorkflowDefinitionResponseBuilder toBuilder() =>
      WorkflowDefinitionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkflowDefinitionResponse &&
        workflowId == other.workflowId &&
        workflowName == other.workflowName &&
        version == other.version &&
        nodes == other.nodes &&
        edges == other.edges &&
        variables == other.variables &&
        settings == other.settings;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, workflowId.hashCode);
    _$hash = $jc(_$hash, workflowName.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, nodes.hashCode);
    _$hash = $jc(_$hash, edges.hashCode);
    _$hash = $jc(_$hash, variables.hashCode);
    _$hash = $jc(_$hash, settings.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WorkflowDefinitionResponse')
          ..add('workflowId', workflowId)
          ..add('workflowName', workflowName)
          ..add('version', version)
          ..add('nodes', nodes)
          ..add('edges', edges)
          ..add('variables', variables)
          ..add('settings', settings))
        .toString();
  }
}

class WorkflowDefinitionResponseBuilder
    implements
        Builder<WorkflowDefinitionResponse, WorkflowDefinitionResponseBuilder> {
  _$WorkflowDefinitionResponse? _$v;

  int? _workflowId;
  int? get workflowId => _$this._workflowId;
  set workflowId(int? workflowId) => _$this._workflowId = workflowId;

  String? _workflowName;
  String? get workflowName => _$this._workflowName;
  set workflowName(String? workflowName) => _$this._workflowName = workflowName;

  String? _version;
  String? get version => _$this._version;
  set version(String? version) => _$this._version = version;

  ListBuilder<WorkflowNodeResponse>? _nodes;
  ListBuilder<WorkflowNodeResponse> get nodes =>
      _$this._nodes ??= ListBuilder<WorkflowNodeResponse>();
  set nodes(ListBuilder<WorkflowNodeResponse>? nodes) => _$this._nodes = nodes;

  ListBuilder<WorkflowEdgeResponse>? _edges;
  ListBuilder<WorkflowEdgeResponse> get edges =>
      _$this._edges ??= ListBuilder<WorkflowEdgeResponse>();
  set edges(ListBuilder<WorkflowEdgeResponse>? edges) => _$this._edges = edges;

  MapBuilder<String, WorkflowVariableResponse>? _variables;
  MapBuilder<String, WorkflowVariableResponse> get variables =>
      _$this._variables ??= MapBuilder<String, WorkflowVariableResponse>();
  set variables(MapBuilder<String, WorkflowVariableResponse>? variables) =>
      _$this._variables = variables;

  WorkflowSettingsDTOBuilder? _settings;
  WorkflowSettingsDTOBuilder get settings =>
      _$this._settings ??= WorkflowSettingsDTOBuilder();
  set settings(WorkflowSettingsDTOBuilder? settings) =>
      _$this._settings = settings;

  WorkflowDefinitionResponseBuilder() {
    WorkflowDefinitionResponse._defaults(this);
  }

  WorkflowDefinitionResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _workflowId = $v.workflowId;
      _workflowName = $v.workflowName;
      _version = $v.version;
      _nodes = $v.nodes?.toBuilder();
      _edges = $v.edges?.toBuilder();
      _variables = $v.variables?.toBuilder();
      _settings = $v.settings?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkflowDefinitionResponse other) {
    _$v = other as _$WorkflowDefinitionResponse;
  }

  @override
  void update(void Function(WorkflowDefinitionResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WorkflowDefinitionResponse build() => _build();

  _$WorkflowDefinitionResponse _build() {
    _$WorkflowDefinitionResponse _$result;
    try {
      _$result =
          _$v ??
          _$WorkflowDefinitionResponse._(
            workflowId: workflowId,
            workflowName: workflowName,
            version: version,
            nodes: _nodes?.build(),
            edges: _edges?.build(),
            variables: _variables?.build(),
            settings: _settings?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'nodes';
        _nodes?.build();
        _$failedField = 'edges';
        _edges?.build();
        _$failedField = 'variables';
        _variables?.build();
        _$failedField = 'settings';
        _settings?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'WorkflowDefinitionResponse',
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
