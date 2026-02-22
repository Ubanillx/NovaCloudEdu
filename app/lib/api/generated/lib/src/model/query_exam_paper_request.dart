//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'query_exam_paper_request.g.dart';

/// 查询试卷请求
///
/// Properties:
/// * [keyword] - 关键词
/// * [subject] - 学科
/// * [grade] - 年级
/// * [status] - 状态: DRAFT/PUBLISHED
/// * [pageNum] - 页码
/// * [pageSize] - 每页数量
@BuiltValue()
abstract class QueryExamPaperRequest
    implements Built<QueryExamPaperRequest, QueryExamPaperRequestBuilder> {
  /// 关键词
  @BuiltValueField(wireName: r'keyword')
  String? get keyword;

  /// 学科
  @BuiltValueField(wireName: r'subject')
  String? get subject;

  /// 年级
  @BuiltValueField(wireName: r'grade')
  String? get grade;

  /// 状态: DRAFT/PUBLISHED
  @BuiltValueField(wireName: r'status')
  String? get status;

  /// 页码
  @BuiltValueField(wireName: r'pageNum')
  int? get pageNum;

  /// 每页数量
  @BuiltValueField(wireName: r'pageSize')
  int? get pageSize;

  QueryExamPaperRequest._();

  factory QueryExamPaperRequest(
      [void updates(QueryExamPaperRequestBuilder b)]) = _$QueryExamPaperRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(QueryExamPaperRequestBuilder b) => b
    ..pageNum = 1
    ..pageSize = 20;

  @BuiltValueSerializer(custom: true)
  static Serializer<QueryExamPaperRequest> get serializer =>
      _$QueryExamPaperRequestSerializer();
}

class _$QueryExamPaperRequestSerializer
    implements PrimitiveSerializer<QueryExamPaperRequest> {
  @override
  final Iterable<Type> types = const [
    QueryExamPaperRequest,
    _$QueryExamPaperRequest
  ];

  @override
  final String wireName = r'QueryExamPaperRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    QueryExamPaperRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.keyword != null) {
      yield r'keyword';
      yield serializers.serialize(
        object.keyword,
        specifiedType: const FullType(String),
      );
    }
    if (object.subject != null) {
      yield r'subject';
      yield serializers.serialize(
        object.subject,
        specifiedType: const FullType(String),
      );
    }
    if (object.grade != null) {
      yield r'grade';
      yield serializers.serialize(
        object.grade,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.pageNum != null) {
      yield r'pageNum';
      yield serializers.serialize(
        object.pageNum,
        specifiedType: const FullType(int),
      );
    }
    if (object.pageSize != null) {
      yield r'pageSize';
      yield serializers.serialize(
        object.pageSize,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    QueryExamPaperRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required QueryExamPaperRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'keyword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.keyword = valueDes;
          break;
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subject = valueDes;
          break;
        case r'grade':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.grade = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'pageNum':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pageNum = valueDes;
          break;
        case r'pageSize':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pageSize = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  QueryExamPaperRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = QueryExamPaperRequestBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
