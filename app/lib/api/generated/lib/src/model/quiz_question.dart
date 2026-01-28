//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'quiz_question.g.dart';

/// QuizQuestion
///
/// Properties:
/// * [type]
/// * [difficulty]
/// * [question]
/// * [options]
/// * [correctAnswer]
/// * [explanation]
@BuiltValue()
abstract class QuizQuestion
    implements Built<QuizQuestion, QuizQuestionBuilder> {
  @BuiltValueField(wireName: r'type')
  QuizQuestionTypeEnum? get type;
  // enum typeEnum {  CHOICE,  FILL,  TRUE_FALSE,  SHORT_ANSWER,  };

  @BuiltValueField(wireName: r'difficulty')
  QuizQuestionDifficultyEnum? get difficulty;
  // enum difficultyEnum {  EASY,  MEDIUM,  HARD,  };

  @BuiltValueField(wireName: r'question')
  String? get question;

  @BuiltValueField(wireName: r'options')
  BuiltList<String>? get options;

  @BuiltValueField(wireName: r'correctAnswer')
  String? get correctAnswer;

  @BuiltValueField(wireName: r'explanation')
  String? get explanation;

  QuizQuestion._();

  factory QuizQuestion([void updates(QuizQuestionBuilder b)]) = _$QuizQuestion;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(QuizQuestionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<QuizQuestion> get serializer => _$QuizQuestionSerializer();
}

class _$QuizQuestionSerializer implements PrimitiveSerializer<QuizQuestion> {
  @override
  final Iterable<Type> types = const [QuizQuestion, _$QuizQuestion];

  @override
  final String wireName = r'QuizQuestion';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    QuizQuestion object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(QuizQuestionTypeEnum),
      );
    }
    if (object.difficulty != null) {
      yield r'difficulty';
      yield serializers.serialize(
        object.difficulty,
        specifiedType: const FullType(QuizQuestionDifficultyEnum),
      );
    }
    if (object.question != null) {
      yield r'question';
      yield serializers.serialize(
        object.question,
        specifiedType: const FullType(String),
      );
    }
    if (object.options != null) {
      yield r'options';
      yield serializers.serialize(
        object.options,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.correctAnswer != null) {
      yield r'correctAnswer';
      yield serializers.serialize(
        object.correctAnswer,
        specifiedType: const FullType(String),
      );
    }
    if (object.explanation != null) {
      yield r'explanation';
      yield serializers.serialize(
        object.explanation,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    QuizQuestion object, {
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
    required QuizQuestionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(QuizQuestionTypeEnum),
          ) as QuizQuestionTypeEnum;
          result.type = valueDes;
          break;
        case r'difficulty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(QuizQuestionDifficultyEnum),
          ) as QuizQuestionDifficultyEnum;
          result.difficulty = valueDes;
          break;
        case r'question':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.question = valueDes;
          break;
        case r'options':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.options.replace(valueDes);
          break;
        case r'correctAnswer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.correctAnswer = valueDes;
          break;
        case r'explanation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.explanation = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  QuizQuestion deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = QuizQuestionBuilder();
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

class QuizQuestionTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'CHOICE')
  static const QuizQuestionTypeEnum CHOICE = _$quizQuestionTypeEnum_CHOICE;
  @BuiltValueEnumConst(wireName: r'FILL')
  static const QuizQuestionTypeEnum FILL = _$quizQuestionTypeEnum_FILL;
  @BuiltValueEnumConst(wireName: r'TRUE_FALSE')
  static const QuizQuestionTypeEnum TRUE_FALSE =
      _$quizQuestionTypeEnum_TRUE_FALSE;
  @BuiltValueEnumConst(wireName: r'SHORT_ANSWER')
  static const QuizQuestionTypeEnum SHORT_ANSWER =
      _$quizQuestionTypeEnum_SHORT_ANSWER;

  static Serializer<QuizQuestionTypeEnum> get serializer =>
      _$quizQuestionTypeEnumSerializer;

  const QuizQuestionTypeEnum._(String name) : super(name);

  static BuiltSet<QuizQuestionTypeEnum> get values =>
      _$quizQuestionTypeEnumValues;
  static QuizQuestionTypeEnum valueOf(String name) =>
      _$quizQuestionTypeEnumValueOf(name);
}

class QuizQuestionDifficultyEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'EASY')
  static const QuizQuestionDifficultyEnum EASY =
      _$quizQuestionDifficultyEnum_EASY;
  @BuiltValueEnumConst(wireName: r'MEDIUM')
  static const QuizQuestionDifficultyEnum MEDIUM =
      _$quizQuestionDifficultyEnum_MEDIUM;
  @BuiltValueEnumConst(wireName: r'HARD')
  static const QuizQuestionDifficultyEnum HARD =
      _$quizQuestionDifficultyEnum_HARD;

  static Serializer<QuizQuestionDifficultyEnum> get serializer =>
      _$quizQuestionDifficultyEnumSerializer;

  const QuizQuestionDifficultyEnum._(String name) : super(name);

  static BuiltSet<QuizQuestionDifficultyEnum> get values =>
      _$quizQuestionDifficultyEnumValues;
  static QuizQuestionDifficultyEnum valueOf(String name) =>
      _$quizQuestionDifficultyEnumValueOf(name);
}
