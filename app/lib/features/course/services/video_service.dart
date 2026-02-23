import '../../../core/network/api_client.dart';

/// 视频播放服务
/// 处理加密 HLS 视频的播放令牌和流地址获取
///
/// 播放流程：
/// 1. Flutter 通过 Dio（带 JWT）调用 /api/video/stream-token 获取一次性 stream token
/// 2. 拼装 URL：{baseUrl}/api/video/hls/{sectionId}?token={streamToken}
/// 3. 将此 URL 传给原生视频播放器（不需要任何自定义 HTTP Header）
/// 4. 后端验证 token 后返回修改过的 m3u8（key URI 中已嵌入密钥 token）
class VideoService {
  final _api = ApiClient.instance;

  /// 获取 HLS 播放流地址（带 Token 验证）
  ///
  /// 先通过 JWT 认证获取一次性 stream token，
  /// 再拼装成原生播放器可直接使用的 URL。
  ///
  /// [sectionId] 小节ID
  /// 返回带 token 的 m3u8 URL，失败返回 null
  Future<String?> getHlsStreamUrl(int sectionId) async {
    try {
      // 1. 通过 Dio（自动携带 JWT）获取一次性 stream token
      final response = await _api.dio.get<Map<String, dynamic>>(
        '/api/video/stream-token',
        queryParameters: {'sectionId': sectionId},
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data!;
        if (data['code'] == 0 && data['data'] != null) {
          final token = data['data'] as String;
          // 2. 拼装带 token 的 URL（原生播放器直接使用，不需要 HTTP Header）
          final baseUrl = _api.dio.options.baseUrl;
          return '$baseUrl/api/video/hls/$sectionId?token=$token';
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
