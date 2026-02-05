// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_scrape_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SourceScrapeRequest extends SourceScrapeRequest {
  @override
  final String sourceCode;
  @override
  final int? maxArticles;

  factory _$SourceScrapeRequest([
    void Function(SourceScrapeRequestBuilder)? updates,
  ]) => (SourceScrapeRequestBuilder()..update(updates))._build();

  _$SourceScrapeRequest._({required this.sourceCode, this.maxArticles})
    : super._();
  @override
  SourceScrapeRequest rebuild(
    void Function(SourceScrapeRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SourceScrapeRequestBuilder toBuilder() =>
      SourceScrapeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SourceScrapeRequest &&
        sourceCode == other.sourceCode &&
        maxArticles == other.maxArticles;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sourceCode.hashCode);
    _$hash = $jc(_$hash, maxArticles.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SourceScrapeRequest')
          ..add('sourceCode', sourceCode)
          ..add('maxArticles', maxArticles))
        .toString();
  }
}

class SourceScrapeRequestBuilder
    implements Builder<SourceScrapeRequest, SourceScrapeRequestBuilder> {
  _$SourceScrapeRequest? _$v;

  String? _sourceCode;
  String? get sourceCode => _$this._sourceCode;
  set sourceCode(String? sourceCode) => _$this._sourceCode = sourceCode;

  int? _maxArticles;
  int? get maxArticles => _$this._maxArticles;
  set maxArticles(int? maxArticles) => _$this._maxArticles = maxArticles;

  SourceScrapeRequestBuilder() {
    SourceScrapeRequest._defaults(this);
  }

  SourceScrapeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sourceCode = $v.sourceCode;
      _maxArticles = $v.maxArticles;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SourceScrapeRequest other) {
    _$v = other as _$SourceScrapeRequest;
  }

  @override
  void update(void Function(SourceScrapeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SourceScrapeRequest build() => _build();

  _$SourceScrapeRequest _build() {
    final _$result =
        _$v ??
        _$SourceScrapeRequest._(
          sourceCode: BuiltValueNullFieldError.checkNotNull(
            sourceCode,
            r'SourceScrapeRequest',
            'sourceCode',
          ),
          maxArticles: maxArticles,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
