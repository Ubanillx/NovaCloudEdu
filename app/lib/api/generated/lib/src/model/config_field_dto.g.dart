// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_field_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ConfigFieldDTOFieldTypeEnum _$configFieldDTOFieldTypeEnum_text =
    const ConfigFieldDTOFieldTypeEnum._('text');
const ConfigFieldDTOFieldTypeEnum _$configFieldDTOFieldTypeEnum_textarea =
    const ConfigFieldDTOFieldTypeEnum._('textarea');
const ConfigFieldDTOFieldTypeEnum _$configFieldDTOFieldTypeEnum_number =
    const ConfigFieldDTOFieldTypeEnum._('number');
const ConfigFieldDTOFieldTypeEnum _$configFieldDTOFieldTypeEnum_select =
    const ConfigFieldDTOFieldTypeEnum._('select');
const ConfigFieldDTOFieldTypeEnum _$configFieldDTOFieldTypeEnum_boolean =
    const ConfigFieldDTOFieldTypeEnum._('boolean');
const ConfigFieldDTOFieldTypeEnum _$configFieldDTOFieldTypeEnum_json =
    const ConfigFieldDTOFieldTypeEnum._('json');

ConfigFieldDTOFieldTypeEnum _$configFieldDTOFieldTypeEnumValueOf(String name) {
  switch (name) {
    case 'text':
      return _$configFieldDTOFieldTypeEnum_text;
    case 'textarea':
      return _$configFieldDTOFieldTypeEnum_textarea;
    case 'number':
      return _$configFieldDTOFieldTypeEnum_number;
    case 'select':
      return _$configFieldDTOFieldTypeEnum_select;
    case 'boolean':
      return _$configFieldDTOFieldTypeEnum_boolean;
    case 'json':
      return _$configFieldDTOFieldTypeEnum_json;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ConfigFieldDTOFieldTypeEnum>
_$configFieldDTOFieldTypeEnumValues =
    BuiltSet<ConfigFieldDTOFieldTypeEnum>(const <ConfigFieldDTOFieldTypeEnum>[
      _$configFieldDTOFieldTypeEnum_text,
      _$configFieldDTOFieldTypeEnum_textarea,
      _$configFieldDTOFieldTypeEnum_number,
      _$configFieldDTOFieldTypeEnum_select,
      _$configFieldDTOFieldTypeEnum_boolean,
      _$configFieldDTOFieldTypeEnum_json,
    ]);

Serializer<ConfigFieldDTOFieldTypeEnum>
_$configFieldDTOFieldTypeEnumSerializer =
    _$ConfigFieldDTOFieldTypeEnumSerializer();

class _$ConfigFieldDTOFieldTypeEnumSerializer
    implements PrimitiveSerializer<ConfigFieldDTOFieldTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'text': 'text',
    'textarea': 'textarea',
    'number': 'number',
    'select': 'select',
    'boolean': 'boolean',
    'json': 'json',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'text': 'text',
    'textarea': 'textarea',
    'number': 'number',
    'select': 'select',
    'boolean': 'boolean',
    'json': 'json',
  };

  @override
  final Iterable<Type> types = const <Type>[ConfigFieldDTOFieldTypeEnum];
  @override
  final String wireName = 'ConfigFieldDTOFieldTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    ConfigFieldDTOFieldTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ConfigFieldDTOFieldTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ConfigFieldDTOFieldTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ConfigFieldDTO extends ConfigFieldDTO {
  @override
  final String? name;
  @override
  final String? label;
  @override
  final ConfigFieldDTOFieldTypeEnum? fieldType;
  @override
  final bool? required_;
  @override
  final JsonObject? defaultValue;
  @override
  final String? description;
  @override
  final BuiltList<OptionDTO>? options;
  @override
  final BuiltMap<String, JsonObject>? validation;

  factory _$ConfigFieldDTO([void Function(ConfigFieldDTOBuilder)? updates]) =>
      (ConfigFieldDTOBuilder()..update(updates))._build();

  _$ConfigFieldDTO._({
    this.name,
    this.label,
    this.fieldType,
    this.required_,
    this.defaultValue,
    this.description,
    this.options,
    this.validation,
  }) : super._();
  @override
  ConfigFieldDTO rebuild(void Function(ConfigFieldDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConfigFieldDTOBuilder toBuilder() => ConfigFieldDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfigFieldDTO &&
        name == other.name &&
        label == other.label &&
        fieldType == other.fieldType &&
        required_ == other.required_ &&
        defaultValue == other.defaultValue &&
        description == other.description &&
        options == other.options &&
        validation == other.validation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, fieldType.hashCode);
    _$hash = $jc(_$hash, required_.hashCode);
    _$hash = $jc(_$hash, defaultValue.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, options.hashCode);
    _$hash = $jc(_$hash, validation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConfigFieldDTO')
          ..add('name', name)
          ..add('label', label)
          ..add('fieldType', fieldType)
          ..add('required_', required_)
          ..add('defaultValue', defaultValue)
          ..add('description', description)
          ..add('options', options)
          ..add('validation', validation))
        .toString();
  }
}

class ConfigFieldDTOBuilder
    implements Builder<ConfigFieldDTO, ConfigFieldDTOBuilder> {
  _$ConfigFieldDTO? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  ConfigFieldDTOFieldTypeEnum? _fieldType;
  ConfigFieldDTOFieldTypeEnum? get fieldType => _$this._fieldType;
  set fieldType(ConfigFieldDTOFieldTypeEnum? fieldType) =>
      _$this._fieldType = fieldType;

  bool? _required_;
  bool? get required_ => _$this._required_;
  set required_(bool? required_) => _$this._required_ = required_;

  JsonObject? _defaultValue;
  JsonObject? get defaultValue => _$this._defaultValue;
  set defaultValue(JsonObject? defaultValue) =>
      _$this._defaultValue = defaultValue;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ListBuilder<OptionDTO>? _options;
  ListBuilder<OptionDTO> get options =>
      _$this._options ??= ListBuilder<OptionDTO>();
  set options(ListBuilder<OptionDTO>? options) => _$this._options = options;

  MapBuilder<String, JsonObject>? _validation;
  MapBuilder<String, JsonObject> get validation =>
      _$this._validation ??= MapBuilder<String, JsonObject>();
  set validation(MapBuilder<String, JsonObject>? validation) =>
      _$this._validation = validation;

  ConfigFieldDTOBuilder() {
    ConfigFieldDTO._defaults(this);
  }

  ConfigFieldDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _label = $v.label;
      _fieldType = $v.fieldType;
      _required_ = $v.required_;
      _defaultValue = $v.defaultValue;
      _description = $v.description;
      _options = $v.options?.toBuilder();
      _validation = $v.validation?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfigFieldDTO other) {
    _$v = other as _$ConfigFieldDTO;
  }

  @override
  void update(void Function(ConfigFieldDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConfigFieldDTO build() => _build();

  _$ConfigFieldDTO _build() {
    _$ConfigFieldDTO _$result;
    try {
      _$result =
          _$v ??
          _$ConfigFieldDTO._(
            name: name,
            label: label,
            fieldType: fieldType,
            required_: required_,
            defaultValue: defaultValue,
            description: description,
            options: _options?.build(),
            validation: _validation?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'options';
        _options?.build();
        _$failedField = 'validation';
        _validation?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ConfigFieldDTO',
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
