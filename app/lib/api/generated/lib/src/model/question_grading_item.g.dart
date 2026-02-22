// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_grading_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$QuestionGradingItem extends QuestionGradingItem {
  @override
  final int? questionIndex;
  @override
  final String? questionContent;
  @override
  final String? questionType;
  @override
  final String? studentAnswer;
  @override
  final String? standardAnswer;
  @override
  final int? score;
  @override
  final int? maxScore;
  @override
  final BuiltList<String>? errorCategories;
  @override
  final String? errorDetail;
  @override
  final BuiltList<String>? knowledgePoints;
  @override
  final String? comment;

  factory _$QuestionGradingItem([
    void Function(QuestionGradingItemBuilder)? updates,
  ]) => (QuestionGradingItemBuilder()..update(updates))._build();

  _$QuestionGradingItem._({
    this.questionIndex,
    this.questionContent,
    this.questionType,
    this.studentAnswer,
    this.standardAnswer,
    this.score,
    this.maxScore,
    this.errorCategories,
    this.errorDetail,
    this.knowledgePoints,
    this.comment,
  }) : super._();
  @override
  QuestionGradingItem rebuild(
    void Function(QuestionGradingItemBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  QuestionGradingItemBuilder toBuilder() =>
      QuestionGradingItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuestionGradingItem &&
        questionIndex == other.questionIndex &&
        questionContent == other.questionContent &&
        questionType == other.questionType &&
        studentAnswer == other.studentAnswer &&
        standardAnswer == other.standardAnswer &&
        score == other.score &&
        maxScore == other.maxScore &&
        errorCategories == other.errorCategories &&
        errorDetail == other.errorDetail &&
        knowledgePoints == other.knowledgePoints &&
        comment == other.comment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, questionIndex.hashCode);
    _$hash = $jc(_$hash, questionContent.hashCode);
    _$hash = $jc(_$hash, questionType.hashCode);
    _$hash = $jc(_$hash, studentAnswer.hashCode);
    _$hash = $jc(_$hash, standardAnswer.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, maxScore.hashCode);
    _$hash = $jc(_$hash, errorCategories.hashCode);
    _$hash = $jc(_$hash, errorDetail.hashCode);
    _$hash = $jc(_$hash, knowledgePoints.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'QuestionGradingItem')
          ..add('questionIndex', questionIndex)
          ..add('questionContent', questionContent)
          ..add('questionType', questionType)
          ..add('studentAnswer', studentAnswer)
          ..add('standardAnswer', standardAnswer)
          ..add('score', score)
          ..add('maxScore', maxScore)
          ..add('errorCategories', errorCategories)
          ..add('errorDetail', errorDetail)
          ..add('knowledgePoints', knowledgePoints)
          ..add('comment', comment))
        .toString();
  }
}

class QuestionGradingItemBuilder
    implements Builder<QuestionGradingItem, QuestionGradingItemBuilder> {
  _$QuestionGradingItem? _$v;

  int? _questionIndex;
  int? get questionIndex => _$this._questionIndex;
  set questionIndex(int? questionIndex) =>
      _$this._questionIndex = questionIndex;

  String? _questionContent;
  String? get questionContent => _$this._questionContent;
  set questionContent(String? questionContent) =>
      _$this._questionContent = questionContent;

  String? _questionType;
  String? get questionType => _$this._questionType;
  set questionType(String? questionType) => _$this._questionType = questionType;

  String? _studentAnswer;
  String? get studentAnswer => _$this._studentAnswer;
  set studentAnswer(String? studentAnswer) =>
      _$this._studentAnswer = studentAnswer;

  String? _standardAnswer;
  String? get standardAnswer => _$this._standardAnswer;
  set standardAnswer(String? standardAnswer) =>
      _$this._standardAnswer = standardAnswer;

  int? _score;
  int? get score => _$this._score;
  set score(int? score) => _$this._score = score;

  int? _maxScore;
  int? get maxScore => _$this._maxScore;
  set maxScore(int? maxScore) => _$this._maxScore = maxScore;

  ListBuilder<String>? _errorCategories;
  ListBuilder<String> get errorCategories =>
      _$this._errorCategories ??= ListBuilder<String>();
  set errorCategories(ListBuilder<String>? errorCategories) =>
      _$this._errorCategories = errorCategories;

  String? _errorDetail;
  String? get errorDetail => _$this._errorDetail;
  set errorDetail(String? errorDetail) => _$this._errorDetail = errorDetail;

  ListBuilder<String>? _knowledgePoints;
  ListBuilder<String> get knowledgePoints =>
      _$this._knowledgePoints ??= ListBuilder<String>();
  set knowledgePoints(ListBuilder<String>? knowledgePoints) =>
      _$this._knowledgePoints = knowledgePoints;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  QuestionGradingItemBuilder() {
    QuestionGradingItem._defaults(this);
  }

  QuestionGradingItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _questionIndex = $v.questionIndex;
      _questionContent = $v.questionContent;
      _questionType = $v.questionType;
      _studentAnswer = $v.studentAnswer;
      _standardAnswer = $v.standardAnswer;
      _score = $v.score;
      _maxScore = $v.maxScore;
      _errorCategories = $v.errorCategories?.toBuilder();
      _errorDetail = $v.errorDetail;
      _knowledgePoints = $v.knowledgePoints?.toBuilder();
      _comment = $v.comment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QuestionGradingItem other) {
    _$v = other as _$QuestionGradingItem;
  }

  @override
  void update(void Function(QuestionGradingItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  QuestionGradingItem build() => _build();

  _$QuestionGradingItem _build() {
    _$QuestionGradingItem _$result;
    try {
      _$result =
          _$v ??
          _$QuestionGradingItem._(
            questionIndex: questionIndex,
            questionContent: questionContent,
            questionType: questionType,
            studentAnswer: studentAnswer,
            standardAnswer: standardAnswer,
            score: score,
            maxScore: maxScore,
            errorCategories: _errorCategories?.build(),
            errorDetail: errorDetail,
            knowledgePoints: _knowledgePoints?.build(),
            comment: comment,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'errorCategories';
        _errorCategories?.build();

        _$failedField = 'knowledgePoints';
        _knowledgePoints?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'QuestionGradingItem',
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
