import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

// tests for FriendRequestListDTO
void main() {
  final instance = FriendRequestListDTOBuilder();
  // TODO add properties to the builder and call build()

  group(FriendRequestListDTO, () {
    // 状态过滤：pending/accepted/rejected，不传则查询全部
    // String status
    test('to test the property `status`', () async {
      // TODO
    });

    // 页码
    // int pageNum (default value: 1)
    test('to test the property `pageNum`', () async {
      // TODO
    });

    // 每页数量
    // int pageSize (default value: 20)
    test('to test the property `pageSize`', () async {
      // TODO
    });
  });
}
