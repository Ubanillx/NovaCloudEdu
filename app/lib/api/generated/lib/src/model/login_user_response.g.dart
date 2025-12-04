// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginUserResponse extends LoginUserResponse {
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
  final String? userRole;
  @override
  final int? userGender;
  @override
  final String? userPhone;
  @override
  final String? userEmail;
  @override
  final int? level;
  @override
  final DateTime? createTime;
  @override
  final String? token;

  factory _$LoginUserResponse(
          [void Function(LoginUserResponseBuilder)? updates]) =>
      (LoginUserResponseBuilder()..update(updates))._build();

  _$LoginUserResponse._(
      {this.id,
      this.userAccount,
      this.userName,
      this.userAvatar,
      this.userProfile,
      this.userRole,
      this.userGender,
      this.userPhone,
      this.userEmail,
      this.level,
      this.createTime,
      this.token})
      : super._();
  @override
  LoginUserResponse rebuild(void Function(LoginUserResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginUserResponseBuilder toBuilder() =>
      LoginUserResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginUserResponse &&
        id == other.id &&
        userAccount == other.userAccount &&
        userName == other.userName &&
        userAvatar == other.userAvatar &&
        userProfile == other.userProfile &&
        userRole == other.userRole &&
        userGender == other.userGender &&
        userPhone == other.userPhone &&
        userEmail == other.userEmail &&
        level == other.level &&
        createTime == other.createTime &&
        token == other.token;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userAccount.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, userAvatar.hashCode);
    _$hash = $jc(_$hash, userProfile.hashCode);
    _$hash = $jc(_$hash, userRole.hashCode);
    _$hash = $jc(_$hash, userGender.hashCode);
    _$hash = $jc(_$hash, userPhone.hashCode);
    _$hash = $jc(_$hash, userEmail.hashCode);
    _$hash = $jc(_$hash, level.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginUserResponse')
          ..add('id', id)
          ..add('userAccount', userAccount)
          ..add('userName', userName)
          ..add('userAvatar', userAvatar)
          ..add('userProfile', userProfile)
          ..add('userRole', userRole)
          ..add('userGender', userGender)
          ..add('userPhone', userPhone)
          ..add('userEmail', userEmail)
          ..add('level', level)
          ..add('createTime', createTime)
          ..add('token', token))
        .toString();
  }
}

class LoginUserResponseBuilder
    implements Builder<LoginUserResponse, LoginUserResponseBuilder> {
  _$LoginUserResponse? _$v;

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

  String? _userRole;
  String? get userRole => _$this._userRole;
  set userRole(String? userRole) => _$this._userRole = userRole;

  int? _userGender;
  int? get userGender => _$this._userGender;
  set userGender(int? userGender) => _$this._userGender = userGender;

  String? _userPhone;
  String? get userPhone => _$this._userPhone;
  set userPhone(String? userPhone) => _$this._userPhone = userPhone;

  String? _userEmail;
  String? get userEmail => _$this._userEmail;
  set userEmail(String? userEmail) => _$this._userEmail = userEmail;

  int? _level;
  int? get level => _$this._level;
  set level(int? level) => _$this._level = level;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  LoginUserResponseBuilder() {
    LoginUserResponse._defaults(this);
  }

  LoginUserResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userAccount = $v.userAccount;
      _userName = $v.userName;
      _userAvatar = $v.userAvatar;
      _userProfile = $v.userProfile;
      _userRole = $v.userRole;
      _userGender = $v.userGender;
      _userPhone = $v.userPhone;
      _userEmail = $v.userEmail;
      _level = $v.level;
      _createTime = $v.createTime;
      _token = $v.token;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginUserResponse other) {
    _$v = other as _$LoginUserResponse;
  }

  @override
  void update(void Function(LoginUserResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginUserResponse build() => _build();

  _$LoginUserResponse _build() {
    final _$result = _$v ??
        _$LoginUserResponse._(
          id: id,
          userAccount: userAccount,
          userName: userName,
          userAvatar: userAvatar,
          userProfile: userProfile,
          userRole: userRole,
          userGender: userGender,
          userPhone: userPhone,
          userEmail: userEmail,
          level: level,
          createTime: createTime,
          token: token,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
