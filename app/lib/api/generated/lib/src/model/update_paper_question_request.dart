//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_paper_question_request.g.dart';

/// 更新试卷题目请求
///
/// Properties:
/// * [score] - 分值
/// * [sortOrder] - 排序
@BuiltValue()
abstract class UpdatePaperQuestionRequest
    implements
        Built<UpdatePaperQuestionRequest, UpdatePaperQuestionRequestBuilder> {
  /// 分值
  @BuiltValueField(wireName: r'score')
  int? get score;

  /// 排序
  @BuiltValueField(wireName: r'sortOrder')
  int? get sortOrder;

  UpdatePaperQuestionRequest._();

  factory UpdatePaperQuestionRequest(
          [void updates(UpdatePaperQuestionRequestBuilder b)]) =
      _$UpdatePaperQuestionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdatePaperQuestionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdatePaperQuestionRequest> get serializer =>
      _$UpdatePaperQuestionRequestSerializer();
}

class _$UpdatePaperQuestionRequestSerializer
    implements PrimitiveSerializer<UpdatePaperQuestionRequest> {
  @override
  final Iterable<Type> types = const [
    UpdatePaperQuestionRequest,
    _$UpdatePaperQuestionRequest
  ];

  @override
  final String wireName = r'UpdatePaperQuestionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdatePaperQuestionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.score != null) {
      yield r'score';
      yield serializers.serialize(
        object.score,
        specifiedType: const FullType(int),
      );
    }
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
    UpdatePaperQuestionRequest object, {
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
    required UpdatePaperQuestionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  UpdatePaperQuestionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdatePaperQuestionRequestBuilder();
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
