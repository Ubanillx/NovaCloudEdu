import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

/// tests for MCPApi
void main() {
  final instance = NovaApi().getMCPApi();

  group(MCPApi, () {
    // 创建MCP服务器
    //
    //Future<BaseResponseMapStringObject> mcpServerCreate(int userId, BuiltMap<String, JsonObject> requestBody) async
    test('test mcpServerCreate', () async {
      // TODO
    });

    // 删除MCP服务器
    //
    //Future<BaseResponseVoid> mcpServerDelete(int id, int userId) async
    test('test mcpServerDelete', () async {
      // TODO
    });

    // 获取MCP服务器详情
    //
    //Future<BaseResponseMapStringObject> mcpServerGetById(int id) async
    test('test mcpServerGetById', () async {
      // TODO
    });

    // 获取用户的MCP服务器列表
    //
    //Future<BaseResponseListMapStringObject> mcpServerListByCreator(int userId) async
    test('test mcpServerListByCreator', () async {
      // TODO
    });

    // 获取MCP服务器提供的工具列表
    //
    //Future<BaseResponseListMapStringObject> mcpServerListTools(int id) async
    test('test mcpServerListTools', () async {
      // TODO
    });

    // 启用/禁用MCP服务器
    //
    //Future<BaseResponseVoid> mcpServerSetEnabled(int id, int userId, bool enabled) async
    test('test mcpServerSetEnabled', () async {
      // TODO
    });

    // 测试MCP服务器连接
    //
    //Future<BaseResponseMapStringString> mcpServerTestConnection(int id) async
    test('test mcpServerTestConnection', () async {
      // TODO
    });

    // 更新MCP服务器
    //
    //Future<BaseResponseVoid> mcpServerUpdate(int id, int userId, BuiltMap<String, JsonObject> requestBody) async
    test('test mcpServerUpdate', () async {
      // TODO
    });
  });
}
