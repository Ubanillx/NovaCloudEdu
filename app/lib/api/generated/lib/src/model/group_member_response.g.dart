// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_member_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GroupMemberResponse extends GroupMemberResponse {
  @override
  final int? id;
  @override
  final int? groupId;
  @override
  final int? memberType;
  @override
  final int? userId;
  @override
  final int? aiRoleId;
  @override
  final int? role;
  @override
  final String? nickname;
  @override
  final DateTime? muteUntil;
  @override
  final DateTime? joinTime;
  @override
  final String? userName;
  @override
  final String? userAvatar;
  @override
  final bool? mute;

  factory _$GroupMemberResponse([
    void Function(GroupMemberResponseBuilder)? updates,
  ]) => (GroupMemberResponseBuilder()..update(updates))._build();

  _$GroupMemberResponse._({
    this.id,
    this.groupId,
    this.memberType,
    this.userId,
    this.aiRoleId,
    this.role,
    this.nickname,
    this.muteUntil,
    this.joinTime,
    this.userName,
    this.userAvatar,
    this.mute,
  }) : super._();
  @override
  GroupMemberResponse rebuild(
    void Function(GroupMemberResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GroupMemberResponseBuilder toBuilder() =>
      GroupMemberResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GroupMemberResponse &&
        id == other.id &&
        groupId == other.groupId &&
        memberType == other.memberType &&
        userId == other.userId &&
        aiRoleId == other.aiRoleId &&
        role == other.role &&
        nickname == other.nickname &&
        muteUntil == other.muteUntil &&
        joinTime == other.joinTime &&
        userName == other.userName &&
        userAvatar == other.userAvatar &&
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
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, userAvatar.hashCode);
    _$hash = $jc(_$hash, mute.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GroupMemberResponse')
          ..add('id', id)
          ..add('groupId', groupId)
          ..add('memberType', memberType)
          ..add('userId', userId)
          ..add('aiRoleId', aiRoleId)
          ..add('role', role)
          ..add('nickname', nickname)
          ..add('muteUntil', muteUntil)
          ..add('joinTime', joinTime)
          ..add('userName', userName)
          ..add('userAvatar', userAvatar)
          ..add('mute', mute))
        .toString();
  }
}

class GroupMemberResponseBuilder
    implements Builder<GroupMemberResponse, GroupMemberResponseBuilder> {
  _$GroupMemberResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _groupId;
  int? get groupId => _$this._groupId;
  set groupId(int? groupId) => _$this._groupId = groupId;

  int? _memberType;
  int? get memberType => _$this._memberType;
  set memberType(int? memberType) => _$this._memberType = memberType;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  int? _aiRoleId;
  int? get aiRoleId => _$this._aiRoleId;
  set aiRoleId(int? aiRoleId) => _$this._aiRoleId = aiRoleId;

  int? _role;
  int? get role => _$this._role;
  set role(int? role) => _$this._role = role;

  String? _nickname;
  String? get nickname => _$this._nickname;
  set nickname(String? nickname) => _$this._nickname = nickname;

  DateTime? _muteUntil;
  DateTime? get muteUntil => _$this._muteUntil;
  set muteUntil(DateTime? muteUntil) => _$this._muteUntil = muteUntil;

  DateTime? _joinTime;
  DateTime? get joinTime => _$this._joinTime;
  set joinTime(DateTime? joinTime) => _$this._joinTime = joinTime;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  String? _userAvatar;
  String? get userAvatar => _$this._userAvatar;
  set userAvatar(String? userAvatar) => _$this._userAvatar = userAvatar;

  bool? _mute;
  bool? get mute => _$this._mute;
  set mute(bool? mute) => _$this._mute = mute;

  GroupMemberResponseBuilder() {
    GroupMemberResponse._defaults(this);
  }

  GroupMemberResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _groupId = $v.groupId;
      _memberType = $v.memberType;
      _userId = $v.userId;
      _aiRoleId = $v.aiRoleId;
      _role = $v.role;
      _nickname = $v.nickname;
      _muteUntil = $v.muteUntil;
      _joinTime = $v.joinTime;
      _userName = $v.userName;
      _userAvatar = $v.userAvatar;
      _mute = $v.mute;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GroupMemberResponse other) {
    _$v = other as _$GroupMemberResponse;
  }

  @override
  void update(void Function(GroupMemberResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GroupMemberResponse build() => _build();

  _$GroupMemberResponse _build() {
    final _$result =
        _$v ??
        _$GroupMemberResponse._(
          id: id,
          groupId: groupId,
          memberType: memberType,
          userId: userId,
          aiRoleId: aiRoleId,
          role: role,
          nickname: nickname,
          muteUntil: muteUntil,
          joinTime: joinTime,
          userName: userName,
          userAvatar: userAvatar,
          mute: mute,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
