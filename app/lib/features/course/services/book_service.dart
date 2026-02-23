import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:nova_api/nova_api.dart';
import '../../../core/network/api_client.dart';

/// 电子书服务 - 封装书籍、书架、书签、阅读进度相关 API
class BookService {
  final _api = ApiClient.instance;

  // ==================== 书籍 ====================

  /// 获取书籍列表
  Future<BuiltList<BookDTO>> listBooks({int page = 1, int size = 20}) async {
    try {
      final response = await _api.defaultApi.listBooks(page: page, size: size);
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '获取书籍列表失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 搜索书籍
  Future<BuiltList<BookDTO>> searchBooks({
    required String keyword,
    int page = 1,
    int size = 20,
  }) async {
    try {
      final response = await _api.defaultApi.searchBooks1(
        keyword: keyword,
        page: page,
        size: size,
      );
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '搜索书籍失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 获取书籍详情
  Future<BookDTO> getBook(int bookId) async {
    try {
      final response = await _api.defaultApi.getBook(bookId: bookId);
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '获取书籍详情失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 获取章节列表
  Future<BuiltList<ChapterDTO>> getBookChapters(int bookId) async {
    try {
      final response = await _api.defaultApi.getBookChapters(bookId: bookId);
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '获取章节列表失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 获取章节内容
  Future<ChapterContentDTO> getChapterContent(int bookId, int chapterIndex) async {
    try {
      final response = await _api.defaultApi.getChapterContent(
        bookId: bookId,
        chapterIndex: chapterIndex,
      );
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '获取章节内容失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 获取 PDF 预签名 URL
  /// 注意：生成的 API 客户端将 data 类型错误地声明为 BuiltList<String>，
  /// 但后端实际返回 BaseResponse<String>（单个字符串），因此使用原始 Dio 请求。
  Future<String> getPdfUrl(int bookId) async {
    try {
      final response = await _api.dio.get('/api/books/$bookId/pdf-url');
      final data = response.data;
      if (data is Map && data['code'] == 0 && data['data'] != null) {
        return data['data'] as String;
      }
      throw Exception(data?['message'] ?? '获取PDF链接失败');
    } catch (e) {
      rethrow;
    }
  }

  // ==================== 书架 ====================

  /// 获取用户书架
  Future<BuiltList<UserShelfDTO>> getUserShelf(int userId, {int page = 1, int size = 50}) async {
    try {
      final response = await _api.defaultApi.getUserShelf(
        userId: userId,
        page: page,
        size: size,
      );
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '获取书架失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 加入书架
  Future<void> addToShelf(int userId, int bookId) async {
    try {
      final response = await _api.defaultApi.addToShelf(
        userId: userId,
        bookId: bookId,
      );
      if (response.data?.code != 0) {
        throw Exception(response.data?.message ?? '加入书架失败');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// 移出书架
  Future<void> removeFromShelf(int userId, int bookId) async {
    try {
      final response = await _api.defaultApi.removeFromShelf(
        userId: userId,
        bookId: bookId,
      );
      if (response.data?.code != 0) {
        throw Exception(response.data?.message ?? '移出书架失败');
      }
    } catch (e) {
      rethrow;
    }
  }

  // ==================== 阅读进度 ====================

  /// 更新阅读进度
  Future<void> updateProgress({
    required int userId,
    required int bookId,
    required int chapterIndex,
    int position = 0,
  }) async {
    try {
      await _api.defaultApi.updateProgress(
        updateReadingProgressCommand: UpdateReadingProgressCommand((b) => b
          ..userId = userId
          ..bookId = bookId
          ..chapterIndex = chapterIndex
          ..position = position),
      );
    } catch (e) {
      // 静默处理进度保存失败
    }
  }

  // ==================== 书签 ====================

  /// 获取书签列表
  Future<BuiltList<ReadingBookmarkDTO>> getBookmarks(int bookId, int userId) async {
    try {
      final response = await _api.defaultApi.getBookmarksByBook(
        bookId: bookId,
        userId: userId,
      );
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '获取书签失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 创建书签
  Future<ReadingBookmarkDTO> createBookmark({
    required int bookId,
    required int userId,
    required int chapterId,
    int chapterIndex = 0,
    int position = 0,
    String? bookmarkTitle,
    String? note,
  }) async {
    try {
      final map = <String, JsonObject>{
        'userId': JsonObject(userId),
        'chapterId': JsonObject(chapterId),
        'chapterIndex': JsonObject(chapterIndex),
        'position': JsonObject(position),
      };
      if (bookmarkTitle != null) map['bookmarkTitle'] = JsonObject(bookmarkTitle);
      if (note != null) map['note'] = JsonObject(note);
      final requestBody = BuiltMap<String, JsonObject>(map);
      final response = await _api.defaultApi.createBookmark(
        bookId: bookId,
        requestBody: requestBody,
      );
      if (response.data?.code == 0 && response.data?.data != null) {
        return response.data!.data!;
      }
      throw Exception(response.data?.message ?? '创建书签失败');
    } catch (e) {
      rethrow;
    }
  }

  /// 删除书签
  Future<void> deleteBookmark(int bookId, int bookmarkId) async {
    try {
      final response = await _api.defaultApi.deleteBookmark(
        bookId: bookId,
        bookmarkId: bookmarkId,
      );
      if (response.data?.code != 0) {
        throw Exception(response.data?.message ?? '删除书签失败');
      }
    } catch (e) {
      rethrow;
    }
  }
}
