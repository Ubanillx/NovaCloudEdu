// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_daily_article_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateDailyArticleRequest extends CreateDailyArticleRequest {
  @override
  final String title;
  @override
  final String content;
  @override
  final int difficulty;
  @override
  final Date publishDate;
  @override
  final String? summary;
  @override
  final String? coverImage;
  @override
  final String? author;
  @override
  final String? source_;
  @override
  final String? sourceUrl;
  @override
  final String? category;
  @override
  final BuiltList<String>? tags;
  @override
  final int? readTime;

  factory _$CreateDailyArticleRequest([
    void Function(CreateDailyArticleRequestBuilder)? updates,
  ]) => (CreateDailyArticleRequestBuilder()..update(updates))._build();

  _$CreateDailyArticleRequest._({
    required this.title,
    required this.content,
    required this.difficulty,
    required this.publishDate,
    this.summary,
    this.coverImage,
    this.author,
    this.source_,
    this.sourceUrl,
    this.category,
    this.tags,
    this.readTime,
  }) : super._();
  @override
  CreateDailyArticleRequest rebuild(
    void Function(CreateDailyArticleRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateDailyArticleRequestBuilder toBuilder() =>
      CreateDailyArticleRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateDailyArticleRequest &&
        title == other.title &&
        content == other.content &&
        difficulty == other.difficulty &&
        publishDate == other.publishDate &&
        summary == other.summary &&
        coverImage == other.coverImage &&
        author == other.author &&
        source_ == other.source_ &&
        sourceUrl == other.sourceUrl &&
        category == other.category &&
        tags == other.tags &&
        readTime == other.readTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, difficulty.hashCode);
    _$hash = $jc(_$hash, publishDate.hashCode);
    _$hash = $jc(_$hash, summary.hashCode);
    _$hash = $jc(_$hash, coverImage.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, sourceUrl.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, readTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateDailyArticleRequest')
          ..add('title', title)
          ..add('content', content)
          ..add('difficulty', difficulty)
          ..add('publishDate', publishDate)
          ..add('summary', summary)
          ..add('coverImage', coverImage)
          ..add('author', author)
          ..add('source_', source_)
          ..add('sourceUrl', sourceUrl)
          ..add('category', category)
          ..add('tags', tags)
          ..add('readTime', readTime))
        .toString();
  }
}

class CreateDailyArticleRequestBuilder
    implements
        Builder<CreateDailyArticleRequest, CreateDailyArticleRequestBuilder> {
  _$CreateDailyArticleRequest? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  int? _difficulty;
  int? get difficulty => _$this._difficulty;
  set difficulty(int? difficulty) => _$this._difficulty = difficulty;

  Date? _publishDate;
  Date? get publishDate => _$this._publishDate;
  set publishDate(Date? publishDate) => _$this._publishDate = publishDate;

  String? _summary;
  String? get summary => _$this._summary;
  set summary(String? summary) => _$this._summary = summary;

  String? _coverImage;
  String? get coverImage => _$this._coverImage;
  set coverImage(String? coverImage) => _$this._coverImage = coverImage;

  String? _author;
  String? get author => _$this._author;
  set author(String? author) => _$this._author = author;

  String? _source_;
  String? get source_ => _$this._source_;
  set source_(String? source_) => _$this._source_ = source_;

  String? _sourceUrl;
  String? get sourceUrl => _$this._sourceUrl;
  set sourceUrl(String? sourceUrl) => _$this._sourceUrl = sourceUrl;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  ListBuilder<String>? _tags;
  ListBuilder<String> get tags => _$this._tags ??= ListBuilder<String>();
  set tags(ListBuilder<String>? tags) => _$this._tags = tags;

  int? _readTime;
  int? get readTime => _$this._readTime;
  set readTime(int? readTime) => _$this._readTime = readTime;

  CreateDailyArticleRequestBuilder() {
    CreateDailyArticleRequest._defaults(this);
  }

  CreateDailyArticleRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _content = $v.content;
      _difficulty = $v.difficulty;
      _publishDate = $v.publishDate;
      _summary = $v.summary;
      _coverImage = $v.coverImage;
      _author = $v.author;
      _source_ = $v.source_;
      _sourceUrl = $v.sourceUrl;
      _category = $v.category;
      _tags = $v.tags?.toBuilder();
      _readTime = $v.readTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateDailyArticleRequest other) {
    _$v = other as _$CreateDailyArticleRequest;
  }

  @override
  void update(void Function(CreateDailyArticleRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateDailyArticleRequest build() => _build();

  _$CreateDailyArticleRequest _build() {
    _$CreateDailyArticleRequest _$result;
    try {
      _$result =
          _$v ??
          _$CreateDailyArticleRequest._(
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'CreateDailyArticleRequest',
              'title',
            ),
            content: BuiltValueNullFieldError.checkNotNull(
              content,
              r'CreateDailyArticleRequest',
              'content',
            ),
            difficulty: BuiltValueNullFieldError.checkNotNull(
              difficulty,
              r'CreateDailyArticleRequest',
              'difficulty',
            ),
            publishDate: BuiltValueNullFieldError.checkNotNull(
              publishDate,
              r'CreateDailyArticleRequest',
              'publishDate',
            ),
            summary: summary,
            coverImage: coverImage,
            author: author,
            source_: source_,
            sourceUrl: sourceUrl,
            category: category,
            tags: _tags?.build(),
            readTime: readTime,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tags';
        _tags?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CreateDailyArticleRequest',
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
