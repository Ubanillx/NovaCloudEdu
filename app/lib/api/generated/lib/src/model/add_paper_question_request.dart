//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'add_paper_question_request.g.dart';

/// 添加试卷题目请求
///
/// Properties:
/// * [questionId] - 题目ID
/// * [score] - 分值
/// * [sortOrder] - 排序
@BuiltValue()
abstract class AddPaperQuestionRequest
    implements Built<AddPaperQuestionRequest, AddPaperQuestionRequestBuilder> {
  /// 题目ID
  @BuiltValueField(wireName: r'questionId')
  int get questionId;

  /// 分值
  @BuiltValueField(wireName: r'score')
  int get score;

  /// 排序
  @BuiltValueField(wireName: r'sortOrder')
  int? get sortOrder;

  AddPaperQuestionRequest._();

  factory AddPaperQuestionRequest(
          [void updates(AddPaperQuestionRequestBuilder b)]) =
      _$AddPaperQuestionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AddPaperQuestionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AddPaperQuestionRequest> get serializer =>
      _$AddPaperQuestionRequestSerializer();
}

class _$AddPaperQuestionRequestSerializer
    implements PrimitiveSerializer<AddPaperQuestionRequest> {
  @override
  final Iterable<Type> types = const [
    AddPaperQuestionRequest,
    _$AddPaperQuestionRequest
  ];

  @override
  final String wireName = r'AddPaperQuestionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AddPaperQuestionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'questionId';
    yield serializers.serialize(
      object.questionId,
      specifiedType: const FullType(int),
    );
    yield r'score';
    yield serializers.serialize(
      object.score,
      specifiedType: const FullType(int),
    );
    if (object.sortOrder != null) {
      yield r'sortOrder';
      yield serializers.serialize(
        object.sortOrder,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AddPaperQuestionRequest object, {
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
    required AddPaperQuestionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'questionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.questionId = valueDes;
          break;
        case r'score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.score = valueDes;
          break;
        case r'sortOrder':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sortOrder = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AddPaperQuestionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AddPaperQuestionRequestBuilder();
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
