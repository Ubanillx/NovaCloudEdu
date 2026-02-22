import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

// tests for CreatePlanRequest
void main() {
  final instance = CreatePlanRequestBuilder();
  // TODO add properties to the builder and call build()

  group(CreatePlanRequest, () {
    // 计划名称
    // String name
    test('to test the property `name`', () async {
      // TODO
    });

    // 计划编码：FREE/BASIC/PRO/TEACHER
    // String code
    test('to test the property `code`', () async {
      // TODO
    });

    // 价格
    // num price
    test('to test the property `price`', () async {
      // TODO
    });

    // 计划描述
    // String description
    test('to test the property `description`', () async {
      // TODO
    });

    // 有效期天数，0表示永久
    // int durationDays
    test('to test the property `durationDays`', () async {
      // TODO
    });
  });
}
