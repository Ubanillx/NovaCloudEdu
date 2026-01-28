// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChapterResponse extends ChapterResponse {
  @override
  final int? id;
  @override
  final int? courseId;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final int? sort;
  @override
  final BuiltList<SectionResponse>? sections;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$ChapterResponse([void Function(ChapterResponseBuilder)? updates]) =>
      (ChapterResponseBuilder()..update(updates))._build();

  _$ChapterResponse._({
    this.id,
    this.courseId,
    this.title,
    this.description,
    this.sort,
    this.sections,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  ChapterResponse rebuild(void Function(ChapterResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChapterResponseBuilder toBuilder() => ChapterResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChapterResponse &&
        id == other.id &&
        courseId == other.courseId &&
        title == other.title &&
        description == other.description &&
        sort == other.sort &&
        sections == other.sections &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, courseId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, sort.hashCode);
    _$hash = $jc(_$hash, sections.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChapterResponse')
          ..add('id', id)
          ..add('courseId', courseId)
          ..add('title', title)
          ..add('description', description)
          ..add('sort', sort)
          ..add('sections', sections)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class ChapterResponseBuilder
    implements Builder<ChapterResponse, ChapterResponseBuilder> {
  _$ChapterResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _courseId;
  int? get courseId => _$this._courseId;
  set courseId(int? courseId) => _$this._courseId = courseId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _sort;
  int? get sort => _$this._sort;
  set sort(int? sort) => _$this._sort = sort;

  ListBuilder<SectionResponse>? _sections;
  ListBuilder<SectionResponse> get sections =>
      _$this._sections ??= ListBuilder<SectionResponse>();
  set sections(ListBuilder<SectionResponse>? sections) =>
      _$this._sections = sections;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  ChapterResponseBuilder() {
    ChapterResponse._defaults(this);
  }

  ChapterResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _courseId = $v.courseId;
      _title = $v.title;
      _description = $v.description;
      _sort = $v.sort;
      _sections = $v.sections?.toBuilder();
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChapterResponse other) {
    _$v = other as _$ChapterResponse;
  }

  @override
  void update(void Function(ChapterResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChapterResponse build() => _build();

  _$ChapterResponse _build() {
    _$ChapterResponse _$result;
    try {
      _$result =
          _$v ??
          _$ChapterResponse._(
            id: id,
            courseId: courseId,
            title: title,
            description: description,
            sort: sort,
            sections: _sections?.build(),
            createTime: createTime,
            updateTime: updateTime,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sections';
        _sections?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ChapterResponse',
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
