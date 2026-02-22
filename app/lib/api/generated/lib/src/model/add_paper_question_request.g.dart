// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_paper_question_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AddPaperQuestionRequest extends AddPaperQuestionRequest {
  @override
  final int questionId;
  @override
  final int score;
  @override
  final int? sortOrder;

  factory _$AddPaperQuestionRequest([
    void Function(AddPaperQuestionRequestBuilder)? updates,
  ]) => (AddPaperQuestionRequestBuilder()..update(updates))._build();

  _$AddPaperQuestionRequest._({
    required this.questionId,
    required this.score,
    this.sortOrder,
  }) : super._();
  @override
  AddPaperQuestionRequest rebuild(
    void Function(AddPaperQuestionRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AddPaperQuestionRequestBuilder toBuilder() =>
      AddPaperQuestionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddPaperQuestionRequest &&
        questionId == other.questionId &&
        score == other.score &&
        sortOrder == other.sortOrder;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, questionId.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, sortOrder.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AddPaperQuestionRequest')
          ..add('questionId', questionId)
          ..add('score', score)
          ..add('sortOrder', sortOrder))
        .toString();
  }
}

class AddPaperQuestionRequestBuilder
    implements
        Builder<AddPaperQuestionRequest, AddPaperQuestionRequestBuilder> {
  _$AddPaperQuestionRequest? _$v;

  int? _questionId;
  int? get questionId => _$this._questionId;
  set questionId(int? questionId) => _$this._questionId = questionId;

  int? _score;
  int? get score => _$this._score;
  set score(int? score) => _$this._score = score;

  int? _sortOrder;
  int? get sortOrder => _$this._sortOrder;
  set sortOrder(int? sortOrder) => _$this._sortOrder = sortOrder;

  AddPaperQuestionRequestBuilder() {
    AddPaperQuestionRequest._defaults(this);
  }

  AddPaperQuestionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _questionId = $v.questionId;
      _score = $v.score;
      _sortOrder = $v.sortOrder;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddPaperQuestionRequest other) {
    _$v = other as _$AddPaperQuestionRequest;
  }

  @override
  void update(void Function(AddPaperQuestionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddPaperQuestionRequest build() => _build();

  _$AddPaperQuestionRequest _build() {
    final _$result =
        _$v ??
        _$AddPaperQuestionRequest._(
          questionId: BuiltValueNullFieldError.checkNotNull(
            questionId,
            r'AddPaperQuestionRequest',
            'questionId',
          ),
          score: BuiltValueNullFieldError.checkNotNull(
            score,
            r'AddPaperQuestionRequest',
            'score',
          ),
          sortOrder: sortOrder,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
