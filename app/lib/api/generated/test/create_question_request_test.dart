import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

// tests for CreateQuestionRequest
void main() {
  final instance = CreateQuestionRequestBuilder();
  // TODO add properties to the builder and call build()

  group(CreateQuestionRequest, () {
    // 题型: SINGLE_CHOICE/MULTI_CHOICE/FILL_BLANK/TRUE_FALSE/SHORT_ANSWER/CALCULATION/ESSAY
    // String type
    test('to test the property `type`', () async {
      // TODO
    });

    // 学科: MATH/CHINESE/ENGLISH/PHYSICS/CHEMISTRY/BIOLOGY/HISTORY/GEOGRAPHY/POLITICS
    // String subject
    test('to test the property `subject`', () async {
      // TODO
    });

    // 难度: 1-5
    // int difficulty
    test('to test the property `difficulty`', () async {
      // TODO
    });

    // 题干内容(支持KaTeX公式)
    // String content
    test('to test the property `content`', () async {
      // TODO
    });

    // 标准答案
    // String answer
    test('to test the property `answer`', () async {
      // TODO
    });

    // 年级
    // String grade
    test('to test the property `grade`', () async {
      // TODO
    });

    // 选项JSON字符串
    // String options
    test('to test the property `options`', () async {
      // TODO
    });

    // 解析
    // String explanation
    test('to test the property `explanation`', () async {
      // TODO
    });

    // 知识点标签
    // BuiltList<String> knowledgeTags
    test('to test the property `knowledgeTags`', () async {
      // TODO
    });

    // 题目图片URL
    // String imageUrl
    test('to test the property `imageUrl`', () async {
      // TODO
    });

    // 来源: MANUAL/AI/IMPORT
    // String source_
    test('to test the property `source_`', () async {
      // TODO
    });
  });
}
