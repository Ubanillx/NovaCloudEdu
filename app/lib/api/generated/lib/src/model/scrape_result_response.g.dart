// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrape_result_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScrapeResultResponse extends ScrapeResultResponse {
  @override
  final String? sourceUrl;
  @override
  final BuiltList<ArticleResponse>? articles;
  @override
  final int? totalPages;
  @override
  final int? successCount;
  @override
  final int? failCount;
  @override
  final BuiltList<String>? errors;
  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;
  @override
  final int? durationMs;
  @override
  final bool? hasErrors;

  factory _$ScrapeResultResponse([
    void Function(ScrapeResultResponseBuilder)? updates,
  ]) => (ScrapeResultResponseBuilder()..update(updates))._build();

  _$ScrapeResultResponse._({
    this.sourceUrl,
    this.articles,
    this.totalPages,
    this.successCount,
    this.failCount,
    this.errors,
    this.startTime,
    this.endTime,
    this.durationMs,
    this.hasErrors,
  }) : super._();
  @override
  ScrapeResultResponse rebuild(
    void Function(ScrapeResultResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ScrapeResultResponseBuilder toBuilder() =>
      ScrapeResultResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScrapeResultResponse &&
        sourceUrl == other.sourceUrl &&
        articles == other.articles &&
        totalPages == other.totalPages &&
        successCount == other.successCount &&
        failCount == other.failCount &&
        errors == other.errors &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        durationMs == other.durationMs &&
        hasErrors == other.hasErrors;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sourceUrl.hashCode);
    _$hash = $jc(_$hash, articles.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jc(_$hash, successCount.hashCode);
    _$hash = $jc(_$hash, failCount.hashCode);
    _$hash = $jc(_$hash, errors.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, durationMs.hashCode);
    _$hash = $jc(_$hash, hasErrors.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScrapeResultResponse')
          ..add('sourceUrl', sourceUrl)
          ..add('articles', articles)
          ..add('totalPages', totalPages)
          ..add('successCount', successCount)
          ..add('failCount', failCount)
          ..add('errors', errors)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('durationMs', durationMs)
          ..add('hasErrors', hasErrors))
        .toString();
  }
}

class ScrapeResultResponseBuilder
    implements Builder<ScrapeResultResponse, ScrapeResultResponseBuilder> {
  _$ScrapeResultResponse? _$v;

  String? _sourceUrl;
  String? get sourceUrl => _$this._sourceUrl;
  set sourceUrl(String? sourceUrl) => _$this._sourceUrl = sourceUrl;

  ListBuilder<ArticleResponse>? _articles;
  ListBuilder<ArticleResponse> get articles =>
      _$this._articles ??= ListBuilder<ArticleResponse>();
  set articles(ListBuilder<ArticleResponse>? articles) =>
      _$this._articles = articles;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  int? _successCount;
  int? get successCount => _$this._successCount;
  set successCount(int? successCount) => _$this._successCount = successCount;

  int? _failCount;
  int? get failCount => _$this._failCount;
  set failCount(int? failCount) => _$this._failCount = failCount;

  ListBuilder<String>? _errors;
  ListBuilder<String> get errors => _$this._errors ??= ListBuilder<String>();
  set errors(ListBuilder<String>? errors) => _$this._errors = errors;

  DateTime? _startTime;
  DateTime? get startTime => _$this._startTime;
  set startTime(DateTime? startTime) => _$this._startTime = startTime;

  DateTime? _endTime;
  DateTime? get endTime => _$this._endTime;
  set endTime(DateTime? endTime) => _$this._endTime = endTime;

  int? _durationMs;
  int? get durationMs => _$this._durationMs;
  set durationMs(int? durationMs) => _$this._durationMs = durationMs;

  bool? _hasErrors;
  bool? get hasErrors => _$this._hasErrors;
  set hasErrors(bool? hasErrors) => _$this._hasErrors = hasErrors;

  ScrapeResultResponseBuilder() {
    ScrapeResultResponse._defaults(this);
  }

  ScrapeResultResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sourceUrl = $v.sourceUrl;
      _articles = $v.articles?.toBuilder();
      _totalPages = $v.totalPages;
      _successCount = $v.successCount;
      _failCount = $v.failCount;
      _errors = $v.errors?.toBuilder();
      _startTime = $v.startTime;
      _endTime = $v.endTime;
      _durationMs = $v.durationMs;
      _hasErrors = $v.hasErrors;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScrapeResultResponse other) {
    _$v = other as _$ScrapeResultResponse;
  }

  @override
  void update(void Function(ScrapeResultResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScrapeResultResponse build() => _build();

  _$ScrapeResultResponse _build() {
    _$ScrapeResultResponse _$result;
    try {
      _$result =
          _$v ??
          _$ScrapeResultResponse._(
            sourceUrl: sourceUrl,
            articles: _articles?.build(),
            totalPages: totalPages,
            successCount: successCount,
            failCount: failCount,
            errors: _errors?.build(),
            startTime: startTime,
            endTime: endTime,
            durationMs: durationMs,
            hasErrors: hasErrors,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'articles';
        _articles?.build();

        _$failedField = 'errors';
        _errors?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ScrapeResultResponse',
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
