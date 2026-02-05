// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ArticleResponse extends ArticleResponse {
  @override
  final String? title;
  @override
  final String? author;
  @override
  final String? source_;
  @override
  final String? content;
  @override
  final String? summary;
  @override
  final String? url;
  @override
  final String? coverImage;
  @override
  final BuiltList<String>? images;
  @override
  final String? sourceType;
  @override
  final String? sourceTypeName;
  @override
  final DateTime? publishTime;
  @override
  final DateTime? scrapeTime;

  factory _$ArticleResponse([void Function(ArticleResponseBuilder)? updates]) =>
      (ArticleResponseBuilder()..update(updates))._build();

  _$ArticleResponse._({
    this.title,
    this.author,
    this.source_,
    this.content,
    this.summary,
    this.url,
    this.coverImage,
    this.images,
    this.sourceType,
    this.sourceTypeName,
    this.publishTime,
    this.scrapeTime,
  }) : super._();
  @override
  ArticleResponse rebuild(void Function(ArticleResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ArticleResponseBuilder toBuilder() => ArticleResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ArticleResponse &&
        title == other.title &&
        author == other.author &&
        source_ == other.source_ &&
        content == other.content &&
        summary == other.summary &&
        url == other.url &&
        coverImage == other.coverImage &&
        images == other.images &&
        sourceType == other.sourceType &&
        sourceTypeName == other.sourceTypeName &&
        publishTime == other.publishTime &&
        scrapeTime == other.scrapeTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, summary.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, coverImage.hashCode);
    _$hash = $jc(_$hash, images.hashCode);
    _$hash = $jc(_$hash, sourceType.hashCode);
    _$hash = $jc(_$hash, sourceTypeName.hashCode);
    _$hash = $jc(_$hash, publishTime.hashCode);
    _$hash = $jc(_$hash, scrapeTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ArticleResponse')
          ..add('title', title)
          ..add('author', author)
          ..add('source_', source_)
          ..add('content', content)
          ..add('summary', summary)
          ..add('url', url)
          ..add('coverImage', coverImage)
          ..add('images', images)
          ..add('sourceType', sourceType)
          ..add('sourceTypeName', sourceTypeName)
          ..add('publishTime', publishTime)
          ..add('scrapeTime', scrapeTime))
        .toString();
  }
}

class ArticleResponseBuilder
    implements Builder<ArticleResponse, ArticleResponseBuilder> {
  _$ArticleResponse? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _author;
  String? get author => _$this._author;
  set author(String? author) => _$this._author = author;

  String? _source_;
  String? get source_ => _$this._source_;
  set source_(String? source_) => _$this._source_ = source_;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _summary;
  String? get summary => _$this._summary;
  set summary(String? summary) => _$this._summary = summary;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  String? _coverImage;
  String? get coverImage => _$this._coverImage;
  set coverImage(String? coverImage) => _$this._coverImage = coverImage;

  ListBuilder<String>? _images;
  ListBuilder<String> get images => _$this._images ??= ListBuilder<String>();
  set images(ListBuilder<String>? images) => _$this._images = images;

  String? _sourceType;
  String? get sourceType => _$this._sourceType;
  set sourceType(String? sourceType) => _$this._sourceType = sourceType;

  String? _sourceTypeName;
  String? get sourceTypeName => _$this._sourceTypeName;
  set sourceTypeName(String? sourceTypeName) =>
      _$this._sourceTypeName = sourceTypeName;

  DateTime? _publishTime;
  DateTime? get publishTime => _$this._publishTime;
  set publishTime(DateTime? publishTime) => _$this._publishTime = publishTime;

  DateTime? _scrapeTime;
  DateTime? get scrapeTime => _$this._scrapeTime;
  set scrapeTime(DateTime? scrapeTime) => _$this._scrapeTime = scrapeTime;

  ArticleResponseBuilder() {
    ArticleResponse._defaults(this);
  }

  ArticleResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _author = $v.author;
      _source_ = $v.source_;
      _content = $v.content;
      _summary = $v.summary;
      _url = $v.url;
      _coverImage = $v.coverImage;
      _images = $v.images?.toBuilder();
      _sourceType = $v.sourceType;
      _sourceTypeName = $v.sourceTypeName;
      _publishTime = $v.publishTime;
      _scrapeTime = $v.scrapeTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ArticleResponse other) {
    _$v = other as _$ArticleResponse;
  }

  @override
  void update(void Function(ArticleResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ArticleResponse build() => _build();

  _$ArticleResponse _build() {
    _$ArticleResponse _$result;
    try {
      _$result =
          _$v ??
          _$ArticleResponse._(
            title: title,
            author: author,
            source_: source_,
            content: content,
            summary: summary,
            url: url,
            coverImage: coverImage,
            images: _images?.build(),
            sourceType: sourceType,
            sourceTypeName: sourceTypeName,
            publishTime: publishTime,
            scrapeTime: scrapeTime,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'images';
        _images?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ArticleResponse',
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
