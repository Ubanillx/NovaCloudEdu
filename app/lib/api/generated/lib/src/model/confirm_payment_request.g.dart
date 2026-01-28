// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_payment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConfirmPaymentRequest extends ConfirmPaymentRequest {
  @override
  final String orderNo;
  @override
  final int paymentMethod;
  @override
  final int? validityDays;

  factory _$ConfirmPaymentRequest([
    void Function(ConfirmPaymentRequestBuilder)? updates,
  ]) => (ConfirmPaymentRequestBuilder()..update(updates))._build();

  _$ConfirmPaymentRequest._({
    required this.orderNo,
    required this.paymentMethod,
    this.validityDays,
  }) : super._();
  @override
  ConfirmPaymentRequest rebuild(
    void Function(ConfirmPaymentRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ConfirmPaymentRequestBuilder toBuilder() =>
      ConfirmPaymentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfirmPaymentRequest &&
        orderNo == other.orderNo &&
        paymentMethod == other.paymentMethod &&
        validityDays == other.validityDays;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, orderNo.hashCode);
    _$hash = $jc(_$hash, paymentMethod.hashCode);
    _$hash = $jc(_$hash, validityDays.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConfirmPaymentRequest')
          ..add('orderNo', orderNo)
          ..add('paymentMethod', paymentMethod)
          ..add('validityDays', validityDays))
        .toString();
  }
}

class ConfirmPaymentRequestBuilder
    implements Builder<ConfirmPaymentRequest, ConfirmPaymentRequestBuilder> {
  _$ConfirmPaymentRequest? _$v;

  String? _orderNo;
  String? get orderNo => _$this._orderNo;
  set orderNo(String? orderNo) => _$this._orderNo = orderNo;

  int? _paymentMethod;
  int? get paymentMethod => _$this._paymentMethod;
  set paymentMethod(int? paymentMethod) =>
      _$this._paymentMethod = paymentMethod;

  int? _validityDays;
  int? get validityDays => _$this._validityDays;
  set validityDays(int? validityDays) => _$this._validityDays = validityDays;

  ConfirmPaymentRequestBuilder() {
    ConfirmPaymentRequest._defaults(this);
  }

  ConfirmPaymentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _orderNo = $v.orderNo;
      _paymentMethod = $v.paymentMethod;
      _validityDays = $v.validityDays;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfirmPaymentRequest other) {
    _$v = other as _$ConfirmPaymentRequest;
  }

  @override
  void update(void Function(ConfirmPaymentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConfirmPaymentRequest build() => _build();

  _$ConfirmPaymentRequest _build() {
    final _$result =
        _$v ??
        _$ConfirmPaymentRequest._(
          orderNo: BuiltValueNullFieldError.checkNotNull(
            orderNo,
            r'ConfirmPaymentRequest',
            'orderNo',
          ),
          paymentMethod: BuiltValueNullFieldError.checkNotNull(
            paymentMethod,
            r'ConfirmPaymentRequest',
            'paymentMethod',
          ),
          validityDays: validityDays,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
