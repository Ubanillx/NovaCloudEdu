// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_analytics_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StudentAnalyticsResponse extends StudentAnalyticsResponse {
  @override
  final int? totalDurationSec;
  @override
  final String? totalDurationText;
  @override
  final int? courseWatchCount;
  @override
  final int? wordStudyCount;
  @override
  final int? articleReadCount;
  @override
  final int? homeworkSubmitCount;
  @override
  final int? checkinCount;
  @override
  final int? totalCheckinDays;
  @override
  final int? currentStreak;
  @override
  final BuiltMap<String, double>? subjectMastery;
  @override
  final int? weakPointCount;
  @override
  final int? totalKnowledgePoints;

  factory _$StudentAnalyticsResponse([
    void Function(StudentAnalyticsResponseBuilder)? updates,
  ]) => (StudentAnalyticsResponseBuilder()..update(updates))._build();

  _$StudentAnalyticsResponse._({
    this.totalDurationSec,
    this.totalDurationText,
    this.courseWatchCount,
    this.wordStudyCount,
    this.articleReadCount,
    this.homeworkSubmitCount,
    this.checkinCount,
    this.totalCheckinDays,
    this.currentStreak,
    this.subjectMastery,
    this.weakPointCount,
    this.totalKnowledgePoints,
  }) : super._();
  @override
  StudentAnalyticsResponse rebuild(
    void Function(StudentAnalyticsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StudentAnalyticsResponseBuilder toBuilder() =>
      StudentAnalyticsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StudentAnalyticsResponse &&
        totalDurationSec == other.totalDurationSec &&
        totalDurationText == other.totalDurationText &&
        courseWatchCount == other.courseWatchCount &&
        wordStudyCount == other.wordStudyCount &&
        articleReadCount == other.articleReadCount &&
        homeworkSubmitCount == other.homeworkSubmitCount &&
        checkinCount == other.checkinCount &&
        totalCheckinDays == other.totalCheckinDays &&
        currentStreak == other.currentStreak &&
        subjectMastery == other.subjectMastery &&
        weakPointCount == other.weakPointCount &&
        totalKnowledgePoints == other.totalKnowledgePoints;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalDurationSec.hashCode);
    _$hash = $jc(_$hash, totalDurationText.hashCode);
    _$hash = $jc(_$hash, courseWatchCount.hashCode);
    _$hash = $jc(_$hash, wordStudyCount.hashCode);
    _$hash = $jc(_$hash, articleReadCount.hashCode);
    _$hash = $jc(_$hash, homeworkSubmitCount.hashCode);
    _$hash = $jc(_$hash, checkinCount.hashCode);
    _$hash = $jc(_$hash, totalCheckinDays.hashCode);
    _$hash = $jc(_$hash, currentStreak.hashCode);
    _$hash = $jc(_$hash, subjectMastery.hashCode);
    _$hash = $jc(_$hash, weakPointCount.hashCode);
    _$hash = $jc(_$hash, totalKnowledgePoints.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StudentAnalyticsResponse')
          ..add('totalDurationSec', totalDurationSec)
          ..add('totalDurationText', totalDurationText)
          ..add('courseWatchCount', courseWatchCount)
          ..add('wordStudyCount', wordStudyCount)
          ..add('articleReadCount', articleReadCount)
          ..add('homeworkSubmitCount', homeworkSubmitCount)
          ..add('checkinCount', checkinCount)
          ..add('totalCheckinDays', totalCheckinDays)
          ..add('currentStreak', currentStreak)
          ..add('subjectMastery', subjectMastery)
          ..add('weakPointCount', weakPointCount)
          ..add('totalKnowledgePoints', totalKnowledgePoints))
        .toString();
  }
}

class StudentAnalyticsResponseBuilder
    implements
        Builder<StudentAnalyticsResponse, StudentAnalyticsResponseBuilder> {
  _$StudentAnalyticsResponse? _$v;

  int? _totalDurationSec;
  int? get totalDurationSec => _$this._totalDurationSec;
  set totalDurationSec(int? totalDurationSec) =>
      _$this._totalDurationSec = totalDurationSec;

  String? _totalDurationText;
  String? get totalDurationText => _$this._totalDurationText;
  set totalDurationText(String? totalDurationText) =>
      _$this._totalDurationText = totalDurationText;

  int? _courseWatchCount;
  int? get courseWatchCount => _$this._courseWatchCount;
  set courseWatchCount(int? courseWatchCount) =>
      _$this._courseWatchCount = courseWatchCount;

  int? _wordStudyCount;
  int? get wordStudyCount => _$this._wordStudyCount;
  set wordStudyCount(int? wordStudyCount) =>
      _$this._wordStudyCount = wordStudyCount;

  int? _articleReadCount;
  int? get articleReadCount => _$this._articleReadCount;
  set articleReadCount(int? articleReadCount) =>
      _$this._articleReadCount = articleReadCount;

  int? _homeworkSubmitCount;
  int? get homeworkSubmitCount => _$this._homeworkSubmitCount;
  set homeworkSubmitCount(int? homeworkSubmitCount) =>
      _$this._homeworkSubmitCount = homeworkSubmitCount;

  int? _checkinCount;
  int? get checkinCount => _$this._checkinCount;
  set checkinCount(int? checkinCount) => _$this._checkinCount = checkinCount;

  int? _totalCheckinDays;
  int? get totalCheckinDays => _$this._totalCheckinDays;
  set totalCheckinDays(int? totalCheckinDays) =>
      _$this._totalCheckinDays = totalCheckinDays;

  int? _currentStreak;
  int? get currentStreak => _$this._currentStreak;
  set currentStreak(int? currentStreak) =>
      _$this._currentStreak = currentStreak;

  MapBuilder<String, double>? _subjectMastery;
  MapBuilder<String, double> get subjectMastery =>
      _$this._subjectMastery ??= MapBuilder<String, double>();
  set subjectMastery(MapBuilder<String, double>? subjectMastery) =>
      _$this._subjectMastery = subjectMastery;

  int? _weakPointCount;
  int? get weakPointCount => _$this._weakPointCount;
  set weakPointCount(int? weakPointCount) =>
      _$this._weakPointCount = weakPointCount;

  int? _totalKnowledgePoints;
  int? get totalKnowledgePoints => _$this._totalKnowledgePoints;
  set totalKnowledgePoints(int? totalKnowledgePoints) =>
      _$this._totalKnowledgePoints = totalKnowledgePoints;

  StudentAnalyticsResponseBuilder() {
    StudentAnalyticsResponse._defaults(this);
  }

  StudentAnalyticsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalDurationSec = $v.totalDurationSec;
      _totalDurationText = $v.totalDurationText;
      _courseWatchCount = $v.courseWatchCount;
      _wordStudyCount = $v.wordStudyCount;
      _articleReadCount = $v.articleReadCount;
      _homeworkSubmitCount = $v.homeworkSubmitCount;
      _checkinCount = $v.checkinCount;
      _totalCheckinDays = $v.totalCheckinDays;
      _currentStreak = $v.currentStreak;
      _subjectMastery = $v.subjectMastery?.toBuilder();
      _weakPointCount = $v.weakPointCount;
      _totalKnowledgePoints = $v.totalKnowledgePoints;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StudentAnalyticsResponse other) {
    _$v = other as _$StudentAnalyticsResponse;
  }

  @override
  void update(void Function(StudentAnalyticsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StudentAnalyticsResponse build() => _build();

  _$StudentAnalyticsResponse _build() {
    _$StudentAnalyticsResponse _$result;
    try {
      _$result =
          _$v ??
          _$StudentAnalyticsResponse._(
            totalDurationSec: totalDurationSec,
            totalDurationText: totalDurationText,
            courseWatchCount: courseWatchCount,
            wordStudyCount: wordStudyCount,
            articleReadCount: articleReadCount,
            homeworkSubmitCount: homeworkSubmitCount,
            checkinCount: checkinCount,
            totalCheckinDays: totalCheckinDays,
            currentStreak: currentStreak,
            subjectMastery: _subjectMastery?.build(),
            weakPointCount: weakPointCount,
            totalKnowledgePoints: totalKnowledgePoints,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'subjectMastery';
        _subjectMastery?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'StudentAnalyticsResponse',
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
