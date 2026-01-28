// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FriendRequestResponse extends FriendRequestResponse {
  @override
  final int? id;
  @override
  final int? senderId;
  @override
  final String? senderName;
  @override
  final String? senderAvatar;
  @override
  final int? receiverId;
  @override
  final String? receiverName;
  @override
  final String? receiverAvatar;
  @override
  final String? status;
  @override
  final String? message;
  @override
  final DateTime? createTime;

  factory _$FriendRequestResponse([
    void Function(FriendRequestResponseBuilder)? updates,
  ]) => (FriendRequestResponseBuilder()..update(updates))._build();

  _$FriendRequestResponse._({
    this.id,
    this.senderId,
    this.senderName,
    this.senderAvatar,
    this.receiverId,
    this.receiverName,
    this.receiverAvatar,
    this.status,
    this.message,
    this.createTime,
  }) : super._();
  @override
  FriendRequestResponse rebuild(
    void Function(FriendRequestResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FriendRequestResponseBuilder toBuilder() =>
      FriendRequestResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FriendRequestResponse &&
        id == other.id &&
        senderId == other.senderId &&
        senderName == other.senderName &&
        senderAvatar == other.senderAvatar &&
        receiverId == other.receiverId &&
        receiverName == other.receiverName &&
        receiverAvatar == other.receiverAvatar &&
        status == other.status &&
        message == other.message &&
        createTime == other.createTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, senderId.hashCode);
    _$hash = $jc(_$hash, senderName.hashCode);
    _$hash = $jc(_$hash, senderAvatar.hashCode);
    _$hash = $jc(_$hash, receiverId.hashCode);
    _$hash = $jc(_$hash, receiverName.hashCode);
    _$hash = $jc(_$hash, receiverAvatar.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FriendRequestResponse')
          ..add('id', id)
          ..add('senderId', senderId)
          ..add('senderName', senderName)
          ..add('senderAvatar', senderAvatar)
          ..add('receiverId', receiverId)
          ..add('receiverName', receiverName)
          ..add('receiverAvatar', receiverAvatar)
          ..add('status', status)
          ..add('message', message)
          ..add('createTime', createTime))
        .toString();
  }
}

class FriendRequestResponseBuilder
    implements Builder<FriendRequestResponse, FriendRequestResponseBuilder> {
  _$FriendRequestResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

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

  String? _receiverName;
  String? get receiverName => _$this._receiverName;
  set receiverName(String? receiverName) => _$this._receiverName = receiverName;

  String? _receiverAvatar;
  String? get receiverAvatar => _$this._receiverAvatar;
  set receiverAvatar(String? receiverAvatar) =>
      _$this._receiverAvatar = receiverAvatar;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  FriendRequestResponseBuilder() {
    FriendRequestResponse._defaults(this);
  }

  FriendRequestResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _senderId = $v.senderId;
      _senderName = $v.senderName;
      _senderAvatar = $v.senderAvatar;
      _receiverId = $v.receiverId;
      _receiverName = $v.receiverName;
      _receiverAvatar = $v.receiverAvatar;
      _status = $v.status;
      _message = $v.message;
      _createTime = $v.createTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FriendRequestResponse other) {
    _$v = other as _$FriendRequestResponse;
  }

  @override
  void update(void Function(FriendRequestResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FriendRequestResponse build() => _build();

  _$FriendRequestResponse _build() {
    final _$result =
        _$v ??
        _$FriendRequestResponse._(
          id: id,
          senderId: senderId,
          senderName: senderName,
          senderAvatar: senderAvatar,
          receiverId: receiverId,
          receiverName: receiverName,
          receiverAvatar: receiverAvatar,
          status: status,
          message: message,
          createTime: createTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
