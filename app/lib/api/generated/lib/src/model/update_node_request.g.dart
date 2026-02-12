// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_node_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_START =
    const UpdateNodeRequestTypeEnum._('START');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_WEBHOOK =
    const UpdateNodeRequestTypeEnum._('WEBHOOK');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_SCHEDULE =
    const UpdateNodeRequestTypeEnum._('SCHEDULE');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_LLM =
    const UpdateNodeRequestTypeEnum._('LLM');
const UpdateNodeRequestTypeEnum
_$updateNodeRequestTypeEnum_KNOWLEDGE_RETRIEVAL =
    const UpdateNodeRequestTypeEnum._('KNOWLEDGE_RETRIEVAL');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_TEXT_EMBEDDING =
    const UpdateNodeRequestTypeEnum._('TEXT_EMBEDDING');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_INTENT_RECOGNITION =
    const UpdateNodeRequestTypeEnum._('INTENT_RECOGNITION');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_ENTITY_EXTRACTION =
    const UpdateNodeRequestTypeEnum._('ENTITY_EXTRACTION');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_CONDITION =
    const UpdateNodeRequestTypeEnum._('CONDITION');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_SWITCH =
    const UpdateNodeRequestTypeEnum._('SWITCH');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_LOOP =
    const UpdateNodeRequestTypeEnum._('LOOP');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_LOOP_START =
    const UpdateNodeRequestTypeEnum._('LOOP_START');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_LOOP_END =
    const UpdateNodeRequestTypeEnum._('LOOP_END');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_PARALLEL =
    const UpdateNodeRequestTypeEnum._('PARALLEL');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_MERGE =
    const UpdateNodeRequestTypeEnum._('MERGE');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_VARIABLE_SET =
    const UpdateNodeRequestTypeEnum._('VARIABLE_SET');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_VARIABLE_GET =
    const UpdateNodeRequestTypeEnum._('VARIABLE_GET');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_JSON_PARSE =
    const UpdateNodeRequestTypeEnum._('JSON_PARSE');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_TEMPLATE =
    const UpdateNodeRequestTypeEnum._('TEMPLATE');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_CODE =
    const UpdateNodeRequestTypeEnum._('CODE');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_HTTP_REQUEST =
    const UpdateNodeRequestTypeEnum._('HTTP_REQUEST');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_DATABASE_QUERY =
    const UpdateNodeRequestTypeEnum._('DATABASE_QUERY');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_FILE_READ =
    const UpdateNodeRequestTypeEnum._('FILE_READ');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_FILE_WRITE =
    const UpdateNodeRequestTypeEnum._('FILE_WRITE');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_RESPONSE =
    const UpdateNodeRequestTypeEnum._('RESPONSE');
const UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnum_END =
    const UpdateNodeRequestTypeEnum._('END');

UpdateNodeRequestTypeEnum _$updateNodeRequestTypeEnumValueOf(String name) {
  switch (name) {
    case 'START':
      return _$updateNodeRequestTypeEnum_START;
    case 'WEBHOOK':
      return _$updateNodeRequestTypeEnum_WEBHOOK;
    case 'SCHEDULE':
      return _$updateNodeRequestTypeEnum_SCHEDULE;
    case 'LLM':
      return _$updateNodeRequestTypeEnum_LLM;
    case 'KNOWLEDGE_RETRIEVAL':
      return _$updateNodeRequestTypeEnum_KNOWLEDGE_RETRIEVAL;
    case 'TEXT_EMBEDDING':
      return _$updateNodeRequestTypeEnum_TEXT_EMBEDDING;
    case 'INTENT_RECOGNITION':
      return _$updateNodeRequestTypeEnum_INTENT_RECOGNITION;
    case 'ENTITY_EXTRACTION':
      return _$updateNodeRequestTypeEnum_ENTITY_EXTRACTION;
    case 'CONDITION':
      return _$updateNodeRequestTypeEnum_CONDITION;
    case 'SWITCH':
      return _$updateNodeRequestTypeEnum_SWITCH;
    case 'LOOP':
      return _$updateNodeRequestTypeEnum_LOOP;
    case 'LOOP_START':
      return _$updateNodeRequestTypeEnum_LOOP_START;
    case 'LOOP_END':
      return _$updateNodeRequestTypeEnum_LOOP_END;
    case 'PARALLEL':
      return _$updateNodeRequestTypeEnum_PARALLEL;
    case 'MERGE':
      return _$updateNodeRequestTypeEnum_MERGE;
    case 'VARIABLE_SET':
      return _$updateNodeRequestTypeEnum_VARIABLE_SET;
    case 'VARIABLE_GET':
      return _$updateNodeRequestTypeEnum_VARIABLE_GET;
    case 'JSON_PARSE':
      return _$updateNodeRequestTypeEnum_JSON_PARSE;
    case 'TEMPLATE':
      return _$updateNodeRequestTypeEnum_TEMPLATE;
    case 'CODE':
      return _$updateNodeRequestTypeEnum_CODE;
    case 'HTTP_REQUEST':
      return _$updateNodeRequestTypeEnum_HTTP_REQUEST;
    case 'DATABASE_QUERY':
      return _$updateNodeRequestTypeEnum_DATABASE_QUERY;
    case 'FILE_READ':
      return _$updateNodeRequestTypeEnum_FILE_READ;
    case 'FILE_WRITE':
      return _$updateNodeRequestTypeEnum_FILE_WRITE;
    case 'RESPONSE':
      return _$updateNodeRequestTypeEnum_RESPONSE;
    case 'END':
      return _$updateNodeRequestTypeEnum_END;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateNodeRequestTypeEnum> _$updateNodeRequestTypeEnumValues =
    BuiltSet<UpdateNodeRequestTypeEnum>(const <UpdateNodeRequestTypeEnum>[
      _$updateNodeRequestTypeEnum_START,
      _$updateNodeRequestTypeEnum_WEBHOOK,
      _$updateNodeRequestTypeEnum_SCHEDULE,
      _$updateNodeRequestTypeEnum_LLM,
      _$updateNodeRequestTypeEnum_KNOWLEDGE_RETRIEVAL,
      _$updateNodeRequestTypeEnum_TEXT_EMBEDDING,
      _$updateNodeRequestTypeEnum_INTENT_RECOGNITION,
      _$updateNodeRequestTypeEnum_ENTITY_EXTRACTION,
      _$updateNodeRequestTypeEnum_CONDITION,
      _$updateNodeRequestTypeEnum_SWITCH,
      _$updateNodeRequestTypeEnum_LOOP,
      _$updateNodeRequestTypeEnum_LOOP_START,
      _$updateNodeRequestTypeEnum_LOOP_END,
      _$updateNodeRequestTypeEnum_PARALLEL,
      _$updateNodeRequestTypeEnum_MERGE,
      _$updateNodeRequestTypeEnum_VARIABLE_SET,
      _$updateNodeRequestTypeEnum_VARIABLE_GET,
      _$updateNodeRequestTypeEnum_JSON_PARSE,
      _$updateNodeRequestTypeEnum_TEMPLATE,
      _$updateNodeRequestTypeEnum_CODE,
      _$updateNodeRequestTypeEnum_HTTP_REQUEST,
      _$updateNodeRequestTypeEnum_DATABASE_QUERY,
      _$updateNodeRequestTypeEnum_FILE_READ,
      _$updateNodeRequestTypeEnum_FILE_WRITE,
      _$updateNodeRequestTypeEnum_RESPONSE,
      _$updateNodeRequestTypeEnum_END,
    ]);

Serializer<UpdateNodeRequestTypeEnum> _$updateNodeRequestTypeEnumSerializer =
    _$UpdateNodeRequestTypeEnumSerializer();

class _$UpdateNodeRequestTypeEnumSerializer
    implements PrimitiveSerializer<UpdateNodeRequestTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'START': 'START',
    'WEBHOOK': 'WEBHOOK',
    'SCHEDULE': 'SCHEDULE',
    'LLM': 'LLM',
    'KNOWLEDGE_RETRIEVAL': 'KNOWLEDGE_RETRIEVAL',
    'TEXT_EMBEDDING': 'TEXT_EMBEDDING',
    'INTENT_RECOGNITION': 'INTENT_RECOGNITION',
    'ENTITY_EXTRACTION': 'ENTITY_EXTRACTION',
    'CONDITION': 'CONDITION',
    'SWITCH': 'SWITCH',
    'LOOP': 'LOOP',
    'LOOP_START': 'LOOP_START',
    'LOOP_END': 'LOOP_END',
    'PARALLEL': 'PARALLEL',
    'MERGE': 'MERGE',
    'VARIABLE_SET': 'VARIABLE_SET',
    'VARIABLE_GET': 'VARIABLE_GET',
    'JSON_PARSE': 'JSON_PARSE',
    'TEMPLATE': 'TEMPLATE',
    'CODE': 'CODE',
    'HTTP_REQUEST': 'HTTP_REQUEST',
    'DATABASE_QUERY': 'DATABASE_QUERY',
    'FILE_READ': 'FILE_READ',
    'FILE_WRITE': 'FILE_WRITE',
    'RESPONSE': 'RESPONSE',
    'END': 'END',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'START': 'START',
    'WEBHOOK': 'WEBHOOK',
    'SCHEDULE': 'SCHEDULE',
    'LLM': 'LLM',
    'KNOWLEDGE_RETRIEVAL': 'KNOWLEDGE_RETRIEVAL',
    'TEXT_EMBEDDING': 'TEXT_EMBEDDING',
    'INTENT_RECOGNITION': 'INTENT_RECOGNITION',
    'ENTITY_EXTRACTION': 'ENTITY_EXTRACTION',
    'CONDITION': 'CONDITION',
    'SWITCH': 'SWITCH',
    'LOOP': 'LOOP',
    'LOOP_START': 'LOOP_START',
    'LOOP_END': 'LOOP_END',
    'PARALLEL': 'PARALLEL',
    'MERGE': 'MERGE',
    'VARIABLE_SET': 'VARIABLE_SET',
    'VARIABLE_GET': 'VARIABLE_GET',
    'JSON_PARSE': 'JSON_PARSE',
    'TEMPLATE': 'TEMPLATE',
    'CODE': 'CODE',
    'HTTP_REQUEST': 'HTTP_REQUEST',
    'DATABASE_QUERY': 'DATABASE_QUERY',
    'FILE_READ': 'FILE_READ',
    'FILE_WRITE': 'FILE_WRITE',
    'RESPONSE': 'RESPONSE',
    'END': 'END',
  };

  @override
  final Iterable<Type> types = const <Type>[UpdateNodeRequestTypeEnum];
  @override
  final String wireName = 'UpdateNodeRequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    UpdateNodeRequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UpdateNodeRequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UpdateNodeRequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UpdateNodeRequest extends UpdateNodeRequest {
  @override
  final UpdateNodeRequestTypeEnum? type;
  @override
  final String? name;
  @override
  final int? positionX;
  @override
  final int? positionY;
  @override
  final BuiltMap<String, JsonObject>? config;
  @override
  final ErrorHandlingConfigDTO? errorHandling;

  factory _$UpdateNodeRequest([
    void Function(UpdateNodeRequestBuilder)? updates,
  ]) => (UpdateNodeRequestBuilder()..update(updates))._build();

  _$UpdateNodeRequest._({
    this.type,
    this.name,
    this.positionX,
    this.positionY,
    this.config,
    this.errorHandling,
  }) : super._();
  @override
  UpdateNodeRequest rebuild(void Function(UpdateNodeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateNodeRequestBuilder toBuilder() =>
      UpdateNodeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateNodeRequest &&
        type == other.type &&
        name == other.name &&
        positionX == other.positionX &&
        positionY == other.positionY &&
        config == other.config &&
        errorHandling == other.errorHandling;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, positionX.hashCode);
    _$hash = $jc(_$hash, positionY.hashCode);
    _$hash = $jc(_$hash, config.hashCode);
    _$hash = $jc(_$hash, errorHandling.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateNodeRequest')
          ..add('type', type)
          ..add('name', name)
          ..add('positionX', positionX)
          ..add('positionY', positionY)
          ..add('config', config)
          ..add('errorHandling', errorHandling))
        .toString();
  }
}

class UpdateNodeRequestBuilder
    implements Builder<UpdateNodeRequest, UpdateNodeRequestBuilder> {
  _$UpdateNodeRequest? _$v;

  UpdateNodeRequestTypeEnum? _type;
  UpdateNodeRequestTypeEnum? get type => _$this._type;
  set type(UpdateNodeRequestTypeEnum? type) => _$this._type = type;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _positionX;
  int? get positionX => _$this._positionX;
  set positionX(int? positionX) => _$this._positionX = positionX;

  int? _positionY;
  int? get positionY => _$this._positionY;
  set positionY(int? positionY) => _$this._positionY = positionY;

  MapBuilder<String, JsonObject>? _config;
  MapBuilder<String, JsonObject> get config =>
      _$this._config ??= MapBuilder<String, JsonObject>();
  set config(MapBuilder<String, JsonObject>? config) => _$this._config = config;

  ErrorHandlingConfigDTOBuilder? _errorHandling;
  ErrorHandlingConfigDTOBuilder get errorHandling =>
      _$this._errorHandling ??= ErrorHandlingConfigDTOBuilder();
  set errorHandling(ErrorHandlingConfigDTOBuilder? errorHandling) =>
      _$this._errorHandling = errorHandling;

  UpdateNodeRequestBuilder() {
    UpdateNodeRequest._defaults(this);
  }

  UpdateNodeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _name = $v.name;
      _positionX = $v.positionX;
      _positionY = $v.positionY;
      _config = $v.config?.toBuilder();
      _errorHandling = $v.errorHandling?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateNodeRequest other) {
    _$v = other as _$UpdateNodeRequest;
  }

  @override
  void update(void Function(UpdateNodeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateNodeRequest build() => _build();

  _$UpdateNodeRequest _build() {
    _$UpdateNodeRequest _$result;
    try {
      _$result =
          _$v ??
          _$UpdateNodeRequest._(
            type: type,
            name: name,
            positionX: positionX,
            positionY: positionY,
            config: _config?.build(),
            errorHandling: _errorHandling?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'config';
        _config?.build();
        _$failedField = 'errorHandling';
        _errorHandling?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UpdateNodeRequest',
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
