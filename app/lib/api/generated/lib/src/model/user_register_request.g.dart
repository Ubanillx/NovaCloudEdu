// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_register_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserRegisterRequest extends UserRegisterRequest {
  @override
  final String userAccount;
  @override
  final String userPassword;
  @override
  final String checkPassword;
  @override
  final String phone;
  @override
  final String smsCode;

  factory _$UserRegisterRequest(
          [void Function(UserRegisterRequestBuilder)? updates]) =>
      (UserRegisterRequestBuilder()..update(updates))._build();

  _$UserRegisterRequest._(
      {required this.userAccount,
      required this.userPassword,
      required this.checkPassword,
      required this.phone,
      required this.smsCode})
      : super._();
  @override
  UserRegisterRequest rebuild(
          void Function(UserRegisterRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserRegisterRequestBuilder toBuilder() =>
      UserRegisterRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserRegisterRequest &&
        userAccount == other.userAccount &&
        userPassword == other.userPassword &&
        checkPassword == other.checkPassword &&
        phone == other.phone &&
        smsCode == other.smsCode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userAccount.hashCode);
    _$hash = $jc(_$hash, userPassword.hashCode);
    _$hash = $jc(_$hash, checkPassword.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, smsCode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserRegisterRequest')
          ..add('userAccount', userAccount)
          ..add('userPassword', userPassword)
          ..add('checkPassword', checkPassword)
          ..add('phone', phone)
          ..add('smsCode', smsCode))
        .toString();
  }
}

class UserRegisterRequestBuilder
    implements Builder<UserRegisterRequest, UserRegisterRequestBuilder> {
  _$UserRegisterRequest? _$v;

  String? _userAccount;
  String? get userAccount => _$this._userAccount;
  set userAccount(String? userAccount) => _$this._userAccount = userAccount;

  String? _userPassword;
  String? get userPassword => _$this._userPassword;
  set userPassword(String? userPassword) => _$this._userPassword = userPassword;

  String? _checkPassword;
  String? get checkPassword => _$this._checkPassword;
  set checkPassword(String? checkPassword) =>
      _$this._checkPassword = checkPassword;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _smsCode;
  String? get smsCode => _$this._smsCode;
  set smsCode(String? smsCode) => _$this._smsCode = smsCode;

  UserRegisterRequestBuilder() {
    UserRegisterRequest._defaults(this);
  }

  UserRegisterRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userAccount = $v.userAccount;
      _userPassword = $v.userPassword;
      _checkPassword = $v.checkPassword;
      _phone = $v.phone;
      _smsCode = $v.smsCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserRegisterRequest other) {
    _$v = other as _$UserRegisterRequest;
  }

  @override
  void update(void Function(UserRegisterRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserRegisterRequest build() => _build();

  _$UserRegisterRequest _build() {
    final _$result = _$v ??
        _$UserRegisterRequest._(
          userAccount: BuiltValueNullFieldError.checkNotNull(
              userAccount, r'UserRegisterRequest', 'userAccount'),
          userPassword: BuiltValueNullFieldError.checkNotNull(
              userPassword, r'UserRegisterRequest', 'userPassword'),
          checkPassword: BuiltValueNullFieldError.checkNotNull(
              checkPassword, r'UserRegisterRequest', 'checkPassword'),
          phone: BuiltValueNullFieldError.checkNotNull(
              phone, r'UserRegisterRequest', 'phone'),
          smsCode: BuiltValueNullFieldError.checkNotNull(
              smsCode, r'UserRegisterRequest', 'smsCode'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
