// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_version_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WorkflowVersionResponse extends WorkflowVersionResponse {
  @override
  final int? id;
  @override
  final int? workflowId;
  @override
  final int? version;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? definition;
  @override
  final String? publishNote;
  @override
  final int? publishedBy;
  @override
  final DateTime? createTime;

  factory _$WorkflowVersionResponse([
    void Function(WorkflowVersionResponseBuilder)? updates,
  ]) => (WorkflowVersionResponseBuilder()..update(updates))._build();

  _$WorkflowVersionResponse._({
    this.id,
    this.workflowId,
    this.version,
    this.name,
    this.description,
    this.definition,
    this.publishNote,
    this.publishedBy,
    this.createTime,
  }) : super._();
  @override
  WorkflowVersionResponse rebuild(
    void Function(WorkflowVersionResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WorkflowVersionResponseBuilder toBuilder() =>
      WorkflowVersionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkflowVersionResponse &&
        id == other.id &&
        workflowId == other.workflowId &&
        version == other.version &&
        name == other.name &&
        description == other.description &&
        definition == other.definition &&
        publishNote == other.publishNote &&
        publishedBy == other.publishedBy &&
        createTime == other.createTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, workflowId.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, definition.hashCode);
    _$hash = $jc(_$hash, publishNote.hashCode);
    _$hash = $jc(_$hash, publishedBy.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WorkflowVersionResponse')
          ..add('id', id)
          ..add('workflowId', workflowId)
          ..add('version', version)
          ..add('name', name)
          ..add('description', description)
          ..add('definition', definition)
          ..add('publishNote', publishNote)
          ..add('publishedBy', publishedBy)
          ..add('createTime', createTime))
        .toString();
  }
}

class WorkflowVersionResponseBuilder
    implements
        Builder<WorkflowVersionResponse, WorkflowVersionResponseBuilder> {
  _$WorkflowVersionResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _workflowId;
  int? get workflowId => _$this._workflowId;
  set workflowId(int? workflowId) => _$this._workflowId = workflowId;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _definition;
  String? get definition => _$this._definition;
  set definition(String? definition) => _$this._definition = definition;

  String? _publishNote;
  String? get publishNote => _$this._publishNote;
  set publishNote(String? publishNote) => _$this._publishNote = publishNote;

  int? _publishedBy;
  int? get publishedBy => _$this._publishedBy;
  set publishedBy(int? publishedBy) => _$this._publishedBy = publishedBy;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  WorkflowVersionResponseBuilder() {
    WorkflowVersionResponse._defaults(this);
  }

  WorkflowVersionResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _workflowId = $v.workflowId;
      _version = $v.version;
      _name = $v.name;
      _description = $v.description;
      _definition = $v.definition;
      _publishNote = $v.publishNote;
      _publishedBy = $v.publishedBy;
      _createTime = $v.createTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkflowVersionResponse other) {
    _$v = other as _$WorkflowVersionResponse;
  }

  @override
  void update(void Function(WorkflowVersionResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WorkflowVersionResponse build() => _build();

  _$WorkflowVersionResponse _build() {
    final _$result =
        _$v ??
        _$WorkflowVersionResponse._(
          id: id,
          workflowId: workflowId,
          version: version,
          name: name,
          description: description,
          definition: definition,
          publishNote: publishNote,
          publishedBy: publishedBy,
          createTime: createTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
