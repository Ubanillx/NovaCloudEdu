// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_template_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WorkflowTemplateResponse extends WorkflowTemplateResponse {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? category;
  @override
  final String? icon;
  @override
  final String? definition;
  @override
  final BuiltList<String>? tags;
  @override
  final int? creatorId;
  @override
  final int? usageCount;
  @override
  final DateTime? createTime;
  @override
  final bool? public;
  @override
  final bool? system;

  factory _$WorkflowTemplateResponse([
    void Function(WorkflowTemplateResponseBuilder)? updates,
  ]) => (WorkflowTemplateResponseBuilder()..update(updates))._build();

  _$WorkflowTemplateResponse._({
    this.id,
    this.name,
    this.description,
    this.category,
    this.icon,
    this.definition,
    this.tags,
    this.creatorId,
    this.usageCount,
    this.createTime,
    this.public,
    this.system,
  }) : super._();
  @override
  WorkflowTemplateResponse rebuild(
    void Function(WorkflowTemplateResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WorkflowTemplateResponseBuilder toBuilder() =>
      WorkflowTemplateResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkflowTemplateResponse &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        category == other.category &&
        icon == other.icon &&
        definition == other.definition &&
        tags == other.tags &&
        creatorId == other.creatorId &&
        usageCount == other.usageCount &&
        createTime == other.createTime &&
        public == other.public &&
        system == other.system;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, definition.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, creatorId.hashCode);
    _$hash = $jc(_$hash, usageCount.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, public.hashCode);
    _$hash = $jc(_$hash, system.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WorkflowTemplateResponse')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('category', category)
          ..add('icon', icon)
          ..add('definition', definition)
          ..add('tags', tags)
          ..add('creatorId', creatorId)
          ..add('usageCount', usageCount)
          ..add('createTime', createTime)
          ..add('public', public)
          ..add('system', system))
        .toString();
  }
}

class WorkflowTemplateResponseBuilder
    implements
        Builder<WorkflowTemplateResponse, WorkflowTemplateResponseBuilder> {
  _$WorkflowTemplateResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  String? _definition;
  String? get definition => _$this._definition;
  set definition(String? definition) => _$this._definition = definition;

  ListBuilder<String>? _tags;
  ListBuilder<String> get tags => _$this._tags ??= ListBuilder<String>();
  set tags(ListBuilder<String>? tags) => _$this._tags = tags;

  int? _creatorId;
  int? get creatorId => _$this._creatorId;
  set creatorId(int? creatorId) => _$this._creatorId = creatorId;

  int? _usageCount;
  int? get usageCount => _$this._usageCount;
  set usageCount(int? usageCount) => _$this._usageCount = usageCount;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  bool? _public;
  bool? get public => _$this._public;
  set public(bool? public) => _$this._public = public;

  bool? _system;
  bool? get system => _$this._system;
  set system(bool? system) => _$this._system = system;

  WorkflowTemplateResponseBuilder() {
    WorkflowTemplateResponse._defaults(this);
  }

  WorkflowTemplateResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _description = $v.description;
      _category = $v.category;
      _icon = $v.icon;
      _definition = $v.definition;
      _tags = $v.tags?.toBuilder();
      _creatorId = $v.creatorId;
      _usageCount = $v.usageCount;
      _createTime = $v.createTime;
      _public = $v.public;
      _system = $v.system;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkflowTemplateResponse other) {
    _$v = other as _$WorkflowTemplateResponse;
  }

  @override
  void update(void Function(WorkflowTemplateResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WorkflowTemplateResponse build() => _build();

  _$WorkflowTemplateResponse _build() {
    _$WorkflowTemplateResponse _$result;
    try {
      _$result =
          _$v ??
          _$WorkflowTemplateResponse._(
            id: id,
            name: name,
            description: description,
            category: category,
            icon: icon,
            definition: definition,
            tags: _tags?.build(),
            creatorId: creatorId,
            usageCount: usageCount,
            createTime: createTime,
            public: public,
            system: system,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tags';
        _tags?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'WorkflowTemplateResponse',
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
