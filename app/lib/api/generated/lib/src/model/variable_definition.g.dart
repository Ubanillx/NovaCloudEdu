// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variable_definition.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$VariableDefinition extends VariableDefinition {
  @override
  final String? name;
  @override
  final String? type;
  @override
  final JsonObject? defaultValue;
  @override
  final String? description;

  factory _$VariableDefinition([
    void Function(VariableDefinitionBuilder)? updates,
  ]) => (VariableDefinitionBuilder()..update(updates))._build();

  _$VariableDefinition._({
    this.name,
    this.type,
    this.defaultValue,
    this.description,
  }) : super._();
  @override
  VariableDefinition rebuild(
    void Function(VariableDefinitionBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  VariableDefinitionBuilder toBuilder() =>
      VariableDefinitionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VariableDefinition &&
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
    return (newBuiltValueToStringHelper(r'VariableDefinition')
          ..add('name', name)
          ..add('type', type)
          ..add('defaultValue', defaultValue)
          ..add('description', description))
        .toString();
  }
}

class VariableDefinitionBuilder
    implements Builder<VariableDefinition, VariableDefinitionBuilder> {
  _$VariableDefinition? _$v;

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

  VariableDefinitionBuilder() {
    VariableDefinition._defaults(this);
  }

  VariableDefinitionBuilder get _$this {
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
  void replace(VariableDefinition other) {
    _$v = other as _$VariableDefinition;
  }

  @override
  void update(void Function(VariableDefinitionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VariableDefinition build() => _build();

  _$VariableDefinition _build() {
    final _$result =
        _$v ??
        _$VariableDefinition._(
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
