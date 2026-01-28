// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_definition.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WorkflowDefinition extends WorkflowDefinition {
  @override
  final String? version;
  @override
  final BuiltList<WorkflowNode>? nodes;
  @override
  final BuiltList<WorkflowEdge>? edges;
  @override
  final BuiltMap<String, VariableDefinition>? variables;
  @override
  final WorkflowSettings? settings;

  factory _$WorkflowDefinition([
    void Function(WorkflowDefinitionBuilder)? updates,
  ]) => (WorkflowDefinitionBuilder()..update(updates))._build();

  _$WorkflowDefinition._({
    this.version,
    this.nodes,
    this.edges,
    this.variables,
    this.settings,
  }) : super._();
  @override
  WorkflowDefinition rebuild(
    void Function(WorkflowDefinitionBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WorkflowDefinitionBuilder toBuilder() =>
      WorkflowDefinitionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkflowDefinition &&
        version == other.version &&
        nodes == other.nodes &&
        edges == other.edges &&
        variables == other.variables &&
        settings == other.settings;
  }

  @override
  int get hashCode {
    var _$hash = 0;
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
    return (newBuiltValueToStringHelper(r'WorkflowDefinition')
          ..add('version', version)
          ..add('nodes', nodes)
          ..add('edges', edges)
          ..add('variables', variables)
          ..add('settings', settings))
        .toString();
  }
}

class WorkflowDefinitionBuilder
    implements Builder<WorkflowDefinition, WorkflowDefinitionBuilder> {
  _$WorkflowDefinition? _$v;

  String? _version;
  String? get version => _$this._version;
  set version(String? version) => _$this._version = version;

  ListBuilder<WorkflowNode>? _nodes;
  ListBuilder<WorkflowNode> get nodes =>
      _$this._nodes ??= ListBuilder<WorkflowNode>();
  set nodes(ListBuilder<WorkflowNode>? nodes) => _$this._nodes = nodes;

  ListBuilder<WorkflowEdge>? _edges;
  ListBuilder<WorkflowEdge> get edges =>
      _$this._edges ??= ListBuilder<WorkflowEdge>();
  set edges(ListBuilder<WorkflowEdge>? edges) => _$this._edges = edges;

  MapBuilder<String, VariableDefinition>? _variables;
  MapBuilder<String, VariableDefinition> get variables =>
      _$this._variables ??= MapBuilder<String, VariableDefinition>();
  set variables(MapBuilder<String, VariableDefinition>? variables) =>
      _$this._variables = variables;

  WorkflowSettingsBuilder? _settings;
  WorkflowSettingsBuilder get settings =>
      _$this._settings ??= WorkflowSettingsBuilder();
  set settings(WorkflowSettingsBuilder? settings) =>
      _$this._settings = settings;

  WorkflowDefinitionBuilder() {
    WorkflowDefinition._defaults(this);
  }

  WorkflowDefinitionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
  void replace(WorkflowDefinition other) {
    _$v = other as _$WorkflowDefinition;
  }

  @override
  void update(void Function(WorkflowDefinitionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WorkflowDefinition build() => _build();

  _$WorkflowDefinition _build() {
    _$WorkflowDefinition _$result;
    try {
      _$result =
          _$v ??
          _$WorkflowDefinition._(
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
          r'WorkflowDefinition',
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
