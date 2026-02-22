// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grading_result_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GradingResultResponse extends GradingResultResponse {
  @override
  final String? submissionId;
  @override
  final int? totalScore;
  @override
  final int? maxScore;
  @override
  final String? overallComment;
  @override
  final String? modelId;
  @override
  final DateTime? gradingTime;
  @override
  final BuiltList<QuestionGradingItem>? questions;

  factory _$GradingResultResponse([
    void Function(GradingResultResponseBuilder)? updates,
  ]) => (GradingResultResponseBuilder()..update(updates))._build();

  _$GradingResultResponse._({
    this.submissionId,
    this.totalScore,
    this.maxScore,
    this.overallComment,
    this.modelId,
    this.gradingTime,
    this.questions,
  }) : super._();
  @override
  GradingResultResponse rebuild(
    void Function(GradingResultResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GradingResultResponseBuilder toBuilder() =>
      GradingResultResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GradingResultResponse &&
        submissionId == other.submissionId &&
        totalScore == other.totalScore &&
        maxScore == other.maxScore &&
        overallComment == other.overallComment &&
        modelId == other.modelId &&
        gradingTime == other.gradingTime &&
        questions == other.questions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, submissionId.hashCode);
    _$hash = $jc(_$hash, totalScore.hashCode);
    _$hash = $jc(_$hash, maxScore.hashCode);
    _$hash = $jc(_$hash, overallComment.hashCode);
    _$hash = $jc(_$hash, modelId.hashCode);
    _$hash = $jc(_$hash, gradingTime.hashCode);
    _$hash = $jc(_$hash, questions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GradingResultResponse')
          ..add('submissionId', submissionId)
          ..add('totalScore', totalScore)
          ..add('maxScore', maxScore)
          ..add('overallComment', overallComment)
          ..add('modelId', modelId)
          ..add('gradingTime', gradingTime)
          ..add('questions', questions))
        .toString();
  }
}

class GradingResultResponseBuilder
    implements Builder<GradingResultResponse, GradingResultResponseBuilder> {
  _$GradingResultResponse? _$v;

  String? _submissionId;
  String? get submissionId => _$this._submissionId;
  set submissionId(String? submissionId) => _$this._submissionId = submissionId;

  int? _totalScore;
  int? get totalScore => _$this._totalScore;
  set totalScore(int? totalScore) => _$this._totalScore = totalScore;

  int? _maxScore;
  int? get maxScore => _$this._maxScore;
  set maxScore(int? maxScore) => _$this._maxScore = maxScore;

  String? _overallComment;
  String? get overallComment => _$this._overallComment;
  set overallComment(String? overallComment) =>
      _$this._overallComment = overallComment;

  String? _modelId;
  String? get modelId => _$this._modelId;
  set modelId(String? modelId) => _$this._modelId = modelId;

  DateTime? _gradingTime;
  DateTime? get gradingTime => _$this._gradingTime;
  set gradingTime(DateTime? gradingTime) => _$this._gradingTime = gradingTime;

  ListBuilder<QuestionGradingItem>? _questions;
  ListBuilder<QuestionGradingItem> get questions =>
      _$this._questions ??= ListBuilder<QuestionGradingItem>();
  set questions(ListBuilder<QuestionGradingItem>? questions) =>
      _$this._questions = questions;

  GradingResultResponseBuilder() {
    GradingResultResponse._defaults(this);
  }

  GradingResultResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _submissionId = $v.submissionId;
      _totalScore = $v.totalScore;
      _maxScore = $v.maxScore;
      _overallComment = $v.overallComment;
      _modelId = $v.modelId;
      _gradingTime = $v.gradingTime;
      _questions = $v.questions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GradingResultResponse other) {
    _$v = other as _$GradingResultResponse;
  }

  @override
  void update(void Function(GradingResultResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GradingResultResponse build() => _build();

  _$GradingResultResponse _build() {
    _$GradingResultResponse _$result;
    try {
      _$result =
          _$v ??
          _$GradingResultResponse._(
            submissionId: submissionId,
            totalScore: totalScore,
            maxScore: maxScore,
            overallComment: overallComment,
            modelId: modelId,
            gradingTime: gradingTime,
            questions: _questions?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'questions';
        _questions?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GradingResultResponse',
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
