// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_follow_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseFollowPageResponse extends BaseResponseFollowPageResponse {
  @override
  final int? code;
  @override
  final FollowPageResponse? data;
  @override
  final String? message;

  factory _$BaseResponseFollowPageResponse([
    void Function(BaseResponseFollowPageResponseBuilder)? updates,
  ]) => (BaseResponseFollowPageResponseBuilder()..update(updates))._build();

  _$BaseResponseFollowPageResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseFollowPageResponse rebuild(
    void Function(BaseResponseFollowPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseFollowPageResponseBuilder toBuilder() =>
      BaseResponseFollowPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseFollowPageResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseFollowPageResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseFollowPageResponseBuilder
    implements
        Builder<
          BaseResponseFollowPageResponse,
          BaseResponseFollowPageResponseBuilder
        > {
  _$BaseResponseFollowPageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  FollowPageResponseBuilder? _data;
  FollowPageResponseBuilder get data =>
      _$this._data ??= FollowPageResponseBuilder();
  set data(FollowPageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseFollowPageResponseBuilder() {
    BaseResponseFollowPageResponse._defaults(this);
  }

  BaseResponseFollowPageResponseBuilder get _$this {
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
  void replace(BaseResponseFollowPageResponse other) {
    _$v = other as _$BaseResponseFollowPageResponse;
  }

  @override
  void update(void Function(BaseResponseFollowPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseFollowPageResponse build() => _build();

  _$BaseResponseFollowPageResponse _build() {
    _$BaseResponseFollowPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseFollowPageResponse._(
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
          r'BaseResponseFollowPageResponse',
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
