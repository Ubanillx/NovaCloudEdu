// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_detail_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AnnouncementDetailResponse extends AnnouncementDetailResponse {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? content;
  @override
  final String? coverImage;
  @override
  final int? viewCount;
  @override
  final bool? isRead;
  @override
  final DateTime? createTime;

  factory _$AnnouncementDetailResponse([
    void Function(AnnouncementDetailResponseBuilder)? updates,
  ]) => (AnnouncementDetailResponseBuilder()..update(updates))._build();

  _$AnnouncementDetailResponse._({
    this.id,
    this.title,
    this.content,
    this.coverImage,
    this.viewCount,
    this.isRead,
    this.createTime,
  }) : super._();
  @override
  AnnouncementDetailResponse rebuild(
    void Function(AnnouncementDetailResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AnnouncementDetailResponseBuilder toBuilder() =>
      AnnouncementDetailResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AnnouncementDetailResponse &&
        id == other.id &&
        title == other.title &&
        content == other.content &&
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
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, coverImage.hashCode);
    _$hash = $jc(_$hash, viewCount.hashCode);
    _$hash = $jc(_$hash, isRead.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AnnouncementDetailResponse')
          ..add('id', id)
          ..add('title', title)
          ..add('content', content)
          ..add('coverImage', coverImage)
          ..add('viewCount', viewCount)
          ..add('isRead', isRead)
          ..add('createTime', createTime))
        .toString();
  }
}

class AnnouncementDetailResponseBuilder
    implements
        Builder<AnnouncementDetailResponse, AnnouncementDetailResponseBuilder> {
  _$AnnouncementDetailResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

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

  AnnouncementDetailResponseBuilder() {
    AnnouncementDetailResponse._defaults(this);
  }

  AnnouncementDetailResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _content = $v.content;
      _coverImage = $v.coverImage;
      _viewCount = $v.viewCount;
      _isRead = $v.isRead;
      _createTime = $v.createTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AnnouncementDetailResponse other) {
    _$v = other as _$AnnouncementDetailResponse;
  }

  @override
  void update(void Function(AnnouncementDetailResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AnnouncementDetailResponse build() => _build();

  _$AnnouncementDetailResponse _build() {
    final _$result =
        _$v ??
        _$AnnouncementDetailResponse._(
          id: id,
          title: title,
          content: content,
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
