// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChatRequest extends ChatRequest {
  @override
  final String message;
  @override
  final BuiltList<BuiltMap<String, String>>? history;
  @override
  final String? systemPrompt;

  factory _$ChatRequest([void Function(ChatRequestBuilder)? updates]) =>
      (ChatRequestBuilder()..update(updates))._build();

  _$ChatRequest._({required this.message, this.history, this.systemPrompt})
    : super._();
  @override
  ChatRequest rebuild(void Function(ChatRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatRequestBuilder toBuilder() => ChatRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatRequest &&
        message == other.message &&
        history == other.history &&
        systemPrompt == other.systemPrompt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, history.hashCode);
    _$hash = $jc(_$hash, systemPrompt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatRequest')
          ..add('message', message)
          ..add('history', history)
          ..add('systemPrompt', systemPrompt))
        .toString();
  }
}

class ChatRequestBuilder implements Builder<ChatRequest, ChatRequestBuilder> {
  _$ChatRequest? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<BuiltMap<String, String>>? _history;
  ListBuilder<BuiltMap<String, String>> get history =>
      _$this._history ??= ListBuilder<BuiltMap<String, String>>();
  set history(ListBuilder<BuiltMap<String, String>>? history) =>
      _$this._history = history;

  String? _systemPrompt;
  String? get systemPrompt => _$this._systemPrompt;
  set systemPrompt(String? systemPrompt) => _$this._systemPrompt = systemPrompt;

  ChatRequestBuilder() {
    ChatRequest._defaults(this);
  }

  ChatRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _history = $v.history?.toBuilder();
      _systemPrompt = $v.systemPrompt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatRequest other) {
    _$v = other as _$ChatRequest;
  }

  @override
  void update(void Function(ChatRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatRequest build() => _build();

  _$ChatRequest _build() {
    _$ChatRequest _$result;
    try {
      _$result =
          _$v ??
          _$ChatRequest._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'ChatRequest',
              'message',
            ),
            history: _history?.build(),
            systemPrompt: systemPrompt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'history';
        _history?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ChatRequest',
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
