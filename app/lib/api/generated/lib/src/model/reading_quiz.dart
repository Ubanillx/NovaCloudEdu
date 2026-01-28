//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/quiz_question.dart';
import 'package:nova_api/src/model/chapter_id.dart';
import 'package:nova_api/src/model/reading_quiz_id.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reading_quiz.g.dart';

/// ReadingQuiz
///
/// Properties:
/// * [id]
/// * [chapterId]
/// * [questions]
/// * [aiModel]
/// * [createTime]
/// * [questionCount]
@BuiltValue()
abstract class ReadingQuiz implements Built<ReadingQuiz, ReadingQuizBuilder> {
  @BuiltValueField(wireName: r'id')
  ReadingQuizId? get id;

  @BuiltValueField(wireName: r'chapterId')
  ChapterId? get chapterId;

  @BuiltValueField(wireName: r'questions')
  BuiltList<QuizQuestion>? get questions;

  @BuiltValueField(wireName: r'aiModel')
  String? get aiModel;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  @BuiltValueField(wireName: r'questionCount')
  int? get questionCount;

  ReadingQuiz._();

  factory ReadingQuiz([void updates(ReadingQuizBuilder b)]) = _$ReadingQuiz;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReadingQuizBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReadingQuiz> get serializer => _$ReadingQuizSerializer();
}

class _$ReadingQuizSerializer implements PrimitiveSerializer<ReadingQuiz> {
  @override
  final Iterable<Type> types = const [ReadingQuiz, _$ReadingQuiz];

  @override
  final String wireName = r'ReadingQuiz';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReadingQuiz object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(ReadingQuizId),
      );
    }
    if (object.chapterId != null) {
      yield r'chapterId';
      yield serializers.serialize(
        object.chapterId,
        specifiedType: const FullType(ChapterId),
      );
    }
    if (object.questions != null) {
      yield r'questions';
      yield serializers.serialize(
        object.questions,
        specifiedType: const FullType(BuiltList, [FullType(QuizQuestion)]),
      );
    }
    if (object.aiModel != null) {
      yield r'aiModel';
      yield serializers.serialize(
        object.aiModel,
        specifiedType: const FullType(String),
      );
    }
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.questionCount != null) {
      yield r'questionCount';
      yield serializers.serialize(
        object.questionCount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ReadingQuiz object, {
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
    required ReadingQuizBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ReadingQuizId),
          ) as ReadingQuizId;
          result.id.replace(valueDes);
          break;
        case r'chapterId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChapterId),
          ) as ChapterId;
          result.chapterId.replace(valueDes);
          break;
        case r'questions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(QuizQuestion)]),
          ) as BuiltList<QuizQuestion>;
          result.questions.replace(valueDes);
          break;
        case r'aiModel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.aiModel = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        case r'questionCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.questionCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReadingQuiz deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReadingQuizBuilder();
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
