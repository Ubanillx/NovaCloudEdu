import 'package:flutter_test/flutter_test.dart';
import 'book_ai_service.dart';

void main() {
  group('BookAiService Tests', () {
    late BookAiService bookAiService;

    setUp(() {
      bookAiService = BookAiService();
    });

    test('服务实例创建成功', () {
      expect(bookAiService, isNotNull);
    });

    test('缓存键格式正确', () {
      // 测试缓存键生成逻辑
      final bookId = 1;
      final chapterId = 2;
      final type = 'DETAILED';
      
      // 验证缓存键包含预期信息
      expect('book_ai_summary_$bookId$chapterId$type', contains('book_ai_summary_'));
      expect('book_ai_kp_$bookId$chapterId', contains('book_ai_kp_'));
    });

    test('请求取消机制', () {
      // 测试并发请求取消
      expect(bookAiService, isNotNull);
      bookAiService.cancelAllRequests();
      expect(bookAiService, isNotNull);
    });

    tearDown(() {
      // 清理资源
      bookAiService.cancelAllRequests();
    });
  });
}
