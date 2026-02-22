//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'question_grading_item.g.dart';

/// 单题批改详情
///
/// Properties:
/// * [questionIndex] - 题号
/// * [questionContent] - 题干
/// * [questionType] - 题型
/// * [studentAnswer] - 学生答案
/// * [standardAnswer] - 标准答案
/// * [score] - 得分
/// * [maxScore] - 满分
/// * [errorCategories] - 错误分类
/// * [errorDetail] - 错误详情
/// * [knowledgePoints] - 关联知识点
/// * [comment] - 评语
@BuiltValue()
abstract class QuestionGradingItem
    implements Built<QuestionGradingItem, QuestionGradingItemBuilder> {
  /// 题号
  @BuiltValueField(wireName: r'questionIndex')
  int? get questionIndex;

  /// 题干
  @BuiltValueField(wireName: r'questionContent')
  String? get questionContent;

  /// 题型
  @BuiltValueField(wireName: r'questionType')
  String? get questionType;

  /// 学生答案
  @BuiltValueField(wireName: r'studentAnswer')
  String? get studentAnswer;

  /// 标准答案
  @BuiltValueField(wireName: r'standardAnswer')
  String? get standardAnswer;

  /// 得分
  @BuiltValueField(wireName: r'score')
  int? get score;

  /// 满分
  @BuiltValueField(wireName: r'maxScore')
  int? get maxScore;

  /// 错误分类
  @BuiltValueField(wireName: r'errorCategories')
  BuiltList<String>? get errorCategories;

  /// 错误详情
  @BuiltValueField(wireName: r'errorDetail')
  String? get errorDetail;

  /// 关联知识点
  @BuiltValueField(wireName: r'knowledgePoints')
  BuiltList<String>? get knowledgePoints;

  /// 评语
  @BuiltValueField(wireName: r'comment')
  String? get comment;

  QuestionGradingItem._();

  factory QuestionGradingItem([void updates(QuestionGradingItemBuilder b)]) =
      _$QuestionGradingItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(QuestionGradingItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<QuestionGradingItem> get serializer =>
      _$QuestionGradingItemSerializer();
}

class _$QuestionGradingItemSerializer
    implements PrimitiveSerializer<QuestionGradingItem> {
  @override
  final Iterable<Type> types = const [
    QuestionGradingItem,
    _$QuestionGradingItem
  ];

  @override
  final String wireName = r'QuestionGradingItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    QuestionGradingItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.questionIndex != null) {
      yield r'questionIndex';
      yield serializers.serialize(
        object.questionIndex,
        specifiedType: const FullType(int),
      );
    }
    if (object.questionContent != null) {
      yield r'questionContent';
      yield serializers.serialize(
        object.questionContent,
        specifiedType: const FullType(String),
      );
    }
    if (object.questionType != null) {
      yield r'questionType';
      yield serializers.serialize(
        object.questionType,
        specifiedType: const FullType(String),
      );
    }
    if (object.studentAnswer != null) {
      yield r'studentAnswer';
      yield serializers.serialize(
        object.studentAnswer,
        specifiedType: const FullType(String),
      );
    }
    if (object.standardAnswer != null) {
      yield r'standardAnswer';
      yield serializers.serialize(
        object.standardAnswer,
        specifiedType: const FullType(String),
      );
    }
    if (object.score != null) {
      yield r'score';
      yield serializers.serialize(
        object.score,
        specifiedType: const FullType(int),
      );
    }
    if (object.maxScore != null) {
      yield r'maxScore';
      yield serializers.serialize(
        object.maxScore,
        specifiedType: const FullType(int),
      );
    }
    if (object.errorCategories != null) {
      yield r'errorCategories';
      yield serializers.serialize(
        object.errorCategories,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.errorDetail != null) {
      yield r'errorDetail';
      yield serializers.serialize(
        object.errorDetail,
        specifiedType: const FullType(String),
      );
    }
    if (object.knowledgePoints != null) {
      yield r'knowledgePoints';
      yield serializers.serialize(
        object.knowledgePoints,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    QuestionGradingItem object, {
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
    required QuestionGradingItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'questionIndex':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.questionIndex = valueDes;
          break;
        case r'questionContent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.questionContent = valueDes;
          break;
        case r'questionType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.questionType = valueDes;
          break;
        case r'studentAnswer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.studentAnswer = valueDes;
          break;
        case r'standardAnswer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.standardAnswer = valueDes;
          break;
        case r'score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.score = valueDes;
          break;
        case r'maxScore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.maxScore = valueDes;
          break;
        case r'errorCategories':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.errorCategories.replace(valueDes);
          break;
        case r'errorDetail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.errorDetail = valueDes;
          break;
        case r'knowledgePoints':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.knowledgePoints.replace(valueDes);
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.comment = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  QuestionGradingItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = QuestionGradingItemBuilder();
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
