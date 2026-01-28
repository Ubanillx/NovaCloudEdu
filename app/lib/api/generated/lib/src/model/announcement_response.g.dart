// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AnnouncementResponse extends AnnouncementResponse {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? content;
  @override
  final int? sort;
  @override
  final int? status;
  @override
  final String? statusDesc;
  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;
  @override
  final String? coverImage;
  @override
  final int? adminId;
  @override
  final int? viewCount;
  @override
  final int? readCount;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$AnnouncementResponse([
    void Function(AnnouncementResponseBuilder)? updates,
  ]) => (AnnouncementResponseBuilder()..update(updates))._build();

  _$AnnouncementResponse._({
    this.id,
    this.title,
    this.content,
    this.sort,
    this.status,
    this.statusDesc,
    this.startTime,
    this.endTime,
    this.coverImage,
    this.adminId,
    this.viewCount,
    this.readCount,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  AnnouncementResponse rebuild(
    void Function(AnnouncementResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AnnouncementResponseBuilder toBuilder() =>
      AnnouncementResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AnnouncementResponse &&
        id == other.id &&
        title == other.title &&
        content == other.content &&
        sort == other.sort &&
        status == other.status &&
        statusDesc == other.statusDesc &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        coverImage == other.coverImage &&
        adminId == other.adminId &&
        viewCount == other.viewCount &&
        readCount == other.readCount &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, sort.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, statusDesc.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, coverImage.hashCode);
    _$hash = $jc(_$hash, adminId.hashCode);
    _$hash = $jc(_$hash, viewCount.hashCode);
    _$hash = $jc(_$hash, readCount.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AnnouncementResponse')
          ..add('id', id)
          ..add('title', title)
          ..add('content', content)
          ..add('sort', sort)
          ..add('status', status)
          ..add('statusDesc', statusDesc)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('coverImage', coverImage)
          ..add('adminId', adminId)
          ..add('viewCount', viewCount)
          ..add('readCount', readCount)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class AnnouncementResponseBuilder
    implements Builder<AnnouncementResponse, AnnouncementResponseBuilder> {
  _$AnnouncementResponse? _$v;

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

  String? _statusDesc;
  String? get statusDesc => _$this._statusDesc;
  set statusDesc(String? statusDesc) => _$this._statusDesc = statusDesc;

  DateTime? _startTime;
  DateTime? get startTime => _$this._startTime;
  set startTime(DateTime? startTime) => _$this._startTime = startTime;

  DateTime? _endTime;
  DateTime? get endTime => _$this._endTime;
  set endTime(DateTime? endTime) => _$this._endTime = endTime;

  String? _coverImage;
  String? get coverImage => _$this._coverImage;
  set coverImage(String? coverImage) => _$this._coverImage = coverImage;

  int? _adminId;
  int? get adminId => _$this._adminId;
  set adminId(int? adminId) => _$this._adminId = adminId;

  int? _viewCount;
  int? get viewCount => _$this._viewCount;
  set viewCount(int? viewCount) => _$this._viewCount = viewCount;

  int? _readCount;
  int? get readCount => _$this._readCount;
  set readCount(int? readCount) => _$this._readCount = readCount;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  AnnouncementResponseBuilder() {
    AnnouncementResponse._defaults(this);
  }

  AnnouncementResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _content = $v.content;
      _sort = $v.sort;
      _status = $v.status;
      _statusDesc = $v.statusDesc;
      _startTime = $v.startTime;
      _endTime = $v.endTime;
      _coverImage = $v.coverImage;
      _adminId = $v.adminId;
      _viewCount = $v.viewCount;
      _readCount = $v.readCount;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AnnouncementResponse other) {
    _$v = other as _$AnnouncementResponse;
  }

  @override
  void update(void Function(AnnouncementResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AnnouncementResponse build() => _build();

  _$AnnouncementResponse _build() {
    final _$result =
        _$v ??
        _$AnnouncementResponse._(
          id: id,
          title: title,
          content: content,
          sort: sort,
          status: status,
          statusDesc: statusDesc,
          startTime: startTime,
          endTime: endTime,
          coverImage: coverImage,
          adminId: adminId,
          viewCount: viewCount,
          readCount: readCount,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
