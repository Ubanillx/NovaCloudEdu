// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_refresh_token_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseRefreshTokenResponse
    extends BaseResponseRefreshTokenResponse {
  @override
  final int? code;
  @override
  final RefreshTokenResponse? data;
  @override
  final String? message;

  factory _$BaseResponseRefreshTokenResponse([
    void Function(BaseResponseRefreshTokenResponseBuilder)? updates,
  ]) => (BaseResponseRefreshTokenResponseBuilder()..update(updates))._build();

  _$BaseResponseRefreshTokenResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseRefreshTokenResponse rebuild(
    void Function(BaseResponseRefreshTokenResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseRefreshTokenResponseBuilder toBuilder() =>
      BaseResponseRefreshTokenResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseRefreshTokenResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseRefreshTokenResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseRefreshTokenResponseBuilder
    implements
        Builder<
          BaseResponseRefreshTokenResponse,
          BaseResponseRefreshTokenResponseBuilder
        > {
  _$BaseResponseRefreshTokenResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  RefreshTokenResponseBuilder? _data;
  RefreshTokenResponseBuilder get data =>
      _$this._data ??= RefreshTokenResponseBuilder();
  set data(RefreshTokenResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseRefreshTokenResponseBuilder() {
    BaseResponseRefreshTokenResponse._defaults(this);
  }

  BaseResponseRefreshTokenResponseBuilder get _$this {
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
  void replace(BaseResponseRefreshTokenResponse other) {
    _$v = other as _$BaseResponseRefreshTokenResponse;
  }

  @override
  void update(void Function(BaseResponseRefreshTokenResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseRefreshTokenResponse build() => _build();

  _$BaseResponseRefreshTokenResponse _build() {
    _$BaseResponseRefreshTokenResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseRefreshTokenResponse._(
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
          r'BaseResponseRefreshTokenResponse',
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
