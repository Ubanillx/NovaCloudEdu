// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_login_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PhoneLoginRequest extends PhoneLoginRequest {
  @override
  final String phone;
  @override
  final String smsCode;

  factory _$PhoneLoginRequest([
    void Function(PhoneLoginRequestBuilder)? updates,
  ]) => (PhoneLoginRequestBuilder()..update(updates))._build();

  _$PhoneLoginRequest._({required this.phone, required this.smsCode})
    : super._();
  @override
  PhoneLoginRequest rebuild(void Function(PhoneLoginRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PhoneLoginRequestBuilder toBuilder() =>
      PhoneLoginRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PhoneLoginRequest &&
        phone == other.phone &&
        smsCode == other.smsCode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, smsCode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PhoneLoginRequest')
          ..add('phone', phone)
          ..add('smsCode', smsCode))
        .toString();
  }
}

class PhoneLoginRequestBuilder
    implements Builder<PhoneLoginRequest, PhoneLoginRequestBuilder> {
  _$PhoneLoginRequest? _$v;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _smsCode;
  String? get smsCode => _$this._smsCode;
  set smsCode(String? smsCode) => _$this._smsCode = smsCode;

  PhoneLoginRequestBuilder() {
    PhoneLoginRequest._defaults(this);
  }

  PhoneLoginRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _phone = $v.phone;
      _smsCode = $v.smsCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PhoneLoginRequest other) {
    _$v = other as _$PhoneLoginRequest;
  }

  @override
  void update(void Function(PhoneLoginRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PhoneLoginRequest build() => _build();

  _$PhoneLoginRequest _build() {
    final _$result =
        _$v ??
        _$PhoneLoginRequest._(
          phone: BuiltValueNullFieldError.checkNotNull(
            phone,
            r'PhoneLoginRequest',
            'phone',
          ),
          smsCode: BuiltValueNullFieldError.checkNotNull(
            smsCode,
            r'PhoneLoginRequest',
            'smsCode',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
