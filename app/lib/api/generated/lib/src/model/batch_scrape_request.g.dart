// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_scrape_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BatchScrapeRequest extends BatchScrapeRequest {
  @override
  final BuiltList<String> urls;
  @override
  final ScrapeConfigRequest? config;

  factory _$BatchScrapeRequest([
    void Function(BatchScrapeRequestBuilder)? updates,
  ]) => (BatchScrapeRequestBuilder()..update(updates))._build();

  _$BatchScrapeRequest._({required this.urls, this.config}) : super._();
  @override
  BatchScrapeRequest rebuild(
    void Function(BatchScrapeRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BatchScrapeRequestBuilder toBuilder() =>
      BatchScrapeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BatchScrapeRequest &&
        urls == other.urls &&
        config == other.config;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, urls.hashCode);
    _$hash = $jc(_$hash, config.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BatchScrapeRequest')
          ..add('urls', urls)
          ..add('config', config))
        .toString();
  }
}

class BatchScrapeRequestBuilder
    implements Builder<BatchScrapeRequest, BatchScrapeRequestBuilder> {
  _$BatchScrapeRequest? _$v;

  ListBuilder<String>? _urls;
  ListBuilder<String> get urls => _$this._urls ??= ListBuilder<String>();
  set urls(ListBuilder<String>? urls) => _$this._urls = urls;

  ScrapeConfigRequestBuilder? _config;
  ScrapeConfigRequestBuilder get config =>
      _$this._config ??= ScrapeConfigRequestBuilder();
  set config(ScrapeConfigRequestBuilder? config) => _$this._config = config;

  BatchScrapeRequestBuilder() {
    BatchScrapeRequest._defaults(this);
  }

  BatchScrapeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _urls = $v.urls.toBuilder();
      _config = $v.config?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BatchScrapeRequest other) {
    _$v = other as _$BatchScrapeRequest;
  }

  @override
  void update(void Function(BatchScrapeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BatchScrapeRequest build() => _build();

  _$BatchScrapeRequest _build() {
    _$BatchScrapeRequest _$result;
    try {
      _$result =
          _$v ??
          _$BatchScrapeRequest._(urls: urls.build(), config: _config?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'urls';
        urls.build();
        _$failedField = 'config';
        _config?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'BatchScrapeRequest',
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
