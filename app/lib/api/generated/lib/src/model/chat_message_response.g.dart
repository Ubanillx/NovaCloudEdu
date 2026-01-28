// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChatMessageResponse extends ChatMessageResponse {
  @override
  final int? messageId;
  @override
  final int? senderId;
  @override
  final String? senderName;
  @override
  final String? senderAvatar;
  @override
  final int? receiverId;
  @override
  final String? content;
  @override
  final String? type;
  @override
  final DateTime? createTime;
  @override
  final bool? read;

  factory _$ChatMessageResponse([
    void Function(ChatMessageResponseBuilder)? updates,
  ]) => (ChatMessageResponseBuilder()..update(updates))._build();

  _$ChatMessageResponse._({
    this.messageId,
    this.senderId,
    this.senderName,
    this.senderAvatar,
    this.receiverId,
    this.content,
    this.type,
    this.createTime,
    this.read,
  }) : super._();
  @override
  ChatMessageResponse rebuild(
    void Function(ChatMessageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ChatMessageResponseBuilder toBuilder() =>
      ChatMessageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatMessageResponse &&
        messageId == other.messageId &&
        senderId == other.senderId &&
        senderName == other.senderName &&
        senderAvatar == other.senderAvatar &&
        receiverId == other.receiverId &&
        content == other.content &&
        type == other.type &&
        createTime == other.createTime &&
        read == other.read;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, messageId.hashCode);
    _$hash = $jc(_$hash, senderId.hashCode);
    _$hash = $jc(_$hash, senderName.hashCode);
    _$hash = $jc(_$hash, senderAvatar.hashCode);
    _$hash = $jc(_$hash, receiverId.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, read.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatMessageResponse')
          ..add('messageId', messageId)
          ..add('senderId', senderId)
          ..add('senderName', senderName)
          ..add('senderAvatar', senderAvatar)
          ..add('receiverId', receiverId)
          ..add('content', content)
          ..add('type', type)
          ..add('createTime', createTime)
          ..add('read', read))
        .toString();
  }
}

class ChatMessageResponseBuilder
    implements Builder<ChatMessageResponse, ChatMessageResponseBuilder> {
  _$ChatMessageResponse? _$v;

  int? _messageId;
  int? get messageId => _$this._messageId;
  set messageId(int? messageId) => _$this._messageId = messageId;

  int? _senderId;
  int? get senderId => _$this._senderId;
  set senderId(int? senderId) => _$this._senderId = senderId;

  String? _senderName;
  String? get senderName => _$this._senderName;
  set senderName(String? senderName) => _$this._senderName = senderName;

  String? _senderAvatar;
  String? get senderAvatar => _$this._senderAvatar;
  set senderAvatar(String? senderAvatar) => _$this._senderAvatar = senderAvatar;

  int? _receiverId;
  int? get receiverId => _$this._receiverId;
  set receiverId(int? receiverId) => _$this._receiverId = receiverId;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  bool? _read;
  bool? get read => _$this._read;
  set read(bool? read) => _$this._read = read;

  ChatMessageResponseBuilder() {
    ChatMessageResponse._defaults(this);
  }

  ChatMessageResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _messageId = $v.messageId;
      _senderId = $v.senderId;
      _senderName = $v.senderName;
      _senderAvatar = $v.senderAvatar;
      _receiverId = $v.receiverId;
      _content = $v.content;
      _type = $v.type;
      _createTime = $v.createTime;
      _read = $v.read;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatMessageResponse other) {
    _$v = other as _$ChatMessageResponse;
  }

  @override
  void update(void Function(ChatMessageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatMessageResponse build() => _build();

  _$ChatMessageResponse _build() {
    final _$result =
        _$v ??
        _$ChatMessageResponse._(
          messageId: messageId,
          senderId: senderId,
          senderName: senderName,
          senderAvatar: senderAvatar,
          receiverId: receiverId,
          content: content,
          type: type,
          createTime: createTime,
          read: read,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
