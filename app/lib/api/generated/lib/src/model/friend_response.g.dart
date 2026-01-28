// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FriendResponse extends FriendResponse {
  @override
  final int? userId;
  @override
  final String? userAccount;
  @override
  final String? userName;
  @override
  final String? userAvatar;
  @override
  final String? userProfile;
  @override
  final DateTime? friendSince;

  factory _$FriendResponse([void Function(FriendResponseBuilder)? updates]) =>
      (FriendResponseBuilder()..update(updates))._build();

  _$FriendResponse._({
    this.userId,
    this.userAccount,
    this.userName,
    this.userAvatar,
    this.userProfile,
    this.friendSince,
  }) : super._();
  @override
  FriendResponse rebuild(void Function(FriendResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FriendResponseBuilder toBuilder() => FriendResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FriendResponse &&
        userId == other.userId &&
        userAccount == other.userAccount &&
        userName == other.userName &&
        userAvatar == other.userAvatar &&
        userProfile == other.userProfile &&
        friendSince == other.friendSince;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, userAccount.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, userAvatar.hashCode);
    _$hash = $jc(_$hash, userProfile.hashCode);
    _$hash = $jc(_$hash, friendSince.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FriendResponse')
          ..add('userId', userId)
          ..add('userAccount', userAccount)
          ..add('userName', userName)
          ..add('userAvatar', userAvatar)
          ..add('userProfile', userProfile)
          ..add('friendSince', friendSince))
        .toString();
  }
}

class FriendResponseBuilder
    implements Builder<FriendResponse, FriendResponseBuilder> {
  _$FriendResponse? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _userAccount;
  String? get userAccount => _$this._userAccount;
  set userAccount(String? userAccount) => _$this._userAccount = userAccount;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  String? _userAvatar;
  String? get userAvatar => _$this._userAvatar;
  set userAvatar(String? userAvatar) => _$this._userAvatar = userAvatar;

  String? _userProfile;
  String? get userProfile => _$this._userProfile;
  set userProfile(String? userProfile) => _$this._userProfile = userProfile;

  DateTime? _friendSince;
  DateTime? get friendSince => _$this._friendSince;
  set friendSince(DateTime? friendSince) => _$this._friendSince = friendSince;

  FriendResponseBuilder() {
    FriendResponse._defaults(this);
  }

  FriendResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _userAccount = $v.userAccount;
      _userName = $v.userName;
      _userAvatar = $v.userAvatar;
      _userProfile = $v.userProfile;
      _friendSince = $v.friendSince;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FriendResponse other) {
    _$v = other as _$FriendResponse;
  }

  @override
  void update(void Function(FriendResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FriendResponse build() => _build();

  _$FriendResponse _build() {
    final _$result =
        _$v ??
        _$FriendResponse._(
          userId: userId,
          userAccount: userAccount,
          userName: userName,
          userAvatar: userAvatar,
          userProfile: userProfile,
          friendSince: friendSince,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
