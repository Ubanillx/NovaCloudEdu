// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BannerResponse extends BannerResponse {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? imageUrl;
  @override
  final int? linkType;
  @override
  final String? linkTypeDesc;
  @override
  final String? linkUrl;
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
  final int? adminId;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$BannerResponse([void Function(BannerResponseBuilder)? updates]) =>
      (BannerResponseBuilder()..update(updates))._build();

  _$BannerResponse._({
    this.id,
    this.title,
    this.imageUrl,
    this.linkType,
    this.linkTypeDesc,
    this.linkUrl,
    this.sort,
    this.status,
    this.statusDesc,
    this.startTime,
    this.endTime,
    this.adminId,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  BannerResponse rebuild(void Function(BannerResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BannerResponseBuilder toBuilder() => BannerResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BannerResponse &&
        id == other.id &&
        title == other.title &&
        imageUrl == other.imageUrl &&
        linkType == other.linkType &&
        linkTypeDesc == other.linkTypeDesc &&
        linkUrl == other.linkUrl &&
        sort == other.sort &&
        status == other.status &&
        statusDesc == other.statusDesc &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        adminId == other.adminId &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, linkType.hashCode);
    _$hash = $jc(_$hash, linkTypeDesc.hashCode);
    _$hash = $jc(_$hash, linkUrl.hashCode);
    _$hash = $jc(_$hash, sort.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, statusDesc.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, adminId.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BannerResponse')
          ..add('id', id)
          ..add('title', title)
          ..add('imageUrl', imageUrl)
          ..add('linkType', linkType)
          ..add('linkTypeDesc', linkTypeDesc)
          ..add('linkUrl', linkUrl)
          ..add('sort', sort)
          ..add('status', status)
          ..add('statusDesc', statusDesc)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('adminId', adminId)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class BannerResponseBuilder
    implements Builder<BannerResponse, BannerResponseBuilder> {
  _$BannerResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  int? _linkType;
  int? get linkType => _$this._linkType;
  set linkType(int? linkType) => _$this._linkType = linkType;

  String? _linkTypeDesc;
  String? get linkTypeDesc => _$this._linkTypeDesc;
  set linkTypeDesc(String? linkTypeDesc) => _$this._linkTypeDesc = linkTypeDesc;

  String? _linkUrl;
  String? get linkUrl => _$this._linkUrl;
  set linkUrl(String? linkUrl) => _$this._linkUrl = linkUrl;

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

  int? _adminId;
  int? get adminId => _$this._adminId;
  set adminId(int? adminId) => _$this._adminId = adminId;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  BannerResponseBuilder() {
    BannerResponse._defaults(this);
  }

  BannerResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _imageUrl = $v.imageUrl;
      _linkType = $v.linkType;
      _linkTypeDesc = $v.linkTypeDesc;
      _linkUrl = $v.linkUrl;
      _sort = $v.sort;
      _status = $v.status;
      _statusDesc = $v.statusDesc;
      _startTime = $v.startTime;
      _endTime = $v.endTime;
      _adminId = $v.adminId;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BannerResponse other) {
    _$v = other as _$BannerResponse;
  }

  @override
  void update(void Function(BannerResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BannerResponse build() => _build();

  _$BannerResponse _build() {
    final _$result =
        _$v ??
        _$BannerResponse._(
          id: id,
          title: title,
          imageUrl: imageUrl,
          linkType: linkType,
          linkTypeDesc: linkTypeDesc,
          linkUrl: linkUrl,
          sort: sort,
          status: status,
          statusDesc: statusDesc,
          startTime: startTime,
          endTime: endTime,
          adminId: adminId,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
