// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_group.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ChatGroupInviteModeEnum _$chatGroupInviteModeEnum_ALL =
    const ChatGroupInviteModeEnum._('ALL');
const ChatGroupInviteModeEnum _$chatGroupInviteModeEnum_ADMIN_ONLY =
    const ChatGroupInviteModeEnum._('ADMIN_ONLY');

ChatGroupInviteModeEnum _$chatGroupInviteModeEnumValueOf(String name) {
  switch (name) {
    case 'ALL':
      return _$chatGroupInviteModeEnum_ALL;
    case 'ADMIN_ONLY':
      return _$chatGroupInviteModeEnum_ADMIN_ONLY;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ChatGroupInviteModeEnum> _$chatGroupInviteModeEnumValues =
    BuiltSet<ChatGroupInviteModeEnum>(const <ChatGroupInviteModeEnum>[
      _$chatGroupInviteModeEnum_ALL,
      _$chatGroupInviteModeEnum_ADMIN_ONLY,
    ]);

const ChatGroupJoinModeEnum _$chatGroupJoinModeEnum_FREE =
    const ChatGroupJoinModeEnum._('FREE');
const ChatGroupJoinModeEnum _$chatGroupJoinModeEnum_APPROVAL =
    const ChatGroupJoinModeEnum._('APPROVAL');
const ChatGroupJoinModeEnum _$chatGroupJoinModeEnum_FORBIDDEN =
    const ChatGroupJoinModeEnum._('FORBIDDEN');

ChatGroupJoinModeEnum _$chatGroupJoinModeEnumValueOf(String name) {
  switch (name) {
    case 'FREE':
      return _$chatGroupJoinModeEnum_FREE;
    case 'APPROVAL':
      return _$chatGroupJoinModeEnum_APPROVAL;
    case 'FORBIDDEN':
      return _$chatGroupJoinModeEnum_FORBIDDEN;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ChatGroupJoinModeEnum> _$chatGroupJoinModeEnumValues =
    BuiltSet<ChatGroupJoinModeEnum>(const <ChatGroupJoinModeEnum>[
      _$chatGroupJoinModeEnum_FREE,
      _$chatGroupJoinModeEnum_APPROVAL,
      _$chatGroupJoinModeEnum_FORBIDDEN,
    ]);

Serializer<ChatGroupInviteModeEnum> _$chatGroupInviteModeEnumSerializer =
    _$ChatGroupInviteModeEnumSerializer();
Serializer<ChatGroupJoinModeEnum> _$chatGroupJoinModeEnumSerializer =
    _$ChatGroupJoinModeEnumSerializer();

class _$ChatGroupInviteModeEnumSerializer
    implements PrimitiveSerializer<ChatGroupInviteModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ALL': 'ALL',
    'ADMIN_ONLY': 'ADMIN_ONLY',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ALL': 'ALL',
    'ADMIN_ONLY': 'ADMIN_ONLY',
  };

  @override
  final Iterable<Type> types = const <Type>[ChatGroupInviteModeEnum];
  @override
  final String wireName = 'ChatGroupInviteModeEnum';

  @override
  Object serialize(
    Serializers serializers,
    ChatGroupInviteModeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ChatGroupInviteModeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ChatGroupInviteModeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ChatGroupJoinModeEnumSerializer
    implements PrimitiveSerializer<ChatGroupJoinModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'FREE': 'FREE',
    'APPROVAL': 'APPROVAL',
    'FORBIDDEN': 'FORBIDDEN',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'FREE': 'FREE',
    'APPROVAL': 'APPROVAL',
    'FORBIDDEN': 'FORBIDDEN',
  };

  @override
  final Iterable<Type> types = const <Type>[ChatGroupJoinModeEnum];
  @override
  final String wireName = 'ChatGroupJoinModeEnum';

  @override
  Object serialize(
    Serializers serializers,
    ChatGroupJoinModeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ChatGroupJoinModeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ChatGroupJoinModeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ChatGroup extends ChatGroup {
  @override
  final GroupId? id;
  @override
  final String? groupName;
  @override
  final String? avatar;
  @override
  final String? description;
  @override
  final UserId? ownerId;
  @override
  final int? classId;
  @override
  final int? maxMembers;
  @override
  final int? memberCount;
  @override
  final ChatGroupInviteModeEnum? inviteMode;
  @override
  final ChatGroupJoinModeEnum? joinMode;
  @override
  final String? announcement;
  @override
  final DateTime? announcementTime;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;
  @override
  final bool? mute;
  @override
  final bool? full;
  @override
  final bool? delete;

  factory _$ChatGroup([void Function(ChatGroupBuilder)? updates]) =>
      (ChatGroupBuilder()..update(updates))._build();

  _$ChatGroup._({
    this.id,
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
    this.updateTime,
    this.mute,
    this.full,
    this.delete,
  }) : super._();
  @override
  ChatGroup rebuild(void Function(ChatGroupBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatGroupBuilder toBuilder() => ChatGroupBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatGroup &&
        id == other.id &&
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
        updateTime == other.updateTime &&
        mute == other.mute &&
        full == other.full &&
        delete == other.delete;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
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
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jc(_$hash, mute.hashCode);
    _$hash = $jc(_$hash, full.hashCode);
    _$hash = $jc(_$hash, delete.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatGroup')
          ..add('id', id)
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
          ..add('updateTime', updateTime)
          ..add('mute', mute)
          ..add('full', full)
          ..add('delete', delete))
        .toString();
  }
}

class ChatGroupBuilder implements Builder<ChatGroup, ChatGroupBuilder> {
  _$ChatGroup? _$v;

  GroupIdBuilder? _id;
  GroupIdBuilder get id => _$this._id ??= GroupIdBuilder();
  set id(GroupIdBuilder? id) => _$this._id = id;

  String? _groupName;
  String? get groupName => _$this._groupName;
  set groupName(String? groupName) => _$this._groupName = groupName;

  String? _avatar;
  String? get avatar => _$this._avatar;
  set avatar(String? avatar) => _$this._avatar = avatar;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  UserIdBuilder? _ownerId;
  UserIdBuilder get ownerId => _$this._ownerId ??= UserIdBuilder();
  set ownerId(UserIdBuilder? ownerId) => _$this._ownerId = ownerId;

  int? _classId;
  int? get classId => _$this._classId;
  set classId(int? classId) => _$this._classId = classId;

  int? _maxMembers;
  int? get maxMembers => _$this._maxMembers;
  set maxMembers(int? maxMembers) => _$this._maxMembers = maxMembers;

  int? _memberCount;
  int? get memberCount => _$this._memberCount;
  set memberCount(int? memberCount) => _$this._memberCount = memberCount;

  ChatGroupInviteModeEnum? _inviteMode;
  ChatGroupInviteModeEnum? get inviteMode => _$this._inviteMode;
  set inviteMode(ChatGroupInviteModeEnum? inviteMode) =>
      _$this._inviteMode = inviteMode;

  ChatGroupJoinModeEnum? _joinMode;
  ChatGroupJoinModeEnum? get joinMode => _$this._joinMode;
  set joinMode(ChatGroupJoinModeEnum? joinMode) => _$this._joinMode = joinMode;

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

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  bool? _mute;
  bool? get mute => _$this._mute;
  set mute(bool? mute) => _$this._mute = mute;

  bool? _full;
  bool? get full => _$this._full;
  set full(bool? full) => _$this._full = full;

  bool? _delete;
  bool? get delete => _$this._delete;
  set delete(bool? delete) => _$this._delete = delete;

  ChatGroupBuilder() {
    ChatGroup._defaults(this);
  }

  ChatGroupBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id?.toBuilder();
      _groupName = $v.groupName;
      _avatar = $v.avatar;
      _description = $v.description;
      _ownerId = $v.ownerId?.toBuilder();
      _classId = $v.classId;
      _maxMembers = $v.maxMembers;
      _memberCount = $v.memberCount;
      _inviteMode = $v.inviteMode;
      _joinMode = $v.joinMode;
      _announcement = $v.announcement;
      _announcementTime = $v.announcementTime;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _mute = $v.mute;
      _full = $v.full;
      _delete = $v.delete;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatGroup other) {
    _$v = other as _$ChatGroup;
  }

  @override
  void update(void Function(ChatGroupBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatGroup build() => _build();

  _$ChatGroup _build() {
    _$ChatGroup _$result;
    try {
      _$result =
          _$v ??
          _$ChatGroup._(
            id: _id?.build(),
            groupName: groupName,
            avatar: avatar,
            description: description,
            ownerId: _ownerId?.build(),
            classId: classId,
            maxMembers: maxMembers,
            memberCount: memberCount,
            inviteMode: inviteMode,
            joinMode: joinMode,
            announcement: announcement,
            announcementTime: announcementTime,
            createTime: createTime,
            updateTime: updateTime,
            mute: mute,
            full: full,
            delete: delete,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'id';
        _id?.build();

        _$failedField = 'ownerId';
        _ownerId?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ChatGroup',
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
