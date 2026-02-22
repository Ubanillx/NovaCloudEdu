// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_profile_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SubjectProfileSummary extends SubjectProfileSummary {
  @override
  final String? subject;
  @override
  final String? subjectName;
  @override
  final double? avgMasteryLevel;
  @override
  final int? totalPoints;
  @override
  final int? weakPointCount;
  @override
  final int? strongPointCount;
  @override
  final BuiltList<KnowledgeProfileResponse>? weakPoints;
  @override
  final BuiltList<KnowledgeProfileResponse>? strongPoints;

  factory _$SubjectProfileSummary([
    void Function(SubjectProfileSummaryBuilder)? updates,
  ]) => (SubjectProfileSummaryBuilder()..update(updates))._build();

  _$SubjectProfileSummary._({
    this.subject,
    this.subjectName,
    this.avgMasteryLevel,
    this.totalPoints,
    this.weakPointCount,
    this.strongPointCount,
    this.weakPoints,
    this.strongPoints,
  }) : super._();
  @override
  SubjectProfileSummary rebuild(
    void Function(SubjectProfileSummaryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SubjectProfileSummaryBuilder toBuilder() =>
      SubjectProfileSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubjectProfileSummary &&
        subject == other.subject &&
        subjectName == other.subjectName &&
        avgMasteryLevel == other.avgMasteryLevel &&
        totalPoints == other.totalPoints &&
        weakPointCount == other.weakPointCount &&
        strongPointCount == other.strongPointCount &&
        weakPoints == other.weakPoints &&
        strongPoints == other.strongPoints;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, subjectName.hashCode);
    _$hash = $jc(_$hash, avgMasteryLevel.hashCode);
    _$hash = $jc(_$hash, totalPoints.hashCode);
    _$hash = $jc(_$hash, weakPointCount.hashCode);
    _$hash = $jc(_$hash, strongPointCount.hashCode);
    _$hash = $jc(_$hash, weakPoints.hashCode);
    _$hash = $jc(_$hash, strongPoints.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubjectProfileSummary')
          ..add('subject', subject)
          ..add('subjectName', subjectName)
          ..add('avgMasteryLevel', avgMasteryLevel)
          ..add('totalPoints', totalPoints)
          ..add('weakPointCount', weakPointCount)
          ..add('strongPointCount', strongPointCount)
          ..add('weakPoints', weakPoints)
          ..add('strongPoints', strongPoints))
        .toString();
  }
}

class SubjectProfileSummaryBuilder
    implements Builder<SubjectProfileSummary, SubjectProfileSummaryBuilder> {
  _$SubjectProfileSummary? _$v;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  String? _subjectName;
  String? get subjectName => _$this._subjectName;
  set subjectName(String? subjectName) => _$this._subjectName = subjectName;

  double? _avgMasteryLevel;
  double? get avgMasteryLevel => _$this._avgMasteryLevel;
  set avgMasteryLevel(double? avgMasteryLevel) =>
      _$this._avgMasteryLevel = avgMasteryLevel;

  int? _totalPoints;
  int? get totalPoints => _$this._totalPoints;
  set totalPoints(int? totalPoints) => _$this._totalPoints = totalPoints;

  int? _weakPointCount;
  int? get weakPointCount => _$this._weakPointCount;
  set weakPointCount(int? weakPointCount) =>
      _$this._weakPointCount = weakPointCount;

  int? _strongPointCount;
  int? get strongPointCount => _$this._strongPointCount;
  set strongPointCount(int? strongPointCount) =>
      _$this._strongPointCount = strongPointCount;

  ListBuilder<KnowledgeProfileResponse>? _weakPoints;
  ListBuilder<KnowledgeProfileResponse> get weakPoints =>
      _$this._weakPoints ??= ListBuilder<KnowledgeProfileResponse>();
  set weakPoints(ListBuilder<KnowledgeProfileResponse>? weakPoints) =>
      _$this._weakPoints = weakPoints;

  ListBuilder<KnowledgeProfileResponse>? _strongPoints;
  ListBuilder<KnowledgeProfileResponse> get strongPoints =>
      _$this._strongPoints ??= ListBuilder<KnowledgeProfileResponse>();
  set strongPoints(ListBuilder<KnowledgeProfileResponse>? strongPoints) =>
      _$this._strongPoints = strongPoints;

  SubjectProfileSummaryBuilder() {
    SubjectProfileSummary._defaults(this);
  }

  SubjectProfileSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _subject = $v.subject;
      _subjectName = $v.subjectName;
      _avgMasteryLevel = $v.avgMasteryLevel;
      _totalPoints = $v.totalPoints;
      _weakPointCount = $v.weakPointCount;
      _strongPointCount = $v.strongPointCount;
      _weakPoints = $v.weakPoints?.toBuilder();
      _strongPoints = $v.strongPoints?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubjectProfileSummary other) {
    _$v = other as _$SubjectProfileSummary;
  }

  @override
  void update(void Function(SubjectProfileSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubjectProfileSummary build() => _build();

  _$SubjectProfileSummary _build() {
    _$SubjectProfileSummary _$result;
    try {
      _$result =
          _$v ??
          _$SubjectProfileSummary._(
            subject: subject,
            subjectName: subjectName,
            avgMasteryLevel: avgMasteryLevel,
            totalPoints: totalPoints,
            weakPointCount: weakPointCount,
            strongPointCount: strongPointCount,
            weakPoints: _weakPoints?.build(),
            strongPoints: _strongPoints?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'weakPoints';
        _weakPoints?.build();
        _$failedField = 'strongPoints';
        _strongPoints?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SubjectProfileSummary',
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
