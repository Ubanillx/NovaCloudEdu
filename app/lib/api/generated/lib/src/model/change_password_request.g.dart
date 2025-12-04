// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChangePasswordRequest extends ChangePasswordRequest {
  @override
  final String oldPassword;
  @override
  final String newPassword;
  @override
  final String confirmPassword;

  factory _$ChangePasswordRequest(
          [void Function(ChangePasswordRequestBuilder)? updates]) =>
      (ChangePasswordRequestBuilder()..update(updates))._build();

  _$ChangePasswordRequest._(
      {required this.oldPassword,
      required this.newPassword,
      required this.confirmPassword})
      : super._();
  @override
  ChangePasswordRequest rebuild(
          void Function(ChangePasswordRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChangePasswordRequestBuilder toBuilder() =>
      ChangePasswordRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChangePasswordRequest &&
        oldPassword == other.oldPassword &&
        newPassword == other.newPassword &&
        confirmPassword == other.confirmPassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, oldPassword.hashCode);
    _$hash = $jc(_$hash, newPassword.hashCode);
    _$hash = $jc(_$hash, confirmPassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChangePasswordRequest')
          ..add('oldPassword', oldPassword)
          ..add('newPassword', newPassword)
          ..add('confirmPassword', confirmPassword))
        .toString();
  }
}

class ChangePasswordRequestBuilder
    implements Builder<ChangePasswordRequest, ChangePasswordRequestBuilder> {
  _$ChangePasswordRequest? _$v;

  String? _oldPassword;
  String? get oldPassword => _$this._oldPassword;
  set oldPassword(String? oldPassword) => _$this._oldPassword = oldPassword;

  String? _newPassword;
  String? get newPassword => _$this._newPassword;
  set newPassword(String? newPassword) => _$this._newPassword = newPassword;

  String? _confirmPassword;
  String? get confirmPassword => _$this._confirmPassword;
  set confirmPassword(String? confirmPassword) =>
      _$this._confirmPassword = confirmPassword;

  ChangePasswordRequestBuilder() {
    ChangePasswordRequest._defaults(this);
  }

  ChangePasswordRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oldPassword = $v.oldPassword;
      _newPassword = $v.newPassword;
      _confirmPassword = $v.confirmPassword;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChangePasswordRequest other) {
    _$v = other as _$ChangePasswordRequest;
  }

  @override
  void update(void Function(ChangePasswordRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChangePasswordRequest build() => _build();

  _$ChangePasswordRequest _build() {
    final _$result = _$v ??
        _$ChangePasswordRequest._(
          oldPassword: BuiltValueNullFieldError.checkNotNull(
              oldPassword, r'ChangePasswordRequest', 'oldPassword'),
          newPassword: BuiltValueNullFieldError.checkNotNull(
              newPassword, r'ChangePasswordRequest', 'newPassword'),
          confirmPassword: BuiltValueNullFieldError.checkNotNull(
              confirmPassword, r'ChangePasswordRequest', 'confirmPassword'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
