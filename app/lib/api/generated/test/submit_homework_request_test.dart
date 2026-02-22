import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

// tests for SubmitHomeworkRequest
void main() {
  final instance = SubmitHomeworkRequestBuilder();
  // TODO add properties to the builder and call build()

  group(SubmitHomeworkRequest, () {
    // 作业图片 OSS URL 列表
    // BuiltList<String> imageUrls
    test('to test the property `imageUrls`', () async {
      // TODO
    });

    // 批改模式: EXAM_PAPER(试卷批改) / GENERAL(通用作业助手)，默认 GENERAL
    // String gradingMode
    test('to test the property `gradingMode`', () async {
      // TODO
    });

    // 作业标题（通用模式可自定义，如'人教版三年级数学第五章练习'）
    // String title
    test('to test the property `title`', () async {
      // TODO
    });

    // 学科: MATH/CHINESE/ENGLISH/...（可选，通用模式AI自动推断）
    // String subject
    test('to test the property `subject`', () async {
      // TODO
    });

    // 年级
    // String grade
    test('to test the property `grade`', () async {
      // TODO
    });

    // 班级ID（可选）
    // int classId
    test('to test the property `classId`', () async {
      // TODO
    });

    // 关联试卷ID（试卷批改模式时传入）
    // int examPaperId
    test('to test the property `examPaperId`', () async {
      // TODO
    });
  });
}
