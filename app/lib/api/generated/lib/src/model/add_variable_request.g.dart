// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_variable_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AddVariableRequestTypeEnum _$addVariableRequestTypeEnum_string =
    const AddVariableRequestTypeEnum._('string');
const AddVariableRequestTypeEnum _$addVariableRequestTypeEnum_number =
    const AddVariableRequestTypeEnum._('number');
const AddVariableRequestTypeEnum _$addVariableRequestTypeEnum_boolean =
    const AddVariableRequestTypeEnum._('boolean');
const AddVariableRequestTypeEnum _$addVariableRequestTypeEnum_object =
    const AddVariableRequestTypeEnum._('object');
const AddVariableRequestTypeEnum _$addVariableRequestTypeEnum_array =
    const AddVariableRequestTypeEnum._('array');

AddVariableRequestTypeEnum _$addVariableRequestTypeEnumValueOf(String name) {
  switch (name) {
    case 'string':
      return _$addVariableRequestTypeEnum_string;
    case 'number':
      return _$addVariableRequestTypeEnum_number;
    case 'boolean':
      return _$addVariableRequestTypeEnum_boolean;
    case 'object':
      return _$addVariableRequestTypeEnum_object;
    case 'array':
      return _$addVariableRequestTypeEnum_array;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AddVariableRequestTypeEnum> _$addVariableRequestTypeEnumValues =
    BuiltSet<AddVariableRequestTypeEnum>(const <AddVariableRequestTypeEnum>[
      _$addVariableRequestTypeEnum_string,
      _$addVariableRequestTypeEnum_number,
      _$addVariableRequestTypeEnum_boolean,
      _$addVariableRequestTypeEnum_object,
      _$addVariableRequestTypeEnum_array,
    ]);

Serializer<AddVariableRequestTypeEnum> _$addVariableRequestTypeEnumSerializer =
    _$AddVariableRequestTypeEnumSerializer();

class _$AddVariableRequestTypeEnumSerializer
    implements PrimitiveSerializer<AddVariableRequestTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'string': 'string',
    'number': 'number',
    'boolean': 'boolean',
    'object': 'object',
    'array': 'array',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'string': 'string',
    'number': 'number',
    'boolean': 'boolean',
    'object': 'object',
    'array': 'array',
  };

  @override
  final Iterable<Type> types = const <Type>[AddVariableRequestTypeEnum];
  @override
  final String wireName = 'AddVariableRequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AddVariableRequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AddVariableRequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AddVariableRequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AddVariableRequest extends AddVariableRequest {
  @override
  final String name;
  @override
  final AddVariableRequestTypeEnum type;
  @override
  final JsonObject? defaultValue;
  @override
  final String? description;

  factory _$AddVariableRequest([
    void Function(AddVariableRequestBuilder)? updates,
  ]) => (AddVariableRequestBuilder()..update(updates))._build();

  _$AddVariableRequest._({
    required this.name,
    required this.type,
    this.defaultValue,
    this.description,
  }) : super._();
  @override
  AddVariableRequest rebuild(
    void Function(AddVariableRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AddVariableRequestBuilder toBuilder() =>
      AddVariableRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddVariableRequest &&
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
    return (newBuiltValueToStringHelper(r'AddVariableRequest')
          ..add('name', name)
          ..add('type', type)
          ..add('defaultValue', defaultValue)
          ..add('description', description))
        .toString();
  }
}

class AddVariableRequestBuilder
    implements Builder<AddVariableRequest, AddVariableRequestBuilder> {
  _$AddVariableRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  AddVariableRequestTypeEnum? _type;
  AddVariableRequestTypeEnum? get type => _$this._type;
  set type(AddVariableRequestTypeEnum? type) => _$this._type = type;

  JsonObject? _defaultValue;
  JsonObject? get defaultValue => _$this._defaultValue;
  set defaultValue(JsonObject? defaultValue) =>
      _$this._defaultValue = defaultValue;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  AddVariableRequestBuilder() {
    AddVariableRequest._defaults(this);
  }

  AddVariableRequestBuilder get _$this {
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
  void replace(AddVariableRequest other) {
    _$v = other as _$AddVariableRequest;
  }

  @override
  void update(void Function(AddVariableRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddVariableRequest build() => _build();

  _$AddVariableRequest _build() {
    final _$result =
        _$v ??
        _$AddVariableRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'AddVariableRequest',
            'name',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'AddVariableRequest',
            'type',
          ),
          defaultValue: defaultValue,
          description: description,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
