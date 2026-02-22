// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_paper_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExamPaperPageResponse extends ExamPaperPageResponse {
  @override
  final BuiltList<ExamPaperResponse>? records;
  @override
  final int? total;
  @override
  final int? pageNum;
  @override
  final int? pageSize;
  @override
  final int? totalPages;

  factory _$ExamPaperPageResponse([
    void Function(ExamPaperPageResponseBuilder)? updates,
  ]) => (ExamPaperPageResponseBuilder()..update(updates))._build();

  _$ExamPaperPageResponse._({
    this.records,
    this.total,
    this.pageNum,
    this.pageSize,
    this.totalPages,
  }) : super._();
  @override
  ExamPaperPageResponse rebuild(
    void Function(ExamPaperPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExamPaperPageResponseBuilder toBuilder() =>
      ExamPaperPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExamPaperPageResponse &&
        records == other.records &&
        total == other.total &&
        pageNum == other.pageNum &&
        pageSize == other.pageSize &&
        totalPages == other.totalPages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, records.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, pageNum.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExamPaperPageResponse')
          ..add('records', records)
          ..add('total', total)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class ExamPaperPageResponseBuilder
    implements Builder<ExamPaperPageResponse, ExamPaperPageResponseBuilder> {
  _$ExamPaperPageResponse? _$v;

  ListBuilder<ExamPaperResponse>? _records;
  ListBuilder<ExamPaperResponse> get records =>
      _$this._records ??= ListBuilder<ExamPaperResponse>();
  set records(ListBuilder<ExamPaperResponse>? records) =>
      _$this._records = records;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  int? _pageNum;
  int? get pageNum => _$this._pageNum;
  set pageNum(int? pageNum) => _$this._pageNum = pageNum;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  ExamPaperPageResponseBuilder() {
    ExamPaperPageResponse._defaults(this);
  }

  ExamPaperPageResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _records = $v.records?.toBuilder();
      _total = $v.total;
      _pageNum = $v.pageNum;
      _pageSize = $v.pageSize;
      _totalPages = $v.totalPages;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExamPaperPageResponse other) {
    _$v = other as _$ExamPaperPageResponse;
  }

  @override
  void update(void Function(ExamPaperPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExamPaperPageResponse build() => _build();

  _$ExamPaperPageResponse _build() {
    _$ExamPaperPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$ExamPaperPageResponse._(
            records: _records?.build(),
            total: total,
            pageNum: pageNum,
            pageSize: pageSize,
            totalPages: totalPages,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'records';
        _records?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ExamPaperPageResponse',
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
