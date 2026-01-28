// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_article_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DailyArticleResponse extends DailyArticleResponse {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? content;
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
  final int? difficulty;
  @override
  final String? difficultyDesc;
  @override
  final int? readTime;
  @override
  final Date? publishDate;
  @override
  final int? viewCount;
  @override
  final int? likeCount;
  @override
  final int? collectCount;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$DailyArticleResponse([
    void Function(DailyArticleResponseBuilder)? updates,
  ]) => (DailyArticleResponseBuilder()..update(updates))._build();

  _$DailyArticleResponse._({
    this.id,
    this.title,
    this.content,
    this.summary,
    this.coverImage,
    this.author,
    this.source_,
    this.sourceUrl,
    this.category,
    this.tags,
    this.difficulty,
    this.difficultyDesc,
    this.readTime,
    this.publishDate,
    this.viewCount,
    this.likeCount,
    this.collectCount,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  DailyArticleResponse rebuild(
    void Function(DailyArticleResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DailyArticleResponseBuilder toBuilder() =>
      DailyArticleResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DailyArticleResponse &&
        id == other.id &&
        title == other.title &&
        content == other.content &&
        summary == other.summary &&
        coverImage == other.coverImage &&
        author == other.author &&
        source_ == other.source_ &&
        sourceUrl == other.sourceUrl &&
        category == other.category &&
        tags == other.tags &&
        difficulty == other.difficulty &&
        difficultyDesc == other.difficultyDesc &&
        readTime == other.readTime &&
        publishDate == other.publishDate &&
        viewCount == other.viewCount &&
        likeCount == other.likeCount &&
        collectCount == other.collectCount &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, summary.hashCode);
    _$hash = $jc(_$hash, coverImage.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, sourceUrl.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, difficulty.hashCode);
    _$hash = $jc(_$hash, difficultyDesc.hashCode);
    _$hash = $jc(_$hash, readTime.hashCode);
    _$hash = $jc(_$hash, publishDate.hashCode);
    _$hash = $jc(_$hash, viewCount.hashCode);
    _$hash = $jc(_$hash, likeCount.hashCode);
    _$hash = $jc(_$hash, collectCount.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DailyArticleResponse')
          ..add('id', id)
          ..add('title', title)
          ..add('content', content)
          ..add('summary', summary)
          ..add('coverImage', coverImage)
          ..add('author', author)
          ..add('source_', source_)
          ..add('sourceUrl', sourceUrl)
          ..add('category', category)
          ..add('tags', tags)
          ..add('difficulty', difficulty)
          ..add('difficultyDesc', difficultyDesc)
          ..add('readTime', readTime)
          ..add('publishDate', publishDate)
          ..add('viewCount', viewCount)
          ..add('likeCount', likeCount)
          ..add('collectCount', collectCount)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class DailyArticleResponseBuilder
    implements Builder<DailyArticleResponse, DailyArticleResponseBuilder> {
  _$DailyArticleResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

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

  int? _difficulty;
  int? get difficulty => _$this._difficulty;
  set difficulty(int? difficulty) => _$this._difficulty = difficulty;

  String? _difficultyDesc;
  String? get difficultyDesc => _$this._difficultyDesc;
  set difficultyDesc(String? difficultyDesc) =>
      _$this._difficultyDesc = difficultyDesc;

  int? _readTime;
  int? get readTime => _$this._readTime;
  set readTime(int? readTime) => _$this._readTime = readTime;

  Date? _publishDate;
  Date? get publishDate => _$this._publishDate;
  set publishDate(Date? publishDate) => _$this._publishDate = publishDate;

  int? _viewCount;
  int? get viewCount => _$this._viewCount;
  set viewCount(int? viewCount) => _$this._viewCount = viewCount;

  int? _likeCount;
  int? get likeCount => _$this._likeCount;
  set likeCount(int? likeCount) => _$this._likeCount = likeCount;

  int? _collectCount;
  int? get collectCount => _$this._collectCount;
  set collectCount(int? collectCount) => _$this._collectCount = collectCount;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  DailyArticleResponseBuilder() {
    DailyArticleResponse._defaults(this);
  }

  DailyArticleResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _content = $v.content;
      _summary = $v.summary;
      _coverImage = $v.coverImage;
      _author = $v.author;
      _source_ = $v.source_;
      _sourceUrl = $v.sourceUrl;
      _category = $v.category;
      _tags = $v.tags?.toBuilder();
      _difficulty = $v.difficulty;
      _difficultyDesc = $v.difficultyDesc;
      _readTime = $v.readTime;
      _publishDate = $v.publishDate;
      _viewCount = $v.viewCount;
      _likeCount = $v.likeCount;
      _collectCount = $v.collectCount;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DailyArticleResponse other) {
    _$v = other as _$DailyArticleResponse;
  }

  @override
  void update(void Function(DailyArticleResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DailyArticleResponse build() => _build();

  _$DailyArticleResponse _build() {
    _$DailyArticleResponse _$result;
    try {
      _$result =
          _$v ??
          _$DailyArticleResponse._(
            id: id,
            title: title,
            content: content,
            summary: summary,
            coverImage: coverImage,
            author: author,
            source_: source_,
            sourceUrl: sourceUrl,
            category: category,
            tags: _tags?.build(),
            difficulty: difficulty,
            difficultyDesc: difficultyDesc,
            readTime: readTime,
            publishDate: publishDate,
            viewCount: viewCount,
            likeCount: likeCount,
            collectCount: collectCount,
            createTime: createTime,
            updateTime: updateTime,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tags';
        _tags?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DailyArticleResponse',
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
