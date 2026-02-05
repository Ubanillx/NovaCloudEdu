// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrape_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScrapeRequest extends ScrapeRequest {
  @override
  final String url;
  @override
  final ScrapeConfigRequest? config;
  @override
  final bool? recursive;
  @override
  final int? maxArticles;

  factory _$ScrapeRequest([void Function(ScrapeRequestBuilder)? updates]) =>
      (ScrapeRequestBuilder()..update(updates))._build();

  _$ScrapeRequest._({
    required this.url,
    this.config,
    this.recursive,
    this.maxArticles,
  }) : super._();
  @override
  ScrapeRequest rebuild(void Function(ScrapeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScrapeRequestBuilder toBuilder() => ScrapeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScrapeRequest &&
        url == other.url &&
        config == other.config &&
        recursive == other.recursive &&
        maxArticles == other.maxArticles;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, config.hashCode);
    _$hash = $jc(_$hash, recursive.hashCode);
    _$hash = $jc(_$hash, maxArticles.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScrapeRequest')
          ..add('url', url)
          ..add('config', config)
          ..add('recursive', recursive)
          ..add('maxArticles', maxArticles))
        .toString();
  }
}

class ScrapeRequestBuilder
    implements Builder<ScrapeRequest, ScrapeRequestBuilder> {
  _$ScrapeRequest? _$v;

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

  ScrapeRequestBuilder() {
    ScrapeRequest._defaults(this);
  }

  ScrapeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _url = $v.url;
      _config = $v.config?.toBuilder();
      _recursive = $v.recursive;
      _maxArticles = $v.maxArticles;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScrapeRequest other) {
    _$v = other as _$ScrapeRequest;
  }

  @override
  void update(void Function(ScrapeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScrapeRequest build() => _build();

  _$ScrapeRequest _build() {
    _$ScrapeRequest _$result;
    try {
      _$result =
          _$v ??
          _$ScrapeRequest._(
            url: BuiltValueNullFieldError.checkNotNull(
              url,
              r'ScrapeRequest',
              'url',
            ),
            config: _config?.build(),
            recursive: recursive,
            maxArticles: maxArticles,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'config';
        _config?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ScrapeRequest',
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
