import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

// tests for AiGenerateQuestionsRequest
void main() {
  final instance = AiGenerateQuestionsRequestBuilder();
  // TODO add properties to the builder and call build()

  group(AiGenerateQuestionsRequest, () {
    // 学科: MATH/CHINESE/ENGLISH/PHYSICS/CHEMISTRY/BIOLOGY/HISTORY/GEOGRAPHY/POLITICS
    // String subject
    test('to test the property `subject`', () async {
      // TODO
    });

    // 题型: SINGLE_CHOICE/MULTI_CHOICE/FILL_BLANK/TRUE_FALSE/SHORT_ANSWER/CALCULATION/ESSAY
    // String type
    test('to test the property `type`', () async {
      // TODO
    });

    // 难度: 1-5
    // int difficulty
    test('to test the property `difficulty`', () async {
      // TODO
    });

    // 生成数量
    // int count
    test('to test the property `count`', () async {
      // TODO
    });

    // 年级
    // String grade
    test('to test the property `grade`', () async {
      // TODO
    });

    // 知识点/主题描述
    // String topic
    test('to test the property `topic`', () async {
      // TODO
    });

    // 是否生成几何图形（Typst cetz 渲染）
    // bool withDiagram
    test('to test the property `withDiagram`', () async {
      // TODO
    });

    // 是否生成配图（文生图）
    // bool withImage
    test('to test the property `withImage`', () async {
      // TODO
    });

    // 是否启用联网搜索热点出题
    // bool enableWebSearch
    test('to test the property `enableWebSearch`', () async {
      // TODO
    });

    // AI 模型ID（可选，如 dashscope/qwen-max）
    // String modelId
    test('to test the property `modelId`', () async {
      // TODO
    });

    // 用户自定义补充要求（如出题风格、特殊限制、场景描述等）
    // String userInput
    test('to test the property `userInput`', () async {
      // TODO
    });
  });
}
