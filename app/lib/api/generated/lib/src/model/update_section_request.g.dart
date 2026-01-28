// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_section_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateSectionRequest extends UpdateSectionRequest {
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

  factory _$UpdateSectionRequest([
    void Function(UpdateSectionRequestBuilder)? updates,
  ]) => (UpdateSectionRequestBuilder()..update(updates))._build();

  _$UpdateSectionRequest._({
    required this.title,
    required this.duration,
    required this.sort,
    required this.isFree,
    this.description,
    this.videoUrl,
    this.resourceUrl,
  }) : super._();
  @override
  UpdateSectionRequest rebuild(
    void Function(UpdateSectionRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateSectionRequestBuilder toBuilder() =>
      UpdateSectionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateSectionRequest &&
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
    return (newBuiltValueToStringHelper(r'UpdateSectionRequest')
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

class UpdateSectionRequestBuilder
    implements Builder<UpdateSectionRequest, UpdateSectionRequestBuilder> {
  _$UpdateSectionRequest? _$v;

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

  UpdateSectionRequestBuilder() {
    UpdateSectionRequest._defaults(this);
  }

  UpdateSectionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
  void replace(UpdateSectionRequest other) {
    _$v = other as _$UpdateSectionRequest;
  }

  @override
  void update(void Function(UpdateSectionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateSectionRequest build() => _build();

  _$UpdateSectionRequest _build() {
    final _$result =
        _$v ??
        _$UpdateSectionRequest._(
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'UpdateSectionRequest',
            'title',
          ),
          duration: BuiltValueNullFieldError.checkNotNull(
            duration,
            r'UpdateSectionRequest',
            'duration',
          ),
          sort: BuiltValueNullFieldError.checkNotNull(
            sort,
            r'UpdateSectionRequest',
            'sort',
          ),
          isFree: BuiltValueNullFieldError.checkNotNull(
            isFree,
            r'UpdateSectionRequest',
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
