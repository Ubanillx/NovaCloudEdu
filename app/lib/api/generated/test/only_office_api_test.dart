import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

/// tests for OnlyOfficeApi
void main() {
  final instance = NovaApi().getOnlyOfficeApi();

  group(OnlyOfficeApi, () {
    // 获取OnlyOffice编辑器配置
    //
    //Future<BuiltMap<String, JsonObject>> getEditorConfig(String fileUrl, { String fileName }) async
    test('test getEditorConfig', () async {
      // TODO
    });

    // OnlyOffice保存回调
    //
    // 无需认证，由OnlyOffice服务器调用
    //
    //Future<BuiltMap<String, JsonObject>> handleCallback(BuiltMap<String, JsonObject> requestBody) async
    test('test handleCallback', () async {
      // TODO
    });
  });
}
