import 'package:built_collection/built_collection.dart';
import 'package:nova_api/nova_api.dart';

import '../../../core/network/api_client.dart';

/// 课程表服务
class ScheduleService {
  final _api = ApiClient.instance;

  /// 获取我的课表
  Future<BuiltList<ClassScheduleItemResponse>> getMySchedule() async {
    try {
      final response = await _api.defaultApi.getMySchedule();
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '获取课表失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 添加课程项
  Future<int> addItem(AddScheduleItemRequest request) async {
    try {
      final response = await _api.defaultApi.addItem(
        addScheduleItemRequest: request,
      );
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '添加课程失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 更新课程项
  Future<bool> updateItem(int id, UpdateScheduleItemRequest request) async {
    try {
      final response = await _api.defaultApi.updateItem(
        id: id,
        updateScheduleItemRequest: request,
      );
      if (response.data?.code == 0) {
        return response.data?.data ?? true;
      }
      throw Exception(response.data?.message ?? '更新课程失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 删除课程项
  Future<bool> deleteItem(int id) async {
    try {
      final response = await _api.defaultApi.deleteItem(id: id);
      if (response.data?.code == 0) {
        return response.data?.data ?? true;
      }
      throw Exception(response.data?.message ?? '删除课程失败');
    } catch (e) {
      rethrow;
    }
  }
}
