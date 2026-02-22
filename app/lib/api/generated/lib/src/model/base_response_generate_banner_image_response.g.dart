// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_generate_banner_image_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseGenerateBannerImageResponse
    extends BaseResponseGenerateBannerImageResponse {
  @override
  final int? code;
  @override
  final GenerateBannerImageResponse? data;
  @override
  final String? message;

  factory _$BaseResponseGenerateBannerImageResponse([
    void Function(BaseResponseGenerateBannerImageResponseBuilder)? updates,
  ]) => (BaseResponseGenerateBannerImageResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseGenerateBannerImageResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseGenerateBannerImageResponse rebuild(
    void Function(BaseResponseGenerateBannerImageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseGenerateBannerImageResponseBuilder toBuilder() =>
      BaseResponseGenerateBannerImageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseGenerateBannerImageResponse &&
        code == other.code &&
        data == other.data &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'BaseResponseGenerateBannerImageResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseGenerateBannerImageResponseBuilder
    implements
        Builder<
          BaseResponseGenerateBannerImageResponse,
          BaseResponseGenerateBannerImageResponseBuilder
        > {
  _$BaseResponseGenerateBannerImageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  GenerateBannerImageResponseBuilder? _data;
  GenerateBannerImageResponseBuilder get data =>
      _$this._data ??= GenerateBannerImageResponseBuilder();
  set data(GenerateBannerImageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseGenerateBannerImageResponseBuilder() {
    BaseResponseGenerateBannerImageResponse._defaults(this);
  }

  BaseResponseGenerateBannerImageResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _data = $v.data?.toBuilder();
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BaseResponseGenerateBannerImageResponse other) {
    _$v = other as _$BaseResponseGenerateBannerImageResponse;
  }

  @override
  void update(
    void Function(BaseResponseGenerateBannerImageResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseGenerateBannerImageResponse build() => _build();

  _$BaseResponseGenerateBannerImageResponse _build() {
    _$BaseResponseGenerateBannerImageResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseGenerateBannerImageResponse._(
            code: code,
            data: _data?.build(),
            message: message,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'BaseResponseGenerateBannerImageResponse',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
