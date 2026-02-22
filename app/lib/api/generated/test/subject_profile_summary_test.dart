import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

// tests for SubjectProfileSummary
void main() {
  final instance = SubjectProfileSummaryBuilder();
  // TODO add properties to the builder and call build()

  group(SubjectProfileSummary, () {
    // 学科
    // String subject
    test('to test the property `subject`', () async {
      // TODO
    });

    // 学科名称
    // String subjectName
    test('to test the property `subjectName`', () async {
      // TODO
    });

    // 平均掌握度
    // double avgMasteryLevel
    test('to test the property `avgMasteryLevel`', () async {
      // TODO
    });

    // 总知识点数
    // int totalPoints
    test('to test the property `totalPoints`', () async {
      // TODO
    });

    // 薄弱知识点数
    // int weakPointCount
    test('to test the property `weakPointCount`', () async {
      // TODO
    });

    // 优势知识点数（掌握度>=0.8）
    // int strongPointCount
    test('to test the property `strongPointCount`', () async {
      // TODO
    });

    // 薄弱知识点列表
    // BuiltList<KnowledgeProfileResponse> weakPoints
    test('to test the property `weakPoints`', () async {
      // TODO
    });

    // 优势知识点列表
    // BuiltList<KnowledgeProfileResponse> strongPoints
    test('to test the property `strongPoints`', () async {
      // TODO
    });
  });
}
