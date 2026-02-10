// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_message_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GroupMessageItem extends GroupMessageItem {
  @override
  final int? messageId;
  @override
  final int? groupId;
  @override
  final int? senderType;
  @override
  final int? senderId;
  @override
  final int? aiRoleId;
  @override
  final String? senderName;
  @override
  final String? senderAvatar;
  @override
  final String? content;
  @override
  final String? type;
  @override
  final int? replyTo;
  @override
  final DateTime? createTime;
  @override
  final int? readCount;

  factory _$GroupMessageItem([
    void Function(GroupMessageItemBuilder)? updates,
  ]) => (GroupMessageItemBuilder()..update(updates))._build();

  _$GroupMessageItem._({
    this.messageId,
    this.groupId,
    this.senderType,
    this.senderId,
    this.aiRoleId,
    this.senderName,
    this.senderAvatar,
    this.content,
    this.type,
    this.replyTo,
    this.createTime,
    this.readCount,
  }) : super._();
  @override
  GroupMessageItem rebuild(void Function(GroupMessageItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GroupMessageItemBuilder toBuilder() =>
      GroupMessageItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GroupMessageItem &&
        messageId == other.messageId &&
        groupId == other.groupId &&
        senderType == other.senderType &&
        senderId == other.senderId &&
        aiRoleId == other.aiRoleId &&
        senderName == other.senderName &&
        senderAvatar == other.senderAvatar &&
        content == other.content &&
        type == other.type &&
        replyTo == other.replyTo &&
        createTime == other.createTime &&
        readCount == other.readCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, messageId.hashCode);
    _$hash = $jc(_$hash, groupId.hashCode);
    _$hash = $jc(_$hash, senderType.hashCode);
    _$hash = $jc(_$hash, senderId.hashCode);
    _$hash = $jc(_$hash, aiRoleId.hashCode);
    _$hash = $jc(_$hash, senderName.hashCode);
    _$hash = $jc(_$hash, senderAvatar.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, replyTo.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, readCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GroupMessageItem')
          ..add('messageId', messageId)
          ..add('groupId', groupId)
          ..add('senderType', senderType)
          ..add('senderId', senderId)
          ..add('aiRoleId', aiRoleId)
          ..add('senderName', senderName)
          ..add('senderAvatar', senderAvatar)
          ..add('content', content)
          ..add('type', type)
          ..add('replyTo', replyTo)
          ..add('createTime', createTime)
          ..add('readCount', readCount))
        .toString();
  }
}

class GroupMessageItemBuilder
    implements Builder<GroupMessageItem, GroupMessageItemBuilder> {
  _$GroupMessageItem? _$v;

  int? _messageId;
  int? get messageId => _$this._messageId;
  set messageId(int? messageId) => _$this._messageId = messageId;

  int? _groupId;
  int? get groupId => _$this._groupId;
  set groupId(int? groupId) => _$this._groupId = groupId;

  int? _senderType;
  int? get senderType => _$this._senderType;
  set senderType(int? senderType) => _$this._senderType = senderType;

  int? _senderId;
  int? get senderId => _$this._senderId;
  set senderId(int? senderId) => _$this._senderId = senderId;

  int? _aiRoleId;
  int? get aiRoleId => _$this._aiRoleId;
  set aiRoleId(int? aiRoleId) => _$this._aiRoleId = aiRoleId;

  String? _senderName;
  String? get senderName => _$this._senderName;
  set senderName(String? senderName) => _$this._senderName = senderName;

  String? _senderAvatar;
  String? get senderAvatar => _$this._senderAvatar;
  set senderAvatar(String? senderAvatar) => _$this._senderAvatar = senderAvatar;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  int? _replyTo;
  int? get replyTo => _$this._replyTo;
  set replyTo(int? replyTo) => _$this._replyTo = replyTo;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  int? _readCount;
  int? get readCount => _$this._readCount;
  set readCount(int? readCount) => _$this._readCount = readCount;

  GroupMessageItemBuilder() {
    GroupMessageItem._defaults(this);
  }

  GroupMessageItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _messageId = $v.messageId;
      _groupId = $v.groupId;
      _senderType = $v.senderType;
      _senderId = $v.senderId;
      _aiRoleId = $v.aiRoleId;
      _senderName = $v.senderName;
      _senderAvatar = $v.senderAvatar;
      _content = $v.content;
      _type = $v.type;
      _replyTo = $v.replyTo;
      _createTime = $v.createTime;
      _readCount = $v.readCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GroupMessageItem other) {
    _$v = other as _$GroupMessageItem;
  }

  @override
  void update(void Function(GroupMessageItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GroupMessageItem build() => _build();

  _$GroupMessageItem _build() {
    final _$result =
        _$v ??
        _$GroupMessageItem._(
          messageId: messageId,
          groupId: groupId,
          senderType: senderType,
          senderId: senderId,
          aiRoleId: aiRoleId,
          senderName: senderName,
          senderAvatar: senderAvatar,
          content: content,
          type: type,
          replyTo: replyTo,
          createTime: createTime,
          readCount: readCount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
