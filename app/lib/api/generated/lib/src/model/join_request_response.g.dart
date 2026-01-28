// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_request_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$JoinRequestResponse extends JoinRequestResponse {
  @override
  final int? id;
  @override
  final int? groupId;
  @override
  final int? userId;
  @override
  final String? message;
  @override
  final int? status;
  @override
  final int? handlerId;
  @override
  final DateTime? handleTime;
  @override
  final DateTime? createTime;
  @override
  final String? userName;
  @override
  final String? userAvatar;

  factory _$JoinRequestResponse([
    void Function(JoinRequestResponseBuilder)? updates,
  ]) => (JoinRequestResponseBuilder()..update(updates))._build();

  _$JoinRequestResponse._({
    this.id,
    this.groupId,
    this.userId,
    this.message,
    this.status,
    this.handlerId,
    this.handleTime,
    this.createTime,
    this.userName,
    this.userAvatar,
  }) : super._();
  @override
  JoinRequestResponse rebuild(
    void Function(JoinRequestResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  JoinRequestResponseBuilder toBuilder() =>
      JoinRequestResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is JoinRequestResponse &&
        id == other.id &&
        groupId == other.groupId &&
        userId == other.userId &&
        message == other.message &&
        status == other.status &&
        handlerId == other.handlerId &&
        handleTime == other.handleTime &&
        createTime == other.createTime &&
        userName == other.userName &&
        userAvatar == other.userAvatar;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, groupId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, handlerId.hashCode);
    _$hash = $jc(_$hash, handleTime.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, userAvatar.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'JoinRequestResponse')
          ..add('id', id)
          ..add('groupId', groupId)
          ..add('userId', userId)
          ..add('message', message)
          ..add('status', status)
          ..add('handlerId', handlerId)
          ..add('handleTime', handleTime)
          ..add('createTime', createTime)
          ..add('userName', userName)
          ..add('userAvatar', userAvatar))
        .toString();
  }
}

class JoinRequestResponseBuilder
    implements Builder<JoinRequestResponse, JoinRequestResponseBuilder> {
  _$JoinRequestResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _groupId;
  int? get groupId => _$this._groupId;
  set groupId(int? groupId) => _$this._groupId = groupId;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  int? _handlerId;
  int? get handlerId => _$this._handlerId;
  set handlerId(int? handlerId) => _$this._handlerId = handlerId;

  DateTime? _handleTime;
  DateTime? get handleTime => _$this._handleTime;
  set handleTime(DateTime? handleTime) => _$this._handleTime = handleTime;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  String? _userAvatar;
  String? get userAvatar => _$this._userAvatar;
  set userAvatar(String? userAvatar) => _$this._userAvatar = userAvatar;

  JoinRequestResponseBuilder() {
    JoinRequestResponse._defaults(this);
  }

  JoinRequestResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _groupId = $v.groupId;
      _userId = $v.userId;
      _message = $v.message;
      _status = $v.status;
      _handlerId = $v.handlerId;
      _handleTime = $v.handleTime;
      _createTime = $v.createTime;
      _userName = $v.userName;
      _userAvatar = $v.userAvatar;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(JoinRequestResponse other) {
    _$v = other as _$JoinRequestResponse;
  }

  @override
  void update(void Function(JoinRequestResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  JoinRequestResponse build() => _build();

  _$JoinRequestResponse _build() {
    final _$result =
        _$v ??
        _$JoinRequestResponse._(
          id: id,
          groupId: groupId,
          userId: userId,
          message: message,
          status: status,
          handlerId: handlerId,
          handleTime: handleTime,
          createTime: createTime,
          userName: userName,
          userAvatar: userAvatar,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
