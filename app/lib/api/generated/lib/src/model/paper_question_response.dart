//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'paper_question_response.g.dart';

/// 试卷题目关联响应
///
/// Properties:
/// * [id] - 关联ID
/// * [sectionId] - 大题ID
/// * [questionId] - 题目ID
/// * [score] - 分值
/// * [sortOrder] - 排序
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
@BuiltValue()
abstract class PaperQuestionResponse
    implements Built<PaperQuestionResponse, PaperQuestionResponseBuilder> {
  /// 关联ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 大题ID
  @BuiltValueField(wireName: r'sectionId')
  int? get sectionId;

  /// 题目ID
  @BuiltValueField(wireName: r'questionId')
  int? get questionId;

  /// 分值
  @BuiltValueField(wireName: r'score')
  int? get score;

  /// 排序
  @BuiltValueField(wireName: r'sortOrder')
  int? get sortOrder;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  PaperQuestionResponse._();

  factory PaperQuestionResponse(
      [void updates(PaperQuestionResponseBuilder b)]) = _$PaperQuestionResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaperQuestionResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaperQuestionResponse> get serializer =>
      _$PaperQuestionResponseSerializer();
}

class _$PaperQuestionResponseSerializer
    implements PrimitiveSerializer<PaperQuestionResponse> {
  @override
  final Iterable<Type> types = const [
    PaperQuestionResponse,
    _$PaperQuestionResponse
  ];

  @override
  final String wireName = r'PaperQuestionResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaperQuestionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.sectionId != null) {
      yield r'sectionId';
      yield serializers.serialize(
        object.sectionId,
        specifiedType: const FullType(int),
      );
    }
    if (object.questionId != null) {
      yield r'questionId';
      yield serializers.serialize(
        object.questionId,
        specifiedType: const FullType(int),
      );
    }
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
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.updateTime != null) {
      yield r'updateTime';
      yield serializers.serialize(
        object.updateTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PaperQuestionResponse object, {
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
    required PaperQuestionResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'sectionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sectionId = valueDes;
          break;
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
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        case r'updateTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updateTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PaperQuestionResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaperQuestionResponseBuilder();
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
