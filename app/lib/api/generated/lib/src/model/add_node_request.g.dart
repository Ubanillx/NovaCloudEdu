// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_node_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_START =
    const AddNodeRequestTypeEnum._('START');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_WEBHOOK =
    const AddNodeRequestTypeEnum._('WEBHOOK');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_SCHEDULE =
    const AddNodeRequestTypeEnum._('SCHEDULE');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_LLM =
    const AddNodeRequestTypeEnum._('LLM');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_KNOWLEDGE_RETRIEVAL =
    const AddNodeRequestTypeEnum._('KNOWLEDGE_RETRIEVAL');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_TEXT_EMBEDDING =
    const AddNodeRequestTypeEnum._('TEXT_EMBEDDING');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_INTENT_RECOGNITION =
    const AddNodeRequestTypeEnum._('INTENT_RECOGNITION');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_ENTITY_EXTRACTION =
    const AddNodeRequestTypeEnum._('ENTITY_EXTRACTION');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_CONDITION =
    const AddNodeRequestTypeEnum._('CONDITION');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_SWITCH =
    const AddNodeRequestTypeEnum._('SWITCH');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_LOOP =
    const AddNodeRequestTypeEnum._('LOOP');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_LOOP_START =
    const AddNodeRequestTypeEnum._('LOOP_START');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_LOOP_END =
    const AddNodeRequestTypeEnum._('LOOP_END');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_PARALLEL =
    const AddNodeRequestTypeEnum._('PARALLEL');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_MERGE =
    const AddNodeRequestTypeEnum._('MERGE');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_VARIABLE_SET =
    const AddNodeRequestTypeEnum._('VARIABLE_SET');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_VARIABLE_GET =
    const AddNodeRequestTypeEnum._('VARIABLE_GET');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_JSON_PARSE =
    const AddNodeRequestTypeEnum._('JSON_PARSE');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_TEMPLATE =
    const AddNodeRequestTypeEnum._('TEMPLATE');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_CODE =
    const AddNodeRequestTypeEnum._('CODE');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_HTTP_REQUEST =
    const AddNodeRequestTypeEnum._('HTTP_REQUEST');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_DATABASE_QUERY =
    const AddNodeRequestTypeEnum._('DATABASE_QUERY');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_FILE_READ =
    const AddNodeRequestTypeEnum._('FILE_READ');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_FILE_WRITE =
    const AddNodeRequestTypeEnum._('FILE_WRITE');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_RESPONSE =
    const AddNodeRequestTypeEnum._('RESPONSE');
const AddNodeRequestTypeEnum _$addNodeRequestTypeEnum_END =
    const AddNodeRequestTypeEnum._('END');

AddNodeRequestTypeEnum _$addNodeRequestTypeEnumValueOf(String name) {
  switch (name) {
    case 'START':
      return _$addNodeRequestTypeEnum_START;
    case 'WEBHOOK':
      return _$addNodeRequestTypeEnum_WEBHOOK;
    case 'SCHEDULE':
      return _$addNodeRequestTypeEnum_SCHEDULE;
    case 'LLM':
      return _$addNodeRequestTypeEnum_LLM;
    case 'KNOWLEDGE_RETRIEVAL':
      return _$addNodeRequestTypeEnum_KNOWLEDGE_RETRIEVAL;
    case 'TEXT_EMBEDDING':
      return _$addNodeRequestTypeEnum_TEXT_EMBEDDING;
    case 'INTENT_RECOGNITION':
      return _$addNodeRequestTypeEnum_INTENT_RECOGNITION;
    case 'ENTITY_EXTRACTION':
      return _$addNodeRequestTypeEnum_ENTITY_EXTRACTION;
    case 'CONDITION':
      return _$addNodeRequestTypeEnum_CONDITION;
    case 'SWITCH':
      return _$addNodeRequestTypeEnum_SWITCH;
    case 'LOOP':
      return _$addNodeRequestTypeEnum_LOOP;
    case 'LOOP_START':
      return _$addNodeRequestTypeEnum_LOOP_START;
    case 'LOOP_END':
      return _$addNodeRequestTypeEnum_LOOP_END;
    case 'PARALLEL':
      return _$addNodeRequestTypeEnum_PARALLEL;
    case 'MERGE':
      return _$addNodeRequestTypeEnum_MERGE;
    case 'VARIABLE_SET':
      return _$addNodeRequestTypeEnum_VARIABLE_SET;
    case 'VARIABLE_GET':
      return _$addNodeRequestTypeEnum_VARIABLE_GET;
    case 'JSON_PARSE':
      return _$addNodeRequestTypeEnum_JSON_PARSE;
    case 'TEMPLATE':
      return _$addNodeRequestTypeEnum_TEMPLATE;
    case 'CODE':
      return _$addNodeRequestTypeEnum_CODE;
    case 'HTTP_REQUEST':
      return _$addNodeRequestTypeEnum_HTTP_REQUEST;
    case 'DATABASE_QUERY':
      return _$addNodeRequestTypeEnum_DATABASE_QUERY;
    case 'FILE_READ':
      return _$addNodeRequestTypeEnum_FILE_READ;
    case 'FILE_WRITE':
      return _$addNodeRequestTypeEnum_FILE_WRITE;
    case 'RESPONSE':
      return _$addNodeRequestTypeEnum_RESPONSE;
    case 'END':
      return _$addNodeRequestTypeEnum_END;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AddNodeRequestTypeEnum> _$addNodeRequestTypeEnumValues =
    BuiltSet<AddNodeRequestTypeEnum>(const <AddNodeRequestTypeEnum>[
      _$addNodeRequestTypeEnum_START,
      _$addNodeRequestTypeEnum_WEBHOOK,
      _$addNodeRequestTypeEnum_SCHEDULE,
      _$addNodeRequestTypeEnum_LLM,
      _$addNodeRequestTypeEnum_KNOWLEDGE_RETRIEVAL,
      _$addNodeRequestTypeEnum_TEXT_EMBEDDING,
      _$addNodeRequestTypeEnum_INTENT_RECOGNITION,
      _$addNodeRequestTypeEnum_ENTITY_EXTRACTION,
      _$addNodeRequestTypeEnum_CONDITION,
      _$addNodeRequestTypeEnum_SWITCH,
      _$addNodeRequestTypeEnum_LOOP,
      _$addNodeRequestTypeEnum_LOOP_START,
      _$addNodeRequestTypeEnum_LOOP_END,
      _$addNodeRequestTypeEnum_PARALLEL,
      _$addNodeRequestTypeEnum_MERGE,
      _$addNodeRequestTypeEnum_VARIABLE_SET,
      _$addNodeRequestTypeEnum_VARIABLE_GET,
      _$addNodeRequestTypeEnum_JSON_PARSE,
      _$addNodeRequestTypeEnum_TEMPLATE,
      _$addNodeRequestTypeEnum_CODE,
      _$addNodeRequestTypeEnum_HTTP_REQUEST,
      _$addNodeRequestTypeEnum_DATABASE_QUERY,
      _$addNodeRequestTypeEnum_FILE_READ,
      _$addNodeRequestTypeEnum_FILE_WRITE,
      _$addNodeRequestTypeEnum_RESPONSE,
      _$addNodeRequestTypeEnum_END,
    ]);

Serializer<AddNodeRequestTypeEnum> _$addNodeRequestTypeEnumSerializer =
    _$AddNodeRequestTypeEnumSerializer();

class _$AddNodeRequestTypeEnumSerializer
    implements PrimitiveSerializer<AddNodeRequestTypeEnum> {
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
  final Iterable<Type> types = const <Type>[AddNodeRequestTypeEnum];
  @override
  final String wireName = 'AddNodeRequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AddNodeRequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AddNodeRequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AddNodeRequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AddNodeRequest extends AddNodeRequest {
  @override
  final String nodeId;
  @override
  final AddNodeRequestTypeEnum type;
  @override
  final String name;
  @override
  final int? positionX;
  @override
  final int? positionY;
  @override
  final BuiltMap<String, JsonObject>? config;
  @override
  final ErrorHandlingConfigDTO? errorHandling;

  factory _$AddNodeRequest([void Function(AddNodeRequestBuilder)? updates]) =>
      (AddNodeRequestBuilder()..update(updates))._build();

  _$AddNodeRequest._({
    required this.nodeId,
    required this.type,
    required this.name,
    this.positionX,
    this.positionY,
    this.config,
    this.errorHandling,
  }) : super._();
  @override
  AddNodeRequest rebuild(void Function(AddNodeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddNodeRequestBuilder toBuilder() => AddNodeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddNodeRequest &&
        nodeId == other.nodeId &&
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
    _$hash = $jc(_$hash, nodeId.hashCode);
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
    return (newBuiltValueToStringHelper(r'AddNodeRequest')
          ..add('nodeId', nodeId)
          ..add('type', type)
          ..add('name', name)
          ..add('positionX', positionX)
          ..add('positionY', positionY)
          ..add('config', config)
          ..add('errorHandling', errorHandling))
        .toString();
  }
}

class AddNodeRequestBuilder
    implements Builder<AddNodeRequest, AddNodeRequestBuilder> {
  _$AddNodeRequest? _$v;

  String? _nodeId;
  String? get nodeId => _$this._nodeId;
  set nodeId(String? nodeId) => _$this._nodeId = nodeId;

  AddNodeRequestTypeEnum? _type;
  AddNodeRequestTypeEnum? get type => _$this._type;
  set type(AddNodeRequestTypeEnum? type) => _$this._type = type;

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

  AddNodeRequestBuilder() {
    AddNodeRequest._defaults(this);
  }

  AddNodeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _nodeId = $v.nodeId;
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
  void replace(AddNodeRequest other) {
    _$v = other as _$AddNodeRequest;
  }

  @override
  void update(void Function(AddNodeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddNodeRequest build() => _build();

  _$AddNodeRequest _build() {
    _$AddNodeRequest _$result;
    try {
      _$result =
          _$v ??
          _$AddNodeRequest._(
            nodeId: BuiltValueNullFieldError.checkNotNull(
              nodeId,
              r'AddNodeRequest',
              'nodeId',
            ),
            type: BuiltValueNullFieldError.checkNotNull(
              type,
              r'AddNodeRequest',
              'type',
            ),
            name: BuiltValueNullFieldError.checkNotNull(
              name,
              r'AddNodeRequest',
              'name',
            ),
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
          r'AddNodeRequest',
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
