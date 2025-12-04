// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_user_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseUserPageResponse extends BaseResponseUserPageResponse {
  @override
  final int? code;
  @override
  final UserPageResponse? data;
  @override
  final String? message;

  factory _$BaseResponseUserPageResponse(
          [void Function(BaseResponseUserPageResponseBuilder)? updates]) =>
      (BaseResponseUserPageResponseBuilder()..update(updates))._build();

  _$BaseResponseUserPageResponse._({this.code, this.data, this.message})
      : super._();
  @override
  BaseResponseUserPageResponse rebuild(
          void Function(BaseResponseUserPageResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseResponseUserPageResponseBuilder toBuilder() =>
      BaseResponseUserPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseUserPageResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseUserPageResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseUserPageResponseBuilder
    implements
        Builder<BaseResponseUserPageResponse,
            BaseResponseUserPageResponseBuilder> {
  _$BaseResponseUserPageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  UserPageResponseBuilder? _data;
  UserPageResponseBuilder get data =>
      _$this._data ??= UserPageResponseBuilder();
  set data(UserPageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseUserPageResponseBuilder() {
    BaseResponseUserPageResponse._defaults(this);
  }

  BaseResponseUserPageResponseBuilder get _$this {
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
  void replace(BaseResponseUserPageResponse other) {
    _$v = other as _$BaseResponseUserPageResponse;
  }

  @override
  void update(void Function(BaseResponseUserPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseUserPageResponse build() => _build();

  _$BaseResponseUserPageResponse _build() {
    _$BaseResponseUserPageResponse _$result;
    try {
      _$result = _$v ??
          _$BaseResponseUserPageResponse._(
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
            r'BaseResponseUserPageResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
