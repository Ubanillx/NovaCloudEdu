// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_chat_session_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListChatSessionResponse
    extends BaseResponseListChatSessionResponse {
  @override
  final int? code;
  @override
  final BuiltList<ChatSessionResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListChatSessionResponse([
    void Function(BaseResponseListChatSessionResponseBuilder)? updates,
  ]) =>
      (BaseResponseListChatSessionResponseBuilder()..update(updates))._build();

  _$BaseResponseListChatSessionResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListChatSessionResponse rebuild(
    void Function(BaseResponseListChatSessionResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListChatSessionResponseBuilder toBuilder() =>
      BaseResponseListChatSessionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListChatSessionResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListChatSessionResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListChatSessionResponseBuilder
    implements
        Builder<
          BaseResponseListChatSessionResponse,
          BaseResponseListChatSessionResponseBuilder
        > {
  _$BaseResponseListChatSessionResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<ChatSessionResponse>? _data;
  ListBuilder<ChatSessionResponse> get data =>
      _$this._data ??= ListBuilder<ChatSessionResponse>();
  set data(ListBuilder<ChatSessionResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListChatSessionResponseBuilder() {
    BaseResponseListChatSessionResponse._defaults(this);
  }

  BaseResponseListChatSessionResponseBuilder get _$this {
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
  void replace(BaseResponseListChatSessionResponse other) {
    _$v = other as _$BaseResponseListChatSessionResponse;
  }

  @override
  void update(
    void Function(BaseResponseListChatSessionResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListChatSessionResponse build() => _build();

  _$BaseResponseListChatSessionResponse _build() {
    _$BaseResponseListChatSessionResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListChatSessionResponse._(
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
          r'BaseResponseListChatSessionResponse',
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
