// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_public_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserPublicResponse extends UserPublicResponse {
  @override
  final int? id;
  @override
  final String? userName;
  @override
  final String? userAvatar;
  @override
  final String? userProfile;
  @override
  final String? role;
  @override
  final int? userGender;
  @override
  final int? level;

  factory _$UserPublicResponse(
          [void Function(UserPublicResponseBuilder)? updates]) =>
      (UserPublicResponseBuilder()..update(updates))._build();

  _$UserPublicResponse._(
      {this.id,
      this.userName,
      this.userAvatar,
      this.userProfile,
      this.role,
      this.userGender,
      this.level})
      : super._();
  @override
  UserPublicResponse rebuild(
          void Function(UserPublicResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserPublicResponseBuilder toBuilder() =>
      UserPublicResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserPublicResponse &&
        id == other.id &&
        userName == other.userName &&
        userAvatar == other.userAvatar &&
        userProfile == other.userProfile &&
        role == other.role &&
        userGender == other.userGender &&
        level == other.level;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, userAvatar.hashCode);
    _$hash = $jc(_$hash, userProfile.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, userGender.hashCode);
    _$hash = $jc(_$hash, level.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserPublicResponse')
          ..add('id', id)
          ..add('userName', userName)
          ..add('userAvatar', userAvatar)
          ..add('userProfile', userProfile)
          ..add('role', role)
          ..add('userGender', userGender)
          ..add('level', level))
        .toString();
  }
}

class UserPublicResponseBuilder
    implements Builder<UserPublicResponse, UserPublicResponseBuilder> {
  _$UserPublicResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  String? _userAvatar;
  String? get userAvatar => _$this._userAvatar;
  set userAvatar(String? userAvatar) => _$this._userAvatar = userAvatar;

  String? _userProfile;
  String? get userProfile => _$this._userProfile;
  set userProfile(String? userProfile) => _$this._userProfile = userProfile;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  int? _userGender;
  int? get userGender => _$this._userGender;
  set userGender(int? userGender) => _$this._userGender = userGender;

  int? _level;
  int? get level => _$this._level;
  set level(int? level) => _$this._level = level;

  UserPublicResponseBuilder() {
    UserPublicResponse._defaults(this);
  }

  UserPublicResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userName = $v.userName;
      _userAvatar = $v.userAvatar;
      _userProfile = $v.userProfile;
      _role = $v.role;
      _userGender = $v.userGender;
      _level = $v.level;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserPublicResponse other) {
    _$v = other as _$UserPublicResponse;
  }

  @override
  void update(void Function(UserPublicResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserPublicResponse build() => _build();

  _$UserPublicResponse _build() {
    final _$result = _$v ??
        _$UserPublicResponse._(
          id: id,
          userName: userName,
          userAvatar: userAvatar,
          userProfile: userProfile,
          role: role,
          userGender: userGender,
          level: level,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
