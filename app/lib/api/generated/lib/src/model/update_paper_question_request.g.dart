// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_paper_question_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdatePaperQuestionRequest extends UpdatePaperQuestionRequest {
  @override
  final int? score;
  @override
  final int? sortOrder;

  factory _$UpdatePaperQuestionRequest([
    void Function(UpdatePaperQuestionRequestBuilder)? updates,
  ]) => (UpdatePaperQuestionRequestBuilder()..update(updates))._build();

  _$UpdatePaperQuestionRequest._({this.score, this.sortOrder}) : super._();
  @override
  UpdatePaperQuestionRequest rebuild(
    void Function(UpdatePaperQuestionRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdatePaperQuestionRequestBuilder toBuilder() =>
      UpdatePaperQuestionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdatePaperQuestionRequest &&
        score == other.score &&
        sortOrder == other.sortOrder;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, sortOrder.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdatePaperQuestionRequest')
          ..add('score', score)
          ..add('sortOrder', sortOrder))
        .toString();
  }
}

class UpdatePaperQuestionRequestBuilder
    implements
        Builder<UpdatePaperQuestionRequest, UpdatePaperQuestionRequestBuilder> {
  _$UpdatePaperQuestionRequest? _$v;

  int? _score;
  int? get score => _$this._score;
  set score(int? score) => _$this._score = score;

  int? _sortOrder;
  int? get sortOrder => _$this._sortOrder;
  set sortOrder(int? sortOrder) => _$this._sortOrder = sortOrder;

  UpdatePaperQuestionRequestBuilder() {
    UpdatePaperQuestionRequest._defaults(this);
  }

  UpdatePaperQuestionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _score = $v.score;
      _sortOrder = $v.sortOrder;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdatePaperQuestionRequest other) {
    _$v = other as _$UpdatePaperQuestionRequest;
  }

  @override
  void update(void Function(UpdatePaperQuestionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdatePaperQuestionRequest build() => _build();

  _$UpdatePaperQuestionRequest _build() {
    final _$result =
        _$v ??
        _$UpdatePaperQuestionRequest._(score: score, sortOrder: sortOrder);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
