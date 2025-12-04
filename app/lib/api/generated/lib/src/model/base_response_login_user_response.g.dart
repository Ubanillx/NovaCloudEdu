// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_login_user_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseLoginUserResponse extends BaseResponseLoginUserResponse {
  @override
  final int? code;
  @override
  final LoginUserResponse? data;
  @override
  final String? message;

  factory _$BaseResponseLoginUserResponse(
          [void Function(BaseResponseLoginUserResponseBuilder)? updates]) =>
      (BaseResponseLoginUserResponseBuilder()..update(updates))._build();

  _$BaseResponseLoginUserResponse._({this.code, this.data, this.message})
      : super._();
  @override
  BaseResponseLoginUserResponse rebuild(
          void Function(BaseResponseLoginUserResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseResponseLoginUserResponseBuilder toBuilder() =>
      BaseResponseLoginUserResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseLoginUserResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseLoginUserResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseLoginUserResponseBuilder
    implements
        Builder<BaseResponseLoginUserResponse,
            BaseResponseLoginUserResponseBuilder> {
  _$BaseResponseLoginUserResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  LoginUserResponseBuilder? _data;
  LoginUserResponseBuilder get data =>
      _$this._data ??= LoginUserResponseBuilder();
  set data(LoginUserResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseLoginUserResponseBuilder() {
    BaseResponseLoginUserResponse._defaults(this);
  }

  BaseResponseLoginUserResponseBuilder get _$this {
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
  void replace(BaseResponseLoginUserResponse other) {
    _$v = other as _$BaseResponseLoginUserResponse;
  }

  @override
  void update(void Function(BaseResponseLoginUserResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseLoginUserResponse build() => _build();

  _$BaseResponseLoginUserResponse _build() {
    _$BaseResponseLoginUserResponse _$result;
    try {
      _$result = _$v ??
          _$BaseResponseLoginUserResponse._(
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
            r'BaseResponseLoginUserResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
