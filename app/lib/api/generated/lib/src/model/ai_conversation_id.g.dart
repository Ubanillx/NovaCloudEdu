// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_conversation_id.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AiConversationId extends AiConversationId {
  @override
  final int? value;

  factory _$AiConversationId([
    void Function(AiConversationIdBuilder)? updates,
  ]) => (AiConversationIdBuilder()..update(updates))._build();

  _$AiConversationId._({this.value}) : super._();
  @override
  AiConversationId rebuild(void Function(AiConversationIdBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AiConversationIdBuilder toBuilder() =>
      AiConversationIdBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AiConversationId && value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AiConversationId',
    )..add('value', value)).toString();
  }
}

class AiConversationIdBuilder
    implements Builder<AiConversationId, AiConversationIdBuilder> {
  _$AiConversationId? _$v;

  int? _value;
  int? get value => _$this._value;
  set value(int? value) => _$this._value = value;

  AiConversationIdBuilder() {
    AiConversationId._defaults(this);
  }

  AiConversationIdBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AiConversationId other) {
    _$v = other as _$AiConversationId;
  }

  @override
  void update(void Function(AiConversationIdBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AiConversationId build() => _build();

  _$AiConversationId _build() {
    final _$result = _$v ?? _$AiConversationId._(value: value);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
