// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_message.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConversationMessage extends ConversationMessage {
  @override
  final String? role;
  @override
  final String? content;
  @override
  final DateTime? timestamp;

  factory _$ConversationMessage([
    void Function(ConversationMessageBuilder)? updates,
  ]) => (ConversationMessageBuilder()..update(updates))._build();

  _$ConversationMessage._({this.role, this.content, this.timestamp})
    : super._();
  @override
  ConversationMessage rebuild(
    void Function(ConversationMessageBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ConversationMessageBuilder toBuilder() =>
      ConversationMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConversationMessage &&
        role == other.role &&
        content == other.content &&
        timestamp == other.timestamp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConversationMessage')
          ..add('role', role)
          ..add('content', content)
          ..add('timestamp', timestamp))
        .toString();
  }
}

class ConversationMessageBuilder
    implements Builder<ConversationMessage, ConversationMessageBuilder> {
  _$ConversationMessage? _$v;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  DateTime? _timestamp;
  DateTime? get timestamp => _$this._timestamp;
  set timestamp(DateTime? timestamp) => _$this._timestamp = timestamp;

  ConversationMessageBuilder() {
    ConversationMessage._defaults(this);
  }

  ConversationMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _role = $v.role;
      _content = $v.content;
      _timestamp = $v.timestamp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConversationMessage other) {
    _$v = other as _$ConversationMessage;
  }

  @override
  void update(void Function(ConversationMessageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConversationMessage build() => _build();

  _$ConversationMessage _build() {
    final _$result =
        _$v ??
        _$ConversationMessage._(
          role: role,
          content: content,
          timestamp: timestamp,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
