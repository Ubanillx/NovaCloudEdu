import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// 聊天文件缓存服务
/// 用于缓存聊天中的图片和文件到本地持久化目录
class ChatFileCacheManager {
  static const _key = 'chatFileCache';
  
  static final ChatFileCacheManager _instance = ChatFileCacheManager._();
  static ChatFileCacheManager get instance => _instance;
  
  ChatFileCacheManager._();

  /// 聊天文件专用缓存管理器（最大缓存 500MB，保留 30 天）
  late final CacheManager _cacheManager = CacheManager(
    Config(
      _key,
      stalePeriod: const Duration(days: 30),
      maxNrOfCacheObjects: 1000,
    ),
  );

  CacheManager get cacheManager => _cacheManager;

  /// 获取缓存文件，如果不存在则下载
  Future<File> getFile(String url) async {
    final fileInfo = await _cacheManager.getFileFromCache(url);
    if (fileInfo != null) {
      return fileInfo.file;
    }
    return (await _cacheManager.downloadFile(url)).file;
  }

  /// 获取缓存文件（仅从缓存读取，不触发下载）
  Future<File?> getCachedFile(String url) async {
    final fileInfo = await _cacheManager.getFileFromCache(url);
    return fileInfo?.file;
  }

  /// 下载文件到持久化目录（用于文件消息，保证用户下载的文件不会被清理）
  /// 返回持久化后的文件路径
  Future<String> downloadToPersistent(
    String url,
    String fileName, {
    void Function(int received, int total)? onProgress,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final chatFilesDir = Directory(p.join(dir.path, 'chat_files'));
    if (!await chatFilesDir.exists()) {
      await chatFilesDir.create(recursive: true);
    }

    final filePath = p.join(chatFilesDir.path, fileName);
    final file = File(filePath);

    // 如果文件已存在，直接返回路径
    if (await file.exists()) {
      return filePath;
    }

    // 先尝试从缓存获取
    final cached = await getCachedFile(url);
    if (cached != null) {
      await cached.copy(filePath);
      return filePath;
    }

    // 缓存中没有，从网络下载并同时写入缓存
    final downloadedFile = await _cacheManager.getSingleFile(url);
    await downloadedFile.copy(filePath);
    return filePath;
  }

  /// 清除所有聊天文件缓存
  Future<void> clearCache() async {
    await _cacheManager.emptyCache();
  }

  /// 获取缓存大小（近似值）
  Future<int> getCacheSize() async {
    try {
      final dir = await getApplicationCacheDirectory();
      final cacheDir = Directory(p.join(dir.path, _key));
      if (!await cacheDir.exists()) return 0;

      int totalSize = 0;
      await for (final entity in cacheDir.list(recursive: true)) {
        if (entity is File) {
          totalSize += await entity.length();
        }
      }
      return totalSize;
    } catch (_) {
      return 0;
    }
  }
}
