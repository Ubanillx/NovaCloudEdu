// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_session_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChatSessionResponse extends ChatSessionResponse {
  @override
  final int? sessionId;
  @override
  final int? partnerId;
  @override
  final String? partnerName;
  @override
  final String? partnerAvatar;
  @override
  final DateTime? lastMessageTime;
  @override
  final int? unreadCount;

  factory _$ChatSessionResponse([
    void Function(ChatSessionResponseBuilder)? updates,
  ]) => (ChatSessionResponseBuilder()..update(updates))._build();

  _$ChatSessionResponse._({
    this.sessionId,
    this.partnerId,
    this.partnerName,
    this.partnerAvatar,
    this.lastMessageTime,
    this.unreadCount,
  }) : super._();
  @override
  ChatSessionResponse rebuild(
    void Function(ChatSessionResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ChatSessionResponseBuilder toBuilder() =>
      ChatSessionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatSessionResponse &&
        sessionId == other.sessionId &&
        partnerId == other.partnerId &&
        partnerName == other.partnerName &&
        partnerAvatar == other.partnerAvatar &&
        lastMessageTime == other.lastMessageTime &&
        unreadCount == other.unreadCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sessionId.hashCode);
    _$hash = $jc(_$hash, partnerId.hashCode);
    _$hash = $jc(_$hash, partnerName.hashCode);
    _$hash = $jc(_$hash, partnerAvatar.hashCode);
    _$hash = $jc(_$hash, lastMessageTime.hashCode);
    _$hash = $jc(_$hash, unreadCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatSessionResponse')
          ..add('sessionId', sessionId)
          ..add('partnerId', partnerId)
          ..add('partnerName', partnerName)
          ..add('partnerAvatar', partnerAvatar)
          ..add('lastMessageTime', lastMessageTime)
          ..add('unreadCount', unreadCount))
        .toString();
  }
}

class ChatSessionResponseBuilder
    implements Builder<ChatSessionResponse, ChatSessionResponseBuilder> {
  _$ChatSessionResponse? _$v;

  int? _sessionId;
  int? get sessionId => _$this._sessionId;
  set sessionId(int? sessionId) => _$this._sessionId = sessionId;

  int? _partnerId;
  int? get partnerId => _$this._partnerId;
  set partnerId(int? partnerId) => _$this._partnerId = partnerId;

  String? _partnerName;
  String? get partnerName => _$this._partnerName;
  set partnerName(String? partnerName) => _$this._partnerName = partnerName;

  String? _partnerAvatar;
  String? get partnerAvatar => _$this._partnerAvatar;
  set partnerAvatar(String? partnerAvatar) =>
      _$this._partnerAvatar = partnerAvatar;

  DateTime? _lastMessageTime;
  DateTime? get lastMessageTime => _$this._lastMessageTime;
  set lastMessageTime(DateTime? lastMessageTime) =>
      _$this._lastMessageTime = lastMessageTime;

  int? _unreadCount;
  int? get unreadCount => _$this._unreadCount;
  set unreadCount(int? unreadCount) => _$this._unreadCount = unreadCount;

  ChatSessionResponseBuilder() {
    ChatSessionResponse._defaults(this);
  }

  ChatSessionResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sessionId = $v.sessionId;
      _partnerId = $v.partnerId;
      _partnerName = $v.partnerName;
      _partnerAvatar = $v.partnerAvatar;
      _lastMessageTime = $v.lastMessageTime;
      _unreadCount = $v.unreadCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatSessionResponse other) {
    _$v = other as _$ChatSessionResponse;
  }

  @override
  void update(void Function(ChatSessionResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatSessionResponse build() => _build();

  _$ChatSessionResponse _build() {
    final _$result =
        _$v ??
        _$ChatSessionResponse._(
          sessionId: sessionId,
          partnerId: partnerId,
          partnerName: partnerName,
          partnerAvatar: partnerAvatar,
          lastMessageTime: lastMessageTime,
          unreadCount: unreadCount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
