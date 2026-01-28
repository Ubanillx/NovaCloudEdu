import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

// tests for ReviewApplicationRequest
void main() {
  final instance = ReviewApplicationRequestBuilder();
  // TODO add properties to the builder and call build()

  group(ReviewApplicationRequest, () {
    // 申请ID
    // int applicationId
    test('to test the property `applicationId`', () async {
      // TODO
    });

    // 是否通过：true-通过，false-拒绝
    // bool approved
    test('to test the property `approved`', () async {
      // TODO
    });

    // 拒绝原因（拒绝时必填）
    // String rejectReason
    test('to test the property `rejectReason`', () async {
      // TODO
    });
  });
}
