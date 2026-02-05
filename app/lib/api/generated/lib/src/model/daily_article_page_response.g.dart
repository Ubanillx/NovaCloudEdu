// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_article_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DailyArticlePageResponse extends DailyArticlePageResponse {
  @override
  final BuiltList<DailyArticleResponse>? records;
  @override
  final int? total;
  @override
  final int? pageNum;
  @override
  final int? pageSize;
  @override
  final int? totalPages;

  factory _$DailyArticlePageResponse([
    void Function(DailyArticlePageResponseBuilder)? updates,
  ]) => (DailyArticlePageResponseBuilder()..update(updates))._build();

  _$DailyArticlePageResponse._({
    this.records,
    this.total,
    this.pageNum,
    this.pageSize,
    this.totalPages,
  }) : super._();
  @override
  DailyArticlePageResponse rebuild(
    void Function(DailyArticlePageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DailyArticlePageResponseBuilder toBuilder() =>
      DailyArticlePageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DailyArticlePageResponse &&
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
    return (newBuiltValueToStringHelper(r'DailyArticlePageResponse')
          ..add('records', records)
          ..add('total', total)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class DailyArticlePageResponseBuilder
    implements
        Builder<DailyArticlePageResponse, DailyArticlePageResponseBuilder> {
  _$DailyArticlePageResponse? _$v;

  ListBuilder<DailyArticleResponse>? _records;
  ListBuilder<DailyArticleResponse> get records =>
      _$this._records ??= ListBuilder<DailyArticleResponse>();
  set records(ListBuilder<DailyArticleResponse>? records) =>
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

  DailyArticlePageResponseBuilder() {
    DailyArticlePageResponse._defaults(this);
  }

  DailyArticlePageResponseBuilder get _$this {
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
  void replace(DailyArticlePageResponse other) {
    _$v = other as _$DailyArticlePageResponse;
  }

  @override
  void update(void Function(DailyArticlePageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DailyArticlePageResponse build() => _build();

  _$DailyArticlePageResponse _build() {
    _$DailyArticlePageResponse _$result;
    try {
      _$result =
          _$v ??
          _$DailyArticlePageResponse._(
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
          r'DailyArticlePageResponse',
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
