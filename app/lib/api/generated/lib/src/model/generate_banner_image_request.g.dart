// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_banner_image_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GenerateBannerImageRequest extends GenerateBannerImageRequest {
  @override
  final String title;
  @override
  final String imageDescription;

  factory _$GenerateBannerImageRequest([
    void Function(GenerateBannerImageRequestBuilder)? updates,
  ]) => (GenerateBannerImageRequestBuilder()..update(updates))._build();

  _$GenerateBannerImageRequest._({
    required this.title,
    required this.imageDescription,
  }) : super._();
  @override
  GenerateBannerImageRequest rebuild(
    void Function(GenerateBannerImageRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GenerateBannerImageRequestBuilder toBuilder() =>
      GenerateBannerImageRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenerateBannerImageRequest &&
        title == other.title &&
        imageDescription == other.imageDescription;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, imageDescription.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GenerateBannerImageRequest')
          ..add('title', title)
          ..add('imageDescription', imageDescription))
        .toString();
  }
}

class GenerateBannerImageRequestBuilder
    implements
        Builder<GenerateBannerImageRequest, GenerateBannerImageRequestBuilder> {
  _$GenerateBannerImageRequest? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _imageDescription;
  String? get imageDescription => _$this._imageDescription;
  set imageDescription(String? imageDescription) =>
      _$this._imageDescription = imageDescription;

  GenerateBannerImageRequestBuilder() {
    GenerateBannerImageRequest._defaults(this);
  }

  GenerateBannerImageRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _imageDescription = $v.imageDescription;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GenerateBannerImageRequest other) {
    _$v = other as _$GenerateBannerImageRequest;
  }

  @override
  void update(void Function(GenerateBannerImageRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenerateBannerImageRequest build() => _build();

  _$GenerateBannerImageRequest _build() {
    final _$result =
        _$v ??
        _$GenerateBannerImageRequest._(
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'GenerateBannerImageRequest',
            'title',
          ),
          imageDescription: BuiltValueNullFieldError.checkNotNull(
            imageDescription,
            r'GenerateBannerImageRequest',
            'imageDescription',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
