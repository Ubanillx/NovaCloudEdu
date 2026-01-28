// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_type_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NodeTypeResponse extends NodeTypeResponse {
  @override
  final String? type;
  @override
  final String? description;
  @override
  final String? category;
  @override
  final String? icon;
  @override
  final BuiltList<ConfigFieldDTO>? configFields;

  factory _$NodeTypeResponse([
    void Function(NodeTypeResponseBuilder)? updates,
  ]) => (NodeTypeResponseBuilder()..update(updates))._build();

  _$NodeTypeResponse._({
    this.type,
    this.description,
    this.category,
    this.icon,
    this.configFields,
  }) : super._();
  @override
  NodeTypeResponse rebuild(void Function(NodeTypeResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NodeTypeResponseBuilder toBuilder() =>
      NodeTypeResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NodeTypeResponse &&
        type == other.type &&
        description == other.description &&
        category == other.category &&
        icon == other.icon &&
        configFields == other.configFields;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, configFields.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NodeTypeResponse')
          ..add('type', type)
          ..add('description', description)
          ..add('category', category)
          ..add('icon', icon)
          ..add('configFields', configFields))
        .toString();
  }
}

class NodeTypeResponseBuilder
    implements Builder<NodeTypeResponse, NodeTypeResponseBuilder> {
  _$NodeTypeResponse? _$v;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  ListBuilder<ConfigFieldDTO>? _configFields;
  ListBuilder<ConfigFieldDTO> get configFields =>
      _$this._configFields ??= ListBuilder<ConfigFieldDTO>();
  set configFields(ListBuilder<ConfigFieldDTO>? configFields) =>
      _$this._configFields = configFields;

  NodeTypeResponseBuilder() {
    NodeTypeResponse._defaults(this);
  }

  NodeTypeResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _description = $v.description;
      _category = $v.category;
      _icon = $v.icon;
      _configFields = $v.configFields?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NodeTypeResponse other) {
    _$v = other as _$NodeTypeResponse;
  }

  @override
  void update(void Function(NodeTypeResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NodeTypeResponse build() => _build();

  _$NodeTypeResponse _build() {
    _$NodeTypeResponse _$result;
    try {
      _$result =
          _$v ??
          _$NodeTypeResponse._(
            type: type,
            description: description,
            category: category,
            icon: icon,
            configFields: _configFields?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'configFields';
        _configFields?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'NodeTypeResponse',
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
