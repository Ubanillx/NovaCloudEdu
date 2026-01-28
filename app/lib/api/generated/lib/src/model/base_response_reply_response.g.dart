// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_reply_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseReplyResponse extends BaseResponseReplyResponse {
  @override
  final int? code;
  @override
  final ReplyResponse? data;
  @override
  final String? message;

  factory _$BaseResponseReplyResponse([
    void Function(BaseResponseReplyResponseBuilder)? updates,
  ]) => (BaseResponseReplyResponseBuilder()..update(updates))._build();

  _$BaseResponseReplyResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseReplyResponse rebuild(
    void Function(BaseResponseReplyResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseReplyResponseBuilder toBuilder() =>
      BaseResponseReplyResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseReplyResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseReplyResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseReplyResponseBuilder
    implements
        Builder<BaseResponseReplyResponse, BaseResponseReplyResponseBuilder> {
  _$BaseResponseReplyResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ReplyResponseBuilder? _data;
  ReplyResponseBuilder get data => _$this._data ??= ReplyResponseBuilder();
  set data(ReplyResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseReplyResponseBuilder() {
    BaseResponseReplyResponse._defaults(this);
  }

  BaseResponseReplyResponseBuilder get _$this {
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
  void replace(BaseResponseReplyResponse other) {
    _$v = other as _$BaseResponseReplyResponse;
  }

  @override
  void update(void Function(BaseResponseReplyResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseReplyResponse build() => _build();

  _$BaseResponseReplyResponse _build() {
    _$BaseResponseReplyResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseReplyResponse._(
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
          r'BaseResponseReplyResponse',
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
