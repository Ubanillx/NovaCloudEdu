// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_announcement_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateAnnouncementRequest extends UpdateAnnouncementRequest {
  @override
  final int id;
  @override
  final String title;
  @override
  final String content;
  @override
  final int? sort;
  @override
  final int? status;
  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;
  @override
  final String? coverImage;

  factory _$UpdateAnnouncementRequest([
    void Function(UpdateAnnouncementRequestBuilder)? updates,
  ]) => (UpdateAnnouncementRequestBuilder()..update(updates))._build();

  _$UpdateAnnouncementRequest._({
    required this.id,
    required this.title,
    required this.content,
    this.sort,
    this.status,
    this.startTime,
    this.endTime,
    this.coverImage,
  }) : super._();
  @override
  UpdateAnnouncementRequest rebuild(
    void Function(UpdateAnnouncementRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateAnnouncementRequestBuilder toBuilder() =>
      UpdateAnnouncementRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateAnnouncementRequest &&
        id == other.id &&
        title == other.title &&
        content == other.content &&
        sort == other.sort &&
        status == other.status &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        coverImage == other.coverImage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, sort.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, coverImage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateAnnouncementRequest')
          ..add('id', id)
          ..add('title', title)
          ..add('content', content)
          ..add('sort', sort)
          ..add('status', status)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('coverImage', coverImage))
        .toString();
  }
}

class UpdateAnnouncementRequestBuilder
    implements
        Builder<UpdateAnnouncementRequest, UpdateAnnouncementRequestBuilder> {
  _$UpdateAnnouncementRequest? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  int? _sort;
  int? get sort => _$this._sort;
  set sort(int? sort) => _$this._sort = sort;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  DateTime? _startTime;
  DateTime? get startTime => _$this._startTime;
  set startTime(DateTime? startTime) => _$this._startTime = startTime;

  DateTime? _endTime;
  DateTime? get endTime => _$this._endTime;
  set endTime(DateTime? endTime) => _$this._endTime = endTime;

  String? _coverImage;
  String? get coverImage => _$this._coverImage;
  set coverImage(String? coverImage) => _$this._coverImage = coverImage;

  UpdateAnnouncementRequestBuilder() {
    UpdateAnnouncementRequest._defaults(this);
  }

  UpdateAnnouncementRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _content = $v.content;
      _sort = $v.sort;
      _status = $v.status;
      _startTime = $v.startTime;
      _endTime = $v.endTime;
      _coverImage = $v.coverImage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateAnnouncementRequest other) {
    _$v = other as _$UpdateAnnouncementRequest;
  }

  @override
  void update(void Function(UpdateAnnouncementRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateAnnouncementRequest build() => _build();

  _$UpdateAnnouncementRequest _build() {
    final _$result =
        _$v ??
        _$UpdateAnnouncementRequest._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'UpdateAnnouncementRequest',
            'id',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'UpdateAnnouncementRequest',
            'title',
          ),
          content: BuiltValueNullFieldError.checkNotNull(
            content,
            r'UpdateAnnouncementRequest',
            'content',
          ),
          sort: sort,
          status: status,
          startTime: startTime,
          endTime: endTime,
          coverImage: coverImage,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
