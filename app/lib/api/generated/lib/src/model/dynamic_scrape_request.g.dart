// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_scrape_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DynamicScrapeRequest extends DynamicScrapeRequest {
  @override
  final String url;
  @override
  final ScrapeConfigRequest? config;
  @override
  final bool? recursive;
  @override
  final int? maxArticles;
  @override
  final int? waitForJsMs;
  @override
  final String? waitForSelector;
  @override
  final int? timeoutSeconds;

  factory _$DynamicScrapeRequest([
    void Function(DynamicScrapeRequestBuilder)? updates,
  ]) => (DynamicScrapeRequestBuilder()..update(updates))._build();

  _$DynamicScrapeRequest._({
    required this.url,
    this.config,
    this.recursive,
    this.maxArticles,
    this.waitForJsMs,
    this.waitForSelector,
    this.timeoutSeconds,
  }) : super._();
  @override
  DynamicScrapeRequest rebuild(
    void Function(DynamicScrapeRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DynamicScrapeRequestBuilder toBuilder() =>
      DynamicScrapeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DynamicScrapeRequest &&
        url == other.url &&
        config == other.config &&
        recursive == other.recursive &&
        maxArticles == other.maxArticles &&
        waitForJsMs == other.waitForJsMs &&
        waitForSelector == other.waitForSelector &&
        timeoutSeconds == other.timeoutSeconds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, config.hashCode);
    _$hash = $jc(_$hash, recursive.hashCode);
    _$hash = $jc(_$hash, maxArticles.hashCode);
    _$hash = $jc(_$hash, waitForJsMs.hashCode);
    _$hash = $jc(_$hash, waitForSelector.hashCode);
    _$hash = $jc(_$hash, timeoutSeconds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DynamicScrapeRequest')
          ..add('url', url)
          ..add('config', config)
          ..add('recursive', recursive)
          ..add('maxArticles', maxArticles)
          ..add('waitForJsMs', waitForJsMs)
          ..add('waitForSelector', waitForSelector)
          ..add('timeoutSeconds', timeoutSeconds))
        .toString();
  }
}

class DynamicScrapeRequestBuilder
    implements Builder<DynamicScrapeRequest, DynamicScrapeRequestBuilder> {
  _$DynamicScrapeRequest? _$v;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  ScrapeConfigRequestBuilder? _config;
  ScrapeConfigRequestBuilder get config =>
      _$this._config ??= ScrapeConfigRequestBuilder();
  set config(ScrapeConfigRequestBuilder? config) => _$this._config = config;

  bool? _recursive;
  bool? get recursive => _$this._recursive;
  set recursive(bool? recursive) => _$this._recursive = recursive;

  int? _maxArticles;
  int? get maxArticles => _$this._maxArticles;
  set maxArticles(int? maxArticles) => _$this._maxArticles = maxArticles;

  int? _waitForJsMs;
  int? get waitForJsMs => _$this._waitForJsMs;
  set waitForJsMs(int? waitForJsMs) => _$this._waitForJsMs = waitForJsMs;

  String? _waitForSelector;
  String? get waitForSelector => _$this._waitForSelector;
  set waitForSelector(String? waitForSelector) =>
      _$this._waitForSelector = waitForSelector;

  int? _timeoutSeconds;
  int? get timeoutSeconds => _$this._timeoutSeconds;
  set timeoutSeconds(int? timeoutSeconds) =>
      _$this._timeoutSeconds = timeoutSeconds;

  DynamicScrapeRequestBuilder() {
    DynamicScrapeRequest._defaults(this);
  }

  DynamicScrapeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _url = $v.url;
      _config = $v.config?.toBuilder();
      _recursive = $v.recursive;
      _maxArticles = $v.maxArticles;
      _waitForJsMs = $v.waitForJsMs;
      _waitForSelector = $v.waitForSelector;
      _timeoutSeconds = $v.timeoutSeconds;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DynamicScrapeRequest other) {
    _$v = other as _$DynamicScrapeRequest;
  }

  @override
  void update(void Function(DynamicScrapeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DynamicScrapeRequest build() => _build();

  _$DynamicScrapeRequest _build() {
    _$DynamicScrapeRequest _$result;
    try {
      _$result =
          _$v ??
          _$DynamicScrapeRequest._(
            url: BuiltValueNullFieldError.checkNotNull(
              url,
              r'DynamicScrapeRequest',
              'url',
            ),
            config: _config?.build(),
            recursive: recursive,
            maxArticles: maxArticles,
            waitForJsMs: waitForJsMs,
            waitForSelector: waitForSelector,
            timeoutSeconds: timeoutSeconds,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'config';
        _config?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DynamicScrapeRequest',
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
