// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WorkflowResponseStatusEnum _$workflowResponseStatusEnum_DRAFT =
    const WorkflowResponseStatusEnum._('DRAFT');
const WorkflowResponseStatusEnum _$workflowResponseStatusEnum_PUBLISHED =
    const WorkflowResponseStatusEnum._('PUBLISHED');
const WorkflowResponseStatusEnum _$workflowResponseStatusEnum_ARCHIVED =
    const WorkflowResponseStatusEnum._('ARCHIVED');

WorkflowResponseStatusEnum _$workflowResponseStatusEnumValueOf(String name) {
  switch (name) {
    case 'DRAFT':
      return _$workflowResponseStatusEnum_DRAFT;
    case 'PUBLISHED':
      return _$workflowResponseStatusEnum_PUBLISHED;
    case 'ARCHIVED':
      return _$workflowResponseStatusEnum_ARCHIVED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<WorkflowResponseStatusEnum> _$workflowResponseStatusEnumValues =
    BuiltSet<WorkflowResponseStatusEnum>(const <WorkflowResponseStatusEnum>[
      _$workflowResponseStatusEnum_DRAFT,
      _$workflowResponseStatusEnum_PUBLISHED,
      _$workflowResponseStatusEnum_ARCHIVED,
    ]);

Serializer<WorkflowResponseStatusEnum> _$workflowResponseStatusEnumSerializer =
    _$WorkflowResponseStatusEnumSerializer();

class _$WorkflowResponseStatusEnumSerializer
    implements PrimitiveSerializer<WorkflowResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'DRAFT': 'DRAFT',
    'PUBLISHED': 'PUBLISHED',
    'ARCHIVED': 'ARCHIVED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'DRAFT': 'DRAFT',
    'PUBLISHED': 'PUBLISHED',
    'ARCHIVED': 'ARCHIVED',
  };

  @override
  final Iterable<Type> types = const <Type>[WorkflowResponseStatusEnum];
  @override
  final String wireName = 'WorkflowResponseStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    WorkflowResponseStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  WorkflowResponseStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => WorkflowResponseStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$WorkflowResponse extends WorkflowResponse {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? definition;
  @override
  final WorkflowResponseStatusEnum? status;
  @override
  final int? version;
  @override
  final int? creatorId;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;
  @override
  final bool? public;

  factory _$WorkflowResponse([
    void Function(WorkflowResponseBuilder)? updates,
  ]) => (WorkflowResponseBuilder()..update(updates))._build();

  _$WorkflowResponse._({
    this.id,
    this.name,
    this.description,
    this.definition,
    this.status,
    this.version,
    this.creatorId,
    this.createTime,
    this.updateTime,
    this.public,
  }) : super._();
  @override
  WorkflowResponse rebuild(void Function(WorkflowResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WorkflowResponseBuilder toBuilder() =>
      WorkflowResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkflowResponse &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        definition == other.definition &&
        status == other.status &&
        version == other.version &&
        creatorId == other.creatorId &&
        createTime == other.createTime &&
        updateTime == other.updateTime &&
        public == other.public;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, definition.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, creatorId.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jc(_$hash, public.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WorkflowResponse')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('definition', definition)
          ..add('status', status)
          ..add('version', version)
          ..add('creatorId', creatorId)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime)
          ..add('public', public))
        .toString();
  }
}

class WorkflowResponseBuilder
    implements Builder<WorkflowResponse, WorkflowResponseBuilder> {
  _$WorkflowResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _definition;
  String? get definition => _$this._definition;
  set definition(String? definition) => _$this._definition = definition;

  WorkflowResponseStatusEnum? _status;
  WorkflowResponseStatusEnum? get status => _$this._status;
  set status(WorkflowResponseStatusEnum? status) => _$this._status = status;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  int? _creatorId;
  int? get creatorId => _$this._creatorId;
  set creatorId(int? creatorId) => _$this._creatorId = creatorId;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  bool? _public;
  bool? get public => _$this._public;
  set public(bool? public) => _$this._public = public;

  WorkflowResponseBuilder() {
    WorkflowResponse._defaults(this);
  }

  WorkflowResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _description = $v.description;
      _definition = $v.definition;
      _status = $v.status;
      _version = $v.version;
      _creatorId = $v.creatorId;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _public = $v.public;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkflowResponse other) {
    _$v = other as _$WorkflowResponse;
  }

  @override
  void update(void Function(WorkflowResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WorkflowResponse build() => _build();

  _$WorkflowResponse _build() {
    final _$result =
        _$v ??
        _$WorkflowResponse._(
          id: id,
          name: name,
          description: description,
          definition: definition,
          status: status,
          version: version,
          creatorId: creatorId,
          createTime: createTime,
          updateTime: updateTime,
          public: public,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
