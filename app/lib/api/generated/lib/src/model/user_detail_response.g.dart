// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserDetailResponse extends UserDetailResponse {
  @override
  final int? id;
  @override
  final String? userAccount;
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
  final String? userPhone;
  @override
  final String? userEmail;
  @override
  final String? userAddress;
  @override
  final Date? birthday;
  @override
  final int? level;
  @override
  final bool? banned;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$UserDetailResponse(
          [void Function(UserDetailResponseBuilder)? updates]) =>
      (UserDetailResponseBuilder()..update(updates))._build();

  _$UserDetailResponse._(
      {this.id,
      this.userAccount,
      this.userName,
      this.userAvatar,
      this.userProfile,
      this.role,
      this.userGender,
      this.userPhone,
      this.userEmail,
      this.userAddress,
      this.birthday,
      this.level,
      this.banned,
      this.createTime,
      this.updateTime})
      : super._();
  @override
  UserDetailResponse rebuild(
          void Function(UserDetailResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserDetailResponseBuilder toBuilder() =>
      UserDetailResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserDetailResponse &&
        id == other.id &&
        userAccount == other.userAccount &&
        userName == other.userName &&
        userAvatar == other.userAvatar &&
        userProfile == other.userProfile &&
        role == other.role &&
        userGender == other.userGender &&
        userPhone == other.userPhone &&
        userEmail == other.userEmail &&
        userAddress == other.userAddress &&
        birthday == other.birthday &&
        level == other.level &&
        banned == other.banned &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userAccount.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, userAvatar.hashCode);
    _$hash = $jc(_$hash, userProfile.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, userGender.hashCode);
    _$hash = $jc(_$hash, userPhone.hashCode);
    _$hash = $jc(_$hash, userEmail.hashCode);
    _$hash = $jc(_$hash, userAddress.hashCode);
    _$hash = $jc(_$hash, birthday.hashCode);
    _$hash = $jc(_$hash, level.hashCode);
    _$hash = $jc(_$hash, banned.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserDetailResponse')
          ..add('id', id)
          ..add('userAccount', userAccount)
          ..add('userName', userName)
          ..add('userAvatar', userAvatar)
          ..add('userProfile', userProfile)
          ..add('role', role)
          ..add('userGender', userGender)
          ..add('userPhone', userPhone)
          ..add('userEmail', userEmail)
          ..add('userAddress', userAddress)
          ..add('birthday', birthday)
          ..add('level', level)
          ..add('banned', banned)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class UserDetailResponseBuilder
    implements Builder<UserDetailResponse, UserDetailResponseBuilder> {
  _$UserDetailResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

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

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  int? _userGender;
  int? get userGender => _$this._userGender;
  set userGender(int? userGender) => _$this._userGender = userGender;

  String? _userPhone;
  String? get userPhone => _$this._userPhone;
  set userPhone(String? userPhone) => _$this._userPhone = userPhone;

  String? _userEmail;
  String? get userEmail => _$this._userEmail;
  set userEmail(String? userEmail) => _$this._userEmail = userEmail;

  String? _userAddress;
  String? get userAddress => _$this._userAddress;
  set userAddress(String? userAddress) => _$this._userAddress = userAddress;

  Date? _birthday;
  Date? get birthday => _$this._birthday;
  set birthday(Date? birthday) => _$this._birthday = birthday;

  int? _level;
  int? get level => _$this._level;
  set level(int? level) => _$this._level = level;

  bool? _banned;
  bool? get banned => _$this._banned;
  set banned(bool? banned) => _$this._banned = banned;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  UserDetailResponseBuilder() {
    UserDetailResponse._defaults(this);
  }

  UserDetailResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userAccount = $v.userAccount;
      _userName = $v.userName;
      _userAvatar = $v.userAvatar;
      _userProfile = $v.userProfile;
      _role = $v.role;
      _userGender = $v.userGender;
      _userPhone = $v.userPhone;
      _userEmail = $v.userEmail;
      _userAddress = $v.userAddress;
      _birthday = $v.birthday;
      _level = $v.level;
      _banned = $v.banned;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserDetailResponse other) {
    _$v = other as _$UserDetailResponse;
  }

  @override
  void update(void Function(UserDetailResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserDetailResponse build() => _build();

  _$UserDetailResponse _build() {
    final _$result = _$v ??
        _$UserDetailResponse._(
          id: id,
          userAccount: userAccount,
          userName: userName,
          userAvatar: userAvatar,
          userProfile: userProfile,
          role: role,
          userGender: userGender,
          userPhone: userPhone,
          userEmail: userEmail,
          userAddress: userAddress,
          birthday: birthday,
          level: level,
          banned: banned,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
