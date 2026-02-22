// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_avatar_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GenerateAvatarResponse extends GenerateAvatarResponse {
  @override
  final String? imageUrl;
  @override
  final bool? success;
  @override
  final String? errorMessage;

  factory _$GenerateAvatarResponse([
    void Function(GenerateAvatarResponseBuilder)? updates,
  ]) => (GenerateAvatarResponseBuilder()..update(updates))._build();

  _$GenerateAvatarResponse._({this.imageUrl, this.success, this.errorMessage})
    : super._();
  @override
  GenerateAvatarResponse rebuild(
    void Function(GenerateAvatarResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GenerateAvatarResponseBuilder toBuilder() =>
      GenerateAvatarResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenerateAvatarResponse &&
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
    return (newBuiltValueToStringHelper(r'GenerateAvatarResponse')
          ..add('imageUrl', imageUrl)
          ..add('success', success)
          ..add('errorMessage', errorMessage))
        .toString();
  }
}

class GenerateAvatarResponseBuilder
    implements Builder<GenerateAvatarResponse, GenerateAvatarResponseBuilder> {
  _$GenerateAvatarResponse? _$v;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _errorMessage;
  String? get errorMessage => _$this._errorMessage;
  set errorMessage(String? errorMessage) => _$this._errorMessage = errorMessage;

  GenerateAvatarResponseBuilder() {
    GenerateAvatarResponse._defaults(this);
  }

  GenerateAvatarResponseBuilder get _$this {
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
  void replace(GenerateAvatarResponse other) {
    _$v = other as _$GenerateAvatarResponse;
  }

  @override
  void update(void Function(GenerateAvatarResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenerateAvatarResponse build() => _build();

  _$GenerateAvatarResponse _build() {
    final _$result =
        _$v ??
        _$GenerateAvatarResponse._(
          imageUrl: imageUrl,
          success: success,
          errorMessage: errorMessage,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
