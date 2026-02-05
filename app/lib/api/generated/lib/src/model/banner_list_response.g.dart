// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_list_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BannerListResponse extends BannerListResponse {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? imageUrl;
  @override
  final int? linkType;
  @override
  final String? linkUrl;

  factory _$BannerListResponse([
    void Function(BannerListResponseBuilder)? updates,
  ]) => (BannerListResponseBuilder()..update(updates))._build();

  _$BannerListResponse._({
    this.id,
    this.title,
    this.imageUrl,
    this.linkType,
    this.linkUrl,
  }) : super._();
  @override
  BannerListResponse rebuild(
    void Function(BannerListResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BannerListResponseBuilder toBuilder() =>
      BannerListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BannerListResponse &&
        id == other.id &&
        title == other.title &&
        imageUrl == other.imageUrl &&
        linkType == other.linkType &&
        linkUrl == other.linkUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, linkType.hashCode);
    _$hash = $jc(_$hash, linkUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BannerListResponse')
          ..add('id', id)
          ..add('title', title)
          ..add('imageUrl', imageUrl)
          ..add('linkType', linkType)
          ..add('linkUrl', linkUrl))
        .toString();
  }
}

class BannerListResponseBuilder
    implements Builder<BannerListResponse, BannerListResponseBuilder> {
  _$BannerListResponse? _$v;

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

  BannerListResponseBuilder() {
    BannerListResponse._defaults(this);
  }

  BannerListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _imageUrl = $v.imageUrl;
      _linkType = $v.linkType;
      _linkUrl = $v.linkUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BannerListResponse other) {
    _$v = other as _$BannerListResponse;
  }

  @override
  void update(void Function(BannerListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BannerListResponse build() => _build();

  _$BannerListResponse _build() {
    final _$result =
        _$v ??
        _$BannerListResponse._(
          id: id,
          title: title,
          imageUrl: imageUrl,
          linkType: linkType,
          linkUrl: linkUrl,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
