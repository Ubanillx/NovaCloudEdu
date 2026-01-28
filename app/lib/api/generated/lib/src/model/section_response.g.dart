// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SectionResponse extends SectionResponse {
  @override
  final int? id;
  @override
  final int? courseId;
  @override
  final int? chapterId;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? videoUrl;
  @override
  final int? duration;
  @override
  final int? sort;
  @override
  final bool? isFree;
  @override
  final String? resourceUrl;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$SectionResponse([void Function(SectionResponseBuilder)? updates]) =>
      (SectionResponseBuilder()..update(updates))._build();

  _$SectionResponse._({
    this.id,
    this.courseId,
    this.chapterId,
    this.title,
    this.description,
    this.videoUrl,
    this.duration,
    this.sort,
    this.isFree,
    this.resourceUrl,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  SectionResponse rebuild(void Function(SectionResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SectionResponseBuilder toBuilder() => SectionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SectionResponse &&
        id == other.id &&
        courseId == other.courseId &&
        chapterId == other.chapterId &&
        title == other.title &&
        description == other.description &&
        videoUrl == other.videoUrl &&
        duration == other.duration &&
        sort == other.sort &&
        isFree == other.isFree &&
        resourceUrl == other.resourceUrl &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, courseId.hashCode);
    _$hash = $jc(_$hash, chapterId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, videoUrl.hashCode);
    _$hash = $jc(_$hash, duration.hashCode);
    _$hash = $jc(_$hash, sort.hashCode);
    _$hash = $jc(_$hash, isFree.hashCode);
    _$hash = $jc(_$hash, resourceUrl.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SectionResponse')
          ..add('id', id)
          ..add('courseId', courseId)
          ..add('chapterId', chapterId)
          ..add('title', title)
          ..add('description', description)
          ..add('videoUrl', videoUrl)
          ..add('duration', duration)
          ..add('sort', sort)
          ..add('isFree', isFree)
          ..add('resourceUrl', resourceUrl)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class SectionResponseBuilder
    implements Builder<SectionResponse, SectionResponseBuilder> {
  _$SectionResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _courseId;
  int? get courseId => _$this._courseId;
  set courseId(int? courseId) => _$this._courseId = courseId;

  int? _chapterId;
  int? get chapterId => _$this._chapterId;
  set chapterId(int? chapterId) => _$this._chapterId = chapterId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _videoUrl;
  String? get videoUrl => _$this._videoUrl;
  set videoUrl(String? videoUrl) => _$this._videoUrl = videoUrl;

  int? _duration;
  int? get duration => _$this._duration;
  set duration(int? duration) => _$this._duration = duration;

  int? _sort;
  int? get sort => _$this._sort;
  set sort(int? sort) => _$this._sort = sort;

  bool? _isFree;
  bool? get isFree => _$this._isFree;
  set isFree(bool? isFree) => _$this._isFree = isFree;

  String? _resourceUrl;
  String? get resourceUrl => _$this._resourceUrl;
  set resourceUrl(String? resourceUrl) => _$this._resourceUrl = resourceUrl;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  SectionResponseBuilder() {
    SectionResponse._defaults(this);
  }

  SectionResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _courseId = $v.courseId;
      _chapterId = $v.chapterId;
      _title = $v.title;
      _description = $v.description;
      _videoUrl = $v.videoUrl;
      _duration = $v.duration;
      _sort = $v.sort;
      _isFree = $v.isFree;
      _resourceUrl = $v.resourceUrl;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SectionResponse other) {
    _$v = other as _$SectionResponse;
  }

  @override
  void update(void Function(SectionResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SectionResponse build() => _build();

  _$SectionResponse _build() {
    final _$result =
        _$v ??
        _$SectionResponse._(
          id: id,
          courseId: courseId,
          chapterId: chapterId,
          title: title,
          description: description,
          videoUrl: videoUrl,
          duration: duration,
          sort: sort,
          isFree: isFree,
          resourceUrl: resourceUrl,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
