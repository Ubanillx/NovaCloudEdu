// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_banner_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateBannerRequest extends CreateBannerRequest {
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

  factory _$CreateBannerRequest([
    void Function(CreateBannerRequestBuilder)? updates,
  ]) => (CreateBannerRequestBuilder()..update(updates))._build();

  _$CreateBannerRequest._({
    required this.title,
    required this.imageUrl,
    this.linkType,
    this.linkUrl,
    this.sort,
    this.startTime,
    this.endTime,
  }) : super._();
  @override
  CreateBannerRequest rebuild(
    void Function(CreateBannerRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateBannerRequestBuilder toBuilder() =>
      CreateBannerRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateBannerRequest &&
        title == other.title &&
        imageUrl == other.imageUrl &&
        linkType == other.linkType &&
        linkUrl == other.linkUrl &&
        sort == other.sort &&
        startTime == other.startTime &&
        endTime == other.endTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, linkType.hashCode);
    _$hash = $jc(_$hash, linkUrl.hashCode);
    _$hash = $jc(_$hash, sort.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateBannerRequest')
          ..add('title', title)
          ..add('imageUrl', imageUrl)
          ..add('linkType', linkType)
          ..add('linkUrl', linkUrl)
          ..add('sort', sort)
          ..add('startTime', startTime)
          ..add('endTime', endTime))
        .toString();
  }
}

class CreateBannerRequestBuilder
    implements Builder<CreateBannerRequest, CreateBannerRequestBuilder> {
  _$CreateBannerRequest? _$v;

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

  CreateBannerRequestBuilder() {
    CreateBannerRequest._defaults(this);
  }

  CreateBannerRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _imageUrl = $v.imageUrl;
      _linkType = $v.linkType;
      _linkUrl = $v.linkUrl;
      _sort = $v.sort;
      _startTime = $v.startTime;
      _endTime = $v.endTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateBannerRequest other) {
    _$v = other as _$CreateBannerRequest;
  }

  @override
  void update(void Function(CreateBannerRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateBannerRequest build() => _build();

  _$CreateBannerRequest _build() {
    final _$result =
        _$v ??
        _$CreateBannerRequest._(
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'CreateBannerRequest',
            'title',
          ),
          imageUrl: BuiltValueNullFieldError.checkNotNull(
            imageUrl,
            r'CreateBannerRequest',
            'imageUrl',
          ),
          linkType: linkType,
          linkUrl: linkUrl,
          sort: sort,
          startTime: startTime,
          endTime: endTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
