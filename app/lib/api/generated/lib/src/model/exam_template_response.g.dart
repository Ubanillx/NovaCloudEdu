// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_template_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExamTemplateResponse extends ExamTemplateResponse {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? templateUrl;
  @override
  final String? coverUrl;
  @override
  final bool? isSystem;
  @override
  final bool? isEnabled;
  @override
  final int? creatorId;
  @override
  final String? createTime;
  @override
  final String? updateTime;

  factory _$ExamTemplateResponse([
    void Function(ExamTemplateResponseBuilder)? updates,
  ]) => (ExamTemplateResponseBuilder()..update(updates))._build();

  _$ExamTemplateResponse._({
    this.id,
    this.name,
    this.description,
    this.templateUrl,
    this.coverUrl,
    this.isSystem,
    this.isEnabled,
    this.creatorId,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  ExamTemplateResponse rebuild(
    void Function(ExamTemplateResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExamTemplateResponseBuilder toBuilder() =>
      ExamTemplateResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExamTemplateResponse &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        templateUrl == other.templateUrl &&
        coverUrl == other.coverUrl &&
        isSystem == other.isSystem &&
        isEnabled == other.isEnabled &&
        creatorId == other.creatorId &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, templateUrl.hashCode);
    _$hash = $jc(_$hash, coverUrl.hashCode);
    _$hash = $jc(_$hash, isSystem.hashCode);
    _$hash = $jc(_$hash, isEnabled.hashCode);
    _$hash = $jc(_$hash, creatorId.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExamTemplateResponse')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('templateUrl', templateUrl)
          ..add('coverUrl', coverUrl)
          ..add('isSystem', isSystem)
          ..add('isEnabled', isEnabled)
          ..add('creatorId', creatorId)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class ExamTemplateResponseBuilder
    implements Builder<ExamTemplateResponse, ExamTemplateResponseBuilder> {
  _$ExamTemplateResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _templateUrl;
  String? get templateUrl => _$this._templateUrl;
  set templateUrl(String? templateUrl) => _$this._templateUrl = templateUrl;

  String? _coverUrl;
  String? get coverUrl => _$this._coverUrl;
  set coverUrl(String? coverUrl) => _$this._coverUrl = coverUrl;

  bool? _isSystem;
  bool? get isSystem => _$this._isSystem;
  set isSystem(bool? isSystem) => _$this._isSystem = isSystem;

  bool? _isEnabled;
  bool? get isEnabled => _$this._isEnabled;
  set isEnabled(bool? isEnabled) => _$this._isEnabled = isEnabled;

  int? _creatorId;
  int? get creatorId => _$this._creatorId;
  set creatorId(int? creatorId) => _$this._creatorId = creatorId;

  String? _createTime;
  String? get createTime => _$this._createTime;
  set createTime(String? createTime) => _$this._createTime = createTime;

  String? _updateTime;
  String? get updateTime => _$this._updateTime;
  set updateTime(String? updateTime) => _$this._updateTime = updateTime;

  ExamTemplateResponseBuilder() {
    ExamTemplateResponse._defaults(this);
  }

  ExamTemplateResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _description = $v.description;
      _templateUrl = $v.templateUrl;
      _coverUrl = $v.coverUrl;
      _isSystem = $v.isSystem;
      _isEnabled = $v.isEnabled;
      _creatorId = $v.creatorId;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExamTemplateResponse other) {
    _$v = other as _$ExamTemplateResponse;
  }

  @override
  void update(void Function(ExamTemplateResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExamTemplateResponse build() => _build();

  _$ExamTemplateResponse _build() {
    final _$result =
        _$v ??
        _$ExamTemplateResponse._(
          id: id,
          name: name,
          description: description,
          templateUrl: templateUrl,
          coverUrl: coverUrl,
          isSystem: isSystem,
          isEnabled: isEnabled,
          creatorId: creatorId,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
