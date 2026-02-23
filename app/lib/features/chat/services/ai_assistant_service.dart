import 'package:flutter/foundation.dart';
import 'package:nova_api/nova_api.dart';
import '../../../core/network/api_client.dart';

/// AI智慧体服务
class AiAssistantService {
  final _api = ApiClient.instance.aiApi;

  /// 获取公开的智慧体列表
  Future<List<AiAssistantVO>> getPublicAssistants({
    int page = 0,
    int size = 20,
  }) async {
    try {
      final response = await _api.assistantListPublic(
        page: page,
        size: size,
      );

      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!.toList();
      }
    } catch (e) {
      debugPrint('获取公开智慧体列表失败: $e');
    }
    return [];
  }

  /// 获取智慧体详情
  Future<AiAssistantVO?> getAssistantById(int id) async {
    try {
      final response = await _api.assistantGetById(id: id);

      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data;
      }
    } catch (e) {
      debugPrint('获取智慧体详情失败: $e');
    }
    return null;
  }

  /// 搜索智慧体
  Future<List<AiAssistantVO>> searchAssistants({
    required String keyword,
    int page = 0,
    int size = 20,
  }) async {
    try {
      final response = await _api.assistantSearch(
        keyword: keyword,
        page: page,
        size: size,
      );

      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!.toList();
      }
    } catch (e) {
      debugPrint('搜索智慧体失败: $e');
    }
    return [];
  }

  /// 获取用户创建的智慧体列表
  Future<List<AiAssistantVO>> getUserAssistants({
    required int userId,
    int page = 0,
    int size = 20,
  }) async {
    try {
      final response = await _api.assistantListByCreator(
        userId: userId,
        page: page,
        size: size,
      );

      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!.toList();
      }
    } catch (e) {
      debugPrint('获取用户智慧体列表失败: $e');
    }
    return [];
  }
}
