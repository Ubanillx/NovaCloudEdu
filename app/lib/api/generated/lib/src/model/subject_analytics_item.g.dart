// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_analytics_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SubjectAnalyticsItem extends SubjectAnalyticsItem {
  @override
  final String? subjectCode;
  @override
  final String? subjectName;
  @override
  final double? avgMasteryLevel;
  @override
  final int? totalKnowledgePoints;
  @override
  final int? weakPointCount;
  @override
  final int? strongPointCount;
  @override
  final int? totalAttempts;
  @override
  final double? correctRate;

  factory _$SubjectAnalyticsItem([
    void Function(SubjectAnalyticsItemBuilder)? updates,
  ]) => (SubjectAnalyticsItemBuilder()..update(updates))._build();

  _$SubjectAnalyticsItem._({
    this.subjectCode,
    this.subjectName,
    this.avgMasteryLevel,
    this.totalKnowledgePoints,
    this.weakPointCount,
    this.strongPointCount,
    this.totalAttempts,
    this.correctRate,
  }) : super._();
  @override
  SubjectAnalyticsItem rebuild(
    void Function(SubjectAnalyticsItemBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SubjectAnalyticsItemBuilder toBuilder() =>
      SubjectAnalyticsItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubjectAnalyticsItem &&
        subjectCode == other.subjectCode &&
        subjectName == other.subjectName &&
        avgMasteryLevel == other.avgMasteryLevel &&
        totalKnowledgePoints == other.totalKnowledgePoints &&
        weakPointCount == other.weakPointCount &&
        strongPointCount == other.strongPointCount &&
        totalAttempts == other.totalAttempts &&
        correctRate == other.correctRate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, subjectCode.hashCode);
    _$hash = $jc(_$hash, subjectName.hashCode);
    _$hash = $jc(_$hash, avgMasteryLevel.hashCode);
    _$hash = $jc(_$hash, totalKnowledgePoints.hashCode);
    _$hash = $jc(_$hash, weakPointCount.hashCode);
    _$hash = $jc(_$hash, strongPointCount.hashCode);
    _$hash = $jc(_$hash, totalAttempts.hashCode);
    _$hash = $jc(_$hash, correctRate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubjectAnalyticsItem')
          ..add('subjectCode', subjectCode)
          ..add('subjectName', subjectName)
          ..add('avgMasteryLevel', avgMasteryLevel)
          ..add('totalKnowledgePoints', totalKnowledgePoints)
          ..add('weakPointCount', weakPointCount)
          ..add('strongPointCount', strongPointCount)
          ..add('totalAttempts', totalAttempts)
          ..add('correctRate', correctRate))
        .toString();
  }
}

class SubjectAnalyticsItemBuilder
    implements Builder<SubjectAnalyticsItem, SubjectAnalyticsItemBuilder> {
  _$SubjectAnalyticsItem? _$v;

  String? _subjectCode;
  String? get subjectCode => _$this._subjectCode;
  set subjectCode(String? subjectCode) => _$this._subjectCode = subjectCode;

  String? _subjectName;
  String? get subjectName => _$this._subjectName;
  set subjectName(String? subjectName) => _$this._subjectName = subjectName;

  double? _avgMasteryLevel;
  double? get avgMasteryLevel => _$this._avgMasteryLevel;
  set avgMasteryLevel(double? avgMasteryLevel) =>
      _$this._avgMasteryLevel = avgMasteryLevel;

  int? _totalKnowledgePoints;
  int? get totalKnowledgePoints => _$this._totalKnowledgePoints;
  set totalKnowledgePoints(int? totalKnowledgePoints) =>
      _$this._totalKnowledgePoints = totalKnowledgePoints;

  int? _weakPointCount;
  int? get weakPointCount => _$this._weakPointCount;
  set weakPointCount(int? weakPointCount) =>
      _$this._weakPointCount = weakPointCount;

  int? _strongPointCount;
  int? get strongPointCount => _$this._strongPointCount;
  set strongPointCount(int? strongPointCount) =>
      _$this._strongPointCount = strongPointCount;

  int? _totalAttempts;
  int? get totalAttempts => _$this._totalAttempts;
  set totalAttempts(int? totalAttempts) =>
      _$this._totalAttempts = totalAttempts;

  double? _correctRate;
  double? get correctRate => _$this._correctRate;
  set correctRate(double? correctRate) => _$this._correctRate = correctRate;

  SubjectAnalyticsItemBuilder() {
    SubjectAnalyticsItem._defaults(this);
  }

  SubjectAnalyticsItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _subjectCode = $v.subjectCode;
      _subjectName = $v.subjectName;
      _avgMasteryLevel = $v.avgMasteryLevel;
      _totalKnowledgePoints = $v.totalKnowledgePoints;
      _weakPointCount = $v.weakPointCount;
      _strongPointCount = $v.strongPointCount;
      _totalAttempts = $v.totalAttempts;
      _correctRate = $v.correctRate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubjectAnalyticsItem other) {
    _$v = other as _$SubjectAnalyticsItem;
  }

  @override
  void update(void Function(SubjectAnalyticsItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubjectAnalyticsItem build() => _build();

  _$SubjectAnalyticsItem _build() {
    final _$result =
        _$v ??
        _$SubjectAnalyticsItem._(
          subjectCode: subjectCode,
          subjectName: subjectName,
          avgMasteryLevel: avgMasteryLevel,
          totalKnowledgePoints: totalKnowledgePoints,
          weakPointCount: weakPointCount,
          strongPointCount: strongPointCount,
          totalAttempts: totalAttempts,
          correctRate: correctRate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
