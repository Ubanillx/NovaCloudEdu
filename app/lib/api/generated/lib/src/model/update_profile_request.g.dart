// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateProfileRequest extends UpdateProfileRequest {
  @override
  final String? userName;
  @override
  final String? userAvatar;
  @override
  final String? userProfile;
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

  factory _$UpdateProfileRequest(
          [void Function(UpdateProfileRequestBuilder)? updates]) =>
      (UpdateProfileRequestBuilder()..update(updates))._build();

  _$UpdateProfileRequest._(
      {this.userName,
      this.userAvatar,
      this.userProfile,
      this.userGender,
      this.userPhone,
      this.userEmail,
      this.userAddress,
      this.birthday})
      : super._();
  @override
  UpdateProfileRequest rebuild(
          void Function(UpdateProfileRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateProfileRequestBuilder toBuilder() =>
      UpdateProfileRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateProfileRequest &&
        userName == other.userName &&
        userAvatar == other.userAvatar &&
        userProfile == other.userProfile &&
        userGender == other.userGender &&
        userPhone == other.userPhone &&
        userEmail == other.userEmail &&
        userAddress == other.userAddress &&
        birthday == other.birthday;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, userAvatar.hashCode);
    _$hash = $jc(_$hash, userProfile.hashCode);
    _$hash = $jc(_$hash, userGender.hashCode);
    _$hash = $jc(_$hash, userPhone.hashCode);
    _$hash = $jc(_$hash, userEmail.hashCode);
    _$hash = $jc(_$hash, userAddress.hashCode);
    _$hash = $jc(_$hash, birthday.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateProfileRequest')
          ..add('userName', userName)
          ..add('userAvatar', userAvatar)
          ..add('userProfile', userProfile)
          ..add('userGender', userGender)
          ..add('userPhone', userPhone)
          ..add('userEmail', userEmail)
          ..add('userAddress', userAddress)
          ..add('birthday', birthday))
        .toString();
  }
}

class UpdateProfileRequestBuilder
    implements Builder<UpdateProfileRequest, UpdateProfileRequestBuilder> {
  _$UpdateProfileRequest? _$v;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  String? _userAvatar;
  String? get userAvatar => _$this._userAvatar;
  set userAvatar(String? userAvatar) => _$this._userAvatar = userAvatar;

  String? _userProfile;
  String? get userProfile => _$this._userProfile;
  set userProfile(String? userProfile) => _$this._userProfile = userProfile;

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

  UpdateProfileRequestBuilder() {
    UpdateProfileRequest._defaults(this);
  }

  UpdateProfileRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userName = $v.userName;
      _userAvatar = $v.userAvatar;
      _userProfile = $v.userProfile;
      _userGender = $v.userGender;
      _userPhone = $v.userPhone;
      _userEmail = $v.userEmail;
      _userAddress = $v.userAddress;
      _birthday = $v.birthday;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateProfileRequest other) {
    _$v = other as _$UpdateProfileRequest;
  }

  @override
  void update(void Function(UpdateProfileRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateProfileRequest build() => _build();

  _$UpdateProfileRequest _build() {
    final _$result = _$v ??
        _$UpdateProfileRequest._(
          userName: userName,
          userAvatar: userAvatar,
          userProfile: userProfile,
          userGender: userGender,
          userPhone: userPhone,
          userEmail: userEmail,
          userAddress: userAddress,
          birthday: birthday,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
