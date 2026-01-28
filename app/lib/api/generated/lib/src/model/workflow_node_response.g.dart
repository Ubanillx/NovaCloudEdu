// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_node_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WorkflowNodeResponse extends WorkflowNodeResponse {
  @override
  final String? id;
  @override
  final String? type;
  @override
  final String? typeDescription;
  @override
  final String? name;
  @override
  final PositionDTO? position;
  @override
  final BuiltMap<String, JsonObject>? config;
  @override
  final ErrorHandlingConfigDTO? errorHandling;

  factory _$WorkflowNodeResponse([
    void Function(WorkflowNodeResponseBuilder)? updates,
  ]) => (WorkflowNodeResponseBuilder()..update(updates))._build();

  _$WorkflowNodeResponse._({
    this.id,
    this.type,
    this.typeDescription,
    this.name,
    this.position,
    this.config,
    this.errorHandling,
  }) : super._();
  @override
  WorkflowNodeResponse rebuild(
    void Function(WorkflowNodeResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WorkflowNodeResponseBuilder toBuilder() =>
      WorkflowNodeResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkflowNodeResponse &&
        id == other.id &&
        type == other.type &&
        typeDescription == other.typeDescription &&
        name == other.name &&
        position == other.position &&
        config == other.config &&
        errorHandling == other.errorHandling;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, typeDescription.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, position.hashCode);
    _$hash = $jc(_$hash, config.hashCode);
    _$hash = $jc(_$hash, errorHandling.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WorkflowNodeResponse')
          ..add('id', id)
          ..add('type', type)
          ..add('typeDescription', typeDescription)
          ..add('name', name)
          ..add('position', position)
          ..add('config', config)
          ..add('errorHandling', errorHandling))
        .toString();
  }
}

class WorkflowNodeResponseBuilder
    implements Builder<WorkflowNodeResponse, WorkflowNodeResponseBuilder> {
  _$WorkflowNodeResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _typeDescription;
  String? get typeDescription => _$this._typeDescription;
  set typeDescription(String? typeDescription) =>
      _$this._typeDescription = typeDescription;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  PositionDTOBuilder? _position;
  PositionDTOBuilder get position => _$this._position ??= PositionDTOBuilder();
  set position(PositionDTOBuilder? position) => _$this._position = position;

  MapBuilder<String, JsonObject>? _config;
  MapBuilder<String, JsonObject> get config =>
      _$this._config ??= MapBuilder<String, JsonObject>();
  set config(MapBuilder<String, JsonObject>? config) => _$this._config = config;

  ErrorHandlingConfigDTOBuilder? _errorHandling;
  ErrorHandlingConfigDTOBuilder get errorHandling =>
      _$this._errorHandling ??= ErrorHandlingConfigDTOBuilder();
  set errorHandling(ErrorHandlingConfigDTOBuilder? errorHandling) =>
      _$this._errorHandling = errorHandling;

  WorkflowNodeResponseBuilder() {
    WorkflowNodeResponse._defaults(this);
  }

  WorkflowNodeResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _type = $v.type;
      _typeDescription = $v.typeDescription;
      _name = $v.name;
      _position = $v.position?.toBuilder();
      _config = $v.config?.toBuilder();
      _errorHandling = $v.errorHandling?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkflowNodeResponse other) {
    _$v = other as _$WorkflowNodeResponse;
  }

  @override
  void update(void Function(WorkflowNodeResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WorkflowNodeResponse build() => _build();

  _$WorkflowNodeResponse _build() {
    _$WorkflowNodeResponse _$result;
    try {
      _$result =
          _$v ??
          _$WorkflowNodeResponse._(
            id: id,
            type: type,
            typeDescription: typeDescription,
            name: name,
            position: _position?.build(),
            config: _config?.build(),
            errorHandling: _errorHandling?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'position';
        _position?.build();
        _$failedField = 'config';
        _config?.build();
        _$failedField = 'errorHandling';
        _errorHandling?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'WorkflowNodeResponse',
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
