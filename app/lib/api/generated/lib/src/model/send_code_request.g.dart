// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_code_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendCodeRequest extends SendCodeRequest {
  @override
  final String phone;

  factory _$SendCodeRequest([void Function(SendCodeRequestBuilder)? updates]) =>
      (SendCodeRequestBuilder()..update(updates))._build();

  _$SendCodeRequest._({required this.phone}) : super._();
  @override
  SendCodeRequest rebuild(void Function(SendCodeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SendCodeRequestBuilder toBuilder() => SendCodeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendCodeRequest && phone == other.phone;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SendCodeRequest')
          ..add('phone', phone))
        .toString();
  }
}

class SendCodeRequestBuilder
    implements Builder<SendCodeRequest, SendCodeRequestBuilder> {
  _$SendCodeRequest? _$v;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  SendCodeRequestBuilder() {
    SendCodeRequest._defaults(this);
  }

  SendCodeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _phone = $v.phone;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendCodeRequest other) {
    _$v = other as _$SendCodeRequest;
  }

  @override
  void update(void Function(SendCodeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SendCodeRequest build() => _build();

  _$SendCodeRequest _build() {
    final _$result = _$v ??
        _$SendCodeRequest._(
          phone: BuiltValueNullFieldError.checkNotNull(
              phone, r'SendCodeRequest', 'phone'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
