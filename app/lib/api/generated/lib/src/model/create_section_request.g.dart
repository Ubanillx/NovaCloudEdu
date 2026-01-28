// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_section_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateSectionRequest extends CreateSectionRequest {
  @override
  final int chapterId;
  @override
  final String title;
  @override
  final int duration;
  @override
  final int sort;
  @override
  final bool isFree;
  @override
  final String? description;
  @override
  final String? videoUrl;
  @override
  final String? resourceUrl;

  factory _$CreateSectionRequest([
    void Function(CreateSectionRequestBuilder)? updates,
  ]) => (CreateSectionRequestBuilder()..update(updates))._build();

  _$CreateSectionRequest._({
    required this.chapterId,
    required this.title,
    required this.duration,
    required this.sort,
    required this.isFree,
    this.description,
    this.videoUrl,
    this.resourceUrl,
  }) : super._();
  @override
  CreateSectionRequest rebuild(
    void Function(CreateSectionRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateSectionRequestBuilder toBuilder() =>
      CreateSectionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateSectionRequest &&
        chapterId == other.chapterId &&
        title == other.title &&
        duration == other.duration &&
        sort == other.sort &&
        isFree == other.isFree &&
        description == other.description &&
        videoUrl == other.videoUrl &&
        resourceUrl == other.resourceUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, chapterId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, duration.hashCode);
    _$hash = $jc(_$hash, sort.hashCode);
    _$hash = $jc(_$hash, isFree.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, videoUrl.hashCode);
    _$hash = $jc(_$hash, resourceUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateSectionRequest')
          ..add('chapterId', chapterId)
          ..add('title', title)
          ..add('duration', duration)
          ..add('sort', sort)
          ..add('isFree', isFree)
          ..add('description', description)
          ..add('videoUrl', videoUrl)
          ..add('resourceUrl', resourceUrl))
        .toString();
  }
}

class CreateSectionRequestBuilder
    implements Builder<CreateSectionRequest, CreateSectionRequestBuilder> {
  _$CreateSectionRequest? _$v;

  int? _chapterId;
  int? get chapterId => _$this._chapterId;
  set chapterId(int? chapterId) => _$this._chapterId = chapterId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  int? _duration;
  int? get duration => _$this._duration;
  set duration(int? duration) => _$this._duration = duration;

  int? _sort;
  int? get sort => _$this._sort;
  set sort(int? sort) => _$this._sort = sort;

  bool? _isFree;
  bool? get isFree => _$this._isFree;
  set isFree(bool? isFree) => _$this._isFree = isFree;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _videoUrl;
  String? get videoUrl => _$this._videoUrl;
  set videoUrl(String? videoUrl) => _$this._videoUrl = videoUrl;

  String? _resourceUrl;
  String? get resourceUrl => _$this._resourceUrl;
  set resourceUrl(String? resourceUrl) => _$this._resourceUrl = resourceUrl;

  CreateSectionRequestBuilder() {
    CreateSectionRequest._defaults(this);
  }

  CreateSectionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chapterId = $v.chapterId;
      _title = $v.title;
      _duration = $v.duration;
      _sort = $v.sort;
      _isFree = $v.isFree;
      _description = $v.description;
      _videoUrl = $v.videoUrl;
      _resourceUrl = $v.resourceUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateSectionRequest other) {
    _$v = other as _$CreateSectionRequest;
  }

  @override
  void update(void Function(CreateSectionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateSectionRequest build() => _build();

  _$CreateSectionRequest _build() {
    final _$result =
        _$v ??
        _$CreateSectionRequest._(
          chapterId: BuiltValueNullFieldError.checkNotNull(
            chapterId,
            r'CreateSectionRequest',
            'chapterId',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'CreateSectionRequest',
            'title',
          ),
          duration: BuiltValueNullFieldError.checkNotNull(
            duration,
            r'CreateSectionRequest',
            'duration',
          ),
          sort: BuiltValueNullFieldError.checkNotNull(
            sort,
            r'CreateSectionRequest',
            'sort',
          ),
          isFree: BuiltValueNullFieldError.checkNotNull(
            isFree,
            r'CreateSectionRequest',
            'isFree',
          ),
          description: description,
          videoUrl: videoUrl,
          resourceUrl: resourceUrl,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
