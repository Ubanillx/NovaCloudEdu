import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

/// tests for WebhookApi
void main() {
  final instance = NovaApi().getWebhookApi();

  group(WebhookApi, () {
    // 获取Webhook信息
    //
    //Future<BaseResponseWebhookInfo> getWebhookInfo(String webhookId) async
    test('test getWebhookInfo', () async {
      // TODO
    });

    // Webhook触发工作流
    //
    //Future<BaseResponseWebhookResponse> triggerWorkflow(String webhookId, { String xWebhookSignature, BuiltMap<String, JsonObject> requestBody }) async
    test('test triggerWorkflow', () async {
      // TODO
    });
  });
}
