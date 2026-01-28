// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_ai_conversation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseAiConversation extends BaseResponseAiConversation {
  @override
  final int? code;
  @override
  final AiConversation? data;
  @override
  final String? message;

  factory _$BaseResponseAiConversation([
    void Function(BaseResponseAiConversationBuilder)? updates,
  ]) => (BaseResponseAiConversationBuilder()..update(updates))._build();

  _$BaseResponseAiConversation._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseAiConversation rebuild(
    void Function(BaseResponseAiConversationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseAiConversationBuilder toBuilder() =>
      BaseResponseAiConversationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseAiConversation &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseAiConversation')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseAiConversationBuilder
    implements
        Builder<BaseResponseAiConversation, BaseResponseAiConversationBuilder> {
  _$BaseResponseAiConversation? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  AiConversationBuilder? _data;
  AiConversationBuilder get data => _$this._data ??= AiConversationBuilder();
  set data(AiConversationBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseAiConversationBuilder() {
    BaseResponseAiConversation._defaults(this);
  }

  BaseResponseAiConversationBuilder get _$this {
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
  void replace(BaseResponseAiConversation other) {
    _$v = other as _$BaseResponseAiConversation;
  }

  @override
  void update(void Function(BaseResponseAiConversationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseAiConversation build() => _build();

  _$BaseResponseAiConversation _build() {
    _$BaseResponseAiConversation _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseAiConversation._(
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
          r'BaseResponseAiConversation',
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
