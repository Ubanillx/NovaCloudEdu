// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserLoginRequest extends UserLoginRequest {
  @override
  final String userAccount;
  @override
  final String userPassword;

  factory _$UserLoginRequest(
          [void Function(UserLoginRequestBuilder)? updates]) =>
      (UserLoginRequestBuilder()..update(updates))._build();

  _$UserLoginRequest._({required this.userAccount, required this.userPassword})
      : super._();
  @override
  UserLoginRequest rebuild(void Function(UserLoginRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserLoginRequestBuilder toBuilder() =>
      UserLoginRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserLoginRequest &&
        userAccount == other.userAccount &&
        userPassword == other.userPassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userAccount.hashCode);
    _$hash = $jc(_$hash, userPassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserLoginRequest')
          ..add('userAccount', userAccount)
          ..add('userPassword', userPassword))
        .toString();
  }
}

class UserLoginRequestBuilder
    implements Builder<UserLoginRequest, UserLoginRequestBuilder> {
  _$UserLoginRequest? _$v;

  String? _userAccount;
  String? get userAccount => _$this._userAccount;
  set userAccount(String? userAccount) => _$this._userAccount = userAccount;

  String? _userPassword;
  String? get userPassword => _$this._userPassword;
  set userPassword(String? userPassword) => _$this._userPassword = userPassword;

  UserLoginRequestBuilder() {
    UserLoginRequest._defaults(this);
  }

  UserLoginRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userAccount = $v.userAccount;
      _userPassword = $v.userPassword;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserLoginRequest other) {
    _$v = other as _$UserLoginRequest;
  }

  @override
  void update(void Function(UserLoginRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserLoginRequest build() => _build();

  _$UserLoginRequest _build() {
    final _$result = _$v ??
        _$UserLoginRequest._(
          userAccount: BuiltValueNullFieldError.checkNotNull(
              userAccount, r'UserLoginRequest', 'userAccount'),
          userPassword: BuiltValueNullFieldError.checkNotNull(
              userPassword, r'UserLoginRequest', 'userPassword'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
