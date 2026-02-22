// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_question_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$QueryQuestionRequest extends QueryQuestionRequest {
  @override
  final String? keyword;
  @override
  final String? type;
  @override
  final String? subject;
  @override
  final String? grade;
  @override
  final int? difficulty;
  @override
  final int? pageNum;
  @override
  final int? pageSize;

  factory _$QueryQuestionRequest([
    void Function(QueryQuestionRequestBuilder)? updates,
  ]) => (QueryQuestionRequestBuilder()..update(updates))._build();

  _$QueryQuestionRequest._({
    this.keyword,
    this.type,
    this.subject,
    this.grade,
    this.difficulty,
    this.pageNum,
    this.pageSize,
  }) : super._();
  @override
  QueryQuestionRequest rebuild(
    void Function(QueryQuestionRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  QueryQuestionRequestBuilder toBuilder() =>
      QueryQuestionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QueryQuestionRequest &&
        keyword == other.keyword &&
        type == other.type &&
        subject == other.subject &&
        grade == other.grade &&
        difficulty == other.difficulty &&
        pageNum == other.pageNum &&
        pageSize == other.pageSize;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, keyword.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, grade.hashCode);
    _$hash = $jc(_$hash, difficulty.hashCode);
    _$hash = $jc(_$hash, pageNum.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'QueryQuestionRequest')
          ..add('keyword', keyword)
          ..add('type', type)
          ..add('subject', subject)
          ..add('grade', grade)
          ..add('difficulty', difficulty)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize))
        .toString();
  }
}

class QueryQuestionRequestBuilder
    implements Builder<QueryQuestionRequest, QueryQuestionRequestBuilder> {
  _$QueryQuestionRequest? _$v;

  String? _keyword;
  String? get keyword => _$this._keyword;
  set keyword(String? keyword) => _$this._keyword = keyword;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  String? _grade;
  String? get grade => _$this._grade;
  set grade(String? grade) => _$this._grade = grade;

  int? _difficulty;
  int? get difficulty => _$this._difficulty;
  set difficulty(int? difficulty) => _$this._difficulty = difficulty;

  int? _pageNum;
  int? get pageNum => _$this._pageNum;
  set pageNum(int? pageNum) => _$this._pageNum = pageNum;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  QueryQuestionRequestBuilder() {
    QueryQuestionRequest._defaults(this);
  }

  QueryQuestionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _keyword = $v.keyword;
      _type = $v.type;
      _subject = $v.subject;
      _grade = $v.grade;
      _difficulty = $v.difficulty;
      _pageNum = $v.pageNum;
      _pageSize = $v.pageSize;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QueryQuestionRequest other) {
    _$v = other as _$QueryQuestionRequest;
  }

  @override
  void update(void Function(QueryQuestionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  QueryQuestionRequest build() => _build();

  _$QueryQuestionRequest _build() {
    final _$result =
        _$v ??
        _$QueryQuestionRequest._(
          keyword: keyword,
          type: type,
          subject: subject,
          grade: grade,
          difficulty: difficulty,
          pageNum: pageNum,
          pageSize: pageSize,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
