// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_user_detail_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseUserDetailResponse extends BaseResponseUserDetailResponse {
  @override
  final int? code;
  @override
  final UserDetailResponse? data;
  @override
  final String? message;

  factory _$BaseResponseUserDetailResponse(
          [void Function(BaseResponseUserDetailResponseBuilder)? updates]) =>
      (BaseResponseUserDetailResponseBuilder()..update(updates))._build();

  _$BaseResponseUserDetailResponse._({this.code, this.data, this.message})
      : super._();
  @override
  BaseResponseUserDetailResponse rebuild(
          void Function(BaseResponseUserDetailResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseResponseUserDetailResponseBuilder toBuilder() =>
      BaseResponseUserDetailResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseUserDetailResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseUserDetailResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseUserDetailResponseBuilder
    implements
        Builder<BaseResponseUserDetailResponse,
            BaseResponseUserDetailResponseBuilder> {
  _$BaseResponseUserDetailResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  UserDetailResponseBuilder? _data;
  UserDetailResponseBuilder get data =>
      _$this._data ??= UserDetailResponseBuilder();
  set data(UserDetailResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseUserDetailResponseBuilder() {
    BaseResponseUserDetailResponse._defaults(this);
  }

  BaseResponseUserDetailResponseBuilder get _$this {
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
  void replace(BaseResponseUserDetailResponse other) {
    _$v = other as _$BaseResponseUserDetailResponse;
  }

  @override
  void update(void Function(BaseResponseUserDetailResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseUserDetailResponse build() => _build();

  _$BaseResponseUserDetailResponse _build() {
    _$BaseResponseUserDetailResponse _$result;
    try {
      _$result = _$v ??
          _$BaseResponseUserDetailResponse._(
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
            r'BaseResponseUserDetailResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
