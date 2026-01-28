// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_list_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AnnouncementListResponse extends AnnouncementListResponse {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? coverImage;
  @override
  final int? viewCount;
  @override
  final bool? isRead;
  @override
  final DateTime? createTime;

  factory _$AnnouncementListResponse([
    void Function(AnnouncementListResponseBuilder)? updates,
  ]) => (AnnouncementListResponseBuilder()..update(updates))._build();

  _$AnnouncementListResponse._({
    this.id,
    this.title,
    this.coverImage,
    this.viewCount,
    this.isRead,
    this.createTime,
  }) : super._();
  @override
  AnnouncementListResponse rebuild(
    void Function(AnnouncementListResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AnnouncementListResponseBuilder toBuilder() =>
      AnnouncementListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AnnouncementListResponse &&
        id == other.id &&
        title == other.title &&
        coverImage == other.coverImage &&
        viewCount == other.viewCount &&
        isRead == other.isRead &&
        createTime == other.createTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, coverImage.hashCode);
    _$hash = $jc(_$hash, viewCount.hashCode);
    _$hash = $jc(_$hash, isRead.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AnnouncementListResponse')
          ..add('id', id)
          ..add('title', title)
          ..add('coverImage', coverImage)
          ..add('viewCount', viewCount)
          ..add('isRead', isRead)
          ..add('createTime', createTime))
        .toString();
  }
}

class AnnouncementListResponseBuilder
    implements
        Builder<AnnouncementListResponse, AnnouncementListResponseBuilder> {
  _$AnnouncementListResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _coverImage;
  String? get coverImage => _$this._coverImage;
  set coverImage(String? coverImage) => _$this._coverImage = coverImage;

  int? _viewCount;
  int? get viewCount => _$this._viewCount;
  set viewCount(int? viewCount) => _$this._viewCount = viewCount;

  bool? _isRead;
  bool? get isRead => _$this._isRead;
  set isRead(bool? isRead) => _$this._isRead = isRead;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  AnnouncementListResponseBuilder() {
    AnnouncementListResponse._defaults(this);
  }

  AnnouncementListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _coverImage = $v.coverImage;
      _viewCount = $v.viewCount;
      _isRead = $v.isRead;
      _createTime = $v.createTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AnnouncementListResponse other) {
    _$v = other as _$AnnouncementListResponse;
  }

  @override
  void update(void Function(AnnouncementListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AnnouncementListResponse build() => _build();

  _$AnnouncementListResponse _build() {
    final _$result =
        _$v ??
        _$AnnouncementListResponse._(
          id: id,
          title: title,
          coverImage: coverImage,
          viewCount: viewCount,
          isRead: isRead,
          createTime: createTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
