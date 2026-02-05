// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_group_member.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ChatGroupMemberMemberTypeEnum _$chatGroupMemberMemberTypeEnum_USER =
    const ChatGroupMemberMemberTypeEnum._('USER');
const ChatGroupMemberMemberTypeEnum _$chatGroupMemberMemberTypeEnum_AI_ROLE =
    const ChatGroupMemberMemberTypeEnum._('AI_ROLE');

ChatGroupMemberMemberTypeEnum _$chatGroupMemberMemberTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'USER':
      return _$chatGroupMemberMemberTypeEnum_USER;
    case 'AI_ROLE':
      return _$chatGroupMemberMemberTypeEnum_AI_ROLE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ChatGroupMemberMemberTypeEnum>
_$chatGroupMemberMemberTypeEnumValues = BuiltSet<ChatGroupMemberMemberTypeEnum>(
  const <ChatGroupMemberMemberTypeEnum>[
    _$chatGroupMemberMemberTypeEnum_USER,
    _$chatGroupMemberMemberTypeEnum_AI_ROLE,
  ],
);

const ChatGroupMemberRoleEnum _$chatGroupMemberRoleEnum_MEMBER =
    const ChatGroupMemberRoleEnum._('MEMBER');
const ChatGroupMemberRoleEnum _$chatGroupMemberRoleEnum_ADMIN =
    const ChatGroupMemberRoleEnum._('ADMIN');
const ChatGroupMemberRoleEnum _$chatGroupMemberRoleEnum_OWNER =
    const ChatGroupMemberRoleEnum._('OWNER');

ChatGroupMemberRoleEnum _$chatGroupMemberRoleEnumValueOf(String name) {
  switch (name) {
    case 'MEMBER':
      return _$chatGroupMemberRoleEnum_MEMBER;
    case 'ADMIN':
      return _$chatGroupMemberRoleEnum_ADMIN;
    case 'OWNER':
      return _$chatGroupMemberRoleEnum_OWNER;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ChatGroupMemberRoleEnum> _$chatGroupMemberRoleEnumValues =
    BuiltSet<ChatGroupMemberRoleEnum>(const <ChatGroupMemberRoleEnum>[
      _$chatGroupMemberRoleEnum_MEMBER,
      _$chatGroupMemberRoleEnum_ADMIN,
      _$chatGroupMemberRoleEnum_OWNER,
    ]);

Serializer<ChatGroupMemberMemberTypeEnum>
_$chatGroupMemberMemberTypeEnumSerializer =
    _$ChatGroupMemberMemberTypeEnumSerializer();
Serializer<ChatGroupMemberRoleEnum> _$chatGroupMemberRoleEnumSerializer =
    _$ChatGroupMemberRoleEnumSerializer();

class _$ChatGroupMemberMemberTypeEnumSerializer
    implements PrimitiveSerializer<ChatGroupMemberMemberTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USER': 'USER',
    'AI_ROLE': 'AI_ROLE',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USER': 'USER',
    'AI_ROLE': 'AI_ROLE',
  };

  @override
  final Iterable<Type> types = const <Type>[ChatGroupMemberMemberTypeEnum];
  @override
  final String wireName = 'ChatGroupMemberMemberTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    ChatGroupMemberMemberTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ChatGroupMemberMemberTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ChatGroupMemberMemberTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ChatGroupMemberRoleEnumSerializer
    implements PrimitiveSerializer<ChatGroupMemberRoleEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'MEMBER': 'MEMBER',
    'ADMIN': 'ADMIN',
    'OWNER': 'OWNER',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MEMBER': 'MEMBER',
    'ADMIN': 'ADMIN',
    'OWNER': 'OWNER',
  };

  @override
  final Iterable<Type> types = const <Type>[ChatGroupMemberRoleEnum];
  @override
  final String wireName = 'ChatGroupMemberRoleEnum';

  @override
  Object serialize(
    Serializers serializers,
    ChatGroupMemberRoleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ChatGroupMemberRoleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ChatGroupMemberRoleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ChatGroupMember extends ChatGroupMember {
  @override
  final int? id;
  @override
  final GroupId? groupId;
  @override
  final ChatGroupMemberMemberTypeEnum? memberType;
  @override
  final UserId? userId;
  @override
  final int? aiRoleId;
  @override
  final ChatGroupMemberRoleEnum? role;
  @override
  final String? nickname;
  @override
  final DateTime? muteUntil;
  @override
  final DateTime? joinTime;
  @override
  final DateTime? updateTime;
  @override
  final bool? adminOrOwner;
  @override
  final bool? owner;
  @override
  final bool? delete;
  @override
  final bool? muted;
  @override
  final bool? mute;

  factory _$ChatGroupMember([void Function(ChatGroupMemberBuilder)? updates]) =>
      (ChatGroupMemberBuilder()..update(updates))._build();

  _$ChatGroupMember._({
    this.id,
    this.groupId,
    this.memberType,
    this.userId,
    this.aiRoleId,
    this.role,
    this.nickname,
    this.muteUntil,
    this.joinTime,
    this.updateTime,
    this.adminOrOwner,
    this.owner,
    this.delete,
    this.muted,
    this.mute,
  }) : super._();
  @override
  ChatGroupMember rebuild(void Function(ChatGroupMemberBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatGroupMemberBuilder toBuilder() => ChatGroupMemberBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatGroupMember &&
        id == other.id &&
        groupId == other.groupId &&
        memberType == other.memberType &&
        userId == other.userId &&
        aiRoleId == other.aiRoleId &&
        role == other.role &&
        nickname == other.nickname &&
        muteUntil == other.muteUntil &&
        joinTime == other.joinTime &&
        updateTime == other.updateTime &&
        adminOrOwner == other.adminOrOwner &&
        owner == other.owner &&
        delete == other.delete &&
        muted == other.muted &&
        mute == other.mute;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, groupId.hashCode);
    _$hash = $jc(_$hash, memberType.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, aiRoleId.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, nickname.hashCode);
    _$hash = $jc(_$hash, muteUntil.hashCode);
    _$hash = $jc(_$hash, joinTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jc(_$hash, adminOrOwner.hashCode);
    _$hash = $jc(_$hash, owner.hashCode);
    _$hash = $jc(_$hash, delete.hashCode);
    _$hash = $jc(_$hash, muted.hashCode);
    _$hash = $jc(_$hash, mute.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatGroupMember')
          ..add('id', id)
          ..add('groupId', groupId)
          ..add('memberType', memberType)
          ..add('userId', userId)
          ..add('aiRoleId', aiRoleId)
          ..add('role', role)
          ..add('nickname', nickname)
          ..add('muteUntil', muteUntil)
          ..add('joinTime', joinTime)
          ..add('updateTime', updateTime)
          ..add('adminOrOwner', adminOrOwner)
          ..add('owner', owner)
          ..add('delete', delete)
          ..add('muted', muted)
          ..add('mute', mute))
        .toString();
  }
}

class ChatGroupMemberBuilder
    implements Builder<ChatGroupMember, ChatGroupMemberBuilder> {
  _$ChatGroupMember? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  GroupIdBuilder? _groupId;
  GroupIdBuilder get groupId => _$this._groupId ??= GroupIdBuilder();
  set groupId(GroupIdBuilder? groupId) => _$this._groupId = groupId;

  ChatGroupMemberMemberTypeEnum? _memberType;
  ChatGroupMemberMemberTypeEnum? get memberType => _$this._memberType;
  set memberType(ChatGroupMemberMemberTypeEnum? memberType) =>
      _$this._memberType = memberType;

  UserIdBuilder? _userId;
  UserIdBuilder get userId => _$this._userId ??= UserIdBuilder();
  set userId(UserIdBuilder? userId) => _$this._userId = userId;

  int? _aiRoleId;
  int? get aiRoleId => _$this._aiRoleId;
  set aiRoleId(int? aiRoleId) => _$this._aiRoleId = aiRoleId;

  ChatGroupMemberRoleEnum? _role;
  ChatGroupMemberRoleEnum? get role => _$this._role;
  set role(ChatGroupMemberRoleEnum? role) => _$this._role = role;

  String? _nickname;
  String? get nickname => _$this._nickname;
  set nickname(String? nickname) => _$this._nickname = nickname;

  DateTime? _muteUntil;
  DateTime? get muteUntil => _$this._muteUntil;
  set muteUntil(DateTime? muteUntil) => _$this._muteUntil = muteUntil;

  DateTime? _joinTime;
  DateTime? get joinTime => _$this._joinTime;
  set joinTime(DateTime? joinTime) => _$this._joinTime = joinTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  bool? _adminOrOwner;
  bool? get adminOrOwner => _$this._adminOrOwner;
  set adminOrOwner(bool? adminOrOwner) => _$this._adminOrOwner = adminOrOwner;

  bool? _owner;
  bool? get owner => _$this._owner;
  set owner(bool? owner) => _$this._owner = owner;

  bool? _delete;
  bool? get delete => _$this._delete;
  set delete(bool? delete) => _$this._delete = delete;

  bool? _muted;
  bool? get muted => _$this._muted;
  set muted(bool? muted) => _$this._muted = muted;

  bool? _mute;
  bool? get mute => _$this._mute;
  set mute(bool? mute) => _$this._mute = mute;

  ChatGroupMemberBuilder() {
    ChatGroupMember._defaults(this);
  }

  ChatGroupMemberBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _groupId = $v.groupId?.toBuilder();
      _memberType = $v.memberType;
      _userId = $v.userId?.toBuilder();
      _aiRoleId = $v.aiRoleId;
      _role = $v.role;
      _nickname = $v.nickname;
      _muteUntil = $v.muteUntil;
      _joinTime = $v.joinTime;
      _updateTime = $v.updateTime;
      _adminOrOwner = $v.adminOrOwner;
      _owner = $v.owner;
      _delete = $v.delete;
      _muted = $v.muted;
      _mute = $v.mute;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatGroupMember other) {
    _$v = other as _$ChatGroupMember;
  }

  @override
  void update(void Function(ChatGroupMemberBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatGroupMember build() => _build();

  _$ChatGroupMember _build() {
    _$ChatGroupMember _$result;
    try {
      _$result =
          _$v ??
          _$ChatGroupMember._(
            id: id,
            groupId: _groupId?.build(),
            memberType: memberType,
            userId: _userId?.build(),
            aiRoleId: aiRoleId,
            role: role,
            nickname: nickname,
            muteUntil: muteUntil,
            joinTime: joinTime,
            updateTime: updateTime,
            adminOrOwner: adminOrOwner,
            owner: owner,
            delete: delete,
            muted: muted,
            mute: mute,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'groupId';
        _groupId?.build();

        _$failedField = 'userId';
        _userId?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ChatGroupMember',
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
