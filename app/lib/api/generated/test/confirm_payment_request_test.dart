import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

// tests for ConfirmPaymentRequest
void main() {
  final instance = ConfirmPaymentRequestBuilder();
  // TODO add properties to the builder and call build()

  group(ConfirmPaymentRequest, () {
    // 订单号
    // String orderNo
    test('to test the property `orderNo`', () async {
      // TODO
    });

    // 支付方式：0-手动确认，1-支付宝，2-微信支付，3-银联支付
    // int paymentMethod
    test('to test the property `paymentMethod`', () async {
      // TODO
    });

    // 有效期（天数），null表示永久有效
    // int validityDays
    test('to test the property `validityDays`', () async {
      // TODO
    });
  });
}
