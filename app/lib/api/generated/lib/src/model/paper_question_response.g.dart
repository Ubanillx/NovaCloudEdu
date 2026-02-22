// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paper_question_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PaperQuestionResponse extends PaperQuestionResponse {
  @override
  final int? id;
  @override
  final int? sectionId;
  @override
  final int? questionId;
  @override
  final int? score;
  @override
  final int? sortOrder;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$PaperQuestionResponse([
    void Function(PaperQuestionResponseBuilder)? updates,
  ]) => (PaperQuestionResponseBuilder()..update(updates))._build();

  _$PaperQuestionResponse._({
    this.id,
    this.sectionId,
    this.questionId,
    this.score,
    this.sortOrder,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  PaperQuestionResponse rebuild(
    void Function(PaperQuestionResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PaperQuestionResponseBuilder toBuilder() =>
      PaperQuestionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaperQuestionResponse &&
        id == other.id &&
        sectionId == other.sectionId &&
        questionId == other.questionId &&
        score == other.score &&
        sortOrder == other.sortOrder &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, sectionId.hashCode);
    _$hash = $jc(_$hash, questionId.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, sortOrder.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PaperQuestionResponse')
          ..add('id', id)
          ..add('sectionId', sectionId)
          ..add('questionId', questionId)
          ..add('score', score)
          ..add('sortOrder', sortOrder)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class PaperQuestionResponseBuilder
    implements Builder<PaperQuestionResponse, PaperQuestionResponseBuilder> {
  _$PaperQuestionResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _sectionId;
  int? get sectionId => _$this._sectionId;
  set sectionId(int? sectionId) => _$this._sectionId = sectionId;

  int? _questionId;
  int? get questionId => _$this._questionId;
  set questionId(int? questionId) => _$this._questionId = questionId;

  int? _score;
  int? get score => _$this._score;
  set score(int? score) => _$this._score = score;

  int? _sortOrder;
  int? get sortOrder => _$this._sortOrder;
  set sortOrder(int? sortOrder) => _$this._sortOrder = sortOrder;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  PaperQuestionResponseBuilder() {
    PaperQuestionResponse._defaults(this);
  }

  PaperQuestionResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _sectionId = $v.sectionId;
      _questionId = $v.questionId;
      _score = $v.score;
      _sortOrder = $v.sortOrder;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaperQuestionResponse other) {
    _$v = other as _$PaperQuestionResponse;
  }

  @override
  void update(void Function(PaperQuestionResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaperQuestionResponse build() => _build();

  _$PaperQuestionResponse _build() {
    final _$result =
        _$v ??
        _$PaperQuestionResponse._(
          id: id,
          sectionId: sectionId,
          questionId: questionId,
          score: score,
          sortOrder: sortOrder,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
