// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_banner_image_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GenerateBannerImageResponse extends GenerateBannerImageResponse {
  @override
  final String? imageUrl;
  @override
  final bool? success;
  @override
  final String? errorMessage;

  factory _$GenerateBannerImageResponse([
    void Function(GenerateBannerImageResponseBuilder)? updates,
  ]) => (GenerateBannerImageResponseBuilder()..update(updates))._build();

  _$GenerateBannerImageResponse._({
    this.imageUrl,
    this.success,
    this.errorMessage,
  }) : super._();
  @override
  GenerateBannerImageResponse rebuild(
    void Function(GenerateBannerImageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GenerateBannerImageResponseBuilder toBuilder() =>
      GenerateBannerImageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenerateBannerImageResponse &&
        imageUrl == other.imageUrl &&
        success == other.success &&
        errorMessage == other.errorMessage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jc(_$hash, errorMessage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GenerateBannerImageResponse')
          ..add('imageUrl', imageUrl)
          ..add('success', success)
          ..add('errorMessage', errorMessage))
        .toString();
  }
}

class GenerateBannerImageResponseBuilder
    implements
        Builder<
          GenerateBannerImageResponse,
          GenerateBannerImageResponseBuilder
        > {
  _$GenerateBannerImageResponse? _$v;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _errorMessage;
  String? get errorMessage => _$this._errorMessage;
  set errorMessage(String? errorMessage) => _$this._errorMessage = errorMessage;

  GenerateBannerImageResponseBuilder() {
    GenerateBannerImageResponse._defaults(this);
  }

  GenerateBannerImageResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _imageUrl = $v.imageUrl;
      _success = $v.success;
      _errorMessage = $v.errorMessage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GenerateBannerImageResponse other) {
    _$v = other as _$GenerateBannerImageResponse;
  }

  @override
  void update(void Function(GenerateBannerImageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenerateBannerImageResponse build() => _build();

  _$GenerateBannerImageResponse _build() {
    final _$result =
        _$v ??
        _$GenerateBannerImageResponse._(
          imageUrl: imageUrl,
          success: success,
          errorMessage: errorMessage,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
