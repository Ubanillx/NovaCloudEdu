// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_banner_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateBannerRequest extends UpdateBannerRequest {
  @override
  final int id;
  @override
  final String title;
  @override
  final String imageUrl;
  @override
  final int? linkType;
  @override
  final String? linkUrl;
  @override
  final int? sort;
  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;
  @override
  final int? status;

  factory _$UpdateBannerRequest([
    void Function(UpdateBannerRequestBuilder)? updates,
  ]) => (UpdateBannerRequestBuilder()..update(updates))._build();

  _$UpdateBannerRequest._({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.linkType,
    this.linkUrl,
    this.sort,
    this.startTime,
    this.endTime,
    this.status,
  }) : super._();
  @override
  UpdateBannerRequest rebuild(
    void Function(UpdateBannerRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateBannerRequestBuilder toBuilder() =>
      UpdateBannerRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateBannerRequest &&
        id == other.id &&
        title == other.title &&
        imageUrl == other.imageUrl &&
        linkType == other.linkType &&
        linkUrl == other.linkUrl &&
        sort == other.sort &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, linkType.hashCode);
    _$hash = $jc(_$hash, linkUrl.hashCode);
    _$hash = $jc(_$hash, sort.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateBannerRequest')
          ..add('id', id)
          ..add('title', title)
          ..add('imageUrl', imageUrl)
          ..add('linkType', linkType)
          ..add('linkUrl', linkUrl)
          ..add('sort', sort)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('status', status))
        .toString();
  }
}

class UpdateBannerRequestBuilder
    implements Builder<UpdateBannerRequest, UpdateBannerRequestBuilder> {
  _$UpdateBannerRequest? _$v;

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

  String? _linkUrl;
  String? get linkUrl => _$this._linkUrl;
  set linkUrl(String? linkUrl) => _$this._linkUrl = linkUrl;

  int? _sort;
  int? get sort => _$this._sort;
  set sort(int? sort) => _$this._sort = sort;

  DateTime? _startTime;
  DateTime? get startTime => _$this._startTime;
  set startTime(DateTime? startTime) => _$this._startTime = startTime;

  DateTime? _endTime;
  DateTime? get endTime => _$this._endTime;
  set endTime(DateTime? endTime) => _$this._endTime = endTime;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  UpdateBannerRequestBuilder() {
    UpdateBannerRequest._defaults(this);
  }

  UpdateBannerRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _imageUrl = $v.imageUrl;
      _linkType = $v.linkType;
      _linkUrl = $v.linkUrl;
      _sort = $v.sort;
      _startTime = $v.startTime;
      _endTime = $v.endTime;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateBannerRequest other) {
    _$v = other as _$UpdateBannerRequest;
  }

  @override
  void update(void Function(UpdateBannerRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateBannerRequest build() => _build();

  _$UpdateBannerRequest _build() {
    final _$result =
        _$v ??
        _$UpdateBannerRequest._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'UpdateBannerRequest',
            'id',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'UpdateBannerRequest',
            'title',
          ),
          imageUrl: BuiltValueNullFieldError.checkNotNull(
            imageUrl,
            r'UpdateBannerRequest',
            'imageUrl',
          ),
          linkType: linkType,
          linkUrl: linkUrl,
          sort: sort,
          startTime: startTime,
          endTime: endTime,
          status: status,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
