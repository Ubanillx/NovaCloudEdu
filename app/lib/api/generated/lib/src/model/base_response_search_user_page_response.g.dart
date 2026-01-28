// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_search_user_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseSearchUserPageResponse
    extends BaseResponseSearchUserPageResponse {
  @override
  final int? code;
  @override
  final SearchUserPageResponse? data;
  @override
  final String? message;

  factory _$BaseResponseSearchUserPageResponse([
    void Function(BaseResponseSearchUserPageResponseBuilder)? updates,
  ]) => (BaseResponseSearchUserPageResponseBuilder()..update(updates))._build();

  _$BaseResponseSearchUserPageResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseSearchUserPageResponse rebuild(
    void Function(BaseResponseSearchUserPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseSearchUserPageResponseBuilder toBuilder() =>
      BaseResponseSearchUserPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseSearchUserPageResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseSearchUserPageResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseSearchUserPageResponseBuilder
    implements
        Builder<
          BaseResponseSearchUserPageResponse,
          BaseResponseSearchUserPageResponseBuilder
        > {
  _$BaseResponseSearchUserPageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  SearchUserPageResponseBuilder? _data;
  SearchUserPageResponseBuilder get data =>
      _$this._data ??= SearchUserPageResponseBuilder();
  set data(SearchUserPageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseSearchUserPageResponseBuilder() {
    BaseResponseSearchUserPageResponse._defaults(this);
  }

  BaseResponseSearchUserPageResponseBuilder get _$this {
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
  void replace(BaseResponseSearchUserPageResponse other) {
    _$v = other as _$BaseResponseSearchUserPageResponse;
  }

  @override
  void update(
    void Function(BaseResponseSearchUserPageResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseSearchUserPageResponse build() => _build();

  _$BaseResponseSearchUserPageResponse _build() {
    _$BaseResponseSearchUserPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseSearchUserPageResponse._(
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
          r'BaseResponseSearchUserPageResponse',
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
