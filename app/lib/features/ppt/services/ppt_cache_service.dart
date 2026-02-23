import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// PPT 离线缓存服务
/// 缓存已生成的会话列表、预览图 URL 和下载记录
class PptCacheService {
  static const _keySessionList = 'ppt_cached_sessions';
  static const _keySlideImages = 'ppt_cached_slides_';
  static const _keyDownloads = 'ppt_cached_downloads';

  final _storage = const FlutterSecureStorage();

  // ==================== 会话列表缓存 ====================

  /// 缓存会话列表（JSON 数组）
  Future<void> cacheSessions(List<Map<String, dynamic>> sessions) async {
    try {
      await _storage.write(key: _keySessionList, value: jsonEncode(sessions));
    } catch (e) {
      debugPrint('缓存PPT会话列表失败: $e');
    }
  }

  /// 读取缓存的会话列表
  Future<List<Map<String, dynamic>>> getCachedSessions() async {
    try {
      final raw = await _storage.read(key: _keySessionList);
      if (raw != null) {
        return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
      }
    } catch (e) {
      debugPrint('读取缓存PPT会话列表失败: $e');
    }
    return [];
  }

  // ==================== 幻灯片预览图缓存 ====================

  /// 缓存某个会话的幻灯片预览图 URL 列表
  Future<void> cacheSlideImages(String sessionId, List<String?> imageUrls) async {
    try {
      await _storage.write(key: '$_keySlideImages$sessionId', value: jsonEncode(imageUrls));
    } catch (e) {
      debugPrint('缓存幻灯片预览图失败: $e');
    }
  }

  /// 读取缓存的幻灯片预览图 URL
  Future<List<String?>> getCachedSlideImages(String sessionId) async {
    try {
      final raw = await _storage.read(key: '$_keySlideImages$sessionId');
      if (raw != null) {
        return (jsonDecode(raw) as List).cast<String?>();
      }
    } catch (e) {
      debugPrint('读取缓存幻灯片预览图失败: $e');
    }
    return [];
  }

  // ==================== 下载记录缓存 ====================

  /// 记录已下载的 PPT 文件本地路径
  Future<void> cacheDownload(String sessionId, String localPath, String fileName) async {
    try {
      final raw = await _storage.read(key: _keyDownloads);
      final downloads = raw != null
          ? Map<String, dynamic>.from(jsonDecode(raw) as Map)
          : <String, dynamic>{};
      downloads[sessionId] = {'path': localPath, 'fileName': fileName};
      await _storage.write(key: _keyDownloads, value: jsonEncode(downloads));
    } catch (e) {
      debugPrint('缓存下载记录失败: $e');
    }
  }

  /// 获取已下载的本地路径
  Future<Map<String, String>?> getCachedDownload(String sessionId) async {
    try {
      final raw = await _storage.read(key: _keyDownloads);
      if (raw != null) {
        final downloads = jsonDecode(raw) as Map;
        if (downloads.containsKey(sessionId)) {
          final entry = downloads[sessionId] as Map;
          return {
            'path': entry['path'] as String,
            'fileName': entry['fileName'] as String,
          };
        }
      }
    } catch (e) {
      debugPrint('读取下载记录失败: $e');
    }
    return null;
  }

  /// 获取所有下载记录
  Future<Map<String, Map<String, String>>> getAllDownloads() async {
    try {
      final raw = await _storage.read(key: _keyDownloads);
      if (raw != null) {
        final downloads = jsonDecode(raw) as Map;
        return downloads.map((k, v) => MapEntry(
          k as String,
          Map<String, String>.from(v as Map),
        ));
      }
    } catch (e) {
      debugPrint('读取所有下载记录失败: $e');
    }
    return {};
  }

  // ==================== 清理 ====================

  /// 清除指定会话的缓存
  Future<void> clearSession(String sessionId) async {
    await _storage.delete(key: '$_keySlideImages$sessionId');
  }

  /// 清除所有缓存
  Future<void> clearAll() async {
    final all = await _storage.readAll();
    for (final key in all.keys) {
      if (key.startsWith('ppt_cached_')) {
        await _storage.delete(key: key);
      }
    }
  }
}
