import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

// tests for ErrorHandlingConfigDTO
void main() {
  final instance = ErrorHandlingConfigDTOBuilder();
  // TODO add properties to the builder and call build()

  group(ErrorHandlingConfigDTO, () {
    // 错误处理策略
    // String onError
    test('to test the property `onError`', () async {
      // TODO
    });

    // 重试次数
    // int retryCount
    test('to test the property `retryCount`', () async {
      // TODO
    });

    // 重试延迟（毫秒）
    // int retryDelayMs
    test('to test the property `retryDelayMs`', () async {
      // TODO
    });

    // 回退节点ID
    // String fallbackNodeId
    test('to test the property `fallbackNodeId`', () async {
      // TODO
    });

    // 超时时间（毫秒）
    // int timeoutMs
    test('to test the property `timeoutMs`', () async {
      // TODO
    });
  });
}
