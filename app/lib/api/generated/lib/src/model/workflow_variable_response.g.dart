// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_variable_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WorkflowVariableResponse extends WorkflowVariableResponse {
  @override
  final String? name;
  @override
  final String? type;
  @override
  final JsonObject? defaultValue;
  @override
  final String? description;

  factory _$WorkflowVariableResponse([
    void Function(WorkflowVariableResponseBuilder)? updates,
  ]) => (WorkflowVariableResponseBuilder()..update(updates))._build();

  _$WorkflowVariableResponse._({
    this.name,
    this.type,
    this.defaultValue,
    this.description,
  }) : super._();
  @override
  WorkflowVariableResponse rebuild(
    void Function(WorkflowVariableResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WorkflowVariableResponseBuilder toBuilder() =>
      WorkflowVariableResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkflowVariableResponse &&
        name == other.name &&
        type == other.type &&
        defaultValue == other.defaultValue &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, defaultValue.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WorkflowVariableResponse')
          ..add('name', name)
          ..add('type', type)
          ..add('defaultValue', defaultValue)
          ..add('description', description))
        .toString();
  }
}

class WorkflowVariableResponseBuilder
    implements
        Builder<WorkflowVariableResponse, WorkflowVariableResponseBuilder> {
  _$WorkflowVariableResponse? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  JsonObject? _defaultValue;
  JsonObject? get defaultValue => _$this._defaultValue;
  set defaultValue(JsonObject? defaultValue) =>
      _$this._defaultValue = defaultValue;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  WorkflowVariableResponseBuilder() {
    WorkflowVariableResponse._defaults(this);
  }

  WorkflowVariableResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _type = $v.type;
      _defaultValue = $v.defaultValue;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkflowVariableResponse other) {
    _$v = other as _$WorkflowVariableResponse;
  }

  @override
  void update(void Function(WorkflowVariableResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WorkflowVariableResponse build() => _build();

  _$WorkflowVariableResponse _build() {
    final _$result =
        _$v ??
        _$WorkflowVariableResponse._(
          name: name,
          type: type,
          defaultValue: defaultValue,
          description: description,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
