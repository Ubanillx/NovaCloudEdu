// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_ai_conversation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListAiConversation extends BaseResponseListAiConversation {
  @override
  final int? code;
  @override
  final BuiltList<AiConversation>? data;
  @override
  final String? message;

  factory _$BaseResponseListAiConversation([
    void Function(BaseResponseListAiConversationBuilder)? updates,
  ]) => (BaseResponseListAiConversationBuilder()..update(updates))._build();

  _$BaseResponseListAiConversation._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListAiConversation rebuild(
    void Function(BaseResponseListAiConversationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListAiConversationBuilder toBuilder() =>
      BaseResponseListAiConversationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListAiConversation &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListAiConversation')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListAiConversationBuilder
    implements
        Builder<
          BaseResponseListAiConversation,
          BaseResponseListAiConversationBuilder
        > {
  _$BaseResponseListAiConversation? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<AiConversation>? _data;
  ListBuilder<AiConversation> get data =>
      _$this._data ??= ListBuilder<AiConversation>();
  set data(ListBuilder<AiConversation>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListAiConversationBuilder() {
    BaseResponseListAiConversation._defaults(this);
  }

  BaseResponseListAiConversationBuilder get _$this {
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
  void replace(BaseResponseListAiConversation other) {
    _$v = other as _$BaseResponseListAiConversation;
  }

  @override
  void update(void Function(BaseResponseListAiConversationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListAiConversation build() => _build();

  _$BaseResponseListAiConversation _build() {
    _$BaseResponseListAiConversation _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListAiConversation._(
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
          r'BaseResponseListAiConversation',
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
