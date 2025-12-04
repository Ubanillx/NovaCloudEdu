// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_user_public_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseUserPublicResponse extends BaseResponseUserPublicResponse {
  @override
  final int? code;
  @override
  final UserPublicResponse? data;
  @override
  final String? message;

  factory _$BaseResponseUserPublicResponse(
          [void Function(BaseResponseUserPublicResponseBuilder)? updates]) =>
      (BaseResponseUserPublicResponseBuilder()..update(updates))._build();

  _$BaseResponseUserPublicResponse._({this.code, this.data, this.message})
      : super._();
  @override
  BaseResponseUserPublicResponse rebuild(
          void Function(BaseResponseUserPublicResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseResponseUserPublicResponseBuilder toBuilder() =>
      BaseResponseUserPublicResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseUserPublicResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseUserPublicResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseUserPublicResponseBuilder
    implements
        Builder<BaseResponseUserPublicResponse,
            BaseResponseUserPublicResponseBuilder> {
  _$BaseResponseUserPublicResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  UserPublicResponseBuilder? _data;
  UserPublicResponseBuilder get data =>
      _$this._data ??= UserPublicResponseBuilder();
  set data(UserPublicResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseUserPublicResponseBuilder() {
    BaseResponseUserPublicResponse._defaults(this);
  }

  BaseResponseUserPublicResponseBuilder get _$this {
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
  void replace(BaseResponseUserPublicResponse other) {
    _$v = other as _$BaseResponseUserPublicResponse;
  }

  @override
  void update(void Function(BaseResponseUserPublicResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseUserPublicResponse build() => _build();

  _$BaseResponseUserPublicResponse _build() {
    _$BaseResponseUserPublicResponse _$result;
    try {
      _$result = _$v ??
          _$BaseResponseUserPublicResponse._(
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
            r'BaseResponseUserPublicResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
