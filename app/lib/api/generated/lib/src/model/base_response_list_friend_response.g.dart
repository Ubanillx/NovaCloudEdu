// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_friend_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListFriendResponse extends BaseResponseListFriendResponse {
  @override
  final int? code;
  @override
  final BuiltList<FriendResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListFriendResponse([
    void Function(BaseResponseListFriendResponseBuilder)? updates,
  ]) => (BaseResponseListFriendResponseBuilder()..update(updates))._build();

  _$BaseResponseListFriendResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListFriendResponse rebuild(
    void Function(BaseResponseListFriendResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListFriendResponseBuilder toBuilder() =>
      BaseResponseListFriendResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListFriendResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListFriendResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListFriendResponseBuilder
    implements
        Builder<
          BaseResponseListFriendResponse,
          BaseResponseListFriendResponseBuilder
        > {
  _$BaseResponseListFriendResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<FriendResponse>? _data;
  ListBuilder<FriendResponse> get data =>
      _$this._data ??= ListBuilder<FriendResponse>();
  set data(ListBuilder<FriendResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListFriendResponseBuilder() {
    BaseResponseListFriendResponse._defaults(this);
  }

  BaseResponseListFriendResponseBuilder get _$this {
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
  void replace(BaseResponseListFriendResponse other) {
    _$v = other as _$BaseResponseListFriendResponse;
  }

  @override
  void update(void Function(BaseResponseListFriendResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListFriendResponse build() => _build();

  _$BaseResponseListFriendResponse _build() {
    _$BaseResponseListFriendResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListFriendResponse._(
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
          r'BaseResponseListFriendResponse',
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
