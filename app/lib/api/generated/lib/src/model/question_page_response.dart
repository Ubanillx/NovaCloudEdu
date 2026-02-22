//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/question_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'question_page_response.g.dart';

/// 题目分页响应
///
/// Properties:
/// * [records] - 题目列表
/// * [total] - 总数
/// * [pageNum] - 当前页
/// * [pageSize] - 每页数量
/// * [totalPages] - 总页数
@BuiltValue()
abstract class QuestionPageResponse
    implements Built<QuestionPageResponse, QuestionPageResponseBuilder> {
  /// 题目列表
  @BuiltValueField(wireName: r'records')
  BuiltList<QuestionResponse>? get records;

  /// 总数
  @BuiltValueField(wireName: r'total')
  int? get total;

  /// 当前页
  @BuiltValueField(wireName: r'pageNum')
  int? get pageNum;

  /// 每页数量
  @BuiltValueField(wireName: r'pageSize')
  int? get pageSize;

  /// 总页数
  @BuiltValueField(wireName: r'totalPages')
  int? get totalPages;

  QuestionPageResponse._();

  factory QuestionPageResponse([void updates(QuestionPageResponseBuilder b)]) =
      _$QuestionPageResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(QuestionPageResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<QuestionPageResponse> get serializer =>
      _$QuestionPageResponseSerializer();
}

class _$QuestionPageResponseSerializer
    implements PrimitiveSerializer<QuestionPageResponse> {
  @override
  final Iterable<Type> types = const [
    QuestionPageResponse,
    _$QuestionPageResponse
  ];

  @override
  final String wireName = r'QuestionPageResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    QuestionPageResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.records != null) {
      yield r'records';
      yield serializers.serialize(
        object.records,
        specifiedType: const FullType(BuiltList, [FullType(QuestionResponse)]),
      );
    }
    if (object.total != null) {
      yield r'total';
      yield serializers.serialize(
        object.total,
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
    if (object.totalPages != null) {
      yield r'totalPages';
      yield serializers.serialize(
        object.totalPages,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    QuestionPageResponse object, {
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
    required QuestionPageResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'records':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(QuestionResponse)]),
          ) as BuiltList<QuestionResponse>;
          result.records.replace(valueDes);
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.total = valueDes;
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
        case r'totalPages':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalPages = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  QuestionPageResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = QuestionPageResponseBuilder();
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
