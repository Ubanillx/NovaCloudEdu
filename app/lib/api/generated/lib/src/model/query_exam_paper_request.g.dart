// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_exam_paper_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$QueryExamPaperRequest extends QueryExamPaperRequest {
  @override
  final String? keyword;
  @override
  final String? subject;
  @override
  final String? grade;
  @override
  final String? status;
  @override
  final int? pageNum;
  @override
  final int? pageSize;

  factory _$QueryExamPaperRequest([
    void Function(QueryExamPaperRequestBuilder)? updates,
  ]) => (QueryExamPaperRequestBuilder()..update(updates))._build();

  _$QueryExamPaperRequest._({
    this.keyword,
    this.subject,
    this.grade,
    this.status,
    this.pageNum,
    this.pageSize,
  }) : super._();
  @override
  QueryExamPaperRequest rebuild(
    void Function(QueryExamPaperRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  QueryExamPaperRequestBuilder toBuilder() =>
      QueryExamPaperRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QueryExamPaperRequest &&
        keyword == other.keyword &&
        subject == other.subject &&
        grade == other.grade &&
        status == other.status &&
        pageNum == other.pageNum &&
        pageSize == other.pageSize;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, keyword.hashCode);
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, grade.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, pageNum.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'QueryExamPaperRequest')
          ..add('keyword', keyword)
          ..add('subject', subject)
          ..add('grade', grade)
          ..add('status', status)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize))
        .toString();
  }
}

class QueryExamPaperRequestBuilder
    implements Builder<QueryExamPaperRequest, QueryExamPaperRequestBuilder> {
  _$QueryExamPaperRequest? _$v;

  String? _keyword;
  String? get keyword => _$this._keyword;
  set keyword(String? keyword) => _$this._keyword = keyword;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  String? _grade;
  String? get grade => _$this._grade;
  set grade(String? grade) => _$this._grade = grade;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  int? _pageNum;
  int? get pageNum => _$this._pageNum;
  set pageNum(int? pageNum) => _$this._pageNum = pageNum;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  QueryExamPaperRequestBuilder() {
    QueryExamPaperRequest._defaults(this);
  }

  QueryExamPaperRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _keyword = $v.keyword;
      _subject = $v.subject;
      _grade = $v.grade;
      _status = $v.status;
      _pageNum = $v.pageNum;
      _pageSize = $v.pageSize;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QueryExamPaperRequest other) {
    _$v = other as _$QueryExamPaperRequest;
  }

  @override
  void update(void Function(QueryExamPaperRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  QueryExamPaperRequest build() => _build();

  _$QueryExamPaperRequest _build() {
    final _$result =
        _$v ??
        _$QueryExamPaperRequest._(
          keyword: keyword,
          subject: subject,
          grade: grade,
          status: status,
          pageNum: pageNum,
          pageSize: pageSize,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
