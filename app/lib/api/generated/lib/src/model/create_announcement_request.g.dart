// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_announcement_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateAnnouncementRequest extends CreateAnnouncementRequest {
  @override
  final String title;
  @override
  final String content;
  @override
  final int? sort;
  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;
  @override
  final String? coverImage;

  factory _$CreateAnnouncementRequest([
    void Function(CreateAnnouncementRequestBuilder)? updates,
  ]) => (CreateAnnouncementRequestBuilder()..update(updates))._build();

  _$CreateAnnouncementRequest._({
    required this.title,
    required this.content,
    this.sort,
    this.startTime,
    this.endTime,
    this.coverImage,
  }) : super._();
  @override
  CreateAnnouncementRequest rebuild(
    void Function(CreateAnnouncementRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateAnnouncementRequestBuilder toBuilder() =>
      CreateAnnouncementRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateAnnouncementRequest &&
        title == other.title &&
        content == other.content &&
        sort == other.sort &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        coverImage == other.coverImage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, sort.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, coverImage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateAnnouncementRequest')
          ..add('title', title)
          ..add('content', content)
          ..add('sort', sort)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('coverImage', coverImage))
        .toString();
  }
}

class CreateAnnouncementRequestBuilder
    implements
        Builder<CreateAnnouncementRequest, CreateAnnouncementRequestBuilder> {
  _$CreateAnnouncementRequest? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  int? _sort;
  int? get sort => _$this._sort;
  set sort(int? sort) => _$this._sort = sort;

  DateTime? _startTime;
  DateTime? get startTime => _$this._startTime;
  set startTime(DateTime? startTime) => _$this._startTime = startTime;

  DateTime? _endTime;
  DateTime? get endTime => _$this._endTime;
  set endTime(DateTime? endTime) => _$this._endTime = endTime;

  String? _coverImage;
  String? get coverImage => _$this._coverImage;
  set coverImage(String? coverImage) => _$this._coverImage = coverImage;

  CreateAnnouncementRequestBuilder() {
    CreateAnnouncementRequest._defaults(this);
  }

  CreateAnnouncementRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _content = $v.content;
      _sort = $v.sort;
      _startTime = $v.startTime;
      _endTime = $v.endTime;
      _coverImage = $v.coverImage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateAnnouncementRequest other) {
    _$v = other as _$CreateAnnouncementRequest;
  }

  @override
  void update(void Function(CreateAnnouncementRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateAnnouncementRequest build() => _build();

  _$CreateAnnouncementRequest _build() {
    final _$result =
        _$v ??
        _$CreateAnnouncementRequest._(
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'CreateAnnouncementRequest',
            'title',
          ),
          content: BuiltValueNullFieldError.checkNotNull(
            content,
            r'CreateAnnouncementRequest',
            'content',
          ),
          sort: sort,
          startTime: startTime,
          endTime: endTime,
          coverImage: coverImage,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
