// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_analytics_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ClassAnalyticsResponse extends ClassAnalyticsResponse {
  @override
  final int? memberCount;
  @override
  final int? totalDurationSec;
  @override
  final String? totalDurationText;
  @override
  final int? avgDurationSecPerMember;
  @override
  final String? avgDurationText;
  @override
  final int? totalActivities;
  @override
  final BuiltMap<String, int>? activityTypeCounts;
  @override
  final double? avgScoreRate;

  factory _$ClassAnalyticsResponse([
    void Function(ClassAnalyticsResponseBuilder)? updates,
  ]) => (ClassAnalyticsResponseBuilder()..update(updates))._build();

  _$ClassAnalyticsResponse._({
    this.memberCount,
    this.totalDurationSec,
    this.totalDurationText,
    this.avgDurationSecPerMember,
    this.avgDurationText,
    this.totalActivities,
    this.activityTypeCounts,
    this.avgScoreRate,
  }) : super._();
  @override
  ClassAnalyticsResponse rebuild(
    void Function(ClassAnalyticsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ClassAnalyticsResponseBuilder toBuilder() =>
      ClassAnalyticsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClassAnalyticsResponse &&
        memberCount == other.memberCount &&
        totalDurationSec == other.totalDurationSec &&
        totalDurationText == other.totalDurationText &&
        avgDurationSecPerMember == other.avgDurationSecPerMember &&
        avgDurationText == other.avgDurationText &&
        totalActivities == other.totalActivities &&
        activityTypeCounts == other.activityTypeCounts &&
        avgScoreRate == other.avgScoreRate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, memberCount.hashCode);
    _$hash = $jc(_$hash, totalDurationSec.hashCode);
    _$hash = $jc(_$hash, totalDurationText.hashCode);
    _$hash = $jc(_$hash, avgDurationSecPerMember.hashCode);
    _$hash = $jc(_$hash, avgDurationText.hashCode);
    _$hash = $jc(_$hash, totalActivities.hashCode);
    _$hash = $jc(_$hash, activityTypeCounts.hashCode);
    _$hash = $jc(_$hash, avgScoreRate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ClassAnalyticsResponse')
          ..add('memberCount', memberCount)
          ..add('totalDurationSec', totalDurationSec)
          ..add('totalDurationText', totalDurationText)
          ..add('avgDurationSecPerMember', avgDurationSecPerMember)
          ..add('avgDurationText', avgDurationText)
          ..add('totalActivities', totalActivities)
          ..add('activityTypeCounts', activityTypeCounts)
          ..add('avgScoreRate', avgScoreRate))
        .toString();
  }
}

class ClassAnalyticsResponseBuilder
    implements Builder<ClassAnalyticsResponse, ClassAnalyticsResponseBuilder> {
  _$ClassAnalyticsResponse? _$v;

  int? _memberCount;
  int? get memberCount => _$this._memberCount;
  set memberCount(int? memberCount) => _$this._memberCount = memberCount;

  int? _totalDurationSec;
  int? get totalDurationSec => _$this._totalDurationSec;
  set totalDurationSec(int? totalDurationSec) =>
      _$this._totalDurationSec = totalDurationSec;

  String? _totalDurationText;
  String? get totalDurationText => _$this._totalDurationText;
  set totalDurationText(String? totalDurationText) =>
      _$this._totalDurationText = totalDurationText;

  int? _avgDurationSecPerMember;
  int? get avgDurationSecPerMember => _$this._avgDurationSecPerMember;
  set avgDurationSecPerMember(int? avgDurationSecPerMember) =>
      _$this._avgDurationSecPerMember = avgDurationSecPerMember;

  String? _avgDurationText;
  String? get avgDurationText => _$this._avgDurationText;
  set avgDurationText(String? avgDurationText) =>
      _$this._avgDurationText = avgDurationText;

  int? _totalActivities;
  int? get totalActivities => _$this._totalActivities;
  set totalActivities(int? totalActivities) =>
      _$this._totalActivities = totalActivities;

  MapBuilder<String, int>? _activityTypeCounts;
  MapBuilder<String, int> get activityTypeCounts =>
      _$this._activityTypeCounts ??= MapBuilder<String, int>();
  set activityTypeCounts(MapBuilder<String, int>? activityTypeCounts) =>
      _$this._activityTypeCounts = activityTypeCounts;

  double? _avgScoreRate;
  double? get avgScoreRate => _$this._avgScoreRate;
  set avgScoreRate(double? avgScoreRate) => _$this._avgScoreRate = avgScoreRate;

  ClassAnalyticsResponseBuilder() {
    ClassAnalyticsResponse._defaults(this);
  }

  ClassAnalyticsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _memberCount = $v.memberCount;
      _totalDurationSec = $v.totalDurationSec;
      _totalDurationText = $v.totalDurationText;
      _avgDurationSecPerMember = $v.avgDurationSecPerMember;
      _avgDurationText = $v.avgDurationText;
      _totalActivities = $v.totalActivities;
      _activityTypeCounts = $v.activityTypeCounts?.toBuilder();
      _avgScoreRate = $v.avgScoreRate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClassAnalyticsResponse other) {
    _$v = other as _$ClassAnalyticsResponse;
  }

  @override
  void update(void Function(ClassAnalyticsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ClassAnalyticsResponse build() => _build();

  _$ClassAnalyticsResponse _build() {
    _$ClassAnalyticsResponse _$result;
    try {
      _$result =
          _$v ??
          _$ClassAnalyticsResponse._(
            memberCount: memberCount,
            totalDurationSec: totalDurationSec,
            totalDurationText: totalDurationText,
            avgDurationSecPerMember: avgDurationSecPerMember,
            avgDurationText: avgDurationText,
            totalActivities: totalActivities,
            activityTypeCounts: _activityTypeCounts?.build(),
            avgScoreRate: avgScoreRate,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'activityTypeCounts';
        _activityTypeCounts?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ClassAnalyticsResponse',
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
