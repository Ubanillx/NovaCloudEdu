// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_friend_request_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseFriendRequestPageResponse
    extends BaseResponseFriendRequestPageResponse {
  @override
  final int? code;
  @override
  final FriendRequestPageResponse? data;
  @override
  final String? message;

  factory _$BaseResponseFriendRequestPageResponse([
    void Function(BaseResponseFriendRequestPageResponseBuilder)? updates,
  ]) => (BaseResponseFriendRequestPageResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseFriendRequestPageResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseFriendRequestPageResponse rebuild(
    void Function(BaseResponseFriendRequestPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseFriendRequestPageResponseBuilder toBuilder() =>
      BaseResponseFriendRequestPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseFriendRequestPageResponse &&
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
            r'BaseResponseFriendRequestPageResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseFriendRequestPageResponseBuilder
    implements
        Builder<
          BaseResponseFriendRequestPageResponse,
          BaseResponseFriendRequestPageResponseBuilder
        > {
  _$BaseResponseFriendRequestPageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  FriendRequestPageResponseBuilder? _data;
  FriendRequestPageResponseBuilder get data =>
      _$this._data ??= FriendRequestPageResponseBuilder();
  set data(FriendRequestPageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseFriendRequestPageResponseBuilder() {
    BaseResponseFriendRequestPageResponse._defaults(this);
  }

  BaseResponseFriendRequestPageResponseBuilder get _$this {
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
  void replace(BaseResponseFriendRequestPageResponse other) {
    _$v = other as _$BaseResponseFriendRequestPageResponse;
  }

  @override
  void update(
    void Function(BaseResponseFriendRequestPageResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseFriendRequestPageResponse build() => _build();

  _$BaseResponseFriendRequestPageResponse _build() {
    _$BaseResponseFriendRequestPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseFriendRequestPageResponse._(
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
          r'BaseResponseFriendRequestPageResponse',
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
