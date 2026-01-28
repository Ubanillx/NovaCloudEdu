// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_quiz.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReadingQuiz extends ReadingQuiz {
  @override
  final ReadingQuizId? id;
  @override
  final ChapterId? chapterId;
  @override
  final BuiltList<QuizQuestion>? questions;
  @override
  final String? aiModel;
  @override
  final DateTime? createTime;
  @override
  final int? questionCount;

  factory _$ReadingQuiz([void Function(ReadingQuizBuilder)? updates]) =>
      (ReadingQuizBuilder()..update(updates))._build();

  _$ReadingQuiz._({
    this.id,
    this.chapterId,
    this.questions,
    this.aiModel,
    this.createTime,
    this.questionCount,
  }) : super._();
  @override
  ReadingQuiz rebuild(void Function(ReadingQuizBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReadingQuizBuilder toBuilder() => ReadingQuizBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReadingQuiz &&
        id == other.id &&
        chapterId == other.chapterId &&
        questions == other.questions &&
        aiModel == other.aiModel &&
        createTime == other.createTime &&
        questionCount == other.questionCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, chapterId.hashCode);
    _$hash = $jc(_$hash, questions.hashCode);
    _$hash = $jc(_$hash, aiModel.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, questionCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReadingQuiz')
          ..add('id', id)
          ..add('chapterId', chapterId)
          ..add('questions', questions)
          ..add('aiModel', aiModel)
          ..add('createTime', createTime)
          ..add('questionCount', questionCount))
        .toString();
  }
}

class ReadingQuizBuilder implements Builder<ReadingQuiz, ReadingQuizBuilder> {
  _$ReadingQuiz? _$v;

  ReadingQuizIdBuilder? _id;
  ReadingQuizIdBuilder get id => _$this._id ??= ReadingQuizIdBuilder();
  set id(ReadingQuizIdBuilder? id) => _$this._id = id;

  ChapterIdBuilder? _chapterId;
  ChapterIdBuilder get chapterId => _$this._chapterId ??= ChapterIdBuilder();
  set chapterId(ChapterIdBuilder? chapterId) => _$this._chapterId = chapterId;

  ListBuilder<QuizQuestion>? _questions;
  ListBuilder<QuizQuestion> get questions =>
      _$this._questions ??= ListBuilder<QuizQuestion>();
  set questions(ListBuilder<QuizQuestion>? questions) =>
      _$this._questions = questions;

  String? _aiModel;
  String? get aiModel => _$this._aiModel;
  set aiModel(String? aiModel) => _$this._aiModel = aiModel;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  int? _questionCount;
  int? get questionCount => _$this._questionCount;
  set questionCount(int? questionCount) =>
      _$this._questionCount = questionCount;

  ReadingQuizBuilder() {
    ReadingQuiz._defaults(this);
  }

  ReadingQuizBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id?.toBuilder();
      _chapterId = $v.chapterId?.toBuilder();
      _questions = $v.questions?.toBuilder();
      _aiModel = $v.aiModel;
      _createTime = $v.createTime;
      _questionCount = $v.questionCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReadingQuiz other) {
    _$v = other as _$ReadingQuiz;
  }

  @override
  void update(void Function(ReadingQuizBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReadingQuiz build() => _build();

  _$ReadingQuiz _build() {
    _$ReadingQuiz _$result;
    try {
      _$result =
          _$v ??
          _$ReadingQuiz._(
            id: _id?.build(),
            chapterId: _chapterId?.build(),
            questions: _questions?.build(),
            aiModel: aiModel,
            createTime: createTime,
            questionCount: questionCount,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'id';
        _id?.build();
        _$failedField = 'chapterId';
        _chapterId?.build();
        _$failedField = 'questions';
        _questions?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ReadingQuiz',
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
