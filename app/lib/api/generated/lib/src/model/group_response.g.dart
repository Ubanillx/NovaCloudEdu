// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GroupResponse extends GroupResponse {
  @override
  final int? id;
  @override
  final String? groupNumber;
  @override
  final String? groupName;
  @override
  final String? avatar;
  @override
  final String? description;
  @override
  final int? ownerId;
  @override
  final int? classId;
  @override
  final int? maxMembers;
  @override
  final int? memberCount;
  @override
  final int? inviteMode;
  @override
  final int? joinMode;
  @override
  final String? announcement;
  @override
  final DateTime? announcementTime;
  @override
  final DateTime? createTime;
  @override
  final bool? mute;

  factory _$GroupResponse([void Function(GroupResponseBuilder)? updates]) =>
      (GroupResponseBuilder()..update(updates))._build();

  _$GroupResponse._({
    this.id,
    this.groupNumber,
    this.groupName,
    this.avatar,
    this.description,
    this.ownerId,
    this.classId,
    this.maxMembers,
    this.memberCount,
    this.inviteMode,
    this.joinMode,
    this.announcement,
    this.announcementTime,
    this.createTime,
    this.mute,
  }) : super._();
  @override
  GroupResponse rebuild(void Function(GroupResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GroupResponseBuilder toBuilder() => GroupResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GroupResponse &&
        id == other.id &&
        groupNumber == other.groupNumber &&
        groupName == other.groupName &&
        avatar == other.avatar &&
        description == other.description &&
        ownerId == other.ownerId &&
        classId == other.classId &&
        maxMembers == other.maxMembers &&
        memberCount == other.memberCount &&
        inviteMode == other.inviteMode &&
        joinMode == other.joinMode &&
        announcement == other.announcement &&
        announcementTime == other.announcementTime &&
        createTime == other.createTime &&
        mute == other.mute;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, groupNumber.hashCode);
    _$hash = $jc(_$hash, groupName.hashCode);
    _$hash = $jc(_$hash, avatar.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, ownerId.hashCode);
    _$hash = $jc(_$hash, classId.hashCode);
    _$hash = $jc(_$hash, maxMembers.hashCode);
    _$hash = $jc(_$hash, memberCount.hashCode);
    _$hash = $jc(_$hash, inviteMode.hashCode);
    _$hash = $jc(_$hash, joinMode.hashCode);
    _$hash = $jc(_$hash, announcement.hashCode);
    _$hash = $jc(_$hash, announcementTime.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, mute.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GroupResponse')
          ..add('id', id)
          ..add('groupNumber', groupNumber)
          ..add('groupName', groupName)
          ..add('avatar', avatar)
          ..add('description', description)
          ..add('ownerId', ownerId)
          ..add('classId', classId)
          ..add('maxMembers', maxMembers)
          ..add('memberCount', memberCount)
          ..add('inviteMode', inviteMode)
          ..add('joinMode', joinMode)
          ..add('announcement', announcement)
          ..add('announcementTime', announcementTime)
          ..add('createTime', createTime)
          ..add('mute', mute))
        .toString();
  }
}

class GroupResponseBuilder
    implements Builder<GroupResponse, GroupResponseBuilder> {
  _$GroupResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _groupNumber;
  String? get groupNumber => _$this._groupNumber;
  set groupNumber(String? groupNumber) => _$this._groupNumber = groupNumber;

  String? _groupName;
  String? get groupName => _$this._groupName;
  set groupName(String? groupName) => _$this._groupName = groupName;

  String? _avatar;
  String? get avatar => _$this._avatar;
  set avatar(String? avatar) => _$this._avatar = avatar;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _ownerId;
  int? get ownerId => _$this._ownerId;
  set ownerId(int? ownerId) => _$this._ownerId = ownerId;

  int? _classId;
  int? get classId => _$this._classId;
  set classId(int? classId) => _$this._classId = classId;

  int? _maxMembers;
  int? get maxMembers => _$this._maxMembers;
  set maxMembers(int? maxMembers) => _$this._maxMembers = maxMembers;

  int? _memberCount;
  int? get memberCount => _$this._memberCount;
  set memberCount(int? memberCount) => _$this._memberCount = memberCount;

  int? _inviteMode;
  int? get inviteMode => _$this._inviteMode;
  set inviteMode(int? inviteMode) => _$this._inviteMode = inviteMode;

  int? _joinMode;
  int? get joinMode => _$this._joinMode;
  set joinMode(int? joinMode) => _$this._joinMode = joinMode;

  String? _announcement;
  String? get announcement => _$this._announcement;
  set announcement(String? announcement) => _$this._announcement = announcement;

  DateTime? _announcementTime;
  DateTime? get announcementTime => _$this._announcementTime;
  set announcementTime(DateTime? announcementTime) =>
      _$this._announcementTime = announcementTime;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  bool? _mute;
  bool? get mute => _$this._mute;
  set mute(bool? mute) => _$this._mute = mute;

  GroupResponseBuilder() {
    GroupResponse._defaults(this);
  }

  GroupResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _groupNumber = $v.groupNumber;
      _groupName = $v.groupName;
      _avatar = $v.avatar;
      _description = $v.description;
      _ownerId = $v.ownerId;
      _classId = $v.classId;
      _maxMembers = $v.maxMembers;
      _memberCount = $v.memberCount;
      _inviteMode = $v.inviteMode;
      _joinMode = $v.joinMode;
      _announcement = $v.announcement;
      _announcementTime = $v.announcementTime;
      _createTime = $v.createTime;
      _mute = $v.mute;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GroupResponse other) {
    _$v = other as _$GroupResponse;
  }

  @override
  void update(void Function(GroupResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GroupResponse build() => _build();

  _$GroupResponse _build() {
    final _$result =
        _$v ??
        _$GroupResponse._(
          id: id,
          groupNumber: groupNumber,
          groupName: groupName,
          avatar: avatar,
          description: description,
          ownerId: ownerId,
          classId: classId,
          maxMembers: maxMembers,
          memberCount: memberCount,
          inviteMode: inviteMode,
          joinMode: joinMode,
          announcement: announcement,
          announcementTime: announcementTime,
          createTime: createTime,
          mute: mute,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
