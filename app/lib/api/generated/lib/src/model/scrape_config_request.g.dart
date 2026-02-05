// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrape_config_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScrapeConfigRequest extends ScrapeConfigRequest {
  @override
  final String? titleSelector;
  @override
  final String? authorSelector;
  @override
  final String? sourceSelector;
  @override
  final String? contentSelector;
  @override
  final String? dateSelector;
  @override
  final String? imageSelector;
  @override
  final String? linkSelector;
  @override
  final int? maxDepth;
  @override
  final int? maxPages;
  @override
  final int? delayMs;

  factory _$ScrapeConfigRequest([
    void Function(ScrapeConfigRequestBuilder)? updates,
  ]) => (ScrapeConfigRequestBuilder()..update(updates))._build();

  _$ScrapeConfigRequest._({
    this.titleSelector,
    this.authorSelector,
    this.sourceSelector,
    this.contentSelector,
    this.dateSelector,
    this.imageSelector,
    this.linkSelector,
    this.maxDepth,
    this.maxPages,
    this.delayMs,
  }) : super._();
  @override
  ScrapeConfigRequest rebuild(
    void Function(ScrapeConfigRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ScrapeConfigRequestBuilder toBuilder() =>
      ScrapeConfigRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScrapeConfigRequest &&
        titleSelector == other.titleSelector &&
        authorSelector == other.authorSelector &&
        sourceSelector == other.sourceSelector &&
        contentSelector == other.contentSelector &&
        dateSelector == other.dateSelector &&
        imageSelector == other.imageSelector &&
        linkSelector == other.linkSelector &&
        maxDepth == other.maxDepth &&
        maxPages == other.maxPages &&
        delayMs == other.delayMs;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, titleSelector.hashCode);
    _$hash = $jc(_$hash, authorSelector.hashCode);
    _$hash = $jc(_$hash, sourceSelector.hashCode);
    _$hash = $jc(_$hash, contentSelector.hashCode);
    _$hash = $jc(_$hash, dateSelector.hashCode);
    _$hash = $jc(_$hash, imageSelector.hashCode);
    _$hash = $jc(_$hash, linkSelector.hashCode);
    _$hash = $jc(_$hash, maxDepth.hashCode);
    _$hash = $jc(_$hash, maxPages.hashCode);
    _$hash = $jc(_$hash, delayMs.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScrapeConfigRequest')
          ..add('titleSelector', titleSelector)
          ..add('authorSelector', authorSelector)
          ..add('sourceSelector', sourceSelector)
          ..add('contentSelector', contentSelector)
          ..add('dateSelector', dateSelector)
          ..add('imageSelector', imageSelector)
          ..add('linkSelector', linkSelector)
          ..add('maxDepth', maxDepth)
          ..add('maxPages', maxPages)
          ..add('delayMs', delayMs))
        .toString();
  }
}

class ScrapeConfigRequestBuilder
    implements Builder<ScrapeConfigRequest, ScrapeConfigRequestBuilder> {
  _$ScrapeConfigRequest? _$v;

  String? _titleSelector;
  String? get titleSelector => _$this._titleSelector;
  set titleSelector(String? titleSelector) =>
      _$this._titleSelector = titleSelector;

  String? _authorSelector;
  String? get authorSelector => _$this._authorSelector;
  set authorSelector(String? authorSelector) =>
      _$this._authorSelector = authorSelector;

  String? _sourceSelector;
  String? get sourceSelector => _$this._sourceSelector;
  set sourceSelector(String? sourceSelector) =>
      _$this._sourceSelector = sourceSelector;

  String? _contentSelector;
  String? get contentSelector => _$this._contentSelector;
  set contentSelector(String? contentSelector) =>
      _$this._contentSelector = contentSelector;

  String? _dateSelector;
  String? get dateSelector => _$this._dateSelector;
  set dateSelector(String? dateSelector) => _$this._dateSelector = dateSelector;

  String? _imageSelector;
  String? get imageSelector => _$this._imageSelector;
  set imageSelector(String? imageSelector) =>
      _$this._imageSelector = imageSelector;

  String? _linkSelector;
  String? get linkSelector => _$this._linkSelector;
  set linkSelector(String? linkSelector) => _$this._linkSelector = linkSelector;

  int? _maxDepth;
  int? get maxDepth => _$this._maxDepth;
  set maxDepth(int? maxDepth) => _$this._maxDepth = maxDepth;

  int? _maxPages;
  int? get maxPages => _$this._maxPages;
  set maxPages(int? maxPages) => _$this._maxPages = maxPages;

  int? _delayMs;
  int? get delayMs => _$this._delayMs;
  set delayMs(int? delayMs) => _$this._delayMs = delayMs;

  ScrapeConfigRequestBuilder() {
    ScrapeConfigRequest._defaults(this);
  }

  ScrapeConfigRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _titleSelector = $v.titleSelector;
      _authorSelector = $v.authorSelector;
      _sourceSelector = $v.sourceSelector;
      _contentSelector = $v.contentSelector;
      _dateSelector = $v.dateSelector;
      _imageSelector = $v.imageSelector;
      _linkSelector = $v.linkSelector;
      _maxDepth = $v.maxDepth;
      _maxPages = $v.maxPages;
      _delayMs = $v.delayMs;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScrapeConfigRequest other) {
    _$v = other as _$ScrapeConfigRequest;
  }

  @override
  void update(void Function(ScrapeConfigRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScrapeConfigRequest build() => _build();

  _$ScrapeConfigRequest _build() {
    final _$result =
        _$v ??
        _$ScrapeConfigRequest._(
          titleSelector: titleSelector,
          authorSelector: authorSelector,
          sourceSelector: sourceSelector,
          contentSelector: contentSelector,
          dateSelector: dateSelector,
          imageSelector: imageSelector,
          linkSelector: linkSelector,
          maxDepth: maxDepth,
          maxPages: maxPages,
          delayMs: delayMs,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
