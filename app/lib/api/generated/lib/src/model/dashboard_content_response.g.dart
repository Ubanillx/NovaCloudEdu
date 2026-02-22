// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_content_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DashboardContentResponse extends DashboardContentResponse {
  @override
  final int? totalCourses;
  @override
  final int? totalCourseStudents;
  @override
  final double? avgCourseRating;
  @override
  final BuiltList<BuiltMap<String, JsonObject>>? topCourses;
  @override
  final int? totalArticles;
  @override
  final int? totalArticleViews;
  @override
  final int? totalArticleLikes;
  @override
  final BuiltList<BuiltMap<String, JsonObject>>? topArticles;
  @override
  final int? totalWords;
  @override
  final int? totalExamPapers;
  @override
  final int? totalQuestions;
  @override
  final BuiltList<BuiltMap<String, JsonObject>>? examPapersBySubject;
  @override
  final int? totalBooks;
  @override
  final int? totalPosts;
  @override
  final int? todayNewPosts;
  @override
  final int? totalPostLikes;
  @override
  final int? totalPostComments;
  @override
  final BuiltList<BuiltMap<String, JsonObject>>? topPosts;

  factory _$DashboardContentResponse([
    void Function(DashboardContentResponseBuilder)? updates,
  ]) => (DashboardContentResponseBuilder()..update(updates))._build();

  _$DashboardContentResponse._({
    this.totalCourses,
    this.totalCourseStudents,
    this.avgCourseRating,
    this.topCourses,
    this.totalArticles,
    this.totalArticleViews,
    this.totalArticleLikes,
    this.topArticles,
    this.totalWords,
    this.totalExamPapers,
    this.totalQuestions,
    this.examPapersBySubject,
    this.totalBooks,
    this.totalPosts,
    this.todayNewPosts,
    this.totalPostLikes,
    this.totalPostComments,
    this.topPosts,
  }) : super._();
  @override
  DashboardContentResponse rebuild(
    void Function(DashboardContentResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DashboardContentResponseBuilder toBuilder() =>
      DashboardContentResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardContentResponse &&
        totalCourses == other.totalCourses &&
        totalCourseStudents == other.totalCourseStudents &&
        avgCourseRating == other.avgCourseRating &&
        topCourses == other.topCourses &&
        totalArticles == other.totalArticles &&
        totalArticleViews == other.totalArticleViews &&
        totalArticleLikes == other.totalArticleLikes &&
        topArticles == other.topArticles &&
        totalWords == other.totalWords &&
        totalExamPapers == other.totalExamPapers &&
        totalQuestions == other.totalQuestions &&
        examPapersBySubject == other.examPapersBySubject &&
        totalBooks == other.totalBooks &&
        totalPosts == other.totalPosts &&
        todayNewPosts == other.todayNewPosts &&
        totalPostLikes == other.totalPostLikes &&
        totalPostComments == other.totalPostComments &&
        topPosts == other.topPosts;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalCourses.hashCode);
    _$hash = $jc(_$hash, totalCourseStudents.hashCode);
    _$hash = $jc(_$hash, avgCourseRating.hashCode);
    _$hash = $jc(_$hash, topCourses.hashCode);
    _$hash = $jc(_$hash, totalArticles.hashCode);
    _$hash = $jc(_$hash, totalArticleViews.hashCode);
    _$hash = $jc(_$hash, totalArticleLikes.hashCode);
    _$hash = $jc(_$hash, topArticles.hashCode);
    _$hash = $jc(_$hash, totalWords.hashCode);
    _$hash = $jc(_$hash, totalExamPapers.hashCode);
    _$hash = $jc(_$hash, totalQuestions.hashCode);
    _$hash = $jc(_$hash, examPapersBySubject.hashCode);
    _$hash = $jc(_$hash, totalBooks.hashCode);
    _$hash = $jc(_$hash, totalPosts.hashCode);
    _$hash = $jc(_$hash, todayNewPosts.hashCode);
    _$hash = $jc(_$hash, totalPostLikes.hashCode);
    _$hash = $jc(_$hash, totalPostComments.hashCode);
    _$hash = $jc(_$hash, topPosts.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DashboardContentResponse')
          ..add('totalCourses', totalCourses)
          ..add('totalCourseStudents', totalCourseStudents)
          ..add('avgCourseRating', avgCourseRating)
          ..add('topCourses', topCourses)
          ..add('totalArticles', totalArticles)
          ..add('totalArticleViews', totalArticleViews)
          ..add('totalArticleLikes', totalArticleLikes)
          ..add('topArticles', topArticles)
          ..add('totalWords', totalWords)
          ..add('totalExamPapers', totalExamPapers)
          ..add('totalQuestions', totalQuestions)
          ..add('examPapersBySubject', examPapersBySubject)
          ..add('totalBooks', totalBooks)
          ..add('totalPosts', totalPosts)
          ..add('todayNewPosts', todayNewPosts)
          ..add('totalPostLikes', totalPostLikes)
          ..add('totalPostComments', totalPostComments)
          ..add('topPosts', topPosts))
        .toString();
  }
}

class DashboardContentResponseBuilder
    implements
        Builder<DashboardContentResponse, DashboardContentResponseBuilder> {
  _$DashboardContentResponse? _$v;

  int? _totalCourses;
  int? get totalCourses => _$this._totalCourses;
  set totalCourses(int? totalCourses) => _$this._totalCourses = totalCourses;

  int? _totalCourseStudents;
  int? get totalCourseStudents => _$this._totalCourseStudents;
  set totalCourseStudents(int? totalCourseStudents) =>
      _$this._totalCourseStudents = totalCourseStudents;

  double? _avgCourseRating;
  double? get avgCourseRating => _$this._avgCourseRating;
  set avgCourseRating(double? avgCourseRating) =>
      _$this._avgCourseRating = avgCourseRating;

  ListBuilder<BuiltMap<String, JsonObject>>? _topCourses;
  ListBuilder<BuiltMap<String, JsonObject>> get topCourses =>
      _$this._topCourses ??= ListBuilder<BuiltMap<String, JsonObject>>();
  set topCourses(ListBuilder<BuiltMap<String, JsonObject>>? topCourses) =>
      _$this._topCourses = topCourses;

  int? _totalArticles;
  int? get totalArticles => _$this._totalArticles;
  set totalArticles(int? totalArticles) =>
      _$this._totalArticles = totalArticles;

  int? _totalArticleViews;
  int? get totalArticleViews => _$this._totalArticleViews;
  set totalArticleViews(int? totalArticleViews) =>
      _$this._totalArticleViews = totalArticleViews;

  int? _totalArticleLikes;
  int? get totalArticleLikes => _$this._totalArticleLikes;
  set totalArticleLikes(int? totalArticleLikes) =>
      _$this._totalArticleLikes = totalArticleLikes;

  ListBuilder<BuiltMap<String, JsonObject>>? _topArticles;
  ListBuilder<BuiltMap<String, JsonObject>> get topArticles =>
      _$this._topArticles ??= ListBuilder<BuiltMap<String, JsonObject>>();
  set topArticles(ListBuilder<BuiltMap<String, JsonObject>>? topArticles) =>
      _$this._topArticles = topArticles;

  int? _totalWords;
  int? get totalWords => _$this._totalWords;
  set totalWords(int? totalWords) => _$this._totalWords = totalWords;

  int? _totalExamPapers;
  int? get totalExamPapers => _$this._totalExamPapers;
  set totalExamPapers(int? totalExamPapers) =>
      _$this._totalExamPapers = totalExamPapers;

  int? _totalQuestions;
  int? get totalQuestions => _$this._totalQuestions;
  set totalQuestions(int? totalQuestions) =>
      _$this._totalQuestions = totalQuestions;

  ListBuilder<BuiltMap<String, JsonObject>>? _examPapersBySubject;
  ListBuilder<BuiltMap<String, JsonObject>> get examPapersBySubject =>
      _$this._examPapersBySubject ??=
          ListBuilder<BuiltMap<String, JsonObject>>();
  set examPapersBySubject(
    ListBuilder<BuiltMap<String, JsonObject>>? examPapersBySubject,
  ) => _$this._examPapersBySubject = examPapersBySubject;

  int? _totalBooks;
  int? get totalBooks => _$this._totalBooks;
  set totalBooks(int? totalBooks) => _$this._totalBooks = totalBooks;

  int? _totalPosts;
  int? get totalPosts => _$this._totalPosts;
  set totalPosts(int? totalPosts) => _$this._totalPosts = totalPosts;

  int? _todayNewPosts;
  int? get todayNewPosts => _$this._todayNewPosts;
  set todayNewPosts(int? todayNewPosts) =>
      _$this._todayNewPosts = todayNewPosts;

  int? _totalPostLikes;
  int? get totalPostLikes => _$this._totalPostLikes;
  set totalPostLikes(int? totalPostLikes) =>
      _$this._totalPostLikes = totalPostLikes;

  int? _totalPostComments;
  int? get totalPostComments => _$this._totalPostComments;
  set totalPostComments(int? totalPostComments) =>
      _$this._totalPostComments = totalPostComments;

  ListBuilder<BuiltMap<String, JsonObject>>? _topPosts;
  ListBuilder<BuiltMap<String, JsonObject>> get topPosts =>
      _$this._topPosts ??= ListBuilder<BuiltMap<String, JsonObject>>();
  set topPosts(ListBuilder<BuiltMap<String, JsonObject>>? topPosts) =>
      _$this._topPosts = topPosts;

  DashboardContentResponseBuilder() {
    DashboardContentResponse._defaults(this);
  }

  DashboardContentResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalCourses = $v.totalCourses;
      _totalCourseStudents = $v.totalCourseStudents;
      _avgCourseRating = $v.avgCourseRating;
      _topCourses = $v.topCourses?.toBuilder();
      _totalArticles = $v.totalArticles;
      _totalArticleViews = $v.totalArticleViews;
      _totalArticleLikes = $v.totalArticleLikes;
      _topArticles = $v.topArticles?.toBuilder();
      _totalWords = $v.totalWords;
      _totalExamPapers = $v.totalExamPapers;
      _totalQuestions = $v.totalQuestions;
      _examPapersBySubject = $v.examPapersBySubject?.toBuilder();
      _totalBooks = $v.totalBooks;
      _totalPosts = $v.totalPosts;
      _todayNewPosts = $v.todayNewPosts;
      _totalPostLikes = $v.totalPostLikes;
      _totalPostComments = $v.totalPostComments;
      _topPosts = $v.topPosts?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardContentResponse other) {
    _$v = other as _$DashboardContentResponse;
  }

  @override
  void update(void Function(DashboardContentResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DashboardContentResponse build() => _build();

  _$DashboardContentResponse _build() {
    _$DashboardContentResponse _$result;
    try {
      _$result =
          _$v ??
          _$DashboardContentResponse._(
            totalCourses: totalCourses,
            totalCourseStudents: totalCourseStudents,
            avgCourseRating: avgCourseRating,
            topCourses: _topCourses?.build(),
            totalArticles: totalArticles,
            totalArticleViews: totalArticleViews,
            totalArticleLikes: totalArticleLikes,
            topArticles: _topArticles?.build(),
            totalWords: totalWords,
            totalExamPapers: totalExamPapers,
            totalQuestions: totalQuestions,
            examPapersBySubject: _examPapersBySubject?.build(),
            totalBooks: totalBooks,
            totalPosts: totalPosts,
            todayNewPosts: todayNewPosts,
            totalPostLikes: totalPostLikes,
            totalPostComments: totalPostComments,
            topPosts: _topPosts?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'topCourses';
        _topCourses?.build();

        _$failedField = 'topArticles';
        _topArticles?.build();

        _$failedField = 'examPapersBySubject';
        _examPapersBySubject?.build();

        _$failedField = 'topPosts';
        _topPosts?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DashboardContentResponse',
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
