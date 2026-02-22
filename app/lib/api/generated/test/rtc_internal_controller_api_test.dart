import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

/// tests for RtcInternalControllerApi
void main() {
  final instance = NovaApi().getRtcInternalControllerApi();

  group(RtcInternalControllerApi, () {
    //Future<BuiltMap<String, JsonObject>> checkPermission(CheckPermissionRequest checkPermissionRequest) async
    test('test checkPermission', () async {
      // TODO
    });

    //Future<BuiltMap<String, JsonObject>> saveCallRecord(SaveCallRecordRequest saveCallRecordRequest) async
    test('test saveCallRecord', () async {
      // TODO
    });
  });
}
