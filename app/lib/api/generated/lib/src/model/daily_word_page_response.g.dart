// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_word_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DailyWordPageResponse extends DailyWordPageResponse {
  @override
  final BuiltList<DailyWordResponse>? records;
  @override
  final int? total;
  @override
  final int? pageNum;
  @override
  final int? pageSize;
  @override
  final int? totalPages;

  factory _$DailyWordPageResponse([
    void Function(DailyWordPageResponseBuilder)? updates,
  ]) => (DailyWordPageResponseBuilder()..update(updates))._build();

  _$DailyWordPageResponse._({
    this.records,
    this.total,
    this.pageNum,
    this.pageSize,
    this.totalPages,
  }) : super._();
  @override
  DailyWordPageResponse rebuild(
    void Function(DailyWordPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DailyWordPageResponseBuilder toBuilder() =>
      DailyWordPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DailyWordPageResponse &&
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
    return (newBuiltValueToStringHelper(r'DailyWordPageResponse')
          ..add('records', records)
          ..add('total', total)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class DailyWordPageResponseBuilder
    implements Builder<DailyWordPageResponse, DailyWordPageResponseBuilder> {
  _$DailyWordPageResponse? _$v;

  ListBuilder<DailyWordResponse>? _records;
  ListBuilder<DailyWordResponse> get records =>
      _$this._records ??= ListBuilder<DailyWordResponse>();
  set records(ListBuilder<DailyWordResponse>? records) =>
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

  DailyWordPageResponseBuilder() {
    DailyWordPageResponse._defaults(this);
  }

  DailyWordPageResponseBuilder get _$this {
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
  void replace(DailyWordPageResponse other) {
    _$v = other as _$DailyWordPageResponse;
  }

  @override
  void update(void Function(DailyWordPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DailyWordPageResponse build() => _build();

  _$DailyWordPageResponse _build() {
    _$DailyWordPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$DailyWordPageResponse._(
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
          r'DailyWordPageResponse',
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
