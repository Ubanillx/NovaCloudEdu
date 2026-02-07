// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_read_user_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MessageReadUserResponse extends MessageReadUserResponse {
  @override
  final int? userId;
  @override
  final String? userName;
  @override
  final String? userAvatar;
  @override
  final DateTime? readTime;

  factory _$MessageReadUserResponse([
    void Function(MessageReadUserResponseBuilder)? updates,
  ]) => (MessageReadUserResponseBuilder()..update(updates))._build();

  _$MessageReadUserResponse._({
    this.userId,
    this.userName,
    this.userAvatar,
    this.readTime,
  }) : super._();
  @override
  MessageReadUserResponse rebuild(
    void Function(MessageReadUserResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MessageReadUserResponseBuilder toBuilder() =>
      MessageReadUserResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MessageReadUserResponse &&
        userId == other.userId &&
        userName == other.userName &&
        userAvatar == other.userAvatar &&
        readTime == other.readTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, userAvatar.hashCode);
    _$hash = $jc(_$hash, readTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MessageReadUserResponse')
          ..add('userId', userId)
          ..add('userName', userName)
          ..add('userAvatar', userAvatar)
          ..add('readTime', readTime))
        .toString();
  }
}

class MessageReadUserResponseBuilder
    implements
        Builder<MessageReadUserResponse, MessageReadUserResponseBuilder> {
  _$MessageReadUserResponse? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  String? _userAvatar;
  String? get userAvatar => _$this._userAvatar;
  set userAvatar(String? userAvatar) => _$this._userAvatar = userAvatar;

  DateTime? _readTime;
  DateTime? get readTime => _$this._readTime;
  set readTime(DateTime? readTime) => _$this._readTime = readTime;

  MessageReadUserResponseBuilder() {
    MessageReadUserResponse._defaults(this);
  }

  MessageReadUserResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _userName = $v.userName;
      _userAvatar = $v.userAvatar;
      _readTime = $v.readTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MessageReadUserResponse other) {
    _$v = other as _$MessageReadUserResponse;
  }

  @override
  void update(void Function(MessageReadUserResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MessageReadUserResponse build() => _build();

  _$MessageReadUserResponse _build() {
    final _$result =
        _$v ??
        _$MessageReadUserResponse._(
          userId: userId,
          userName: userName,
          userAvatar: userAvatar,
          readTime: readTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
