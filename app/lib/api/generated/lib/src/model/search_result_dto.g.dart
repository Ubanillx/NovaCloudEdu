// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SearchResultDTO extends SearchResultDTO {
  @override
  final String? type;
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? content;
  @override
  final double? score;
  @override
  final BuiltMap<String, BuiltList<String>>? highlights;
  @override
  final String? author;
  @override
  final String? fileType;
  @override
  final String? coverUrl;
  @override
  final int? totalChapters;
  @override
  final int? bookId;
  @override
  final String? bookTitle;
  @override
  final int? chapterIndex;
  @override
  final BuiltList<String>? tags;
  @override
  final String? postType;
  @override
  final int? thumbNum;
  @override
  final int? favourNum;
  @override
  final int? commentNum;
  @override
  final DateTime? createTime;

  factory _$SearchResultDTO([void Function(SearchResultDTOBuilder)? updates]) =>
      (SearchResultDTOBuilder()..update(updates))._build();

  _$SearchResultDTO._({
    this.type,
    this.id,
    this.title,
    this.content,
    this.score,
    this.highlights,
    this.author,
    this.fileType,
    this.coverUrl,
    this.totalChapters,
    this.bookId,
    this.bookTitle,
    this.chapterIndex,
    this.tags,
    this.postType,
    this.thumbNum,
    this.favourNum,
    this.commentNum,
    this.createTime,
  }) : super._();
  @override
  SearchResultDTO rebuild(void Function(SearchResultDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SearchResultDTOBuilder toBuilder() => SearchResultDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchResultDTO &&
        type == other.type &&
        id == other.id &&
        title == other.title &&
        content == other.content &&
        score == other.score &&
        highlights == other.highlights &&
        author == other.author &&
        fileType == other.fileType &&
        coverUrl == other.coverUrl &&
        totalChapters == other.totalChapters &&
        bookId == other.bookId &&
        bookTitle == other.bookTitle &&
        chapterIndex == other.chapterIndex &&
        tags == other.tags &&
        postType == other.postType &&
        thumbNum == other.thumbNum &&
        favourNum == other.favourNum &&
        commentNum == other.commentNum &&
        createTime == other.createTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, highlights.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, fileType.hashCode);
    _$hash = $jc(_$hash, coverUrl.hashCode);
    _$hash = $jc(_$hash, totalChapters.hashCode);
    _$hash = $jc(_$hash, bookId.hashCode);
    _$hash = $jc(_$hash, bookTitle.hashCode);
    _$hash = $jc(_$hash, chapterIndex.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, postType.hashCode);
    _$hash = $jc(_$hash, thumbNum.hashCode);
    _$hash = $jc(_$hash, favourNum.hashCode);
    _$hash = $jc(_$hash, commentNum.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SearchResultDTO')
          ..add('type', type)
          ..add('id', id)
          ..add('title', title)
          ..add('content', content)
          ..add('score', score)
          ..add('highlights', highlights)
          ..add('author', author)
          ..add('fileType', fileType)
          ..add('coverUrl', coverUrl)
          ..add('totalChapters', totalChapters)
          ..add('bookId', bookId)
          ..add('bookTitle', bookTitle)
          ..add('chapterIndex', chapterIndex)
          ..add('tags', tags)
          ..add('postType', postType)
          ..add('thumbNum', thumbNum)
          ..add('favourNum', favourNum)
          ..add('commentNum', commentNum)
          ..add('createTime', createTime))
        .toString();
  }
}

class SearchResultDTOBuilder
    implements Builder<SearchResultDTO, SearchResultDTOBuilder> {
  _$SearchResultDTO? _$v;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  double? _score;
  double? get score => _$this._score;
  set score(double? score) => _$this._score = score;

  MapBuilder<String, BuiltList<String>>? _highlights;
  MapBuilder<String, BuiltList<String>> get highlights =>
      _$this._highlights ??= MapBuilder<String, BuiltList<String>>();
  set highlights(MapBuilder<String, BuiltList<String>>? highlights) =>
      _$this._highlights = highlights;

  String? _author;
  String? get author => _$this._author;
  set author(String? author) => _$this._author = author;

  String? _fileType;
  String? get fileType => _$this._fileType;
  set fileType(String? fileType) => _$this._fileType = fileType;

  String? _coverUrl;
  String? get coverUrl => _$this._coverUrl;
  set coverUrl(String? coverUrl) => _$this._coverUrl = coverUrl;

  int? _totalChapters;
  int? get totalChapters => _$this._totalChapters;
  set totalChapters(int? totalChapters) =>
      _$this._totalChapters = totalChapters;

  int? _bookId;
  int? get bookId => _$this._bookId;
  set bookId(int? bookId) => _$this._bookId = bookId;

  String? _bookTitle;
  String? get bookTitle => _$this._bookTitle;
  set bookTitle(String? bookTitle) => _$this._bookTitle = bookTitle;

  int? _chapterIndex;
  int? get chapterIndex => _$this._chapterIndex;
  set chapterIndex(int? chapterIndex) => _$this._chapterIndex = chapterIndex;

  ListBuilder<String>? _tags;
  ListBuilder<String> get tags => _$this._tags ??= ListBuilder<String>();
  set tags(ListBuilder<String>? tags) => _$this._tags = tags;

  String? _postType;
  String? get postType => _$this._postType;
  set postType(String? postType) => _$this._postType = postType;

  int? _thumbNum;
  int? get thumbNum => _$this._thumbNum;
  set thumbNum(int? thumbNum) => _$this._thumbNum = thumbNum;

  int? _favourNum;
  int? get favourNum => _$this._favourNum;
  set favourNum(int? favourNum) => _$this._favourNum = favourNum;

  int? _commentNum;
  int? get commentNum => _$this._commentNum;
  set commentNum(int? commentNum) => _$this._commentNum = commentNum;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  SearchResultDTOBuilder() {
    SearchResultDTO._defaults(this);
  }

  SearchResultDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _id = $v.id;
      _title = $v.title;
      _content = $v.content;
      _score = $v.score;
      _highlights = $v.highlights?.toBuilder();
      _author = $v.author;
      _fileType = $v.fileType;
      _coverUrl = $v.coverUrl;
      _totalChapters = $v.totalChapters;
      _bookId = $v.bookId;
      _bookTitle = $v.bookTitle;
      _chapterIndex = $v.chapterIndex;
      _tags = $v.tags?.toBuilder();
      _postType = $v.postType;
      _thumbNum = $v.thumbNum;
      _favourNum = $v.favourNum;
      _commentNum = $v.commentNum;
      _createTime = $v.createTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SearchResultDTO other) {
    _$v = other as _$SearchResultDTO;
  }

  @override
  void update(void Function(SearchResultDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SearchResultDTO build() => _build();

  _$SearchResultDTO _build() {
    _$SearchResultDTO _$result;
    try {
      _$result =
          _$v ??
          _$SearchResultDTO._(
            type: type,
            id: id,
            title: title,
            content: content,
            score: score,
            highlights: _highlights?.build(),
            author: author,
            fileType: fileType,
            coverUrl: coverUrl,
            totalChapters: totalChapters,
            bookId: bookId,
            bookTitle: bookTitle,
            chapterIndex: chapterIndex,
            tags: _tags?.build(),
            postType: postType,
            thumbNum: thumbNum,
            favourNum: favourNum,
            commentNum: commentNum,
            createTime: createTime,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'highlights';
        _highlights?.build();

        _$failedField = 'tags';
        _tags?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SearchResultDTO',
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
