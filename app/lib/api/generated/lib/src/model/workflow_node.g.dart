// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_node.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_START =
    const WorkflowNodeTypeEnum._('START');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_WEBHOOK =
    const WorkflowNodeTypeEnum._('WEBHOOK');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_SCHEDULE =
    const WorkflowNodeTypeEnum._('SCHEDULE');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_LLM =
    const WorkflowNodeTypeEnum._('LLM');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_KNOWLEDGE_RETRIEVAL =
    const WorkflowNodeTypeEnum._('KNOWLEDGE_RETRIEVAL');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_TEXT_EMBEDDING =
    const WorkflowNodeTypeEnum._('TEXT_EMBEDDING');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_INTENT_RECOGNITION =
    const WorkflowNodeTypeEnum._('INTENT_RECOGNITION');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_ENTITY_EXTRACTION =
    const WorkflowNodeTypeEnum._('ENTITY_EXTRACTION');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_CONDITION =
    const WorkflowNodeTypeEnum._('CONDITION');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_SWITCH =
    const WorkflowNodeTypeEnum._('SWITCH');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_LOOP =
    const WorkflowNodeTypeEnum._('LOOP');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_PARALLEL =
    const WorkflowNodeTypeEnum._('PARALLEL');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_MERGE =
    const WorkflowNodeTypeEnum._('MERGE');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_VARIABLE_SET =
    const WorkflowNodeTypeEnum._('VARIABLE_SET');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_VARIABLE_GET =
    const WorkflowNodeTypeEnum._('VARIABLE_GET');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_JSON_PARSE =
    const WorkflowNodeTypeEnum._('JSON_PARSE');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_TEMPLATE =
    const WorkflowNodeTypeEnum._('TEMPLATE');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_CODE =
    const WorkflowNodeTypeEnum._('CODE');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_HTTP_REQUEST =
    const WorkflowNodeTypeEnum._('HTTP_REQUEST');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_DATABASE_QUERY =
    const WorkflowNodeTypeEnum._('DATABASE_QUERY');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_FILE_READ =
    const WorkflowNodeTypeEnum._('FILE_READ');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_FILE_WRITE =
    const WorkflowNodeTypeEnum._('FILE_WRITE');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_RESPONSE =
    const WorkflowNodeTypeEnum._('RESPONSE');
const WorkflowNodeTypeEnum _$workflowNodeTypeEnum_END =
    const WorkflowNodeTypeEnum._('END');

WorkflowNodeTypeEnum _$workflowNodeTypeEnumValueOf(String name) {
  switch (name) {
    case 'START':
      return _$workflowNodeTypeEnum_START;
    case 'WEBHOOK':
      return _$workflowNodeTypeEnum_WEBHOOK;
    case 'SCHEDULE':
      return _$workflowNodeTypeEnum_SCHEDULE;
    case 'LLM':
      return _$workflowNodeTypeEnum_LLM;
    case 'KNOWLEDGE_RETRIEVAL':
      return _$workflowNodeTypeEnum_KNOWLEDGE_RETRIEVAL;
    case 'TEXT_EMBEDDING':
      return _$workflowNodeTypeEnum_TEXT_EMBEDDING;
    case 'INTENT_RECOGNITION':
      return _$workflowNodeTypeEnum_INTENT_RECOGNITION;
    case 'ENTITY_EXTRACTION':
      return _$workflowNodeTypeEnum_ENTITY_EXTRACTION;
    case 'CONDITION':
      return _$workflowNodeTypeEnum_CONDITION;
    case 'SWITCH':
      return _$workflowNodeTypeEnum_SWITCH;
    case 'LOOP':
      return _$workflowNodeTypeEnum_LOOP;
    case 'PARALLEL':
      return _$workflowNodeTypeEnum_PARALLEL;
    case 'MERGE':
      return _$workflowNodeTypeEnum_MERGE;
    case 'VARIABLE_SET':
      return _$workflowNodeTypeEnum_VARIABLE_SET;
    case 'VARIABLE_GET':
      return _$workflowNodeTypeEnum_VARIABLE_GET;
    case 'JSON_PARSE':
      return _$workflowNodeTypeEnum_JSON_PARSE;
    case 'TEMPLATE':
      return _$workflowNodeTypeEnum_TEMPLATE;
    case 'CODE':
      return _$workflowNodeTypeEnum_CODE;
    case 'HTTP_REQUEST':
      return _$workflowNodeTypeEnum_HTTP_REQUEST;
    case 'DATABASE_QUERY':
      return _$workflowNodeTypeEnum_DATABASE_QUERY;
    case 'FILE_READ':
      return _$workflowNodeTypeEnum_FILE_READ;
    case 'FILE_WRITE':
      return _$workflowNodeTypeEnum_FILE_WRITE;
    case 'RESPONSE':
      return _$workflowNodeTypeEnum_RESPONSE;
    case 'END':
      return _$workflowNodeTypeEnum_END;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<WorkflowNodeTypeEnum> _$workflowNodeTypeEnumValues =
    BuiltSet<WorkflowNodeTypeEnum>(const <WorkflowNodeTypeEnum>[
      _$workflowNodeTypeEnum_START,
      _$workflowNodeTypeEnum_WEBHOOK,
      _$workflowNodeTypeEnum_SCHEDULE,
      _$workflowNodeTypeEnum_LLM,
      _$workflowNodeTypeEnum_KNOWLEDGE_RETRIEVAL,
      _$workflowNodeTypeEnum_TEXT_EMBEDDING,
      _$workflowNodeTypeEnum_INTENT_RECOGNITION,
      _$workflowNodeTypeEnum_ENTITY_EXTRACTION,
      _$workflowNodeTypeEnum_CONDITION,
      _$workflowNodeTypeEnum_SWITCH,
      _$workflowNodeTypeEnum_LOOP,
      _$workflowNodeTypeEnum_PARALLEL,
      _$workflowNodeTypeEnum_MERGE,
      _$workflowNodeTypeEnum_VARIABLE_SET,
      _$workflowNodeTypeEnum_VARIABLE_GET,
      _$workflowNodeTypeEnum_JSON_PARSE,
      _$workflowNodeTypeEnum_TEMPLATE,
      _$workflowNodeTypeEnum_CODE,
      _$workflowNodeTypeEnum_HTTP_REQUEST,
      _$workflowNodeTypeEnum_DATABASE_QUERY,
      _$workflowNodeTypeEnum_FILE_READ,
      _$workflowNodeTypeEnum_FILE_WRITE,
      _$workflowNodeTypeEnum_RESPONSE,
      _$workflowNodeTypeEnum_END,
    ]);

Serializer<WorkflowNodeTypeEnum> _$workflowNodeTypeEnumSerializer =
    _$WorkflowNodeTypeEnumSerializer();

class _$WorkflowNodeTypeEnumSerializer
    implements PrimitiveSerializer<WorkflowNodeTypeEnum> {
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
  final Iterable<Type> types = const <Type>[WorkflowNodeTypeEnum];
  @override
  final String wireName = 'WorkflowNodeTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    WorkflowNodeTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  WorkflowNodeTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => WorkflowNodeTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$WorkflowNode extends WorkflowNode {
  @override
  final String? id;
  @override
  final WorkflowNodeTypeEnum? type;
  @override
  final String? name;
  @override
  final Position? position;
  @override
  final BuiltMap<String, JsonObject>? config;
  @override
  final ErrorHandlingConfig? errorHandling;

  factory _$WorkflowNode([void Function(WorkflowNodeBuilder)? updates]) =>
      (WorkflowNodeBuilder()..update(updates))._build();

  _$WorkflowNode._({
    this.id,
    this.type,
    this.name,
    this.position,
    this.config,
    this.errorHandling,
  }) : super._();
  @override
  WorkflowNode rebuild(void Function(WorkflowNodeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WorkflowNodeBuilder toBuilder() => WorkflowNodeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkflowNode &&
        id == other.id &&
        type == other.type &&
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
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, position.hashCode);
    _$hash = $jc(_$hash, config.hashCode);
    _$hash = $jc(_$hash, errorHandling.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WorkflowNode')
          ..add('id', id)
          ..add('type', type)
          ..add('name', name)
          ..add('position', position)
          ..add('config', config)
          ..add('errorHandling', errorHandling))
        .toString();
  }
}

class WorkflowNodeBuilder
    implements Builder<WorkflowNode, WorkflowNodeBuilder> {
  _$WorkflowNode? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  WorkflowNodeTypeEnum? _type;
  WorkflowNodeTypeEnum? get type => _$this._type;
  set type(WorkflowNodeTypeEnum? type) => _$this._type = type;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  PositionBuilder? _position;
  PositionBuilder get position => _$this._position ??= PositionBuilder();
  set position(PositionBuilder? position) => _$this._position = position;

  MapBuilder<String, JsonObject>? _config;
  MapBuilder<String, JsonObject> get config =>
      _$this._config ??= MapBuilder<String, JsonObject>();
  set config(MapBuilder<String, JsonObject>? config) => _$this._config = config;

  ErrorHandlingConfigBuilder? _errorHandling;
  ErrorHandlingConfigBuilder get errorHandling =>
      _$this._errorHandling ??= ErrorHandlingConfigBuilder();
  set errorHandling(ErrorHandlingConfigBuilder? errorHandling) =>
      _$this._errorHandling = errorHandling;

  WorkflowNodeBuilder() {
    WorkflowNode._defaults(this);
  }

  WorkflowNodeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _type = $v.type;
      _name = $v.name;
      _position = $v.position?.toBuilder();
      _config = $v.config?.toBuilder();
      _errorHandling = $v.errorHandling?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkflowNode other) {
    _$v = other as _$WorkflowNode;
  }

  @override
  void update(void Function(WorkflowNodeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WorkflowNode build() => _build();

  _$WorkflowNode _build() {
    _$WorkflowNode _$result;
    try {
      _$result =
          _$v ??
          _$WorkflowNode._(
            id: id,
            type: type,
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
          r'WorkflowNode',
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
