import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

// tests for SubmissionStatusResponse
void main() {
  final instance = SubmissionStatusResponseBuilder();
  // TODO add properties to the builder and call build()

  group(SubmissionStatusResponse, () {
    // 提交ID
    // String submissionId
    test('to test the property `submissionId`', () async {
      // TODO
    });

    // 批改模式: EXAM_PAPER/GENERAL
    // String gradingMode
    test('to test the property `gradingMode`', () async {
      // TODO
    });

    // 作业标题
    // String title
    test('to test the property `title`', () async {
      // TODO
    });

    // 学科（可能为null，通用模式下AI推断后回填）
    // String subject
    test('to test the property `subject`', () async {
      // TODO
    });

    // 年级
    // String grade
    test('to test the property `grade`', () async {
      // TODO
    });

    // 作业图片URL列表
    // BuiltList<String> imageUrls
    test('to test the property `imageUrls`', () async {
      // TODO
    });

    // 批改状态: PENDING/OCR_PROCESSING/GRADING/COMPLETED/FAILED
    // String status
    test('to test the property `status`', () async {
      // TODO
    });

    // 关联试卷ID
    // String examPaperId
    test('to test the property `examPaperId`', () async {
      // TODO
    });

    // 总得分（已完成时有值）
    // int totalScore
    test('to test the property `totalScore`', () async {
      // TODO
    });

    // 满分（已完成时有值）
    // int maxScore
    test('to test the property `maxScore`', () async {
      // TODO
    });

    // 提交时间
    // DateTime createTime
    test('to test the property `createTime`', () async {
      // TODO
    });
  });
}
