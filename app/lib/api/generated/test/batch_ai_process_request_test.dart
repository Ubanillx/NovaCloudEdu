import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

// tests for BatchAiProcessRequest
void main() {
  final instance = BatchAiProcessRequestBuilder();
  // TODO add properties to the builder and call build()

  group(BatchAiProcessRequest, () {
    // 文章ID列表
    // BuiltList<int> articleIds
    test('to test the property `articleIds`', () async {
      // TODO
    });

    // 是否格式化内容为 Markdown
    // bool formatContent (default value: true)
    test('to test the property `formatContent`', () async {
      // TODO
    });

    // 是否生成摘要
    // bool generateSummary (default value: true)
    test('to test the property `generateSummary`', () async {
      // TODO
    });
  });
}
