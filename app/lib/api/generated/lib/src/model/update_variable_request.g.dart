// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_variable_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateVariableRequestTypeEnum _$updateVariableRequestTypeEnum_string =
    const UpdateVariableRequestTypeEnum._('string');
const UpdateVariableRequestTypeEnum _$updateVariableRequestTypeEnum_number =
    const UpdateVariableRequestTypeEnum._('number');
const UpdateVariableRequestTypeEnum _$updateVariableRequestTypeEnum_boolean =
    const UpdateVariableRequestTypeEnum._('boolean');
const UpdateVariableRequestTypeEnum _$updateVariableRequestTypeEnum_object =
    const UpdateVariableRequestTypeEnum._('object');
const UpdateVariableRequestTypeEnum _$updateVariableRequestTypeEnum_array =
    const UpdateVariableRequestTypeEnum._('array');

UpdateVariableRequestTypeEnum _$updateVariableRequestTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'string':
      return _$updateVariableRequestTypeEnum_string;
    case 'number':
      return _$updateVariableRequestTypeEnum_number;
    case 'boolean':
      return _$updateVariableRequestTypeEnum_boolean;
    case 'object':
      return _$updateVariableRequestTypeEnum_object;
    case 'array':
      return _$updateVariableRequestTypeEnum_array;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateVariableRequestTypeEnum>
_$updateVariableRequestTypeEnumValues = BuiltSet<UpdateVariableRequestTypeEnum>(
  const <UpdateVariableRequestTypeEnum>[
    _$updateVariableRequestTypeEnum_string,
    _$updateVariableRequestTypeEnum_number,
    _$updateVariableRequestTypeEnum_boolean,
    _$updateVariableRequestTypeEnum_object,
    _$updateVariableRequestTypeEnum_array,
  ],
);

Serializer<UpdateVariableRequestTypeEnum>
_$updateVariableRequestTypeEnumSerializer =
    _$UpdateVariableRequestTypeEnumSerializer();

class _$UpdateVariableRequestTypeEnumSerializer
    implements PrimitiveSerializer<UpdateVariableRequestTypeEnum> {
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
  final Iterable<Type> types = const <Type>[UpdateVariableRequestTypeEnum];
  @override
  final String wireName = 'UpdateVariableRequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    UpdateVariableRequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UpdateVariableRequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UpdateVariableRequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UpdateVariableRequest extends UpdateVariableRequest {
  @override
  final UpdateVariableRequestTypeEnum? type;
  @override
  final JsonObject? defaultValue;
  @override
  final String? description;

  factory _$UpdateVariableRequest([
    void Function(UpdateVariableRequestBuilder)? updates,
  ]) => (UpdateVariableRequestBuilder()..update(updates))._build();

  _$UpdateVariableRequest._({this.type, this.defaultValue, this.description})
    : super._();
  @override
  UpdateVariableRequest rebuild(
    void Function(UpdateVariableRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateVariableRequestBuilder toBuilder() =>
      UpdateVariableRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateVariableRequest &&
        type == other.type &&
        defaultValue == other.defaultValue &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, defaultValue.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateVariableRequest')
          ..add('type', type)
          ..add('defaultValue', defaultValue)
          ..add('description', description))
        .toString();
  }
}

class UpdateVariableRequestBuilder
    implements Builder<UpdateVariableRequest, UpdateVariableRequestBuilder> {
  _$UpdateVariableRequest? _$v;

  UpdateVariableRequestTypeEnum? _type;
  UpdateVariableRequestTypeEnum? get type => _$this._type;
  set type(UpdateVariableRequestTypeEnum? type) => _$this._type = type;

  JsonObject? _defaultValue;
  JsonObject? get defaultValue => _$this._defaultValue;
  set defaultValue(JsonObject? defaultValue) =>
      _$this._defaultValue = defaultValue;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  UpdateVariableRequestBuilder() {
    UpdateVariableRequest._defaults(this);
  }

  UpdateVariableRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _defaultValue = $v.defaultValue;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateVariableRequest other) {
    _$v = other as _$UpdateVariableRequest;
  }

  @override
  void update(void Function(UpdateVariableRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateVariableRequest build() => _build();

  _$UpdateVariableRequest _build() {
    final _$result =
        _$v ??
        _$UpdateVariableRequest._(
          type: type,
          defaultValue: defaultValue,
          description: description,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
