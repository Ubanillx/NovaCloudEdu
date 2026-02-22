//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'query_question_request.g.dart';

/// 查询题目请求
///
/// Properties:
/// * [keyword] - 关键词
/// * [type] - 题型
/// * [subject] - 学科
/// * [grade] - 年级
/// * [difficulty] - 难度: 1-5
/// * [pageNum] - 页码
/// * [pageSize] - 每页数量
@BuiltValue()
abstract class QueryQuestionRequest
    implements Built<QueryQuestionRequest, QueryQuestionRequestBuilder> {
  /// 关键词
  @BuiltValueField(wireName: r'keyword')
  String? get keyword;

  /// 题型
  @BuiltValueField(wireName: r'type')
  String? get type;

  /// 学科
  @BuiltValueField(wireName: r'subject')
  String? get subject;

  /// 年级
  @BuiltValueField(wireName: r'grade')
  String? get grade;

  /// 难度: 1-5
  @BuiltValueField(wireName: r'difficulty')
  int? get difficulty;

  /// 页码
  @BuiltValueField(wireName: r'pageNum')
  int? get pageNum;

  /// 每页数量
  @BuiltValueField(wireName: r'pageSize')
  int? get pageSize;

  QueryQuestionRequest._();

  factory QueryQuestionRequest([void updates(QueryQuestionRequestBuilder b)]) =
      _$QueryQuestionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(QueryQuestionRequestBuilder b) => b
    ..pageNum = 1
    ..pageSize = 20;

  @BuiltValueSerializer(custom: true)
  static Serializer<QueryQuestionRequest> get serializer =>
      _$QueryQuestionRequestSerializer();
}

class _$QueryQuestionRequestSerializer
    implements PrimitiveSerializer<QueryQuestionRequest> {
  @override
  final Iterable<Type> types = const [
    QueryQuestionRequest,
    _$QueryQuestionRequest
  ];

  @override
  final String wireName = r'QueryQuestionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    QueryQuestionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.keyword != null) {
      yield r'keyword';
      yield serializers.serialize(
        object.keyword,
        specifiedType: const FullType(String),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
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
    if (object.difficulty != null) {
      yield r'difficulty';
      yield serializers.serialize(
        object.difficulty,
        specifiedType: const FullType(int),
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
    QueryQuestionRequest object, {
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
    required QueryQuestionRequestBuilder result,
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
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
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
        case r'difficulty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.difficulty = valueDes;
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
  QueryQuestionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = QueryQuestionRequestBuilder();
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
