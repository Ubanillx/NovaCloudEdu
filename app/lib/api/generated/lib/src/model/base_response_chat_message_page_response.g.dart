// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_chat_message_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseChatMessagePageResponse
    extends BaseResponseChatMessagePageResponse {
  @override
  final int? code;
  @override
  final ChatMessagePageResponse? data;
  @override
  final String? message;

  factory _$BaseResponseChatMessagePageResponse([
    void Function(BaseResponseChatMessagePageResponseBuilder)? updates,
  ]) =>
      (BaseResponseChatMessagePageResponseBuilder()..update(updates))._build();

  _$BaseResponseChatMessagePageResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseChatMessagePageResponse rebuild(
    void Function(BaseResponseChatMessagePageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseChatMessagePageResponseBuilder toBuilder() =>
      BaseResponseChatMessagePageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseChatMessagePageResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseChatMessagePageResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseChatMessagePageResponseBuilder
    implements
        Builder<
          BaseResponseChatMessagePageResponse,
          BaseResponseChatMessagePageResponseBuilder
        > {
  _$BaseResponseChatMessagePageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ChatMessagePageResponseBuilder? _data;
  ChatMessagePageResponseBuilder get data =>
      _$this._data ??= ChatMessagePageResponseBuilder();
  set data(ChatMessagePageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseChatMessagePageResponseBuilder() {
    BaseResponseChatMessagePageResponse._defaults(this);
  }

  BaseResponseChatMessagePageResponseBuilder get _$this {
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
  void replace(BaseResponseChatMessagePageResponse other) {
    _$v = other as _$BaseResponseChatMessagePageResponse;
  }

  @override
  void update(
    void Function(BaseResponseChatMessagePageResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseChatMessagePageResponse build() => _build();

  _$BaseResponseChatMessagePageResponse _build() {
    _$BaseResponseChatMessagePageResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseChatMessagePageResponse._(
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
          r'BaseResponseChatMessagePageResponse',
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
