import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

// tests for WorkflowTriggerResponse
void main() {
  final instance = WorkflowTriggerResponseBuilder();
  // TODO add properties to the builder and call build()

  group(WorkflowTriggerResponse, () {
    // 触发器ID
    // int id
    test('to test the property `id`', () async {
      // TODO
    });

    // 工作流ID
    // int workflowId
    test('to test the property `workflowId`', () async {
      // TODO
    });

    // 触发器类型：SCHEDULE/WEBHOOK/EVENT
    // String type
    test('to test the property `type`', () async {
      // TODO
    });

    // 触发器名称
    // String name
    test('to test the property `name`', () async {
      // TODO
    });

    // 是否启用
    // bool enabled
    test('to test the property `enabled`', () async {
      // TODO
    });

    // 配置JSON
    // BuiltMap<String, JsonObject> config
    test('to test the property `config`', () async {
      // TODO
    });

    // 最后触发时间
    // DateTime lastTriggeredAt
    test('to test the property `lastTriggeredAt`', () async {
      // TODO
    });

    // 触发次数
    // int triggerCount
    test('to test the property `triggerCount`', () async {
      // TODO
    });

    // 创建时间
    // DateTime createTime
    test('to test the property `createTime`', () async {
      // TODO
    });
  });
}
