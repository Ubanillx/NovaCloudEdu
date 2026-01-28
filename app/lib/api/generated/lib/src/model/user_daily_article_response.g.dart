// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_daily_article_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserDailyArticleResponse extends UserDailyArticleResponse {
  @override
  final int? id;
  @override
  final int? userId;
  @override
  final int? articleId;
  @override
  final bool? read;
  @override
  final bool? liked;
  @override
  final bool? collected;
  @override
  final String? commentContent;
  @override
  final DateTime? commentTime;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;
  @override
  final DailyArticleResponse? article;

  factory _$UserDailyArticleResponse([
    void Function(UserDailyArticleResponseBuilder)? updates,
  ]) => (UserDailyArticleResponseBuilder()..update(updates))._build();

  _$UserDailyArticleResponse._({
    this.id,
    this.userId,
    this.articleId,
    this.read,
    this.liked,
    this.collected,
    this.commentContent,
    this.commentTime,
    this.createTime,
    this.updateTime,
    this.article,
  }) : super._();
  @override
  UserDailyArticleResponse rebuild(
    void Function(UserDailyArticleResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UserDailyArticleResponseBuilder toBuilder() =>
      UserDailyArticleResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserDailyArticleResponse &&
        id == other.id &&
        userId == other.userId &&
        articleId == other.articleId &&
        read == other.read &&
        liked == other.liked &&
        collected == other.collected &&
        commentContent == other.commentContent &&
        commentTime == other.commentTime &&
        createTime == other.createTime &&
        updateTime == other.updateTime &&
        article == other.article;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, articleId.hashCode);
    _$hash = $jc(_$hash, read.hashCode);
    _$hash = $jc(_$hash, liked.hashCode);
    _$hash = $jc(_$hash, collected.hashCode);
    _$hash = $jc(_$hash, commentContent.hashCode);
    _$hash = $jc(_$hash, commentTime.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jc(_$hash, article.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserDailyArticleResponse')
          ..add('id', id)
          ..add('userId', userId)
          ..add('articleId', articleId)
          ..add('read', read)
          ..add('liked', liked)
          ..add('collected', collected)
          ..add('commentContent', commentContent)
          ..add('commentTime', commentTime)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime)
          ..add('article', article))
        .toString();
  }
}

class UserDailyArticleResponseBuilder
    implements
        Builder<UserDailyArticleResponse, UserDailyArticleResponseBuilder> {
  _$UserDailyArticleResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  int? _articleId;
  int? get articleId => _$this._articleId;
  set articleId(int? articleId) => _$this._articleId = articleId;

  bool? _read;
  bool? get read => _$this._read;
  set read(bool? read) => _$this._read = read;

  bool? _liked;
  bool? get liked => _$this._liked;
  set liked(bool? liked) => _$this._liked = liked;

  bool? _collected;
  bool? get collected => _$this._collected;
  set collected(bool? collected) => _$this._collected = collected;

  String? _commentContent;
  String? get commentContent => _$this._commentContent;
  set commentContent(String? commentContent) =>
      _$this._commentContent = commentContent;

  DateTime? _commentTime;
  DateTime? get commentTime => _$this._commentTime;
  set commentTime(DateTime? commentTime) => _$this._commentTime = commentTime;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  DailyArticleResponseBuilder? _article;
  DailyArticleResponseBuilder get article =>
      _$this._article ??= DailyArticleResponseBuilder();
  set article(DailyArticleResponseBuilder? article) =>
      _$this._article = article;

  UserDailyArticleResponseBuilder() {
    UserDailyArticleResponse._defaults(this);
  }

  UserDailyArticleResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _articleId = $v.articleId;
      _read = $v.read;
      _liked = $v.liked;
      _collected = $v.collected;
      _commentContent = $v.commentContent;
      _commentTime = $v.commentTime;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _article = $v.article?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserDailyArticleResponse other) {
    _$v = other as _$UserDailyArticleResponse;
  }

  @override
  void update(void Function(UserDailyArticleResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserDailyArticleResponse build() => _build();

  _$UserDailyArticleResponse _build() {
    _$UserDailyArticleResponse _$result;
    try {
      _$result =
          _$v ??
          _$UserDailyArticleResponse._(
            id: id,
            userId: userId,
            articleId: articleId,
            read: read,
            liked: liked,
            collected: collected,
            commentContent: commentContent,
            commentTime: commentTime,
            createTime: createTime,
            updateTime: updateTime,
            article: _article?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'article';
        _article?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UserDailyArticleResponse',
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
