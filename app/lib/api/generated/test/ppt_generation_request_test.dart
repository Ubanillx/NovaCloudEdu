import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

// tests for PptGenerationRequest
void main() {
  final instance = PptGenerationRequestBuilder();
  // TODO add properties to the builder and call build()

  group(PptGenerationRequest, () {
    // 操作类型: detect_intent / generate_outline / revise_outline / confirm_outline / select_template / generate_ppt
    // String action
    test('to test the property `action`', () async {
      // TODO
    });

    // 会话ID（首次操作时为空，后续步骤必填）
    // int sessionId
    test('to test the property `sessionId`', () async {
      // TODO
    });

    // 用户消息（detect_intent 时使用，AI判断是否要生成PPT）
    // String message
    test('to test the property `message`', () async {
      // TODO
    });

    // PPT主题（generate_outline 时使用）
    // String topic
    test('to test the property `topic`', () async {
      // TODO
    });

    // 额外要求（generate_outline 时可选）
    // String requirements
    test('to test the property `requirements`', () async {
      // TODO
    });

    // 修改反馈（revise_outline 时使用）
    // String feedback
    test('to test the property `feedback`', () async {
      // TODO
    });

    // 系统模板ID（select_template 时使用）
    // int templateId
    test('to test the property `templateId`', () async {
      // TODO
    });

    // 自定义模板URL（select_template 时使用，与 templateId 二选一）
    // String templateUrl
    test('to test the property `templateUrl`', () async {
      // TODO
    });
  });
}
