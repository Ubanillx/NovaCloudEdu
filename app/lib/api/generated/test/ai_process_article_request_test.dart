import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

// tests for AiProcessArticleRequest
void main() {
  final instance = AiProcessArticleRequestBuilder();
  // TODO add properties to the builder and call build()

  group(AiProcessArticleRequest, () {
    // 文章ID
    // int articleId
    test('to test the property `articleId`', () async {
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

    // 摘要最大长度
    // int summaryMaxLength (default value: 150)
    test('to test the property `summaryMaxLength`', () async {
      // TODO
    });
  });
}
