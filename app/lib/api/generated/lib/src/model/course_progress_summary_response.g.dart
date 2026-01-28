// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_progress_summary_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CourseProgressSummaryResponse extends CourseProgressSummaryResponse {
  @override
  final int? courseId;
  @override
  final int? totalSections;
  @override
  final int? completedSections;
  @override
  final int? overallProgress;
  @override
  final int? completionRate;

  factory _$CourseProgressSummaryResponse([
    void Function(CourseProgressSummaryResponseBuilder)? updates,
  ]) => (CourseProgressSummaryResponseBuilder()..update(updates))._build();

  _$CourseProgressSummaryResponse._({
    this.courseId,
    this.totalSections,
    this.completedSections,
    this.overallProgress,
    this.completionRate,
  }) : super._();
  @override
  CourseProgressSummaryResponse rebuild(
    void Function(CourseProgressSummaryResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CourseProgressSummaryResponseBuilder toBuilder() =>
      CourseProgressSummaryResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CourseProgressSummaryResponse &&
        courseId == other.courseId &&
        totalSections == other.totalSections &&
        completedSections == other.completedSections &&
        overallProgress == other.overallProgress &&
        completionRate == other.completionRate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, courseId.hashCode);
    _$hash = $jc(_$hash, totalSections.hashCode);
    _$hash = $jc(_$hash, completedSections.hashCode);
    _$hash = $jc(_$hash, overallProgress.hashCode);
    _$hash = $jc(_$hash, completionRate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CourseProgressSummaryResponse')
          ..add('courseId', courseId)
          ..add('totalSections', totalSections)
          ..add('completedSections', completedSections)
          ..add('overallProgress', overallProgress)
          ..add('completionRate', completionRate))
        .toString();
  }
}

class CourseProgressSummaryResponseBuilder
    implements
        Builder<
          CourseProgressSummaryResponse,
          CourseProgressSummaryResponseBuilder
        > {
  _$CourseProgressSummaryResponse? _$v;

  int? _courseId;
  int? get courseId => _$this._courseId;
  set courseId(int? courseId) => _$this._courseId = courseId;

  int? _totalSections;
  int? get totalSections => _$this._totalSections;
  set totalSections(int? totalSections) =>
      _$this._totalSections = totalSections;

  int? _completedSections;
  int? get completedSections => _$this._completedSections;
  set completedSections(int? completedSections) =>
      _$this._completedSections = completedSections;

  int? _overallProgress;
  int? get overallProgress => _$this._overallProgress;
  set overallProgress(int? overallProgress) =>
      _$this._overallProgress = overallProgress;

  int? _completionRate;
  int? get completionRate => _$this._completionRate;
  set completionRate(int? completionRate) =>
      _$this._completionRate = completionRate;

  CourseProgressSummaryResponseBuilder() {
    CourseProgressSummaryResponse._defaults(this);
  }

  CourseProgressSummaryResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _courseId = $v.courseId;
      _totalSections = $v.totalSections;
      _completedSections = $v.completedSections;
      _overallProgress = $v.overallProgress;
      _completionRate = $v.completionRate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CourseProgressSummaryResponse other) {
    _$v = other as _$CourseProgressSummaryResponse;
  }

  @override
  void update(void Function(CourseProgressSummaryResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CourseProgressSummaryResponse build() => _build();

  _$CourseProgressSummaryResponse _build() {
    final _$result =
        _$v ??
        _$CourseProgressSummaryResponse._(
          courseId: courseId,
          totalSections: totalSections,
          completedSections: completedSections,
          overallProgress: overallProgress,
          completionRate: completionRate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
