// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateUserRequest extends UpdateUserRequest {
  @override
  final int id;
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

  factory _$UpdateUserRequest(
          [void Function(UpdateUserRequestBuilder)? updates]) =>
      (UpdateUserRequestBuilder()..update(updates))._build();

  _$UpdateUserRequest._(
      {required this.id,
      this.userName,
      this.userAvatar,
      this.userProfile,
      this.role,
      this.userGender,
      this.userPhone,
      this.userEmail,
      this.userAddress,
      this.birthday,
      this.level})
      : super._();
  @override
  UpdateUserRequest rebuild(void Function(UpdateUserRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateUserRequestBuilder toBuilder() =>
      UpdateUserRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateUserRequest &&
        id == other.id &&
        userName == other.userName &&
        userAvatar == other.userAvatar &&
        userProfile == other.userProfile &&
        role == other.role &&
        userGender == other.userGender &&
        userPhone == other.userPhone &&
        userEmail == other.userEmail &&
        userAddress == other.userAddress &&
        birthday == other.birthday &&
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
    _$hash = $jc(_$hash, userPhone.hashCode);
    _$hash = $jc(_$hash, userEmail.hashCode);
    _$hash = $jc(_$hash, userAddress.hashCode);
    _$hash = $jc(_$hash, birthday.hashCode);
    _$hash = $jc(_$hash, level.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateUserRequest')
          ..add('id', id)
          ..add('userName', userName)
          ..add('userAvatar', userAvatar)
          ..add('userProfile', userProfile)
          ..add('role', role)
          ..add('userGender', userGender)
          ..add('userPhone', userPhone)
          ..add('userEmail', userEmail)
          ..add('userAddress', userAddress)
          ..add('birthday', birthday)
          ..add('level', level))
        .toString();
  }
}

class UpdateUserRequestBuilder
    implements Builder<UpdateUserRequest, UpdateUserRequestBuilder> {
  _$UpdateUserRequest? _$v;

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

  UpdateUserRequestBuilder() {
    UpdateUserRequest._defaults(this);
  }

  UpdateUserRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
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
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateUserRequest other) {
    _$v = other as _$UpdateUserRequest;
  }

  @override
  void update(void Function(UpdateUserRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateUserRequest build() => _build();

  _$UpdateUserRequest _build() {
    final _$result = _$v ??
        _$UpdateUserRequest._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'UpdateUserRequest', 'id'),
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
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
