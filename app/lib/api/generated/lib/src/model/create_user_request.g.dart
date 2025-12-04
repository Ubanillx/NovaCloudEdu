// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateUserRequest extends CreateUserRequest {
  @override
  final String userAccount;
  @override
  final String userPassword;
  @override
  final String? userName;
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

  factory _$CreateUserRequest(
          [void Function(CreateUserRequestBuilder)? updates]) =>
      (CreateUserRequestBuilder()..update(updates))._build();

  _$CreateUserRequest._(
      {required this.userAccount,
      required this.userPassword,
      this.userName,
      this.role,
      this.userGender,
      this.userPhone,
      this.userEmail,
      this.userAddress,
      this.birthday})
      : super._();
  @override
  CreateUserRequest rebuild(void Function(CreateUserRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateUserRequestBuilder toBuilder() =>
      CreateUserRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateUserRequest &&
        userAccount == other.userAccount &&
        userPassword == other.userPassword &&
        userName == other.userName &&
        role == other.role &&
        userGender == other.userGender &&
        userPhone == other.userPhone &&
        userEmail == other.userEmail &&
        userAddress == other.userAddress &&
        birthday == other.birthday;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userAccount.hashCode);
    _$hash = $jc(_$hash, userPassword.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
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
    return (newBuiltValueToStringHelper(r'CreateUserRequest')
          ..add('userAccount', userAccount)
          ..add('userPassword', userPassword)
          ..add('userName', userName)
          ..add('role', role)
          ..add('userGender', userGender)
          ..add('userPhone', userPhone)
          ..add('userEmail', userEmail)
          ..add('userAddress', userAddress)
          ..add('birthday', birthday))
        .toString();
  }
}

class CreateUserRequestBuilder
    implements Builder<CreateUserRequest, CreateUserRequestBuilder> {
  _$CreateUserRequest? _$v;

  String? _userAccount;
  String? get userAccount => _$this._userAccount;
  set userAccount(String? userAccount) => _$this._userAccount = userAccount;

  String? _userPassword;
  String? get userPassword => _$this._userPassword;
  set userPassword(String? userPassword) => _$this._userPassword = userPassword;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

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

  CreateUserRequestBuilder() {
    CreateUserRequest._defaults(this);
  }

  CreateUserRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userAccount = $v.userAccount;
      _userPassword = $v.userPassword;
      _userName = $v.userName;
      _role = $v.role;
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
  void replace(CreateUserRequest other) {
    _$v = other as _$CreateUserRequest;
  }

  @override
  void update(void Function(CreateUserRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateUserRequest build() => _build();

  _$CreateUserRequest _build() {
    final _$result = _$v ??
        _$CreateUserRequest._(
          userAccount: BuiltValueNullFieldError.checkNotNull(
              userAccount, r'CreateUserRequest', 'userAccount'),
          userPassword: BuiltValueNullFieldError.checkNotNull(
              userPassword, r'CreateUserRequest', 'userPassword'),
          userName: userName,
          role: role,
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
