// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scraper_config_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScraperConfigPageResponse extends ScraperConfigPageResponse {
  @override
  final BuiltList<ScraperConfigResponse>? records;
  @override
  final int? total;
  @override
  final int? pageNum;
  @override
  final int? pageSize;
  @override
  final int? totalPages;

  factory _$ScraperConfigPageResponse([
    void Function(ScraperConfigPageResponseBuilder)? updates,
  ]) => (ScraperConfigPageResponseBuilder()..update(updates))._build();

  _$ScraperConfigPageResponse._({
    this.records,
    this.total,
    this.pageNum,
    this.pageSize,
    this.totalPages,
  }) : super._();
  @override
  ScraperConfigPageResponse rebuild(
    void Function(ScraperConfigPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ScraperConfigPageResponseBuilder toBuilder() =>
      ScraperConfigPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScraperConfigPageResponse &&
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
    return (newBuiltValueToStringHelper(r'ScraperConfigPageResponse')
          ..add('records', records)
          ..add('total', total)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class ScraperConfigPageResponseBuilder
    implements
        Builder<ScraperConfigPageResponse, ScraperConfigPageResponseBuilder> {
  _$ScraperConfigPageResponse? _$v;

  ListBuilder<ScraperConfigResponse>? _records;
  ListBuilder<ScraperConfigResponse> get records =>
      _$this._records ??= ListBuilder<ScraperConfigResponse>();
  set records(ListBuilder<ScraperConfigResponse>? records) =>
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

  ScraperConfigPageResponseBuilder() {
    ScraperConfigPageResponse._defaults(this);
  }

  ScraperConfigPageResponseBuilder get _$this {
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
  void replace(ScraperConfigPageResponse other) {
    _$v = other as _$ScraperConfigPageResponse;
  }

  @override
  void update(void Function(ScraperConfigPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScraperConfigPageResponse build() => _build();

  _$ScraperConfigPageResponse _build() {
    _$ScraperConfigPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$ScraperConfigPageResponse._(
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
          r'ScraperConfigPageResponse',
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
