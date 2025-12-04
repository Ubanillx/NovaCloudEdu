// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_sms_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendSmsRequest extends SendSmsRequest {
  @override
  final String phone;
  @override
  final String? code;
  @override
  final int? expireMinutes;

  factory _$SendSmsRequest([void Function(SendSmsRequestBuilder)? updates]) =>
      (SendSmsRequestBuilder()..update(updates))._build();

  _$SendSmsRequest._({required this.phone, this.code, this.expireMinutes})
      : super._();
  @override
  SendSmsRequest rebuild(void Function(SendSmsRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SendSmsRequestBuilder toBuilder() => SendSmsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendSmsRequest &&
        phone == other.phone &&
        code == other.code &&
        expireMinutes == other.expireMinutes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, expireMinutes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SendSmsRequest')
          ..add('phone', phone)
          ..add('code', code)
          ..add('expireMinutes', expireMinutes))
        .toString();
  }
}

class SendSmsRequestBuilder
    implements Builder<SendSmsRequest, SendSmsRequestBuilder> {
  _$SendSmsRequest? _$v;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  int? _expireMinutes;
  int? get expireMinutes => _$this._expireMinutes;
  set expireMinutes(int? expireMinutes) =>
      _$this._expireMinutes = expireMinutes;

  SendSmsRequestBuilder() {
    SendSmsRequest._defaults(this);
  }

  SendSmsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _phone = $v.phone;
      _code = $v.code;
      _expireMinutes = $v.expireMinutes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendSmsRequest other) {
    _$v = other as _$SendSmsRequest;
  }

  @override
  void update(void Function(SendSmsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SendSmsRequest build() => _build();

  _$SendSmsRequest _build() {
    final _$result = _$v ??
        _$SendSmsRequest._(
          phone: BuiltValueNullFieldError.checkNotNull(
              phone, r'SendSmsRequest', 'phone'),
          code: code,
          expireMinutes: expireMinutes,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
