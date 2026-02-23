import 'package:built_collection/built_collection.dart';
import 'package:nova_api/nova_api.dart';
import '../../../core/network/api_client.dart';

/// 订单服务
class OrderService {
  final _api = ApiClient.instance;

  /// 创建订单
  Future<String> createOrder(int courseId) async {
    try {
      final response = await _api.defaultApi.createOrder(
        createOrderRequest: CreateOrderRequest((b) => b..courseId = courseId),
      );
      if (response.data?.code == 0 && response.data?.data != null && response.data!.data!.isNotEmpty) {
        return response.data!.data!.first;
      }
      throw Exception(response.data?.message ?? '创建订单失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 获取订单详情
  Future<OrderResponse> getOrder(String orderNo) async {
    try {
      final response = await _api.defaultApi.getOrder(orderNo: orderNo);
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '获取订单失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 获取我的订单列表
  Future<BuiltList<OrderResponse>> getMyOrders({
    int page = 1,
    int size = 20,
  }) async {
    try {
      final response = await _api.defaultApi.getMyOrders(
        page: page,
        size: size,
      );
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '获取订单列表失败');
    } catch (e) {
      rethrow;
    }
  }
}
