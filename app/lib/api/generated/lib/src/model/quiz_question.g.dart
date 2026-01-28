// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_question.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const QuizQuestionTypeEnum _$quizQuestionTypeEnum_CHOICE =
    const QuizQuestionTypeEnum._('CHOICE');
const QuizQuestionTypeEnum _$quizQuestionTypeEnum_FILL =
    const QuizQuestionTypeEnum._('FILL');
const QuizQuestionTypeEnum _$quizQuestionTypeEnum_TRUE_FALSE =
    const QuizQuestionTypeEnum._('TRUE_FALSE');
const QuizQuestionTypeEnum _$quizQuestionTypeEnum_SHORT_ANSWER =
    const QuizQuestionTypeEnum._('SHORT_ANSWER');

QuizQuestionTypeEnum _$quizQuestionTypeEnumValueOf(String name) {
  switch (name) {
    case 'CHOICE':
      return _$quizQuestionTypeEnum_CHOICE;
    case 'FILL':
      return _$quizQuestionTypeEnum_FILL;
    case 'TRUE_FALSE':
      return _$quizQuestionTypeEnum_TRUE_FALSE;
    case 'SHORT_ANSWER':
      return _$quizQuestionTypeEnum_SHORT_ANSWER;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<QuizQuestionTypeEnum> _$quizQuestionTypeEnumValues =
    BuiltSet<QuizQuestionTypeEnum>(const <QuizQuestionTypeEnum>[
      _$quizQuestionTypeEnum_CHOICE,
      _$quizQuestionTypeEnum_FILL,
      _$quizQuestionTypeEnum_TRUE_FALSE,
      _$quizQuestionTypeEnum_SHORT_ANSWER,
    ]);

const QuizQuestionDifficultyEnum _$quizQuestionDifficultyEnum_EASY =
    const QuizQuestionDifficultyEnum._('EASY');
const QuizQuestionDifficultyEnum _$quizQuestionDifficultyEnum_MEDIUM =
    const QuizQuestionDifficultyEnum._('MEDIUM');
const QuizQuestionDifficultyEnum _$quizQuestionDifficultyEnum_HARD =
    const QuizQuestionDifficultyEnum._('HARD');

QuizQuestionDifficultyEnum _$quizQuestionDifficultyEnumValueOf(String name) {
  switch (name) {
    case 'EASY':
      return _$quizQuestionDifficultyEnum_EASY;
    case 'MEDIUM':
      return _$quizQuestionDifficultyEnum_MEDIUM;
    case 'HARD':
      return _$quizQuestionDifficultyEnum_HARD;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<QuizQuestionDifficultyEnum> _$quizQuestionDifficultyEnumValues =
    BuiltSet<QuizQuestionDifficultyEnum>(const <QuizQuestionDifficultyEnum>[
      _$quizQuestionDifficultyEnum_EASY,
      _$quizQuestionDifficultyEnum_MEDIUM,
      _$quizQuestionDifficultyEnum_HARD,
    ]);

Serializer<QuizQuestionTypeEnum> _$quizQuestionTypeEnumSerializer =
    _$QuizQuestionTypeEnumSerializer();
Serializer<QuizQuestionDifficultyEnum> _$quizQuestionDifficultyEnumSerializer =
    _$QuizQuestionDifficultyEnumSerializer();

class _$QuizQuestionTypeEnumSerializer
    implements PrimitiveSerializer<QuizQuestionTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'CHOICE': 'CHOICE',
    'FILL': 'FILL',
    'TRUE_FALSE': 'TRUE_FALSE',
    'SHORT_ANSWER': 'SHORT_ANSWER',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'CHOICE': 'CHOICE',
    'FILL': 'FILL',
    'TRUE_FALSE': 'TRUE_FALSE',
    'SHORT_ANSWER': 'SHORT_ANSWER',
  };

  @override
  final Iterable<Type> types = const <Type>[QuizQuestionTypeEnum];
  @override
  final String wireName = 'QuizQuestionTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    QuizQuestionTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  QuizQuestionTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => QuizQuestionTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$QuizQuestionDifficultyEnumSerializer
    implements PrimitiveSerializer<QuizQuestionDifficultyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'EASY': 'EASY',
    'MEDIUM': 'MEDIUM',
    'HARD': 'HARD',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'EASY': 'EASY',
    'MEDIUM': 'MEDIUM',
    'HARD': 'HARD',
  };

  @override
  final Iterable<Type> types = const <Type>[QuizQuestionDifficultyEnum];
  @override
  final String wireName = 'QuizQuestionDifficultyEnum';

  @override
  Object serialize(
    Serializers serializers,
    QuizQuestionDifficultyEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  QuizQuestionDifficultyEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => QuizQuestionDifficultyEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$QuizQuestion extends QuizQuestion {
  @override
  final QuizQuestionTypeEnum? type;
  @override
  final QuizQuestionDifficultyEnum? difficulty;
  @override
  final String? question;
  @override
  final BuiltList<String>? options;
  @override
  final String? correctAnswer;
  @override
  final String? explanation;

  factory _$QuizQuestion([void Function(QuizQuestionBuilder)? updates]) =>
      (QuizQuestionBuilder()..update(updates))._build();

  _$QuizQuestion._({
    this.type,
    this.difficulty,
    this.question,
    this.options,
    this.correctAnswer,
    this.explanation,
  }) : super._();
  @override
  QuizQuestion rebuild(void Function(QuizQuestionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QuizQuestionBuilder toBuilder() => QuizQuestionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuizQuestion &&
        type == other.type &&
        difficulty == other.difficulty &&
        question == other.question &&
        options == other.options &&
        correctAnswer == other.correctAnswer &&
        explanation == other.explanation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, difficulty.hashCode);
    _$hash = $jc(_$hash, question.hashCode);
    _$hash = $jc(_$hash, options.hashCode);
    _$hash = $jc(_$hash, correctAnswer.hashCode);
    _$hash = $jc(_$hash, explanation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'QuizQuestion')
          ..add('type', type)
          ..add('difficulty', difficulty)
          ..add('question', question)
          ..add('options', options)
          ..add('correctAnswer', correctAnswer)
          ..add('explanation', explanation))
        .toString();
  }
}

class QuizQuestionBuilder
    implements Builder<QuizQuestion, QuizQuestionBuilder> {
  _$QuizQuestion? _$v;

  QuizQuestionTypeEnum? _type;
  QuizQuestionTypeEnum? get type => _$this._type;
  set type(QuizQuestionTypeEnum? type) => _$this._type = type;

  QuizQuestionDifficultyEnum? _difficulty;
  QuizQuestionDifficultyEnum? get difficulty => _$this._difficulty;
  set difficulty(QuizQuestionDifficultyEnum? difficulty) =>
      _$this._difficulty = difficulty;

  String? _question;
  String? get question => _$this._question;
  set question(String? question) => _$this._question = question;

  ListBuilder<String>? _options;
  ListBuilder<String> get options => _$this._options ??= ListBuilder<String>();
  set options(ListBuilder<String>? options) => _$this._options = options;

  String? _correctAnswer;
  String? get correctAnswer => _$this._correctAnswer;
  set correctAnswer(String? correctAnswer) =>
      _$this._correctAnswer = correctAnswer;

  String? _explanation;
  String? get explanation => _$this._explanation;
  set explanation(String? explanation) => _$this._explanation = explanation;

  QuizQuestionBuilder() {
    QuizQuestion._defaults(this);
  }

  QuizQuestionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _difficulty = $v.difficulty;
      _question = $v.question;
      _options = $v.options?.toBuilder();
      _correctAnswer = $v.correctAnswer;
      _explanation = $v.explanation;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QuizQuestion other) {
    _$v = other as _$QuizQuestion;
  }

  @override
  void update(void Function(QuizQuestionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  QuizQuestion build() => _build();

  _$QuizQuestion _build() {
    _$QuizQuestion _$result;
    try {
      _$result =
          _$v ??
          _$QuizQuestion._(
            type: type,
            difficulty: difficulty,
            question: question,
            options: _options?.build(),
            correctAnswer: correctAnswer,
            explanation: explanation,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'options';
        _options?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'QuizQuestion',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
