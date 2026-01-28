// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_friend_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseFriendPageResponse extends BaseResponseFriendPageResponse {
  @override
  final int? code;
  @override
  final FriendPageResponse? data;
  @override
  final String? message;

  factory _$BaseResponseFriendPageResponse([
    void Function(BaseResponseFriendPageResponseBuilder)? updates,
  ]) => (BaseResponseFriendPageResponseBuilder()..update(updates))._build();

  _$BaseResponseFriendPageResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseFriendPageResponse rebuild(
    void Function(BaseResponseFriendPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseFriendPageResponseBuilder toBuilder() =>
      BaseResponseFriendPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseFriendPageResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseFriendPageResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseFriendPageResponseBuilder
    implements
        Builder<
          BaseResponseFriendPageResponse,
          BaseResponseFriendPageResponseBuilder
        > {
  _$BaseResponseFriendPageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  FriendPageResponseBuilder? _data;
  FriendPageResponseBuilder get data =>
      _$this._data ??= FriendPageResponseBuilder();
  set data(FriendPageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseFriendPageResponseBuilder() {
    BaseResponseFriendPageResponse._defaults(this);
  }

  BaseResponseFriendPageResponseBuilder get _$this {
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
  void replace(BaseResponseFriendPageResponse other) {
    _$v = other as _$BaseResponseFriendPageResponse;
  }

  @override
  void update(void Function(BaseResponseFriendPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseFriendPageResponse build() => _build();

  _$BaseResponseFriendPageResponse _build() {
    _$BaseResponseFriendPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseFriendPageResponse._(
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
          r'BaseResponseFriendPageResponse',
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
